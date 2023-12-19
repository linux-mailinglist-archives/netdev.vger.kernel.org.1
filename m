Return-Path: <netdev+bounces-58842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E28185C8
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E85A1F25D3C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9014A94;
	Tue, 19 Dec 2023 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYwX/cU9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1215AC9;
	Tue, 19 Dec 2023 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065C0C433C9;
	Tue, 19 Dec 2023 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983492;
	bh=uHLoReQ0rrb9TjeQA9A4ObaAjoz7p639g5gyuqEsBqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYwX/cU9kTglIX+sPh1HMvmGQlrv2BHO1S4nqxsg2f2NfWu1xRIyQI5lpgru8rZMS
	 /tMARDxycW/nuKZzshAIqkEdLM7yXwRPIt7ah76LNWRXY6gV3xhXN4rlCxtHYSa1na
	 IQ799yn7GzKjLObAOiu2jw2bnHgy3+TknMjtpS6dYa5JdSOjuIsGGWoiNd90+TR0U8
	 xhDU43Wu9wk0s2t3h98jKy1yW4ep2s6a92vN5OaXhleCOVy0vm6ri1skcr1LdnY1Sh
	 74pRSSMlF6j44GH23+sONqEpWrA267xNRaH4PQKklIeMgQOw40/kyChN4UnGWIuv7L
	 ZelGb4xr+oZ0A==
Date: Tue, 19 Dec 2023 11:58:07 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
 krzysztof.kozlowski+dt@linaro.org
Cc: 20231214201442.660447-5-tobias@waldekranz.com, Andrew Lunn
 <andrew@lunn.ch>, Tobias Waldekranz <tobias@waldekranz.com>,
 davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, robh+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
Message-ID: <20231219115807.22c22694@dellmb>
In-Reply-To: <65816cda.050a0220.1b07b.59b5@mx.google.com>
References: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>
	<65816cda.050a0220.1b07b.59b5@mx.google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 11:13:43 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> On Fri, Dec 15, 2023 at 03:22:11PM +0100, Christian Marangi wrote:
> > > > +        properties:
> > > > +          marvell,polarity:
> > > > +            description: |
> > > > +              Electrical polarity and drive type for this LED. In the
> > > > +              active state, hardware may drive the pin either low or
> > > > +              high. In the inactive state, the pin can either be
> > > > +              driven to the opposite logic level, or be tristated.
> > > > +            $ref: /schemas/types.yaml#/definitions/string
> > > > +            enum:
> > > > +              - active-low
> > > > +              - active-high
> > > > +              - active-low-tristate
> > > > +              - active-high-tristate  
> > > 
> > > Christian is working on adding a generic active-low property, which
> > > any PHY LED could use. The assumption being if the bool property is
> > > not present, it defaults to active-high.
> > >   
> > 
> > Hi, it was pointed out this series sorry for not noticing before.
> >   
> > > So we should consider, how popular are these two tristate values? Is
> > > this a Marvell only thing, or do other PHYs also have them? Do we want
> > > to make them part of the generic PHY led binding? Also, is an enum the
> > > correct representation? Maybe tristate should be another bool
> > > property? Hi/Low and tristate seem to be orthogonal, so maybe two
> > > properties would make it cleaner with respect to generic properties?  
> > 
> > For parsing it would make it easier to have the thing split.
> > 
> > But on DT I feel an enum like it's done here might be more clear.
> > 
> > Assuming the property define the LED polarity, it would make sense
> > to have a single one instead of a sum of boolean.
> > 
> > The boolean idea might be problematic in the future for device that
> > devisates from what we expect.
> > 
> > Example: A device set the LED to active-high by default and we want a
> > way in DT to define active-low. With the boolean idea of having
> > "active-high" and assume active-low if not defined we would have to put
> > active-high in every PHY node (to reflect the default settings)
> > 
> > Having a property instead permits us to support more case.
> > 
> > Ideally on code side we would have an enum that map the string to the
> > different modes and we would pass to a .led_set_polarity the enum.
> > (or if we really want a bitmask)
> > 
> > 
> > If we feel tristate is special enough we can consider leaving that
> > specific to marvell (something like marvell,led-tristate)
> > 
> > But if we notice it's more generic then we will have to keep
> > compatibility for both.
> >   
> > > 
> > > Please work with Christian on this.  
> > 
> > Think since the current idea is to support this in the LED api with set
> > polarity either the 2 series needs to be merged or the polarity part
> > needs to be detached and submitted later until we sort the generic way
> > to set it?
> >  
> 
> Hi Andrew,
> 
> I asked some further info to Tobias. With a better look at the
> Documentation, it was notice that tristate is only to drive the LED off.
> 
> So to drive LED ON:
> - active-low
> - active-high
> 
> And to drive LED OFF:
> - low
> - high
> - tristate
> 
> I feel introducing description to how to drive the LED inactive might be
> too much.
> 
> Would it be ok to have something like
> 
> polarity:
> - "active-low"
> - "active-high"
> 
> And a bool with "marvel,led-inactive-tristate" specific to this PHY?
* marvell

The "tristate" in LED off state means high impendance (or
alternatively: open, Z), see:
  https://en.wikipedia.org/wiki/Three-state_logic

Marvell calling this high impedance state "tristate" is IMO confusing,
since "tristate" means 3 state logic, the three states being:
- connected to high voltage
- connected to low voltage
- not connected to any voltage

I would propose something like
  inactive-hi-z;
or even better
  inactive-high-impedance;

Krzysztof, what do you think?

Marek

