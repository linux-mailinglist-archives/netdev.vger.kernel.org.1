Return-Path: <netdev+bounces-222232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED84B539F3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F471CC5832
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572EC342C95;
	Thu, 11 Sep 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDs6pDfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331002376FC
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610389; cv=none; b=guTh+hmtlgnRc60CqZcEuTR6uFINWM0ANwhgCUgkOYpxO41qPUcrepYB9jIhigbfE1TCPSlWzBTU6DHiLmar8oczNmXAZUNngAlPYUUk7dL1vJSih8s/YFtz+efr99dMFEuWrbRP2tM8vBctCsiVGivQ/y7U47YobFFB4rF+XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610389; c=relaxed/simple;
	bh=tPhsK+qMBOKVRIOZUkZoLliEDrpfKbzruuBj587DFVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOnYBDEHKKaHiWUU9Z8ivSevbgGS5v1By3c2U/mzglhD30I4skwpB/86lkeUrRgo3pDYe+CXRZRq29K7Rmx8+tMA46qgVEPADuh6nkoNJtO/XXemfgNGSfbr7migd+bCWQEuXv1uNwU2NwU/gt7+NNYCgRjc39eQufsW1P6z4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDs6pDfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59306C4CEF0;
	Thu, 11 Sep 2025 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757610388;
	bh=tPhsK+qMBOKVRIOZUkZoLliEDrpfKbzruuBj587DFVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDs6pDfiOQ2sWYDtKNZW6ODvFdK++JfXXAXDbTZnUznBJYmUO+GwLxRsjgyey7Qc+
	 3LsZs2kxB9gvn8OPhSh0bqOhFWyZ9EBTuXm/qTQhLFWI6LtCZoYJeGR0DbTGuU+y3x
	 R8BK5RruCNS/jB+U5xPsn5PyHlCyf34yEkoJwZ6C8GDimQsFgmxwvpBliZw3mhDOXc
	 Eg5X/kjKTS4nXiCmZpNFgVNDMBGxgVpqMNb7Z+4frR3xDvp3bnVbBwzG1sdEWn6ed2
	 jT90++7iXS1uE7dkx/iEi5F4cMHCilaLYPcNumwg2PrpdC28X6pl30dKatD1gGP07w
	 Sd9KtHQCAiDTg==
Date: Thu, 11 Sep 2025 18:06:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v1] ixgbevf: fix proper type for error code in
 ixgbevf_resume()
Message-ID: <20250911170625.GQ30363@horms.kernel.org>
References: <20250910060108.126427-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910060108.126427-1-aleksandr.loktionov@intel.com>

On Wed, Sep 10, 2025 at 06:01:08AM +0000, Aleksandr Loktionov wrote:
> The variable 'err' in ixgbevf_resume() is used to store the return value
> of different functions, which return an int. Currently, 'err' is
> declared as u32, which is semantically incorrect and misleading.
> 
> In the Linux kernel, u32 is typically reserved for fixed-width data
> used in hardware interfaces or protocol structures. Using it for a
> generic error code may confuse reviewers or developers into thinking
> the value is hardware-related or size-constrained.
> 
> Replace u32 with int to reflect the actual usage and improve code
> clarity and semantic correctness.
> 
> No functional change.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


