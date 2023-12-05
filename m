Return-Path: <netdev+bounces-54066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F9805E74
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EAF2818F3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763A6D1CB;
	Tue,  5 Dec 2023 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzHDlKjW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5756D1A8
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69924C433C9;
	Tue,  5 Dec 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701803767;
	bh=dFHThxBmnjrmmteNpPiNVEIBTX15vyVkyAINGkaYRe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzHDlKjWO3GvAifXp8J72cUctfpy+jZDLA0bBhY2yeXgqOzotz944ixeLAlzh/Nan
	 jYrRdd8fkHORjFD7cyc5aqjKqy9mzCD94T3vrejrcn+MUevuBLDoHSYNVfl2C+JWA0
	 9TuRExl15t3bLIpeu5foPvdlPcYTEozi12JwnjWw/ilz8pMjy3xJiHE3qSA3Gdaq1W
	 JXWpMe5FMQ8oBolm0cUuIb+P22pszymtWg2bL3X38nKKwUA1jht+gsnklq8yCxD1FI
	 wMHSUV+R+Bpo46VAyuKxtcLUnDjWrH7X5fbakpHv3/DPu2opxovA6IXLvgioNLtM2V
	 fRSCYUbfz/NZg==
Date: Tue, 5 Dec 2023 19:16:02 +0000
From: Simon Horman <horms@kernel.org>
To: Steven Zou <steven.zou@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, andrii.staikov@intel.com,
	jan.sokolowski@intel.com
Subject: Re: [PATCH iwl-next 1/2] ice: Refactor FW data type and fix bitmap
 casting issue
Message-ID: <20231205191602.GU50400@kernel.org>
References: <20231201062502.10099-1-steven.zou@intel.com>
 <20231201062502.10099-2-steven.zou@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201062502.10099-2-steven.zou@intel.com>

On Fri, Dec 01, 2023 at 02:25:01PM +0800, Steven Zou wrote:
> According to the datasheet, the recipe association data is an 8-byte
> little-endian value. It is described as 'Bitmap of the recipe indexes
> associated with this profile', it is from 24 to 31 byte area in FW.
> Therefore, it is defined to '__le64 recipe_assoc' in struct
> ice_aqc_recipe_to_profile. And then fix the bitmap casting issue, as we
> must never ever use castings for bitmap type.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Steven Zou <steven.zou@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

