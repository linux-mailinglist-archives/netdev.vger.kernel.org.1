Return-Path: <netdev+bounces-118120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D680950950
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4371C20C76
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CA1A071A;
	Tue, 13 Aug 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtCE97rY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD01E86A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563827; cv=none; b=OtfRpSZcSpQVronpZ2C+MvjV+g7rpQXfcIOejWU3HOki4mMOx13uDo9uozYb+ISxhPCjBTfEYkALRaarolSrGe7R2RBiAkV18wS5PLVe8OsLYC76N8Y7gnVSTnglPb4SlP8uWDfpXRrQ9RHTAlf7bumnf6wHGrby4eLCkrTVq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563827; c=relaxed/simple;
	bh=w1nD4oRKBHOTRWEMFdmVdwweMJpT7+oYgkT4zTsMCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/NeOyVlVJhMrdn0mo6vXk8y4KtxwDRSK3Yr8C0cp4adK10p8qC6eI+CD540OoLMjg7oEMjxUV1NfXCEjBRt+KoVJii6kzpxjTsMvFQzikNwemxUjSWW0fFPrbU25JcMxNFJgveODbUGTtRVmPakulFX1abzXqxNTCvz9IzFPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtCE97rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3162BC4AF09;
	Tue, 13 Aug 2024 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563827;
	bh=w1nD4oRKBHOTRWEMFdmVdwweMJpT7+oYgkT4zTsMCIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TtCE97rYske5F3PtQtthB9FvbW+ueZ0wdcIlTnQQ0PtAhiSO/ZmZIGOao5FH2p8K7
	 VpiXEsGPGIWbK14WnIttj6lfPc2AzRtYr50kqMwSCQy0IWTFGEWmI9vzEpmwPY4N0C
	 6IRhN5A7uHIhKIvU/aa00PLp4uJ27qV5nU4DRQa35628tUGtqc+LT5uumWB3IBjSnJ
	 k1GPLby8PUKkEBIv7iBHsaliunwT6MghKARN+w33jbbrEnJ/ttVakvCe2Xw4HyU62N
	 NQ0gXqAaoOPbaE32FUpw+zBs+I1nDGZDYoiOX2PzfYfj3qOpIT7vLq5AHOoF0BkfAO
	 PQ+AUlHzgjC3A==
Date: Tue, 13 Aug 2024 08:43:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240813084345.575ffd78@kernel.org>
In-Reply-To: <9f4854e4-f199-467a-bf42-9633033f191d@redhat.com>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org>
	<Zro9PhW7SmveJ2mv@nanopsycho.orion>
	<20240812104221.22bc0cca@kernel.org>
	<ZrrxZnsTRw2WPEsU@nanopsycho.orion>
	<20240813071214.5724e81b@kernel.org>
	<eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
	<20240813075828.4ead43d4@kernel.org>
	<9f4854e4-f199-467a-bf42-9633033f191d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 17:31:17 +0200 Paolo Abeni wrote:
> > "set" is not a sensible verb for creating something. "group" in
> > the original was the verb.
> > Why are both saying "set" and not "create"? What am I missing?  
> 
> Please, don't read too much in my limited English skills!
> I'm fine with group_create() - or create_group()

Again, group was a verb :)
I don't think anyone suggested group as a noun / object.

> Still WRT naming, I almost forgot about the much blamed 'detached' 
> scope. Would 'node' or 'group' be a better name? (the latter only if we 
> rename the homonymous operation)

I vote 'node', given the above.

