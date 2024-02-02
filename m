Return-Path: <netdev+bounces-68291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193684668E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ECD1C224DA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333AC8C3;
	Fri,  2 Feb 2024 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQEknTRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1663EAFB
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844655; cv=none; b=PElM0FFP1N78ogsUoIIU1QbB2DoyzCc7+0MCADSusOw/AIsIuCrmOUPIdDJbpdFHx4kiIDhmfl2pkSBl9SBuYreucQK+nq4t4WIZxvk19lCsIlry+VSDkaFnUk1X8uVhYyLvvlBoQnye1+0VzlM9Nx//StDKyoALzwKTFlAI1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844655; c=relaxed/simple;
	bh=YB58uL0vd9C7zXR3MUALx3Xy9Es4q5H9cUmii8RuLcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByRbHrIhvJTdaZUNu1nsvyF6XybAmxRLYtIV7Z8NF2klazwweMTXh3EmAVEBpN0GnYCViqJIV9dki+zvrdgcnMoEwiTb/1As6tqpttepU4Xv21rhn6T+ti/Atc3twoqUlMwcf6ZFbX7SQFDBGhZNJ9y3Vq7VgXmMyABMpadlzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQEknTRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44962C43394;
	Fri,  2 Feb 2024 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706844655;
	bh=YB58uL0vd9C7zXR3MUALx3Xy9Es4q5H9cUmii8RuLcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQEknTRObrQCJsvICpSrNk7f1/RYknmSlo1R9rCKPYoFRazqdjCDDtP3a789TShEl
	 v5ohIEAyS/vxwz9MbYCBvuJEnXyIsIC/uyU/uRhFEkdKf+j7gLkkqq6gKjhy8sI6Kt
	 5hPeLciRgcDHETPtrdNTnbS8ly1Zr/rXg8KCUyhkevs1vrk0iq6fi4q59857tMdGtm
	 995exWrOwUqLB1QNz65ViNqradAId3Uwy6atJuHlVGzBAERXIMlCbmUFO7N2bpnNU1
	 m62Th0bXUA2L4neMFhB52Dana9R2af/06tIAmll1k/PAhQzzLAWHLwpaSvVWCYW+ql
	 sQR88oA6CqGAw==
Date: Thu, 1 Feb 2024 19:30:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
 jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 ecree.xilinx@gmail.com, Yossi Kuperman <yossiku@nvidia.com>, William Tu
 <u9012063@gmail.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240201193050.3b19111b@kernel.org>
In-Reply-To: <39dbf7f6-76e0-4319-97d8-24b54e788435@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
	<20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
	<20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
	<20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<39dbf7f6-76e0-4319-97d8-24b54e788435@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 11:16:22 -0800 William Tu wrote:
> >> I guess bnxt, ice, nfp are doing tx buffer sharing?  
> > I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
> > I'm 99.9% sure nfp does.
> >
> > It'd be great if you could do the due diligence rather than guessing
> > given that you're proposing uAPI extension :(
> >  
> *
> 
> (sorry again, html is detected in previous email)
> 
> due diligence here:

Thanks for collecting the deets!

If I'm reading this right we have 3 drivers which straight up share
queues. I don't remember anyone complaining about the queue sharing
in my time at Netro. Meaning we can probably find reasonable defaults
and not start with the full API? Just have the

  devlink dev eswitch set DEV mode switchdev shared-descs enable

extension to begin with?

