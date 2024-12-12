Return-Path: <netdev+bounces-151424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D99EEC02
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00118283D80
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47F21CA0C;
	Thu, 12 Dec 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1G4jnCJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB921C166;
	Thu, 12 Dec 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017417; cv=none; b=SLD5QI6nRBZYyTrbZtnGFLcjJrGNv4EtMO1w+tUhFqiwxdChX26kEa5m0rkMLiI8xG0kprWclhTiIiBKVFapbq5gKsreeL6qqrFJRRB44Dk2P0jbwBgJctvThi0njpFvGfuc2CQ5ZaQ0uHfaAeTqm2tvHmX3aDpMLEgvius1xE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017417; c=relaxed/simple;
	bh=NGwT/sP6fdeGKQ6iR9Uw1CJTnYeHzQsJrSFdTagVG44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=igXoQpXNdM9+DaigJbuSQfhJmEd/VMB6ZfBSFjWmsxwWquzgwkqln9JC0opnKe0L6TN44J8xRNUJO2bmbiRvaGmkjlDlJhEKxuyAfk6Y0Tcg7OEPEA/ivtnWMOc28FmYj1F8T+DlyTBmSP17BL9UgOI3+fTCuxGaIcp7uriX4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1G4jnCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1231AC4CECE;
	Thu, 12 Dec 2024 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017417;
	bh=NGwT/sP6fdeGKQ6iR9Uw1CJTnYeHzQsJrSFdTagVG44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1G4jnCJ8aVRftXS8THsL/gbpoht3H8LJeSz3Usi15hdpYC0NLN7TrUSUIAQuYyIF
	 hB+mNv5mg87n6xP0V6DLmwbU9e0IYVw3C0egBT0/idMJjng4K8dMjAaW7nqZFROnfQ
	 ys7fEdPdgxICWsaEUmlz6z9n4X6QcBosEE6JsJBucE8IgjH9ZwAqV8LLwiP+SrgloV
	 /eWPyKHGmhvZT8K8+2O+sOr/reFb51/KKYjFVpm37Vvm3T3U0KnewOj4pkKhpRmLKS
	 cB+hDXLk2COpzvyw+eYmuh/fuslmefSu8Jaq3L/J3M2ijvHCtZZMssNYWYeR99fG8L
	 3w3uxufAEGNCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7109E380A959;
	Thu, 12 Dec 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-12-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173401743299.2337313.1332143889147091604.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 15:30:32 +0000
References: <20241212142806.2046274-1-luiz.dentz@gmail.com>
In-Reply-To: <20241212142806.2046274-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 09:28:05 -0500 you wrote:
> The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e2e975:
> 
>   net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:08:00 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-12
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-12-12
    https://git.kernel.org/netdev/net/c/ad913dfd8bfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



