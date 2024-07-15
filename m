Return-Path: <netdev+bounces-111480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50A9314F2
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB76B22D94
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821E18C176;
	Mon, 15 Jul 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQOcO9R2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4761891D6;
	Mon, 15 Jul 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047831; cv=none; b=QVYrg1IOkukdC+P1KYWdGn/DphJmI6McCQRufU3SohSQKDT8spB1HTo2z5nDj+/cXxZNTJl/VUNySbBMp3uwuLdVCoq8Bs3uWsQhPcS9484qLQOnkr8EkE8sMvM3xHt5nopVp+6BrTrHo3A4bynltdFLC4XiXu2oQ5UTfO2Nueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047831; c=relaxed/simple;
	bh=pIVANU6xP0xHHXRKTBCyi1bN9Q/dCKwFUjlq/HH6aaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ahe1cPULBzUfkjCAG+goMQRsQ2dFmslSf3qU2kou2Qu8XJpB7q7KZgVXOEWy3mav9KZdSOTLdPU7ewRI+5K43L9x0KbPNVlWQTKWT80C4JA66g6eeK+Cwv7erFo7HhKmTXo6WazgXfKBzsRd2dn5gZzW3f2+ua9qKfjHZf8QGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQOcO9R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC2CAC4AF0A;
	Mon, 15 Jul 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047831;
	bh=pIVANU6xP0xHHXRKTBCyi1bN9Q/dCKwFUjlq/HH6aaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eQOcO9R275tPJWL8v40FE1qer4KJz4NrcrYE94Rtm2qgO2mZVrHQd5CpuP5vQrB74
	 DDumhv2IAZsfvQyiYjk1v6+i1x3iYkagp+t0kFFV9N5QngnTdofCbhiRVgiYTNlH7f
	 4sLxJwoLd87FlgaGjy6EZA+1/WgRoKuSAUeqvXz5JATuCqa762fuDSCSGKbyfdDFj6
	 zu+xkWmzJ/SYJa+XPi26sGMjTlOcIW44OOph9JtzjNT/XSS4iXJ63dGg/5JZ2j68VU
	 ADAI4IPOOBdKjV7pm+Da0Ha57fUQj4afJKuFrkATmv/mIeJUkJ3B8OFnHq+y+zJIki
	 xy5dS/HvGweOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1708C4332C;
	Mon, 15 Jul 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bridge: mst: Check vlan state for egress decision
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172104783085.16511.9830005090027267122.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 12:50:30 +0000
References: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
In-Reply-To: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: davem@davemloft.net, roopa@nvidia.com, razor@blackwall.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tobias@waldekranz.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jul 2024 13:31:33 +1200 you wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by skipping the port state check in MST mode to allow
> checking the vlan state via br_allowed_egress(). This is similar to
> what happens in br_handle_frame_finish() when checking ingress
> traffic, which was introduced in the change below.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bridge: mst: Check vlan state for egress decision
    https://git.kernel.org/netdev/net/c/0a1868b93fad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



