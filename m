Return-Path: <netdev+bounces-99797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0E8D68C2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08EF1F235A0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6787B17C7D4;
	Fri, 31 May 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMDTKMoM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7D4C62B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179224; cv=none; b=F9T4rD7Ucuw4hY0b8gQflCR5JllNLb5eykzwCcOSgrJMmNelo28tYQWLnJPreQ6QaLbw51omkwmSkI3UTjLviTtv6eoKnlxEmsok8q1JF+vTrlxkL8jBC5yKNNdYQ0Mqi1lpu56f+WjBVyn5mjKjpLLEiYDVcKVdZKrnuGm2S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179224; c=relaxed/simple;
	bh=NlNJoKQw02Z2Sdv6VpyQhxDm/mrs/9RVmVyqWMo0hnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7bI2sM++VZq3skx8YYOExQK5Bkg6jbR5x4C6OtVidJrk+w8c4H7m5hIh/GuGz6Y0oOKSUtJVSaTq9R0nF6jUMdpNYl19EUL0laJX1zqwEnyU0bYMqdFU6OoQ4j9Zfq6aXKbdWMYrihEbI1A3VBjnDKWwQmeCCXZv6fjU45rk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMDTKMoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB73C2BD10;
	Fri, 31 May 2024 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179223;
	bh=NlNJoKQw02Z2Sdv6VpyQhxDm/mrs/9RVmVyqWMo0hnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMDTKMoM8HisjJbNEA6I72XPijpmp1d/nZYSiMjtzLskvYCYaPk6oU9ZJM9Mdb+1b
	 EXe0aTH6n8uR0vyjOsBvWXydV42iIatDjBWpW5wzgff1qZnuhr6adYoNeQHUVvBTip
	 ZpesdrwS9YdOR3ZWVSalTkHjH7T1AE8DzKzD5iQa/8NqtPZonKPJw7i59EUncAd9Bj
	 9Azt5DY1xSQ/hTfVamLqPAMRWFxwOzCixhRoLHhN0DbMan9qm50joagczOmoUafPvp
	 Pgrknuz87eSS3ngMtgPSfwiDEM/UzN8ltstf/TGxTvOYK8IHuni2VJ5PryDT9GsjoB
	 dKR+c/lLvO8VQ==
Date: Fri, 31 May 2024 19:13:38 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 01/15] ice: add new VSI type for subfunctions
Message-ID: <20240531181338.GE491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-2-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:37:59AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Add required plumbing for new VSI type dedicated to devlink subfunctions.
> Make sure that the vsi is properly configured and destroyed. Also allow
> loading XDP and AF_XDP sockets.
> 
> The first implementation of devlink subfunctions supports only one Tx/Rx
> queue pair per given subfunction.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


