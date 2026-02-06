Return-Path: <netdev+bounces-257622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCxVKjkfhmnQJwQAu9opvQ
	(envelope-from <netdev+bounces-257622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:04:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1B100B66
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9BB301C89F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9AE36164C;
	Fri,  6 Feb 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wqvpcAov"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92135F8D9
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397481; cv=none; b=IshrmceWfXbd1CU74ALGPBgO6S/DuZtMwqkkVpBiHH+QyviNNaplUb8thkaVeJHcCTHEbq94DhvfqyVbZihuNskMMSvKzNV7IZWjgC/eh4ja4jGlPl1wUpca03kK66NjJEarXRj0Ua3flQ6X3yJHrX8d/R8Lmuv02DlYzA6TOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397481; c=relaxed/simple;
	bh=pdin6yzjwhqVn8fEZZeYMgdeq9Bs1pDDjAPioJ7C3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oif9lK3es+14AFSA3oQCtj59sDDZfCVAdoubkxVqfVFuH+x5jkm8yxv1Y8lfHSlJsjoiejy5PNwNv/irlZcEUPHUdIW+h/UaL0hBpSohWOZAXn+rMYUIivFf/Z+22fg/DtMEdNqHNiiRRsUkCEev5AZZRGE7F98weWhFPKeGU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wqvpcAov; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 425EA1A2C51
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:04:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D3C560729;
	Fri,  6 Feb 2026 17:04:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE181119D1EB8;
	Fri,  6 Feb 2026 18:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770397477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0ic2/LjykCaTthFBVUsww+vffQZo2P/OkjGVl7Arbmg=;
	b=wqvpcAovzM29NuqLwGqnbh9bhUoIodIBC+DNjpdc4IvEG+BGipa7PYxl6zfRq6CN27XA4f
	//YQCMAyHsktyAm/rO/BEjAFIerEFEnsrnLqbQy3mB2ifaiO9PdU8qGxePSEQYY/CSo9BB
	4upDeo7nPesZHZdVun3BRwQJHWJJDvd2vPwQUhVGG3Rm319U/OZtuIhR5Bcs1hEthaOWe1
	ps6BWgCcDYZUysjf19+zPDB59sJ/wsLNSKVesehOqTi8/NgzRcOKA1hwGZjhYUr1leoFc3
	tcSD7G+u1A0jCpTnBosqXqW7TrwRNqWBRB9IlF8bt8InoP90GtUfKZ4GFuEHHg==
Message-ID: <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
Date: Fri, 6 Feb 2026 18:04:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: ethtool: Introduce per-PHY DUMP operations
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <aYXu0esD_wSjGTZm@stanley.mountain>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aYXu0esD_wSjGTZm@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16B1B100B66
X-Rspamd-Action: no action

Hi Dan,

On 06/02/2026 14:38, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Maxime Chevallier,
> 
> Commit 172265b44cd3 ("net: ethtool: Introduce per-PHY DUMP
> operations") from May 2, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	net/ethtool/netlink.c:714 ethnl_perphy_start()
> 	error: buffer overflow 'ethnl_default_requests' 52 <= 255 user_rl='0-255' uncapped
> 
> net/ethtool/netlink.c
>     700 static int ethnl_perphy_start(struct netlink_callback *cb)
>     701 {
>     702         struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
>     703         const struct genl_dumpit_info *info = genl_dumpit_info(cb);
>     704         struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
>     705         struct ethnl_reply_data *reply_data;
>     706         const struct ethnl_request_ops *ops;
>     707         struct ethnl_req_info *req_info;
>     708         struct genlmsghdr *ghdr;
>     709         int ret;
>     710 
>     711         BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
>     712 
>     713         ghdr = nlmsg_data(cb->nlh);
> --> 714         ops = ethnl_default_requests[ghdr->cmd];
> 
> Smatch thinks nlmsg_data() is untrusted data, so it could be out of bounds.
> It's a u8, but there are only 52 elements in the ethnl_default_requests[]
> array.

I see, then we also have the same problem in ethnl_default_start().

I'd expect the genl part to validate cmd (I haven't checked yet), but we
do have a WARN_ONCE just below for the case 'cmd' is wrong, so we could
definitely add some more sanity checks before accessing
ethnl_default_requests[].

I'll look further into that and send the relevant fixes :)

Thanks for the report,

Maxime



