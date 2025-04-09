Return-Path: <netdev+bounces-180891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E158A82D38
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB188078C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE618270EA6;
	Wed,  9 Apr 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a57XR0c4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED31C2324;
	Wed,  9 Apr 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218470; cv=none; b=mPcOTSYwyFA5gQ5R9UUF/z2QM9AM66WZGAFDh1awhK1MQRFb14F2CXVHdW2gPhFNc3I4TMc+o64MTdz9AqXR8SSk7lubDgLe4dh6zA7bvlzgGJsR5sPUSZu89EaHCu3FNEv6snBYUdbwvSQnxddDi82O0YpHGQHw53PhGVmwxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218470; c=relaxed/simple;
	bh=PcqRDQbAzwE809Lz8qtd+AbOW+ahMuiblP3wSIQB8Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlA9f9umQPvMTOTrCoyiFaq8ebOI/dx9U75BhjigqU6WJJfydkCtdT89ep3AdRnF2NH8+mxEOwejeXqFgItiOi4sbb/co2UY1GtWLAYmXkHY3qMVez9Ln6JlxVaPlQsPnYIAQ87VZY45Ag0125jJgEYMqoP6BPtwlH1WlrBd0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a57XR0c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E47FC4CEE2;
	Wed,  9 Apr 2025 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744218470;
	bh=PcqRDQbAzwE809Lz8qtd+AbOW+ahMuiblP3wSIQB8Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a57XR0c43AffaWmAz1Ed7S/TRdn57sZL7pBF3H7tCtXQAUM2KXRXXq6ioEJRw5WVw
	 rpZDto+ddqJoC6HYDwcWVYHBOy79rwxs7Lo+qeu7/U+OUyZFeO/IjzNAUZCsvGTmAi
	 fQ8PBep3dK71lPOvym3o3tj3kDYtLE5xU0IByVZsRh1vq8rNBs3LpGVhh5ps/OZbbl
	 941G4LCV9sfUzJoOwzupdnuEjfbug7GmjcD2iKk4+DfvcHLJiIuFPOWxPGeFnusMNz
	 TN8SRDnQsLHWL5SCoiYntMb46wkdnnmGnUv8WiEY4vj/FCiMYFYXbzrvQUrH8YgQTN
	 HOLsk9c8VGjag==
Date: Wed, 9 Apr 2025 18:07:45 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/6] pds_core: Remove unnecessary check in
 pds_client_adminq_cmd()
Message-ID: <20250409170745.GO395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-5-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-5-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:11PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> When the pds_core driver was first created there were some race
> conditions around using the adminq, especially for client drivers.
> To reduce the possibility of a race condition there's a check
> against pf->state in pds_client_adminq_cmd(). This is problematic
> for a couple of reasons:
> 
> 1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
>    cleared until after everything in probe is complete, which
>    includes creating the auxiliary devices. For pds_fwctl this
>    means it can't make any adminq commands until after pds_core's
>    probe is complete even though the adminq is fully up by the
>    time pds_fwctl's auxiliary device is created.
> 
> 2. The race conditions around using the adminq have been fixed
>    and this path is already protected against client drivers
>    calling pds_client_adminq_cmd() if the adminq isn't ready,
>    i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().
> 
> Fix this by removing the pf->state check in pds_client_adminq_cmd()
> because invalid accesses to pds_core's adminq is already handled by
> pdsc_adminq_post()->pdsc_adminq_inc_if_up().
> 
> Fixes: 10659034c622 ("pds_core: add the aux client API")

I'm assuming that backporting this patch that far only
makes sense if other fixes have been backported too.
And that their fixes tags should enable that happening.

If so, this seems fine to me.

> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>

