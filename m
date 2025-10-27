Return-Path: <netdev+bounces-233097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07118C0C2E5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84583BB463
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384972E36EC;
	Mon, 27 Oct 2025 07:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA632E2F0D;
	Mon, 27 Oct 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551388; cv=none; b=TK3LPyXZnDT4TSmQEhfyuVxdqgSOpYlWj2oD0tUhIDkxX0UyoRNvCwazLmckyfglrRgSn25zoRs6m66TcJE7wAMKDHfWb5FwKYQaX53r9XRH76KS6pVHfyQLj9BizqBNtSm7I9hKva7v9E8oA9iue5+zx5BtAqJyqWHy0NO2c+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551388; c=relaxed/simple;
	bh=CR1G9JPLl55SGn6CId9yfrnLZjKtbAk2nkRFfS5BcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m70idlBniN6N3z0zzK2YX9MmZMVX0V/EnX2rOZNghEjTCuqQ1H2h2kM1M8tiGL0L50IE0xr7IukdbHTwkg2htC9XDMUhq9CAxMjFTIOcHa+VBKUgcLXt8Yut299NvmbjQRw0HYAfo69Yms5Hk8UNbNltO8BejIts7WnS85SjOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300c597473De00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9747:3de0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5C197FA130;
	Mon, 27 Oct 2025 08:49:37 +0100 (CET)
From: Sven Eckelmann <se@simonwunderlich.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sw@simonwunderlich.de,
 Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH] net: phy: realtek: Add RTL8224 cable testing support
Date: Mon, 27 Oct 2025 08:49:36 +0100
Message-ID: <8597775.T7Z3S40VBb@ripper>
In-Reply-To: <3b1d35d7-ed62-4351-9e94-28e614d7f763@lunn.ch>
References:
 <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
 <3b1d35d7-ed62-4351-9e94-28e614d7f763@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10746008.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart10746008.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <se@simonwunderlich.de>
To: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 27 Oct 2025 08:49:36 +0100
Message-ID: <8597775.T7Z3S40VBb@ripper>
In-Reply-To: <3b1d35d7-ed62-4351-9e94-28e614d7f763@lunn.ch>
MIME-Version: 1.0

On Monday, 27 October 2025 01:16:12 CET Andrew Lunn wrote:
> > +#define RTL8224_SRAM_RTCT_FAULT_BUSY		BIT(0)
> > +#define RTL8224_SRAM_RTCT_FAULT_OPEN		BIT(3)
> > +#define RTL8224_SRAM_RTCT_FAULT_SAME_SHORT	BIT(4)
> > +#define RTL8224_SRAM_RTCT_FAULT_OK		BIT(5)
> > +#define RTL8224_SRAM_RTCT_FAULT_DONE		BIT(6)
> > +#define RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT	BIT(7)
> 
> It is unusual these are bits. Does the datasheet say what happens if
> the cable is both same short and cross short?

Unfortunately, the datasheet doesn't say anything about cable tests.

> 
> > +static int rtl8224_cable_test_result_trans(u32 result)
> > +{
> > +	if (result & RTL8224_SRAM_RTCT_FAULT_SAME_SHORT)
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
> > +
> > +	if (result & RTL8224_SRAM_RTCT_FAULT_BUSY)
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
> > +
> > +	if (result & RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT)
> > +		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
> 
> I don't remember seeing a PHY able to report both same short and cross
> short at the same time. Maybe there has been, but there is no code for
> it. We could add such a code.

I've tried it a couple of times (with shorts at different lengths) but was not 
able to do this. For me, it looks like the RTL8224 can represent these faults 
in parallel but not actual detect them in parallel. I also played around with
open + shorts. At the end, I never saw any parallel detections and left it to 
the bit prioritization (during decoding) from RTLSDK.

RTL8226 in RTLSDK doesn't use (in contrast to RTL8224 in RTLSDK) the bits - 
but there seems to be at least some connections. The codes for RTL8226 
(according to RTLSDK) are:

* 0x60 RTL8226_SRAM_RTCT_FAULT_OK (would be RTL8224 OK+DONE)
* 0x48 RTL8226_SRAM_RTCT_FAULT_OPEN (would be RTL8224 OPEN+DONE)
* 0x50 RTL8226_SRAM_RTCT_FAULT_SHORT (would be RTL8224 SAME_SHORT + DONE)
* 0x42 RTL8226_SRAM_RTCT_FAULT_MISMATCH_OPEN (would be RTL8224 DONE + ????)
* 0x44 RTL8226_SRAM_RTCT_FAULT_MISMATCH_SHORT (would be RTL8224 DONE + ????)
* else: RTL8226_SRAM_RTCT_FAULT_UNKNOWN

It seems like these decoding would not even have cross shorts. Don't ask me 
what this mismatch is - couldn't find anything like this in RTL8224. The bits 
1 + 2 are completely unused there.

Regards,
	Sven
--nextPart10746008.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaP8kEAAKCRBND3cr0xT1
y6MxAP9xn9PAEooF1J5Mih/sE05QVQvSvOTirV3C5o66UT+rVQEA1QSSMTWOSqEj
2lkg9V4vYd2dlU5qsMwHH+OU9umcMAc=
=DI62
-----END PGP SIGNATURE-----

--nextPart10746008.nUPlyArG6x--




