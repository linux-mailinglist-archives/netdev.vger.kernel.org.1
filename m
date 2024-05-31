Return-Path: <netdev+bounces-99799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD728D68C6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6260289CBE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C8176AC1;
	Fri, 31 May 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/i5CsIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F24C62B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179308; cv=none; b=MIXJ0okmfxtQifW7u3Jgwt2ZKtwQRFvsT7q+Ijm7wIVc1bZB1t8oCm/wA5uAglt2Z8vBU+KgB3HGdwyC3GWrRXIh7W5eBCFelF7+tfDqiC23wxntHDH7wY2wJWrP/vTcBD+L7AAOTGaceQZc6tm79GdZMvXfpGPAJAfCs/ma6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179308; c=relaxed/simple;
	bh=8A5AiCOfaCmfwQ8xPFJjOIOjqBcwPjrYEDrU5qXdxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZJQFWgv6jtr8BTalaugy8Ze1dbuQv4FiGJZMajM0jGk7iF2DmMPnzuG+5CH6wKQzm6qwGdDMIcNDedQ6NYWZF2E3hOAjT5ccslb+Q2YCG9ModVH10oiPM4TV3M2knSb9DJHqIF9wT7fp+NezJy4RCoQAnpHCwjSGZp7tKWe8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/i5CsIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DDBC116B1;
	Fri, 31 May 2024 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179307;
	bh=8A5AiCOfaCmfwQ8xPFJjOIOjqBcwPjrYEDrU5qXdxpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/i5CsIVOSt+67w1kCX0TjL69N2ang5LKzLtVcdo8ybBx+5vG4CpO5M29nwiKqZeY
	 lTSdtKOeiG85q72Jp4eZeUEUmp/GVdnzgTJZnpGhIuJDH1pXL5XeM5UGcCsLkFQQZ4
	 Z/oKj9p6pjxtRdryh3/l2TCY7ZwOWnHzhd8qAQ8aaB7ulUzQKOdKuBPGw8Bz0jA6Nl
	 /XHfzIoYuLupATYjQQgQdF+rQhbwk2nMC4lD/+ftrs/gmH8+q9jPUivZZ228PgqUge
	 h4vLXHoH55tEgdnXxi2B3vgZW0VAinoNJJVMPDi5s82rRQ6aYA5KGKd0KO3sxnA2/r
	 /qJ2dcWakFH/A==
Date: Fri, 31 May 2024 19:15:02 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 03/15] ice: add basic devlink subfunctions support
Message-ID: <20240531181502.GG491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-4-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:01AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Implement devlink port handlers responsible for ethernet type devlink
> subfunctions. Create subfunction devlink port and setup all resources
> needed for a subfunction netdev to operate. Configure new VSI for each
> new subfunction, initialize and configure interrupts and Tx/Rx resources.
> Set correct MAC filters and create new netdev.
> 
> For now, subfunction is limited to only one Tx/Rx queue pair.
> 
> Only allocate new subfunction VSI with devlink port new command.
> Allocate and free subfunction MSIX interrupt vectors using new API
> calls with pci_msix_alloc_irq_at and pci_msix_free_irq.
> 
> Support both automatic and manual subfunction numbers. If no subfunction
> number is provided, use xa_alloc to pick a number automatically. This
> will find the first free index and use that as the number. This reduces
> burden on users in the simple case where a specific number is not
> required. It may also be slightly faster to check that a number exists
> since xarray lookup should be faster than a linear scan of the dyn_ports
> xarray.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


