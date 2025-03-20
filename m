Return-Path: <netdev+bounces-176524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E6A6AA72
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A1B3BF519
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425B11EB1B7;
	Thu, 20 Mar 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsgdW6KW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9481EB183
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486311; cv=none; b=AmQZzgNp8DjhQqdA9Uk8MihfOkIFN2A0+XOJvdkCFv2Sw9ccPeutTg8iFBiraO/RNCKdxiGb3W134/WccYJo43TBUrr9xtB2MqhwEKmsrpLa4qY31LT/zej/ri0PqAa95sZxmCL7q5yX3NyTwzi5wVk++NXJC8FuyUde3cFV9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486311; c=relaxed/simple;
	bh=P4yOgsPSR6ebCWT4lPi82dwb4wRtQRAAFwWpcS34rzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvdsXcPYolYX85VCZsH0LC2gWTxCcCITLnfX+YvryTDUmOAOhA6HXaGQC+1ZyP53OYSIkP0PAPmVxGkfPEresw7BxBGIiJj4NaP5q6ek6RBbidoYQyc7M2CnW/k13FPsjtg+WLZGUicwXi8ze73hGws8enOLBE0c1nFC2FM0t2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsgdW6KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DA0C4CEDD;
	Thu, 20 Mar 2025 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486310;
	bh=P4yOgsPSR6ebCWT4lPi82dwb4wRtQRAAFwWpcS34rzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsgdW6KWCluPvEaMUSQ2xKlvNNPWWvgIYMHDSBTZXRMZoJ7L0yrRCGKiJew5f99Rh
	 8YnSMdL71KgQ52xfZEyNw7fPwT+DkXrcY14l4nYIpjQEAhUA61B0Tg1Hf/j5NqEA+Z
	 8X0BjHT92D3oyCOpJBDegUjGGh6zBLQqjlz13CSVY3t5K5g++www1NJsdgvirgJdVs
	 K1kl+GC3FP2wBPvLbzZ3lXuRMtj7PX4EjIgwJvb1bXWSvdJ86ow6tniZMTdx3/DAJz
	 Yf0sODnIqy7owQIERNEYnUlltywLsq62W9JRpp7HTqjZEGvsfZTPwxsy3y1BU1I3f3
	 lIKEeo3kh6DJQ==
Date: Thu, 20 Mar 2025 15:58:26 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 3/6] mlxsw: spectrum_switchdev: Add an internal
 API for VXLAN leave
Message-ID: <20250320155826.GF889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <f3a32bd2d87a0b7ac4d2bb98a427dc6d95a01cd0.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a32bd2d87a0b7ac4d2bb98a427dc6d95a01cd0.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:28PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> There is asymmetry in how the VXLAN join and leave functions are used.
> The join function (mlxsw_sp_bridge_vxlan_join()) is only called in
> response to netdev events (e.g., VXLAN device joining a bridge), but the
> leave function is also called in response to switchdev events (e.g.,
> VLAN configuration on top of the VXLAN device) in order to invalidate
> VNI to FID mappings.
> 
> This asymmetry will cause problems when the functions will be later
> extended to mark VXLAN bridge ports as offloaded or not.
> 
> Therefore, create an internal function (__mlxsw_sp_bridge_vxlan_leave())
> that is used to invalidate VNI to FID mappings and call it from
> mlxsw_sp_bridge_vxlan_leave() which will only be invoked in response to
> netdev events, like mlxsw_sp_bridge_vxlan_join().
> 
> No functional changes intended.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


