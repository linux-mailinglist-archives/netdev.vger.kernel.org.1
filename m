Return-Path: <netdev+bounces-242148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D26C8CBD9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 964A44E36C9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A692C3247;
	Thu, 27 Nov 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP9i9IeV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF952BF006
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213451; cv=none; b=nHtzMNlBfIRDEdwYd0/m18+GFUJ7Y/ZoOKXBOsezkXmrVwE+RnVqXKUYFTLwtYDYyYjYUVisk7a2u6efA3XCCNGjCyB8bPNrie9AMRXkJUDeOFdLHvSwuxXGO+t3Ek/eFmTTcONXUJ9R5PL/iX4yCQDjsigW0SVBu3S7qrCQrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213451; c=relaxed/simple;
	bh=VNVxWQL4TcU8bATnyrDImk7no2aZnlZAXA5dm/JLR+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G0nQoD6a9V0cuxXH2O2DhxtW4bVoFv8wEKYCY37GCaAruZoEdMqUKrdvbrZbnIlM+aOL39mBwMT2UHKVGGqpZVTQF8y8ohSdZo8FiK4TpIfhPtANkW+FJg7H5/Vvh3B27eKH0yQqC/Hs6PCyCT42b3TnxMMap4f6J0GivCNXNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP9i9IeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8996BC4CEF7;
	Thu, 27 Nov 2025 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213451;
	bh=VNVxWQL4TcU8bATnyrDImk7no2aZnlZAXA5dm/JLR+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RP9i9IeVcv0tpGOnYSOhuzZIFCJyncPdR/BMNbFvXVxlQl+ZyqNlEZiSlEDYaa9IA
	 vXubgvrpzkGRjH1iLAEY40cRRcY6pkcDqRMYzHZHk6B28oCO2E8WDsvCLbtm7qoZOB
	 3Rbd4NJDUr49UY/Pf+lL1bfeuNNQ+DJnfbHVmt+i/iXkO5QoCu92C1wlMeLqtACIgv
	 WeLMg64Xc86sNzIEgd9N6DhaW3THUGCwH7IgJIXw+jmQnrc47jpgOkzZlqPskgEd+6
	 Sgrk+0gaoLim5kTQ0P4SqD40MtY3Nnx7DHcolKivlHatERKlugMKeejpqZ9ryI3zTJ
	 hio27vcDqhuxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB0380CEF8;
	Thu, 27 Nov 2025 03:16:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv7 net-next] tools: ynl: add YNL test framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421341299.1916399.13230156100149446580.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:52 +0000
References: <20251124022055.33389-1-liuhangbin@gmail.com>
In-Reply-To: <20251124022055.33389-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jstancek@redhat.com, matttbe@kernel.org, ast@fiberby.net,
 sdf@fomichev.me, idosch@nvidia.com, gnault@redhat.com, sd@queasysnail.net,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 02:20:55 +0000 you wrote:
> Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> ethtool functionality. The framework includes:
> 
> 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
>    operations
> 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
>    feature gettings
> 
> [...]

Here is the summary with links:
  - [PATCHv7,net-next] tools: ynl: add YNL test framework
    https://git.kernel.org/netdev/net-next/c/308b7dee3e5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



