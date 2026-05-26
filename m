Return-Path: <netdev+bounces-291905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HC7LyH0FWpCgAcAu9opvQ
	(envelope-from <netdev+bounces-291905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:27:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 366985DBF9B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0236D3059E18
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F13B47E9;
	Tue, 26 May 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LMnihLru"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224253C0633;
	Tue, 26 May 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823348; cv=none; b=IMsXbcKXmkrgDAv3SZ9ywaHG8TTk65pwpf2ZVRoFJrH/yl3CZb2Tw67xYHF/L0h1mcHfiniBfxgB8yl+pw1Rg1EjHs8wFldlNMJNIYPbGP6jD+HCf4c/sGIjg5nsUYm16Jh5b67JJwHQ+TylFlSUMCKPol8oIRLrHSm6XK20shM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823348; c=relaxed/simple;
	bh=2IqGpm/obDxNgn0x78Z4cjkdInTkjoo6bStjCvwL2sc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KZYiXMgo6M6pR6cuqwCX3TZ6CZ/A0d9M+QvtENSQiL241v2Bw1P5o2/hrYbzpzucUP944/p4u/TWunrkDXn+h8ZqXO14MT1dkDUbuhiI0dmn1LLnZ1ZFMt6LnHzEn+gDObv5oWlc0YVIZf+4ajTzHlEk87tABwGK7BgUgNBZ9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LMnihLru; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54B33A0025;
	Tue, 26 May 2026 21:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779823342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WA9U5/aga7HNi12SnNFYa5cfnfKbHcoSgoN8mlKqLNo=;
	b=LMnihLruJQl1BYv6fnnSJZFI/3CEseYNziDHFDmxQtJiYmjnUq+Coqyo09mS9vnqlb+Dkz
	C91G2UVMXqWRlioVir56+T0VPvkXLDv/K377iCtzpzvPYsWXF36PXaIIV+dWRzYzYxDqrK
	vOex3zzRScfB7TcbRbHguAwFNolHWdbX1mdC8pK7JehjnlXcC6yL7gthGcr0AbO5g6b1ZY
	v+E7V1wcg2xV8cCmkWT/7P6dXbGxRii8tumoOfzL1FsaqGkoMgqmesme3lVINnAbiQNouF
	XLTbzhrhPqHTFXdCbJFGRK1rwdgw/NEqH5C+h0WxIJ53bjuKp/L3UkZNOJcttQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:22:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 tariqt@nvidia.com, dtatulea@nvidia.com, linux-doc@vger.kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 2/4] docs: clarify page pool NAPI consumer
 requirement
In-Reply-To: <20260526155722.2790742-3-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
 <20260526155722.2790742-3-kuba@kernel.org>
Message-ID: <c04f87ca8b70baf7a0fa6b8f03a6a476@tipi-net.de>
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
	TAGGED_FROM(0.00)[bounces-291905-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 366985DBF9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26.5.2026 17:57, Jakub Kicinski wrote:
> The comment about requirements when to set the NAPI pointer
> may not be super clear. Add more words.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

