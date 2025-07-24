Return-Path: <netdev+bounces-209587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493AB0FE9C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 04:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE9EAA63E6
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64E1DE8AD;
	Thu, 24 Jul 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOd1gkEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8A1DE2DC;
	Thu, 24 Jul 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322427; cv=none; b=hU8zEp1SdjJRi4JR1phaPJEXjV0vPoU7hZn8b9XE+Coq4+bWokY581drtLr+/Q73Lw2FDDCYga4dA2QBkVcIpKqHordbApHFT4M7CoN6sIoPRNIWQre379lsoPAP5jahnKlbpGkwMg+GIuPPHgvbYTzDtEb2g2qqUSOhTcGtWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322427; c=relaxed/simple;
	bh=2ReRg3n4hrA7gWArFH3HjuQScWTdVpvWDBx4Ru+OhBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQGds1xtKeP4BXMbfSD1+oh23LQSRtrYexLBnDjX2ZALa7sp3Q+lijFpOIPPmZHgBHvFqGHxThhxh+pZkh2zGbeUOOemyU6dLSuAJQncy6iwvw/xdIz7ziaa5ooASOJQfo8hxIL8/GyDnCZIGz5HSck/xwHg5CHT0WjAkbW04WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOd1gkEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F03C4CEF4;
	Thu, 24 Jul 2025 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322427;
	bh=2ReRg3n4hrA7gWArFH3HjuQScWTdVpvWDBx4Ru+OhBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oOd1gkEuDAsKqHRHVFb5Ul2vZ/YXU/iosqu5lAjOh7iT/s/yZCvjYLqL935ILv57f
	 /W+93hj2f4FobEnnsjbWL0utpGkNrUCBUAXERpd2BvrXcsYEqiQoOKeykrOqR6LX39
	 2sAPsgI/UdTLrI1F3aV7KNFdaZ8CvVUzHRUFAQl9rGjCfv0C/yD793ABGHlAYc8/Y1
	 ZtNRY7IS8igg8ssrnxJ6QAtWSSOLSI3yMTJW9gJJwlvhP4QrX6p3BKKJGFL6op/Lpx
	 RsiL4cmoeIqfj8katFocQK+Mup+lZmvgWploeNc5WMLxnqUe8ufgYm8GcLwghjcqLV
	 TYlaZBn08V4Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD41383BF4E;
	Thu, 24 Jul 2025 02:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vxlan: remove redundant conversion of vni in
 vxlan_nl2conf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332244575.1844642.14095040782507524061.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:45 +0000
References: <20250722093049.1527505-1-wangliang74@huawei.com>
In-Reply-To: <20250722093049.1527505-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
 petrm@nvidia.com, menglong8.dong@gmail.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 17:30:49 +0800 you wrote:
> The IFLA_VXLAN_ID data has been converted to local variable vni in
> vxlan_nl2conf(), there is no need to do it again when set conf->vni.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] vxlan: remove redundant conversion of vni in vxlan_nl2conf
    https://git.kernel.org/netdev/net-next/c/918c675b208d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



