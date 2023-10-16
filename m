Return-Path: <netdev+bounces-41188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B827CA2DF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0221C208CB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8B1A29F;
	Mon, 16 Oct 2023 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTVwj73m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9B1548F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39D6C433C7;
	Mon, 16 Oct 2023 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697446579;
	bh=1AHKkjopLy9MQ2QaX0CMu3exjv0u7VlsqlSyKEPL17I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTVwj73mH4w8wkLtKxMBFbXppul9fJhr+aXijweVOwj/yAN+p6H+DVcthn0x4ZxrH
	 WNWEVkbFlxG3zbRPgjplrcrzxbN/oIs4zJQNqGL93wenT/OfI3QIv0T4b5z6S2PRuz
	 OTKz9XQ4qccllse9iUSs5S9NQsSzY0LOBZ4VxN6LkxejfolOUT1VcWVU3CEMRNOsta
	 Fjo2Bb124+cbUWwQqzhbHw6vXHr04N4bYEn8sbI9/vPLIzRFP6FHovH5dMvEn1tCmI
	 uNEaWIxvTuPV6cokexqMWvx8jdi0NSOAh/eLVrmPpAouDQY893Zn62mKS1XvdY93yh
	 eTvWTlL0OLnLQ==
Date: Mon, 16 Oct 2023 10:56:16 +0200
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 0/5] ice: Support 5 layer
 Tx scheduler topology
Message-ID: <20231016085616.GF1501712@kernel.org>
References: <20231009090711.136777-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009090711.136777-1-mateusz.polchlopek@intel.com>

On Mon, Oct 09, 2023 at 05:07:06AM -0400, Mateusz Polchlopek wrote:
> For performance reasons there is a need to have support for selectable
> Tx scheduler topology. Currently firmware supports only the default
> 9-layer and 5-layer topology. This patch series enables switch from
> default to 5-layer topology, if user decides to opt-in.
> 
> ---
> v3:
> - fixed documentation warnings
> 
> v2:
> - updated documentation
> - reorder of variables list (default-init first)
> - comments changed to be more descriptive
> - added elseif's instead of few if's
> - returned error when ice_request_fw fails
> - ice_cfg_tx_topo() changed to take const u8 as parameter (get rid of copy
>   buffer)
> - renamed all "balance" occurences to the new one
> - prevent fail of ice_aq_read_nvm() function
> - unified variables names (int err instead of int status in few
>   functions)
> - some smaller fixes, typo fixes
> https://lore.kernel.org/netdev/20231006110212.96305-1-mateusz.polchlopek@intel.com/
> 
> v1: https://lore.kernel.org/netdev/20230523174008.3585300-1-anthony.l.nguyen@intel.com/
> ---
> 
> Lukasz Czapnik (1):
>   ice: Add tx_scheduling_layers devlink param
> 
> Michal Wilczynski (2):
>   ice: Enable switching default Tx scheduler topology
>   ice: Document tx_scheduling_layers parameter
> 
> Raj Victor (2):
>   ice: Support 5 layer topology
>   ice: Adjust the VSI/Aggregator layers

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


