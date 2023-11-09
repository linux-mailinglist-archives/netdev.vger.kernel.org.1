Return-Path: <netdev+bounces-46809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E07E6867
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304491C20A67
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58F7F2;
	Thu,  9 Nov 2023 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCb+JTQB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E5199B9;
	Thu,  9 Nov 2023 10:38:34 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079AB2139;
	Thu,  9 Nov 2023 02:38:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c5249d55so896772e87.3;
        Thu, 09 Nov 2023 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526312; x=1700131112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F6sdlilRzx4KJNCM1uvaoqMCkWPOin5PXK15jSeT8dQ=;
        b=fCb+JTQB/vRTl2VoGmwlivyJZS6BGPmVqgYXFd43vWN/9ykzobQeG9vIASQ4vhom1R
         dhnINY5isTV9x1YYHgmD1LTx9H7UyW0/6uMQIeRENmHOkUIAWUKW1cIkvgp7i0XtWfA7
         sbTCF/IfkgGX0iGu+0Q+DtFPiqK0Ga6N0ZSRK2+xuyXYfE9Ts+L+sDMK9pX0XQaEGDRS
         vUej/wZlTmm/1Gl6c2zTQD4rV+6QzMakdJGLD5wlTGavW0319j9ACPgIZQDp+9GSpmza
         oRdsNvFxbVolLPhRtAYZAGurQoDOKnQTPowbVUBXKup7M1+Z/lUaPY8sfjB73VuYxv8p
         q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526312; x=1700131112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6sdlilRzx4KJNCM1uvaoqMCkWPOin5PXK15jSeT8dQ=;
        b=ldReS1th0tQ/U1YqvpIdC07ySEsO+2es3Q9ApLg85tTiBUz2OPFR6ikrTlmyLogfNJ
         1jfAJ+F8+6UcaxkTA1RB+Mx3K62Bs95awkDsvZoCsGOnWSKRjXU7K1syCa9aWa8W9zxe
         mWcdqikUD0xDWkk2oJegXoGUbxyfu60syKUxyVA6ot3YraVlcWYPoDKqaEkF59Q6G+uX
         5l/nixSHlVdT4PHBv/PNS7/J47Ei33Il8GrvUFtT6msJIbNX/OZWPR2qDg+zNimaAe9I
         u3UXW7Y5kykY7dAfHDXA9pHQHJO/Uq+AwabPwZhlKnvg+NcwQzPILHGKU44alG4Zu4Gh
         twsQ==
X-Gm-Message-State: AOJu0Yx0+Ha0o0X5ITSuIwIKbY99u1HPHVwRtudkomJXCN43yTk/S1Rq
	6bB6zgZsUbi2UP2t6maijC8=
X-Google-Smtp-Source: AGHT+IHZhML8KNaOm9Y0mD700s/Nyoltq5ethe4dv3R0UqGXcUT3bmS/+0jzPSHKsy/PW133kpsC8w==
X-Received: by 2002:ac2:5f57:0:b0:507:b15b:8b92 with SMTP id 23-20020ac25f57000000b00507b15b8b92mr998309lfz.59.1699526311861;
        Thu, 09 Nov 2023 02:38:31 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b00405391f485fsm1684846wms.41.2023.11.09.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:38:31 -0800 (PST)
Message-ID: <654cb6a7.050a0220.78255.59d0@mx.google.com>
X-Google-Original-Message-ID: <ZUy2pLuCj82ynjOh@Ansuel-xps.>
Date: Thu, 9 Nov 2023 11:38:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v5 4/4] dt-bindings: Document bindings for
 Marvell Aquantia PHY
References: <20231106165433.2746-1-ansuelsmth@gmail.com>
 <20231106165433.2746-4-ansuelsmth@gmail.com>
 <20231107192232.GA3296102-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107192232.GA3296102-robh@kernel.org>

On Tue, Nov 07, 2023 at 01:22:32PM -0600, Rob Herring wrote:
> On Mon, Nov 06, 2023 at 05:54:33PM +0100, Christian Marangi wrote:
> > Document bindings for Marvell Aquantia PHY.
> 
> For the subject: dt-bindings: net: Add Marvell Aquantia PHY
> 
> ('Document bindings' is redundant)
> 
> > 
> > The Marvell Aquantia PHY require a firmware to work correctly and there
> > at least 3 way to load this firmware.
> > 
> > Describe all the different way and document the binding "firmware-name"
> > to load the PHY firmware from userspace.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v5:
> > - Drop extra entry not related to HW description
> > Changes v3:
> > - Make DT description more OS agnostic
> > - Use custom select to fix dtbs checks
> > Changes v2:
> > - Add DT patch
> > 
> >  .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> > new file mode 100644
> > index 000000000000..7106c5bdf73c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Aquantia Ethernet PHY
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
> > +  work.
> > +
> > +  This can be done and is implemented by OEM in 3 different way:
> > +    - Attached SPI flash directly to the PHY with the firmware. The PHY
> > +      will self load the firmware in the presence of this configuration.
> > +    - Dedicated partition on system NAND with firmware in it. NVMEM
> > +      subsystem will be used and the declared NVMEM cell will load
> > +      the firmware to the PHY using the PHY mailbox interface.
> > +    - Manually provided firmware loaded from a file in the filesystem.
> > +
> > +allOf:
> > +  - $ref: ethernet-phy.yaml#
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - ethernet-phy-id03a1.b445
> > +          - ethernet-phy-id03a1.b460
> > +          - ethernet-phy-id03a1.b4a2
> > +          - ethernet-phy-id03a1.b4d0
> > +          - ethernet-phy-id03a1.b4e0
> > +          - ethernet-phy-id03a1.b5c2
> > +          - ethernet-phy-id03a1.b4b0
> > +          - ethernet-phy-id03a1.b662
> > +          - ethernet-phy-id03a1.b712
> > +          - ethernet-phy-id31c3.1c12
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
> > +  firmware-name:
> > +    description: specify the name of PHY firmware to load
> > +
> > +  nvmem-cells:
> > +    description: phandle to the firmware nvmem cell
> > +    maxItems: 1
> > +
> > +  nvmem-cell-names:
> > +    const: firmware
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet-phy@0 {
> > +            /*  Only needed to make DT lint tools work. Do not copy/paste
> > +             *  into real DTS files.
> > +             */
> 
> I don't agree with this statement. Pretty sure we've been through this 
> before...
> 
> If we have a node, we need to define what it is. The way that is done is 
> with compatible. Whether some particular OS implementation (currently) 
> needs compatible or not is irrelevant. It's not about dtschema needing 
> it, that just exposes the issue.
> 
> These MDIO PHY bindings are all broken because they are never actually 
> applied to anything.
>

I will just drop these comments, the additional compatible is redundant
as it will be scanned from PHY ID but won't cause any problem.

Also the scenario with fw in nvmem cells or in fs is in devices where
the PHY is soldered to the device, so describe them in DT is correct.

-- 
	Ansuel

