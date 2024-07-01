Return-Path: <netdev+bounces-108012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16091D8C1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E5B1C210B2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A66EB5B;
	Mon,  1 Jul 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb/FWyH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AE6BFC7
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818205; cv=none; b=ne6M752HtJwOOXJoLvYyE4I5m8Oz+GM7tFikns0zXvHswKrzK8mxnMBojU98b/+//J9rISTWsgv/mi07GzqjvDd4VjQ7iQGNw45i9EA3pFpzdNzkoJzJR/HKee8/PHSeoV8+ruzQCTagawEcW+F4F0i6sXzSs6QWLXWl6r86tMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818205; c=relaxed/simple;
	bh=CwosdTmAYfrtOMU/fdvpzzuGdoW7n1X4y02HIDFAEL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3/5in//vPaa1eawjNJCU9NNra/0Qzlf874Lqi2nCVl7UkzH+oVVD/PWijEM69IJDT8XQlsBh4fUp7l5Lw4m+JfMuC4NyAf8+sxiXOOMrqkOCXQTXJL+nEl8729p3lvE2Hu6JDxy595B2mW8i7+OxcXeHeaf/tnuuSYniXljCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb/FWyH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4D1C116B1;
	Mon,  1 Jul 2024 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719818204;
	bh=CwosdTmAYfrtOMU/fdvpzzuGdoW7n1X4y02HIDFAEL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pb/FWyH6pjUO16ee1W4XozfGGd50lCnl8zFxzXx14Cyw8K9BXj2xGIjyW9VYDHN1O
	 KveIi0wooDPRK/Wu6bLhOSSYSHoQCDsaCq+MSA/quI5uxV+ktaEOlvARYdxmFtpmGh
	 gxozjzpEbeDfEGOr0hiOYRH4DAWU2Z+MWsIfVz8lSwlZwuVu06vZymB7qboKYmqXVq
	 K9sHhtQHmXcCynYf8aez+7fDCazqV0epDpBADiW+hKOiNngsadil4ks6ViRcwQcNa1
	 FsT24E8XV90DJMeJZ81HleiS4MHYK8zmT4sM7Zi+au9HSl4kr1ml2YW6UYbneMGVWw
	 v/htiufppz8sg==
Date: Mon, 1 Jul 2024 08:16:41 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 4/4] ice: Drop auxbus use for PTP to finalize
 ice_adapter move
Message-ID: <20240701071641.GF17134@kernel.org>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
 <20240626125456.27667-5-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626125456.27667-5-sergey.temerkhanov@intel.com>

On Wed, Jun 26, 2024 at 02:54:56PM +0200, Sergey Temerkhanov wrote:
> Drop unused auxbus/auxdev support from the PTP code due to
> move to the ice_adapter.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 252 -----------------------
>  drivers/net/ethernet/intel/ice/ice_ptp.h |  23 ---

Nice diffstat :)

Reviewed-by: Simon Horman <horms@kernel.org>

