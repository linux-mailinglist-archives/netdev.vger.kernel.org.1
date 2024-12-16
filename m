Return-Path: <netdev+bounces-152194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DEE9F30DB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA04165FC3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD7204C2B;
	Mon, 16 Dec 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTPK4Igr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A9201253;
	Mon, 16 Dec 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353414; cv=none; b=ALhjptn/K836KCvtz/NbueBAyWB5c14zGE+w/eaaIk6yUOVUhIvYZ9oTHavoFk5D1nziZeviReeTnv8nO91s+jetvZHYt3Jb2uJps+JGKGzclbZjW4Z8Y1rzcj8DC2BBCI8FXsyM9RP0WiJnlmS8WLp7IaW1yERqRgILju00ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353414; c=relaxed/simple;
	bh=gXQavCKWulSt/Iu+B0u/gE0WYEvXCSe9B1LvGgWUj4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UDefwvnJkEDmc4OahSOuP8XMEcc2H/153DIm38aqnWValjgqi5gODIEhLsP/UisC362xKggm/qZzmQ3zDUnBiUTTBvDhz6KOSfa3mAs1t/B9Qu6qLMPB1ou8k6Qt4exQXIPFluXD110f97Xk2epglG1KjSh5fVStYqxt0vXsNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTPK4Igr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9BDC4CED0;
	Mon, 16 Dec 2024 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734353414;
	bh=gXQavCKWulSt/Iu+B0u/gE0WYEvXCSe9B1LvGgWUj4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTPK4IgrWbMv26zqxKEfCu8xOvkl7swM26qA3ohtQpr4lRFITTxRMK9RnSMKAeWQc
	 7vOO8FSh8l/jt3ucvFOwRUcsYe/cieP/c2juwc/Kt5DkmR01MWNOo6Z8AC0qwhCHTc
	 /3CCtjVF2WnEI1GHhIHYLpo+xEkM1ZRLDmdEAI9DL4fkiFnmmsMs9ZZeLW8B9YXnhI
	 Kqjmnfy4Bqy8fa7KlBj3QLxetapaNogtQkKCbT8ozHTc81xSM02Lz7t2ZmCrvgOgcM
	 ekZxjU63Nh4ljlXnINiFMJ7RG6z+V9/UpT/6neAlDuBTJ5W4ee7N6VVRwywmW7Oadv
	 cSNR2fawPWpUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6202B3806656;
	Mon, 16 Dec 2024 12:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] tls: implement key updates for TLS1.3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173435343108.197327.447831770899898017.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 12:50:31 +0000
References: <cover.1734013874.git.sd@queasysnail.net>
In-Reply-To: <cover.1734013874.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, vfedorenko@novek.ru, fkrenzel@redhat.com,
 kuba@kernel.org, kuniyu@amazon.com, apoorvko@amazon.com, borisp@nvidia.com,
 john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 gal@nvidia.com, marcel@holtmann.org, horms@kernel.org,
 Parthiban.Veerasooran@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Dec 2024 16:36:03 +0100 you wrote:
> This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
> [1]). A sender transmits a KeyUpdate message and then changes its TX
> key. The receiver should react by updating its RX key before
> processing the next message.
> 
> This patchset implements key updates by:
>  1. pausing decryption when a KeyUpdate message is received, to avoid
>     attempting to use the old key to decrypt a record encrypted with
>     the new key
>  2. returning -EKEYEXPIRED to syscalls that cannot receive the
>     KeyUpdate message, until the rekey has been performed by userspace
>  3. passing the KeyUpdate message to userspace as a control message
>  4. allowing updates of the crypto_info via the TLS_TX/TLS_RX
>     setsockopts
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] tls: block decryption when a rekey is pending
    https://git.kernel.org/netdev/net-next/c/0471b1093e3a
  - [net-next,v5,2/6] tls: implement rekey for TLS1.3
    https://git.kernel.org/netdev/net-next/c/47069594e67e
  - [net-next,v5,3/6] tls: add counters for rekey
    https://git.kernel.org/netdev/net-next/c/510128b30f2d
  - [net-next,v5,4/6] docs: tls: document TLS1.3 key updates
    https://git.kernel.org/netdev/net-next/c/5aa97a43d042
  - [net-next,v5,5/6] selftests: tls: add key_generation argument to tls_crypto_info_init
    https://git.kernel.org/netdev/net-next/c/b2e584aa3c71
  - [net-next,v5,6/6] selftests: tls: add rekey tests
    https://git.kernel.org/netdev/net-next/c/555f0edb9ff0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



