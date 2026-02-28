Return-Path: <netdev+bounces-262219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG68Ev1jo2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:54:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08321C9528
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFB931DA11B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945C30F7E2;
	Sat, 28 Feb 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PBB8N4qe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BB3101A5;
	Sat, 28 Feb 2026 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772312374; cv=none; b=N/v0qMVlQ6WUB07t8/xmOHUpoWTkSPPNJgyiSy6YGatpov1QMZYmFQK/5nhmw4TmtyLim4Qi+pBNK2i/BXFu2j6Mdz0eH4WBUjVJzp6P8l112RXXW/CKQKHMXossREbzpUry8t2AWM4AB6sh4RNLa4Eqo/dRjT8Yf3cbUyO7Jbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772312374; c=relaxed/simple;
	bh=nFIMGrF3Sthd/vK5fAbW361iIoujC3GOyHBeinY8p/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQv2yustuFJ7PY1ZKwTwUdE/T4r4iRMyRbO95O8EiViu1DAn8CHYIhwlwqUxUIIzHK6QMs7zdGbKcSgC8m2F2XAU4tINdUd9z/5khjc7dT3DK3vMJy7dTDRtRUCB368GWFWis8Y/Wxol4CFdHLkZ6pVwWCAXT1gPbJcF761mWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBB8N4qe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=biAwKoGqS3OZX+ntBTmdPsMRsc94h1FYpRLLpH1nnHQ=; b=PBB8N4qelMn1yZmMLBw7dM9sff
	54dIxTqqwfe/9a0hYp5SWj5jYobXsQgvV7PwhOTclL8glJO+wKxJm8evBzpcDbxuwC7OUAPRcclkl
	EtPsiaHGITo+WCewOSG8kVPINM8v0StZFFpth+gcIduFlLvlpo3coqTL7o32R198pzJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwRPF-009DwA-Vk; Sat, 28 Feb 2026 21:59:21 +0100
Date: Sat, 28 Feb 2026 21:59:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 11/11] net/nebula-matrix: add common dev
 start/stop operation
Message-ID: <b8f71f46-735b-4b1f-8df8-01a532bc7964@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-12-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-12-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262219-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: E08321C9528
X-Rspamd-Action: no action

> +int nbl_dev_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +{
> +	int ret;
> +
> +	ret = nbl_dev_start_common_dev(adapter, param);
> +	return ret;

return nbl_dev_start_common_dev(adapter, param);

But then i have to ask, why bother having nbl_dev_start() when you can
just call nbl_dev_start_common().

> -#define NBL_DRIVER_NAME					"nbl_core"
> +#define NBL_DRIVER_NAME					"nbl"

Don't change things like this. Get it correct from the beginning.

> @@ -37,8 +37,7 @@ struct nbl_func_caps {
>  	u32 has_ctrl:1;
>  	u32 has_net:1;
>  	u32 is_nic:1;
> -	u32 is_ocp:1;
> -	u32 rsv:28;
> +	u32 rsv:29;

Why has is_ocp disappeared? Was it never used? Then don't add it in
the first place.

> -module_pci_driver(nbl_driver);
> +static int __init nbl_module_init(void)
> +{
> +	int status;
> +
> +	status = nbl_common_create_wq();
> +	if (status) {
> +		pr_err("Failed to create wq, err = %d\n", status);
> +		goto wq_create_failed;
> +	}
> +	status = pci_register_driver(&nbl_driver);
> +	if (status) {
> +		pr_err("Failed to register PCI driver, err = %d\n", status);
> +		goto pci_register_driver_failed;
> +	}
> +	pr_info("nbl module loaded\n");

Don't spam the log.

> +static void __exit nbl_module_exit(void)
> +{
> +	pci_unregister_driver(&nbl_driver);
> +	nbl_common_destroy_wq();
> +
> +	pr_info("nbl module unloaded\n");

More log spamming

	Andrew

