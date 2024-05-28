Return-Path: <netdev+bounces-98757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905D8D255E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC3BB2A928
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA2178CE7;
	Tue, 28 May 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn47sZRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B6178CC8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926456; cv=none; b=Wl0U4XV7ZgDYsjooSIa7nnnY7QJIuCpj4/IqvwiZdLBSYLTmyh1P5hZkLLGprp2uKFeaso6lXr2G37OD0mdTrDAe3+sBkKAdnMGUNgq/Y4c0C6qXhrbmyoWRuSgdkwp0sg/2yra6zC9gVNaCpXHeK6K+I5Wy3I/Pn9v2p4pLJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926456; c=relaxed/simple;
	bh=xUabrjVkxN8o4R8ntx8FJJfFQMqqMQAguaktepl1+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP0NcWRKxV+FSRBCAyS+kqrM8WEiejjnNgjojwtZnIT0e67MFK6/neGPYH2UjJVPOkUWFlqcAw5EIfin9L6cfNqLaVohL4Pw8CFZP7vWsehCcyjyjvBI9DFguN6JWxt9m7UM5RkxennTYPWQVQd33ip6G0dUsPQrQMFBTK7X4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn47sZRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F138C3277B;
	Tue, 28 May 2024 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926456;
	bh=xUabrjVkxN8o4R8ntx8FJJfFQMqqMQAguaktepl1+hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gn47sZRijwKiuKA20fqG+AfzEoinXxjFOCa4zW+RomeYJR0vFdGqqYWfb/i67yP3G
	 8hcmqAWJSDA6TXiZlMeZFDswMBnrHJ7OZczEJmpBR4c+cJOVQu/+NVeseNhUzMMesC
	 KF8apKSwmFd8Ei3LpkqRU8epLmGUjyHN5u916oLT5MRtLzarcqPd/yzDceWjVzqQbb
	 I/+NWToW5VovDhmdBxGL3+GhAof/9ucuk0dXZ4GBv3FUlZYhBPvG+L4aB37ALQuy7o
	 jb7jsNxuQq+Nm4CX2WWWe+PAHbD7kUzKkRAkQCF+ZVoCRGe+X3QvyVvnO4+refc59r
	 MsKVXFPV3C+2w==
Date: Tue, 28 May 2024 13:00:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 11/12] iavf: handle
 SIOCSHWTSTAMP and SIOCGHWTSTAMP
Message-ID: <20240528130055.4ecf339a@kernel.org>
In-Reply-To: <20240528112301.5374-12-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
	<20240528112301.5374-12-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 07:23:00 -0400 Mateusz Polchlopek wrote:
> +	.ndo_eth_ioctl		= iavf_do_ioctl,

Please use the new ndos:

 * int (*ndo_hwtstamp_get)(struct net_device *dev,
 *			   struct kernel_hwtstamp_config *kernel_config);
 *	Get the currently configured hardware timestamping parameters for the
 *	NIC device.
 *
 * int (*ndo_hwtstamp_set)(struct net_device *dev,
 *			   struct kernel_hwtstamp_config *kernel_config,
 *			   struct netlink_ext_ack *extack);
 *	Change the hardware timestamping parameters for NIC device.

