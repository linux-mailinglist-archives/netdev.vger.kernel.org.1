Return-Path: <netdev+bounces-58067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5815814EED
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D7B1F2421B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07982EE9;
	Fri, 15 Dec 2023 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPom+RRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2030105;
	Fri, 15 Dec 2023 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso10611835e9.2;
        Fri, 15 Dec 2023 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702661717; x=1703266517; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDM7Gyx0opqICU85pKvqZtalDyOdIzIV3Qr01aGjUvA=;
        b=IPom+RRanUFk+XTRAUwE01vOB1PBy7r3gglB6mTiQRnJl737c9qHhR/elJWajPdnst
         J7LQuwCzKZJrkv+JHSpBz5bnsFVy2hNaK78iAGYlueT3O9HqVD7BmS3cnh94LKIq4MhW
         Kc+ELXftY5YtTKnoH9obsisX43a9CYsVVN+hzod/7+TFKofV7D+5aCTlkowG23A6yh5z
         zF/bar+3TcdD/BlLWwbCeraFv107xWgReMEC5t89jKZ+2cVxC7B2ThJn8Y0fdpPV440Q
         sYZgkruqp4P3rvyq7W/ply31rZ3xNVHT101MDH1P3krHFztanYCGHYFezQ3OQuzbjBYJ
         XW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661717; x=1703266517;
        h=content-disposition:mime-version:reply-to:subject:cc:to:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDM7Gyx0opqICU85pKvqZtalDyOdIzIV3Qr01aGjUvA=;
        b=Wfhbvs2q5klvai4j6iGOhYrXpCeNFbyBPm973d+zXc9bFZKCO5dRTP4MO7oIJa/nLq
         okwK8hqdH9FGCf7ChVRPwIpaoxjbdIgtt51sf9/oLa29kcJbJYgu1CWHdAiym5ozXJmc
         EhxqB22V1lSDMYJBEmfxT5AKyc1zIRV4mLXZIEO+prOIX3f4mtFC2qj0bc1L6KHXVQeK
         MBcGIJ9IaVznf9NLV+F2c6MQ4Y0Fb93SU88XNxjlt0CHacz6fVBEYOcULgV0pDzf/i4G
         HfsqGYAAaO/hZMaHWch/yw3ZpKji1I7hJoKJ6RdlymefL23SDPfrgSk9llmVZI8uvmHo
         BIhw==
X-Gm-Message-State: AOJu0Yzeavhg/2OyF9+IR1VYi1bMhiQ9Jjd0XiSpUoYlTQuE+lBbr7dW
	+3x5ZytyzP4n9DFyidxtbR99yun5pzY=
X-Google-Smtp-Source: AGHT+IHqbVBfuLXGSjdFKZPZywE06b2XwJVWt75FIkdl501f+QEYJYGnrSg/wCkp5xF7XPjjEClt7g==
X-Received: by 2002:a05:600c:3107:b0:40c:32fa:4f41 with SMTP id g7-20020a05600c310700b0040c32fa4f41mr6514069wmo.142.1702661716270;
        Fri, 15 Dec 2023 09:35:16 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b004094e565e71sm29868770wmr.23.2023.12.15.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:35:15 -0800 (PST)
Message-ID: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>
X-Google-Original-Message-ID: <ZXxhE--t-2l9BRB-@Ansuel-xps.>
Date: Fri, 15 Dec 2023 15:22:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, linux@armlinux.org.uk, kabel@kernel.org,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
Reply-To: 20231214201442.660447-5-tobias@waldekranz.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > +        properties:
> > +          marvell,polarity:
> > +            description: |
> > +              Electrical polarity and drive type for this LED. In the
> > +              active state, hardware may drive the pin either low or
> > +              high. In the inactive state, the pin can either be
> > +              driven to the opposite logic level, or be tristated.
> > +            $ref: /schemas/types.yaml#/definitions/string
> > +            enum:
> > +              - active-low
> > +              - active-high
> > +              - active-low-tristate
> > +              - active-high-tristate
> 
> Christian is working on adding a generic active-low property, which
> any PHY LED could use. The assumption being if the bool property is
> not present, it defaults to active-high.
> 

Hi, it was pointed out this series sorry for not noticing before.

> So we should consider, how popular are these two tristate values? Is
> this a Marvell only thing, or do other PHYs also have them? Do we want
> to make them part of the generic PHY led binding? Also, is an enum the
> correct representation? Maybe tristate should be another bool
> property? Hi/Low and tristate seem to be orthogonal, so maybe two
> properties would make it cleaner with respect to generic properties?

For parsing it would make it easier to have the thing split.

But on DT I feel an enum like it's done here might be more clear.

Assuming the property define the LED polarity, it would make sense
to have a single one instead of a sum of boolean.

The boolean idea might be problematic in the future for device that
devisates from what we expect.

Example: A device set the LED to active-high by default and we want a
way in DT to define active-low. With the boolean idea of having
"active-high" and assume active-low if not defined we would have to put
active-high in every PHY node (to reflect the default settings)

Having a property instead permits us to support more case.

Ideally on code side we would have an enum that map the string to the
different modes and we would pass to a .led_set_polarity the enum.
(or if we really want a bitmask)


If we feel tristate is special enough we can consider leaving that
specific to marvell (something like marvell,led-tristate)

But if we notice it's more generic then we will have to keep
compatibility for both.

> 
> Please work with Christian on this.

Think since the current idea is to support this in the LED api with set
polarity either the 2 series needs to be merged or the polarity part
needs to be detached and submitted later until we sort the generic way
to set it?

-- 
	Ansuel

