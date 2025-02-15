Return-Path: <netdev+bounces-166692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E197FA36F7C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5873AEF75
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7E1624F0;
	Sat, 15 Feb 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGKVG20b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A38D529;
	Sat, 15 Feb 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637378; cv=none; b=QcFmflC7Vh93+OiLN+5A0SEhO9cuA86290C/8T4rgK2V2Qk64YXTGH8Jhfr4bi0OPOMl3WlTin+QP3qePfMwP3qginQUgrye72zdl2+3DGgcH8H9kFkNJY580J+hLoyz9K76QRSeSsBlq4l+qsB78QrB4mnEvWjoKG6JOVVLeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637378; c=relaxed/simple;
	bh=iYuB55lRmwpvhYI53PDufq8CV/MBZPan6dR3p7Ownbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL2JTXSLOvCGdcYoecG8SPVIa0VbYnmr+NZYQ2hsbE77PiGLkT/bEMHF2Ti5ponAzG7a6oKlN1mvhSOLAJOxqcGCjfehILUKpC80nqQ4ArFT3VAgHdn+1dzzKihWczmlgUx9/A/TLhG+G5cXMTl6PJfZ4OwmV7SA4wFOQ/aWvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGKVG20b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08AAC4CEDF;
	Sat, 15 Feb 2025 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739637376;
	bh=iYuB55lRmwpvhYI53PDufq8CV/MBZPan6dR3p7Ownbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGKVG20bL+UJq6ubAxIWqwOLPLUXlruL0Olb9ZegfzPGiUntzF1ft5EXkfA/gwuOa
	 Je9UE/FLGqBTVbLj567gH1wAwz3wRh/C5zWVFLgPi9oRo51vjbDEib4qCdtwH21RZe
	 eZNTMH0ZlTWUbvgGiexAWwsA0IdZXM/q75BhR+Iz74UXgrEEwr+qN3UXyJMB4HuJoB
	 FX75Cllj7lABC+OolwU8V44POfWy9/TbvvI2Xs/FKi5ZFySxqVONuQl9JwAts73L9b
	 GgV+/dxJ3gnzBADt1+lmFavNN2b3YoNPmm0x+0i2ghp087tKZm6rq9GJo1UPhSec2y
	 gj/E+6Y1BoK4Q==
Date: Sat, 15 Feb 2025 16:36:12 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
	jacob.e.keller@intel.com,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Message-ID: <20250215163612.GR1615191@kernel.org>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214162436.241359-2-nnac123@linux.ibm.com>

+ David Laight

On Fri, Feb 14, 2025 at 10:24:34AM -0600, Nick Child wrote:
> Define for_each_line_in_hex_dump which loops over a buffer and calls
> hex_dump_to_buffer for each segment in the buffer. This allows the
> caller to decide what to do with the resulting string and is not
> limited by a specific printing format like print_hex_dump.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  include/linux/printk.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..559d4bfe0645 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -755,6 +755,27 @@ enum {
>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
>  			      int groupsize, char *linebuf, size_t linebuflen,
>  			      bool ascii);
> +/**
> + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> + * @i: offset in @buff
> + * @rowsize: number of bytes to print per line; must be 16 or 32
> + * @linebuf: where to put the converted data
> + * @linebuflen: total size of @linebuf, including space for terminating NUL
> + *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
> + * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
> + * @buf: data blob to dump
> + * @len: number of bytes in the @buf
> + */
> + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> +				   buf, len) \
> +	for ((i) = 0;							\
> +	     (i) < (len) &&						\
> +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> +				min((len) - (i), rowsize),		\
> +				(rowsize), (groupsize), (linebuf),	\
> +				(linebuflen), false);			\
> +	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\
> +	    )
>  #ifdef CONFIG_PRINTK
>  extern void print_hex_dump(const char *level, const char *prefix_str,
>  			   int prefix_type, int rowsize, int groupsize,

Hi Nick,

When compiling with gcc 7.5.0 (old, but still supported AFAIK) on x86_64
with patch 2/3 (and 1/3) applied I see this:

  CC      lib/hexdump.o
In file included from <command-line>:0:0:
lib/hexdump.c: In function 'print_hex_dump':
././include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_11' declared with attribute error: min((len) - (i), rowsize) signedness error
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
././include/linux/compiler_types.h:523:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
././include/linux/compiler_types.h:542:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:93:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(!__types_ok(ux, uy),  \
  ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:98:2: note: in expansion of macro '__careful_cmp_once'
  __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
  ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:105:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(min, x, y)
                   ^~~~~~~~~~~~~
./include/linux/printk.h:774:5: note: in expansion of macro 'min'
     min((len) - (i), rowsize),  \
     ^~~
lib/hexdump.c:272:2: note: in expansion of macro 'for_each_line_in_hex_dump'
  for_each_line_in_hex_dump(i, rowsize, linebuf, sizeof(linebuf),
  ^~~~~~~~~~~~~~~~~~~~~~~~~

Highlighting the min line in the macro for context, it looks like this:

	min((len) - (i), rowsize)

And in this case the types involved are:

	size_t len
	int i
	int rowsize

This is not a proposal, but I made a quick hack changing they type of rowsize
to size_t and the problem goes away. So I guess it is the type missmatch
between the two arguments to min that needs to be resolved somehow.


FWIIW, you should be able to reproduce this problem fairly easily using
the toolchain here:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/7.5.0/

