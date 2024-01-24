Return-Path: <netdev+bounces-65412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFAD83A665
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A998D284FE2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1F182DB;
	Wed, 24 Jan 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRsVuLTe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982017C66
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090986; cv=none; b=r5+pVsbh+Ts3k1SAKG4Qtf292dpZuWVwuhpDzquOHFvB2GB1bd9fF02IHfA8RV+ebjwdQ6hdCCrKOcYvQxPpPdcCnV1DSDTtRUZi/6CC1L+5bKt75jEKR4ZlQmVHik/7KpJTOVNRyVcmbxtpyl/tFtcTn+HRZSwJrNBienXlIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090986; c=relaxed/simple;
	bh=zaUBIOlL0lgA7E78oSNpzzMB7BJcp/PnNOWf3yezQOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivOLVrLEj7kC+QiN0NiJ3PzuVDvYwrb6YZcTQHtV52OKzhGKp5tkmvMGYvHj5cR62ow6IXm2Xl73L3PEsp9NyXH1RH2ukYWU66iLBmHxsDXDg4YE7nobD7UkrFjdyGs5x+CbEJT+A2zCC7wxyYrxSEpPZvaWcJy1/HtDEX6H6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRsVuLTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B83C433C7;
	Wed, 24 Jan 2024 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706090985;
	bh=zaUBIOlL0lgA7E78oSNpzzMB7BJcp/PnNOWf3yezQOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRsVuLTeuCCKAPI8m4eqcinXQDn/mqSjYMU1JEP0coe/yTF9FzdJLGKutgAZQEs7H
	 5Gbd4kFRg8RIos1M3RggintU4qXeO923MRdPFnpVBgoQCtQWwtyj5nfbTymvxzM9L1
	 PdDpdgJkvQWW8nw1Zyv3X6Qhs4fL4N8Va22KoBdWa7nk5b5cGNopWrZTU4BETPYeC/
	 dcm3JL442Q1mitWSe9SetPN4EvMwE42+SX3Ls/C/bJ6ER9EFAqgCt6Tvk3WK6xh09K
	 +KGhO6vXiep2LEtnF+XZuCnrMm84GFXtZoMVQQZGKevGFLkA9lrlU0UNsc3CJhESSe
	 nZIg+ej7kFUXg==
Date: Wed, 24 Jan 2024 10:09:42 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH iwl-next 2/2] ice: make ice_vsi_cfg_txq() static
Message-ID: <20240124100942.GT254773@kernel.org>
References: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
 <20240123115846.559559-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123115846.559559-3-maciej.fijalkowski@intel.com>

On Tue, Jan 23, 2024 at 12:58:46PM +0100, Maciej Fijalkowski wrote:
> Currently, XSK control path in ice driver calls directly
> ice_vsi_cfg_txq() whereas we have ice_vsi_cfg_single_txq() for that
> purpose. Use the latter from XSK side and make ice_vsi_cfg_txq() static.
> 
> ice_vsi_cfg_txq() resides in ice_base.c and is rather big, so to reduce
> the code churn let us move the callers of it from ice_lib.c to
> ice_base.c.
> 
> This change puts ice_qp_ena() on nice diet due to the checks and
> operations that ice_vsi_cfg_single_{r,t}xq() do internally.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-182 (-182)
> Function                                     old     new   delta
> ice_xsk_pool_setup                          2165    1983    -182
> Total: Before=472597, After=472415, chg -0.04%
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


