Return-Path: <netdev+bounces-145169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0529CD5F2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818C21F221F8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520B15FD13;
	Fri, 15 Nov 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP1L7zSp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6715CD49;
	Fri, 15 Nov 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642021; cv=none; b=Mvry0rqcE1v1anO7CDcegj6e6ofRufjHkb0K+6UVhResO/kaQ7dmgdbvRAXua9OUUr7xIKrB/uQjljrCAsxrku/aQ1EojECu9JuzfllUXLyzIKHHWvXe86WEHcDN/mCzUDubJNMnqatnAmn9gvPFig9pUjNSVeZmGrKmJ9R0yDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642021; c=relaxed/simple;
	bh=ElqMo7Uyg7vjfrP+p+Vu5wcMB897kki8e7dpMrhh2LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mgpuPbiXL63PGG5Oq3W+YSZlCyN3FnodgdRrcjZmADLQNw42j1JI5yOBvcQkR6Lyoineb1Ks+hPwxagRmyWO4Xs87GR7OXDn0/NHH6KqAJKs8iAUyWHjvp8VVL7yBIjfwNLP4oR2kum+PlkcNDjzRqgKiwlMqjnI7LugNnw1hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP1L7zSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0B8C4CECF;
	Fri, 15 Nov 2024 03:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731642021;
	bh=ElqMo7Uyg7vjfrP+p+Vu5wcMB897kki8e7dpMrhh2LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fP1L7zSpyogcByfaCHrlELW1alKUAL41b2RP1YShHRlNC0ZM5a8TD5p6zCIjk0hvA
	 izS2aXoPWvzX/SbDoS1oNnfMXVaIbnH4M6SDa59yTQY4ibh1yPrmj/U5wx3BWR61TZ
	 kbTdlcTMMiUIh3dcXAC+qkvcEf9P03/TELXI6M6Zq6LMOE3dHu2BurqtTUgJ9/QUEl
	 YK/Bt+0qh5jSwJdp3/+vwau8Kb/qe8linHEH+7An7Ctv3xlQb9JC6mQS6Xy9r4kKCz
	 7j2rDwSKLTN8/tJFxNGD+Pud/+JFW07TZhPbT1Jq6mbdThsyvXOz22kv1fl03GFm1X
	 mYLca+rG+93oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2BD3809A80;
	Fri, 15 Nov 2024 03:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: sff,sfp: Fix "interrupts" property
 typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164203148.2141101.13732070093827071857.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:40:31 +0000
References: <20241113225825.1785588-2-robh@kernel.org>
In-Reply-To: <20241113225825.1785588-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 16:58:25 -0600 you wrote:
> The example has "interrupt" property which is not a defined property. It
> should be "interrupts" instead. "interrupts" also should not contain a
> phandle.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/sff,sfp.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: sff,sfp: Fix "interrupts" property typo
    https://git.kernel.org/netdev/net-next/c/b52a8deea530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



