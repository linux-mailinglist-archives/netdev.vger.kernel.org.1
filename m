Return-Path: <netdev+bounces-198826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55FADDF64
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795CB7A6443
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9942957A9;
	Tue, 17 Jun 2025 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTqFISrk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF3294A0B;
	Tue, 17 Jun 2025 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201777; cv=none; b=rg4dT4mJbftrf5BJY1xkzQH+0wposbduZC0s9C6BnoFDPi5EYq8sGJfitWjcFOwfCQGKCJOsards3V+4uGVMoxv2+EHml1cp9zCXpQMRYXOFAWM4Ek1E7u9rIbhlQSrRtDqZoZ9SwZq1ZMMtzknyXWAuYBK2Cl779KjKW2XpsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201777; c=relaxed/simple;
	bh=kcB9nqV0AvhUhiSM+/9o/yE+LthTXfXASBnzHnKLtFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGVC6t5l8fyK6Gaop4+4QCdYxq5DW3Skpqrz/dCPUa9vmT6kPBENvFfMeK5ceOlofk4vx160Nk4pRhVfqMyEHbiKYFhDMJwo6aYCq7Y9rm2O13Gc5fb5EGmxVMIptqTkGQyZxMTBKqktrON6CsE+U6FCJl6moxWD/V7oC0rxmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTqFISrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D8C4CEE3;
	Tue, 17 Jun 2025 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201777;
	bh=kcB9nqV0AvhUhiSM+/9o/yE+LthTXfXASBnzHnKLtFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iTqFISrkMfqk/W/J807m/XLuMWt+/AmOrQEkKc1cZ/1mbY74pGSV/dAH3axKBq+u8
	 akoybs/Lo3s1slQSijkeVS2o0kS1Tkb1Dm8GNZF5++/1zAlH3xGDP7JOaCcfIBkCEI
	 EjD6s6pk2mGvx1c1iyKZvr+9Up0XOwtForH0LqwBkq0DX+rGh403zqFXeeFmK3xIV0
	 OaMah8fnboYyv6nGbbANYZsoIG7oGfq3RYIzBqPjGmTwitU3Q4W+Vh14OnjxjNETDB
	 JF/MDxRfc6An9rwN7NVloYIFTX0PS1F2GzmzdA+w6ldzQMajdWofhr1PlGkv2zSPWT
	 ZEJU2cNviJ4BQ==
Date: Tue, 17 Jun 2025 16:09:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, "jedrzej.jagielski@intel.com"
 <jedrzej.jagielski@intel.com>, "anthony.l.nguyen@intel.com"
 <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Mateusz
 Polchlopek <mateusz.polchlopek@intel.com>, Bharath R <bharath.r@intel.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [REGRESSION] ixgbe broken after devlink support patch
Message-ID: <20250617160935.08f8652a@kernel.org>
In-Reply-To: <59faaf3b-d75d-4405-a7bb-a137918617e3@intel.com>
References: <LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com>
	<59faaf3b-d75d-4405-a7bb-a137918617e3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 11:01:18 +0200 Przemek Kitszel wrote:
> > Normally, the device is given a name like enp194s0f0 and connects to the wired network.    
> 
> now the name is likely to be different, please see this thread:
> https://lkml.org/lkml/2025/4/24/1750
> 
> Is it possible that your network setup script has some part of interface
> discovery hardcoded?

Hi Przemek, could you/someone on your side try the workaround 
I suggested in the earlier thread? I'm not sure how actively 
developed ixgbe is, if the work is not related to any new devices 
with more complicated port topology breaking people's setups feels 
pretty unnecessary.

