Return-Path: <netdev+bounces-52808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012F8800429
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7DA2816C0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847281173E;
	Fri,  1 Dec 2023 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKchjUxM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE191172F;
	Fri,  1 Dec 2023 06:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A04EC433CA;
	Fri,  1 Dec 2023 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701413488;
	bh=kQXX0N9DHac4wzjyMFagAgIKtsFvQDfa4+CaUJ9nQsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oKchjUxMO4ZeSNCNFQcsENqGG2C57VOtaGye4yTBy8D8O1YNMEI6Nsfs3Lrnlx3Jv
	 g+ifoWreBQS//LHF6/8y/RnRmRGq4eJgczq8DmuT5IUtNRM+VztyYxi7AVmXuzKHC7
	 oGElAYKnTYE1xyM+Y6bnhCvoljI0yjhgGPwHQdEjXlccYdqVijw7encBVIA3/bMtAc
	 T8jzMwN0KLPiKSm/Roht8hvPXIp8We3kUuEmxnDETwaxcMU8y2vfAxA9lQ0+ZJ42pO
	 vstS6H2qZ31UvsRk8mEnhZDBVhK17OdcvIfD8ck+FlGcr+hUYPDREAUh1fsHVTVu/L
	 40oiH5CYhUXLw==
Date: Thu, 30 Nov 2023 22:51:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michalik, Michal" <michal.michalik@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
 <jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
 <poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
 <mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Message-ID: <20231130225127.1b56ffca@kernel.org>
In-Reply-To: <CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
	<20231129093951.3be1bd8b@kernel.org>
	<CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 17:46:37 +0000 Michalik, Michal wrote:
> > Did you try to run it in vmtest or virtme-ng?
> > https://www.youtube.com/watch?v=NT-325hgXjY
> > https://lpc.events/event/17/contributions/1506/attachments/1143/2441/virtme-ng.pdf
> > 
> > I'm thinking of using those for continuous testing, curious all 
> > the Python setup works okay with them.  
> 
> Very interesting idea, I didn't try to use those - will get familiar with that and
> see if I can make any improvements to go with vmtest/virtme-ng before I will send
> out the RFC v5.

LMK how it goes. I tried using both today and they work fine if I let
them build the kernel, but if I tried to use my own kernel build they
just hang :(

> > Did you see what the sdsi test does? It seems to assume everything 
> > is installed locally, without the venv. I wonder if that may be simpler
> > to get going with vmtest?  
> 
> To be honest I did not see that. I agree that this is a simpler solution, but I am
> not sure if that is not "too simple". What I mean, I'm not sure who wrote the sdsi
> tests, but maybe they were not aware about the Python best practices? Python used
> to be my first language, and I would vote for using the venvs if you asked me.
> I understand that it haven't been done before, but we are here to try to improve
> the things, yes? 

I think I already asked how long the setup takes but my only concern 
is that the setup will be slower, and less useful during development.

> Of course if you outvote me, I won't act as Tadeusz Rejtan in
> Matejko's painting "The Fall of Poland" and just remove the virtual environments. :)

:D
The infallible strategy of showing a nipple.
https://www.youtube.com/watch?v=lY0V65YWEIA&t=50s

