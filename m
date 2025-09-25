Return-Path: <netdev+bounces-226284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D353BB9ED0A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C213ACF30
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B42F5306;
	Thu, 25 Sep 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxB9D27N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9952EA47E;
	Thu, 25 Sep 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797416; cv=none; b=FAb6cTr5+V0tDhHX1XzntTiMVjvE62h5kewKTwl0guX1nsn1qcplVOXXy4dNWyzzofxbPOwKRURcCKYNrL0doghXWVSeNLAEGQGcv4h7Eq3Ug7dsuphIf6u7cJsYfbmeRQPv4TCXNihS2+JWGH3lJ6zaioUO7TZ5GL/6DRHKJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797416; c=relaxed/simple;
	bh=+wlZn7QPyajocFdqL/fg4gZvcEePNLZTcYaBoVafrNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwalhqpJqSgr5D8gE/uJA6vCy+BEtlE8w/IQpj1lQQl/CgAZBLNBfQcuw4O5PQYECC28AWPw8j8uQKZEl+1Hd7izY+bt9t9UTo+221/K4nbxUKZtM9fI4ZxMWvApcGW/ssobM4O+P2FfLB8Gw/QpTokDf9Qlmaz3tKLGtW2rmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxB9D27N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A8AC4CEF4;
	Thu, 25 Sep 2025 10:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758797415;
	bh=+wlZn7QPyajocFdqL/fg4gZvcEePNLZTcYaBoVafrNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lxB9D27NhD1w3LUVthAhO1VJ06649vMMlTs6XWsy+Ls9QdGMm7Z+a1Xo8JEky/rHG
	 5JE6FC5OLTTSo//K0deosufdGHBBEJ1YSSiGV9hiH8PqOGELDJauixCRAyPD0t+i+0
	 EKrbCflOIhymKeOlxTgs/Obz5gJTFl6Gs/KQuciZsmKViw9jaxPExImwzxSkppN448
	 8mvFMqUIwt13MDyUyB3T860blru5GAgZQ07aU+Z7VLkCx9dkK8X1LpvUJn/7oXv96w
	 vG4jODer0XV9ZHlRSVZuHb3BoevhFzO1n3IBBhMyPv6ArZiSjtr0QPkVWwBd++xpm5
	 tLqqAEQ35c8fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4339D0C21;
	Thu, 25 Sep 2025 10:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/5] net: gso: restore outer ip ids correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175879741200.2924890.4123184469600808130.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 10:50:12 +0000
References: <20250923085908.4687-1-richardbgobert@gmail.com>
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Sep 2025 10:59:03 +0200 you wrote:
> GRO currently ignores outer IPv4 header IDs for encapsulated packets
> that have their don't-fragment flag set. GSO, however, always assumes
> that outer IP IDs are incrementing. This results in GSO mangling the
> outer IDs when they aren't incrementing. For example, GSO mangles the
> outer IDs of IPv6 packets that were converted to IPv4, which must
> have an ID of 0 according to RFC 6145, sect. 5.1.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/5] net: gro: remove is_ipv6 from napi_gro_cb
    https://git.kernel.org/netdev/net-next/c/25c550464acd
  - [net-next,v8,2/5] net: gro: only merge packets with incrementing or fixed outer ids
    https://git.kernel.org/netdev/net-next/c/21f7484220ac
  - [net-next,v8,3/5] net: gso: restore ids of outer ip headers correctly
    https://git.kernel.org/netdev/net-next/c/3271f19bf7b9
  - [net-next,v8,4/5] net: gro: remove unnecessary df checks
    https://git.kernel.org/netdev/net-next/c/f095a358faf2
  - [net-next,v8,5/5] selftests/net: test ipip packets in gro.sh
    https://git.kernel.org/netdev/net-next/c/5e9ff9378adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



