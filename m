Return-Path: <netdev+bounces-245155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A1CC7CF5
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D952830198C5
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCA3644A2;
	Wed, 17 Dec 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JgR2xIqM"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2D364054;
	Wed, 17 Dec 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977800; cv=pass; b=urMTQ4c0zfw7JfqJGrvTBqxqp3KAYPPckymTmgMEOF9Ppsrhca3ssrQW3VYR0C5UiwbNLTEjVFLH8vZTAgxuCdj7od1jZdIrJlDfHgrLKvQyg1PlppBkq4KGJXWM6NjRUqEqE+2tHlHr353e5LCSqPIjpcN200Ff1LD85wGLpRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977800; c=relaxed/simple;
	bh=fVKT7rDdttCzsRfnB9K7nWj5FT4eZcULlfN80OgBHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND0dDN99sc6DGmmjRl+Y2870qmU+LVrz1h+7zIH8DAZ11sanO1IL6fw6ByRZSbzySX1E+Dn3rka1geahBAsa610Rj1DFdAMX119aKwDkVo9RXi4yHh0QGh5MjkYLBRBFDxGa0AHGWK14zi73R56h4DtodfH/jJOH/ShYm+hTVxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JgR2xIqM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765977761; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JcaNVFtWF09J8UUQjJDy51N/nfczZfTSImwJqyGX/SZWPjPqO2Ng6qMwCCWFAGJyJHbyplcx3mTCQk/eiDSfi7oyUCcIe7olfEJeEcTJR2lTaFCsGKRy6peQusivroHwrfErdW6dPZ0PiM3Jl3AgC55fATxHGErQYYmYX2Xwsow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765977761; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a4Eijtqz4M7Yj1PtxbYsVVRrrOGxhIAmSQjItxOgZ54=; 
	b=HIhLw91TPWEOqJyOOVx5JFX7wqqac6qvlQ5j2WSNw3OOSnseGP086LICIebP5gSaIUMxJxMY3Npnsko0tCupJjf+djSWWLAiqbR3Brog77fWkmf49EbmV8xYz4aTs7nO9fnRPmzzIv78BoIkc8nQbZtI90pV5C0bWdHbdHaaKyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765977761;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=a4Eijtqz4M7Yj1PtxbYsVVRrrOGxhIAmSQjItxOgZ54=;
	b=JgR2xIqM5PptMkzFkDbvpDgS/j2fsvEz2FL6UT8OVv0Mw9DAnrGc6Yf3fzc6VMNp
	immBRxv2+Q0arsFaC8h2Ct03+JpQjgCKoJzpOKJ/NyrnWRUI3RrUofswXycue4wWFHm
	tBFL9Lxb3wc7SCNM3c3V9XXnFRcvz8RI1HwUaTxc=
Received: by mx.zohomail.com with SMTPS id 1765977758524562.7899643388763;
	Wed, 17 Dec 2025 05:22:38 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
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
 Yehezkel Bernat <YehezkelShB@gmail.com>, david.laight.linux@gmail.com
Cc: David Laight <david.laight.linux@gmail.com>
Subject:
 Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Date: Wed, 17 Dec 2025 14:22:32 +0100
Message-ID: <5257288.LvFx2qVVIh@workhorse>
In-Reply-To: <20251212193721.740055-4-david.laight.linux@gmail.com>
References:
 <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 12 December 2025 20:37:08 Central European Standard Time david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> not be used outside bitfield) and open-coding the generation of the
> masked value, just call FIELD_PREP() and add an extra check for
> the mask being at most 16 bits.
> The extra check is added after calling FIELD_PREP() to get a sane
> error message if 'mask' isn't constant.
> 
> Remove the leading _ from the formal parameter names.
> Prefix the local variables with _wm16_ to hopefully make them
> unique.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> 
> Changes for v2:
> - Update kerneldoc to match changed formal parameter names.
> - Change local variables to not collide with those in FIELD_PREP().
> 
> Most of the examples are constants and get optimised away.
> 
>  include/linux/hw_bitfield.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> index df202e167ce4..0bd1040a5f93 100644
> --- a/include/linux/hw_bitfield.h
> +++ b/include/linux/hw_bitfield.h
> @@ -12,8 +12,8 @@
>  
>  /**
>   * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
> - * @_mask: shifted mask defining the field's length and position
> - * @_val:  value to put in the field
> + * @mask: shifted mask defining the field's length and position
> + * @val:  value to put in the field
>   *
>   * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
>   * result with the mask shifted up by 16.
> @@ -23,15 +23,14 @@
>   * register, a bit in the lower half is only updated if the corresponding bit
>   * in the upper half is high.
>   */
> -#define FIELD_PREP_WM16(_mask, _val)					     \
> -	({								     \
> -		typeof(_val) __val = _val;				     \
> -		typeof(_mask) __mask = _mask;				     \
> -		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
> -				 "HWORD_UPDATE: ");			     \
> -		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
> -		((__mask) << 16);					     \
> -	})
> +#define FIELD_PREP_WM16(mask, val)				\
> +({								\
> +	__auto_type _wm16_mask = mask;				\
> +	u32 _wm16_val = FIELD_PREP(_wm16_mask, val);		\
> +	BUILD_BUG_ON_MSG(_wm16_mask > 0xffffu,			\
> +			 "FIELD_PREP_WM16: mask too large");	\
> +	_wm16_val | (_wm16_mask << 16);				\
> +})
>  
>  /**
>   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> 

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Compiled it with my usual config and booted it on a board that uses
drivers that make use of these macros, and checked that things are
working.

Thank you!

Kind regards,
Nicolas Frattaroli



