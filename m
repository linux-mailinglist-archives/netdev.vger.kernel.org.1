Return-Path: <netdev+bounces-239356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C079DC672CD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5FDD329AEC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4BA25D546;
	Tue, 18 Nov 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIhwV6yU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36A21CC79
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437266; cv=none; b=RjrP1NMzPfA9TaIhtpdLlQyLvuKIejWWORe1gM9XaRcboq5f4/n0WsourtBBZn52fYJkyGSzrRLhXdV0W0Y80lh75nCpP6iox5+3mDjS6SRhw7QRKUstJJUdzQn6YGiMStRrIr7keWv36hbXW7QRvISWC5DXAAJybC5W8EmlDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437266; c=relaxed/simple;
	bh=OQaOYpr8vPQPVWhnq6HI6/VB8djnyrGp032SrgQHzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjGelNj6kv6Th+93u4xzkltwq4YTwUk12pFEW/wtqonu0rrMw1i/fue/Wvtr7hGcO7VJeX8AlGpahW/z4eNeBFKxiC6HDSeZ7VAmgvRAtJmnN9kOo17IIZ2CArFeu0pFjLsx0OSjdh0RCokoipX8T5oKfLmqOXRkB6tzwoptE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIhwV6yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCCCC2BCAF;
	Tue, 18 Nov 2025 03:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437264;
	bh=OQaOYpr8vPQPVWhnq6HI6/VB8djnyrGp032SrgQHzZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIhwV6yUYPZ3FJYv0eim/aGzCzbh50Y/rBZt77FWyDqNW6NWa4Yggs196eJ8al2bu
	 PA4mCVFBXOfhitU8cnw4DeKD4SARrMLZih6xCOx3HePk9cb5ao55h3w6tiUYKprIuu
	 cJWLMZjpTanlUN3CGvH8B7cd+Ue+23GvOrkF5PAaUHDxb4slj0cNYrWnwRZ6TVFlTJ
	 1Eb1q2b93Lrv7uq5OOqPDfTWdDejE5gEMUVsMDNDxu1x+M0kstCjYZsGSV7htTuUZv
	 9xSkzRcYZt/xSydO5YEospP259abyaQhYX1LGU/gtIuiJgZJZ6wAHgXOe5DqimLp28
	 4qo2rzO+o2vxg==
Date: Mon, 17 Nov 2025 19:41:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251117194101.3b86a936@kernel.org>
In-Reply-To: <20251115025125.13485-1-parav@nvidia.com>
References: <20251115025125.13485-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Nov 2025 04:51:25 +0200 Parav Pandit wrote:
> +	err = devlink_nl_eswitch_fill(msg, devlink, DEVLINK_CMD_ESWITCH_SET,

I've never seen action command ID being used for a notification.
Either use an existing type which has the same message format,
or if no message which naturally fits exists allocate a new ID.
-- 
pw-bot: cr

