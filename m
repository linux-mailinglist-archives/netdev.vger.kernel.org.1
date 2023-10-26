Return-Path: <netdev+bounces-44585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818107D8BCF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AFE281FB6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CC168C7;
	Thu, 26 Oct 2023 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD6tylj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5868BFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD11C433C8;
	Thu, 26 Oct 2023 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698360393;
	bh=RehIgzpbnoltbBcEZDMw+bozyCWn+t0QY8Vs+iYcxDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LD6tylj/c/OZYU/vIs+7gyery8yUT6So2CHQqx9kuU6rcWFiC22SZFbqREGMVpHX7
	 Pr6LGYOgSgwsfSphtBnUn/oYz6iMg1u44Got7sEVcqSuklqtOnZ+pdguNuw8mONcfJ
	 zXrjmR3412oaii7cndDuK5izaC0G6o/a5zIYpqLQlKGyfW6AjBoTjkimhF2N8ey1gB
	 xd0eFwIyBWsAKlVugycf9GX2sXJPnW7ssj4e0H43hkdGsQFcsTuuXN6ytsjPR/oYAF
	 /pEl3sklibvRbYdoIO2W30tYOflnQzuD6Lfkld/rBVe6OzW/lgNYUKM2QY7N7whwdJ
	 HBJ2etnOpKQ2g==
Date: Thu, 26 Oct 2023 15:46:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231026154632.250414b0@kernel.org>
In-Reply-To: <ZTrneUfjgEW7hgNh@x130>
References: <20231021064620.87397-1-saeed@kernel.org>
	<20231024180251.2cb78de4@kernel.org>
	<ZTrneUfjgEW7hgNh@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 15:26:01 -0700 Saeed Mahameed wrote:
> When I sent V1 I stripped the fixes tags given that I know this is not an
> actual bug fix but rather a missing feature, You asked me to add Fixes
> tags when you know this is targeting net-next, and I complied in V2.
>
> About Fixes tags strict policy in net-next, it was always a controversy,
> I thought you changed your mind, since you explicitly asked me to add the
> Fixes tags to a series targeting net-next.

Sorry, I should have been clearer, obviously the policy did not change.
I thought you'd know what to do.

> I will submit V3, with Fixes tags removed, Please accept it since Leon 
> and I agree that this is not a high priority bug fix that needs to be
> addressed in -rc7 as Leon already explained.

Patches 3 / 4 are fairly trivial. Patch 7 sounds pretty scary, 
you're not performing replay validation at all, IIUC.
Let me remind you that this is an offload of a security protocol.

BTW I have no idea what "ASO syndrome" is, please put more effort 
into commit messages.

