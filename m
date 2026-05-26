Return-Path: <netdev+bounces-291913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAtgFUL2FWqzfwcAu9opvQ
	(envelope-from <netdev+bounces-291913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AD5DC0BE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6C93014BE7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AB3A872C;
	Tue, 26 May 2026 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="covj1rD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34817377009;
	Tue, 26 May 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824186; cv=none; b=jUKIm8czI19/7GqiSkVf7Rig3g6cgqbCYgAmm2i280x30P6VQYuK4BlKehXJSfXfEDEyGSSLiINGFwARPzpwwdDVD06mUTqR5HiKvNbk/dfKLw5mzpxNNJ6Pf6x+2aIFu4C/vfu5z0eUg4GrUWF1oza3Kx5x6EqKFsfKofTb2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824186; c=relaxed/simple;
	bh=UvKTJ9IuxiWon6lZcZAgjd8GDTaliJRts/5/4wx02SQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f+/SQ64F8SiICU5/E+Et5NzX7zRIXtOBX+SA6b2zUv3N7Ea7UC41VowE4KMU7ZNmJsYyHMQGkZYjaUMT6k3nc231Q0sDkYmavTAt3q2EHqOXxSEl5Q0+WwYN4FJrAXtVug6zJFUR5m5WLmXTA2qJyTLqzRNJuOuvmORY9e8lT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=covj1rD9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D94CA4B6F;
	Tue, 26 May 2026 21:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779824182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FIsguaqLNZxyz4WUt9a4bb97qm80/A2ahltxZ1mLKOA=;
	b=covj1rD9GR1X8WK5A+bMiM1jtOLj41YaqHGzVac+cWrfkKefKTAq6aVXz3cyEwDHFEIX/R
	xvIphaJBA2K90zduUqPL0z3nyvxK7ZfVskBU8gnPkxXfq5C3fA4TxiZZny0CkQ5+Puwnbq
	VZvMxII50RrVN/exXmU5lwJ61x6M0zDDs1M75F0LORTJrvWaj4Yg4qqGe31b5A6rR3QYEy
	GnWj140nzrHV4IYS+9tk7u10K1KhHtaZWrK/lYdYd7t5/4AYQcuQbGPrCM6B5TNYj+YiyI
	awyOJTm41mPUvS4A/Q6e6/Isl5kIZj/ex8jHfE6QyrP38wxxQDJB7vg5OrHwLw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:36:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 tariqt@nvidia.com, dtatulea@nvidia.com, linux-doc@vger.kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 4/4] net: make page_pool_get_stats() void
In-Reply-To: <20260526155722.2790742-5-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
 <20260526155722.2790742-5-kuba@kernel.org>
Message-ID: <8867c95fc2c88a4074526f31dfb583b9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-291913-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Queue-Id: AA4AD5DC0BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26.5.2026 17:57, Jakub Kicinski wrote:
> The kdoc for page_pool_get_stats() is missing a Returns: statement.
> Looking at this function, I have no idea what is the purpose of
> the bool it returns. My guess was that maybe the static inline
> stub returns false if CONFIG_PAGE_POOL_STATS=n but such static
> inline helper doesn't exist at all. All callers pass a pointer
> to a struct on the stack. Make this function void.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

