Return-Path: <netdev+bounces-59070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E950A81936A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561361F215B9
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCC3C6A4;
	Tue, 19 Dec 2023 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALDcoztj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2783C46D;
	Tue, 19 Dec 2023 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336788cb261so190063f8f.3;
        Tue, 19 Dec 2023 14:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024354; x=1703629154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c+U9F/n5xpKCPPuisB20j/cIz+UAY9d8vj1JdS9Q5nw=;
        b=ALDcoztjvdeSfeXeNPp3k1nYanhX1Obi7H3k0NfJ85NaJ1rLs6cMGbRwmPE8zgNuoY
         iVo1r27IdiB/haPkfb4kKRY+4bE0OkL953tVHKdMbhuS5v99ed+1ra3G+nIEpDYUReNo
         vxzW4Lr9JuwT8OxhKCLlUsC3+wIRklMpxeEsKnVLaD5+r/QDZebhy0Zt5jhsFdxr7ujj
         Jnq/y5GvWw9tzvYeDhRuSlVt9QoS8S7CNtC1e+UXl4A2pysp6urPW7L9CRV5bdNxK7p2
         9XqHqL4NuPWwMjum1rdHYYPE7xubby0REjtnAaw6+FZgFBwsndqKQ1m6mOGqCN8aAxMa
         zLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024354; x=1703629154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+U9F/n5xpKCPPuisB20j/cIz+UAY9d8vj1JdS9Q5nw=;
        b=IQxnkhbcJLjqRRO7z03mkDVM1ILCD5AcpknXkTDCLzeHhPUMQ35NiIA9pdE5ENM5uv
         MBHw+PNHbOs13yu05fuYUqhk5niCp1VUxiokhVjKOdTtmoaSunlplM2c3zqxMB21Mj/B
         7TzCSsoz7oxoXHvk38P95ZTvTI62WILM8ougclhx1dN2c9IL9RlxgybbVOk0PLvf+agV
         EM0tEYywbwTg1HTjWF1TGMqjdtl3MLF6ZM29JZu1YySCe4qaskl/PTVz4WoncnxkH2tn
         vY55Cdyiw377U31Fh53wO2Ovl9cR4N3iaIVtfxE16jVTww6az8RDrwmxClID67g5JzX7
         0AsQ==
X-Gm-Message-State: AOJu0YweiKS1BJIOJrauysbvFS3CR9WO1bLQJtvbmrr1OMIsaZqjOX1L
	DneA72VeHbk/v5tA0CTt2pI=
X-Google-Smtp-Source: AGHT+IGo0kDM34/fQ7tLwNBbsieyz8+FvMbOSHfnO7WJ07iiCVyzgAwLBz1EmMleIuodS8zPGRijTQ==
X-Received: by 2002:a5d:4dc7:0:b0:336:768b:c019 with SMTP id f7-20020a5d4dc7000000b00336768bc019mr473221wru.54.1703024354012;
        Tue, 19 Dec 2023 14:19:14 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d6b08000000b0033673ddd81csm2430554wrw.112.2023.12.19.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:19:13 -0800 (PST)
Message-ID: <658216e1.5d0a0220.ef7e8.7ff0@mx.google.com>
X-Google-Original-Message-ID: <ZYHybUewZjy-YTc6@Ansuel-xps.>
Date: Tue, 19 Dec 2023 20:43:41 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org,
	20231214201442.660447-5-tobias@waldekranz.com,
	Andrew Lunn <andrew@lunn.ch>,
	Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	robh+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
References: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>
 <65816cda.050a0220.1b07b.59b5@mx.google.com>
 <20231219115807.22c22694@dellmb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219115807.22c22694@dellmb>

