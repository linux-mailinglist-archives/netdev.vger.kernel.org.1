Return-Path: <netdev+bounces-161307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952AA20981
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB80418865C9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFE19F111;
	Tue, 28 Jan 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oij6JUsR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50919DFA5;
	Tue, 28 Jan 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063208; cv=none; b=KzqghjkBJC5hmCTlswd9+vju7CaJpglOrOx8JV6gwIMkMzGDs8pX/E175xl2XhGd8H9hjSh5KFRmTdOrSHVYDGW0nxtToePE5yF5MUN3dDrckRtavQLDaeixBtCRIqZ5DX+IcDGONNeUEWRgiX+cp2wqu8RVCocX5pXHqUh+Ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063208; c=relaxed/simple;
	bh=+wN+xyHCWm7Mr05FKtb0eiMkKTeqnJP0gRwFVC0K7qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V6/vLGx+NFDjbFQZvYfYxMD3Gq/GQdwlwaaSUrCB6ZTHC51SPZ2eH93r/OrV+vmVqYlhN7FJuJBDhGTQF49Pw/345s4elBza5znydZXBZ0T+o72dHeZCmY0BIY5/3BuHL7gGntUSWc9Q6Pcae7vvPi3eXErZE8o7iqEGYKYaUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oij6JUsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EACC4CED3;
	Tue, 28 Jan 2025 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738063207;
	bh=+wN+xyHCWm7Mr05FKtb0eiMkKTeqnJP0gRwFVC0K7qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oij6JUsRuxaWsHWMkScOZbhYm5JGcw3P4mNOQrn7EAfei6+jXDh6IaeXwF/Rrxujg
	 123d4m7t7e4qr8kDi/jmPGPerSoQ2iZ22QgEFfCXIn7gPXIYLQE8h5ayGFzAucFJPI
	 1unn5TOU/sCHd3v7FPGC7EAnAxVnJDP6rWpVpYbSIwgTBxLMq233TdJKJEGPfC215s
	 etM7HHj8+mV/R3yRVnbxIEvlVmZSZWc0yU7a5p1R5PSShOJxerMTHvZdLwP4Hkjumx
	 WcRT9vnwXZcmhHgMs+mYVWlmYQkDUzpj9J3JRv23DukZR/SBLDQSoUxaieK5Epi30l
	 k0oUzJGf+mnNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE521380AA66;
	Tue, 28 Jan 2025 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/7] usbnet: ipheth: prevent OoB reads of NDP16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806323350.3759067.5078692360425955195.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 11:20:33 +0000
References: <20250125235409.3106594-1-forst@pen.gy>
In-Reply-To: <20250125235409.3106594-1-forst@pen.gy>
To: Foster Snowhill <forst@pen.gy>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gvalkov@gmail.com, horms@kernel.org, oneukum@suse.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Jan 2025 00:54:02 +0100 you wrote:
> iOS devices support two types of tethering over USB: regular, where the
> internet connection is shared from the phone to the attached computer,
> and reverse, where the internet connection is shared from the attached
> computer to the phone.
> 
> The `ipheth` driver is responsible for regular tethering only. With this
> tethering type, iOS devices support two encapsulation modes on RX:
> legacy and NCM.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/7] usbnet: ipheth: fix possible overflow in DPE length check
    https://git.kernel.org/netdev/net/c/c219427ed296
  - [net,v5,2/7] usbnet: ipheth: check that DPE points past NCM header
    https://git.kernel.org/netdev/net/c/429fa68b58ce
  - [net,v5,3/7] usbnet: ipheth: use static NDP16 location in URB
    https://git.kernel.org/netdev/net/c/86586dcb75cb
  - [net,v5,4/7] usbnet: ipheth: refactor NCM datagram loop
    https://git.kernel.org/netdev/net/c/2a9a196429e9
  - [net,v5,5/7] usbnet: ipheth: break up NCM header size computation
    https://git.kernel.org/netdev/net/c/efcbc678a14b
  - [net,v5,6/7] usbnet: ipheth: fix DPE OoB read
    https://git.kernel.org/netdev/net/c/ee591f2b2817
  - [net,v5,7/7] usbnet: ipheth: document scope of NCM implementation
    https://git.kernel.org/netdev/net/c/be154b598fa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



