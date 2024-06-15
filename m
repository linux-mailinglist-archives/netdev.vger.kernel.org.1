Return-Path: <netdev+bounces-103748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAC90951E
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2781F22112
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662C1396;
	Sat, 15 Jun 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjjpjnkj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6A7E6
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718412961; cv=none; b=MnbANFdSLzsrNH0fGj99xAUa06Y55q9vEyMLpren5KJBMRSMmZ/cuuyL2j9rX9zfEkTdE31hdR0aUnoaA2wenZXEyNEujl6R/XmgW5u43Bx+4V391RBRBX9DzweamkMgHS5G/MYh32nd1w8Zr0nxztrSrF1PNN4WGmH8ZwfwSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718412961; c=relaxed/simple;
	bh=vfiMJ+3bv9cpjQwDMNPWKxLpb+EofwsYQJo95zaXp64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J32SZ5scCBegEtfuerdu0SC7+kkE0hoNJv0S0k3jUlAFjOsPo/Ktv4WfHecI6DgPOBBFno13ywOk/lQcTnHtYm10+kzkVLIw5TZV9ssBi3J8/cGGyq9NdHAYm4mIEm+2j9SMxNCsteUnob02+Bl49omDzAoFPBpz4NInc8/7AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjjpjnkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF6BC2BD10;
	Sat, 15 Jun 2024 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718412960;
	bh=vfiMJ+3bv9cpjQwDMNPWKxLpb+EofwsYQJo95zaXp64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjjpjnkjY9tlL41Ve5eD4jCTycckrdnRIZxucfFPAp/AeS3qjaBPfiiWaV1duYmmI
	 K3k9huH1xTmXH6ft8YQ0wYl1/uGNmOQ8SIARGjua2llxv02O7eJQIfx8CfZZw6mvcE
	 R1sOHv2d5pCJnEwIC0X1ihfP2DEEPaxh2K5qUp+WMoP2GzdgOazyBHh0g+yEFJf7OA
	 RQMaAzJ68H2b3kGWqn3zXZEL8W4wZrrdfMS/U67xRR0M/lyZaE/NJ+1Fy7UCSPCGqC
	 VCGpPim0ViLOpgEigG80R+kFe1ho3e7e236VOpY0lrYGDGKbPrtwPh0L+n5I2N6Bi5
	 ym0JCAnAiRRzQ==
Date: Fri, 14 Jun 2024 17:55:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anil Samal <anil.samal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 leszek.pepiak@intel.com, przemyslaw.kitszel@intel.com,
 lukasz.czapnik@intel.com, anthony.l.nguyen@intel.com, Simon Horman
 <horms@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v3 3/3] ice: Implement driver functionality to
 dump serdes equalizer values
Message-ID: <20240614175559.4826e4aa@kernel.org>
In-Reply-To: <20240614125935.900102-4-anil.samal@intel.com>
References: <20240614125935.900102-1-anil.samal@intel.com>
	<20240614125935.900102-4-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 05:58:17 -0700 Anil Samal wrote:
> To debug link issues in the field, serdes Tx/Rx equalizer values
> help to determine the health of serdes lane.
> 
> Extend 'ethtool -d' option to dump serdes Tx/Rx equalizer.
> The following list of equalizer param is supported
>     a. rx_equalization_pre2
>     b. rx_equalization_pre1
>     c. rx_equalization_post1
>     d. rx_equalization_bflf
>     e. rx_equalization_bfhf
>     f. rx_equalization_drate
>     g. tx_equalization_pre1
>     h. tx_equalization_pre3
>     i. tx_equalization_atten
>     j. tx_equalization_post1
>     k. tx_equalization_pre2

I'd be tempted to create a dedicated way to dump vendor specific signal
quality indicators (both for Ethernet and PCIe). Feels little cleaner
than appending to a flat mixed-purpose dump. But either way is fine by
me, TBH. Much better than vendor tools poking into the BAR...

