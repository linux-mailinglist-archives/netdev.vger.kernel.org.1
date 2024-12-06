Return-Path: <netdev+bounces-149726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D09E6F2A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2455188398C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F03206F34;
	Fri,  6 Dec 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR6LEBKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436B202C4A
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490999; cv=none; b=I2Qmo6yG5Hmzzr7A/LyKXagWxGFLcZ1aAa0LQ6ne8AOqehIwNtXeQUd3uuRwDoUEk2ythphl/DSPXUHRcpd4gsIFDF+hleRsrddXbj5nLTaWVccdf7Lh6Bba6Z57kq/WCe8LiQtldgHpRqg/6xbi5MBMfOqWZWLk7KroiraVD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490999; c=relaxed/simple;
	bh=wFMtQuON0MWgenzgJh4EM+D4LwMQ2n10g48psQOK3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsl5WjZAb7/6TprZpNKUDxCU9DjW+b5R5p27iSu1mATWwHe+R9gAL2riauzFF/R3E/7cP9f3REwhnFERGRa9kXKMODG4WOAio+3lEl0vf0GHiNSiCkKSMbD5Owx+Bt+gap9RU2DFitLlqE4S47dviMAJvdwyx4WYj8EGe6pnRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR6LEBKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D169C4CED1;
	Fri,  6 Dec 2024 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490998;
	bh=wFMtQuON0MWgenzgJh4EM+D4LwMQ2n10g48psQOK3KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PR6LEBKd4LUsl3PtshVfjsjCuocJt31lbOl++w9bQa3905LgBdSqgUdopjgT7uDIA
	 3LFTjFWjfKW68YUcE24zdTUpcx6fBfugClJxdV/+df0EIrwrBfgPr4AeguSCCsdlky
	 C6LUwvG7f9yKvzWVRtgCiHEXHyUFrH09Q2ptm5LpOyvciZanaCuUXygbpEQNSIz81Q
	 yKR+Q1QxDZxCeNMM43XHGSnqDI+ZQzNvQ0aYelWR/Mjl2DsTkGdEgkDXJ9VsGldVT6
	 af+imMkWTpK6omj74cdjLlQ5nbE0IVun9fBpUTBrtAF0sO7LWORht2l2Byva+ATorX
	 knmv2CZqz3Gvg==
Date: Fri, 6 Dec 2024 13:16:35 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v3 iwl-next] ice: Add in/out PTP pin delays
Message-ID: <20241206131635.GP2581@kernel.org>
References: <20241204094816.337884-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204094816.337884-2-karol.kolacinski@intel.com>

On Wed, Dec 04, 2024 at 10:46:11AM +0100, Karol Kolacinski wrote:
> HW can have different input/output delays for each of the pins.
> 
> Currently, only E82X adapters have delay compensation based on TSPLL
> config and E810 adapters have constant 1 ms compensation, both cases
> only for output delays and the same one for all pins.
> 
> E825 adapters have different delays for SDP and other pins. Those
> delays are also based on direction and input delays are different than
> output ones. This is the main reason for moving delays to pin
> description structure.
> 
> Add a field in ice_ptp_pin_desc structure to reflect that. Delay values
> are based on approximate calculations of HW delays based on HW spec.
> 
> Implement external timestamp (input) delay compensation.
> 
> Remove existing definitions and wrappers for periodic output propagation
> delays.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V2 -> V3: rebased, renamed prop_delay to prop_delay_ns, reworded commit
>           message to be more descriptive
> V1 -> V2: removed duplicate gpio_pin variable and restored missing
>           ICE_E810_E830_SYNC_DELAY

Reviewed-by: Simon Horman <horms@kernel.org>


