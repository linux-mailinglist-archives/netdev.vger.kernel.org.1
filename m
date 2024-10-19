Return-Path: <netdev+bounces-137192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5E9A4BF7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CED4B222C7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21D1DD0DE;
	Sat, 19 Oct 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVOPbAfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29612032A
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729325516; cv=none; b=hNqYHIAnILJlSlVtfRFrUhaZtzFXpOz7+V0aCBBzlQj0ORB8UBsh7/GxTYYuVWf6w4MTkWDtAr59xaLuJRRiQDT1tjILYdRVAuheOxmrEZMbkeYbRK7EALtv9nNEqCWStoSsfdK/9kcSg1RLKOS7RiGc+MY9BXgMRwlmQi0qB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729325516; c=relaxed/simple;
	bh=QmK0ulrEPKUfiR3BuJg+I7mX6gD2ELUneUo+Z2GLeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm9+goqTjHorIV7hJtGdCRCh3FVLevWtHa3vaJIp7G9Kp7FuRaGw59M8l8IRTCxCZG4iw2D+cYf2V4YwdwAabfCA/pV8lTZIWVA3j0I+S8Z9t+OA1TdkORFCL4eHQNYj4/gFEPb3Hk+ixKJUtqPuNUj/bgykoWNg0J9gJwbayWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVOPbAfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E1DC4CEC5;
	Sat, 19 Oct 2024 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729325516;
	bh=QmK0ulrEPKUfiR3BuJg+I7mX6gD2ELUneUo+Z2GLeqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVOPbAfpee01UvI712jROprLeQKgwR05F/bIXLFNs2dtDxmGi3PE5E2toswXowAn2
	 6mtFhx3NUHvY9DehFnDzId3VfdGaOH4cpHOulCjZkPmVlYHxwzMFbZUVefyIAsFRPK
	 3Npo1XWQM06UNh5UcvPPXk6tCOmrLkGH7GUpOHEn0wN4EVkps66mTRMTxAiIGalulZ
	 nSHgJa2NIOYI+5/oo/DTipPc4e7A2Y4DXFTKisjip9MS/yScepP5IIRXfFqWyr6+XG
	 3v1EERhLxMwIBr0S9FjRsTCPlC6+yorfe7srW1e76tqKEvmYgcaBnXltf3tPVQ+MtQ
	 ZnrB5Pv5iFz8g==
Date: Sat, 19 Oct 2024 09:11:52 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	brett.creeley@amd.com, mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v1] ice: only allow Tx promiscuous for multicast
Message-ID: <20241019081152.GH1697@kernel.org>
References: <20241017070816.189630-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017070816.189630-1-michal.swiatkowski@linux.intel.com>

On Thu, Oct 17, 2024 at 09:08:16AM +0200, Michal Swiatkowski wrote:
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when any VF is trusted and true promiscuous mode is enabled on
> the PF, the VF will receive all unicast traffic directed to the device's
> internal switch. This includes traffic external to the NIC and also from
> other VSI (i.e. VFs). This does not match the expected behavior as
> unicast traffic should only be visible from external sources in this
> case. Disable the Tx promiscuous mode bits for unicast promiscuous mode.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


