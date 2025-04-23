Return-Path: <netdev+bounces-184941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA63A97C1C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A511B61591
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6525D901;
	Wed, 23 Apr 2025 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffX3Zme2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79E25D8F5
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371793; cv=none; b=NvtH5kKMHIOHWvDMHZ9WKQAs6wvXMnMLFyFor/T/n1ZtL2vmuNQI0ktuQlNe4i1jjJFFXdTmMBhmMOA8sQGg2fKukoHjJDIPHNjzlJ1tpJkmdlv+wLnc65fegF03dMYLrjiQyM7KjgmWsG/o7LqSGIT5p46kP2mbwYdIFcWVe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371793; c=relaxed/simple;
	bh=404nH2hiUbjJYrdsv6fE+yIVGshf+op5JOKelrp+aTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AkQ23yLhcctYEm387Wc2bBrmhNY19ynYIOyJvB1E/vO563785DjNOxwjJsRS49G+lTY57TrqQFh2JUTytclDF6iU/olFY9zcxYjRmiI6PFeSlK5fcbElf/zPppGZcGArMOu1Cb/15yJatyUJZa2ZI7XrXc4xsnJz57Y38s3VG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffX3Zme2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B742C4CEEF;
	Wed, 23 Apr 2025 01:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745371792;
	bh=404nH2hiUbjJYrdsv6fE+yIVGshf+op5JOKelrp+aTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffX3Zme23MKcr/zBN8dxVrhuIaHs+xwc7Bk0R7R1eicAmbWIOFsZ+87SlQ2I83QOT
	 lnI6jbGwARCxbMhmCkR6Ho8WwIOMd2S7FIYHUP+W16lWHbdZXI4XjIfSBTjw0z2XCE
	 sDMoxhB91jvJJOgP/llJ6kveSNJVmP99cYSZAp+Yq0/oy+WjQL4qW222/rfPz3Pgg8
	 fKSE+nYm6co/M1NJ6jEhvZsLIDuD6xMm/Zx2BpDI0WaJC4MJi4gu4zDGH1jpwhxQ8S
	 NfE2Hr05lmSvqeoxHMZTW7sHFbx74FT4BBzgfMIoFcsfQtbT0lTf+Nxf58dDAjSNpU
	 Gw3Fj4ZJD+UyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C79380CEF4;
	Wed, 23 Apr 2025 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: mac_link_(up|down)() clarifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537183074.2107432.17359160335159032493.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 01:30:30 +0000
References: <E1u5Ah5-001GO1-7E@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u5Ah5-001GO1-7E@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexander.duyck@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 22:53:19 +0100 you wrote:
> As a result of an email from the fbnic author, I reviewed the phylink
> documentation, and I have decided to clarify the wording in the
> mac_link_(up|down)() kernel documentation as this was written from the
> point of view of mvneta/mvpp2 and is misleading.
> 
> The documentation talks about forcing the link - indeed, this is what
> is done in the mvneta and mvpp2 drivers but not at the physical layer
> but the MACs idea, which has the effect of only allowing or stopping
> packet flow at the MAC. This "link" needs to be controlled when using
> a PHY or fixed link to start or stop packet flow at the MAC. However,
> as the MAC and PCS are tightly integrated, if the MACs idea of the
> link is forced down, it has the side effect that there is no way to
> determine that the media link has come up - in this mode, the MAC must
> be allowed to follow its built-in PCS so we can read the link state.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: mac_link_(up|down)() clarifications
    https://git.kernel.org/netdev/net/c/ce6815585d46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



