Return-Path: <netdev+bounces-188711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96FAAE4D2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148123BAB60
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BE28BAB7;
	Wed,  7 May 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPplaysz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180228B3FE;
	Wed,  7 May 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631575; cv=none; b=gVQFKKIRzJCDlooTGSKdNxzcnPoLgmY8yKN4Co3zxLFYsGmKMWmPj3cSyWJBt+vESMnYI8L7aUJuvBe6FF15DbXNywBFtC0a4RCFMYwrL+FuAaSovfYRqp41yOCeNEOV2lvNt3VTbB0tyjgrpsoRwyJpDSCljZWJj8ZrMkSq3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631575; c=relaxed/simple;
	bh=slVt5lIKJTnZi3bMfiTdllvE+A/QE0g4pjjhSkT/YcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8mouej3hX77F582lgM4efVeXW9WXONYzXLX+56kYGuL3SIlb3+VwMhBBaH8R88t73GnR6LxQvoRJzR7wXIaqLrFMQYA53NjIokKHh3au+s9PIgFJs//Mq0DjuOLPG6cDnPwxfc6kOPzgEfl8X0SU0eCm1HCdUb70e4OI2m2CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPplaysz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC3FC4CEE2;
	Wed,  7 May 2025 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746631575;
	bh=slVt5lIKJTnZi3bMfiTdllvE+A/QE0g4pjjhSkT/YcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPplaysznrNxewK4xJFXoM6FH/opMrnXUuyDlpJUQrchZDSjl+lmLHkIzGTI2aw5q
	 5SzfCCD+9kN008ozTvtXZKxVmrOJzVrhPw9ow8PcP8a46YtFe9lKgR35VHj61VIdrj
	 e3CwVVoH6BhjptX7AYMSFzx02/OQQ98ujl+kCP/d5X/m3dk3WkNTZ21HhPhnE3uRBs
	 34kTOKppM/jlAg5mVFWuNRX7DfS29sxRUWLDx5h/IRS416wfEo5KdLYleSN08qYLWD
	 NQvyPf7iYyjw7LwoBDtxCwjsFYeF6+k0PS/vWldDW2pLZ35yCtYZyNngFJQl3KT5Xc
	 308dbhYb3NAyg==
Date: Wed, 7 May 2025 16:26:09 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250507152609.GK3865826@google.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBt1N6TcSckYj23A@smile.fi.intel.com>

On Wed, 07 May 2025, Andy Shevchenko wrote:

> On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
> > On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> > > On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
> 
> ...
> 
> > > > +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > > > +       { .channel = 0, },
> > > > +       { .channel = 1, },
> > > > +       { .channel = 2, },
> > > > +       { .channel = 3, },
> > > > +       { .channel = 4, },
> > > > +};
> > > 
> > > > +static const struct mfd_cell zl3073x_devs[] = {
> > > > +       ZL3073X_CELL("zl3073x-dpll", 0),
> > > > +       ZL3073X_CELL("zl3073x-dpll", 1),
> > > > +       ZL3073X_CELL("zl3073x-dpll", 2),
> > > > +       ZL3073X_CELL("zl3073x-dpll", 3),
> > > > +       ZL3073X_CELL("zl3073x-dpll", 4),
> > > > +};
> > > 
> > > > +#define ZL3073X_MAX_CHANNELS   5
> > > 
> > > Btw, wouldn't be better to keep the above lists synchronised like
> > > 
> > > 1. Make ZL3073X_CELL() to use indexed variant
> > > 
> > > [idx] = ...
> > > 
> > > 2. Define the channel numbers
> > > 
> > > and use them in both data structures.
> > > 
> > > ...
> > 
> > WDYM?
> > 
> > > OTOH, I'm not sure why we even need this. If this is going to be
> > > sequential, can't we make a core to decide which cell will be given
> > > which id?
> > 
> > Just a note that after introduction of PHC sub-driver the array will look
> > like:
> > static const struct mfd_cell zl3073x_devs[] = {
> >        ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
> >        ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
> >        ZL3073X_CELL("zl3073x-dpll", 1),  // ...
> >        ZL3073X_CELL("zl3073x-phc", 1),
> >        ZL3073X_CELL("zl3073x-dpll", 2),
> >        ZL3073X_CELL("zl3073x-phc", 2),
> >        ZL3073X_CELL("zl3073x-dpll", 3),
> >        ZL3073X_CELL("zl3073x-phc", 3),
> >        ZL3073X_CELL("zl3073x-dpll", 4),
> >        ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
> > };
> 
> Ah, this is very important piece. Then I mean only this kind of change
> 
> enum {
> 	// this or whatever meaningful names
> 	..._CH_0	0
> 	..._CH_1	1
> 	...
> };
> 
> static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>        { .channel = ..._CH_0, },
>        ...
> };
> 
> static const struct mfd_cell zl3073x_devs[] = {
>        ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
>        ZL3073X_CELL("zl3073x-phc", ..._CH_0),
>        ...
> };

This is getting hectic.  All for a sequential enumeration.  Seeing as
there are no other differentiations, why not use IDA in the child
instead?

-- 
Lee Jones [李琼斯]

