Return-Path: <netdev+bounces-159200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABEA14C06
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4A4188A64C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59821F7910;
	Fri, 17 Jan 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg6TTR7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6F17583
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105547; cv=none; b=YqTbRADrJzTDMM6vCKe7fvpOmVK2/gD7FFzLzcXSO+Qp5UKI2XSEvDCo58QrVpsg4q6PNuURYNV2WoW84vm7O/9UJlwABb/aHvlfbmwG9/AzvmZKuPrzAdXcjlH3kWdsMMmLgTHo4Gt3z5q71JEJzwkoF2xSv+WFaP53wRp5sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105547; c=relaxed/simple;
	bh=wqo7SEaByFKABJSnAUbDwqbXNEFLOMEevJ46ECs1yHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJQ3pbTWo4CbmbWeY/BbMe/lXbPdzNqF15ARqMrK278+6OtP45b05pqgZR+lka9V0RjM23ZW3rgkv4K7FlDI1sAflORjE2fRipGPKha5zN/GH3PgmVWfKIBS1Ox5dG6ikx7AuduwIdcg37AjFel3b3n3rM37BIGC29VKYnWs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg6TTR7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A6C4CEEC;
	Fri, 17 Jan 2025 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737105547;
	bh=wqo7SEaByFKABJSnAUbDwqbXNEFLOMEevJ46ECs1yHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg6TTR7lyjVvvf6pr35aZMpxRh0C8Zq23wzuhzMRfzJ+iCNtGeFpDKyTlDvsyMn7t
	 6mfqfEAYVFmu3qpoF4gCfGWbLEHFw/RtLLqcBegnfUPayHQgl+TRO3rQOS79JksaIA
	 qCfMtMtUYEJQ9uPt9/QSBCG0wNPLlRKxUaHyWsDd4jieJOSXrVq9X3rbPfPhwjkONY
	 1zTMnz0V0fc00ebjeT7KhUspVzfJkbYfdPmw/l5bh2jdfK299Z7ojNke3Zu1TMKfuD
	 x8IzY6QV2TjDUJ1hwAbE2ZpQsbO324AMuoPYowzXeo9VncGoDb8v0T2ATIpa1YNg3d
	 nzs0WaFjkRS/g==
Date: Fri, 17 Jan 2025 09:19:04 +0000
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: Re: [PATCH iwl-next] idpf: modify vport_cfg_lock to be per-vport
Message-ID: <20250117091904.GH6206@kernel.org>
References: <20250116135530.94562-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116135530.94562-1-ahmed.zaki@intel.com>

On Thu, Jan 16, 2025 at 06:55:30AM -0700, Ahmed Zaki wrote:
> The vport config lock protects the vports queues and config data. These
> mainly change in soft reset path. Since there is no dependency across
> vports, there is no need for this lock to be global.
> 
> Move the lock to be per-vport and allow one vport to reset without
> locking the rest of the vports.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
> depends on iwl series:
> https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=431435

Reviewed-by: Simon Horman <horms@kernel.org>


