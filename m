Return-Path: <netdev+bounces-180118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDE6A7FA40
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A557A5624
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18311266593;
	Tue,  8 Apr 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJXBMCE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C326562E
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105796; cv=none; b=MSGrfWLff4qxdyQ7ZMUjWFISKIXGS7kh3fbuDymSsAvR79Z6ZrXWPPn4F1MYdMCHmk23NYT4JXlxVpLjmLEmliOdpDrDxWTQTI9YSf+zsq+HaW/DSXaFXFDM+UAFk1QxrutOiT7UvoKnvZmehmQK/kFOa4138t2KNlwMhsKV5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105796; c=relaxed/simple;
	bh=yGUx7Tx9lAjDgovv8cKhp2cV6UwZT0CcgwcSzSMB6ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BWFcO71k17v9EmqTImqNmOJpWIf6BJ5EVbGjSslaaAKzTiz5MuuEHwk8BpLJuxsitOqgPK3eiX1LE5LneQWpkZpmBAVAsEUBS3ixuMeEwpQf+8e+L02ktbhOP8txk8HeCVEI4xfXwZczwqGfKQ9RFSRjuV6JWpR2ipwQcL8+ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJXBMCE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C322C4CEE5;
	Tue,  8 Apr 2025 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744105795;
	bh=yGUx7Tx9lAjDgovv8cKhp2cV6UwZT0CcgwcSzSMB6ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LJXBMCE8pg3OwEiFe6CZ9bPiin48G1PKEISLLDucf7UFXS/uAjBTdSehKLULoFCss
	 urPvD9jT9DHSY2CzdlVpr6BxIJ+Ejc0qeTk0Fe7CGm1Ndk784wlAMK9S3r5ze4rjCm
	 jh+hiiNOCBbyCwgdQeOnuE/ww3bwVztRS/I9BBZ9StqTdDsE/7PeIdRu/UuOALuF0w
	 Hz9YZPwFsHpAfrDx2C7YfEhan/702eq3g3rrsZ/qpQHTKeW+IrPSl1IXbRA1P33dLL
	 GS3VttjnyItGcFv5APZqzvovgiH4GVlr0swYweQ4q793ahSBU+GpWwfzpEneT+kljW
	 Si0WoIjaQN2lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC738111D4;
	Tue,  8 Apr 2025 09:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174410583280.1846628.16756253256143568898.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 09:50:32 +0000
References: <20250404180334.3224206-1-kuba@kernel.org>
In-Reply-To: <20250404180334.3224206-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 borisp@nvidia.com, john.fastabend@gmail.com, sd@queasysnail.net,
 syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Apr 2025 11:03:33 -0700 you wrote:
> syzbot discovered that it can disconnect a TLS socket and then
> run into all sort of unexpected corner cases. I have a vague
> recollection of Eric pointing this out to us a long time ago.
> Supporting disconnect is really hard, for one thing if offload
> is enabled we'd need to wait for all packets to be _acked_.
> Disconnect is not commonly used, disallow it.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: tls: explicitly disallow disconnect
    https://git.kernel.org/netdev/net/c/5071a1e606b3
  - [net,2/2] selftests: tls: check that disconnect does nothing
    https://git.kernel.org/netdev/net/c/a1328a671e1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



