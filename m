Return-Path: <netdev+bounces-244148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F3CB0787
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCCE330115E4
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4162FE582;
	Tue,  9 Dec 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hi6l+Td6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F427F759;
	Tue,  9 Dec 2025 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295622; cv=none; b=dyqFVg1g8lQGk9ptTU8N0EtVbTpBCu55NSYxkVkoT4GCD4h2sA45KxRaSQj9RjYhlkdi4lVBj3t4jR/kNh+xkAYeWcOTEEa4f1RhmHZfNjMBLvkV2TBUutSL3ATCIrSFjiZkjw5CLF3apNUwYCPLu5fo0sEmTathxW22wCuePrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295622; c=relaxed/simple;
	bh=ldAUQ3qlJKlypdnT8395n30k3scG1Hsh/4akiujI2kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XksiIQINafxwQzbReJN2DeHgZf++Yty43Q/K4VE8OwE/MwLR9ydNw7pqTOkhrSrNBQWAwfx9m3gaW7N6BodVAbwBwE2V4z9TKYlY2ki/mADO+qBOuzKXiuWtBgv232WpZBZLaNta0vXXmFZmkNZLvIp6UAce769HS7reZxwFc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hi6l+Td6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765295621; x=1796831621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldAUQ3qlJKlypdnT8395n30k3scG1Hsh/4akiujI2kM=;
  b=Hi6l+Td6884fOkH07XDA+sZb/Np4WMs2XgwO20rEhew2DQisABsHbByl
   /2bZSjX9nerZL9lHQyDqMJGTpTu7seYC6Ml9sDiQIqAABAyQbXqsJMHvt
   Hlp6Z7r8CFWaU2KQMtD/bc7rr8x0b+jT0BBXNda3VMhca8Luo9Wb+OG6j
   srA9ObH60E2GbuHJ+6o8euzn8+zYO6DhDAPZMlPuzJMA0CmhbQ3/j5iYt
   AsM5NFx+x18GjrlbMhPjSZ57dAcFaCo3OWIWleGA68pW13W/9RVZJbYvV
   GtvcwpuvQyX0K54n8SzVJaBq0rk5cXyZyyF15fK6ptnE7I9OzTZPgP+oq
   A==;
X-CSE-ConnectionGUID: vrZCjXSeRdq9jNNMMol1xw==
X-CSE-MsgGUID: lfMMAXNVRtCFxuc97jUXOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="77871103"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="77871103"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:53:40 -0800
X-CSE-ConnectionGUID: ssg/azmWQPiVweOFzVaN/w==
X-CSE-MsgGUID: LLu7/m6lSSmvCyjtUOkH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="196022254"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:53:36 -0800
Date: Tue, 9 Dec 2025 17:53:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 8/9] bitfield: Add comment block for the host/fixed
 endian functions
Message-ID: <aThF_cYiyRjS38Ok@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-9-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100313.2867-9-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 10:03:12AM +0000, david.laight.linux@gmail.com wrote:

> Copied almost verbatim from the commit message that added the functions.

...

> +/*

Can it be a global DOC for being processed by kernel-doc?

> + * Primitives for manipulating bitfields both in host- and fixed-endian.
> + *
> + * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
> + *   bitfield specified by @field in little-endian 32bit object @val and
> + *   converts it to host-endian.
> + *
> + * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
> + *   the contents of the bitfield specified by @field in little-endian
> + *   32bit object pointed to by @p with the value of @v.  New value is
> + *   given in host-endian and stored as little-endian.
> + *
> + * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) is equivalent to
> + *   ({__le32 tmp = old; le32p_replace_bits(&tmp, v, field); tmp;})
> + *   In other words, instead of modifying an object in memory, it takes
> + *   the initial value and returns the modified one.
> + *
> + * * __le32 le32_encode_bits(u32 v, u32 field) is equivalent to
> + *   le32_replace_bits(0, v, field).  In other words, it returns a little-endian
> + *   32bit object with the bitfield specified by @field containing the
> + *   value of @v and all bits outside that bitfield being zero.
> + *
> + * Such set of helpers is defined for each of little-, big- and host-endian
> + * types; e.g. u64_get_bits(val, field) will return the contents of the bitfield
> + * specified by @field in host-endian 64bit object @val, etc.  Of course, for
> + * host-endian no conversion is involved.
> + *
> + * Fields to access are specified as GENMASK() values - an N-bit field
> + * starting at bit #M is encoded as GENMASK(M + N - 1, M).  Note that
> + * bit numbers refer to endianness of the object we are working with -
> + * e.g. GENMASK(11, 0) in __be16 refers to the second byte and the lower
> + * 4 bits of the first byte.  In __le16 it would refer to the first byte
> + * and the lower 4 bits of the second byte, etc.
> + *
> + * Field specification must be a constant; __builtin_constant_p() doesn't
> + * have to be true for it, but compiler must be able to evaluate it at
> + * build time.  If it cannot or if the value does not encode any bitfield,
> + * the build will fail.
> + *
> + * If the value being stored in a bitfield is a constant that does not fit
> + * into that bitfield, a warning will be generated at compile time.
> + */

-- 
With Best Regards,
Andy Shevchenko



