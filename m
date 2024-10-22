Return-Path: <netdev+bounces-137849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504D9AA12B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310611F2284F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615791990CE;
	Tue, 22 Oct 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnLNvkYB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D017B436
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596625; cv=none; b=cuJ8/Qj/L6FxEJzUq+e+cttHIl4lD+aUcR6gKNPvLLWxZo2wt05JrvqCzGENMIF+YLMKC5hVQwu2jIWtuwsdiK9oA8MDlQCA3AQe9NLH347D+SaG6v/u9wNIHjrQ0u480AT1b3MZnlEqpu35GXufIsf8l7rLPm4cvuFDDChCjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596625; c=relaxed/simple;
	bh=T/vYDub+WqPoBmB2IC+cQ5Yz74JbFCEJ9hJllq6XYIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZrP/QlyOm9OrmBCVCjp2JHBwIVBWZj5TBqZFiaTrm/gRmI3MqCuHPCNp8EyzNYg+LH6x8e5+vzjSph9hW1U/lKD/4+NEDDIBNU2RLKQmCfKN/8iwuCFJSWENagHz0kVMId1/kP+0guUi/G8giILgnNiaU76u4Csk8cFERyIklmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnLNvkYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1FDC4CECD;
	Tue, 22 Oct 2024 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729596624;
	bh=T/vYDub+WqPoBmB2IC+cQ5Yz74JbFCEJ9hJllq6XYIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gnLNvkYB8X7u1Yuf9BTcfkkbRKR2xZJlpw4mDbNeLJC0UwE8LivWs0pZVw+N02pk4
	 nplC3ElT63bw4i+g2juwFj6xHC+m3sD6ysm74xm09U3kuLg/cLBJjdI7EGA5TXBafR
	 S6DdNi2WQU3igWvxYjD/9gQMseFzKE7TAu6NZBpDlvU9N9/CAxZ+VZQLj2TAbTaLb4
	 68BmCAQizkC5YUdR6y5cli8EScnssQVJ2VsM8dNxgez8strxkHi6MPsI/e3aetmhGL
	 9HRKe/GmiqBBUv3pKQNfxzL4B4kN3Y9w3IAfiEvaIw7aqWm/DtEprDWaK/rHoaA3zZ
	 dgzRT4zTEIkKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B933809A8A;
	Tue, 22 Oct 2024 11:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172959663100.937353.5541224503906245480.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 11:30:31 +0000
References: <20241017071849.389636-1-oneukum@suse.com>
In-Reply-To: <20241017071849.389636-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, gthelen@google.com, jsperbeck@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 09:18:37 +0200 you wrote:
> The fix for MAC addresses broke detection of the naming convention
> because it gave network devices no random MAC before bind()
> was called. This means that the check for the local assignment bit
> was always negative as the address was zeroed from allocation,
> instead of from overwriting the MAC with a unique hardware address.
> 
> The correct check for whether bind() has altered the MAC is
> done with is_zero_ether_addr
> 
> [...]

Here is the summary with links:
  - [net] net: usb: usbnet: fix name regression
    https://git.kernel.org/netdev/net/c/8a7d12d674ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



