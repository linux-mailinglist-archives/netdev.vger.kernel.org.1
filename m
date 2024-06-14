Return-Path: <netdev+bounces-103591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC9908BF3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794631F27655
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84499199384;
	Fri, 14 Jun 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baqVZebJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607371991C3
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369030; cv=none; b=hax914apa5/nuEEAucohFZdMsMtWAGxRWhuxY0hh4GZn3kSDB3cR4kEetmxp6sBZQcYZB7cuDlzIlepzLWYhxclqlTqGXrEoDXuFlZGcaAZ4v0wsodofMQUqAk0K4Mnt8kYkynlPVkYgNxQy7ClBaZygnIYnZ1/ZWHvEN6hD2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369030; c=relaxed/simple;
	bh=eHbspLPsRwN/mbeaXgB2lqHgAnRpJhQXTP9RTxxZ5eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTvPTb69qLKUy12UiQ0/0BXiOt7vQ2M4vwsX1gttn7P9tbfLK/AMgfce4i0MTW2ZWpRWBofZLCsaWbHZmz2bPR/y7qZHytV5jCP5C+zUoYMmB2Fonen0b+e/QFeKWGhRGBSY5U+YV70mgirkQavPCNcjyuTcKuSNy5D37Lh/LqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baqVZebJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D3CC2BD10;
	Fri, 14 Jun 2024 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718369030;
	bh=eHbspLPsRwN/mbeaXgB2lqHgAnRpJhQXTP9RTxxZ5eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baqVZebJYB6JQRjG1TbqtNy8NAJUp4PDkrD0TKpQa+gXFDIkLDXBtCgUECynQnNyq
	 qq87MdlwMi8aOASAawHo4ZUAem3bCrB9zqjnywz62m6wFsygIQ60Vix1/EdaLHcFS+
	 XyHDsFrLorhaC2AV1b5jhtGhDNSJU56fKK1JGwaM0K9l7SHAA5buumxAQ2aWPDCHOQ
	 9XVTDQ/hGNNWF4pSILD/vGeNQidbiUDH/KqrYfDO/PqHvt4Tw/70PTH65Jw5RhVqm0
	 Dxa4XILV7BSGLV3wL/vA72RhnV8AtYsJVw1PwUnVwdXDUsiizpkbyDm7A2+bwz2Ozt
	 exNqhLNlzU+XA==
Date: Fri, 14 Jun 2024 13:43:45 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 1/4] ice: store representor ID in bridge port
Message-ID: <20240614124345.GM8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-2-michal.swiatkowski@linux.intel.com>

On Mon, Jun 10, 2024 at 09:44:31AM +0200, Michal Swiatkowski wrote:
> It is used to get representor structure during cleaning.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


