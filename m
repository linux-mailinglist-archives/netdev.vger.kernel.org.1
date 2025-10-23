Return-Path: <netdev+bounces-232132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D4C01AE7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35A83BA5BE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EEF200BA1;
	Thu, 23 Oct 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM1b0aLv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5031F8724
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228030; cv=none; b=BRsYWJA3gu4lF2Eplsq4Lu5Z+qGJ2CmnulRP5eV7tCByLyMis4oc90UEYIlCiQEFn9pVsby2foqDJEZrttPKhUDFZ5g64ogubywEGGhjDGCE3L2FkgWsWAilDpRO66H5ORNIBKALcMcSh86ql+h+hCekWtBTTEngzLTarEccOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228030; c=relaxed/simple;
	bh=tUKG8hAVnKXi+fBk1Uwhd4EsUZVgTZa3kFJyy4dxBik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KyeHlz/Oq3H/JGn126heTPqQePtLN8ezw7q5h9JELLmTy1Reoky4ZW8Tm4vUtYCG0sUkoA3NjNoQfXDzIR08s/Swz0AHZHvVX2EAZgj7F6VVRZ0NprAocAm62NO8B9JMv/O15FDb0GQR2jWh9Ibtov13ZKQcf4qxqdIDQfW1DhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM1b0aLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC5C4CEE7;
	Thu, 23 Oct 2025 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228030;
	bh=tUKG8hAVnKXi+fBk1Uwhd4EsUZVgTZa3kFJyy4dxBik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oM1b0aLv1Cb+pbSxvVO+kpAb3Uhhc04Ar4SD9+jTpsvO0FofdrfPJF+9JO1KRoKUH
	 /jQZHiN6g7cPuXTLDGDCwxoTmHz0b3kPT6aDvJWmokf4hYBJF1PJuBPm9xl5uieMCd
	 gJBuUqn7Ci3FENwNYbwGHcQ05ybzNSEDt3Hs0b5wVigDGDFHLdGLUTf0HPEJGjwSxM
	 5ygO4DO3X1jQIVOhooyYqHqmwSXnaWZN0dylg/9OnGXzt4Ruto/7ojpi5s39uNB436
	 KgJ40d2uDwsRgydTymOGYUMvx5RV1GJeGYEVvn8yTDTnq3gGZgEjjs5YxSOYuvJ3Ul
	 ypKEdaUkBynoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0283809A96;
	Thu, 23 Oct 2025 14:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] fix poll behaviour for TCP-based tunnel
 protocols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176122801073.3092461.10668741219735517723.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 14:00:10 +0000
References: <20251021100942.195010-1-ralf@mandelbit.com>
In-Reply-To: <20251021100942.195010-1-ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, antonio@openvpn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Oct 2025 12:09:39 +0200 you wrote:
> Hi all,
> 
> This patch series introduces a polling function for datagram-style
> sockets that operates on custom skb queues, and updates ovpn (the
> OpenVPN data-channel offload module) and espintcp (the TCP Encapsulation
> of IKE and IPsec Packets implementation) to use it accordingly.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: datagram: introduce datagram_poll_queue for custom receive queues
    https://git.kernel.org/netdev/net/c/f6ceec6434b5
  - [net,v3,2/3] espintcp: use datagram_poll_queue for socket readiness
    https://git.kernel.org/netdev/net/c/0fc3e32c2c06
  - [net,v3,3/3] ovpn: use datagram_poll_queue for socket readiness in TCP
    https://git.kernel.org/netdev/net/c/efd729408bc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



