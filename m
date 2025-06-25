Return-Path: <netdev+bounces-201315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D832AE8F7A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0694A809B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A892DCBE0;
	Wed, 25 Jun 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2wN1DZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AC2DAFC1
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883147; cv=none; b=OWhFKy3L8qg4keZKc/fdlUYouMjykxcGuQzA8ma55XhyPQ2/h4TRGOtg00ilccPNUCLONYNPrbRV627I32g6X0U0eDJJmcJx0GkPoelcu0Mo+75qbmV0WeMpql2DJMIMpPC3JtoS0yVFZ5jYNJNzkgxTt4+IkccxRX2gXHTPIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883147; c=relaxed/simple;
	bh=ylxCpTUuN7sOcpqB+lMQrdkoP/CMdeKpEQdi2hpMpHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhJDLmpasNMOfYsATfX2qAbaQhorKCJ8wLkRVGH0mDQ72x44Zo/P3e59ydd94jqGDNyGyafr3PuZ8f2zp8H+GORyUpBiI2gk7/WLHEykJjPAamCYJrev4AqLyDwwg9VEo4jCaA2OoMStzfPKE2T6lHL6NW0x+pbx+Svpo+ImQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2wN1DZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B6C4CEEA;
	Wed, 25 Jun 2025 20:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883147;
	bh=ylxCpTUuN7sOcpqB+lMQrdkoP/CMdeKpEQdi2hpMpHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2wN1DZD03yG5kovQ3urG3qKoSG7fdnUM01iTOIvpQgmmV1mnIUFEuIoO6pwZd8Fr
	 br/6jjkLQuj1J6OB4nnqwJrD9M8ArNJuYGVfIAGQdu5GNQHbZHp4jaiwyFg7UvB8kw
	 14+1xPoZZZAKrgIlHzSlGy9OCX2hxaAkprM4VWMdDMRVC9ewvnHh/y/jVn/cxFPo2S
	 6cXF3abnhLdz5rD/Z3klTpIW5cgyOwgVWN06BLJOkWI9FIbZLLDARp6tZKWJ+Mb+NP
	 yUZfze1cRDizeNmyF+drEb7Qpfnn4C3h3tttlQb64Ptfe8y2VzDBXQs7NqX29YzWRI
	 mASN6oMOrziEQ==
Date: Wed, 25 Jun 2025 13:25:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Damato, Joe"
 <jdamato@fastly.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, "Czapnik, Lukasz"
 <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, "Zaki,
 Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Igor
 Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, Zdenek
 Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
Message-ID: <20250625132545.1772c6ab@kernel.org>
In-Reply-To: <CAK8fFZ7LREBEdhXjBAKuaqktOz1VwsBTxcCpLBsa+dkMj4Pyyw@mail.gmail.com>
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
	<4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
	<20250415175359.3c6117c9@kernel.org>
	<CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
	<20250416064852.39fd4b8f@kernel.org>
	<CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
	<CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
	<20250416171311.30b76ec1@kernel.org>
	<CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
	<CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
	<CAK8fFZ4BJ-T40eNzO1rDLLpSRkeaHGctATsGLKD3bqVCa4RFEQ@mail.gmail.com>
	<CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
	<b3eb99da-9293-43e8-a24d-f4082f747d6c@intel.com>
	<CAK8fFZ7LREBEdhXjBAKuaqktOz1VwsBTxcCpLBsa+dkMj4Pyyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jun 2025 19:51:08 +0200 Jaroslav Pulchart wrote:
> Great, please send me a link to the related patch set. I can apply them in
> our kernel build and try them ASAP!

Sorry if I'm repeating the question - have you tried
CONFIG_MEM_ALLOC_PROFILING? Reportedly the overhead in recent kernels=20
is low enough to use it for production workloads.

> st 25. 6. 2025 v 16:03 odes=C3=ADlatel Przemek Kitszel <
> przemyslaw.kitszel@intel.com> napsal: =20
>=20
> > On 6/25/25 14:17, Jaroslav Pulchart wrote: =20
> > > Hello
> > >
> > > We are still facing the memory issue with Intel 810 NICs (even on lat=
est
> > > 6.15.y).
> > >
> > > Our current stabilization and solution is to move everything to a new
> > > INTEL-FREE server and get rid of last Intel sights there (after Intel=
's
> > > CPU vulnerabilities fuckups NICs are next step).
> > >
> > > Any help welcomed,
> > > Jaroslav P.
> > >
> > > =20
> >
> > Thank you for urging us, I can understand the frustration.
> >
> > We have identified some (unrelated) memory leaks, will soon ship fixes.
> > And, as there were no clear issue with any commit/version you have
> > posted to be a culprit, there is a chance that our random findings could
> > help. Anyway going to zero kmemleak reports is good in itself, that is
> > a good start.
> >
> > Will ask my VAL too to increase efforts in this area too.


