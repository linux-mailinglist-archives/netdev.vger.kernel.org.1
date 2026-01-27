Return-Path: <netdev+bounces-253871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOXfA+K8eGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:25:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576294E1F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C2F301D682
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81A3563D3;
	Tue, 27 Jan 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i21R9Hel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A92BEFF8
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520350; cv=none; b=PhKjiPbM3WiiuyM2gxG+2yha6OJohqLcV8y+NoNXPUIFhFxj1LVePhEy4Z6a310Gid5XzQOGCtssFO+zYKNmrA9ACvhoPn7F1pmpMrbiMCFiirWkV86mMerKz2fzpzyykRd+mruBf75Q2hnyKKRY4Wb3QZBoSJFuUyi+o9BQug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520350; c=relaxed/simple;
	bh=DKKByrvZEjKIT/Myu40wMhUOkgAQzSlInWjqaT7lQZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7GKxZgt1W2F+Jtuejad2NEP98eE6Z6qgwjLFauY0FX94IeqBBcBFCoAsLLUkx8yKbIELLoF0+/gqlgDVGGZ7wtlO30yaJVghSZsyQjZntnM3n00R5v57IgqqghzZ5mn1hH6KzILvBy9CRQw3DM5W7f0K7kHpwTYfNlGVYGMkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i21R9Hel; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359309bf32so769441f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769520347; x=1770125147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQB+nvHOFdkG6DFc4Gb9geb+idoAzBkb6lGiVWp4fsw=;
        b=i21R9HelMd4cM0e5ycPvsaJ9W3EwywRI/TVzGE3NfYVApPadooOWq+h9ZuoaEHTLzK
         4/C8GTnccflh2peNObsC8KvfTvcYJuxEC0C7cPAAMPFclk7cT8HZq1nWc5x2RtytKz3e
         Mqxk/fgo3Kev0KUZb28rd7ocCCOd+LbBp5sv0fN+MSIerRmzNE3MIbIWWFpBC4cVYP86
         h6Lm/F4w84oQphyREpBqlccAVn8dZusYNZxbR9x83qCs5RDh0dJfwt/U3G9/nUCE7W06
         R4Q6TZGYqxxc/u1IYnHrl7DABepghElYywPV8a2vCLtZTh7gHH8h8JGCyoGbLPi8hizq
         f/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520347; x=1770125147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQB+nvHOFdkG6DFc4Gb9geb+idoAzBkb6lGiVWp4fsw=;
        b=wulN4+BEv/B2nEPNqrUWBllh4AA5JJ5EJtvc650ziJ3aQMz3mEoxZHbZSRpugkDlfC
         r0xNiW8MvKfji0qB3+EuiSFOFYgjrDwmvxgOBY58jm5ZRBeouIugxbn0l3yoAk2G0RNR
         mKQB8ze1VAL1Yjl1jWssFhKx0LHyl93/n4aAXuH2M5/YBh/5a6OwFbBPP7+VjEdl8kpc
         dkhb0jsnEYYp7RADPWYYJFvpEW+pQAAUSYqK9kBYw74XadqqVXxcLqxn/cSFdIP2zv2j
         5cvOPgGaPZQbU+YEkC6JwYjbDxTEFA4sROA1pBoub9Z5XleHZJT2jUaCbI4+EhZBLSmS
         tNRg==
X-Forwarded-Encrypted: i=1; AJvYcCVaA48GsXjmnBFVQGIvUBWHnW2uAHXKP29apQvPtanXpQp/hEDnm+sbcdJ3m8fb16xoF+RiLts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9OmOUWWHIOMQYjEnXHxorBNR4oVgphr1dFtLME0tyMHV/3Jh
	OA59M6UkC3hN+ju96nLhtKBLZbcWtfST6PqwHgFzmD5qHboELjrygVuR
