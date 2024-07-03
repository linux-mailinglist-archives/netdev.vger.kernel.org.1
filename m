Return-Path: <netdev+bounces-109006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DEC9267F5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8836F1F246CC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9218411C;
	Wed,  3 Jul 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkGCeR2y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D017B4E8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030790; cv=none; b=uU340r/tm8cRZMwF/FvzKzO9ExF1utKY7nhIXxq1O9ZBZLx/VBHg4gmZmAjSOh/mNze1ZgTfumzJ53KJqM6b0E5GWesSPlZ8zTCJ8jVxHQUQ0cj0+gF36cz0fBKpI/qDBJ5zzC2lAnLUwrY3zgNVhfrCU1tJD3BtoXmiAsOsECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030790; c=relaxed/simple;
	bh=cF2H4jyUtOE6hWkWsSubltzoLKDLzna4vo4o5UYxqaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMLYVV3sYwCLF15z8B9HAI4kevJbeyiXJlae95cqX/dmTUZtzos5B1qIBXK3x4oVTtojoNP/i39y/icVd8x8kYVx/Na4OC3KNOLSV6C9ti18wHYsc9q0pwtRBSL3dJT1iYb+luLPpEeMhod8ID+xmHn2LYBEnv6obxyml1coSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkGCeR2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA0BC2BD10;
	Wed,  3 Jul 2024 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030789;
	bh=cF2H4jyUtOE6hWkWsSubltzoLKDLzna4vo4o5UYxqaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkGCeR2yOyw9KTbWKcsVYhlpS6U15CtYJEdNhdcnJFGeUU4Wup1M7MpvOlTZtZARM
	 zYi39TdignhAs0G+t99rm48lTBbZk+pSJLI7AjTMKPOxgAsBCcvBnwUzyV7Slkq1SA
	 UmgiNVAPO4d9b3NnbFxw1FDtryzG0YRgUw5BDBzB33rUDI91rIY5HC+YYfwRI57Zqj
	 AbGj29g0j0YU4uI45M1jYx2uIGnhBM7rgmj6fA9Vzu6/6EadpQBTz708P8M8CSKm0y
	 WINLlikU/5BW+toyfJrGABPGZTbc4NP+8vYiZ2OjoUJobFLsitWXMc6pmZe4gs693e
	 wpG3y+FJoQUuQ==
Date: Wed, 3 Jul 2024 19:19:46 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 1/7] ice: Implement ice_ptp_pin_desc
Message-ID: <20240703181946.GJ598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-10-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-10-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:30PM +0200, Karol Kolacinski wrote:
> Add a new internal structure describing PTP pins.
> Use the new structure for all non-E810T products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Removed unused err variable

Reviewed-by: Simon Horman <horms@kernel.org>


