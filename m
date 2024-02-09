Return-Path: <netdev+bounces-70558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68684F891
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA00E284762
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FB745E6;
	Fri,  9 Feb 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUMNHVNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBB745DD;
	Fri,  9 Feb 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492606; cv=none; b=fQOMnuqb4+33fqpwk+b3d/Wpv5zcQbceE7DlOOh1jaINHhwUhl+HJ3EBaPOX4JiDXh3KKb1C8O1XIHIqbsQkzf8CqSsfGh+dNm2tQ8/+3IK8IIQZ61vVSfnrA8Q0Ia9Q4O7CySevjyMkssk89ix8M8urB2+V74bOCU/NnBQQ3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492606; c=relaxed/simple;
	bh=9ZNVcfCx2id7zasFzjp7Q1+4I6SJDwjcJoq6suy8EDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrW4+Xrh5rxTWzrFEwUP9i2lHuEJcu3+Up7UbTD2BCka1GR9gorTao7vvLFV7d/VdVIfj6cvvDTlTDQqy/kq/XL3nedG1nLY2IpSUv8kSoGKCyeaaMEKOwYwnN6dg5erZb4E1Blo9wSd0Xd1IiSztI+Oy38ArM8LaBu7wtE8OKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUMNHVNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BEC433F1;
	Fri,  9 Feb 2024 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707492605;
	bh=9ZNVcfCx2id7zasFzjp7Q1+4I6SJDwjcJoq6suy8EDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUMNHVNzQqBvNPasgTJHnC4ecuVTi2FjJT595EabruD6qJhPGDqOSTwyIlCHsd3D7
	 dQJqI4rcsaztSGxUEs4a+CdSwXjeRUqRw2aTDY1cYe8InJjblOM3Kh5fsMlK8aUxtV
	 R0is10FuEdiFmysty2Tdpx1LdKNFMpqAtcHiPRKMWfFTpBA3uzUl8qcLW1JkcTHaZ5
	 wqLHYlBG2SO1U4UZMzCtSE6fipJdC2Ndhj3FY52BBUbxOzvjEUTl4Z12GKC4MNoxzB
	 9MqF7236ihjF51qqWePAOwNoNqYS+MHaFZi/h6L2F/HVIo0UMbj0YZXFbgyoySAWVF
	 rprSDa3KA1x5g==
Date: Fri, 9 Feb 2024 07:30:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240209073004.585cb176@kernel.org>
In-Reply-To: <20240209102510.GB1516992@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
	<20240209102510.GB1516992@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 10:25:10 +0000 Simon Horman wrote:
> On Fri, Feb 02, 2024 at 09:31:48AM -0800, Jakub Kicinski wrote:
> > Hi folks!
> > 
> > We added a wiki page to the nipa repo on how to run the tests locally:
> > 
> > https://github.com/linux-netdev/nipa/wiki/How-to-test-netdev-selftests  
> 
> Thanks for this.
> 
> I am wondering if the URL should be / is now:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Yes, I didn't realize editing the title would change the URL.
There's no permanent link either, it seems.
I added some links to the home page:
https://github.com/linux-netdev/nipa/wiki
And also the contest page now links directly to the repro instructions
(top right corner). Is there any other place we need to update?

