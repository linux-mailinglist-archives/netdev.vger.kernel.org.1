Return-Path: <netdev+bounces-213650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9BB26195
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0FF5C369C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628B2F0C5D;
	Thu, 14 Aug 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZvcr26D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B92153C6
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165004; cv=none; b=BlGa16NhUpj7pThfq8U5jCIQ8IEWVmD/FgSfbQnORAopk+pVEs2FMVy2CjFqvwORPYpIjhHOmxjj9HCN0zr9MCV3DO2NLK/pKn+pZE5DpP8LqHAenFe31TLpqbYl15f1zpT9+nmDVmic6bAwVozUC/qx0FS6JAtsXswkNEM0LBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165004; c=relaxed/simple;
	bh=IXXcC06CoPryfx6dVb9iCIc0iKqZGI/HAbGoVLpF1P8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m30w+g7lXPLUfhI2XnPNh8dhJNZVYZZcWDoqBaxtHF6K0CD5i6a+81rKyoCQM6A8gRkKZN5ITRlHLfJZoB63LV2zcAfjTcYhXdTHnii1pO1CYxw1iWsK49770dQJJSuId0bfarA9STN7GSPJ/Hjh7Xg7dFlv4p75n5z6/oGV4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZvcr26D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6C0C4CEED;
	Thu, 14 Aug 2025 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755165003;
	bh=IXXcC06CoPryfx6dVb9iCIc0iKqZGI/HAbGoVLpF1P8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZvcr26Dbz5fIsmharbz1bGLk+FvUx/ebEbpILSSStMu9vope+C8zAyz448GJtUxD
	 38pw4bpAZ6h6xdzWrDvfCq+t83I+s9yj3ABHLj6hFE1eFNgZuB+YE9Vtdx/D68y0qF
	 raiB6N0HRVWI4DWtoRcWYpcbLWENzDBnpGEbnXDnWc5Hk6eQHdHMtlABeVk/A4b64O
	 g1ylSeDa7btvxD5/PdgPjOuw2BliPT+UhIHPKcCzhJJwdkM/gJi/KqNxaVCQr4k8YQ
	 MjD9vRX98vQTz46qgufeGl2t/v1YjkI7gTTYiLtPLm1653SspvLxMRxqjCRKUroyVX
	 VqJoo+1yqQ3Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE639D0C3B;
	Thu, 14 Aug 2025 09:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] net: ethtool: support including Flow
 Label in
 the flow hash for RSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175516501499.217992.12779266892846322057.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 09:50:14 +0000
References: <20250811234212.580748-1-kuba@kernel.org>
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
 ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Aug 2025 16:42:08 -0700 you wrote:
> Add support for using IPv6 Flow Label in Rx hash computation
> and therefore RSS queue selection.
> 
> v4:
>  - adjust the 2 tuple / 4 tuple condition in bnxt
> v3: https://lore.kernel.org/20250724015101.186608-1-kuba@kernel.org
>  - change the bnxt driver, bits are now exclusive
>  - check for RPS/RFS in the test
> v2:  https://lore.kernel.org/20250722014915.3365370-1-kuba@kernel.org
> RFC: https://lore.kernel.org/20250609173442.1745856-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: ethtool: support including Flow Label in the flow hash for RSS
    https://git.kernel.org/netdev/net-next/c/f22cc6f766f8
  - [net-next,v4,2/4] eth: fbnic: support RSS on IPv6 Flow Label
    https://git.kernel.org/netdev/net-next/c/0afbfdc0f64a
  - [net-next,v4,3/4] eth: bnxt: support RSS on IPv6 Flow Label
    https://git.kernel.org/netdev/net-next/c/46c0faa46378
  - [net-next,v4,4/4] selftests: drv-net: add test for RSS on flow label
    https://git.kernel.org/netdev/net-next/c/26dbe030ff08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



