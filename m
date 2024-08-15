Return-Path: <netdev+bounces-118796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69F952CB5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C6E1C23693
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B91BE871;
	Thu, 15 Aug 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj0F8ywy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D7143899;
	Thu, 15 Aug 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717828; cv=none; b=KRQ2RRdckK+S/g4X0tK0hhhrq/qnOhPT9UtZ+fBeNvRhs1ZltWsIUjmI+NoXFv4CZrTXj8VYPVyhJuEGevAFnXhyVdWB+V434ORdf6CbEp4E4b12ScdQxk/elZMEZOZCP4lcGa+AmGkrzqbJiN92hgZ7Vyht4b6ut4BvFeT193M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717828; c=relaxed/simple;
	bh=zk1pEqi/+AjEWWQaQgJ2M37R3MrtH/xff8K5fvk8LZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfcryScwmDDouHmRrUltZcJEPi5y688cawCTR1IP1DRS/b13l28sv9QMOIwfYZkbQYEE3kZEqhPt5jiwSufrFHOr+CTmO3SkoNfim0woaEATAXQsf3YbTfXcAv8lx0kFLFCFohtsoQRX7b+6siv7+IbhFzuecokxrSyPRBfxzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj0F8ywy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB6FC4AF0D;
	Thu, 15 Aug 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723717827;
	bh=zk1pEqi/+AjEWWQaQgJ2M37R3MrtH/xff8K5fvk8LZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cj0F8ywyv0qsyU72oFi9jifg8EY5yTsvgU0DTK/qGiHanhpWp12OlvMHBy+HwzP79
	 4WjkHfdSs8MR2H26VdOg/KNxkldRF8A1f1BAHG1HdKLuYjuoyPJ3Zne5RUrRjqufB0
	 oIykaSZVxlUtVQ6iSG6tlPlba4NLregC6K3Ku9453kCgHZQy/ZFUu4b1x+5XtRx3D+
	 DZe2fw5VYPejkroswEzioDnHojggeplR8L+HKyTLVswFKR37WDAUtQlUpqiPM/9A6z
	 kcKQrGcEPCdiZzr+OG1FrEc2SACwHRtiHrnQRtygbKdaZ1rOxqyxxlT4Q/K+UmZgHv
	 vqzSaaeeZFbGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB154382327A;
	Thu, 15 Aug 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: Allow write mechanism of LPL and both LPL
 and EPL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172371782676.2814415.8948871837207182901.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 10:30:26 +0000
References: <20240812140824.3718826-1-danieller@nvidia.com>
In-Reply-To: <20240812140824.3718826-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, petrm@nvidia.com,
 linux-kernel@vger.kernel.org, vmykhaliuk@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Aug 2024 17:08:24 +0300 you wrote:
> CMIS 5.2 standard section 9.4.2 defines four types of firmware update
> supported mechanism: None, only LPL, only EPL, both LPL and EPL.
> 
> Currently, only LPL (Local Payload) type of write firmware block is
> supported. However, if the module supports both LPL and EPL the flashing
> process wrongly fails for no supporting LPL.
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: Allow write mechanism of LPL and both LPL and EPL
    https://git.kernel.org/netdev/net/c/fde25c20f518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



