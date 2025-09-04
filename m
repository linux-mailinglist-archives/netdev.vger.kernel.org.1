Return-Path: <netdev+bounces-220049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160FB444A8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAE75A1F01
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4C3126D1;
	Thu,  4 Sep 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTgH44q6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2203126DB;
	Thu,  4 Sep 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008109; cv=none; b=jd1LQKpKRYoSgoVMeLv29xZ6B93omMXFc/zR99VER9cfIIGPMh3CiHau44nzYIJBRcRdKSi7KxjKm8+jVgjI40qQuWiAbeXZldMd8MFjnMQtpsLnnQ9fRXgn3jHtc7zOiat91vrE9zGPFYYhkUGEsB5tZqQX6V0+gS/C7VZLW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008109; c=relaxed/simple;
	bh=GazaQOAjqu3KTGz6/UzSjxl/0+LWmjHWyXJTlu8Pmho=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEjvBjHk2GKP++ePC1TNbu/VJ1nobMfvpvWLr2RZOnF+1pgDGIYdRFIWXSHgMaU4ptAHX8L8hx1mO8OYKs6bSl8V3jsJdKbNWWcwtSsSqmVBCvH/Z4p3fMcK7GdXQ2YOWs3Z5CC0SfCLSeSsu50naPIXts2uXJ+DaD3KfdWHQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTgH44q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3FBC4CEF0;
	Thu,  4 Sep 2025 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757008108;
	bh=GazaQOAjqu3KTGz6/UzSjxl/0+LWmjHWyXJTlu8Pmho=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=KTgH44q6kRssI3eBUq2HNKFNeV6pYISsEr6++lTjAmY7Tqg1LrUgLiwrKfLzvlsz1
	 dZZrTUejvJsTVwA3S4pZiaoEkg6jPwAtY2OloGqL4oJtWsH64+HTiIYMa/ZpBkrBLf
	 Sy4UyCYmK/20aFYGTbRN2lUl4RAKkWZYKohCVN2QEe0S/nDn6+q6UXeJ9YSLEkUFpx
	 eXABNxGe642ucoc9U3XjK70GZiPn+Ywo3eJEJvKtdnPxIOESUgoBU+Yr3GM8oftU8f
	 Th5Np4x3UZfuA6h9/ibpCPGaPGPBAPGoqaLlAa8P+33v5rjD3HLC/nUJIrg1TBnVIG
	 RgT+E+AR5YI1A==
Message-ID: <44898314e457669a80ccb08976813161d8cd9eb1.camel@kernel.org>
Subject: Re: [PATCH v17 00/22] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Date: Thu, 04 Sep 2025 10:48:27 -0700
In-Reply-To: <e74a66db-6067-4f8d-9fb1-fe4f80357899@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	 <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
	 <e74a66db-6067-4f8d-9fb1-fe4f80357899@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alejandro,

Apologies for the late reply.  Totally lost the reply during the US
holiday...

On Thu, 2025-08-28 at 09:02 +0100, Alejandro Lucero Palau wrote:
> Hi PJ,
>=20
> On 8/27/25 17:48, PJ Waskiewicz wrote:
> > On Tue, 2025-06-24 at 15:13 +0100, alejandro.lucero-palau@amd.com
> > wrote:
> >=20
> > Hi Alejandro,
> >=20
> > > From: Alejandro Lucero <alucerop@amd.com>
> > >=20
> > > v17 changes: (Dan Williams review)
> > > =C2=A0=C2=A0- use devm for cxl_dev_state allocation
> > > =C2=A0=C2=A0- using current cxl struct for checking capability regist=
ers
> > > found
> > > by
> > > =C2=A0=C2=A0=C2=A0 the driver.
> > > =C2=A0=C2=A0- simplify dpa initialization without a mailbox not suppo=
rting
> > > pmem
> > > =C2=A0=C2=A0- add cxl_acquire_endpoint for protection during initiali=
zation
> > > =C2=A0=C2=A0- add callback/action to cxl_create_region for a driver
> > > notified
> > > about cxl
> > > =C2=A0=C2=A0=C2=A0 core kernel modules removal.
> > > =C2=A0=C2=A0- add sfc function to disable CXL-based PIO buffers if su=
ch a
> > > callback
> > > =C2=A0=C2=A0=C2=A0 is invoked.
> > > =C2=A0=C2=A0- Always manage a Type2 created region as private not all=
owing
> > > DAX.
> > >=20
> > I've been following the patches here since your initial RFC.=C2=A0 What
> > platform are you testing these on out of curiosity?
>=20
>=20
> Most of the work was done with qemu. Nowadays, I have several system=20
> with CXL support and Type2 BIOS support, so it has been successfully=20
> tested there as well.

