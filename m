Return-Path: <netdev+bounces-209384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4440B0F6BE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18331CC7A02
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE329B229;
	Wed, 23 Jul 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCcuC1j4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F41BF33F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283320; cv=none; b=Jx1rM5O8Lq6LyOPesDqmh8pxf31NYoISGwP34mnOzcYRSuclf/n9bhzTYKvvyhpqbIYMqkV9/mhppqmDeaVvuoK+I5Q15tBVhGuQiJ8J/NJo1yyi4ONyf/FlkaCHgGRyJjdUe05muRE3iLpavSxU36u62lyjTOrPwfGxRrxlcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283320; c=relaxed/simple;
	bh=6ac3yCnZRiKybVgrw6uQZVIG3hlH9OMCgFZI/ldwaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slpbHyhxCKHKVrXSsMEDDFREgahSkNdvFlU+WF+/tGVHHcFnEmhLL7/sXGb4FPIGQZ6tNb8+K5ZKHk7INgsRH8NgajkROeUH/PuxeUjE5aIfoGfbyZjuG/yuehRE25lKtV+GDj3u5akT3g/7RHZFIboPA3z4+GDcWRw9fbDnm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCcuC1j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75B0C4CEE7;
	Wed, 23 Jul 2025 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283319;
	bh=6ac3yCnZRiKybVgrw6uQZVIG3hlH9OMCgFZI/ldwaNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCcuC1j4/HvMAX6yDgfCynzSqRMJKiz6BFuNsLjc4qnyCMxvg59LqbpoKMD4FFxoe
	 Aah0Xn5Q3OO0fstFULQZANvHkTSSLTXmWkJnsv2Ipz5ZUyVWd4JYI0tzdi6iH4wzNF
	 2oxLvqVobo73qklxtrhDb8rajRKlXJjD4KX9ZT3gptbG9PQpHx5ANNnX0ldmD1OKvX
	 BTyINyWt8LLZQsJFJqSmKCY1fIyVBEzUH++/W4clUsc87UQN/28sc84ScqM8meLwQR
	 7H82UuRfdO3gmvW0751Hm1RnzzpjR9kz1nx5SqjcU6FJDVhdevS4YFGYm44nEaJYlg
	 W2uslGEdGJZVg==
Date: Wed, 23 Jul 2025 16:08:35 +0100
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2 0/6] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Message-ID: <20250723150835.GF1036606@horms.kernel.org>
References: <20250718002150.2724409-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718002150.2724409-1-joshua.a.hay@intel.com>

On Thu, Jul 17, 2025 at 05:21:44PM -0700, Joshua Hay wrote:
> This series fixes a stability issue in the flow scheduling Tx send/clean
> path that results in a Tx timeout.
> 
> The existing guardrails in the Tx path were not sufficient to prevent
> the driver from reusing completion tags that were still in flight (held
> by the HW).  This collision would cause the driver to erroneously clean
> the wrong packet thus leaving the descriptor ring in a bad state.
> 
> The main point of this refactor is to replace the flow scheduling buffer
> ring with a large pool/array of buffers.  The completion tag then simply
> is the index into this array.  The driver tracks the free tags and pulls
> the next free one from a refillq.  The cleaning routines simply use the
> completion tag from the completion descriptor to index into the array to
> quickly find the buffers to clean.
> 
> All of the code to support the refactor is added first to ensure traffic
> still passes with each patch.  The final patch then removes all of the
> obsolete stashing code.
> 
> ---
> v2:
> - Add a new patch "idpf: simplify and fix splitq Tx packet rollback
>   error path" that fixes a bug in the error path. It also sets up
>   changes in patch 4 that are necessary to prevent a crash when a packet
>   rollback occurs using the buffer pool.
> 
> v1:
> https://lore.kernel.org/intel-wired-lan/c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de/T/#maf9f464c598951ee860e5dd24ef8a451a488c5a0
> 
> Joshua Hay (6):
>   idpf: add support for Tx refillqs in flow scheduling mode
>   idpf: improve when to set RE bit logic
>   idpf: simplify and fix splitq Tx packet rollback error path
>   idpf: replace flow scheduling buffer ring with buffer pool
>   idpf: stop Tx if there are insufficient buffer resources
>   idpf: remove obsolete stashing code
> 
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 723 +++++++-----------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  87 +--
>  3 files changed, 356 insertions(+), 515 deletions(-)

Hi Joshua, all,

Perhaps it is not followed much anymore, but at least according to [1]
patches for stable should not be more than 100 lines, with context.

This patch-set is an order of magnitude larger.
Can something be done to create a more minimal fix?

[1] https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules

