Return-Path: <netdev+bounces-214727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092FB2B0EF
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA891893CBA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1090273D9A;
	Mon, 18 Aug 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayVDIn+8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E5272E6B;
	Mon, 18 Aug 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543427; cv=none; b=dpHWs/e3j3C1H2Z9Jgp690aO1TPgQpBWyhtv1TNE6Fe7nUKwMjvb0yT1OAS5ZcyZwrOfp0XrJTdRwz+g4BZ5ZmgLIeR0JgglecujsMqKWIQAhvaR8o4JEhy6z4AYDxFK1/db2ahwJrkMc+DaJwnyOMd49MswfztVt87nApT/cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543427; c=relaxed/simple;
	bh=LLrbrlWI1+1Wrpjrc3PeIRE7Z93HYyEAJTPMZ/3akPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHN2pe6xhZurUy1C8w7/pa5GDtFh3XIiIjzUQghLmDlb5mW3sJeVi8y1v0Z+Ri9C6WRgpG6Q185PLixPLaaXxAi1V5UqR8fUlR9318RgYThdcR58wIYcWWnV447FCo4BGEEDoyfkzoITQCQwRLssoGMmgNhqBG4HxCVJC7gUJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayVDIn+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB86C4CEEB;
	Mon, 18 Aug 2025 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755543427;
	bh=LLrbrlWI1+1Wrpjrc3PeIRE7Z93HYyEAJTPMZ/3akPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayVDIn+8U8Wx4EDu34txQp0k4cUvEI7PP0j0IId9lGTOOiHRy6gfy0+DzeATALLY8
	 jTSbQbPNF2xefOSoqneA1b0kFBHRCVNapPVfsbVQEzdlrvh7zVFlMA3GvX4CyPwANC
	 klwjkKeEzA+boXeqgbEyzx2Tt3TM3uOUX/DPs5/P0XDlvo4pUMPgdghgDSofFnAKgz
	 UUdxX76YVQgDB2rGVCLIUQFQ4TJ0SUyq+3wiAg1Osm7lcoByulhsoNb7ZnbbwDUfPT
	 BJZ1ueDbYSGUwQZ3nK6YFm3QY/yE9B/0Ir3H7Q2ZmRc16A5/XDoUGAvBWLcVK/S+eO
	 ozRWNrUGUdxEQ==
Date: Mon, 18 Aug 2025 11:57:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan
 Bell <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 0/5] Add ethernet support for RPi5
Message-ID: <20250818115705.72533d08@kernel.org>
In-Reply-To: <68c3db9d-daf5-40ed-91a7-1d08b9c8cb52@broadcom.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
	<4c454b3c-f62c-4086-a665-282aa2f4a0e1@broadcom.com>
	<20250818115041.71041ad6@kernel.org>
	<68c3db9d-daf5-40ed-91a7-1d08b9c8cb52@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:52:28 -0700 Florian Fainelli wrote:
> On 8/18/25 11:50, Jakub Kicinski wrote:
> > On Mon, 18 Aug 2025 11:02:15 -0700 Florian Fainelli wrote:  
> >> netdev maintainers, do you mind if I take patches 2, 4 and 5 via the
> >> Broadcom ARM SoC tree to avoid generating conflicts down the road? You
> >> can take patches 1 and 3. Thanks  
> > 
> > 4, 5 make perfect sense, why patch 2? We usually take bindings.  
> 
> Because that way when CI runs against the ARM SoC tree, we don't get 
> errors that the bindings are undocumented.

Hm, my understanding is that validation should use bindings from
linux-next.. tho I'm not 100% sure. Perhaps DT maintainers can
clarify. This problem exists for all DT changes, unless there's
something exceptional about the patches I'd rather follow the default
process.

