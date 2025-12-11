Return-Path: <netdev+bounces-244377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35111CB5F0B
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15543011416
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BC311975;
	Thu, 11 Dec 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Yi2YLt1n"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D1311C3F;
	Thu, 11 Dec 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457481; cv=pass; b=ZwLezT3LIDUL8ag2d+k/x70QtfbD6N+Uuv9jcs4hnpihSMboNxYF/9kd6koMXqJOXbJeUv9PAX7xMak1Mjb4wmmcyvn0tsDwUIF8lFtRh9Jtp6V54fiQiHfv9l87HLvqoFqeoJf3pg7oRL4fVPpA9uIccPxPnWqztBnBodpHe5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457481; c=relaxed/simple;
	bh=UotlDZzTIEzcRItwp42SflKr1dHJl1J/Ncwa96BATk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBs6Skc1tp7gkhTYpV2kx02LUe+go/m8L/EHov/XdQAj/xNJn1U19uZZxIhDKySOQFWsd37+qq7sfXxWw55IjYICgnWaJC/xtBFJd3BCMioUU+Xyd0lUpHrpGdh3p6c0Vlcbqk7HJ0as5ApUlHyBJ6sAXRNtbpDfoIxrzu4/eMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Yi2YLt1n; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765457437; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kcUtD/eaoviqaIeEsrR41Pduoq1AYAKnqcE8XE5tTSIQ2BemdGq6+txvnCuk9yh4vl3WJaRt/uNMfB8u82hOXuBussErdEy0AvsiywzTxNxHgUSeItYmS66kHAE4O1LsVP/3CbTTnSLSGCD9tCbkAH2/js6lQEj1PK5z5V5blDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765457437; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ryxLHFOaruqbCroXVXS/PQz42TVjtoAvSN9FkkJhb2k=; 
	b=DvjyhwkYHECpZJLpa1F0MAGLRbCrrlAb9s8hIp6O3rnEyylRjetkLg8YyeQ3+ABzuM2OUS3JMyABzjoAcT2r1l49Ma5l3oepEaVz88tjpFk62O4fjFkdpav54jqKz6simuav5JfwyGT15Kz+ZVIw2zHecAilKCcFNZloCKa/4fU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765457437;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ryxLHFOaruqbCroXVXS/PQz42TVjtoAvSN9FkkJhb2k=;
	b=Yi2YLt1nywJfWQOx3Algyky823qQUp++N19UqlKMP7wtPENx8V1d63Y+8YtYnGJK
	GyESIJA/hGLJJqq0Aam3aJ23zt2i4LmmJwb5ZLeRdux5rLJMAxBTQ8N+dronk+AaJDq
	bkgbIwXvA5VznufdLTB1nOs8K7iPBHQv+v/UdXoo=
Received: by mx.zohomail.com with SMTPS id 1765457436311561.4113907322494;
	Thu, 11 Dec 2025 04:50:36 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Luo Jie <quic_luoj@quicinc.com>, Peter Zijlstra <peterz@infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Simon Horman <simon.horman@netronome.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Subject:
 Re: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
Date: Thu, 11 Dec 2025 13:50:28 +0100
Message-ID: <6719438.lOV4Wx5bFT@workhorse>
In-Reply-To: <20251210205915.3b055b7c@pumpkin>
References:
 <20251209100313.2867-1-david.laight.linux@gmail.com>
 <2262600.PYKUYFuaPT@workhorse> <20251210205915.3b055b7c@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 10 December 2025 21:59:15 Central European Standard Time David Laight wrote:
> On Wed, 10 Dec 2025 20:18:30 +0100
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > On Tuesday, 9 December 2025 11:03:07 Central European Standard Time david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > > not be used outside bitfield) and open-coding the generation of the
> > > masked value, just call FIELD_PREP() and add an extra check for
> > > the mask being at most 16 bits.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > >  include/linux/hw_bitfield.h | 17 ++++++++---------
> > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> > > index df202e167ce4..d7f21b60449b 100644
> > > --- a/include/linux/hw_bitfield.h
> > > +++ b/include/linux/hw_bitfield.h
> > > @@ -23,15 +23,14 @@
> > >   * register, a bit in the lower half is only updated if the corresponding bit
> > >   * in the upper half is high.
> > >   */
> > > -#define FIELD_PREP_WM16(_mask, _val)					     \
> > > -	({								     \
> > > -		typeof(_val) __val = _val;				     \
> > > -		typeof(_mask) __mask = _mask;				     \
> > > -		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
> > > -				 "HWORD_UPDATE: ");			     \
> > > -		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
> > > -		((__mask) << 16);					     \
> > > -	})
> > > +#define FIELD_PREP_WM16(mask, val)				\
> > > +({								\
> > > +	__auto_type _mask = mask;				\
> > > +	u32 _val = FIELD_PREP(_mask, val);			\
> > > +	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
> > > +			 "FIELD_PREP_WM16: mask too large");	\
> > > +	_val | (_mask << 16);					\
> > > +})
> > >  
> > >  /**
> > >   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> > >   
> > 
> > This breaks the build for at least one driver that uses
> > FIELD_PREP_WM16, namely phy-rockchip-emmc.c:
> 
> Not in my allmodconfig build.
> ... 
> > pcie-dw-rockchip.c is similarly broken by this change, except
> > without the superfluous wrapper:
> 
> That one did get built.

I build with clang 21.1.6 for arm64, in case that's any help.
I don't see how pcie-dw-rockchip.c built for you if FIELD_PREP
and FIELD_PREP_WM16 have conflicting symbol names?

> 
> The problem is that FIELD_PREP_WM16() needs to use different 'local'
> variables than FIELD_PREP().
> The 'proper' fix is to use unique names (as min() and max() do), but that
> makes the whole thing unreadable and is best avoided unless nesting is
> likely.
> In this case s/mask/wm16_mask/ and s/val/wm16_val/ might be best.
> 
> 	David
> 
> 





