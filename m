Return-Path: <netdev+bounces-109910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A714D92A416
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1D1F21663
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F610132121;
	Mon,  8 Jul 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmpSpmso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9E1B970
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446754; cv=none; b=PMvMS2SqdGB1bDCytS07p/q/g19kgi8RplKZwEj/dcGX1PoYOMBvadp1Acm0WycKwR6OpGxHEfPUmLtG8Wc8aoMSJpovjYAXiS4cqed5RKYA2J58c3sObM/S/kbL7N/fvamW/chfFwT4lAc5FWc95gpx3moxmUrGXyblnV5HBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446754; c=relaxed/simple;
	bh=LCYVdr6UQo9gzA4OPYFJ4T1bPUoeJNQC5T6gf/CYb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sITCmvQ7HigZL7wWepVWJZDyUnydb9+jHFjzxoYmF4AYpucV6Z42krux0M/N6j/0ILRPWjW8NnyX26xHdLxarQu1jZm+HzxGycMufbBZPExPfXbUQW3FzBq3oP2BOCWiKoK9dYRL5sEqyPX5duhZvrpyjdhARS33A0Vd/G0eSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmpSpmso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AAFC116B1;
	Mon,  8 Jul 2024 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446753;
	bh=LCYVdr6UQo9gzA4OPYFJ4T1bPUoeJNQC5T6gf/CYb/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmpSpmsolN31ReQoVzmW2WupuBtyn/aIM77MaXeCFjqmaDTzvmrOK/6UT6R+FEcai
	 VENesspDvt6veTSea2qmlwp7C7UafOSgJ+XO6kXLtN3gfWkNvu8pz6wTOx3bf2pQqX
	 oBVDDhK/sq5P8YamRGSw/ZVUCCmKIb8aPZl3VckIkePsVZeAy4LxkCuIGg8+SHnLrP
	 AAXCb8g0/7VAuVtbDwWpkYAUfQnfiVDom2+4Db1MsU8TUihi5PPdrmnY5CHmS4qWGl
	 cC2l9zXcgBfAWuRoTqcpMqnrlj6QI8bdynjXCCPXQGhhbb7tSw4itDzjAMfwyQ8cKf
	 deOdOdpXa9A8Q==
Date: Mon, 8 Jul 2024 14:52:30 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v8 2/7] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20240708135230.GU1481495@kernel.org>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
 <20240704122655.39671-3-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704122655.39671-3-piotr.kwapulinski@intel.com>

On Thu, Jul 04, 2024 at 02:26:50PM +0200, Piotr Kwapulinski wrote:
> Add low level support for E610 device capabilities detection. The
> capabilities are discovered via the Admin Command Interface. Discover the
> following capabilities:
> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> - device caps: vsi, fdir, 1588
> - phy caps
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Thanks for addressing my review of v7.

Reviewed-by: Simon Horman <horms@kernel.org>


