Return-Path: <netdev+bounces-163919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C14A2C037
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB753A70DE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EEF1DE3B6;
	Fri,  7 Feb 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfBnP1/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF61D31B8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922842; cv=none; b=t0k8AY9erLB78nrE7FVDwoRhimBEFDlu3eQX2lgO2C7QFQMV6Net4fpsiYVu9V03lBpaUpB5UxjeZQv0ZSNqxQJflR7GpTeccIRiQU0mNKZBhprr/duS81sU7Mv6Vew3UovZ0P/RWpAJYCxdqh36xUt7+HDbgFYr6O+vEv6+0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922842; c=relaxed/simple;
	bh=de+Z/14+ZPdvLxUTgHvhp+ZATkWvmwtCW4nxIYb53sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t737BzThwgDrZAT2G7EckM4vdUkweSKDery6MHh2Hn7/jZi9BEVT9xal3mEJ6KHltTBBWw33DvIaacOw+1hEO1osnH5WmBrg7MX3LzQj+Gqb4uHpi+PC9I3o77KPgu4xWQ0s6tn/tHO1IpxDi1aQ+aucWLuxTEetzTJz+pRaFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfBnP1/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB608C4CED1;
	Fri,  7 Feb 2025 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738922842;
	bh=de+Z/14+ZPdvLxUTgHvhp+ZATkWvmwtCW4nxIYb53sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfBnP1/hNFz2iTCtPgEEYCOC3/eVudRfm+V+a+nGNW89hIAsr8NTuttaloo0h4WQB
	 oCqgI2xdjjY3nxKVxV7okTIOhpBEVaDTYqLr0lkD4zP1wE1sUsjSSaIhayytznzP69
	 actwWZ2mfEM7BAQ8CDxCBWLv0TtN0bAgofye+1Zp04Mokfmhu5mnvp4U3Fx5ecH4aj
	 mnp32MxkmQz1d/6h5KaTC2iVpaeNgpvftAKb8ko34xfULkTKaWnSMumxZeeZ/GS01l
	 pC3iIbQXnXWjFTIqC0RVU7Vo+42q3ILAjKb1MD3i4bIKyaLEc8lexxOzbMUL9Pmf0i
	 EsdPv9ZpqiVhg==
Date: Fri, 7 Feb 2025 10:07:18 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v1 3/3] ice: E825C PHY register cleanup
Message-ID: <20250207100718.GM554665@kernel.org>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
 <20250206083655.3005151-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206083655.3005151-4-grzegorz.nitka@intel.com>

On Thu, Feb 06, 2025 at 09:36:55AM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Minor PTP register refactor, including logical grouping E825C 1-step
> timestamping registers. Remove unused register definitions
> (PHY_REG_GPCS_BITSLIP, PHY_REG_REVISION).
> Also, apply preferred GENMASK macro (instead of ICE_M) for register
> fields definition affected by this patch.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

In reference to my comment on patch 1/3, this patch is also doing sevearl
things. But I think that is fine because: they are all cleanups; they are
somewhat related to each other; and overall the patch is still not so long.

Reviewed-by: Simon Horman <horms@kernel.org>

...

