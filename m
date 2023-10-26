Return-Path: <netdev+bounces-44581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF87D8BAA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48018280D5C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968303F4C0;
	Thu, 26 Oct 2023 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjat1067"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E762F502
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0509C433C8;
	Thu, 26 Oct 2023 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698359162;
	bh=HfnPzCNc+/gkZGfnqevmqynUNGH8wyyukv09I2ZY0Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjat1067uSwHn31eGbjZBJngTiJiSBj4cpUoAJYESxY3j1RHHEDLFstucVqCVMqxg
	 gezmkBgG1AfROOo/e4ENjbH9nFplOQwwts2ywTKSWYfPitN+7cIeNtXuOJ08n9dEPN
	 hnBtUsbIozAOlOvDVva7h9KorExhQYss+nP4OODdohJ7Kkkh+8/2eawI+km42HSCSz
	 97gtIRSF1fgMA+JKJETYUIW31WOlLJjMHNppuLUEAVuDsqBhbZu0c5rUorAM3v5wGa
	 yKNgqfCtATqHiD6tsIDSBvcygzFzKGMFR8YoTk1n3yoCscWTLbXEGeqGjLyhQZxb2V
	 r7ouz+qBPG+yQ==
Date: Thu, 26 Oct 2023 15:26:01 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <ZTrneUfjgEW7hgNh@x130>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231024180251.2cb78de4@kernel.org>

On 24 Oct 18:02, Jakub Kicinski wrote:
>On Fri, 20 Oct 2023 23:46:05 -0700 Saeed Mahameed wrote:
>>   - Add missing Fixes tags
>
>Fixes for bugs present in net need to go to net..
>We are pretty strict about that, is there any context I'm missing?
>

When I sent V1 I stripped the fixes tags given that I know this is not an
actual bug fix but rather a missing feature, You asked me to add Fixes
tags when you know this is targeting net-next, and I complied in V2.

About Fixes tags strict policy in net-next, it was always a controversy,
I thought you changed your mind, since you explicitly asked me to add the
Fixes tags to a series targeting net-next.

I will submit V3, with Fixes tags removed, Please accept it since Leon 
and I agree that this is not a high priority bug fix that needs to be
addressed in -rc7 as Leon already explained.

Thanks,
Saeed.

