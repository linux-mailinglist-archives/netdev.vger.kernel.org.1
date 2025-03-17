Return-Path: <netdev+bounces-175380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69FA65833
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC97516A213
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A81A00D1;
	Mon, 17 Mar 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eim7GMPZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2E1922D3
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229372; cv=none; b=q3bbP0fqXv+pfy6HehPxbWGDCwXqaqjCq4IteSLqvcj8e/Jak1X8NfRvhWFzLoYe9jdKeTW6ih6ICCH3OvvPRLFHTFBoS6vbyLRb50KPnKHXhjp6e2jVE5uJkct69sGgYSuvsW15D/Sv72oq8npw6bcPEXwwsl7t5zZn75UK5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229372; c=relaxed/simple;
	bh=hxUGwuq7WDdmDJmZwXTfkiEjKSTVRymvuQfO+oKCd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaVQvSISqMTJ3wWE+HaRHRjyJZAM2O7ZVtBHqxf5SGwW5lp0XPnonTNeG/7GcruxHbfuyRk7ksZdqGiVN7s9KgxuzeJWbIF89hzLP9Iz2SDXJ45EnJuNMCRSPUdNwbPtHZIQQL9d+ptUmIduWSjVaKKzxTyHZEI7i3SUhrvl+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eim7GMPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D6DC4CEE3;
	Mon, 17 Mar 2025 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229370;
	bh=hxUGwuq7WDdmDJmZwXTfkiEjKSTVRymvuQfO+oKCd2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eim7GMPZJ+a7J8RIAakBUTHU5Hl4HUVOxQlDkCp7Az77Y1ooTCXtn7CT4PydNT9ML
	 34Yna0UV8nQUFO3Gr+TJ08s1Zdf8kXQA+dNCTHZlgPfdbSymzXSJPlcxo/te6GtpYe
	 ryZ27ab6g42K9XJ/7CQk+YP/KqrSk3OJfruoFYdt/46vo1oWDjsO2FwXAy5MECOjDv
	 miRVvAPL0THlFytOTz3wVGDPpVB9UWKmm1uFdSL8sn7aWpGaIZA05tcYSlGBd2l8Yu
	 bIEUfWTT/vfkvqmbfR/bvqimtQ3jAOLxJ2pqfxt/ATslJchpRwtA1W1U+cA1hiazwD
	 hq1aVhOoXfuXQ==
Date: Mon, 17 Mar 2025 16:36:07 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 1/3] ice: remove SW side band access
 workaround for E825
Message-ID: <20250317163607.GD688833@kernel.org>
References: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
 <20250310122439.3327908-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310122439.3327908-2-grzegorz.nitka@intel.com>

On Mon, Mar 10, 2025 at 01:24:37PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Due to the bug in FW/NVM autoload mechanism (wrong default
> SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
> clients was disabled by default.
> 
> As the workaround solution, the register value was overwritten by the
> driver at the probe or reset handling.
> Remove workaround as it's not needed anymore. The fix in autoload
> procedure has been provided with NVM 3.80 version.

Hi Grzegorz,

As per my belated comment on v2 [*], I think it would be worth adding
a brief comment here regarding this not being expected to cause
a regression in HW+FW seen in the wild.

[*] https://lore.kernel.org/netdev/20250317163359.GC688833@kernel.org/

> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

...

