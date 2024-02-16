Return-Path: <netdev+bounces-72262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD458573A8
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4791F2363B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 02:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8BDDC5;
	Fri, 16 Feb 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnUml87w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA6DDC4
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049251; cv=none; b=fja419yBm+X5wf+Gj+0iwNKiHw/kGc83WFnibFPQ7qZGg/L4PXw7q8yPqjigSInudfyDjjU1SBc/8Jo/4cuJBgmBHUljXS5qrJLulBrO8ikv9S3ffTKJbd1uthafC+6x41VcuojjLNlodDBJ+T7xQSDCKgKZd6yfE1odU9Gcxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049251; c=relaxed/simple;
	bh=pNaxx+tC6Xq1HYfS9c61tQg77prpGD/S9HkO89pKXfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWzhbTxcuyvoHYdJJm8BiwGabfPkxDiA65pWaoOmgzcNGzKZJYfeCoxIrkzfnIcfzwyw0/idtt/JlcOc/ENaJ1viLigL6PLkwBbECBNXhJwAhJIaL5HYgdxd4KiRbgfUpEaOAu6JnfNfjS9UgSpFNOdd+VWlHrWnpA/v0VZbdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnUml87w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED26C433C7;
	Fri, 16 Feb 2024 02:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708049250;
	bh=pNaxx+tC6Xq1HYfS9c61tQg77prpGD/S9HkO89pKXfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fnUml87wEA5swRCVeU+sQVsCGs+Jc+8Haj/HQtb3Y0oA8WhZ+AAAP9FrCCcZCkr62
	 nT1hTbYuWms8k4wu5lcLH3BdQYE0XYlm8bRJoOfVxIs3V3t+Tu6kNZQo3HxXwkMz4B
	 rwXe1DJQqYHY2FZ1x4aVR5P4ATh8mRo0IHrLfg2bVEEBeXiEgGpTRvkSSRqn1Tq6pc
	 lqfdDqV3DtY2pjI6bD6DVJeaIq6u9NW7TIK8dgg4INvfATJ4sdQyahy26qaOd/Hvdd
	 Y/gzlTZh85TCtxHJX+y1krfWUZPG/nY3ccmaJT6+b6bP4C+cF/W0EiPPae0eQW3PeZ
	 Rmt79cEtEXg6w==
Date: Thu, 15 Feb 2024 18:07:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, <bodong@nvidia.com>, <jiri@nvidia.com>,
 <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240215180729.07314879@kernel.org>
In-Reply-To: <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
References: <20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
	<20240201200041.241fd4c1@kernel.org>
	<Zbyd8Fbj8_WHP4WI@nanopsycho>
	<20240208172633.010b1c3f@kernel.org>
	<Zc4Pa4QWGQegN4mI@nanopsycho>
	<aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 09:41:31 -0800 Jacob Keller wrote:
> I don't know offhand if we have a device which can share pools
> specifically, but we do have multi-PF devices which have a lot of shared
> resources. However, due to the multi-PF PCIe design. I looked into ways
> to get a single devlink across the devices.. but ultimately got stymied
> and gave up.
> 
> This left us with accepting the limitation that each PF gets its own
> devlink and can't really communicate with other PFs.
> 
> The existing solution has just been to partition the shared resources
> evenly across PFs, typically via firmware. No flexibility.
> 
> I do think the best solution here would be to figure out a generic way
> to tie multiple functions into a single devlink representing the device.
> Then each function gets the set of devlink_port objects associated to
> it. I'm not entirely sure how that would work. We could hack something
> together with auxbus.. but thats pretty ugly. Some sort of orchestration
> in the PCI layer that could identify when a device wants to have some
> sort of "parent" driver which loads once and has ties to each of the
> function drivers would be ideal.
> 
> Then this parent driver could register devlink, and each function driver
> could connect to it and allocate ports and function-specific resources.
> 
> Alternatively a design which loads a single driver that maintains
> references to each function could work but that requires a significant
> change to the entire driver design and is unlikely to be done for
> existing drivers...

I think the complexity mostly stems from having to answer what the
"right behavior" is. At least that's what I concluded when thinking
about it back at Netronome :)  If you do a strict hierarchy where
one PF is preassigned the role of the leader, and just fail if anything
unexpected happens - it should be doable. We already kinda have the
model where devlink is the "first layer of probing" and "reload_up()"
is the second.

Have you had a chance to take a closer look at mlx5 "socket direct"
(rename pending) implementation?

BTW Jiri, weren't you expecting that to use component drivers or some
such?

