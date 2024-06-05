Return-Path: <netdev+bounces-100897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1CB8FC7D0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13505281E68
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716419047A;
	Wed,  5 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdolMbhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0F190078;
	Wed,  5 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579830; cv=none; b=m8ddJdwtIjP74EN5pqSK8zQZqNj5LA5JkwzVxr5G3QPy6iE3dAp/bCeFKuuCUN4/qezALGc/Mo8eKAkqkRGQi55csX1L+BpyEF8r8TMW9r3nV3A7tDBjwM8sbFFgm3tow2b5I4U4ir+Fn9tovi2gSbtktcF56b2N9+n9Riinim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579830; c=relaxed/simple;
	bh=omvsGsm3VpH9I17E4mg2XxTtOxQUZz1UHTdriaN1Co8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OPWOtSa+Ini35aTtoRMfWCEENb0YDOfVkPqMyUXbYtWLV7hPTRMhsIJzWyP0q3xf5Ifs30FG3bqS0e9I9fmsH+T2HcaHP+TD/RDYc/As0sbt/PDuTais2395AqGQ4E9F/3Dk1DSQJD7Am28zqocI+qUGjIPmUZ4jMvFv4FgFUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdolMbhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09B90C4AF08;
	Wed,  5 Jun 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579830;
	bh=omvsGsm3VpH9I17E4mg2XxTtOxQUZz1UHTdriaN1Co8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdolMbhguQ9T19A+eueofKuufSDjOp+f9t3ODFi/1lk9/+JyEKz5O72HIYVxrqBSK
	 Q2ABouDwiXW25Fw+2DF00yVElgvohdN+F6BIQE/6/+iumPWt2NnYjXi9/Ab5FbZY4R
	 /C7fO0BSgDxlgvQPu2OPOwdLncaD33mvGS3CrhR6JOw7cgDGYWjKUe1QonfHDoZcvl
	 vIBU3zxSwXTyRkOn2AOzo3INOlDd4tA25egSprPJhRNq5wAGZarCOudx2T5MpiccSJ
	 YQM9EkljuNRsFCd52NFpR0ZdmmIJ5owDeJf984vLGqhjpcTPlO3aFB6HoavGSVnaaw
	 6V4gUJFYOnxFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7CB4D3E99A;
	Wed,  5 Jun 2024 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3 1/2] net: phy: aquantia: move priv and hw stat to
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757982994.5772.18334468085942264665.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:30:29 +0000
References: <20240531233505.24903-1-ansuelsmth@gmail.com>
In-Reply-To: <20240531233505.24903-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robimarko@gmail.com, daniel@makrotopia.org, rmk+kernel@armlinux.org.uk,
 frut3k7@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jun 2024 01:35:02 +0200 you wrote:
> In preparation for LEDs support, move priv and hw stat to header to
> reference priv struct also in other .c outside aquantia.main
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Out of RFC
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: aquantia: move priv and hw stat to header
    https://git.kernel.org/netdev/net-next/c/c11d5dbbe73f
  - [net-next,v3,2/2] net: phy: aquantia: add support for PHY LEDs
    https://git.kernel.org/netdev/net-next/c/61578f679378

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



