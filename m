Return-Path: <netdev+bounces-117692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA3194ED3B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB699B22DD0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05717B4E9;
	Mon, 12 Aug 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx0oOMga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA217B428;
	Mon, 12 Aug 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466427; cv=none; b=cyS0cpx3lPaoWYpK5STBpv//QSoOQVYPL38z5OVa4rL6uJgBJPd7/P35MiVuNGwzl/Xte/rDMUM3B4RhYzs5OH7O5JsP9B2Vdi96oDSz3LjLbT8J/tBfFTHM59qcxYYLl9vJhpvATSyIje/LI+tGf9BHdgFzTbXRpQM+UHdre4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466427; c=relaxed/simple;
	bh=hxvENyo07WG1H0d4ud5FRdEjMpjzeHc9iWhjWsTNLeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PMnlBxikBm1/ilKC8FMsRIDh0vaQBy3cPeJ9EUe2gHxlUJkDOb+fUJZ0mmH3lbqO/HAdNK9eeL33r76eWZymzhZu1ykFB6KqtIJPi4dymP8qqdReDSnM28jeAL0VTxs/JD6DT8SJaArtEiQrAir4gso1m0XYFJLShONxrUW204s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx0oOMga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB78C32782;
	Mon, 12 Aug 2024 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723466427;
	bh=hxvENyo07WG1H0d4ud5FRdEjMpjzeHc9iWhjWsTNLeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zx0oOMga236f0TjlUyQY/cFFDFAHyss5bMXmW6fBXrH6tNs5TaM1xcSqmSmYzYIur
	 xqgNLJa/hUBW3ldHa0mxFLWHM28kSLhJYxMLEU8ojSn4AiTrFZRI/AGtU5KOcJm5hi
	 /0ndwHeE6LgFyPDt/NRmDmiPr7+U537CGPKcY5HR7srng9GCk6QO8q0c6s/KsSJccl
	 6Z5f+9IxOJ0r5+Md8qsDEkcW6+6W9LxUrmjXTTGBPyO1qtXTBHmwtYVDKsW9HQq8UK
	 KdPa+kUoCIeyOHxeLiRaIrcHSJ9rWKZw8P/v82fcTXyAXrErf4oPEderu4xpJzn+VX
	 87ozoD79gr6sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D42382332D;
	Mon, 12 Aug 2024 12:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vxlan: remove duplicated initialization in
 vxlan_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346642625.1012384.4914709823946390896.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 12:40:26 +0000
References: <20240810020632.367019-1-dongml2@chinatelecom.cn>
In-Reply-To: <20240810020632.367019-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, idosch@nvidia.com, amcohen@nvidia.com, gnault@redhat.com,
 dongml2@chinatelecom.cn, b.galvani@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 10 Aug 2024 10:06:32 +0800 you wrote:
> The variable "did_rsc" is initialized twice, which is unnecessary. Just
> remove one of them.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: vxlan: remove duplicated initialization in vxlan_xmit
    https://git.kernel.org/netdev/net-next/c/6b8a024d25eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



