Return-Path: <netdev+bounces-245004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0BCC4E37
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B264302F1BD
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56DE33971E;
	Tue, 16 Dec 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwrm8Sld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5851221FDE
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909816; cv=none; b=op2wcqcW1VB8QIKYRHConwWqT2wrX3F2Q6R++lrl3vOrrzXa0jXdkZX89fHq0paIBTcN/oL/CIUsFNA0yLjXfwkRq3DhzaDn1SHs3QnVpCOmH8n8xFh5841UO080p/SzMCqn7IKH4RBxfXPBnVCmeD/G9yfPGryrfO7NSjlRyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909816; c=relaxed/simple;
	bh=/QX1+siljLhXuETEqMly+imYqZN+VvoqR7nTfdr+yXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz7iwIvuPUxxUxNYIYOu/2qZEX9bHbLTaDpwRfDNRm3waikysHV0QN4nFXrDfK+FHJt6en4kkywn9reJPrFc8to9hwm6BPZsCERnf9aePYOHutO8z73wrPWfxA+Lz7hrC4eBoudvCQMMt1dHhhHu0hH9XHsrsKxAn58oly4VsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cwrm8Sld; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d9326so30062745e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765909813; x=1766514613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2qwyKoiSE4y0S7R/sYbAU8Ep9J/DNr0jxtlpXQRjF8=;
        b=Cwrm8SldF2gSQUsvPOPiroVHw61dCrfsACHy8I854U4ByeuCe60bSLFKsc715Jm+oG
         P4A/4dOns7Pj9NJ+fbIHhqrQTEdfZukbFsKXH8XddQy69nBFE0omto7hgKhr4U7P/fx7
         tAIGTCrwqBkUgosO4X9edB9L0qmoBNXOokCss0f2CjJSD1USbncYOVEf86I8gcqjkkUX
         W/TbST1mjQPf3ic9J4e6dOyuccN+EEh6m7kN84EAhxg+sDtchs1CkuINSP9OncElWdpH
         caFu9TBTmw4nuVomtNIVE+shYlFnCFeWwXir1yXWhV0bYgV0lZIGXHvOnnbS1syb7Pix
         8Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765909813; x=1766514613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2qwyKoiSE4y0S7R/sYbAU8Ep9J/DNr0jxtlpXQRjF8=;
        b=t3Bjd3z8ObMTljcs/xtNawQbMiU8jtTW6ytdQboRuUfaHuSJez6m9kxDVdkSIisCvG
         8s2XpvpYvSU7P+KFUd9MqahdJQPnruHOracz+MqLhoIs0hzOX64isezRzpaZi55tG3X2
         aboebtV9dXi+/DwS6OZl2bEQ7YRPn4BXBl0DISvAzUc+33ehucv1cR1VuUUieN3bmcbg
         Zxros3oAtJy41vr5u/SJb3M+rgEuNeRVZm4OfIx5U0g8A+Xm8SwXHsYLIZ1Tsg2tXOzw
         MuXDDcZsGSOdaxf3Rr4NxBjn9fEMw51xw8M4cky2dL2OTo2RKXi3dS4D8bJ8STiRq3Vp
         IZtw==
X-Forwarded-Encrypted: i=1; AJvYcCUJNe1DIDe1LYJ5FwNd0oDjCIkngDfvTA++WRrbbKkAr3onV3Jy2gJcjIKUNoPPsrIXF4/IBIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACJtTbIW9+KiXDcJE0lWuJTW+4eIynexQIgKn3oUdKjq8Ba+Y
	NjfDVA4LfS0JrUWLFh9KwgZrvvppMpJeyUuuS1cEy7hE/1kwPL9IzBE48GACMAjv9Y8=
X-Gm-Gg: AY/fxX5b+OElBZlSats22hkz7VyTXRPraT/8IQCv8YYRpqTwrQ3vXGxB/tyxxWdpeBt
	dzDofXXwfG4dPdXJPm8WawTf9MBJaLaPk3URqAoH1JYKeqnB5K/eQcrFmEtsD0SA4kCdm6HUHvi
	KZuakw+WPyf31vr+Iz5Myn2YGdy+XWLebqUr7/xOoHqdTUUhNlO8CFdgNHJSWiuo1q8cxftuxN6
	8NSBP5mnqHxulyFokwRD5gusKzlLuH9y91haNjnagvZTPZOF5/U1ai6efeBMDuM6r6XIKXOdWqD
	Hu0SSrYbScHgTGf56JseKxZLXxtKlZHkGM/VS/LvaXIredJK2vcVWUz4JKVX54ru+oLZ0KsXKvO
	1qRmomFoDArROK/3xwJkGZ3OhB0kkGbdEMBXTP26VOXg+Kr72/JVXwcUKYckeZMmp0jUTCTv1fG
	TredLZDAVKc6HRJBOI
X-Google-Smtp-Source: AGHT+IF+nY/k4C/6P18u9JysznJj/Z5B3Y6A+1aqCm2cbh7pc65+FeNcv1ODeP4J/8ke38+irCHPGg==
X-Received: by 2002:a05:600c:45c9:b0:479:3a87:2eeb with SMTP id 5b1f17b1804b1-47a8f91515amr130008935e9.37.1765909812657;
        Tue, 16 Dec 2025 10:30:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc23c2b0sm2187435e9.15.2025.12.16.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:30:12 -0800 (PST)
Date: Tue, 16 Dec 2025 21:30:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUGlMP7J19L_AHF2@stanley.mountain>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
 <aUBrV2_Iv4oTPkC4@stanley.mountain>
 <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>
 <aUEQkuzSZXFs5nqr@stanley.mountain>
 <aUFvvmDUai9QrhZ2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUFvvmDUai9QrhZ2@lizhi-Precision-Tower-5810>

On Tue, Dec 16, 2025 at 09:42:06AM -0500, Frank Li wrote:
> > >
> > > Why not implement standard phy interface,
> > > phy_set_mode_ext(PHY_MODE_ETHERNET, RGMII);
> > >
> > > For example:  drivers/pci/controller/dwc/pci-imx6.c
> > >
> > > In legency platform, it use syscon to set some registers. It becomes mess
> > > when more platform added.  And it becomes hard to convert because avoid
> > > break compatibltiy now.
> > >
> > > It doesn't become worse since new platforms switched to use standard
> > > inteface, (phy, reset ...).
> > >
> >
> > This happens below that layer, this is just saying where the registers
> > are found.  The GMAC_0_CTRL_STS is just one register in the GPR region,
> > most of the others are unrelated to PHY.
> 
> The other register should work as other function's providor with mfd.
> 

Syscons are a really standard way to do register accesses.  The
pci-imx6.c driver you mentioned earlier does it that way...  The only
thing which my code does differently is I put the offset into the
phandle, but that's not so unusual and it's arguably a cleaner way
because now both the base address and offset are in the same file.

regards,
dan carpenter


