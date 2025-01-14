Return-Path: <netdev+bounces-158154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2204A109D8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D083AB19D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6614C5A1;
	Tue, 14 Jan 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc40TVKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67485149C51;
	Tue, 14 Jan 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866115; cv=none; b=HW2lwQbK96tYIIqjWqPyZcwrjAw5h+daloazJbewGAIe5A2vLcCzDDo86FqfQDAL7le06EHP2qg61bV2Tjaa+EoIPJp/s5Q7+OpY4uhqMvVZ5ElYK3nXi64szi3dpOr0br6tgVMwl5AchDrzCD9wgS66NNF40LEjvqGjTq3Kk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866115; c=relaxed/simple;
	bh=QXHukQ1t65WpXbs/EAAzNzXITRs6qp7GU6svnJEMHLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXzx9wqM2w9xGUyiT0AMDe8Sm/jiphdd/7ijfmKQR8JJrZlt8MI264ZE/PNJqXO03tauXCtS/bKmFE17vtHlrm5VkEF3naeyPhWRdKh6rZpOiU2du9/ucRrh0lyUcgf8ZKesSB4ocm2ZqYAO/GmVMXuPNTnDA8Lq2sszKQt8VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc40TVKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA56C4CEDD;
	Tue, 14 Jan 2025 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736866114;
	bh=QXHukQ1t65WpXbs/EAAzNzXITRs6qp7GU6svnJEMHLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zc40TVKqn0xFQJT7ZvU2Lsglv2GvnP0cE9d1T6jd25/dpFBaR42gu0x3TwX6TzEaz
	 45Z451ReVqCLDQ+L/ZUvDcWWKSc4YMKWkAc7Y3OitJITkzUmSPVhNGcP7vNf8buZp1
	 O06ayyfjhY/1/LCvuyQDYlkEOHbXbl3Coax+8gmF0oQjuAKz+c9kywoPmdYtAQwFKq
	 LCH4ODPxPc0i3RMGHBx25QYpYTytwvG56rQ1ylhGgFx4sF1Js2pzyTqP0g1Ec5pz6Q
	 Kd6la7REKWEqCLSxVipmKaa/m9scY+SY2J/fEwJxNWX4nYW0YeXjt/Q92uZLQLLLGx
	 1UtWvKhcwJnXA==
Date: Tue, 14 Jan 2025 14:48:31 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, nick.child@ibm.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Message-ID: <20250114144831.GI5497@kernel.org>
References: <20250113221721.362093-1-nnac123@linux.ibm.com>
 <20250113221721.362093-2-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113221721.362093-2-nnac123@linux.ibm.com>

On Mon, Jan 13, 2025 at 04:17:19PM -0600, Nick Child wrote:
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
> index 4217a9f412b2..d55968f7ac10 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -755,6 +755,27 @@ enum {
>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
>  			      int groupsize, char *linebuf, size_t linebuflen,
>  			      bool ascii);
> +/**
> + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> + * @i - offset in @buff

nit: scripts/kernel-doc would like this to be "@i: ..." 

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
> -- 
> 2.47.1
> 
> 

