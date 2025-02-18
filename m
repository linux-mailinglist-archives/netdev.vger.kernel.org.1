Return-Path: <netdev+bounces-167486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F2A3A7B8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131393B1515
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF117A2FD;
	Tue, 18 Feb 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg3HruaQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEA21B9C7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907398; cv=none; b=hS8/23U061lWj2oDoWzdcvkxCTWAUKS01V3jNc90/rIwAaam8h2thSSN7Dnjk/nYVkkzQaJpjctWnOq4/0rggtIoYQbPIHN9HTp2fZdHKqrxN/jLqu31qu4UYajwWCj7u/GNcNFsWbsjrGtv3tWpvKtMim6sk7VyL8m44CVeZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907398; c=relaxed/simple;
	bh=sE/fUARRNHyp59sxR3Q+zmGjFoVYdfhTn6es8kCpY+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOBW7SSUiid/80tKu326G5A6I0490FebY+K35Mc8rTir5e8M/uGofFdyTiCq/SxkGLwo0stE3VozkW7+eBuE1J7FclmcnCr4qFabtelay7tBEWZyYi0j+xOuqCZpMQB1V8UHXuoYEr7tgn/2sSgjTrFhUVt+S+67krIP9+dFedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg3HruaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43858C4CEE2;
	Tue, 18 Feb 2025 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907398;
	bh=sE/fUARRNHyp59sxR3Q+zmGjFoVYdfhTn6es8kCpY+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rg3HruaQUZRaemXPdH7hU1+YsgDYCL49kSeh7PZxgTZruKMxIzlASQKxq9CVBmSK/
	 69o5gw10U5eX1CXLZ6D8vWHvkrz7Tyeoz4jwJIOTwh4/sgX3aKrD3u+Wm7IGolHt4i
	 DW/CWP0cY+sqHYzKPVy8HZrlL0OXqEjXtV25zNe/9YfryW9GVkSCC9PCfCq+AkGyJs
	 C2bsOBXxazBJijAH0RmoXv+lPwy5Fe84au5SavsLAEHcReHwjPjJh2VnIOjciAz+cm
	 LcYgjDQVw0cIzCANk1NDe3FtRBGn15DGfXWn6uIVad7+I0cKM7LWZjU29rAsbeyWAU
	 /EMs2+ZgrTEKA==
Date: Tue, 18 Feb 2025 19:36:34 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [iwl-next v3 2/4] ixgbe: check for MDD events
Message-ID: <20250218193634.GI1615191@kernel.org>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217090636.25113-3-michal.swiatkowski@linux.intel.com>

On Mon, Feb 17, 2025 at 10:06:34AM +0100, Michal Swiatkowski wrote:
> From: Don Skidmore <donald.c.skidmore@intel.com>
> 
> When an event is detected it is logged and, for the time being, the
> queue is immediately re-enabled.  This is due to the lack of an API
> to the hypervisor so it could deal with it as it chooses.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


