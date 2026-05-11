Return-Path: <netdev+bounces-286652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO9kJs/bAWqblgEAu9opvQ
	(envelope-from <netdev+bounces-286652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE1450F155
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71D5730531EC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D843E6389;
	Mon, 11 May 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hkTBD8fU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkwZgMqy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116536B046;
	Mon, 11 May 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506381; cv=none; b=kXckhGEDu3wllKonIrdcvqLAAMOITT+Td+ch9JJnpxQ8eIGWk8P2enUYYVVU05yJr3sR9qPkWuQXkqL4qn2O8KzqccHDwUlK5q2kt3cGLPEKE3TtTacgD47zATRwYykUfS3JRSZVoDN+lyWoWjvqW3/TxHawXh5bOzduAq438cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506381; c=relaxed/simple;
	bh=SDbkzvThp5xbvCsnLzMqTTB9JGOV6FL1PM7AF+RtQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDIJIc1uEas2WDYG9jTnhnVEpISO9CQt1g11yl/0Bq5daHsb0XI1F5/cJQWa5fDGEET0CzXbz72z+A5T+/1R3oxMM0/alJDLeJg5qMrlp7lWjfjiSBMircQi1iUNk+Fpn63SRTAkUnNGtaf4HOouZcL7AvPbMwCB7nzJtxYVP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hkTBD8fU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkwZgMqy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39E6A1400111;
	Mon, 11 May 2026 09:32:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 09:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778506377; x=
	1778592777; bh=6Ov3BOehjlIiJZT1Ja+2MCIn8RZG+zCisKhvpCkeJvU=; b=h
	kTBD8fUV4XsoXqgakh0svjye6wHf+5rwA1WnWhYC381BpTCNIAdFZ+f2tv3viPcy
	WwtQFtXBjsEgNgiyfE7N6DMikPyC0MO46VkWKT3l42KlTA4NAHjcWcXIo9Kq3RBl
	I8JZxkQ7tVs/OI57vWae/swuTYOP1ZEqvvtoIcItTqvY7+AOO7op/lPZ26i+KHGZ
	gTFZzUxgMvWlG7LElJMJ5ra5suIZ7IGUASX21aiXBvN7gDO/O5pR3Cn/xKEvMFq9
	NKgl+IQo2Oz6ZUs1sch48LC8ZEYHD8QSU6P6eQ4BDUnaR2qXk2RN34rimt4QqzPP
	J992JKhTaVORLYGDIUz2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778506377; x=1778592777; bh=6Ov3BOehjlIiJZT1Ja+2MCIn8RZG+zCisKh
	vpCkeJvU=; b=XkwZgMqyWJv/ZnvgSdwwAV2PANiZtZhxT/NcBaAKHQ/rdt1tSI5
	/pjfQ36NDUscOMNf6YyY6DW2u6z1Mh111W7AzVEZQOGL3+TWKz1OyqQBszZUXxeq
	7u79Y30PQzj3nkF60CU0uZr/jl5U47cgdysZRdNJkUZn9G41WRZVw9NeUFJgOftz
	GDLD8nNoPX5DmTRx4rWUJSkj4ZxA9juoritVmw6+in9EiwS/G+awNixzhKFWh8Pb
	mPwtEgjNWoupW9xOgmtKP7bmlQC36BfGiKVWFLslNbHHpnVFTb3eXtyHM3OEtOBT
	UwQ7hD1jjgC0MiPzOfLb1tko0Y/1ho5W5sw==
X-ME-Sender: <xms:h9oBapz9rPZCTIz6c7lBISkdHu_6fVvou5X7Y5-HZRN6jKgPuqiC4w>
    <xme:h9oBaudq0reXrwwhuDN9H5Rw_pDnxfDeX9xzXh9X1oNtcj-dcef93vkSvbQkwGy0e
    eQDnraGtDn9qXr1xzQoouWqHIOPTX82lz0k_136kE6D8xEXtQUz4nM>
X-ME-Received: <xmr:h9oBamuWAU98SQF3jyPE-dnDCCLoQScgrPb6B0P9K9wx1MRvftrMUvUJgiEbW4o5nln3qT72tuLe9qoBTmX-BmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigjhhliihhvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssehs
    thhrvghsshhinhguuhhkthhiohhnrdhorhhgpdhrtghpthhtoheprghlsghinhifhigrnh
    hgsehtvghntggvnhhtrdgtohhm
X-ME-Proxy: <xmx:h9oBarBskyPrCE69i_nUXkR8KAEbQ-u0O0fvIeyioJbSHmA6SEmQfg>
    <xmx:h9oBamH6Jk6Ha6x0vPGVsGcMyHkBQ9Mn0SS5WADXaJoHFDbUJGaccg>
    <xmx:h9oBajtB2HvANybT2suSVi1AAZXb3kPFCPhHVikUMVPM_YQPC6OILw>
    <xmx:h9oBaklZzpT-j1pLTB_eu_B5_It54pvPNuu2LSL_ye9Z0vgIKg1-zg>
    <xmx:idoBak_aR25brs4p3J2OnkQyXf6NCKbdHzvUbmuScDhoiFUJZieQ00Zx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 09:32:55 -0400 (EDT)
Date: Mon, 11 May 2026 15:32:53 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: alexjlzheng@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hannes@stressinduktion.org, albinwyang@tencent.com,
	shenyangyang4@huawei.com, kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v3 v3 1/3] macsec: introduce dedicated workqueue for
 SA crypto cleanup
Message-ID: <agHahVF3yq9AuLmj@krikkit>
References: <20260509033353.1814289-1-alexjlzheng@tencent.com>
 <20260509033353.1814289-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509033353.1814289-2-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 0CE1450F155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286652-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Action: no action

Thanks for the updated patch. A few minor comments:

2026-05-09, 11:33:45 +0800, alexjlzheng@gmail.com wrote:
> @@ -4450,25 +4452,35 @@ static int __init macsec_init(void)
>  {
>  	int err;
>  
> +	macsec_wq = alloc_ordered_workqueue("macsec", 0);
> +	if (!macsec_wq)
> +		return -ENOMEM;

Why did you pick an ordered workqueue instead of a normal one?

[...]
> -rtnl:
> +err_rtnl:
>  	rtnl_link_unregister(&macsec_link_ops);
> -notifier:
> +err_notifier:
>  	unregister_netdevice_notifier(&macsec_notifier);
> +err_destroy_wq:
> +	/* Precautionary, mirrors macsec_exit() to stay safe if work
> +	 * ever becomes queueable before this point in the future.
> +	 */

I don't think this comment is really necessary, but ok.

(I missed the discussion on v2, it's not possible to create SAs at
this point, but it's reasonable to add the rcu_barrier here)

> +	rcu_barrier();
> +	destroy_workqueue(macsec_wq);
>  	return err;
>  }

-- 
Sabrina

