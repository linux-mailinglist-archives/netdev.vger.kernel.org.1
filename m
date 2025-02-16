Return-Path: <netdev+bounces-166752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE0CA3732D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6413E3A6A35
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0C1865E3;
	Sun, 16 Feb 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSqbu4+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9D433A0;
	Sun, 16 Feb 2025 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698329; cv=none; b=dJkNsJdbH+qOeyY9EiSlIcibK1Hx7Menguph740pNE7gdHGBE+ziGVmr401GjZrSIIywljZb5Nq1TAHSfR8b30mur++CUERaCoQjCkd8pd8aa886jBRf6ADSV0O+WaSqtKkZnHZybGnRiSEVSogpWEAtaFxETMv9hD9i4+C9nhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698329; c=relaxed/simple;
	bh=sM2HFCLqAxsh4GngDOhlxRVRtA3N/hd95Tg81RfRQFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhvKmTM8h2OpeMv9ebvN+I6EVaHnVreAZL1mpSACZnHwPW8T5A2nbSUPUbG3yORCLjIiLkWAJrAUp23VI+VRCZxicVZ5cenza1iFmpP97prz1OirZ7HVuaJYL12KMDhqKfH1QCLfrElpRzXZ1NXRHuMPsdFKqYKeklP6du/r2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSqbu4+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED22AC4CEDD;
	Sun, 16 Feb 2025 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739698328;
	bh=sM2HFCLqAxsh4GngDOhlxRVRtA3N/hd95Tg81RfRQFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSqbu4+tEX+C/2s1TbcFTrMIK+qL/1F+WKH2CoR28EH30Sn6dCaPq9OqX8EiHCd+Z
	 MWLufQMzvM6Oss4aHU71MfXyhG1tG5OhtObH60+5GI9YZSXmwZUWWe4AmqL4rkBqvx
	 qb85QA1WEXIXEBn87bKvIGV5WkoO+UF8Q2oUuTmM7s2erZND4ZYcvOz2mOlh6xc8B+
	 GQKD3Iq/hzrC2zV5J+3oFkYadfh7KcgciSXyAyPdg+RZQv9pKHsG8SCfwpuYiuTRVL
	 6PS6Yioe20W3ilHsyrawLKJ0AlYSmjXkX/9C6f6EdrlPAAOdBTYRNN9ZcYWv5WFX2A
	 +Kw3NrbONlrRg==
Date: Sun, 16 Feb 2025 09:32:04 +0000
From: Simon Horman <horms@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, haren@linux.ibm.com,
	ricklind@us.ibm.com, nick.child@ibm.com, jacob.e.keller@intel.com
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
Message-ID: <20250216093204.GZ1615191@kernel.org>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
 <20250215163612.GR1615191@kernel.org>
 <20250215174039.20fbbc42@pumpkin>
 <20250215174635.3640fb28@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215174635.3640fb28@pumpkin>

On Sat, Feb 15, 2025 at 05:46:35PM +0000, David Laight wrote:
> On Sat, 15 Feb 2025 17:40:39 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Sat, 15 Feb 2025 16:36:12 +0000
> > Simon Horman <horms@kernel.org> wrote:
> > 
> > > + David Laight
> > > 
> > > On Fri, Feb 14, 2025 at 10:24:34AM -0600, Nick Child wrote:  
> > > > Define for_each_line_in_hex_dump which loops over a buffer and calls
> > > > hex_dump_to_buffer for each segment in the buffer. This allows the
> > > > caller to decide what to do with the resulting string and is not
> > > > limited by a specific printing format like print_hex_dump.
> > > > 
> > > > Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> > > > ---
> > > >  include/linux/printk.h | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > > 
> > > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > > index 4217a9f412b2..559d4bfe0645 100644
> > > > --- a/include/linux/printk.h
> > > > +++ b/include/linux/printk.h
> > > > @@ -755,6 +755,27 @@ enum {
> > > >  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > > >  			      int groupsize, char *linebuf, size_t linebuflen,
> > > >  			      bool ascii);
> > > > +/**
> > > > + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> > > > + * @i: offset in @buff
> > > > + * @rowsize: number of bytes to print per line; must be 16 or 32
> > > > + * @linebuf: where to put the converted data
> > > > + * @linebuflen: total size of @linebuf, including space for terminating NUL
> > > > + *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
> > > > + * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
> > > > + * @buf: data blob to dump
> > > > + * @len: number of bytes in the @buf
> > > > + */
> > > > + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> > > > +				   buf, len) \
> > > > +	for ((i) = 0;							\
> > > > +	     (i) < (len) &&						\
> > > > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > > > +				min((len) - (i), rowsize),		\
> > > > +				(rowsize), (groupsize), (linebuf),	\
> > > > +				(linebuflen), false);			\
> > > > +	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\  
> > > > +	    )
> > > >  #ifdef CONFIG_PRINTK
> > > >  extern void print_hex_dump(const char *level, const char *prefix_str,
> > > >  			   int prefix_type, int rowsize, int groupsize,    
> > > 
> > > Hi Nick,
> > > 
> > > When compiling with gcc 7.5.0 (old, but still supported AFAIK) on x86_64
> > > with patch 2/3 (and 1/3) applied I see this:
> > > 
> > >   CC      lib/hexdump.o
> > > In file included from <command-line>:0:0:
> > > lib/hexdump.c: In function 'print_hex_dump':
> > > ././include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_11' declared with attribute error: min((len) - (i), rowsize) signedness error  
> > ...
> > > Highlighting the min line in the macro for context, it looks like this:
> > > 
> > > 	min((len) - (i), rowsize)
> > > 
> > > And in this case the types involved are:
> > > 
> > > 	size_t len
> > > 	int i
> > > 	int rowsize  
> > 
> > Yep, that should fail for all versions of gcc.
> > Both 'i' and 'rowsize' should be unsigned types.
> > In fact all three can be 'unsigned int'.

To give a bit more context, a complication changing the types is that the
type of len and rowsise (but not i) is in the signature of the calling
function, print_hex_dump(). And I believe that function is widely used
throughout the tree.

> 
> Thinking a bit more.
> If the compiler can determine that 'rowsize >= 0' then the test will pass.
> More modern compilers do better value tracking so that might be enough
> to stop the compiler 'bleating'.

FTR, I did not see this with GCC 14.2.0 (or clang 19.1.7).

