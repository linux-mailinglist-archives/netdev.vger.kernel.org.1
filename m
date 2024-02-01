Return-Path: <netdev+bounces-67894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F8845449
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC451C222D3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61215B0F9;
	Thu,  1 Feb 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIdXtvLV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595D015B966
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780398; cv=none; b=BsCkuN6Edca9Z+AHaX8yWENJivgA1qVVCOXkedNElBz/Iu+nh+CEVBSkIE2D0ZMnutyVyXJYwfSokVgS/Uh+d6M/CQimGizJGGZIrFho0ineaoyy4r9Op8lYmhmrqDuyJIvdVC4tRV1s2D2/pH6jTGOUDGZ1blDeokarwmMgT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780398; c=relaxed/simple;
	bh=2L4QMTxfavhBie+3DfYcZNvCNEVe5Gbqhzb/FRYP4fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcMeLvrEL4LqjM8eWvCCgFaXplAb28397q2DcO+hSOIA3TV/axXH8CnzOVxZXGjRNc3Av1CB4B7DV3i9e9yokobfvxjIGOha/D7U7asixRI2AhZYkpbudYDxMt0QKQ98yPTa9bICrlH5m2lFpqGSNmaLaKBifSWASpcGbVRqmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIdXtvLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70723C433C7;
	Thu,  1 Feb 2024 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706780397;
	bh=2L4QMTxfavhBie+3DfYcZNvCNEVe5Gbqhzb/FRYP4fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIdXtvLVRw8R6HRf3/LOotLe4nKqGXLaXrhrSdeD6krkZaqI9XNbIpLaXIzpv0SX5
	 PdvJOyV16HurV9Svc/pfENO2I1v/p58aabFjK3k9ejFNTrbzfUpbHYrlisIYACHpEJ
	 fiddXCJ9cJ9UhSSfKMVGvY+kb5nWpKZ8MuTy87yDhcXGG1ZWsX2+liQl2orheK+k+j
	 mT9lvgeTEjNDGBfN9w7J6bpE/axItjr/TWTrhEtND3i84cNq5uKRxgo1MYv+mrOs5S
	 K3j+YpI4XM6AoqnQkIpnGWIlRz/IALY9J5KZZmcXQDMcuLj2P4ZJIaXJuez/DoeHNL
	 KWanP0U996EDQ==
Date: Thu, 1 Feb 2024 10:39:52 +0100
From: Simon Horman <horms@kernel.org>
To: Steven Zou <steven.zou@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, andrii.staikov@intel.com,
	jan.sokolowski@intel.com
Subject: Re: [PATCH RESEND iwl-next 2/2] ice: Add switch recipe reusing
 feature
Message-ID: <20240201093952.GC514352@kernel.org>
References: <20240130025146.30265-1-steven.zou@intel.com>
 <20240130025146.30265-3-steven.zou@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130025146.30265-3-steven.zou@intel.com>

On Tue, Jan 30, 2024 at 10:51:46AM +0800, Steven Zou wrote:
> New E810 firmware supports the corresponding functionality, so the driver
> allows PFs to subscribe the same switch recipes. Then when the PF is done
> with a switch recipes, the PF can ask firmware to free that switch recipe.
> 
> When users configure a rule to PFn into E810 switch component, if there is
> no existing recipe matching this rule's pattern, the driver will request
> firmware to allocate and return a new recipe resource for the rule by
> calling ice_add_sw_recipe() and ice_alloc_recipe(). If there is an existing
> recipe matching this rule's pattern with different key value, or this is a
> same second rule to PFm into switch component, the driver checks out this
> recipe by calling ice_find_recp(), the driver will tell firmware to share
> using this same recipe resource by calling ice_subscribable_recp_shared()
> and ice_subscribe_recipe().
> 
> When firmware detects that all subscribing PFs have freed the switch
> recipe, firmware will free the switch recipe so that it can be reused.
> 
> This feature also fixes a problem where all switch recipes would eventually
> be exhausted because switch recipes could not be freed, as freeing a shared
> recipe could potentially break other PFs that were using it.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Steven Zou <steven.zou@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


