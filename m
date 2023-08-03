Return-Path: <netdev+bounces-24063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1776EA5F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F2A281F7A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E91F181;
	Thu,  3 Aug 2023 13:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2B17FF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F633C433C9;
	Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691069423;
	bh=KM3SVbE2l+Dymo4uy1mdhvTALidWFZb++YPoJUNyLsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6gHVJ09+jSpCCsxY8+TRUxq+H8nQLw7ZgVIiu5RBLOc/4pvgrPB+PlP/ueOfgq+a
	 irUEUhwjGGX/xC6CfcN8SadzEyUTiBb71b0hSoZC+q0ajPjUZ+Nz+8CAJKD+MUdCEw
	 Gs2ikg6UyGPuq5AdNcDWC53cIK7NyErUzsHbTjmeB1X957F17U5eTwv5ll9p/47BYA
	 daQrthLio61DDXujuvhDEKv6zxnL8sQGG7bBMOpw7pgumfZE2escYA6/xxje4gqZBq
	 hocEF3SJLaqOrIPSEkZiUsV6s2xM1fBhH05dIFc3aUp8dn4AffBK+mObznWIFypqxL
	 rkbaOBurCZf7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 127E0C3274D;
	Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow programming
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169106942307.23843.4039028020019462397.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 13:30:23 +0000
References: <20230801212226.909249-1-aconole@redhat.com>
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, pshelar@ovn.org, amorenoz@redhat.com, i.maximets@ovn.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Aug 2023 17:22:21 -0400 you wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
> 
> Add the ability to program some of the more common flows with actions. This
> can be improved overtime to include regression testing, etc.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] selftests: openvswitch: add an initial flow programming case
    https://git.kernel.org/netdev/net-next/c/918423fda910
  - [v3,net-next,2/5] selftests: openvswitch: support key masks
    https://git.kernel.org/netdev/net-next/c/9f1179fbbd84
  - [v3,net-next,3/5] selftests: openvswitch: add a test for ipv4 forwarding
    https://git.kernel.org/netdev/net-next/c/05398aa40953
  - [v3,net-next,4/5] selftests: openvswitch: add basic ct test case parsing
    https://git.kernel.org/netdev/net-next/c/2893ba9c1d1a
  - [v3,net-next,5/5] selftests: openvswitch: add ct-nat test case with ipv4
    https://git.kernel.org/netdev/net-next/c/60f10077eec6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



