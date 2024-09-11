Return-Path: <netdev+bounces-127496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F028975943
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F82285AEF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC681B0131;
	Wed, 11 Sep 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gI3HRS2U"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB11A7AD2;
	Wed, 11 Sep 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075475; cv=none; b=FBUbEUJWNUZXFdK/763aIhFJrA4VzDEDap5qfYMKEjezoZkOAapeSGFakbJYHsVXEFodKnoSNWKgr71xamiMCMaTmkmHnSHvbqmiyqAx0leEDQCmqZRN6THHL7vTt8wmHchM8RZdbgMDJlWffj8PKP2rdXTsQTap9P+WiSXrVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075475; c=relaxed/simple;
	bh=nmClAsUqTrnOuhGkCIFAF0/JOFUfML/VO2XNpoibdwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7hg8pjFTSc33dj4s4pgunB3Y6zjSQ6T2z+/5JjM9e5hWKIpXxDYEbWZmOCURznEZJONLvkB8PSOAMlbZxnYKKOJikB+7733/eSZK80I13Ex/rJHQN8E44zLrBb+5lOHJSZbXdvDqKUy8X36c1CvfJ42mceIKxTkRHjj/P9KR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gI3HRS2U; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98D7620007;
	Wed, 11 Sep 2024 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726075470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVllLPdo6jGcPAqF/a1pHcskPl6uYc607Xh9DUSo+LU=;
	b=gI3HRS2UwW/8tTSqU/CgG5NL3J4+lTK77WjzLSFsNBv6CFwspElHpIgq/8IXHkHt/6rrbg
	QJSMXCwukwmwQbmPkrRAwEIU2LCJQEaJVGg3z6ZJEnHnN+++VI+vCZHSo1O4mFSK1LtJVu
	84Mf1f4NGKY0PusWht600gfs5fsoopn74T52TziCrEhvwqeo7qr83cjwnkcCcPK17bzMDS
	0AoKi4Xxvde5f43C2gxcxcQGeVTPZUe49CEIdYUpos8MZDCtMA7YtfLsWlKpmcAKIUc1tZ
	1YZfgIVuyPLVCXjcTk/lzi17WZu/0jGq6sFDeIYXkuJ4tpOPwGeOLW4oc10g4g==
Date: Wed, 11 Sep 2024 19:24:25 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
 <rdunlap@infradead.org>, <andrew@lunn.ch>, <Steen.Hegelund@microchip.com>,
 <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <20240911192425.428db5ac@fedora.home>
In-Reply-To: <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
	<20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Raju,

On Wed, 11 Sep 2024 21:40:53 +0530
Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:

[...]

> @@ -3820,9 +3869,28 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
>  	ret = mdiobus_register(adapter->mdiobus);
>  	if (ret < 0)
>  		goto return_error;
> +
> +	if (adapter->is_sfp_support_en) {
> +		if (!adapter->phy_interface)
> +			lan743x_phy_interface_select(adapter);
> +
> +		xpcs = xpcs_create_mdiodev(adapter->mdiobus, 0,
> +					   adapter->phy_interface);
> +		if (IS_ERR(xpcs)) {
> +			netdev_err(adapter->netdev, "failed to create xpcs\n");
> +			ret = PTR_ERR(xpcs);
> +			goto err_destroy_xpcs;
> +		}
> +		adapter->xpcs = xpcs;
> +	}
> +
>  	return 0;
>  
> +err_destroy_xpcs:
> +	xpcs_destroy(xpcs);

It looks like here, you're destroying the xpcs only when the xpcs
couln't be created in the first place, so no need to destroy it :)

Best regards,

Maxime

