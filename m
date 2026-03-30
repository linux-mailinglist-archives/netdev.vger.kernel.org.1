Return-Path: <netdev+bounces-273352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CvfNKf8ymn7CQYAu9opvQ
	(envelope-from <netdev+bounces-273352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143936210E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF52A30474E3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270E3EBF37;
	Mon, 30 Mar 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE7cC5U5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CB3EAC9F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910275; cv=none; b=ZqG4wNWHDQQGUjlPw2XIXtYqiDlk8B8GQCYn0Ln+Fnd6L0D+ehU5CjupkPVhsf+96fXyt3jlfxHtj1mjzc62H2ZTYvganGYcAbfQea4aRjbmAwek/5hXsogX9Hw5V7hRbAziLt7Wa9+ztQTak1WSHf0wezZPugbZ1lhNubSFoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910275; c=relaxed/simple;
	bh=EQimx+QysHLjjgSi9/ePA+PjBK6gGiEFjWC4RPJeIv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee7YHj6ER5nuDdeJZ9PPpDKPBo1zC9B9NiAdzUk+sQhZHgky3zRuy2hy8Fnqk75+k0gAe9+QOvGn98ug9i+Hi9OwLFASoOHJPFqDAtaGvvHLbf3/O/2+vJsGyJhvc2LR1xy4wpQYySYfvRjx7Hxah89R02/MttDqxp9mf8T5nIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE7cC5U5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485358f43e7so5565145e9.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774910265; x=1775515065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jfJJje0KBtM9hz5w5lHt1nnYJf3r1NFmOVPbBE39ug=;
        b=UE7cC5U5fTRYpE7ImKu2qQHK2s4yHX1nWr9iiSS5gZpGBZpsFvzNLPJ/v+yhJ5L8VQ
         JnF/MHhy3pcy4X49sNnJG8oUtLJuao+wVd6l4x5uc91fk+hafx0vYe7ZE3KB5l/1lb56
         Xjxt1IpJus9WOylHD52QflZ6mawaFG++EoWAWOaRxo9o1+LdOOxVBXVq1P3FKozDMnqd
         osvCcBgcX1HUbFuLpAQPfhxS45UWG4rvyw8fk0seCxgiNU/tSbTEBbu9PptKjgkSwseX
         1A2qwYx8GTVpjiMKT+wUmUDY2Ka1BhVVrZO5zXik0wL2C5XwIAZgHDhJWB0GTxyI9eqL
         q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774910265; x=1775515065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jfJJje0KBtM9hz5w5lHt1nnYJf3r1NFmOVPbBE39ug=;
        b=VCoF+u4r9OduaVY3c4XEuUX8qsqaNIQ43oInJjlt8FlRCutGx0M4pAuBeEZLSCyRbf
         0yyu5gOThKixRNT1X0owAjn7VDp/oz92lY6G7gwUFvNNuhdt0mJ9q9GAG3kAFMgCOtRr
         Kl079d054GQV1nWkn8zHGxMrNv21iM8M9qXreAr7ru4vnSSLtGz0duuKddPEVtFxnq4l
         hhX5ib4QELnXjB3n5C+uMy3+StjrXhcOWYmA9fTcMInW3McPhoKdfSoB33jHpc7MPbhL
         Q7K7Xi6pvPViu+/LZk9awjvq4fJnbLp25GjFlm7DRLk7SHSK/RjO7i5E/daSNyTL7uaG
         +puw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ktPn0PgxJO2sn/+ok576qmO7Hf7XgmorBqdRkeuqm3vsNLZGfV9J5ugYpmzflNqQWh7BXbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq42+CxBFQgFc3OisUxfpjd0cwJLOXgXbD94GScxQ1+IyY6EA/
	7RqWxhFULRWw9TeohgPst/LSO2bkjG/foe934KLsEX7cV8On3jVBTLes
X-Gm-Gg: ATEYQzzWdIfYdHO2S4ixPk5bbvj82E4uaBOHHomBZfk8Ns6/1smFXPTEQuCnaM46z3P
	IseQtjU9RCcpi+OePSAb+PbrcLnodwTZ52bQxxz6SgOZA2Qce/1lvgi7HqqFLaJC/ZI/JLqzY+C
	qxPhOPvNB79im6WQR8lWP8EcexXSHop4vMxgi2UcvrO1he9Efig3xJQh5uiT1yNxXvoscsxafBp
	RtMJQvvePBgmw26yYyJ0ZLpXC5eUDPD3iXOj/lyOv7/8/QjlyIao/nPZfficer+3P+kBipDkONT
	fAP8u9ZauYPk59mKVgNGU2CgMns4Qj5UgyCL73SiZpncLofsClAv1Oh1ssOKP8BGfUaHLQgihWU
	2dJp6xf5WU9q+Vb2JVF3wHushnd7nRqClLlJ5dAAgjDULJcaIjFk0VXPP8pIo8SpPdH03UG5SfR
	sLaUjt7qaNkTfxmPOAN11Jfdoo1A==
X-Received: by 2002:a05:6000:4014:b0:43c:fd96:2b8a with SMTP id ffacd0b85a97d-43cfd963552mr5568854f8f.2.1774910265013;
        Mon, 30 Mar 2026 15:37:45 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:fc92:d05b:3301:b722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm23222604f8f.30.2026.03.30.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:37:44 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:37:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 5/7] phy: ti: gmii-sel: add support for J722S SoC
 family
Message-ID: <20260330223741.pmrx25cslrlpbcea@skbuf>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
 <5d00697f133cd33a1df62ac7ebf73e507e49ed2f.1774354734.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d00697f133cd33a1df62ac7ebf73e507e49ed2f.1774354734.git.nora.schiffer@ew.tq-group.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273352-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email]
X-Rspamd-Queue-Id: 3143936210E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nora,

On Tue, Mar 24, 2026 at 01:29:41PM +0100, Nora Schiffer wrote:
> The J722S gmii-sel is mostly identical to the AM64's, but additionally
> supports SGMII.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 6213c2b6005a5..4e242b1892334 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -251,6 +251,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
>  	.regfields = phy_gmii_sel_fields_am654,
>  };
>  
> +static const
> +struct phy_gmii_sel_soc_data phy_gmii_sel_soc_j722s = {
> +	.use_of_data = true,
> +	.regfields = phy_gmii_sel_fields_am654,
> +	.extra_modes = BIT(PHY_INTERFACE_MODE_SGMII),

I'm not familiar with the hardware, but "mostly identical to AM64, but
additionally supports SGMII" does not explain why j722s does not inherit
the features that am654 has (PHY_GMII_SEL_RGMII_ID_MODE and
BIT(PHY_GMII_SEL_FIXED_TX_DELAY).

The phy-gmii-sel from j722s does support RGMII, right? Because in lack
of the PHY_GMII_SEL_RGMII_ID_MODE feature, phy_gmii_sel_mode() will just
silently skip the regmap_field_write(regfield, rgmii_id) call, and
return successfully despite an incomplete configuration.

We have the phy_validate() call and phy_ops::validate() through which
the PHY can report to the Ethernet controller which phy_interface_t it
supports and which it doesn't. If the j722s doesn't support RGMII, maybe
it should implement this method.

> +};
> +

