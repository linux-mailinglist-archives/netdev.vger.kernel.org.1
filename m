Return-Path: <netdev+bounces-141367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825D9BA963
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0617281365
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C218198E81;
	Sun,  3 Nov 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqqTq/04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECA197521
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674231; cv=none; b=uQ8sM7pCpdaFW2NK8eDyT/7C5WiwaByavUlOwhwQTpNZmiPIs0rwdjxnBbmJ+zueQl5MMTMVQE0/xC/5CuZIZGJJknytWIH7+Z3yMq4Gpf9UuOFbhQsiPbOy0ZNt3bO4ap4xyIX4qX6sQ6KZ7+xt+GdCdHX/8TWvHcpPbo1iG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674231; c=relaxed/simple;
	bh=pOSKcDFC1qAmrlBfAnoJwQPnJbCAURA9aAKNg4qaDXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKtHt5zeBIy5wjyjINTnaMcW4s6tawUxPYQTo0bpZV04prtANcoUVvbk793yw2N7nQxLGK4v7EEiTJkItQFqoT/6IfRptuA0BhQnB/pB+eMv2KD4+utyQh08Onoqxs6ECxE3mq2OZxeCgunGwDPHmUk3tbEATnuLYsS9Z0fmj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqqTq/04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEC6C4CECD;
	Sun,  3 Nov 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730674231;
	bh=pOSKcDFC1qAmrlBfAnoJwQPnJbCAURA9aAKNg4qaDXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HqqTq/043YQKPY9Q0c2JNW4w/d50hdquZ0kQg81QnlK7dsphqtBMSmwvz8c3K8ZuX
	 rCUlfF7cFPegpkw9w3KRMY3xrV65wgTPAo/6JqWwRik/shQNhWL6QfOIYyN0tH6rYT
	 n4AxlliPk/qIdlp3EwB8KKZOgarFUJinaPFugEgba95mZ2g6kpi7H628Yb6Ct1o+GO
	 nc2l7qqFT3711stqw7FHqQVkSWwXcf/N9H5/dwmUSQcW/0WatqFh2kzEOdpfaFNzll
	 0Vq/nycftxfcwP8/gzh8oUa+trKorDWfToHa5QTklwKYptqtwuKtB8f/yOvGIJZYCQ
	 oIdUFX0YXshRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB8B38363C3;
	Sun,  3 Nov 2024 22:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vrf: Prepare vrf_process_v4_outbound() to future
 .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067423923.3271988.409261031971405732.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 22:50:39 +0000
References: <6be084229008dcfa7a4e2758befccfd2217a331e.1730294788.git.gnault@redhat.com>
In-Reply-To: <6be084229008dcfa7a4e2758befccfd2217a331e.1730294788.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 14:27:19 +0100 you wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] vrf: Prepare vrf_process_v4_outbound() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/937677f48125

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



