Return-Path: <netdev+bounces-270980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB/SHnZrwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:46:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE610306A85
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F0D31116AF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE93E3176;
	Tue, 24 Mar 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCrrJVqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AA3E4C65;
	Tue, 24 Mar 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348820; cv=none; b=KYHHXzjZCTjNPl9Ja9a4+RaQRrc3O+E6na8Ins97atb5K3MVaEOGIZMCCEgWFqMS3tZ6g19zGFVVq+oK6MYcNEGwGngCdMQXfWeMrAE9ex+mLn6Vxf+7K5n1JIHIeNlGuXx8FadHAyjuO8G35Og2+ekeKptleuhyNWG97DnyPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348820; c=relaxed/simple;
	bh=7ULftS75d8Nh+VNwMOLbIkr+vFqx9TpAusmjO6F+wgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j9KJtGyse1YFsxoKrFw2ciwH01LftuK9CTKnkTHYOKc0+LbArR1SL+dmibDhm8OtTugf+E9+Bl/yOflab+W+pqV0MUsHK/wu0fJ+/g/YSuSKeDLRYH4jiT582NeS80HrjWpqohaL2Zmd9OeLFBAAU3K2f3R91Dv8fobWiynA60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCrrJVqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1907CC19424;
	Tue, 24 Mar 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348820;
	bh=7ULftS75d8Nh+VNwMOLbIkr+vFqx9TpAusmjO6F+wgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MCrrJVqdxaNIKtE8SxKwq23cU4Z1/MUiB0NOFbx5f7P7uwfhHH0HLCxJvy0EgwbIb
	 9H8bI7HehqDhcGBTtCv0KXGh7x4/DKcnEJbSRDWkzaaZiVBH8AQCj9GONtQt0fJ5BT
	 fSrH4wY/l4mIF0ilDM56iWZQkymCmuPWPnx+gAK7FlcYrNdJyhgvFpEKkAnF8YSofR
	 ox5h1eTz2jc5aAR6idrEPGNKL1z2lPICXcUY9uDz9rZPBdYjjcVZ9skcWzo8YSRtvg
	 4PJO09xfa3TKNTxuk7gTKGWtgOHQ3m5GGwsxa6MO1NYtHH/+Chm0zWdaEwHbHP2G1m
	 BzvaoV7jXJV5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF333808200;
	Tue, 24 Mar 2026 10:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] team: fix header_ops type confusion and add
 selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177434880804.612784.10063445209003153905.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 10:40:08 +0000
References: <20260320072139.134249-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260320072139.134249-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270980-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE610306A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 15:21:25 +0800 you wrote:
> Hi,
> 
> This patch series fixes a panic reported by syzkaller in the team/bond/gre
> stacked non-Ethernet configuration:
> https://syzkaller.appspot.com/bug?extid=3d8bc31c45e11450f24c
> 
> The first patch fixes the header_ops type confusion / parse recursion
> context issue in team. The second patch adds a selftest to reproduce the
> reported scenario and prevent regressions in the future.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] team: fix header_ops type confusion with non-Ethernet ports
    https://git.kernel.org/netdev/net/c/425000dbf173
  - [net,v3,2/2] selftests: team: add non-Ethernet header_ops reproducer
    https://git.kernel.org/netdev/net/c/56063823b9f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



