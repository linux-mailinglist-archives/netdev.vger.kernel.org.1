Return-Path: <netdev+bounces-213530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1EB2585A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C50D17579A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D711185;
	Thu, 14 Aug 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFt6KRjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A42FF649;
	Thu, 14 Aug 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131395; cv=none; b=lCS9/l9His2zJoP1HaxvXyRZdf4oECyOdjrTOPju2MooVj7p5Qc56KKuPPqY+xJP+vm3w21ykdnaqH1a04cRBfiTXDnhDAEktnGGoRqiyv9s/s4rDGESmg921m9AerK9dfjdoSs5byZZ8AMveXZq6TK9rUsmaAy8L7x/eLp2tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131395; c=relaxed/simple;
	bh=9t/k6hD3q7W6h5qT3pu5917Ndvu3p1x1fe+HWdTh4ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZXGXtDz2/TN4pgiAY7xF+Y3I+zKowuZa9k600MASXB2H5TbiYW9ybHZgOj9237R3sSWh0EK35hK/OOXnp3YF8lF5QUf4/sHtgNBhyLcFNFtueZG5f+tLwvR9ds7PQmVG2Pqn10VkLLd7K4V8E/x9e2eXuCZYwfj61ZcvP14Szk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFt6KRjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8271C4CEEB;
	Thu, 14 Aug 2025 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131395;
	bh=9t/k6hD3q7W6h5qT3pu5917Ndvu3p1x1fe+HWdTh4ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AFt6KRjCVmZsoCtjIEX0dpUtE5XvqYtoJ8gNAjQz1pUdw8CsgUeFRctf6ic7ufVlp
	 dTJxJ50A3PCu/Yxol81WL0ppaVC6Q945K2QcLYKddDD65lysoq3iHuB4mpqB+yenDL
	 pf4Zm1950uWIYkOame/5I+hwW2ZsZ8ApfUTksK8gmLCdLQ6aFfONP0NOS58ARqMA6/
	 UgtzhBERY7Mq+Ehzah/Wq2DNSL0RFYFYGs4g9EsJsd0HiD4EQBQhgxO6XwWJ+/lOW+
	 NgTiACFfk/8BWhMaTxnVp9/n+vO7goiagEjSkAngSJXITp5So1vxnBmJWG1bhy3vjE
	 G+t7QKYBmyJaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7102639D0C37;
	Thu, 14 Aug 2025 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513140725.3830230.6064788817690151758.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:30:07 +0000
References: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
In-Reply-To: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
To: =?utf-8?q?Miguel_Garc=C3=ADa_Rom=C3=A1n_=3Cmiguelgarciaroman8=40gmail=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 10:22:44 +0200 you wrote:
> Replace the strcpy() calls that copy the device name into ifr->ifr_name
> with strscpy() to avoid potential overflows and guarantee NULL termination.
> 
> Destination is ifr->ifr_name (size IFNAMSIZ).
> 
> Tested in QEMU (BusyBox rootfs):
>  - Created TUN devices via TUNSETIFF helper
>  - Set addresses and brought links up
>  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tun: replace strcpy with strscpy for ifr_name
    https://git.kernel.org/netdev/net-next/c/a57384110dc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



