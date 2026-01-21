Return-Path: <netdev+bounces-252022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCFwNSQbcWmodQAAu9opvQ
	(envelope-from <netdev+bounces-252022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D435B470
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14B2D84E14D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280C37BE93;
	Wed, 21 Jan 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0KqgJBZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED4366552
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016915; cv=none; b=WTUaiBMJ3Obm9wj0LtwSMZqceUrZdDpbsk8GIiAcoFVmeHgJC0tmec8ahMffW/26scT0Cc3PvHcdUDRhgvbz0keA7nbRoWRFvS6iHxilysoE35ycaYYzvl4mhNoUK3783ip5KOjo+jxrEF6dEjrGqNgFRktUBpC6BDlYor6PP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016915; c=relaxed/simple;
	bh=Fz2msaD9lrUVZIX8KtD2yrEdn8jXk2/zeBaLvgG60bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkB73GP25zW7GtVYCEnKIWS/sCW4IMY2yTT02NcXBJ+xyd1Uk2tYl7hCCtV3QBcNfEZ0Z1qaZe36hHDD2cX5vtqk2xr4mSAr/8bJhNq3t61dOuKW8RiwvuWUtANkYWlgQEaBQrTg3E3bzvDnVE7JgVf83ixZcrCncJjUkM+yyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0KqgJBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F73C4CEF1;
	Wed, 21 Jan 2026 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769016914;
	bh=Fz2msaD9lrUVZIX8KtD2yrEdn8jXk2/zeBaLvgG60bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0KqgJBZSi0E2CGaj4kkgGX40TMAzaX6sVH4gNF9RGt/RYb4HSjhYepaoDC4db3Ly
	 O+5GFLwoJSQ7HWNl7/2J20F3oV6gr/kzaYU+NNfOm5AJiqYXSH83emx3g0tBAKiOWh
	 YwsIv69SH7KHdwGEV6M/niDjwmL4kvPMTqFROcvRXOtLbnixJ0G/19FEyxAYVE3UZE
	 pUdG1YmSY8KhV4G95weF8EiNRU6Sp8AwKDiyd8b4jyfnpJC7FaPRFf0YFcLSTP1SZg
	 wvWBwd/gGjTzVJWeSVbzE9DzhushpOv8w7dV/lVm03gx6C701lVF0iBLMrVtDX8sxB
	 SxYo9TEIEMsgA==
Date: Wed, 21 Jan 2026 17:35:10 +0000
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: ks8955: Delete KSZ8864 and
 KSZ8795 support
Message-ID: <aXEOTvCiiCmG5_cN@horms.kernel.org>
References: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
 <20260118-ks8995-fixups-v1-2-10a493f0339d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-ks8995-fixups-v1-2-10a493f0339d@kernel.org>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-252022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 62D435B470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 11:07:32PM +0100, Linus Walleij wrote:

...

> @@ -346,79 +291,37 @@ static int ks8995_reset(struct ks8995_switch *ks)
>  static int ks8995_get_revision(struct ks8995_switch *ks)
>  {
>  	int err;
> -	u8 id0, id1, ksz8864_id;
> +	u8 id0, id1;
>  
>  	/* read family id */
>  	err = ks8995_read_reg(ks, KS8995_REG_ID0, &id0);
> -	if (err) {
> -		err = -EIO;
> -		goto err_out;
> -	}
> +	if (err)
> +		return -EIO;
>  
>  	/* verify family id */
> -	if (id0 != ks->chip->family_id) {
> +	if (id0 != FAMILY_KS8995) {
>  		dev_err(&ks->spi->dev, "chip family id mismatch: expected 0x%02x but 0x%02x read\n",
> -			ks->chip->family_id, id0);
> -		err = -ENODEV;
> -		goto err_out;
> +			FAMILY_KS8995, id0);
> +		return -ENODEV;
>  	}
>  
> -	switch (ks->chip->family_id) {
> -	case FAMILY_KS8995:
> -		/* try reading chip id at CHIP ID1 */
> -		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
> -		if (err) {
> -			err = -EIO;
> -			goto err_out;
> -		}
> -
> -		/* verify chip id */
> -		if ((get_chip_id(id1) == CHIPID_M) &&
> -		    (get_chip_id(id1) == ks->chip->chip_id)) {
> -			/* KS8995MA */
> -			ks->revision_id = get_chip_rev(id1);
> -		} else if (get_chip_id(id1) != CHIPID_M) {
> -			/* KSZ8864RMN */
> -			err = ks8995_read_reg(ks, KS8995_REG_ID1, &ksz8864_id);
> -			if (err) {
> -				err = -EIO;
> -				goto err_out;
> -			}
> -
> -			if ((ksz8864_id & 0x80) &&
> -			    (ks->chip->chip_id == KSZ8864_CHIP_ID)) {
> -				ks->revision_id = get_chip_rev(id1);
> -			}
> -
> -		} else {
> -			dev_err(&ks->spi->dev, "unsupported chip id for KS8995 family: 0x%02x\n",
> -				id1);
> -			err = -ENODEV;
> -		}
> -		break;
> -	case FAMILY_KSZ8795:
> -		/* try reading chip id at CHIP ID1 */
> -		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
> -		if (err) {
> -			err = -EIO;
> -			goto err_out;
> -		}
> +	/* try reading chip id at CHIP ID1 */
> +	err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
> +	if (err)
> +		return -EIO;
>  
> -		if (get_chip_id(id1) == ks->chip->chip_id) {
> -			ks->revision_id = get_chip_rev(id1);
> -		} else {
> -			dev_err(&ks->spi->dev, "unsupported chip id for KSZ8795 family: 0x%02x\n",
> -				id1);
> -			err = -ENODEV;
> -		}
> -		break;
> -	default:
> -		dev_err(&ks->spi->dev, "unsupported family id: 0x%02x\n", id0);
> -		err = -ENODEV;
> -		break;
> +	/* verify chip id */
> +	if ((get_chip_id(id1) == CHIPID_M) &&
> +	    (get_chip_id(id1) == KS8995_CHIP_ID)) {

Hi Linus,

This seems a little odd to me.
The condition can be true, but only because the constants are equal (0).

What is the intention here?

Flagged by Smatch.

> +		/* KS8995MA */
> +		ks->revision_id = get_chip_rev(id1);
> +	} else {
> +		dev_err(&ks->spi->dev, "unsupported chip id for KS8995 family: 0x%02x\n",
> +			id1);
> +		return -ENODEV;
>  	}
> -err_out:
> -	return err;
> +
> +	return 0;
>  }

...

