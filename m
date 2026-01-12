Return-Path: <netdev+bounces-249062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC2D13693
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C008C3078972
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172092BDC34;
	Mon, 12 Jan 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffouazh5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80762BE058;
	Mon, 12 Jan 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229578; cv=none; b=Zch9tk2DwD7Un/9A8YRjc6Vap7jhoKnd8Uni2oSdksK/eugu5SN3F7aaP+z0GOob0L+67evr4knqqJFrZm27DMrHXqFEIbQNeSyWsU5Q4egEO7pXqrzpgcq3uE5nfV/O4aGuzg9WfXSR9ZkYNDhwu3q6O02q5y/2qz/px0z9d2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229578; c=relaxed/simple;
	bh=oplnv+4FcIopBLovnp3hn13jlbWLf39jXpZCiCMMc3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jlRiz90cpJlZyOfzj5OhcGnb8v8YFKejFgyYtvl+TOhPymaE9ZC0qaXP+7YtD8d6e8ODRNc40cknqrXq7dNJe9y/q3Mmgo7UIkc05tBORs6a+TwgaUgUVq8JVrXYqZC15RyE/Oj3Pv83BrB7bnuoxainLZ2mhf9o8RRcuCPDvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffouazh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65556C16AAE;
	Mon, 12 Jan 2026 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229577;
	bh=oplnv+4FcIopBLovnp3hn13jlbWLf39jXpZCiCMMc3Y=;
	h=Date:From:To:Subject:From;
	b=ffouazh59MlNgdFlCPGLYLaec/OzXx/b+WSqr2RCnx+n2ZSKCDGy99FJuwYQmhRQG
	 mQrWYuT2wXnV4F9e2nTm+j2hfB7Bl/Ss3C+RL9YOHHHMT8ZudwJyKn401it/aJejBT
	 ZyA8PZemAhd8VoT0lgl0ztdZ01V1M1HlOhgAw9JpsimyEontKamQu2HsENHMuLb1MW
	 Ykm2ro7dksVQidEFNsvHQ6feTJHf6uKIQPvMk3guXVFxv7fQXVN5zVFjFt7mVCqMDM
	 YLT+GrLW1gODMjLeG8xmxHW2/7HeaRSfg7cTXPN2WKLxcnWJ1OSxiBud4XfhNwqUmt
	 8XQB9CBcmCoIw==
Date: Mon, 12 Jan 2026 06:52:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jan 12th
Message-ID: <20260112065256.341cbd65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

We haven't had this call in a while but I guess some of us had
a chance to catch up during LPC. No agenda at this stage.
Please reply with topics.

