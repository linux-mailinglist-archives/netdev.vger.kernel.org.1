Return-Path: <netdev+bounces-181600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DEA85A60
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF2189EEB4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85AF221293;
	Fri, 11 Apr 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqdLASoA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402C20DD47
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368276; cv=none; b=iUEs4bFYYfgR3eZ4U82QbiFC2e/YUSzkf7Nyr0D0MHZDg7Q5RdxHKPwTFhrqM+vAR63b2DLbh6egfqdXlaU8ssF0IYNrC+REfJZKiAn3wXpFshyHAAJgk3LOKEqbYPvhsPaAQ9A3pY2wBbtH5jOTeSDQrdBJ/hL0vJAO3qpwqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368276; c=relaxed/simple;
	bh=h4bx2Fgct43nQkrQDm6FzxOeMDQd5ZE9c+zZxfj9pOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZowJAtyRv9wv7w6RKkP1hCrKj15RIxyTimhfnNwII3yQbwtu+JptPwKZAi3Km1UDTNUgHgsKPnzPjdH7O+rWVtuu/eioWR19Jl7ErCWz4p9xl4oFqKiNpbKfqOv540ZfmsFywifMfMA8N2pxhOO68lZbyd6J3pOQxmD+HETAstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqdLASoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E2FC4CEE7;
	Fri, 11 Apr 2025 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744368276;
	bh=h4bx2Fgct43nQkrQDm6FzxOeMDQd5ZE9c+zZxfj9pOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqdLASoABuEw8IDTeBaQSGMFQlpZHSA/zBZ53vpub/9yBTsPWm8P/80cm7q7P0lAI
	 Cg1WdppcD8MQO5yeISDsIhgkFXwjBvPrMggqLIuXPqjePAUBhNX61AAK8UsPsmNsTN
	 f911S4uK/x/lfoWG1ooV1BQ1Nct+u4j2ymrl74RmekSKBpFn1hhtjFMBomML5jOLrO
	 rzyMbBqPC/3fxPHqd0JdtpxFiyT1JOJXFYZCLYoJiSOEko9MGqg2hQ4YgMSNMh5tTB
	 CWQ5dfpjfKH3ybaEclwSH2huKI2bNsdOg4OeyHUSR9VdA6FL4fQdIYagNMy7jDxYvd
	 YotDyt9ThKyKg==
Date: Fri, 11 Apr 2025 11:44:32 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH iwl-next v1] idpf: remove unreachable code from setting
 mailbox
Message-ID: <20250411104432.GZ395307@horms.kernel.org>
References: <20250409062945.1764245-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409062945.1764245-1-michal.swiatkowski@linux.intel.com>

On Wed, Apr 09, 2025 at 08:29:45AM +0200, Michal Swiatkowski wrote:
> Remove code that isn't reached. There is no need to check for
> adapter->req_vec_chunks, because if it isn't set idpf_set_mb_vec_id()
> won't be called.
> 
> Only one path when idpf_set_mb_vec_id() is called:
> idpf_intr_req()
>  -> idpf_send_alloc_vectors_msg() -> adapter->req_vec_chunk is allocated
>  here, otherwise an error is returned and idpf_intr_req() exits with an
>  error.

I agree this is correct, but perhaps it would be clearer to say something
like this:

* idpf_set_mb_vec_id() is only called from idpf_intr_req()
* Before that idpf_intr_req() calls idpf_send_alloc_vectors_msg()
* idpf_send_alloc_vectors_msg() allocates adapter->req_vec_chunk

> 
> The idpf_set_mb_vec_id() becomes one-linear and it is called only once.

nit: one liner

> Remove it and set mailbox vector index directly.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