X-Gm-Gg: AZuq6aIW/fkK0juO8y8YSFvZe9f6gXhZRVKXl9EWiuyhuLPz1Sc8999nQFDBYyemyLc
	mLf2Y/E8wBLyL1FEEITpC2LeBh5BptCGkHWJLTUTqpgPFZC1q8mWwk7NcLRvAk9tnjfzXw+JPUR
	sBTksDhM+YaLjIMKtOKItEMq8r2R0MPGCom1oy3qIKrsIeEeZ/XWWkzUswayNYEBk8CcGlx82XH
	p8iYg2GN+5oFiMQcKDFd8z88D0LjxrGbsQBtWDRZBtEe9rUOCpIOWadPNVqyh/Q5lBWQTYcCZfs
	C1lvcjje85nB95h72VOQBy8JI1dCWY0nF9vQXv7FRblirbrFTbadq25wbA9DhQQNZd/UQ0cF89t
	IuiFTvWpCMrFkVVt7L5WQ+7rJQKzz2v1OfPBY3L9hSYuseb10hricMIohKziWGdUFCn7E2D7B28
	fth4OgT/2VVtXeZQ==
X-Received: by 2002:a05:6000:186d:b0:435:a380:2262 with SMTP id ffacd0b85a97d-435dd1c17bdmr1511705f8f.6.1769520347299;
        Tue, 27 Jan 2026 05:25:47 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:739c:1012:de93:325c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71562sm37324308f8f.21.2026.01.27.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:25:46 -0800 (PST)
Date: Tue, 27 Jan 2026 15:25:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: mxl-gsw1xx: configure PCS
 polarities
Message-ID: <20260127132544.2ga4wiwckovziylw@skbuf>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <db296e8f477f34498979cd580898170f8ae537e5.1769519758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db296e8f477f34498979cd580898170f8ae537e5.1769519758.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253871-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6576294E1F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:18:45PM +0000, Daniel Golle wrote:
> @@ -229,11 +231,17 @@ static int gsw1xx_pcs_phy_xaui_write(struct gsw1xx_priv *priv, u16 addr,
>  					1000, 100000);
>  }
>  
> -static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
> +static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv, phy_interface_t interface)
>  {
> +	struct dsa_port *pcs_port;
> +	unsigned int pol;
>  	int ret;
>  	u16 val;
>  
> +	pcs_port = dsa_to_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
> +	if (!pcs_port)
> +		return -EINVAL;
> +
>  	/* Assert and deassert SGMII shell reset */
>  	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
>  			      GSW1XX_RST_REQ_SGMII_SHELL);
> @@ -260,15 +268,19 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
>  	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
>  			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
>  
> +	ret = phy_get_rx_polarity(of_fwnode_handle(pcs_port->dn),
> +				  phy_modes(interface),
> +				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
> +				  PHY_POL_NORMAL, &pol);

phy_get_manual_rx_polarity()

> +	if (ret)
> +		return ret;
> +
>  	/* RX lane seems to be inverted internally, so bit
>  	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
>  	 * (ie. non-inverted) operation.
> -	 *
> -	 * TODO: Take care of inverted RX pair once generic property is
> -	 *       available
>  	 */
> -
> -	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
> +	if (pol == PHY_POL_NORMAL)
> +		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
>  
>  	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
>  	if (ret < 0)
> @@ -277,9 +289,15 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
>  	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
>  			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
>  
> -	/* TODO: Take care of inverted TX pair once generic property is
> -	 *       available
> -	 */
> +	ret = phy_get_tx_polarity(of_fwnode_handle(pcs_port->dn),
> +				  phy_modes(interface),
> +				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
> +				  PHY_POL_NORMAL, &pol);

phy_get_manual_tx_polarity()

> +	if (ret)
> +		return ret;
> +
> +	if (pol == PHY_POL_INVERT)
> +		val |= GSW1XX_SGMII_PHY_TX0_CFG3_INVERT;
>  
>  	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
>  	if (ret < 0)
> @@ -336,7 +354,7 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
>  
>  	if (!reconf)
> -		ret = gsw1xx_pcs_reset(priv);
> +		ret = gsw1xx_pcs_reset(priv, interface);
>  
>  	if (ret)
>  		return ret;
> -- 
> 2.52.0

