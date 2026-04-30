Return-Path: <netdev+bounces-282979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGe2F+yu82k/6AEAu9opvQ
	(envelope-from <netdev+bounces-282979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 023204A7699
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A59C300825A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1336D9EC;
	Thu, 30 Apr 2026 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xLxpYijP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFA52D47E9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577704; cv=none; b=ZIcFN2eTnvgiSoSUAQXXHtc/N0R//qzv9rwVFQtgNEX4F+/QLr7/Dm1SmGVyxro8MJKzgKcp92bTS4AJFKxtHwn5tUw+QMPgCiohWvsqsWimK+sIfrrxinahdDSUQeSb2ZTAFG3Om7Ur1agzTU+8A64sPjLp/H+JpIkHiorGCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577704; c=relaxed/simple;
	bh=JU+Lm2/8upLNNTuwyJEW2xobHbda9df7x/rU9pwAbT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYyK+0bVnUK5aiPSfHD5dPLWYmjjtNZPG/FCQdoZW2GMvohorOjefA9Fkis0EUgONrFhBxJHSejI6jVCpQu1j8WopJ9Bnw7h+OziNaSHzD6wNzGneR+dSQp6QcV8qaVt7lG3rcCsVGaRdEH4R4dOwsRJjl9js7mCNd/2V+/UEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xLxpYijP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yE89MWJJ8mFNP+EQE3tQLxIR0F1fbjJ/EDjapCeT7Rg=; b=xLxpYijPKRJlrSK1eSbhOU9fBY
	zsnEulmwdGukFA+7vrU6SfzbCXvIp1PN5dKignndvM7ZMJj//Yay/FkpBrWEMCbrHZbZs0Vr9DM+R
	eQmWuVRWC4QO0XFDIkVTDOGOhM8n8qsD1MZxwD5G9utjkQDVz6rJ0KJkkX9zwj0bcdDA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIXA0-000jMJ-GI; Thu, 30 Apr 2026 21:34:56 +0200
Date: Thu, 30 Apr 2026 21:34:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 1/3] net/ethernet: add ZTE network driver
 support
Message-ID: <eabcb0c3-324f-4fd7-992e-8d517980ea27@lunn.ch>
References: <20260430151138.2813381-1-han.junyang@zte.com.cn>
 <20260430151138.2813381-2-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430151138.2813381-2-han.junyang@zte.com.cn>
X-Rspamd-Queue-Id: 023204A7699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> +    struct zxdh_pf_device *pf_dev = NULL;

Please don't initialise variables, unless they actual do need
initialising. It mask used before set warnings the compiler will
issue.

> +void dh_pf_pci_close(struct dh_core_dev *dev)
> +{
> +    struct zxdh_pf_device *pf_dev = NULL;

Looks like you can just set it so dev->priv.

> +static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +    struct dh_core_dev *dh_dev;
> +    struct zxdh_pf_device *pf_dev;

Reverse Christmas tree. 

> +    struct devlink *devlink;
> +    int ret;
> +
> +    devlink = devlink_alloc(&dh_pf_devlink_ops, sizeof(struct dh_core_dev),
> +                &pdev->dev);

Wrong indentation. In fact, this seems to have spaces not tabs. What
does checkpatch say about these files? Or is you email still broken?

No point reviewing further if the basic are wrong.

    Andrew

---
pw-bot: cr