On Tue, Dec 19, 2023 at 11:58:07AM +0100, Marek Behún wrote:
> On Tue, 19 Dec 2023 11:13:43 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > On Fri, Dec 15, 2023 at 03:22:11PM +0100, Christian Marangi wrote:
> > > > > +        properties:
> > > > > +          marvell,polarity:
> > > > > +            description: |
> > > > > +              Electrical polarity and drive type for this LED. In the
> > > > > +              active state, hardware may drive the pin either low or
> > > > > +              high. In the inactive state, the pin can either be
> > > > > +              driven to the opposite logic level, or be tristated.
> > > > > +            $ref: /schemas/types.yaml#/definitions/string
> > > > > +            enum:
> > > > > +              - active-low
> > > > > +              - active-high
> > > > > +              - active-low-tristate
> > > > > +              - active-high-tristate  
> > > > 
> > > > Christian is working on adding a generic active-low property, which
> > > > any PHY LED could use. The assumption being if the bool property is
> > > > not present, it defaults to active-high.
> > > >   
> > > 
> > > Hi, it was pointed out this series sorry for not noticing before.
> > >   
> > > > So we should consider, how popular are these two tristate values? Is
> > > > this a Marvell only thing, or do other PHYs also have them? Do we want
> > > > to make them part of the generic PHY led binding? Also, is an enum the
> > > > correct representation? Maybe tristate should be another bool
> > > > property? Hi/Low and tristate seem to be orthogonal, so maybe two
> > > > properties would make it cleaner with respect to generic properties?  
> > > 
> > > For parsing it would make it easier to have the thing split.
> > > 
> > > But on DT I feel an enum like it's done here might be more clear.
> > > 
> > > Assuming the property define the LED polarity, it would make sense
> > > to have a single one instead of a sum of boolean.
> > > 
> > > The boolean idea might be problematic in the future for device that
> > > devisates from what we expect.
> > > 
> > > Example: A device set the LED to active-high by default and we want a
> > > way in DT to define active-low. With the boolean idea of having
> > > "active-high" and assume active-low if not defined we would have to put
> > > active-high in every PHY node (to reflect the default settings)
> > > 
> > > Having a property instead permits us to support more case.
> > > 
> > > Ideally on code side we would have an enum that map the string to the
> > > different modes and we would pass to a .led_set_polarity the enum.
> > > (or if we really want a bitmask)
> > > 
> > > 
> > > If we feel tristate is special enough we can consider leaving that
> > > specific to marvell (something like marvell,led-tristate)
> > > 
> > > But if we notice it's more generic then we will have to keep
> > > compatibility for both.
> > >   
> > > > 
> > > > Please work with Christian on this.  
> > > 
> > > Think since the current idea is to support this in the LED api with set
> > > polarity either the 2 series needs to be merged or the polarity part
> > > needs to be detached and submitted later until we sort the generic way
> > > to set it?
> > >  
> > 
> > Hi Andrew,
> > 
> > I asked some further info to Tobias. With a better look at the
> > Documentation, it was notice that tristate is only to drive the LED off.
> > 
> > So to drive LED ON:
> > - active-low
> > - active-high
> > 
> > And to drive LED OFF:
> > - low
> > - high
> > - tristate
> > 
> > I feel introducing description to how to drive the LED inactive might be
> > too much.
> > 
> > Would it be ok to have something like
> > 
> > polarity:
> > - "active-low"
> > - "active-high"
> > 
> > And a bool with "marvel,led-inactive-tristate" specific to this PHY?
> * marvell
> 
> The "tristate" in LED off state means high impendance (or
> alternatively: open, Z), see:
>   https://en.wikipedia.org/wiki/Three-state_logic
> 
> Marvell calling this high impedance state "tristate" is IMO confusing,
> since "tristate" means 3 state logic, the three states being:
> - connected to high voltage
> - connected to low voltage
> - not connected to any voltage
> 
> I would propose something like
>   inactive-hi-z;
> or even better
>   inactive-high-impedance;
> 
> Krzysztof, what do you think?

Considering we want to use a property called polarity that might intend
the full configuration of the LED.

Wonder if
- active-low
- active-high
- active-low-open
- active-high-open

And describe them that in
- active-low
- active-high

low or high voltage is used for the other pin.

And for active-low-open and active-high-open the other pin is not
connected.

But maybe open might be even confusing (since I don't think they are not
connected bu as you said just attached to something high impedance.

-- 
	Ansuel

