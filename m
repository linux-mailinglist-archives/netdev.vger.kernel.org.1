Return-Path: <netdev+bounces-54886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F44808DB4
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8436A1F2128F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1046BAB;
	Thu,  7 Dec 2023 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP38tHyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D1168AA
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB0C433C7;
	Thu,  7 Dec 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701967508;
	bh=JeKwB/GAD7ntrx5bD/J9xGlTXHGsoM0MFeCLDL+CA0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pP38tHyFS8AP/EpETtJS6mSjX/uLyh3ip59lVdV438kdORTw3wHX3PZqPB1PC2dM5
	 icHy7r3Z6myu1lCO2M7cxE/QHQPBVRBwuILuGXNFwbUR/z7GThoJwJMD0YHJp8Rvox
	 aFBQItL8KstyUKK/K4FvOrLNZxPec3Mk1vBKTI5YULsL0Hp6vWwXDZ05/m/rnQ8R8h
	 VJcS1HZPmONL0pjF7lW4zjJ2uX2D9x5zpTGgX06huE/dGNq2MNtJGhNnjBO5Z+i5sP
	 lXsbx5ZN8HlTlGlIsE55RAI0m57tKXxwYjBeahL2O0crX0aSQSWTNj6osdmCF3nSK9
	 ear/GHQTCF9xg==
Date: Thu, 7 Dec 2023 08:45:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting
 RSS contexts
Message-ID: <20231207084506.727fc175@kernel.org>
In-Reply-To: <2ea45188-5554-8067-820d-378cada735ee@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
	<20231004161651.76f686f3@kernel.org>
	<2ea45188-5554-8067-820d-378cada735ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 14:15:30 +0000 Edward Cree wrote:
> tl;dr: none of this is impossible, but it'd be a lot of work just to
>  get rid of one mutex, and would paint us into a bit of a corner.
> So I propose to stick with the locking scheme for now; I'll post v5
>  with the other review comments addressed; and if at some point in
>  the future core tracking of ntuple filters gets added, we can
>  revisit then whether moving to a replay scheme is viable.  Okay?

Sounds good, thanks for investigating.

