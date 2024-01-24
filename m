Return-Path: <netdev+bounces-65688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB683B591
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C601F23BC3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D313665E;
	Wed, 24 Jan 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMKdmAqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6F136656
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138722; cv=none; b=OCrTYfZv1UCxCGBpgBNPl06U34mMNVLOBhitQNBhedc43sI9asLph7IbHYgsbgmuhTHblS1PUagxQnMIsibTwb/3uQZbKIZMs6EzG5Ob8eEpi+9Uks5kdGXUFxen1u29WUg0mL6Uq8WfOq1ki2C1+37/qmRbAhKHRTKwyVaHkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138722; c=relaxed/simple;
	bh=mS4D7ctCAGwTiChKKipSFbTSUcNug4Z6StYF3FFc3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2bjII5BGtATErVJhX5tVDf/RRcjLyHGQ74M/6NtNyvliD//H6CWgjXWBreyH9DZled/OVid7oYS9zTRCHLScjEb4YuEQFdLxUiwo7B+/PJHn/obnZQ1WK6utR/vLhG0czMr5mAi//sMdROD+Vwue/U2WH6u0vE1zjIDx/+N9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMKdmAqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B587CC433F1;
	Wed, 24 Jan 2024 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138722;
	bh=mS4D7ctCAGwTiChKKipSFbTSUcNug4Z6StYF3FFc3yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMKdmAqZrdK5OSjEY0u0iNI8KKYPLzV84wjjTej/Yw0eMtyH/jUiXHGYSb9RWPkdM
	 RfSMSgQQAZLd7FqJOKxk8cviGrX7EtirKT/q+5Pb2n+nfRFEDwIRVwQ8qo3IDv/KMc
	 biFoyyHbAFoo6g1i6wp29FcrCuvCU4Rham2ahwz1Nt8CtMqYQSvCJOsKWtXcE7kxPL
	 UBu4gSPNNqgW7VyaC1TRYrWeuBMfj1lKqtOyOsVko5mcrrIJqjGyJn2s7yABX0RsyA
	 VXALmE3yFC21KeKJ0v4BG8L+Jld6JacnAJRWaGlnSdXFKXOtxZmXrJFAZP/5IFyaht
	 TmfmkOX8W9SQg==
Date: Wed, 24 Jan 2024 15:25:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Add support for encoding multi-attr to ynl
Message-ID: <20240124152520.4be53f65@kernel.org>
In-Reply-To: <cover.1706112189.git.alessandromarcolini99@gmail.com>
References: <cover.1706112189.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 17:34:35 +0100 Alessandro Marcolini wrote:
> This patchset depends on the work done by Donald Hunter:
> https://lore.kernel.org/netdev/20240123160538.172-1-donald.hunter@gmail.com/T/#t

You'll have to repost once Donald's changes are in, sorry :(
Our build bots and CI do not know how to handle series with
dependencies.

