Return-Path: <netdev+bounces-220502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A18B46717
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3655A8306
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6327FD64;
	Fri,  5 Sep 2025 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJYzVH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD837274FEF;
	Fri,  5 Sep 2025 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114639; cv=none; b=uKCJoAq50z+GOchmhVgYZusVfPX48Ti7etuNbL657nzT4mN5KkQec0K8qNwqDnAgrQ/B2Xc8yT5mgqKIWMZFijdgDmFwbVljZApHeE4F00go8uPmd4j/X8LGoMzrD6SDTGpWl1Yi5T5XR0jHBINW5Wep2VxbgA8x2cxJI9SPJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114639; c=relaxed/simple;
	bh=Gs+74QQ3pqE8Dw+3XkxxysoR+QZSz4q7BtqI4TR0BjU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjqy7FgAhi11QhmBsgHNFRron9bvK/diWAcb5uDWOZ69jy9l8FEJ7PkecpN2kkpct90xqSXeG8gvyfsPDa2rpItPzIVC59B/Zi6WEwet9TUy2nj8g8Gc5iywqH3fSgruminL98fVD0KqE622GawTMFmJNh7BGgqCFHuO2LGdpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJYzVH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA874C4CEF1;
	Fri,  5 Sep 2025 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114638;
	bh=Gs+74QQ3pqE8Dw+3XkxxysoR+QZSz4q7BtqI4TR0BjU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JsJYzVH/xYMRQ7jUll8U+lQ7ZLVhKAhyDl7pmuSH8AmqTE5lkxK6xEyj4QUNckwJx
	 sU5EZq75rMtNIFwdLXL4+GQXbGaf8ohLXQ1tLDG7TLvFuepN5ORi+eGayw4ySZRCFC
	 gn3Mzj+ifh0sNQ5x5oBULM7I7mPOoArN1TkjT3idjMdqqn0BMn6o9iAgVlCBoEMhTq
	 ztE1D+n3w1Y3LZcQQsReboG2+eIk1j+x3ln9z/bOwCrQsJBNgXkgW2fxVBlOdxc3xj
	 EmRl7a7YzVSl1fs8n2N4tpe3ogRtAo0xgn+mXSmSvdhZWVPhyWeCXwNWpMkdpu5G3w
	 S9NYAY0wSWntw==
Message-ID: <1aab20e65ba961d786813bb135f9edfc0cb6db0a.camel@kernel.org>
Subject: Re: [PATCH v17 00/22] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Date: Fri, 05 Sep 2025 16:23:50 -0700
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

A bit more info for the weekend to digest.

On my AMD Purico CRB, it looks like I may be missing pieces of the ACPI
tables in the BIOS.  I'm going to shift to a GNR that is pretty healthy
and keep hacking away.  But this is what I'm seeing now that I ported
everything over to these V17 patches.

- devm_cxl_dev_state_create() - succeeds

- cxl_pci_set_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxl-
>cxlds.reg_map): this is where things go wrong.  I get -ENODEV
returned.  I'm digging into the BIOS settings, but this is the same
place I landed on with the V16 patches.  The device is fully trained on
all protocols.

Hope this rings a bell where to look.

Cheers,
-PJ

