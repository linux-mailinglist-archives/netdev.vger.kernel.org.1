Return-Path: <netdev+bounces-245525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410FCD001A
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0057D3014A24
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE72E88A1;
	Fri, 19 Dec 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ackrrqks"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31021ABDC;
	Fri, 19 Dec 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149946; cv=pass; b=kHa+Rpz2zvWKGnCd2JMcDPKxzz27I44GfPYA23M7rowPUdpCgOBA2BAo/UBOK+uSPW2a865JsP0v7zsGRQxYcjuH+jFmSeO4mg1bvC9g9YqRE+vr6X0l4twgrlPNc86eCMggGi42zZqVeyjguqZ1nrdXrP+Lozzn++nvQDyAZkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149946; c=relaxed/simple;
	bh=sB0pU3XzDtEZyPXrJ9MhP+taMGJeMC32bcB98EmLKxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4GGmNU0i9FKmq9uTQOL/Y4L50ozMjqdv+Ib543k4O8y7jQVcAAv0vRMITtq/mBsVXI3Nf/3PK2TfDaz4BkVPsgmH0On2M8faIlMR58WrrrHDxlwt1cW3feRMDl+jmGV+NdrBHZucFcqDCjQCkWpZe+W9OYBgyGKOSpyNzmBcEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ackrrqks; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766149902; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h/1Nxtxor5f2a0qadiTmKCU5OxnryxbhKgFwOw3mXeZ9d89pwjCzkG+JPBqd9F2iFNpb/O+Ey2aMUHj5M8DrWI6YOUy/NpRPeBteYLTUCSNtEDDoqgTKZ8jKR9//4NxJmNRcw5GECRsV7f54bkeXQRsuGDIAhC/awok0Dyx8UdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766149902; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9+kwT7cTq8h6pPJlieCyoVIEFRzcWrfER4cYYgnn5ko=; 
	b=Io4vh9lil4++o9Pgd90SbW4WC3i1fh2mxSuafjRhwJVu9OCrNUDA+BoKLec6ZkIaS/O1WbjGPxqENq1Uq9mWWAvdE4aUwi957R5tWIFYCXYk5TzZqa/CUdjyawjJiV7HQZYpwu0ylsnCtxsW7/AMsmXMH6XUtuBDJxz6zdcNQyI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766149902;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=9+kwT7cTq8h6pPJlieCyoVIEFRzcWrfER4cYYgnn5ko=;
	b=ackrrqksLxL3+DfSFCyDNvDpORh4y2VN8InPMjWmukQJbb4N/Py0yRXvfLdwHIno
	6r8elofRE1gA855pd4a0nliNuxvNuIL/DGNdygApgHjmMgI4oTrTOtHWUYrGdLMD1WW
	XL8cyVBclhFeHyHZmRPmAk7XrUgVOp1gq9Hyaqkc=
Received: by mx.zohomail.com with SMTPS id 17661499003347.950368020915107;
	Fri, 19 Dec 2025 05:11:40 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Yury Norov <yury.norov@gmail.com>, david.laight.linux@gmail.com
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Luo Jie <quic_luoj@quicinc.com>, Peter Zijlstra <peterz@infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Subject:
 Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Date: Fri, 19 Dec 2025 14:11:33 +0100
Message-ID: <7313978.lOV4Wx5bFT@workhorse>
In-Reply-To: <aUNHyjKS9b2KwdGJ@yury>
References:
 <20251212193721.740055-1-david.laight.linux@gmail.com>
 <5257288.LvFx2qVVIh@workhorse> <aUNHyjKS9b2KwdGJ@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 18 December 2025 01:16:10 Central European Standard Time Yury Norov wrote:
> On Wed, Dec 17, 2025 at 02:22:32PM +0100, Nicolas Frattaroli wrote:
> > On Friday, 12 December 2025 20:37:08 Central European Standard Time david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > > not be used outside bitfield) and open-coding the generation of the
> > > masked value, just call FIELD_PREP() and add an extra check for
> > > the mask being at most 16 bits.
> > > The extra check is added after calling FIELD_PREP() to get a sane
> > > error message if 'mask' isn't constant.
> > > 
> > > Remove the leading _ from the formal parameter names.
> > > Prefix the local variables with _wm16_ to hopefully make them
> > > unique.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > 
> > > Changes for v2:
> > > - Update kerneldoc to match changed formal parameter names.
> > > - Change local variables to not collide with those in FIELD_PREP().
> > > 
> > > Most of the examples are constants and get optimised away.
> > > 
> > >  include/linux/hw_bitfield.h | 21 ++++++++++-----------
> > >  1 file changed, 10 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> > > index df202e167ce4..0bd1040a5f93 100644
> > > --- a/include/linux/hw_bitfield.h
> > > +++ b/include/linux/hw_bitfield.h
> > > @@ -12,8 +12,8 @@
> > >  
> > >  /**
> > >   * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
> > > - * @_mask: shifted mask defining the field's length and position
> > > - * @_val:  value to put in the field
> > > + * @mask: shifted mask defining the field's length and position
> > > + * @val:  value to put in the field
> > >   *
> > >   * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
> > >   * result with the mask shifted up by 16.
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
> > > +	__auto_type _wm16_mask = mask;				\
> > > +	u32 _wm16_val = FIELD_PREP(_wm16_mask, val);		\
> > > +	BUILD_BUG_ON_MSG(_wm16_mask > 0xffffu,			\
> > > +			 "FIELD_PREP_WM16: mask too large");	\
> > > +	_wm16_val | (_wm16_mask << 16);				\
> > > +})
> > >  
> > >  /**
> > >   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> > > 
> > 
> > Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > Compiled it with my usual config and booted it on a board that uses
> > drivers that make use of these macros, and checked that things are
> > working.
> 
> Nicolas, thanks for testing! Would you also want to add an explicit
> ack or review tag?

Sure!

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

(not sure if an ack is meaningful for me, since I'm technically not
the maintainer, but:)

Acked-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I've taken some more time to compare the binary outputs with and
without the change, and they're the same. I've also looked at the
code itself, and it appears correct (and more correct than the
original in fact, since I used "HWORD_UPDATE" by accident in the
error message).

Kind regards,
Nicolas Frattaroli

> 
> David, I'm OK with this change. Please add bloat-o-meter and code
> generation examples, and minimize the diff as I asked in v1, before I
> can merge it.
> 
> Thanks,
> Yury
> 





