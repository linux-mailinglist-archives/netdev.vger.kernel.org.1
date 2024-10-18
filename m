Return-Path: <netdev+bounces-136991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8239A3E30
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF81C23601
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D42EAD2;
	Fri, 18 Oct 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgQsYR30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992120E302;
	Fri, 18 Oct 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254022; cv=none; b=IlKutCDWcAdd11RhYnq4yxLZkUz8v+HAAELcDHtrZ3EDu3QtPRxXxzmjPpucDTPbKYEzLG8n4Nu7iz8Q/2oCiZbADstmuhvAjApnpgqeR/P6EbL4P1Ryvy/5d0ZJ30D+oFHi2kg9kOahLzhcdeWb2m9aGZstIgKi/mWuodVnxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254022; c=relaxed/simple;
	bh=4n/QueacIS3wCm6O965ciM0zDr6nIslOHLdMVslm/cE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFQuXmDoOnPiZdQqM3OpoYdCS4D10Mg91cv9KxaLyN/BmoxR/yBeHqYvMh+vJ0T3+Dm3TgwsMPE+bcjpSvx4iIDBKDRFa3+DOdGTHARI2K+j9a4rSHPg/Y/RxMuqFETVCjSCHtM+t3LlZIuC+V6jxW1V6t3aREMnIPMt0r9VHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgQsYR30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9B3C4CEC3;
	Fri, 18 Oct 2024 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729254022;
	bh=4n/QueacIS3wCm6O965ciM0zDr6nIslOHLdMVslm/cE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FgQsYR30ioJoFPWp7eg0sznAmUHouqzZCZjoK3CVVuvn1cTm9IiNn6rCbtenmbmeT
	 yEhV+Atdk+Iv5rSu/hBjAb1Dp8rh/79pEqaQHQ1xOOrAJhTmmBV4a2hFjuxxRbRjcI
	 UAXkHxSBjjbDw4kIu8R5EFIgygKqM5Ea614R1amMf0v9LhdoDJYaeCyNJeUeKHFyuf
	 hWUq1fEqDpDfACgSU1D0mAWyq8Jq3olH5RLM7s4VUSfh4sREXRa9IA+kwwJXlo8r2M
	 uP9JcjzWdto25opQXpU45VIxGHWaMtZV+DZ0TPKbONrLe+5UMdfVvZjbFA377Dunw1
	 IsqSmisUenVvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB51B3805CC0;
	Fri, 18 Oct 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vxlan: replace VXLAN_INVALID_HDR with
 VNI_NOT_FOUND
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172925402777.3100100.11318902877264873310.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 12:20:27 +0000
References: <20241015082830.29565-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241015082830.29565-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dongml2@chinatelecom.cn,
 gnault@redhat.com, aleksander.lobakin@intel.com, leitao@debian.org,
 b.galvani@gmail.com, alce@lafranque.net, kalesh-anakkur.purayil@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Oct 2024 16:28:30 +0800 you wrote:
> Replace the drop reason "SKB_DROP_REASON_VXLAN_INVALID_HDR" with
> "SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND" in encap_bypass_if_local(), as the
> latter is more accurate.
> 
> Fixes: 790961d88b0e ("net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] net: vxlan: replace VXLAN_INVALID_HDR with VNI_NOT_FOUND
    https://git.kernel.org/netdev/net-next/c/eb4f99c56ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



