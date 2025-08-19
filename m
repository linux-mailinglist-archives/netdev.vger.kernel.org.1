Return-Path: <netdev+bounces-214978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAE7B2C692
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1D37B3D2B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3E2153D3;
	Tue, 19 Aug 2025 14:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EA2EB850;
	Tue, 19 Aug 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612476; cv=none; b=a+t8tvefUAFlZ07TNJ2SzHH1QAI4BCFnjXAhykgtw1FX6Rb3lcWEjKqMHNw1Ie6nqYHVFUWjBhd3rf5JagDt8p6sz3fxE7yHlbP0fITF2cmoYJEDNsk6nwIoyQYbCJz4Y7/atzMzOapIcDO7i05ohrpYHsmp1jNgRntPm2VKx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612476; c=relaxed/simple;
	bh=XyPEOIutZF5XVSITy/v0DslxDYnWJy+0xlunS+qG4cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/b4TX/0vo9R10lPwF14do6gvlFNbRQJtzcsxE8qMjqhKs+dwnO2HYIvostTX8r4ZC5mDugYJCA0T5fPyD4gjow42Mt5kvWreqvSl7Qd4y2g098sGVHfKSXdDAG4mBkb7jpVnsUVPq+Kitw8dlRdohOgoPDDCfEcW9qJqDT/+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoMzz-000000003VL-4AgO;
	Tue, 19 Aug 2025 14:07:40 +0000
Date: Tue, 19 Aug 2025 15:07:32 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 06/23] net: dsa: lantiq_gswip: load
 model-specific microcode
Message-ID: <aKSFJNn0mHpyeow-@pidgin.makrotopia.org>
References: <aKDhZ9LQi63Qadvh@pidgin.makrotopia.org>
 <c8128783-6eac-4362-ae31-f2ae28122803@lunn.ch>
 <aKI_t6F0zzLq2AMw@pidgin.makrotopia.org>
 <aKPI6xMIgIeBzqy7@pidgin.makrotopia.org>
 <5cabea37-2a10-4664-b02b-c803641aff1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cabea37-2a10-4664-b02b-c803641aff1f@lunn.ch>

On Tue, Aug 19, 2025 at 03:17:31PM +0200, Andrew Lunn wrote:
> > I didn't consider that the size of the array elements needs to be known
> > when defining struct gswip_hw_info in lantiq_gswip.h.
> > So the only reasonable solution is to make also the definition of
> > struct gswip_pce_microcode into lantiq_gswip.h, so lantiq_pce.h won't
> > have to be included before or by lantiq_gswip.h itself.
> 
> What i've done in the past is define a structure which describes the
> firmware. Two members, a pointer to the list of values, and a length
> of the list of values. You can construct this structure using
> ARRAY_SIZE(), and export it.

It is true that with one more layer of indirection I could have a separate
(allocated) struct gswip_pce_firmware with two elements
	.pce_microcode = &gswip_pce_microcode,
	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),

However, see below why I don't think this would actually solve the whole
problem.

> You should then be able to put the odd
> val4, val3, val2, val1 structure, and the macro together in one header
> file, and use it in two places to define the firmware blobs for the
> different devices.

I think this is the root of the misunderstanding here.
The odd val4, val3, val2, val1 struct is not only used to define the
microcode instructions, but it is also used to load the microcode into
the hardware, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/dsa/lantiq_gswip.c?h=v6.17-rc2#n743

Now, as long as there is only one header lantiq_pce.h defining such
microcode along with the odd struct, all this is not a problem.
However, the problem arises once there is more than one such header,
which will be required to support the newer MaxLinear hardware.
Which of the two (lantiq_pce.h or gsw1xx_pce.h?) is suppose to define
the struct? Which of the two should be included in the share module
('lantiq_gswip_common') which will take care of loading the microcode
into the hardware? (imho: none of them, both headers are hardware
specific and should be included by the respective specific modules
for either switch family)


