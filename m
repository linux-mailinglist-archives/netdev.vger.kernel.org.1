Return-Path: <netdev+bounces-258174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLEMAfXli2kcdAAAu9opvQ
	(envelope-from <netdev+bounces-258174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:14:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A18E120B89
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4007300C31D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FBE2FD675;
	Wed, 11 Feb 2026 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7tYPjJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136302FD1B1
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776049; cv=none; b=YplsMussYSTSXDVIJco2coiFPbp79lt+w38Dkr9hFKu3TsYb+DW+jI7+2Yy7OzvEuany+Z65FjxPINkzN7Ak881hx4XlmOnTbkH7EMn+bFcTPfRQrLnFNy7tVIZOjGUOIuLg+oEs37a5++6ixST/nffBnd3418/qHNkbsjasrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776049; c=relaxed/simple;
	bh=2nONMecAlliorhX0hR7OB9uQEl1LmAXUfqMnJeruTL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALDqzSOUaIgpQ621ltwj9AwwGVfetBMQsBZKbzaNMxq+cSyLLxW0sIxPtk3007z1Xh0XZFmPAx0XRFmPfYTi5eJwkG12s2ggmVEYMWx0CjuAw4vgQIowQxFLeee6DIDg31ZyXsJtHqEgjAUOiItIQZJIRVUzfKchlTleC/nogO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7tYPjJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78255C116C6;
	Wed, 11 Feb 2026 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776048;
	bh=2nONMecAlliorhX0hR7OB9uQEl1LmAXUfqMnJeruTL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7tYPjJ0zrlkXAlhRKq9rnFJALxsDWdsPGHJM8zhTtCgo4GnA7ag2WZheuFBj7ikK
	 2dmV5LAQaFQ4AuN15YvUGvRUs2uwj9fT15QW8fsjyrMWy8Td6H8qID+NQfqBvl1e9W
	 X5s1v9Y0gj5m+hNeTgvKd1XyEDbySflm+ywTNhi9qeB9rwfJJ1bfXEjxxkW3Yw4MG0
	 77h1wTTZMBBmPIKaDNNDOJueaNEk9nYTB2SGR8eILcn/lmxDjhiw2avhEbrapJeiK8
	 x7Tk6UA4v9kicrYBaoNj5ecv6PG2ous/V6fYdFMd1pvDIMsPlnQyVMMGACf7bQ5SlY
	 HLy3EhQT+exxg==
Date: Tue, 10 Feb 2026 18:14:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Heckemann <git@sphalerite.org>
Cc: edumazet@google.com, liuhangbin@gmail.com, davem@davemloft.net,
 eric.dumazet@gmail.com, horms@kernel.org, morikw2@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] selftests/net: add test for IPv4-in-IPv6 tunneling
Message-ID: <20260210181407.413c702d@kernel.org>
In-Reply-To: <20260209190008.139099-2-git@sphalerite.org>
References: <20260209190008.139099-2-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258174-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A18E120B89
X-Rspamd-Action: no action

On Mon,  9 Feb 2026 20:00:09 +0100 Linus Heckemann wrote:
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
> 
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/

Missing your Signed-off-by: ...

Is this the output you expect (ignore the first two numbers, they are
just output timing within our infra):

TAP version 13
1..1
# overriding timeout to 7200
# selftests: net: ip6_tunnel.sh
# Warning: file ip6_tunnel.sh is not executable
# 1.17 [+1.17] PING 172.0.0.2 (172.0.0.2) 56(84) bytes of data.
# 1.18 [+0.00] 64 bytes from 172.0.0.2: icmp_seq=1 ttl=64 time=2.31 ms
# 1.18 [+0.00] 
# 1.18 [+0.00] --- 172.0.0.2 ping statistics ---
# 1.19 [+0.00] 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# 1.19 [+0.00] rtt min/avg/max/mdev = 2.311/2.311/2.311/0.000 ms
# 1.24 [+0.05] PING 2001:db8:6::2 (2001:db8:6::2) 56 data bytes
# 1.24 [+0.00] 64 bytes from 2001:db8:6::2: icmp_seq=1 ttl=64 time=0.368 ms
# 1.25 [+0.00] 
# 1.25 [+0.00] --- 2001:db8:6::2 ping statistics ---
# 1.25 [+0.00] 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# 1.25 [+0.00] rtt min/avg/max/mdev = 0.368/0.368/0.368/0.000 ms
# 1.58 [+0.33] Cannot find device "transport1"
ok 1 selftests: net: ip6_tunnel.sh

Tests don't usually print raw ping output to stdout, plus the
	Cannot find device "transport1"
looks a bit off?
-- 
pw-bot: cr

