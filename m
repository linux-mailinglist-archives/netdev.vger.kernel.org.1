Return-Path: <netdev+bounces-45720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01B7DF330
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DD81C20E82
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD5A7498;
	Thu,  2 Nov 2023 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="axIh+OQs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13946FBE;
	Thu,  2 Nov 2023 13:04:54 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6067E193;
	Thu,  2 Nov 2023 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lhnHvgPTUerCavcKvy4VoFNn9k17Ymmjx4Tbd3bshik=;
	t=1698930289; x=1700139889; b=axIh+OQs/8lt1/eCYxHEd6sdY68CsoLKtnX3H8kQwIL2R9T
	zrcHkoQiiL6mQPu8UReBO+NoXxOSaafybY8xtaCYh2PIlqJtOHavjMqBB/WFNzlyFVWTJDvKYqz6H
	ZnpD8tIKRq69VUxxGGwxF6EQI06974EwMFdxkTVPCvro3Ksfsav0Nmq/Z9DFqQkl0Gwj4R/OT1nkd
	ThcikbeZ6oRrjaof0DHOmaonV/KtEVxVHtQ7GuRhUWrxw1youZF98Gd+VcYRJ1ir7Ar5DEhu1lVJs
	WGfYlaDWfTtJokAS8YbUfi4qADPzC+rrH5y5ttw/y8JL3+h3BxAxfEtUP9oWj8LA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qyXNL-0000000BJWz-3w9i;
	Thu, 02 Nov 2023 14:04:44 +0100
Message-ID: <d0d35561b80b873d9f78c9ca4ad304b6e0f16cb2.camel@sipsolutions.net>
Subject: Re: [Patch v13 4/9] wifi: mac80211: Add support for WBRF features
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 lenb@kernel.org,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,  alexander.deucher@amd.com,
 Lijo.Lazar@amd.com, mario.limonciello@amd.com, Netdev
 <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, majun@amd.com, Evan Quan
 <quanliangl@hotmail.com>
Date: Thu, 02 Nov 2023 14:04:42 +0100
In-Reply-To: <e42c5484-d66-e41a-8b2e-a1fa4495ce2@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
	  <20231030071832.2217118-5-Jun.Ma2@amd.com>
	  <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
	 <b080757463a1f55a38484e3ea39fd3697e98409e.camel@sipsolutions.net>
	 <e42c5484-d66-e41a-8b2e-a1fa4495ce2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-02 at 14:24 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 2 Nov 2023, Johannes Berg wrote:
> > On Thu, 2023-11-02 at 13:55 +0200, Ilpo J=C3=A4rvinen wrote:
> >=20
> > > > +static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth,=
 u64 *start, u64 *end)
> > > > +{
> > > > +	bandwidth =3D MHZ_TO_KHZ(bandwidth);
> > > > +	center_freq =3D MHZ_TO_KHZ(center_freq);
> > >=20
> > > Please use include/linux/units.h ones for these too.
> >=20
> > Now we're feature creeping though - this has existed for *years* in the
> > wireless stack with many instances? We can convert them over, I guess,
> > but not sure that makes much sense here - we'd want to add such macros
> > to units.h, but ... moving them can be independent of this patch?
>=20
> What new macros you're talking about?=C2=A0

Sorry, I got confused - for some reason I was pretty sure something here
was already being added to units.h in this patchset.

> Nothing new needs to be added=20
> as there's already KHZ_PER_MHZ so these would just be:
>=20
> 	bandwidth *=3D KHZ_PER_MHZ;
> 	center_freq *=3D KHZ_PER_MHZ;

Sure, and in this case that's probably pretty much equivalent. But
having a MHZ_TO_KHZ() macro isn't inherently *bad*, and I'm not sure
you're objection to it on anything other than "it's not defined in
units.h".

> Everything can of course be postponed by the argument that some=20
> subsystem specific mechanism has been there before the generic one
> but the end of that road won't be pretty... What I was trying to do
> here was to point out the new stuff introduced by this series into the=
=20
> direction of the generic thing.

I just think that the better course of action would be to eventually
move MHZ_TO_KHZ() to units.h ...

johannes

