Return-Path: <netdev+bounces-215405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C16B2E7A1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1413A5C64
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761A9334377;
	Wed, 20 Aug 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+TQUYr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700732A3D1;
	Wed, 20 Aug 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726001; cv=none; b=HQ/5DjFu27CcxOCv/6lX0+WNqoY7WSIKqRfaCB9R9Rk7klInd9rqHVpcBgtAbt9u+gno6KGUSxdudsuYMim4mr9m/U6dCogiHfy1iL9NgbN73pQfZHHvepIsxbsxzSUHcXXthogx+LFxV5KHjjjFIpw1eUT31ZexNywxUx1xt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726001; c=relaxed/simple;
	bh=Vu1I+HuHxDoxxbdFB6j/GEmkfst7XlomsGsZmlP9iJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3eSuetFWHyr3TOvneEpMux52c6u7AX3aorTat8KKu+YGcUEBJsqcUA2r/VB6l6m0WM2K32+55d0kpQsGR+kIekkwwJVDLlI3+HOax5bKU4VDIj/t2QFI7sRQ7p1g2Pm2smhdlAO29VC6oeRnf4AL81Gi5aViRX3mlY9BOezKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+TQUYr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D9C4CEE7;
	Wed, 20 Aug 2025 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726000;
	bh=Vu1I+HuHxDoxxbdFB6j/GEmkfst7XlomsGsZmlP9iJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+TQUYr0THucNKh8oKFkwFeJXzEbfGCHJyoliV+IcvcvgGdLfCzeR0EbkUp+qrvn2
	 LvSN948xgKu4YQ1nblQ3HF95WmUJUY12AoElpmJipXd6634ZWgggLhWhySVolrY98G
	 KhAiwZwwNsd2pXm1syl27NxVCPbkjHIe6IHYWXS/vw7FPFVgIVNZ2QHE7v3z5YngHK
	 E+uXlLTvIyGR1J/K2wa/sxc63Phh37yxqJnpvv1wqzZtWX9QdwOwbVH7cVV0aTK+lV
	 wTs2VLXpzP1Qk0N5I+TPcOGrtXag/d45bQozG90GXCexdjXYsGLZPihNClOxgkN5yV
	 +XPS05GgV0DLw==
Date: Wed, 20 Aug 2025 16:39:59 -0500
From: Rob Herring <robh@kernel.org>
To: "D. Jeff Dionne" <jeff@coresemi.io>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Artur Rojek <contact@artur-rojek.eu>, Rob Landley <rob@landley.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
Message-ID: <20250820213959.GA1242641-robh@kernel.org>
References: <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
 <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
 <295AB115-C189-430E-B361-4A892D7528C9@coresemi.io>
 <bc96aab8-fbb4-4869-a40a-d655e01bb5c7@kernel.org>
 <CAMuHMdW0NZHCX1V01N4oay-yKuOf+RR5YV3kjNFiM6X6aVAvdw@mail.gmail.com>
 <0784109c-bb3e-4c4e-a516-d9e11685f9fb@kernel.org>
 <CB2BF943-8629-4D01-8E52-EEC578A371B5@coresemi.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CB2BF943-8629-4D01-8E52-EEC578A371B5@coresemi.io>

On Mon, Aug 18, 2025 at 10:55:51PM +0900, D. Jeff Dionne wrote:
> Something like:

Please don't top post to maillists.

> J-Core SoCs are assembled with an SoC generator tool from standard 
> components.  An SoC has a ROM from soc_gen with a Device Tree binary 
> included.  Therefore, J-Core SoC devices are designed to ‘just work’ 
> with linux, but this means the DT entires are generic, slightly 
> different than standard device tree practice.

Yes. Though doesn't the SoC generator evolve/change? New features in the 
IP blocks, bug fixes, etc. Soft IP for FPGAs is similar I think. There 
we typically just require the versioning schema be documented and 
correlate to the IP versions (vs. made up v1, v2, v3).

This is all pretty niche I think, so I'm not too concerned about what 
you do here.

Rob

> 
> J
> 
> > On Aug 18, 2025, at 22:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > On 18/08/2025 12:57, Geert Uytterhoeven wrote:
> >>>> 
> >>>> No.  It’s a generic IP core for multiple SoCs, which do have names.
> >>> 
> >>> Then you need other SoCs compatibles, because we do not allow generic
> >>> items. See writing bindings.
> >>> 
> >>>> This is the correct naming scheme.  All compatible devices and SoCs match properly.
> >>> 
> >>> No, it is not a correct naming scheme. Please read writing bindings.
> >> 
> >> Can we please relax this for this specific compatible value?
> > 
> > We can...
> > 
> >> All other devices in this specific hardware implementation were
> >> accepted without SoC-specific compatible values ca. 9 years ago. AFAIK
> >> the Ethernet MAC was the sole missing piece, because its Linux driver
> >> was never attempted to be upstreamed before.
> > 
> > ...just provide some context and rationale in the commit msg.
> > 
> > Some (different) people pick up some irrelevant commits and use them as
> > argument in different discussions in style: it was allowed there, so I
> > can do the same.
> > 
> > Best regards,
> > Krzysztof
> 

