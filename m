Return-Path: <netdev+bounces-242623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF41C9309E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48FEF34A9A9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37E2EA174;
	Fri, 28 Nov 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2Cc61u4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C327587E;
	Fri, 28 Nov 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359084; cv=none; b=Nfl+YVLlf0nbKWOfynlW+Lv6I5CL4J8NiOddIAt+l1qmz0u3iaboS12I/7mmjeacnU6PoXI7JOfDTgbmeIOxopIVmkqS++0q6ITWp4xNId/zytOdLve1xjrnIeiv59RyGgBGrq91dmaT1hCLHfQeSKCW88bfYa4W7MP/eLsaNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359084; c=relaxed/simple;
	bh=+W2+lwge+T0AwB64j6pBgpy5FGDdFXNCCRIPRNPhf8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2liv0hQKg+Ra3LvG2EL4cguZ2vOSiiNYVH4P5tfeBtGU2SSUzYgIlIsfuRNrxEO6TpANGWRullwX0AmdLkDeWYchiRULUIpFSf2Wy80ROpR+qFTx7oN66sbVPiooX0rpuA5RXwyxFTjYqbbs/NRCfhJMWtnEsdIC2CBjjMx6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2Cc61u4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40620C4CEF1;
	Fri, 28 Nov 2025 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764359083;
	bh=+W2+lwge+T0AwB64j6pBgpy5FGDdFXNCCRIPRNPhf8A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s2Cc61u4CM6/EVhcihupO2zBOCGGHJ4XDyThD7UbFdMlBrKKHm+pLGs/2s+1t7KyK
	 k21f4+yjJGyfcknwHSCHDRnMRHfcouVbN8J7BBlLDCykR1XuldYr/3ZEMSUl9lTEfP
	 +5waZV2vUjTA0SEpkscdIxm73lcnA0j0kLZM30ojPyFIwq9sUqzZJFmac+Vi+IUgbF
	 YVpYEC96fYJl3JmHuinBBE4GYJCsF8+TkznP08H9x9EeIce5eiMLGYrBYrHMQeQbah
	 yP6KLZHeliXxBzFZjkxDmBjEFee2vpp3KYclNxWkoG5A6HH4FqeRq4msF0nAYoexl4
	 nYyU2qa5WdvHw==
Message-ID: <31dae6910b0863dee44069d01a909f8ed0b19bb2.camel@kernel.org>
Subject: Re: [PATCH v21 00/23] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Date: Fri, 28 Nov 2025 11:44:42 -0800
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

Hi Alejandro,

On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
wrote:
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
>=20

So I'm unable to get these patches working with a Type2 device that
just needs its existing resources auto-discovered by the CXL core.=20
These patches are assuming the underlying device will require full
setup and allocations for DPA and HPA.  I'd argue that a true Type2
device will not be doing that today with existing BIOS implementations.

I've tested this behavior on both Intel and AMD platforms (GNR and
Turin), and they're behaving the same way.  Both will train up the
Type2 device, see there's an advertised CXL.mem region marked EFI
Special Purpose memory, and will map it and program the decoders.=20
These patches partially see those decoders are already programmed, but
does not bypass that fact, and still attemps to dynamically allocate,
configure, and commit, the whole flow.  This assumption fails the init
path.

I think there needs to be a bit of a re-think here.  I briefly chatted
with Dan offline about this, and we do think a different approach is
likely needed.  The current CXL core for Type3 devices can handle when
the BIOS/platform firmware already discovers and maps resources, so we
should be able to do that for this case.

If you're going to be at Plumbers in a week or so, this would be a
great topic if we could grab a whiteboard somewhere and just hack on
it.  Otherwise we can also chat on the Discord (I just joined finally).

Cheers,
-PJ

