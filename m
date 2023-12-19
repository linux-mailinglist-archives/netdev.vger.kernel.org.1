Return-Path: <netdev+bounces-58830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC1818520
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B651F21B3B
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802F14281;
	Tue, 19 Dec 2023 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKRUa36N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1814F67;
	Tue, 19 Dec 2023 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso52055855e9.0;
        Tue, 19 Dec 2023 02:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980827; x=1703585627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7M4xq122AX61szKBpJMOfJj+F3QBlSeTxa9D2l4u8g=;
        b=UKRUa36Nfk2WJDw964rx4tF2E8eLDEK2YNILULrFjsR4yPcjCoFHUl3z0gKloYogFv
         8TPuvKqZPOe3GmrQINnV9CSuMB4iVacgZNpkgrGu0SSBM+NrL+xUfvql1t41VqNOP3CC
         42yA9UnZLYPIVsgXsGUN3eI0jw+gyssxxDgjzACfPLU5kOFiuKMSEd//jStMbRdmP3mh
         kXazb+wl6j6VeBOthRYRe0Cso29JKwWaqcZS7oFoOLiu2u1MfNuEl6LpHIgYH8+1Tni6
         4bGfqvpEHue0rGrt7JJZIN5UdB+ledzztY48J19BkwZ/rsuRf/HDLd2SzRcqBXQM0Ph4
         Pyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980827; x=1703585627;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7M4xq122AX61szKBpJMOfJj+F3QBlSeTxa9D2l4u8g=;
        b=HozPVee80KUHp0j7JJM18iWnsBr9/P9BK+ZiA/P6ZWVGIKPV+G2kKcIJPvoQvY3ltF
         VDFtxrbs3P3Sm1neN66NQuPCfcfdU0kSKE0betv6TKt41tm6tKsO5Idai3LcZfm6psdx
         +D2QtC5mkJipBHySjmwi8ruuSw/07c5lh9huYXBvIhUCI5QzapmKSPQOX35isVNwNNzj
         zHnHcXzO85Ip8TsGtI9oX9ArDWtIfK9AsXglRekWjHDpG4CDIlyeCfoiV68heu/QjPSc
         EJdNYAX1zAFJCnJ/1CJqC/ChCWoV0yJGFPihWd0QW3cwI+KDDg7kqwBCxTTUpE/3tAtf
         OLSw==
X-Gm-Message-State: AOJu0Yxbm5Pp2vxl8IUd2TLh4JVy5yaeqYK4ru9bF/Srl+LekIa0BzQw
	axqw2pBBUGJ3BxadcU8Cn/s=
X-Google-Smtp-Source: AGHT+IEudogkL0MkOkDKM7OkgyMuRWxHlp/7iDqE5aHwoZiZOJoot0O0pfkCby6nODqO/lyZHJrGBw==
X-Received: by 2002:a05:600c:1d95:b0:40d:2082:40e3 with SMTP id p21-20020a05600c1d9500b0040d208240e3mr497743wms.102.1702980827175;
        Tue, 19 Dec 2023 02:13:47 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id iv6-20020a05600c548600b0040c45cabc34sm2131124wmb.17.2023.12.19.02.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:13:46 -0800 (PST)
Message-ID: <65816cda.050a0220.1b07b.59b5@mx.google.com>
X-Google-Original-Message-ID: <ZYFs16kfCFqJ9ey4@Ansuel-xps.>
Date: Tue, 19 Dec 2023 11:13:43 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: 20231214201442.660447-5-tobias@waldekranz.com
Cc: Andrew Lunn <andrew@lunn.ch>, Tobias Waldekranz <tobias@waldekranz.com>,
	davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
References: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>

On Fri, Dec 15, 2023 at 03:22:11PM +0100, Christian Marangi wrote:
> > > +        properties:
> > > +          marvell,polarity:
> > > +            description: |
> > > +              Electrical polarity and drive type for this LED. In the
> > > +              active state, hardware may drive the pin either low or
> > > +              high. In the inactive state, the pin can either be
> > > +              driven to the opposite logic level, or be tristated.
> > > +            $ref: /schemas/types.yaml#/definitions/string
> > > +            enum:
> > > +              - active-low
> > > +              - active-high
> > > +              - active-low-tristate
> > > +              - active-high-tristate
> > 
> > Christian is working on adding a generic active-low property, which
> > any PHY LED could use. The assumption being if the bool property is
> > not present, it defaults to active-high.
> > 
> 
> Hi, it was pointed out this series sorry for not noticing before.
> 
> > So we should consider, how popular are these two tristate values? Is
> > this a Marvell only thing, or do other PHYs also have them? Do we want
> > to make them part of the generic PHY led binding? Also, is an enum the
> > correct representation? Maybe tristate should be another bool
> > property? Hi/Low and tristate seem to be orthogonal, so maybe two
> > properties would make it cleaner with respect to generic properties?
> 
> For parsing it would make it easier to have the thing split.
> 
> But on DT I feel an enum like it's done here might be more clear.
> 
> Assuming the property define the LED polarity, it would make sense
> to have a single one instead of a sum of boolean.
> 
> The boolean idea might be problematic in the future for device that
> devisates from what we expect.
> 
> Example: A device set the LED to active-high by default and we want a
> way in DT to define active-low. With the boolean idea of having
> "active-high" and assume active-low if not defined we would have to put
> active-high in every PHY node (to reflect the default settings)
> 
> Having a property instead permits us to support more case.
> 
> Ideally on code side we would have an enum that map the string to the
> different modes and we would pass to a .led_set_polarity the enum.
> (or if we really want a bitmask)
> 
> 
> If we feel tristate is special enough we can consider leaving that
> specific to marvell (something like marvell,led-tristate)
> 
> But if we notice it's more generic then we will have to keep
> compatibility for both.
> 
> > 
> > Please work with Christian on this.
> 
> Think since the current idea is to support this in the LED api with set
> polarity either the 2 series needs to be merged or the polarity part
> needs to be detached and submitted later until we sort the generic way
> to set it?
>

Hi Andrew,

I asked some further info to Tobias. With a better look at the
Documentation, it was notice that tristate is only to drive the LED off.

So to drive LED ON:
- active-low
- active-high

And to drive LED OFF:
- low
- high
- tristate

I feel introducing description to how to drive the LED inactive might be
too much.

Would it be ok to have something like

polarity:
- "active-low"
- "active-high"

And a bool with "marvel,led-inactive-tristate" specific to this PHY?

In alternative we can list all the modes as done in the qca808x series
currently proposed. (more flexible for other PHY and expandable but can
pose the risk of bloating the property with all kind of modes)

PHY driver wise, with the set_polarity function or even probe function
they can handle this with a priv struct and operate in the
set_brightness function for these special handling.

-- 
	Ansuel

