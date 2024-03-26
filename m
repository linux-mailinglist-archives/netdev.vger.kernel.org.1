Return-Path: <netdev+bounces-82007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1888C0FB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D522C5C9C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D455E58;
	Tue, 26 Mar 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Np1bNn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8C5475D
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453231; cv=none; b=uRpf/6y9nauPR2Fqxe55XYzvpEt08KCBxFSk8KwPe2OAnYzydDR+w6CeF1AwvlvvHYNZoGry4tF/cGSfkxJivdJACGv4FNWkFNCiHO+7+taCVjOk0Jsx+wPxfD5JAfhu3U0Nv5RbdOc2oemAcFt/MZ+tuZgqCq6cBZxjEWXLxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453231; c=relaxed/simple;
	bh=7lJIWy/m7ZLTiyMMI48HYyvtpwcDo8JPg6CufdR47TQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pvsgMfUkSQxaDILbx97e0KYeH5sOx62cIxG6+A0lDyyitjRkUHOt0hIZ2Z9iUvVD7nuAVnJq92BOIZuSWQJWxTka4BNuxEiEMXmo7hkKFAXJpScs1LaqGCyibUe/4zxrCkUHRmt8RT/4yAvg1c2TwXx4qb+7iiV++UvxzBvC6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Np1bNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71F80C433C7;
	Tue, 26 Mar 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453230;
	bh=7lJIWy/m7ZLTiyMMI48HYyvtpwcDo8JPg6CufdR47TQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q4Np1bNntonbF41eNRS5iwYT5/FkEWFQPhs01BN7w4C9tyN8JL/K5MxFOkb5SACEh
	 HhyJYdLIKCGcu8ZO6uyLlA6eVA+qf+zgXvUpztA8t1qcjq6UC8e0cPmxe39+dgY1lP
	 UekcVaYPr5N5SlZmEEI9JmNFKRgiDZwnmhqaI8mr0UhiUXBcAJRwvcLBARKnigo7pz
	 zKSrakT4Yjvw4Wy8uyLjv4/f1ZhZhPQ2RX64Ut0xMepazbDFmEfIUxlvrEIAl6y+qh
	 MiU7Lnn89eRHCxnrNWF3ZotLDNhqcS4Lxv0mUQ8W+b5w7Xa6YrDqB6xMCtj5ptZ30L
	 YLekv6nseXsBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67837D2D0EC;
	Tue, 26 Mar 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: vxlan_mdb: Fix failures with old libnet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171145323041.5270.10718978656923412689.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 11:40:30 +0000
References: <20240325075030.2379513-1-idosch@nvidia.com>
In-Reply-To: <20240325075030.2379513-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 mirsad.todorovac@alu.unizg.hr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 09:50:30 +0200 you wrote:
> Locally generated IP multicast packets (such as the ones used in the
> test) do not perform routing and simply egress the bound device.
> 
> However, as explained in commit 8bcfb4ae4d97 ("selftests: forwarding:
> Fix failing tests with old libnet"), old versions of libnet (used by
> mausezahn) do not use the "SO_BINDTODEVICE" socket option. Specifically,
> the library started using the option for IPv6 sockets in version 1.1.6
> and for IPv4 sockets in version 1.2. This explains why on Ubuntu - which
> uses version 1.1.6 - the IPv4 overlay tests are failing whereas the IPv6
> ones are passing.
> 
> [...]

Here is the summary with links:
  - [net] selftests: vxlan_mdb: Fix failures with old libnet
    https://git.kernel.org/netdev/net/c/f1425529c33d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



