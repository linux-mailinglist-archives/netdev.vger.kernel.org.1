Return-Path: <netdev+bounces-99840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D148D6B0D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326521C21530
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922721350;
	Fri, 31 May 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1jnCmwl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AD208DA
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188431; cv=none; b=rLRlufQixQ2+BYYWX3KtlpMr65ZVMvvBS066OyMujkvG5gwX+Ug6FhBUEtwCivuqSlfoO8vxw0VCjci4WnEEuM4AysHT2ZjN+SuDgER0OAy+z6RO+SDLA+fjS8MqFQ8iiRmk0fHmV+PIghcTBppDLNHHoqZSdX8PZl6UeQkXOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188431; c=relaxed/simple;
	bh=N2OLLR+a9Z2gK8vMsAEx2Y+IPXBoYuCzkY4i8KvEMQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ0D/5jJXyG9CH07bQZYnyqz7YQL+Ngh48mZYwdq31TavBJYB6EBCsWRm+EVlssFMHuy7Bygd9S9eZpUamHqVyhcd3j8Wof4Ulsb4OYJnLRpp09GlCLi9RSpM7eSPDNxXRxXP+KSXhIcgKWsdNVmjrQymcSFqChKUmtUmWp+98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1jnCmwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F2C116B1;
	Fri, 31 May 2024 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188431;
	bh=N2OLLR+a9Z2gK8vMsAEx2Y+IPXBoYuCzkY4i8KvEMQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1jnCmwlxZDkvQQQmVhhQkQhTUapCkuhI1uQw1v3sGmqLwJvOwJvB1sxki4Id8sJp
	 1tY0aTnsjR+Qr6jQ8nJfCqwSAnU25dVxY3B9JuCBISFJxQYzDmWvcbuUi9FDJDZJWO
	 g6rSRSQuPe8o8pcbTbytU8GSbeg5tZBeYRxL7GgcIaK9tRK8fQrGNX+wSIYKU3uYSx
	 clt2YIGc52gjByuPhTFS/XtUb3rvpwaEWkgD8Vvc68jFKPGtzb9rsbOKVVsjzPRWuA
	 FcE5NVaT4JMJpmXDXAqC4toHxddUksciIf6jsZ22jl9j0RxVkGDv60MI0o2GB2ILp6
	 gA55vANa6dyfg==
Date: Fri, 31 May 2024 21:47:07 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	naveenm@marvell.com, bcreeley@amd.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net v2] ice: implement AQ download pkg retry
Message-ID: <20240531204707.GV491852@kernel.org>
References: <20240520103700.81122-1-wojciech.drewek@intel.com>
 <20240531183605.GS491852@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531183605.GS491852@kernel.org>

On Fri, May 31, 2024 at 07:36:05PM +0100, Simon Horman wrote:
> On Mon, May 20, 2024 at 12:37:00PM +0200, Wojciech Drewek wrote:
> > ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> > to FW issue. Fix this by retrying five times before moving to
> > Safe Mode.
> > 
> > Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, please ignore that.
I seem to have managed to respond to a stale patch.

