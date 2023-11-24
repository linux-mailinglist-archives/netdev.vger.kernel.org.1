Return-Path: <netdev+bounces-50789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E37F7244
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D9C1C2074B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3951A58A;
	Fri, 24 Nov 2023 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPZ4m1Fz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC818043
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 11:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9086C433C7;
	Fri, 24 Nov 2023 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700823660;
	bh=2ci1UjH+nU/w+5yINTyYaGPvh7WQcxnpCviXZwMQHIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPZ4m1FzUoYigpCpPegE/Fwwcdy4qhyplp5aEpjVq1B4mluAENpIJ5+QbQppcbvYG
	 QwCsiEwBXr9bOAAwV1sh/vBS9CXqqzrmGXBljfSr6QmavL82K8neu7JeHkv8o5OYJa
	 WNgvOaB/jEUF8WKOFoLt5WPfoOq0VXv4Jz0DoULf4IhSxx1P/iSRcRgnTY5yvVAflX
	 zEKN43hGvoMvIFeuYcyA3JD5xVfEpvMUp9Vsmi7uMdqocv/JJTdp4wztAwZs6D6uwL
	 7DfaIZSK0sTAN1bz3I/j1jfOBwBbKiUR8VppVkw0wHji/njzqORJry/Vtak4CH/h3L
	 R1lLzBFKHEomw==
Date: Fri, 24 Nov 2023 11:00:57 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v1 07/13] ice: fix pre-shifted bit usage
Message-ID: <20231124110057.GG50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-8-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-8-jesse.brandeburg@intel.com>

On Tue, Nov 21, 2023 at 01:19:15PM -0800, Jesse Brandeburg wrote:
> While converting to FIELD_PREP() and FIELD_GET(), it was noticed that
> some of the RSS defines had *included* the shift in their definitions.
> This is completely outside of normal, such that a developer could easily
> make a mistake and shift at the usage site (like when using
> FIELD_PREP()).
> 
> Rename the defines and set them to the "pre-shifted values" so they
> match the template the driver normally uses for masks and the member
> bits of the mask, which also allows the driver to use FIELD_PREP
> correctly with these values. Use GENMASK() for this changed MASK value.
> 
> Do the same for the VLAN EMODE defines as well.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


