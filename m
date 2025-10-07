Return-Path: <netdev+bounces-228140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA07BC2BC8
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 23:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BED3E189C
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52B24A05D;
	Tue,  7 Oct 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfQCO01r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC8242D99;
	Tue,  7 Oct 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872218; cv=none; b=hcK3wkMK8BPOrIxjPVe1ckZ/DI7Ep8VUlAJVyOEozUTOoB15q2Wyp0VgnjIgGCN9XycMYAiFnBxZcI58Sda/Qnut1nmx5ZmGOzHRfXujNROete3BWCantuhw8W1rwVFh6ss5zdwMX/BBGcnsrU71zufLoAjjflsrM2k9bp1J1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872218; c=relaxed/simple;
	bh=mi3ukmsDreQW6QtPVmfcB9hZ4nEwi6gs50v8k6LA0xc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmmXFxLD6mx7CT2xBzq328ZK6jxTyNCVEhfc/XICRafMDUVL8TfR3/ShSC/JVyGP0r1TVCAJ2QtKVNXriRoNzovCKS9MQjS0/qnS8NA0hnoFVk1CxHdOqvFmqweRtIiX+xM9zuueQwsuCCjxsNb1uboHmF/ykHly0mTke5b5qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfQCO01r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7CC4CEF1;
	Tue,  7 Oct 2025 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759872217;
	bh=mi3ukmsDreQW6QtPVmfcB9hZ4nEwi6gs50v8k6LA0xc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DfQCO01rwuvusRjxD6gPGdIFFOgfvIQNzbYnq+B5rD/TRyyX3HUD3PHxUaF0eCpKV
	 ggcmCs5jyU9AqgnBHJ0C54ublNNXPBRy5FVvhKNrT0EIlcLqd1zI1HshxTTJGNWmD8
	 AreOhaxWDiXfgmkdSfPyzOvNodCqzkwkVZ6el75qFbcnQRzhRGCp4K2Z4thMjG94mj
	 Ts5FvDwMUCD9OF8iZMwu6gR63ODoDDtygsombtrLfaN3sUz4gQgh75aF4peilfamMY
	 Bo690zczj3rD2JtA3zEYT36FLaCTuP3bh4UtrLcj58iUEMpWmRG90MzSTUHPxTT8PJ
	 JTkAl/LwUFucA==
Message-ID: <efcc7c09e0edcbb9479963c09a636b25c410e0f0.camel@kernel.org>
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 07 Oct 2025 14:23:36 -0700
In-Reply-To: <36fdebc2-b987-40ee-abf0-624b55768e3c@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
	 <8b6d2a9dfafe1cbf4311efe157f50e8f21702d04.camel@kernel.org>
	 <36fdebc2-b987-40ee-abf0-624b55768e3c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 10:36 +0100, Alejandro Lucero Palau wrote:
>=20
>=20
> > > +	if (!cxl->cxlds.reg_map.component_map.ras.valid)
> > > +		return dev_err_probe(&pci_dev->dev, -ENODEV,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Expected RAS component
> > > register not found\n");
> > > +
> > > +	rc =3D cxl_map_component_regs(&cxl->cxlds.reg_map,
> > > +				=C2=A0=C2=A0=C2=A0 &cxl->cxlds.regs.component,
> > > +				=C2=A0=C2=A0=C2=A0 BIT(CXL_CM_CAP_CAP_ID_RAS));
> > > +	if (rc) {
> > > +		dev_err(&pci_dev->dev, "Failed to map RAS
> > > capability.\n");
> > > +		return rc;
> > > +	}
> > I've finally made some serious headway integrating v17 into my
> > environment to better comment on this flow.
> >=20
> > I'm running into what I'm seeing as a fundamental issue of resource
> > ownership between a device driver, and the CXL driver core.=C2=A0 I'm
> > having
> > a hard time trying to resolve this.
> >=20
> > If I do the above and call cxl_map_component_regs() with a valid
> > CAP_ID
> > (RAS, HDM, etc.), that eventually calls devm_cxl_iomap_block() from
> > inside the CXL core drivers.=C2=A0 That calls devm_request_mem_region()=
,
> > and
> > this is where things get interesting.
> >=20
> > If my device happens to land the CXL component registers inside of
> > a
> > BAR that has other items needed by my Type 2 device's driver, then
> > we
> > have a conflict.=C2=A0 My driver and the CXL core drivers cannot hold
> > the
> > same regions mapped.=C2=A0 i.e. I can't call pci_request_region() on my
> > BAR,
> > and then call the above.=C2=A0 One loses, and then we all lose.
> >=20
> > Curious if you have any ideas how we can improve this?
>=20
>=20
> I ran into this issue early in my development when working with=20
> emulation, and I had to share the mapping somehow.
>=20
>=20
> It went away with newer more real emulation so I had to no worry
> about=20
> it anymore. But yes, the problem does exist. I can not find my old
> code=20
> but I guess the solution is to pass a pointer to the already mapped=20
> region implying the mapping is not required. It requires changes to
> the=20
> cxl core but it should not be too much work.

This is a real issue in the API that has implications on hardware
design for people building endpoint devices.

Previously, the CXL core owned the whole thing.  Here, a "normal"
driver that would call something like pci_request_region() on the BAR
now can't do that.  Or, like you said, the API to the kernel would need
to have some way of taking an existing mapping.  But I don't think
that's what we want to do here.

The flow I'm seeing is the driver will start, create the memdev state,
and begin hooking everything up.  Once the memdev is "added," then the
endpoint will start its probe() on the new device.  This goes into the
outstanding issue of the EPROBE_DEFER problems with the endpoint device
not ready when the type 2 driver may try poking at it.

In order for that probe() to succeed for the endpoint, it needs to map
and own that memory region that the CXL regs belong to.  I don't see
any clean path that doesn't involve separating these memory regions
apart.

So I see either:

- An endpoint device's hardware design will need to put the CXL regs
onto a BAR that the endpoint's driver won't need to try and map/own
(big ask of HW vendors)

OR:

- An endpoint device lands the CXL regs on either side of an existing
BAR (front or back) and the endpoint's driver manually maps the portion
of the BAR minus the CXL regs.  And then that should "just work" if you
manually handle what pci_request_region() would do, just at a more
granular level.

If there's a third option I'm not seeing, I'm all ears!

-PJ

