Return-Path: <netdev+bounces-101359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21298FE424
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64582284ABD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E31194AF4;
	Thu,  6 Jun 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGcBebii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24301E52A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669230; cv=none; b=pB2st+eaHJPQ/mhPdqIFQv9f0moBgOFkiAkxMQTlpP7mX6XSXFhZP5Wy2HF3jSqBlAjvYfA/xVRawM43Gvp8mLrGyQerr29D06BEeRQi0yW7Nkt3yHMQ9XeaSRgSZsaYTTjnylCsxk0f6DIxoWBypvQceIOgaGnM2xLqakHKApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669230; c=relaxed/simple;
	bh=heq260m7nbsADubToR5/b1qyWIah3uTjPUZGUqiERrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EFxczPA2T36mU3V5sJXTY/DNNLwphsaqL7IFWlPRa3ZHWG8A0dAN8rN5jgX5u199ZKe2ziKoLAzTar35fn8JuLUNQE02/cpM5xJR4gG3NMv7rofxJUYkLqpxdZG0EtlZs5oSbdT+B/TxgGSkDMs8aVVvyadCAEYQbCf2VG0qQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGcBebii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81C03C32782;
	Thu,  6 Jun 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717669229;
	bh=heq260m7nbsADubToR5/b1qyWIah3uTjPUZGUqiERrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGcBebiiL7lNtOcEIBAPyzvUd1hQy+PA2Pz5lpbw6oTpYdedC+FGRAZx+bdEFgppH
	 k5WLK3D/FEzubb+uIMp5AXXXa2YKPGYNWc8AOaFLaEtCLEgJT+oXgWgI6elIS4PFs9
	 l1EuPpNNrl+NbEpXpqwahrxeUYG7n0ky0NGkPN9Sq4bjld62spJcf5OchSrieKNzaC
	 z0CLayiLuUuJmzEri/Z5mDU/AI+uhQr5LxDgN/pZCohal0dxr5okZHY5nhyBw/dW5x
	 uSd9FSvMPAPc8+fUEi3UmcX2algJYAUf/ojBL90JjRhOUO/vO+WpJoY13qdKgp8U7W
	 EeHAxojWBVg5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76A2EC4332D;
	Thu,  6 Jun 2024 10:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use unrcu_pointer() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171766922848.31207.10513608297477102581.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 10:20:28 +0000
References: <20240604111603.45871-1-edumazet@google.com>
In-Reply-To: <20240604111603.45871-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, toke@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Jun 2024 11:16:03 +0000 you wrote:
> Toke mentioned unrcu_pointer() existence, allowing
> to remove some of the ugly casts we have when using
> xchg() for rcu protected pointers.
> 
> Also make inet_rcv_compat const.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: use unrcu_pointer() helper
    https://git.kernel.org/netdev/net-next/c/b4cb4a1391dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



