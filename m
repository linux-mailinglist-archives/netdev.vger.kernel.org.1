Return-Path: <netdev+bounces-187252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FCAA5F82
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED129C2951
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E51ACECE;
	Thu,  1 May 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7e00Q/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF519D06B
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107465; cv=none; b=Z4De3bEbdvKdVSk+cQFPfxqe0Lq19pVxno6SGwjqQdwRG/hiAxg/eoQxtY56g0p30O6tjPdE7MJtnez7UKKML+g5fRgP8xF+rdF05ZFAumQ+I3a2HW2Qinc3WxnR8fU1yaJANqVuWd9+zD4fsTgZvaxnRF2+vlEw6ZEQ+BnkPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107465; c=relaxed/simple;
	bh=oXB04uqyKlgN7tbJfyRt02/1FDKJI/QaOt5ciFDSSiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd4qoDNgtZxHglQZEDu0oJ96T73kYfwKOA6ihGXSuWxnIVjSgX0aw7bfXVMfJZtHS76j8/+eXGNHNLFBGKIJ6sPDB1ckLlreAXWtJOQ+rlAqLWF+HSyLyr7m+obHaaDL5I//LCKIThn8Vr+F9xCLUjp7QJp/Vyc5IHEjmhgkj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7e00Q/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76CEC4CEE3;
	Thu,  1 May 2025 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107465;
	bh=oXB04uqyKlgN7tbJfyRt02/1FDKJI/QaOt5ciFDSSiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7e00Q/Qsh0Pk/KpONhQU+viGjvpq6iEV08gxw5YQEVj1DAOG4xPxUx7RhyXUKpw8
	 8+syULZgXwL0Yl+vV9TDizd3uubXsVlyxqluRlBbFvavQSReYIA5mw6dUq2B/dy6Ve
	 HtM22IzQhIXnav1eFAIH+dfYbgqjV/O90WIVGANmvr9QXGR5PYz4pOs8sgTpESKzOV
	 awMdWdnvPFIENgYnQ89Zjyitw/kRGBB+32lGu0wNDU8Gx4PB9i6z1CPKjm5MwIRLgY
	 74gjfXxinjdYbp7Ny0tydJymW0lR4AX5Ex1Ab28g8D+cZCUQT7CyQol9wYVsbx2CMs
	 h6loUxjPaJV4g==
Date: Thu, 1 May 2025 14:51:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next 2/2] net: intel: move RSS packet classifier
 types to libie
Message-ID: <20250501135101.GY3339421@horms.kernel.org>
References: <20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com>
 <20250430-jk-hash-ena-refactor-v1-2-8310a4785472@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430-jk-hash-ena-refactor-v1-2-8310a4785472@intel.com>

On Wed, Apr 30, 2025 at 10:11:53AM -0700, Jacob Keller wrote:
> The Intel i40e, iavf, and ice drivers all include a definition of the
> packet classifier filter types used to program RSS hash enable bits. For
> i40e, these bits are used for both the PF and VF to configure the PFQF_HENA
> and VFQF_HENA registers.
> 
> For ice and iAVF, these bits are used to communicate the desired hash
> enable filter over virtchnl via its struct virtchnl_rss_hashena. The
> virtchnl.h header makes no mention of where the bit definitions reside.
> 
> Maintaining a separate copy of these bits across three drivers is
> cumbersome. Move the definition to libie as a new pctype.h header file.
> Each driver can include this, and drop its own definition.
> 
> The ice implementation also defined a ICE_AVF_FLOW_FIELD_INVALID, intending
> to use this to indicate when there were no hash enable bits set. This is
> confusing, since the enumeration is using bit positions. A value of 0
> *should* indicate the first bit. Instead, rewrite the code that uses
> ICE_AVF_FLOW_FIELD_INVALID to just check if the avf_hash is zero. From
> context this should be clear that we're checking if none of the bits are
> set.
> 
> The values are kept as bit positions instead of encoding the BIT_ULL
> directly into their value. While most users will simply use BIT_ULL
> immediately, i40e uses the macros both with BIT_ULL and test_bit/set_bit
> calls.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Please see comment below.

...

> diff --git a/include/linux/net/intel/libie/pctype.h b/include/linux/net/intel/libie/pctype.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..78723c8a33a084fb1120743427273af4b982c835
> --- /dev/null
> +++ b/include/linux/net/intel/libie/pctype.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBIE_PCTYPE_H
> +#define __LIBIE_PCTYPE_H
> +
> +/**
> + * enum libie_filter_pctype - Packet Classifier Types for filters
> + *
> + * Packet Classifier Type indexes, used to set the xxQF_HENA registers. Also
> + * communicated over the virtchnl API as part of struct virtchnl_rss_hashena.
> + */

As there is a Kernel doc for this enum,
./tools/kernel-doc -none would like each value documented too.

> +enum libie_filter_pctype {
> +	/* Note: Values 0-28 are reserved for future use.
> +	 * Value 29, 30, 32 are not supported on XL710 and X710.
> +	 */
> +	LIBIE_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP	= 29,
> +	LIBIE_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP	= 30,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV4_UDP		= 31,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK	= 32,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV4_TCP		= 33,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV4_SCTP		= 34,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV4_OTHER		= 35,
> +	LIBIE_FILTER_PCTYPE_FRAG_IPV4			= 36,
> +	/* Note: Values 37-38 are reserved for future use.
> +	 * Value 39, 40, 42 are not supported on XL710 and X710.
> +	 */
> +	LIBIE_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP	= 39,
> +	LIBIE_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP	= 40,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV6_UDP		= 41,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK	= 42,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV6_TCP		= 43,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV6_SCTP		= 44,
> +	LIBIE_FILTER_PCTYPE_NONF_IPV6_OTHER		= 45,
> +	LIBIE_FILTER_PCTYPE_FRAG_IPV6			= 46,
> +	/* Note: Value 47 is reserved for future use */
> +	LIBIE_FILTER_PCTYPE_FCOE_OX			= 48,
> +	LIBIE_FILTER_PCTYPE_FCOE_RX			= 49,
> +	LIBIE_FILTER_PCTYPE_FCOE_OTHER			= 50,
> +	/* Note: Values 51-62 are reserved for future use */
> +	LIBIE_FILTER_PCTYPE_L2_PAYLOAD			= 63
> +};
> +
> +#endif /* __LIBIE_PCTYPE_H */

...