I also have a number of systems with Type2 support enabled in the BIOS,
spread between multiple uarch versions of Intel and AMD (EMR/GNR,
Genoa/Turin).

>=20
> > I've tried pulling the v16 patches into my test environment, and on
> > CXL
> > 2.0 hosts that I have access to, the patches did not work when
> > trying
> > to hook up a Type 2 device.=C2=A0 Most of it centered around many of th=
e
> > CXL
> > host registers you try poking not existing.
>=20
>=20
> Can you share the system logs and maybe run it with CXL debugging on?

What system logs are you referring to?  dmesg?  Also what CXL
debugging?  Just enabling the dev_dbg() paths for the CXL modules?

>=20
> > I do have CXL-capable BIOS
> > firmware on these hosts, but I'm questioning that either there's
> > still
> > missing firmware, or the patches are trying to touch something that
> > doesn't exist.
>=20
>=20
> May I ask which system are you using? ARM/Intel/AMD/surpriseme? lspci
> -vvv output would also be useful. I did find some issues with how the
> BIOS we got is doing things, something I will share and work on if
> that=20
> turns out to be a valid case and not a BIOS problem.

I've been lately testing on an Intel GNR and an AMD Turin.  Let's just
say we can focus on the CRB's from both of them, so I have BIOS's
directly from the CPU vendors (there are other OEM vendors in the mix,
same results, but we'll leave them out for now).

We have our Type2 device that successfully links/trains CXL protocols
(all of them), and have been working for some time on previous gen's as
well (SPR/EMR/Genoa).  I can't share the full output of lspci due to
this being a proprietary device, but link caps show the .mem and other
protocols fully linked/trained.  I also have the .mem acceleration
region mapped currently by our drivers directly.

What I'm running into is very early in the driver bringup when
migrating to the new API you have presented with the refactors of the
CXL core.  In my driver's .probe() function (assume this is a pci_dev),
I have the following beginning flow:

- pci_find_dvsec_capability() (returns the correct field pointer)
- cxl_dev_state_create(..., CXL_DEVTYPE_DEVMEM, ...) - succeeds
- cxl_pci_accel_setup_regs() - fails to detect accelerated registers
- cxl_mem_dpa_init()
- cxl_dpa_setup() - returns failure

This is where the wheels have already flown off.  Note that this is
with the V16 patches, so I'm not sure if there was something resolved
between those and the V17 patches.  I'm working right now on geting the
V17 patches running on my Purico Turin box.  But if there's a specific
BIOS I would need to target for the Purico CRB, that would be useful
information to have as well.  My Purico box is running BIOS Revision
5.33.

>=20
> >=20
> > I'm working on rebasing to the v17 patches to see if this resolves
> > what
> > I'm seeing.=C2=A0 But it's a bit of a lift, so I figured I'd ask what
> > you're
> > testing on before burning more time.
> >=20
> > Eventually I'd like to either give a Tested-by or shoot back some
> > amended patches based on testing.=C2=A0 But I've not been able to get
> > that
> > far yet...
>=20
>=20
> That would be really good. Let's see if we can figure out what is the
> problem there.

Sounds like a plan to me.  Thanks for doing the heavy lifting here on
these patches.

Cheers,
-PJ

