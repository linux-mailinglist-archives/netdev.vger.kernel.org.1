Return-Path: <netdev+bounces-140045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D89B51D6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103E1F22873
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17D205E0B;
	Tue, 29 Oct 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSLdNw2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C59200C8B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226632; cv=none; b=V9MaqFEZWjt13z46gK3n5rFCphCPa9bvkNqLhMBEPAxsTzfZjUtWMEk9cR9QOv50CnACA/wkU+ZnlR3gUN+89n9wqhehFAZNoReYF3B+8RujTxgx/l20hwprLlivufxiTVhSviJQbf0xrsB7VSHV9aUkhOqzlOkdXLajhMZOVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226632; c=relaxed/simple;
	bh=sBBjvpypSGw/BGqus8Ppq7c2D2ickZx5FX1Hgq8s5Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VidzF3gebsmNuTfB6/UKIX9JzANm5cvJyHD9uBYKQpVWPMibnTur/4rBn17vt2H0Vhdmc9M8M6+xchXubRBMayrk53qwl8eIfonZYUqe+pqm7jf9FqfgNXmagMTlR/HPVSXJV9EJJTgMCyq3HHzFueKrVQzGgSV8SiIVf/BrHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSLdNw2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10CAC4CECD;
	Tue, 29 Oct 2024 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226631;
	bh=sBBjvpypSGw/BGqus8Ppq7c2D2ickZx5FX1Hgq8s5Zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iSLdNw2rvT3/PWpwv4/Pi3iuIJ9CWNwGpLrvytdzf14jySpnRvqIyorzMvNDDX/7v
	 I8YrSHFY7fdMPqKf1h+EY33/XZ93chYn4ZZ5/Fy4bqcYnwRMgyWw/Utft6AMudh2NW
	 +Y9iaOhwfvgZ9m0oXQi6X0icYddCcQHpIPE/mRKEokQPoqjF5WCsYAxyW+VDn+SP88
	 mQ085ZT/Pd8Zg9nh27n9STDjWCmaC529MD1aOOUALPBHVAFA6zR/T7ur5T3f3t8hz0
	 jyH9lqlMUSs2juL2i36sck9RqExvJ6fc2dj/m3pYJ79WnwVIeb8TpidqPYY6/IAXrU
	 6oWMtlpEfDTaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE641380AC08;
	Tue, 29 Oct 2024 18:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gtp: allow -1 to be specified as file description from
 userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022663924.781637.8597993399199418689.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:30:39 +0000
References: <20241022144825.66740-1-pablo@netfilter.org>
In-Reply-To: <20241022144825.66740-1-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, fw@strlen.de, pespin@sysmocom.de,
 laforge@gnumonks.org, osmocom-net-gprs@lists.osmocom.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 16:48:25 +0200 you wrote:
> Existing user space applications maintained by the Osmocom project are
> breaking since a recent fix that addresses incorrect error checking.
> 
> Restore operation for user space programs that specify -1 as file
> descriptor to skip GTPv0 or GTPv1 only sockets.
> 
> Fixes: defd8b3c37b0 ("gtp: fix a potential NULL pointer dereference")
> Reported-by: Pau Espin Pedrol <pespin@sysmocom.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> [...]

Here is the summary with links:
  - [net] gtp: allow -1 to be specified as file description from userspace
    https://git.kernel.org/netdev/net/c/7515e37bce5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



