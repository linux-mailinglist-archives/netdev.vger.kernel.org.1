Return-Path: <netdev+bounces-114101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDE940EED
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424A91F23AD5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC53195B1A;
	Tue, 30 Jul 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbE3e+xp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64C195997
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335024; cv=none; b=oJmaluXhUT8qmx5Va22ah4p7E901kqAMuSljts1gtd2/K5xeS4EHV1EXpuKiIyE1gigdgEQQbLEr8uM46GrfXVT26kGtG4wXKGArDOH55Cdb6U2fjClZ9Fi1RxB0WhYJrRQntJmefNyl8oRSb/Tl9vAcO0bEThVGd/NgtfEXfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335024; c=relaxed/simple;
	bh=63xEIcvXjlR02Hfdugx6BZutPkEtvIG450jNMfawbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrepVvg6G73jb7H+nHqnZ0CS2PMU8reZQNte66SwPXlFTrbaq2HQJI8w/G42hsG4fIwFFsrRphYKW/AYboeA+kXMEtfnX5FTfcxxIGRsJIvekSd4iqzSGsGFiBBurfBPgWc64u1DfN54+NEsqmfrtGULodkcPFENcj7RCIzv4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbE3e+xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E4C32782;
	Tue, 30 Jul 2024 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335023;
	bh=63xEIcvXjlR02Hfdugx6BZutPkEtvIG450jNMfawbKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbE3e+xpn6vyHWMeQ+uoHM97DCxhzDqPtRSeB/HzeXGjBdF082v43QB6oRPAiGxS0
	 UmwlGWpctecsIAKDTFpghzwHBSUbsH9Geywt5Uk+SqyT+Mvg7O79rvLZ5kdlr8Iax4
	 +/cqwUFyE/kJOQBh/pVOwwacUyPUxCr85iKbOeDxiNFMIo1wxP3MpvMemugtZABooz
	 +DDgYws5CO5tJKQMIv5HWZmjO1yJjyRcFlwIR2pV0EczTKZBrvl7fV7JdyCL1RXdqO
	 hviHGkBve7kYUkh7cTAhZm0yK7vj13aFql52YySgvezKt6QFuTFURrew8iNGG/ocb3
	 5sxVsp/R5Mj1g==
Date: Tue, 30 Jul 2024 11:23:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 10/13] ice: add method to disable FDIR SWAP
 option
Message-ID: <20240730102339.GW97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-11-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-11-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:06PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> The SWAP Flag in the FDIR Programming Descriptor doesn't work properly,
> it is always set and cannot be unset (hardware bug). Thus, add a method
> to effectively disable the FDIR SWAP option by setting the FDSWAP instead
> of FDINSET registers.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


