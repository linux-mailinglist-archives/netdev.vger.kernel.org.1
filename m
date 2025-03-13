Return-Path: <netdev+bounces-174470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF5A5EE67
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE23B8640
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E451262D08;
	Thu, 13 Mar 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+9tQIfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59526281A;
	Thu, 13 Mar 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855798; cv=none; b=PiBjl6dtaqfFyZ4slAFfbcb8YouApku61gNLKKLvK+r6pXPsmKkowtpS9JirL+LQZ4iYDdXK9A5N0QHm6xMhDRmO4gujkabmtiTkZPtrQJAo5YbtwShKjTgPovVWeTseMGkjwSG73IfesxsjvUmL3b7C6gkJIQ1htASQXz92TnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855798; c=relaxed/simple;
	bh=Z9bhnmQuVTK3KlaOUmQ71atR3CCNcpznsgNzTr7cStk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCSCD66Cboxv+HmDYY3XFec5gjKhKnPxcgj8GD6E5sXF3MI+Sq4ECHr9Sc96rd5npcuXHMkknxn+tJEjhcj9j5HdMmZqVEwcLREX8JfcKyq9vsDjd3vNu7XDBysAWQwdZwXE6gFTFyMl6PCJRPMWY+HvoqGqLnT0bRCM+P67j8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+9tQIfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92595C4CEDD;
	Thu, 13 Mar 2025 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741855797;
	bh=Z9bhnmQuVTK3KlaOUmQ71atR3CCNcpznsgNzTr7cStk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G+9tQIfjeJErLON2J/nToFA2RBUmgwbQxm+0CYZjQjXaYAz1xuuwv0oBNxKwzXQjz
	 cEKVukEuVIWDw8azuwTDidseHqEU/I4c5hbrK0bxqYIwwFg8ZRBHeQyUz8BB590FMA
	 99O3TeIzuMcZ5c5gj0A9iCgI/1eIupk4OvlsLChq5RkBZT/8wqGcT9CpmLKYVbNVV7
	 b9cOTqT7gcayjn03OseokgQivAx8Y6ZqSpaw/e1e93HjqEiS+cJ/fI39LoprugcUM8
	 a0F5g1CSpOiX+nhCdwjlGKs5yA/BIfY/ePEaUu/hd8vi2WrU1WNvYJvpuwW5fozQ4M
	 3CE1CdBnudnwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8D3806651;
	Thu, 13 Mar 2025 08:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns3: use string choices helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185583203.1420926.338411681169004091.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 08:50:32 +0000
References: <20250307113733.819448-1-shaojijie@huawei.com>
In-Reply-To: <20250307113733.819448-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 7 Mar 2025 19:37:33 +0800 you wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Use string choices helper for better readability.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: hns3: use string choices helper
    https://git.kernel.org/netdev/net-next/c/9e3285040514

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



