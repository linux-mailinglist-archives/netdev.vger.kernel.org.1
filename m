Return-Path: <netdev+bounces-67723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF2844B11
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22952951DA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A63A292;
	Wed, 31 Jan 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orJpenu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5672FE3F
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740213; cv=none; b=ZrU7pUWKsFWiNPU0iROC9X3/43gGZ3010Yeodg0YTOruadnNXutrOZWmnsooxy6HxgXgZO19gE7oYKnOT5WCXmXzDJ8mt3I7jjvh/cRUU8CybF1QLcZfQhDaZfn0XPb2EXrfKCCjZ1dhmMeL+Eiwyltw2Un6pV3xk08XVO6zsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740213; c=relaxed/simple;
	bh=+k8MNaR/Vc0QQvsIITPij2Um3MBqrEwPE/gFtIResNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxGOVAnxYnJMSoY6SSqAmS1+dx83pbsm7htaeAR9UGl+PJtqtzXuO7yj6rx9TesA4p6mtSUK4UIVckkTsgk/CCH313b1IasVXa8gb8CGA1uW7YA2HiPMG/sIPVNtXrYUosjF9vpZgts4HnsomQKNA4nDKpgwTrF8Pui4b7Eqhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orJpenu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC312C433C7;
	Wed, 31 Jan 2024 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706740213;
	bh=+k8MNaR/Vc0QQvsIITPij2Um3MBqrEwPE/gFtIResNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=orJpenu5JRyvHb6jr0OwTu1bhGWazNxFNRyI+zj2+4oMHedCutn6WbXNDyEIPOkVp
	 9p8omdM8TwpdzpHdyA+oyCDJS9hRFq06UU6XgezpZgz36mB+KN70J9soAXTvj8kpTA
	 Wbga7Vs3xQ9lIqjro5/5mTGyLT5qES+o3ZsBJJrDs0JT/S4FTWw7KB7iqKxv1LxXho
	 MdV2T+dlT07Jt0lmbK35iLnZbf3tawtt2maDvON3at85tnXLYeUkoeKkOuHuQX66+7
	 TWxaS2VRb6uRpaFp9Ler2jwEVL+8ZcAalMxcjUx1o8IPQ8rawUOnO0q8rHCHLxMA0N
	 +faSfthJFkptg==
Date: Wed, 31 Jan 2024 14:30:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: William Tu <witu@nvidia.com>, <bodong@nvidia.com>, <jiri@nvidia.com>,
 <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240131143009.756cc25c@kernel.org>
In-Reply-To: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
	<20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
	<20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
	<20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 13:41:07 -0800 Jacob Keller wrote:
> >> Still, I feel like shared buffer pools / shared queues is how majority
> >> of drivers implement representors. Did you had a look around?  
> > 
> > Yes, I look at Intel ICE driver, which also has representors. (Add to CC)
> > 
> > IIUC, it's still dedicated buffer for each reps, so this new API might help.
> 
> Yea, I am pretty sure the ice implementation uses dedicated buffers for
> representors right now.

I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
all do buffer sharing. You're saying you mux Tx queues but not Rx
queues? Or I need to actually read the code instead of grepping? :)

