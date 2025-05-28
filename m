Return-Path: <netdev+bounces-193796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A4AC5EB9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856DD4A4F49
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841801E5B7B;
	Wed, 28 May 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv4MTw8C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D418C004;
	Wed, 28 May 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395216; cv=none; b=j1GmOUlijIBvHj55O0cs3TWFi3nTAiK6y0i1aReFsXewvTg8f9Ctx7vM2rywfEbvZfXeyt2Jazo2+MLsaufZQpveSILFqazuCyQ1mDzfNeXO2Jd5oUoyVUGXIjeKBTmFpaDEiDtvdtZFOI7tateGqCtO2mJZfGYhDR0pVdXYAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395216; c=relaxed/simple;
	bh=W2+dbvW7t8dJh1KZx8OEQK9FItnMc5/NHMP8AiZOl6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hs+LMZowaJKUpYGL7SIs89VESnutZIgCQzrynFrMHGn5a2HLK972cP3MCdrRYsuklyix6SeCWT9dJzTABjGsrO0QAVyokf8mQgU4mKHKrS8PmxvldxUNWib5+/9Saew7ri2Ea6uIDvCKy1TeZJ2TJ9nWQpQV4V7YU5BE6rDAc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv4MTw8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7EEC4CEE9;
	Wed, 28 May 2025 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395214;
	bh=W2+dbvW7t8dJh1KZx8OEQK9FItnMc5/NHMP8AiZOl6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qv4MTw8CVhkMsrldM9hlGSuybugf00H5MtDWpvTxfMeMOIDhnr2IBqIvpjxEm039N
	 pMB7hyZvI3RZjnGSZJVVeukVS0YdCqn3UeyE2+0YYw01tVYjandhweqDfS+i2o3Fgq
	 oAuXU8FbDwo4uGy55J3JnHQjdg1ZAmCZF4sI4viEOv1wajDod/tgjseG3Im12angc3
	 SOjXWUcvYlcomgt+4+DH6Rk+LauuQNZMgnhjUwZGNlANO/zidY1/kx7ikpJPpzXkro
	 qpGI4TCtMnS94tQYvLk/lmyrfzJJuWj2IFj0Z8JsEKuPrUf90ci6V8kdDeYgYWgbpu
	 TmUmGeAgjSh9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0B380AAE2;
	Wed, 28 May 2025 01:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: core_thermal: Constify struct
 thermal_zone_device_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839524874.1849945.12481137182393218605.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:48 +0000
References: <4516676973f5adc1cdb76db1691c0f98b6fa6614.1748164348.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4516676973f5adc1cdb76db1691c0f98b6fa6614.1748164348.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 May 2025 11:13:17 +0200 you wrote:
> 'struct thermal_zone_device_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> While at it, also constify a struct thermal_zone_params.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: core_thermal: Constify struct thermal_zone_device_ops
    https://git.kernel.org/netdev/net-next/c/82fb5a369b8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



