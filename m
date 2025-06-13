Return-Path: <netdev+bounces-197514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4456AD8FD7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D0E176FA9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26819FA8D;
	Fri, 13 Jun 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHl6c322"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957F18EFD1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825764; cv=none; b=cgYzUb6RuzZN5yE43LYpp0aUL5shnNNzW22oV9GIwlViFOxfNQ1DHdbQ8l4Zs4V74ArKyQuPrmK5NG8fbabZpAmKF8GOenoXUmwrR9fT314EBUoyEFS42eHXbdOxOPr5bFluhXZ2SyCtsLZprQfPsJDtortTmLjo+o1wYa3VZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825764; c=relaxed/simple;
	bh=a/ijWLO3kYFMEjABLaGSvs9pPdguYQoiMJyEcNPTMMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zon1AH8UC5mPmnoYrvdTFKiNAQYP5o/8Qp42FjZuT5hCD6ZMTdOOxF9Ef6cloNyqzAsZPNkVzC0dCuTvQbb/7ZTaOJb4kmyZatXTEEhenvl7lIBJVrvb4Ghtf1/i1pQEUIhqScGw4AqXHQRrNIHYMM9vVNEqhiKfyF5s/4ULe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHl6c322; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A54C4CEE3;
	Fri, 13 Jun 2025 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825764;
	bh=a/ijWLO3kYFMEjABLaGSvs9pPdguYQoiMJyEcNPTMMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHl6c322t/5CgCBvR5Bi6kh+H2A2LNXVYL8ORRTH747ThPsmvD0x/sBr4c6/Yos3p
	 rVKwDdZXKiVYpZWg5OhyRbsG+pUR9fs06bxJk07xm57INVXpOaUochP7PIKgnyMDyE
	 15ze60Tu7gXAVyIru/sBx1rvcohTxFrLfLTHkAbUF80fLxtinXJEXr+yB098pnkDHp
	 kYVEgBthXyePw0paeX80pIZAUM/1Y7E4id2On/008jCr4AgMfYlq7xoRTFCwkXrSeY
	 GJTXtL8A7RPYS4MSwipiTfrB1j61hIda4L6kM7lj2Za+2tB+Pu2ppa8J2WHIoZ3wGC
	 2LAY90Mkkr8tA==
Date: Fri, 13 Jun 2025 15:42:40 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 06/15] net: homa: create homa_sock.h and
 homa_sock.c
Message-ID: <20250613144240.GK414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-7-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154051.1319-7-ouster@cs.stanford.edu>

On Mon, Jun 09, 2025 at 08:40:39AM -0700, John Ousterhout wrote:
> These files provide functions for managing the state that Homa keeps
> for each open Homa socket.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

...

> diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h

...

> +/**
> + * struct homa_rpc_bucket - One bucket in a hash table of RPCs.
> + */
> +
> +struct homa_rpc_bucket {
> +	/**
> +	 * @lock: serves as a lock both for this bucket (e.g., when
> +	 * adding and removing RPCs) and also for all of the RPCs in
> +	 * the bucket. Must be held whenever looking up an RPC in
> +	 * this bucket or manipulating an RPC in the bucket. This approach
> +	 * has the following properties:
> +	 * 1. An RPC can be looked up and locked (a common operation) with
> +	 *    a single lock acquisition.
> +	 * 2. Looking up and locking are atomic: there is no window of
> +	 *    vulnerability where someone else could delete an RPC after
> +	 *    it has been looked up and before it has been locked.
> +	 * 3. The lookup mechanism does not use RCU.  This is important because
> +	 *    RPCs are created rapidly and typically live only a few tens of
> +	 *    microseconds.  As of May 2027 RCU introduces a lag of about
> +	 *    25 ms before objects can be deleted; for RPCs this would result
> +	 *    in hundreds or thousands of RPCs accumulating before RCU allows
> +	 *    them to be deleted.
> +	 * This approach has the disadvantage that RPCs within a bucket share
> +	 * locks and thus may not be able to work concurently, but there are

nit: concurrently

> +	 * enough buckets in the table to make such colllisions rare.
> +	 *
> +	 * See "Homa Locking Strategy" in homa_impl.h for more info about
> +	 * locking.
> +	 */
> +	spinlock_t lock __context__(rpc_bucket_lock, 1, 1);

As per my comment on __context__ in reply to another patch in this series.
I am clear on the intent of using __context__ here. And it does not seem
to be a common construct within the Kernel. I suspect it would be best
to remove it.

> +
> +	/**
> +	 * @id: identifier for this bucket, used in error messages etc.
> +	 * It's the index of the bucket within its hash table bucket
> +	 * array, with an additional offset to separate server and
> +	 * client RPCs.
> +	 */
> +	int id;
> +
> +	/** @rpcs: list of RPCs that hash to this bucket. */
> +	struct hlist_head rpcs;
> +};

...

