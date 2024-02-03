Return-Path: <netdev+bounces-68844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5C8487FB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051C1C209F3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C95DF19;
	Sat,  3 Feb 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEKo5uRp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3F5D732
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706982113; cv=none; b=r1Y85RhG4zrDeQ/+Tv3bfwr81KwfP1U+DtDDQ12vU8UVZHvybj4N0UCx7Ea6LLCiOq2e1M8qBZ1dVElWs1AgDQAqvnBUODmauCjg+y9QjGtYTl73WN2Hl508gFuP/Gu9xIMrai+JZ2Z1Wxga/OXmCHVOY1gPagTmlOGxlYBTIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706982113; c=relaxed/simple;
	bh=xS/1UjUZX12poDRo7aGVW5+i6aru0/FpiwK7sL/v2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoqoB+jDg4qM/wV9hCHz2OR95Oq6SdUekG7AvzN3Z8yyCl5HgxHAnraLvOssdcdexc0DAejg9zd6QpkOYVTwNyDBrcjUS7Hh5yfRgG+GSzX2PEGtkNwWSh3iMPWAhaR7nGMcQTH8kMb/GROQlemlUhXJhWv7F6dnUPljg4jyJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEKo5uRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1C1C433F1;
	Sat,  3 Feb 2024 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706982112;
	bh=xS/1UjUZX12poDRo7aGVW5+i6aru0/FpiwK7sL/v2Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEKo5uRp4Jyp5tcNRBaNB6N04JPOWZNKH8Z1DwORBCGJMzsk1jGYht7UysOhpdhCk
	 iZ6YWXO06St3I5Pz4w0Uh3UPV6APZ8BT6NPcEKSC0VDeNqTQgzoh9xTaU3xc2nZMsM
	 fmX1814w/hVKhRQuw5hB48HA70nfGADrbmRqzpMOrXCCtMfUVV5Eegdn5pWtDY9N76
	 FnzaOxlX9jsCsNfveRe5fuSgN3wuLuWtDB8ZrUBH7eAVUIXn/bABU4eGg6sMcd5Jva
	 l0nFnt17c5aaoFwl2quFR5ae1dGrx3Dlg/D3KrlgyIahMnvz96baXZAlldEv5hFi9S
	 fegPTgdY4tBXA==
Date: Sat, 3 Feb 2024 09:41:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCHv3 net-next 4/4] selftests: bonding: use slowwait instead
 of hard code sleep
Message-ID: <20240203094151.5347fba8@kernel.org>
In-Reply-To: <20240202023754.932930-5-liuhangbin@gmail.com>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
	<20240202023754.932930-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 10:37:54 +0800 Hangbin Liu wrote:
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> index b609fb6231f4..acd3ebed3e20 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> @@ -58,7 +58,7 @@ macvlan_over_bond()
>  	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
>  	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
>  
> -	sleep 2
> +	slowwait 2 ip netns exec ${c_ns} ping ${s_ip4} -c 1 -W 0.1 &> /dev/null
>  
>  	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
>  	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
> @@ -69,8 +69,7 @@ macvlan_over_bond()
>  	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
>  	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
>  
> -
> -	sleep 5
> +	slowwait 5 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
>  
>  	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
>  	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"

This makes the bond_macvlan.sh test flaky:

https://netdev.bots.linux.dev/contest.html?test=bond-macvlan-sh

I repro'd it and the ping in check_connection() fails - neigh resolution
fails. I guess we need to insert more of the slowwaits?

Reverting this patch from the pending patch tree fixes it. The runner
has no KVM support, and runs a VM with 64 CPUs. If I lower the number
of CPUs to 4 the test passes. I added the note that some flakiness may
be caused by high CPU count:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#tips
-- 
pw-bot: cr

