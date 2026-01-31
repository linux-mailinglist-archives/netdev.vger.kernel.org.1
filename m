Return-Path: <netdev+bounces-255446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOJsLx8Ufml6VQIAu9opvQ
	(envelope-from <netdev+bounces-255446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:39:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4FC2840
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F6230097F6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BB3570D1;
	Sat, 31 Jan 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOWuZyQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C0349B0B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769870353; cv=none; b=sTNvRmFuDVnBaECqclCDH2U+DwldmXYUbiDsu3+E5SA8FlpxrxqRzS5TG0GHpjBU3u6ol0gXFDtIm+971M+nIaODyXMlqFDi5A5l96HSu5JqXRDu/Q9595gjwiRdMRgPRq36ZYOuXLFpI+R9bJiVefUItWdOkg3gpUkYp0dcALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769870353; c=relaxed/simple;
	bh=agoPNQOe0xFyH7/EILpgDCjcO8bvJhuUEoS05pqjCos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKkqRqJ0HfOjdD7iZBCYy9zr50mZ1ffpjCrWRY7VEwqe1QAxs6S2ROPGm2FFYs05LLCXajqAU2QuKHa1rErQ3hLc4A+sxwTuv0geMfOUv4iDgIYXdCgN/IoHfzHLTyKfP7sU+XlK7AGjnP+4FgPEBwr7Dn/ZMHdfyU6yvmSm6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOWuZyQf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435a51abad1so420147f8f.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769870349; x=1770475149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pM8RMrvOe0ebjDVKWMiFhnPrBIYHyAt65WWdm6ay16A=;
        b=cOWuZyQfnYZmH08vxc4L24acMvkCav+lAOkl5V22dJkVC9ueY1B07Q1ZXfiIwo8ek2
         jSimFQKc+YdsX/pibYTvdr8WMd+ur1tVrpV9ccTS0P1dl7W18qLNvvxWiz0W/wOfFuQA
         nikYP9t/EcKXRaxfcmjuKxXFwSgvCNKhLKheg62nyULNAKvfYGkWMkyDbo1LBS7Vcml0
         v+C1OSvva9SRYY26kUy+j2RGTKqZYfygqQqgUKRv+InOyXeoNT9Xs+acQShe6rMI2gmv
         jl2pPHgsYUeaSwdEN4u8kssXfjZIqLUJus8yQBKg+dX7X/6l/aybUshPFFXWUVfpODc+
         9tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769870349; x=1770475149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pM8RMrvOe0ebjDVKWMiFhnPrBIYHyAt65WWdm6ay16A=;
        b=DcOfPzEHxUbitNc7JaDdiIPja+7IlcPTMcq0SVckEjU7xDyARbhMnHofPLhksLm1TT
         zNGg0ARI9jui1ZUFRc4kltA8/mykXuSWuZYMzibK+KfIyU9cR9Ch0curlZp9s4EMzx0h
         ppPRplBBArD8drEXvsUZdH5lvgh/ebiVxi02Z92KV+rMlpXtZILmOAfCXzrkKlHXuLlQ
         Xrnk/B55HGSUmTdWPCbRaD+lgkptWBjTwss1WFNfwKe1V6hBtCOn357ANf5AUdCstCd7
         MYnKVZD3kJY1FgEPWz7eYMzxwJi3QNhcsE09vdP9p63ri5nt+qIZX9mlh/j+MWtrrT01
         7d7g==
X-Forwarded-Encrypted: i=1; AJvYcCWBK60RxfmIwCIUWrH/eHiufYmz4CYLi8M6EK5QLhFYr2JSd2MZiaf2c8/KZEuU29OlD5plkeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj61VsntIRTJNWhnLbju0cXPvEuQTxwJFZ8WLpVekPFh25gGnW
	sTUSmvGAo/fS89Qv+EBKq2NWACkjn852KLBjiVxly94OEnZ1Q4VFlqlN
X-Gm-Gg: AZuq6aI8eJD4v42lwb0LW9hGQOX/ow2SfjnKYTbVGIf2CVMTjLnSfMTNR1cTbSeQ835
	pEyHhk2ICI3w+7ejRQpn0+3wynxgjFO+s9q2J/39CZ8oDSALSjaokDlnFCBqtYpLOWkRz+jc87p
	jHC7K1yoehnA+3bhQJsgCXjEnS4DV4GF26i5Jot7fs1debM1+Ya7wK36J7g5xHuyD2liG5ElvFI
	gjE3FjdTBZbjUOGVTJCxwUzQsca5838e3xniNwD9G04q1gX/742Qetai1CmN5EuR+RJU+cFeQhI
	lBAXRVQytce8W+1tutV0vawQAseaKEPXMjLa1qEuSolD1XSyLf8ktmtSpS0LvWCvZelLNuLISLs
	QNTTJcceosfY0djie1nfyKFmNSNtOoUf2hvoLFlcVc9c5GIChNF/6CuzoVBS0nn8v9+UMWiFMXw
	bAQg==
X-Received: by 2002:a05:600c:154e:b0:47e:e20e:bbc0 with SMTP id 5b1f17b1804b1-482db4576ffmr51474885e9.2.1769870348868;
        Sat, 31 Jan 2026 06:39:08 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:cd2:4e3c:ba08:4c89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm30491102f8f.23.2026.01.31.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 06:39:07 -0800 (PST)
Date: Sat, 31 Jan 2026 16:39:04 +0200
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
Subject: Re: [PATCH net-next v2 2/3] net: dsa: mxl-gsw1xx: configure PCS
 polarities
Message-ID: <20260131143904.ux4h43nmbxp5bn2b@skbuf>
References: <cover.1769733972.git.daniel@makrotopia.org>
 <875329426cffe416ebe6a3064ed632604f29f100.1769733972.git.daniel@makrotopia.org>
 <cover.1769733972.git.daniel@makrotopia.org>
 <875329426cffe416ebe6a3064ed632604f29f100.1769733972.git.daniel@makrotopia.org>
 <a570f80f0fa66692746954684b10d13242ce9f18.1769733972.git.daniel@makrotopia.org>
 <a570f80f0fa66692746954684b10d13242ce9f18.1769733972.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a570f80f0fa66692746954684b10d13242ce9f18.1769733972.git.daniel@makrotopia.org>
 <a570f80f0fa66692746954684b10d13242ce9f18.1769733972.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255446-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60F4FC2840
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:49:55AM +0000, Daniel Golle wrote:
> Configure SerDes PCS RX and TX polarities using the newly
> introduced generic properties.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> @@ -260,15 +268,17 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
>  	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
>  			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
>  
> +	ret = phy_get_manual_rx_polarity(of_fwnode_handle(pcs_port->dn),
> +					 phy_modes(interface), &pol);
> +	if (ret)
> +		return ret;
> +
>  	/* RX lane seems to be inverted internally, so bit
>  	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
>  	 * (ie. non-inverted) operation.

Sorry, I just noticed this existing comment now.

I think this patch set has the right solution with the wrong explanation,
and as someone who cares about logical consistency as much as about
functionality, I think it's worth resending to clarify something.

There exists a problem which, at a high level, is that the signal can
be inverted at multiple levels in its path. When multiple levels are
configurable, it becomes important to know "which level does this DT
property correspond to".  Otherwise it's not clear how inversions at
multiple layers relate to each other.

For someone who doesn't study the problem deeply, it will be confusing
that this approach is inconsistent with what I intend to do for XPCS on
SJA1105:
https://lore.kernel.org/netdev/20260122105654.105600-16-vladimir.oltean@nxp.com/

That is, if one needs to invert the TX lane signal in the PCS to achieve
normal polarity at the pins (to compensate for internal inversion in the
SerDes/PMA), then the PCS node needs to have "tx-polarity = <PHY_POL_INVERT>".

In Documentation/devicetree/bindings/phy/phy-common-props.yaml it
explicitly says that "If the property is absent, the default value is
undefined." in order to permit drivers to call phy_get_rx_polarity()
with a custom default_val, rather than phy_get_manual_rx_polarity()
which implies a predefined default_val of PHY_POL_NORMAL.

This is the opposite of what you're doing. You need to invert the RX
signal in the SerDes for what can be assumed to be a hidden inversion in
the PCS, but you make that invisible in the device tree, interpreting
PHY_POL_NORMAL as "inverted" when programming the SerDes.

Only difference, which also makes your approach self-consistent, is that
the rx-polarity property goes neither in the PCS nor the SerDes OF nodes
(which don't exist), but in the port node. If we interpret the port node
as what happens at the pins, the totality of the internal data path
layers with no further insight into sub-components, then it's OK and is
the simplest solution to the problem.

But it needs to be presented 100% clearly, with a very clear distinction
between the PCS, the SerDes PHY and the port as a whole.  Patches 1 and
2 use these 3 concepts very interchangeably, ranging from comments/commit
messages ("Reference the common PHY properties so RX and TX SerDes lane
polarity of the SGMII/1000Base-X/2500Base-X PCS can be configured") to
code placement (SerDes configuration done in gsw1xx_pcs_reset()) to
variable names ("pcs_port" could lose the "pcs" portion, to avoid somebody
unfamiliar with the HW doing some refactoring where they take the port
OF node as the PCS OF node, for other purposes as well, perhaps not applicable).

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
> @@ -277,9 +287,13 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
>  	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
>  			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
>  
> -	/* TODO: Take care of inverted TX pair once generic property is
> -	 *       available
> -	 */
> +	ret = phy_get_manual_tx_polarity(of_fwnode_handle(pcs_port->dn),
> +					 phy_modes(interface), &pol);
> +	if (ret)
> +		return ret;
> +
> +	if (pol == PHY_POL_INVERT)
> +		val |= GSW1XX_SGMII_PHY_TX0_CFG3_INVERT;
>  
>  	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
>  	if (ret < 0)
> @@ -336,7 +350,7 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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


