Return-Path: <netdev+bounces-163918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EFA2C034
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD63A307F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967141DDC20;
	Fri,  7 Feb 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk0iWvUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD11D31B8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922747; cv=none; b=i0lsyDncY/KI5syHIMmbyxi2mtGktClHKf7V4nvrUURk+hdYVPIJMg/08aCCZd3CDFyvmIhQDzMfySYeHxHEk9rLXNBmI92yrNu1fPN8Rnp0EcraQ+CyYyi//mm3L4JJpqhXPTIkQmpyQvxSKpODvLfyZtKHdP/PyQdJYv8TrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922747; c=relaxed/simple;
	bh=MGNJPt+YsRpuH8tr53yUSWWSv+odu8ZuGiFak8uu0HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/lKd6WgZwWxKSrTMLYac3sWvSJK9TgVcE80TGefLTRDT8LxRxNO1bvPt2jkzcYd0rLDLrpKcNwWBfVi528u50PMAgd2Okq7lrC2VEVDdENtiGbyHahfRrKm0KhWRsk+kqIFJfyjHhkE5Axtm7Fn0ph+NiDXKNZCaZJeBuRnhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk0iWvUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954B9C4CED1;
	Fri,  7 Feb 2025 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738922746;
	bh=MGNJPt+YsRpuH8tr53yUSWWSv+odu8ZuGiFak8uu0HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uk0iWvUbxtRspeWHlVFjUbt3PdzfM+MHoDAwluv4OxLV/U7eEZfZfVTxNaVARPj8l
	 RheCDhXge1E4j+nNxHN3iYECHXYwXG5o+AcFy6of8zN3O36b9eApAhGsPje5uIl06I
	 ZYEupTrqaOB5Q53RvHyekVHV6ez/GLLVxrP83IIhYXvskPCjgI/ODGdCmg3Q4UGPV+
	 +dftuB000PnEQ1bmea0jfotJPgL2rKswqJYNTAqq9ODfTnYopMuykmFFZbzHNsROb3
	 SWRQQU/XKDnAgySxsg8igPmPxo9GAf8boPrllulRLs2hy8gzZGhkPBMvsk15X5tFB+
	 ZIlcMa7wcpskA==
Date: Fri, 7 Feb 2025 10:05:43 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v1 2/3] ice: Refactor E825C PHY registers info
 struct
Message-ID: <20250207100543.GL554665@kernel.org>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
 <20250206083655.3005151-3-grzegorz.nitka@intel.com>
 <20250207100345.GK554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207100345.GK554665@kernel.org>

On Fri, Feb 07, 2025 at 10:03:45AM +0000, Simon Horman wrote:
> On Thu, Feb 06, 2025 at 09:36:54AM +0100, Grzegorz Nitka wrote:
> > From: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> > Simplify ice_phy_reg_info_eth56g struct definition to include base
> > address for the very first quad. Use base address info and 'step'
> > value to determine address for specific PHY quad.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I failed to notice that the kdoc for ice_phy_reg_info_eth56g
needs to be updated to document base_addr instead of base.

