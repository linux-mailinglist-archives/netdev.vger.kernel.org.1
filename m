Return-Path: <netdev+bounces-291908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPqjHq/zFWqzfwcAu9opvQ
	(envelope-from <netdev+bounces-291908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3655DBF6A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180B4303AF86
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8F3C0621;
	Tue, 26 May 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="I+q/8a5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B805352C52;
	Tue, 26 May 2026 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823528; cv=none; b=Hvfbk/H17ow4G5GBHYRFqverQPaHwwlBDH7EJ1zBwmbPvBmO4d+ZEO64TOC4LtRMWvlgxPCoHT2FTZDKyzgztxDK+cFWr2jwvH6vbuEj7IsLC3MvpxZJChAEkLd1SZAQvRzpcxKhSHiuBOwRsszyC+rIFaa1KGvT7ofO0y7rEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823528; c=relaxed/simple;
	bh=W4LIlDQOM+MhDJlLpJo59skrrnE14/No7Tn7xOpv7JQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u7+Sc6e3haUvPkxq79DojBvA/Kgk4zSq0pYorc9mKVqwf3MFp+pYVtYYK1JRtNppC8JW7FXvBHqkiw4wZUHjmfG15Qps6Si3BnjnzCdKf7dOACoL2fv9wrr8Yqydpu4+xe08TmW+BE/VXq4nM7FaDlbtGKyegEUKthP4p9dlS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=I+q/8a5j; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE260A4B73;
	Tue, 26 May 2026 21:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779823524; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AzVsY1iGJmoJBD2ByM8HX35fkw5gcS3qmwSaMiT/Jsk=;
	b=I+q/8a5j3BEOT5wS5T4V+6KYivD4+SAjVBFwYaOUzoMAu0LpWId4L5n08/G3jue3wMYmx1
	BVizIqmx4LAbqIcwe8oc16ymPArGTP74eZYnXgiVaGKrcowxCtjF+3LqK7WggjvBNMNbIc
	mowrAI6b30ggbhlnmlbT2kk8LxRWOHsosb4AhvKd1fHZX3RzV41UvMrx5eATXfoQOr7XyI
	mcP3450HnlBCGnRFvWFcTGHPfBB6M7kQWOX7d14SAZlzsNyd1UJi/TYbuNRRgYiwHtlhbj
	cm+WwbLX9aCl+/Vq/l9+mh6/qqZ54h3N3No2h1U7Sa1w8y8FnIGptZmMCEDLsQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:25:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 tariqt@nvidia.com, dtatulea@nvidia.com, linux-doc@vger.kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 3/4] docs: page_pool: drop the mention of the
 legacy stats API
In-Reply-To: <20260526155722.2790742-4-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
 <20260526155722.2790742-4-kuba@kernel.org>
Message-ID: <0ba941849c110930ffa4fecc4f257703@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-291908-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E3655DBF6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26.5.2026 17:57, Jakub Kicinski wrote:
> The Netlink support for querying page pool stats has been
> proven out in production, let's remove the mention of the
> helper meant for dumping page pool stats into ethtool -S
> from the docs.
> 
> Call out in the kdoc that this API is deprecated.
> Some drivers may not be able to use the Netlink API
> (if page pool is shared across netdevs). So the old API
> is not _completely_ dead. But we shouldn't advertise it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

