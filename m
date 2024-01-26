Return-Path: <netdev+bounces-66228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655C83E0E2
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F3D280C47
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187220325;
	Fri, 26 Jan 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH9oC6SY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC451BF44
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291472; cv=none; b=W74aOXIjPamzpuXiirMhzElpZ6KwuUIhs4Y+8TE/LdoHYSLoTwbIZvUGoGNqWezHkOm9i1w7+Csn2Iex64PhETjhPRTjC/PkrYWkcgz9mIPNUfcK7n22vsQnpIhReJ1plQcw1ms/CFZycJtLPUdYqBJOY5meYKDfdzxzg9FqSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291472; c=relaxed/simple;
	bh=xYlmBsenQr8hdoyjMRz9OkQNyQh55NtukTE75S7Jg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahgbaIO9+05A5MdJvSCvOrdo8pws2UOPQ4PZ/tqqHBnaH8KkyPUKLU4+tX1meK1gKnYhdaoS7fEJvS211HWNavEDSPm8dkGKEGo2f1FQsGeV75KyeHHLv/j8M+qD9mAvXSoIByevF9R4hTdEJ2Z3tGbZdyXh11KzV7GXuNUyNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH9oC6SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08330C433C7;
	Fri, 26 Jan 2024 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291471;
	bh=xYlmBsenQr8hdoyjMRz9OkQNyQh55NtukTE75S7Jg3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cH9oC6SYOD5onM/srS2Szrc1q/27LPbRpKWSA8+tlEIXyGuW/45IYeMinRoDbwSMn
	 J+b8sC3hf0xVGajlbB8RPDv58XcrNS1TWmX1W7Qw7kqIangeW5LmM8isrqiyCLpmnv
	 ufYzqZoacM6ZlNH/wdbJqsObg64WYVNqEANmhxHEQCzHSFO25Ucevqyj5BEGbDQWSD
	 Lxje2meCm3Q3n4k9TdmbDRm+gHP2PAPeYudAB9d0yhKGBcpYG6dRGcro0/jZqrdDOO
	 +dWQz2YYALSGf2zgwfcvpfwzq48LXdVl6SRHw43ZUDu4FEz5nCPe5HJV7yoiQeo08j
	 wTVKSz19SjNTg==
Date: Fri, 26 Jan 2024 17:51:07 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	brett.creeley@amd.com, Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 2/2] ice: Implement 'flow-type ether' rules
Message-ID: <20240126175107.GB401354@kernel.org>
References: <20240124152141.15077-1-lukasz.plachno@intel.com>
 <20240124152141.15077-3-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124152141.15077-3-lukasz.plachno@intel.com>

On Wed, Jan 24, 2024 at 04:21:41PM +0100, Lukasz Plachno wrote:
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.
> 
> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.
> 
> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>

...

> +/**
> + * ice_set_ether_flow_seg

nit: @dev should be documented here.

> + * @seg: flow segment for programming
> + * @eth_spec: mask data from ethtool
> + *
> + * Return: 0 on success and errno in case of error.
> + */
> +static int ice_set_ether_flow_seg(struct device *dev,
> +				  struct ice_flow_seg_info *seg,
> +				  struct ethhdr *eth_spec)

...

