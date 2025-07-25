Return-Path: <netdev+bounces-209969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DEBB1192F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ECA1C82ED5
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE462BD5BB;
	Fri, 25 Jul 2025 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF3OAXrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCF2BD59B;
	Fri, 25 Jul 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428602; cv=none; b=Uon+oFDBy89wSaG5Cx3ELyuDCVuDu2nFtlmqfGHo2IdoLgG2ca2Q6RNRY5irU3oUIAkxbfxtAe5RIF/7giXaelKMBqx02BI9aOkvK92ULcQHdw9WrI+ThvvPtGt6reYUy1PD9xxNABUeyZ5rNWk8sT3LCpoQswxBiKgOXQmeoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428602; c=relaxed/simple;
	bh=VsBUVIq/j+r7AHbQ4ytPSRI1voy8+67A4EX8tCplsAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOz4Oro78UH8s4BUANM78KgTpuNOS/DyyDnx6sO9ATHjRUbk/k8zIYPW+gcsLM8keGZBlVpD4vhwtVTTk12EpaVGc2jdwmgpgyjFFNx5XtCBQzOi5nMyhjUXdI+/SUhEDJMzkTFNAyKyiZsDJSWry9x1SVxcssw5v7nVD6YS3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF3OAXrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71E3C4CEE7;
	Fri, 25 Jul 2025 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753428602;
	bh=VsBUVIq/j+r7AHbQ4ytPSRI1voy8+67A4EX8tCplsAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uF3OAXrhjTurG/QT8dpeU7/K2QQM3EpzbggdyjfaomTXEbXChflQHD3scmNhrTZeO
	 cRTeRCq6xKGtizCzR+OEfr1fN2gr9ugSmY9hz+IFaEJCA1FQTsKEu6i2Rha74pc7+k
	 VgJJvOKZXZapWxIqIizDBy7A85Mqz+pMkGEmnB62nXTT6xvEh1nMzlFlGWxnVZJ8KS
	 RYISKevmUgrwox4gNcEPblZAjYhWdr+mTfiNZeuqNQcIXgFCtgVikTQN3jrwQnQkOL
	 orJuWcai5U2TgDkL1KQ26vhyS0MT0LFBQJ31ZUZEyd5ONRvvGzfCIgPY1+sM/PWtQi
	 6vkBA7fjXBCHg==
Date: Fri, 25 Jul 2025 08:29:56 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250725072956.GH1266901@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250723162158.GJ1036606@horms.kernel.org>
 <DM3PR11MB87369E36CA76C1BB7C78CEB7EC5EA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250724213556.GG1266901@horms.kernel.org>
 <DM3PR11MB87360DB5CDD47DF4A64FC33BEC59A@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87360DB5CDD47DF4A64FC33BEC59A@DM3PR11MB8736.namprd11.prod.outlook.com>

On Fri, Jul 25, 2025 at 12:17:26AM +0000, Tristram.Ha@microchip.com wrote:
> > On Thu, Jul 24, 2025 at 02:28:56AM +0000, Tristram.Ha@microchip.com wrote:
> > > > On Wed, Jul 23, 2025 at 02:25:27AM +0000, Tristram.Ha@microchip.com wrote:
> > > > > > On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > > > > > > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com
> > wrote:

...

> > I feel that we are talking past each other.
> > Let's try to find a common understanding.
> 
> It is really about the register definition of this specific register.
> In KSZ8863 when presenting in 16-bit the value is 0x07ff, but in KSZ8463
> it is 0xff07.  It is the fault of the hardware to define such value.

If the behaviour of this register is different to others, then I guess a
special case is a reasonable approach. Although I would have thought there
is a better way.

I would suggest adding a comment to the code explaining that this is a
special case. And I would suggest revisiting this if more special cases are
needed.

> Note that in the new patch KSZ8463 SPI driver implements its own access
> functions, so native mode is used instead and there is no automatic
> swapping depending on the big-endian or little-endian format.  Still this
> code is needed to program the register correctly.

Thanks for taking time to respond to my questions.
I think we should let the matter rest here.

