Return-Path: <netdev+bounces-109552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F018E928C77
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A710B25A36
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1516ABC6;
	Fri,  5 Jul 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU4MFAoA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537D14E2D6
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198233; cv=none; b=Kqt2n7lrGNsXGzfmNRU99Pa9Jb+cdnD00TBineQv7r30koIISuw+cyiCioFjnzMS1ha5tITJ8zJXqygrOUN6atquPJ8cl9irghedaCX/A5Ag+Y/re4x+G/OZ5zt9hxmDBDVFYQggrKu3OW8oUTuINcuMLdZfI/lpbnKF3mJ0HLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198233; c=relaxed/simple;
	bh=5XAu9MoF4dG7d35tmEDksQZB4pSRXzaIVRun86t+YXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ClFZ8wj+XCV2WpCYLhqwqrpp6w1x5kYiPv3s5P3q0KXNiL4ae1Xz0sVzisYqmJ9456CAZ2B7+398SwonPVoZbwZa8SyzOXegO2+csR8B4o+rn91iZ1HDSDo44EYqkn197wKZoiLwygP1G5tGbw+395k5D2epcb7WjpQjX5jMmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU4MFAoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 515F9C4AF07;
	Fri,  5 Jul 2024 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198233;
	bh=5XAu9MoF4dG7d35tmEDksQZB4pSRXzaIVRun86t+YXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uU4MFAoAoOIWfWnAwN/suiac61SNcioBzJjsfLMREA12j+mMhcV5RbIcI/EDNyG9S
	 T2zCaet5mjdbIkE0KkyGpMExCxs2M7CBD89Azsl/xzw4MILVoXy2h+yLmoehKZb8BP
	 FBNBmvSV/97J9/j2PvM4OIdbnUs1xQjo+WP7XSTdPWxA1wm0P/rL0uEfv+cHOqpTV9
	 FRGWOEhg8+8gA0YiOJc4LDp1gEpM4cwjgOwztY8Vo9TDz/8YZcvE6TpOkbsDmOKVcu
	 5Q/o/ej/DN3OKxB9As0/Rv5CEYPoPYtaajAekFki8SDmW2q9DsRlEW93j6FETxYymi
	 yKmwy7HZKwAaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39982C43446;
	Fri,  5 Jul 2024 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] route: filter by interface on multipath routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172019823323.18928.11832863150821186305.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 16:50:33 +0000
References: <20240705004440.186345-1-stephen@networkplumber.org>
In-Reply-To: <20240705004440.186345-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, matt.muggeridge2@hpe.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  4 Jul 2024 17:44:19 -0700 you wrote:
> The ip route command would silently hide multipath routes when filter
> by interface. The problem was it was not looking for interface when
> filter multipath routes.
> 
> Example:
> 	ip link add name dummy1 up type dummy
> 	ip link add name dummy2 up type dummy
> 	ip address add 192.0.2.1/28 dev dummy1
> 	ip address add 192.0.2.17/28 dev dummy2
> 	ip route add 198.51.100.0/24 \
> 		nexthop via 192.0.2.2 dev dummy1 \
> 		nexthop via 192.0.2.18 dev dummy2
> 
> [...]

Here is the summary with links:
  - [iproute] route: filter by interface on multipath routes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0ea0699ea01d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



