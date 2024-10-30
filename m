Return-Path: <netdev+bounces-140200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648B9B5847
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E03C1F215BE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9F3A41;
	Wed, 30 Oct 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L2xm3JZu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B74414
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246995; cv=none; b=qB4feISKxR+epAkfYl+hQj+ObXsfAs25iapB52//0dyk3z+PBKuktMpmyCWFsrLkvintgku3jHjsGJFNizw/sY8LN6ZbM1JCv1dlQ3B/dkU0hfXjUhvHFFevqZoaYQNAAjMMe31HCGBx15BvnDrzZyCIBJypN9JVVjHyE/Y5PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246995; c=relaxed/simple;
	bh=lVG9go60zqFjZsqTUCmwGKhqmdBJ9Ht29mwdQizcccY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA01ptHPlESGVl1plW/RO+Dc2aIFkLp9kUM99FcUQOcLH5u0ec3FbazMaAL5G/wJBCBj2zOIZtooaQJNkGlFIuDh1TxGbo74hH5nkB8+G42tSHrl+UN8vI3O5lY2Fo7d9h/u96wPfkFsasLMYY9J6V8hOpr5/Cwgdz4nYQahoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L2xm3JZu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BNRVBe0d284VVhDyxxWWx6dP4VyszZ+/0xPwe1DQcXE=; b=L2xm3JZuFNiy93fHaU/iiz+sqd
	r6GQtUaxSY/i3hrjcA1TgJ6Ip9dYJZeC9fv0kvSmdGAJYwANKdReWrSPt2YaF+MJk3gD2CAmEVy+o
	1f0XqXmWmRqv5J/PGrPxe8EmJkQFV+4D2r3z/ReJTFTZRVI5yPYae1CE1n4FPWWvex0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5wHW-00Bdn3-UT; Wed, 30 Oct 2024 01:09:50 +0100
Date: Wed, 30 Oct 2024 01:09:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and
 homa_pool.c
Message-ID: <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-5-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-5-ouster@cs.stanford.edu>

On Mon, Oct 28, 2024 at 02:35:31PM -0700, John Ousterhout wrote:
> These files implement Homa's mechanism for managing application-level
> buffer space for incoming messages This mechanism is needed to allow
> Homa to copy data out to user space in parallel with receiving packets;
> it was discussed in a talk at NetDev 0x17.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_pool.c | 434 +++++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_pool.h | 152 +++++++++++++++
>  2 files changed, 586 insertions(+)
>  create mode 100644 net/homa/homa_pool.c
>  create mode 100644 net/homa/homa_pool.h
> 
> diff --git a/net/homa/homa_pool.c b/net/homa/homa_pool.c
> new file mode 100644
> index 000000000000..6c59f659fba1
> --- /dev/null
> +++ b/net/homa/homa_pool.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +#include "homa_impl.h"
> +#include "homa_pool.h"
> +
> +/* This file contains functions that manage user-space buffer pools. */
> +
> +/* Pools must always have at least this many bpages (no particular
> + * reasoning behind this value).
> + */
> +#define MIN_POOL_SIZE 2
> +
> +/* Used when determining how many bpages to consider for allocation. */
> +#define MIN_EXTRA 4
> +
> +/* When running unit tests, allow HOMA_BPAGE_SIZE and HOMA_BPAGE_SHIFT
> + * to be overridden.
> + */
> +#ifdef __UNIT_TEST__
> +#include "mock.h"
> +#undef HOMA_BPAGE_SIZE
> +#define HOMA_BPAGE_SIZE mock_bpage_size
> +#undef HOMA_BPAGE_SHIFT
> +#define HOMA_BPAGE_SHIFT mock_bpage_shift
> +#endif
> +
> +/**
> + * set_bpages_needed() - Set the bpages_needed field of @pool based
> + * on the length of the first RPC that's waiting for buffer space.
> + * The caller must own the lock for @pool->hsk.
> + * @pool: Pool to update.
> + */
> +static inline void set_bpages_needed(struct homa_pool *pool)

Generally we say no inline functions in .c files, let the compiler
decide. If you have some micro benchmark indicating the compiler is
getting it wrong, we will then consider allowing it.

It would be good if somebody who knows about the page pool took a look
at this code. Could the page pool be used as a basis?

   Andrew

