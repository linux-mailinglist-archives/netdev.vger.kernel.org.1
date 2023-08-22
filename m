Return-Path: <netdev+bounces-29727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C1B784808
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0E21C20856
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4EE2B55C;
	Tue, 22 Aug 2023 16:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65E2B546
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E80C433C7;
	Tue, 22 Aug 2023 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692723182;
	bh=1PCdFDvVtS6q1aCDOFe7QTda6W7MpcZ2xfJ2LZ9QIbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfIluj/XOmj1Vo69xYyBpbO8ovsot7Y2I00bnwHpW22TsutWjNv0r750auv12htnQ
	 TmZjDj9nY9UWNXqy91kp07O+qeYDKnWuH/GkIJN8+Dd63fiqFi2ohgtkl209VuZfuJ
	 H6HNnU3iBfJ1o4PIzwEWnmtLhO9dCTWYWJ3eVBTCLuH8ozT7UrtKkwvrWNVbq0efr/
	 +zOAQjYgQI+COo0N65Rnm4jbkr6wKIiC3SSEzdlEDd+OG4WviFNsXMCgeSPoCNmSxo
	 ZJKkzxbjpdstG1nj+ABUAmJbFMpGlbE1KxKqXT1CNt4uOEtcFdCAbXj19VoRYus6Mx
	 C4ex4mBwja0sA==
Date: Tue, 22 Aug 2023 09:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 anthony.l.nguyen@intel.com, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, Karol Kolacinski <karol.kolacinski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Saeed Mahameed <saeedm@nvidia.com>, Jiri
 Pirko <jiri@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
Message-ID: <20230822095301.31aeeaf2@kernel.org>
In-Reply-To: <20230822160651.GN6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
	<20230817141746.18726-2-karol.kolacinski@intel.com>
	<20230819115249.GP22185@unreal>
	<20230822070211.GH2711035@kernel.org>
	<20230822141348.GH6029@unreal>
	<f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
	<20230822154810.GM6029@unreal>
	<8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>
	<20230822160651.GN6029@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 19:06:51 +0300 Leon Romanovsky wrote:
> Can I suggest change in the process?
> 1. Perform validation before posting
> 2. Intel will post their patches to the netdev@ ML.
> 3. Tony will collect reviewed patches from netdev@
> 4. Tony will send clean PRs (without patches) from time to time to
> netdev maintainers for acceptance.
> 
> It will allow to all of us (Intel, Nvidia e.t.c) to have same submission
> flow without sacrificing open netdev@ review which will be done only once.
> 
> Jakub/Dave, is it possible?

That sounds worse than what they are doing today. And I can't help
but think that you're targeting them because I asked you to stop posting
directly for net-next. Vendetta is not a good guide for process changes.

Let's see what the 6.6 development stats look like. Then we'll have
a discussion about what we can improve.

