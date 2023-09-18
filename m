Return-Path: <netdev+bounces-34495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C694F7A4631
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804C328162F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F31C29D;
	Mon, 18 Sep 2023 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483F6FD0;
	Mon, 18 Sep 2023 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1BCBC433CA;
	Mon, 18 Sep 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695030022;
	bh=uRfOQOB0II5sP8GPpDWkYX/vEwWZ4Q9wf7azPLUxnI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+/CFp1VkUNvrkW4WOXwUNjeLGGda4LOtdSOhfnYStHDdLVlHuZgUtGJ6PmPrATSn
	 s28+YAtvisNIxRfYRakr/TdDBQfPOITm9eY2KLuKlhFf7fRLLzxAzCpIU8BVq4gMlA
	 2m5g/NqQxmPK2TaBf3uef6ajyji2hvUJpAgnrzw42gtp6JqVnPPfl/n6qfFIe1v+z/
	 rOdSMU1EGbXcYtaU2Arp8vi41mRQEEuUBclAnxxeff6oAvSXhlA1PyrTDKyEWfLYBV
	 IvBBO6M0C/3vulS+/41rNhmTpdXm3y0oi6nheA43JyCMotdTmfRmL0g+5Rzr/Mhuus
	 +MIjX3Y5F4oiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C78EBE11F41;
	Mon, 18 Sep 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169503002181.24344.5873701629214587241.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 09:40:21 +0000
References: <20230915201510.never.365-kees@kernel.org>
In-Reply-To: <20230915201510.never.365-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 13:15:10 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Here is the summary with links:
  - ceph: Annotate struct ceph_monmap with __counted_by
    https://git.kernel.org/netdev/net-next/c/1cb6422ecac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



