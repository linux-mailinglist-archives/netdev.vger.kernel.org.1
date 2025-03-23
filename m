Return-Path: <netdev+bounces-176970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F641A6D05E
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBF3AF360
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80562155759;
	Sun, 23 Mar 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfroNBFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B373D51C
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742751944; cv=none; b=ao5f40HWkxuV0pMtFFeXgnBOH4C1yKbjHlWpXTq9fqstXqiLgS6+Tv7Pj1aO5UzYUwTO54NCthIuZef/QgILKJMJ0BXqR2u2ra3YfsXa+Chkcn/W5MQ2PXTH+J3yxie9LiV4gK08Ws/e7kqfTfHtNlGLErbkHlh/xBqWqmDBHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742751944; c=relaxed/simple;
	bh=Hiy4VTUA2gxwvVKzEAm0ZAK2MDhlfx+HDc7UsEL1ypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkdap4LMvQmNBVG3j5ud8hVoL58qg8Cjp0B7OfnD7V5/YmUjRAOzExjL203nTfeUoT4nx0XW3T63K+JK1Owmw19BxayN4baDZR/s6NYtcwCDq4mZ659McWOg7opjFmAU3SKs4snEMJL8Ne0QAUaHRgCbJjNhYR+qMEyfQRo1kgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfroNBFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58402C4CEE2;
	Sun, 23 Mar 2025 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742751941;
	bh=Hiy4VTUA2gxwvVKzEAm0ZAK2MDhlfx+HDc7UsEL1ypo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfroNBFjbaMNEIP+r19NwDME2aC16KUXQRRQKgJ+EiTVaXtLC5hZt6hFQOS1owOuY
	 /REHi6CTjmQcGB+U1RFrsrSFADgc5BwTkx9AMHVBhulq9p0L6iIRsETHsNgmzCU4hW
	 Xpgnt97Fqxgo/5X5Yjh3exYCjnwYQg5kBZ/D8zDU49LLRLUTATuzyCqGNg0MV2Vw9F
	 7NWN39Dh+v8dCNtfUDUL+bVCRMCHdxu+6s2csYSVWItuZQNiG+7HVMHO3tz5cFaxNT
	 y+S0dx0EkmOy4REr1T7uuZbF++ZjWeYrd+NlRXrcLpZwqMa5jekiDC40XyMZggv6Qw
	 nVyaeknL2lenw==
Date: Sun, 23 Mar 2025 17:45:37 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, davemarq@linux.ibm.com, haren@linux.ibm.com,
	ricklind@us.ibm.com
Subject: Re: [PATCH net] ibmvnic: Use kernel helpers for hex dumps
Message-ID: <20250323174537.GY892515@horms.kernel.org>
References: <20250320212951.11142-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320212951.11142-1-nnac123@linux.ibm.com>

On Thu, Mar 20, 2025 at 04:29:51PM -0500, Nick Child wrote:
> Previously, when the driver was printing hex dumps, the buffer was cast
> to an 8 byte long and printed using string formatters. If the buffer
> size was not a multiple of 8 then a read buffer overflow was possible.
> 
> Therefore, create a new ibmvnic function that loops over a buffer and
> calls hex_dump_to_buffer instead.
> 
> This patch address KASAN reports like the one below:
>   ibmvnic 30000003 env3: Login Buffer:
>   ibmvnic 30000003 env3: 01000000af000000
>   <...>
>   ibmvnic 30000003 env3: 2e6d62692e736261
>   ibmvnic 30000003 env3: 65050003006d6f63
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in ibmvnic_login+0xacc/0xffc [ibmvnic]
>   Read of size 8 at addr c0000001331a9aa8 by task ip/17681
>   <...>
>   Allocated by task 17681:
>   <...>
>   ibmvnic_login+0x2f0/0xffc [ibmvnic]
>   ibmvnic_open+0x148/0x308 [ibmvnic]
>   __dev_open+0x1ac/0x304
>   <...>
>   The buggy address is located 168 bytes inside of
>                 allocated 175-byte region [c0000001331a9a00, c0000001331a9aaf)
>   <...>
>   =================================================================
>   ibmvnic 30000003 env3: 000000000033766e
> 
> Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> This patch obsoletes my work to define a for_each macro in printk.h [1].
> It was determined the pitfalls outweighed the benefits of the code
> cleanup.
> 
> Side question, is net the correct mailing list even if the bug being
> addressed was introduced long before the current release? Or is net-next
> more appropriate?  Does bug severity play any part in this or does
> anything with a Fixes tag go to net? netdev-FAQ implies all fixes go into
> net but previous mailing list entries seem to vary. Thanks

My view is that net is the correct target for bug fixes
for Networking code provided the bug is present in net
(which would be the case here).

