Return-Path: <netdev+bounces-240677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C308DC77985
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F23F4E3A12
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0A32FA2F;
	Fri, 21 Nov 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyfAeaz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300F2F5487;
	Fri, 21 Nov 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707278; cv=none; b=PYFwC8wWFfNr+0K1NMX+Vawwxvx/IjWfISD/vccNRkRkw2UNlhlP4A8u+wYj2bb5IzXcsm/7OmXrIwaPX0NDJEtDFuOp36jJ88jfb0x5QFpQzXr4H3nfdRDW3thJnBHnmlOyTXL57CldZerrRES2Q2o3YS09j5LUkqCJlPhIwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707278; c=relaxed/simple;
	bh=uYFvjqEc51Mdt5o+/a/tTRDyKKIcuwZGwngRMwPgH44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gENaVoPrNf5+HywkMyKnv/6XQLLDML1J0hKyBTv1gc+ur7ZTjSzVka6Z9B+labfavCg/Ih84rM4RnRt+ufaDo3D1BUoOfso+Vl6Va5J0XcSLV47A6tLwK8YoZkmlYg5MiO3ev98SvKDPTPTRLiZxPEeRGc8yaO2y52v5BLpzIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyfAeaz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088A7C4CEF1;
	Fri, 21 Nov 2025 06:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763707278;
	bh=uYFvjqEc51Mdt5o+/a/tTRDyKKIcuwZGwngRMwPgH44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gyfAeaz258kV8f9IQSLueORrn2WaBhy+kOxZ7BTgdJaFN1iUPuEUoy10gXY1U8Sh9
	 7Bg8SqVE2DAyIVCPnOxgCgAQbubRJsKvb7vBdfgmKtLCEmEZqmqVOhwd484glRu9d+
	 4cDyxSMgZa4p7duJccGM7Ut/5leZHNZHPHSFbRRoJb9ImbLzRYH63sRNH3W1r8kC1B
	 h0vhdnoJ8O5b9gUVmIpD719srxJvOiZHJV2VyZ585hNTimZs4GQcvxkDRxgcvLACG9
	 SxCSM3wLqw7G8796FoFKC9UlE7EhwAriikgcceTSt3TojAJsIE8qxAcY0DF81DjFDI
	 KBpK5nyPoktFg==
Message-ID: <e3d376c8a1ac1ee9b75d02f78bdc25f7c556bb20.camel@kernel.org>
Subject: Re: [PATCH v21 00/23] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Date: Thu, 20 Nov 2025 22:41:17 -0800
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
wrote:

Hi Alejandro,

Sorry it's been a bit since I've been able to comment.  I've been
trying to test these patchsets with varying degrees of success.  Still
haven't gotten things up and running fully.  One comment below.

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> The patchset should be applied on the described base commit then
> applying
> Terry's v13 about CXL error handling. The first 4 patches come from
> Dan's
> for-6.18/cxl-probe-order branch with minor modifications.
>=20
> v21 changes;
>=20
> =C2=A0 patch1-2: v20 patch1 splitted up doing the code move in the second
> 	=C2=A0=C2=A0=C2=A0 patch in v21. (Jonathan)
> =C2=A0
> =C2=A0 patch1-4: adding my Signed-off tag along with Dan's
>=20
> =C2=A0 patch5: fix duplication of CXL_NR_PARTITION definition
>=20
> =C2=A0 patch7: dropped the cxl test fixes removing unused function. It wa=
s
> 	=C2=A0 sent independently ahead of this version.
>=20
> =C2=A0 patch12: optimization for max free space calculation (Jonathan)
>=20
> =C2=A0 patch19: optimization for returning on error (Jonathan)

I cannot test these v21 patches or the v20 patches for the same reason.
I suspect v19 is also affected, but I was stuck on v17 for awhile (b4
was really not likely the prereq patches you required to get the tree
into a usable state to apply your patchset).

When I build and go to install the kernel mods, depmod fails:

DEPMOD  /lib/modules/6.18.0-rc6+
depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_port ->
cxl_core
depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_core
depmod: ERROR: Found 3 modules in dependency cycles!

I repro'd this on a few different systems, and just finally repro'd
this on a box outside of my work network.

This is unusable unfortunately, so I can't test this if I wanted to.

My .config for CXL:


CONFIG_PCIEAER_CXL=3Dy
CONFIG_CXL_BUS=3Dm
CONFIG_CXL_PCI=3Dy
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=3Dm
CONFIG_CXL_PMEM=3Dm
CONFIG_CXL_MEM=3Dm
CONFIG_CXL_FEATURES=3Dy
# CONFIG_CXL_EDAC_MEM_FEATURES is not set
CONFIG_CXL_PORT=3Dm
CONFIG_CXL_SUSPEND=3Dy
CONFIG_CXL_REGION=3Dy
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
CONFIG_CXL_RAS=3Dy
CONFIG_CXL_RCH_RAS=3Dy
CONFIG_CXL_PMU=3Dm
CONFIG_DEV_DAX_CXL=3Dm

Pretty simple to repro.

$ make -j<N> && make modules && make modules_install

Hopefully there's a solution here that doesn't involve building the
whole mess into the kernel directly.

Cheers,
-PJ

