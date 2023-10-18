Return-Path: <netdev+bounces-42290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49F7CE0F0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75555281D3A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A938BDA;
	Wed, 18 Oct 2023 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaaiYcn6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83D20307;
	Wed, 18 Oct 2023 15:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8838DC433C9;
	Wed, 18 Oct 2023 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697642223;
	bh=tYDvOcQYMxY8m9SGQfhjrd9cWuqQEEGhyR4rDAfRaTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaaiYcn6gSFfDUR4XbUsgIuZNCRef2tMCpBfqHEC/E5+oGAGB3ida/odELyAWoDjl
	 b6xWex8Glgld6p82OZIh0Irwt6fPPmnUjYrKc3dp5C6L7wwEUUornJcOW99to2CvgW
	 49S45IDtHNnXtqLPM05RXzaVt1AXSTNUD6UeupynzD7smRsNChIkXNjmKn/tQ3XLYd
	 z2Actt8+5SrIE+MWNywgJ45dpkMXJzJawDNLxz/CxLW0ME3W6xU+E321/evOfuphAo
	 jfXtHaBkBQAz83ZesH5XZj8Ub9CnnQ3Q62uehbOtn9PvprhdzJsnvEObt30q7SFG46
	 d7upvMuv5C8Ng==
Date: Wed, 18 Oct 2023 08:17:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: Louis Peens <louis.peens@corigine.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, bpf@vger.kernel.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: bpf: offload: Check prog before dereference
Message-ID: <20231018081702.2e24ce32@kernel.org>
In-Reply-To: <20231018145244.591454-1-artem.chernyshev@red-soft.ru>
References: <20231018145244.591454-1-artem.chernyshev@red-soft.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 17:52:44 +0300 Artem Chernyshev wrote:
> In nfp_net_bpf_offload() it is possible to dereference a
> NULL pointer.

And who would call this function with prog = NULL if old_prog
is also NULL, exactly?
-- 
pw-bot: cr

