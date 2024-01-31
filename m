Return-Path: <netdev+bounces-67600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C98443A0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D49B2716E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8612BE8A;
	Wed, 31 Jan 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8BcMzY+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538B12AAFE;
	Wed, 31 Jan 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716901; cv=none; b=nR0dhYjwzT8GaWY4m9KZ7KHLSs28x2CHtLtZgRTnASWzDSPA3HcNp+YQKblMnyUuVeKwwgJ+zxRAlUIcuhGJPuQAFk4SlDRfsEBp1sQFdsyiBMw88k6K6F/OE4JuN4zNG2VUF/uGLfi1WFDHG399GzBczA1vuCmDLOrK8JS156o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716901; c=relaxed/simple;
	bh=cEUoUJ9s7uuT0d4FIkDyhd3VzrDdfHZh6N4G4jYpffo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eexDUTpy5RQmd9vZBz9NbcoTsUqszzJeI1XBuFBQAcsf+n3/28Fioef/Hpypty/mMGhlLnJk12wxiyjoHJzWnzC21pQbFHIR54p0OIpSi6a1mX3mAvZW9ik/CtpGdaDJxX6XZ/nTz3B9AeLJJ2rWX8ie2x5JZLCdypaSQj97X10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8BcMzY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A4C433C7;
	Wed, 31 Jan 2024 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706716900;
	bh=cEUoUJ9s7uuT0d4FIkDyhd3VzrDdfHZh6N4G4jYpffo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8BcMzY+bLt6AONb3AatqO6xaFqRSBwBSODBR58EXoyI1RRMVynpDCd00nfA6cig6
	 yhJGdLcM5iWXbd8qhze1K1K9NWsqT/xaUSbniy8o9AUAyYCWrHxdguzJLxbRmJz0QJ
	 bZfzmiVV9OdUvRtXhN3hj6xmLnLBGM5DHkJrTb2zepdHMjy5txZ11XYwB3YwHxfO4V
	 PugySZBcIpkioPkjZxuYLIKquB9rewUTNG21p19ib5BqzYodEjcTh4eqBOEo1FzdZI
	 LfmkJSFxVsHj6GspJRTzOQK9MC3keWdtW+YXnqtF3sIQG1w+t1rzRx0I+vvKVO4i/e
	 AexeyFvD183HQ==
Date: Wed, 31 Jan 2024 08:01:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <20240131080137.50870aa4@kernel.org>
In-Reply-To: <ZbpJ5s6Lcl5SS3ck@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
	<ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
	<20240129070057.62d3f18d@kernel.org>
	<ZbfZwZrqdBieYvPi@shredder>
	<20240129091810.0af6b81a@kernel.org>
	<ZbpJ5s6Lcl5SS3ck@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 15:23:50 +0200 Ido Schimmel wrote:
> > Hm. Looks like our versions match. I put the entire tools root dir up on
> > HTTP now: https://netdev-2.bots.linux.dev/tools/fs/ in case you wanna
> > fetch the exact binary, it only links with libc, it seems.  
> 
> I tried with your binary and on other setups and I'm unable to reproduce
> the failure. From the test output it seems the NS is never sent. If you
> can, attaching the verbose test output might help:
> 
> ./test_bridge_neigh_suppress.sh -t neigh_suppress_ns -v

FWIW I started two new instances on bare metal one with the same kernel
as the nested VM and one with debug options enabled.

selftests-net/test-bridge-neigh-suppress-sh
 - fails across all, so must be the OS rather than the "speed"

selftests-net/test-bridge-backup-port-sh
  - passes on VM, metal-dbg
  - fails on metal :S very reliably / every time:
https://netdev.bots.linux.dev/contest.html?test=test-bridge-backup-port-sh

  # TEST: No forwarding out of swp1                    [FAIL]

selftests-net/drop-monitor-tests-sh 
 - passes everywhere now

The info you asked for:

# ./test_bridge_neigh_suppress.sh -t neigh_suppress_ns -v
[   49.621534] eth0: renamed from veth0
[   49.654673] swp1: renamed from veth1
[   49.676235] ip (235) used greatest stack depth: 12032 bytes left
[   49.721434] veth0: renamed from veth1
[   49.739521] ip (241) used greatest stack depth: 11880 bytes left
[   49.760463] eth0: renamed from veth0
[   49.787523] swp1: renamed from veth1
[   50.019197] br0: port 1(swp1) entered blocking state
[   50.019610] br0: port 1(swp1) entered disabled state
[   50.019949] swp1: entered allmulticast mode
[   50.020307] swp1: entered promiscuous mode
[   50.021035] br0: port 1(swp1) entered blocking state
[   50.021415] br0: port 1(swp1) entered forwarding state
[   50.076445] br0: port 2(vx0) entered blocking state
[   50.076805] br0: port 2(vx0) entered disabled state
[   50.077139] vx0: entered allmulticast mode
[   50.077492] vx0: entered promiscuous mode
[   50.077812] br0: port 2(vx0) entered blocking state
[   50.078172] br0: port 2(vx0) entered forwarding state
[   50.238364] br0: port 1(swp1) entered blocking state
[   50.238735] br0: port 1(swp1) entered disabled state
[   50.239077] swp1: entered allmulticast mode
[   50.239434] swp1: entered promiscuous mode
[   50.240046] br0: port 1(swp1) entered blocking state
[   50.240395] br0: port 1(swp1) entered forwarding state
[   50.269453] br0: port 2(vx0) entered blocking state
[   50.269812] br0: port 2(vx0) entered disabled state
[   50.270142] vx0: entered allmulticast mode
[   50.270597] vx0: entered promiscuous mode
[   50.270893] br0: port 2(vx0) entered blocking state
[   50.271222] br0: port 2(vx0) entered forwarding state

Per-port NS suppression - VLAN 10
---------------------------------
COMMAND: tc -n sw1-hF6GFk qdisc replace dev vx0 clsact
COMMAND: tc -n sw1-hF6GFk filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip ff02::1:ff00:2 src_ip 2001:db8:1::1 type 135 code 0 action pass
[   55.411592] GACT probability NOT on
COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: bridge -n sw1-hF6GFk link set dev vx0 neigh_suppress on
COMMAND: bridge -n sw1-hF6GFk -d link show dev vx0 | grep "neigh_suppress on"
        hairpin off guard off root_block off fastleave off learning off flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress on neigh_vlan_suppress off vlan_tunnel on isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0 
TEST: "neigh_suppress" is on                                        [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: bridge -n sw1-hF6GFk fdb replace 5a:1d:b4:4b:25:16 dev vx0 master static vlan 10
TEST: FDB entry installation                                        [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n sw1-hF6GFk neigh replace 2001:db8:1::2 lladdr 5a:1d:b4:4b:25:16 nud permanent dev br0.10
TEST: Neighbor entry installation                                   [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.10 down
TEST: H2 down                                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.10 up
TEST: H2 up                                                         [ OK ]

COMMAND: bridge -n sw1-hF6GFk link set dev vx0 neigh_suppress off
COMMAND: bridge -n sw1-hF6GFk -d link show dev vx0 | grep "neigh_suppress off"
        hairpin off guard off root_block off fastleave off learning off flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress off neigh_vlan_suppress off vlan_tunnel on isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0 
TEST: "neigh_suppress" is off                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.10 down
TEST: H2 down                                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 2

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0


Per-port NS suppression - VLAN 20
---------------------------------
COMMAND: tc -n sw1-hF6GFk qdisc replace dev vx0 clsact
COMMAND: tc -n sw1-hF6GFk filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip ff02::1:ff00:2 src_ip 2001:db8:2::1 type 135 code 0 action pass
COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: bridge -n sw1-hF6GFk link set dev vx0 neigh_suppress on
COMMAND: bridge -n sw1-hF6GFk -d link show dev vx0 | grep "neigh_suppress on"
        hairpin off guard off root_block off fastleave off learning off flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress on neigh_vlan_suppress off vlan_tunnel on isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0 
TEST: "neigh_suppress" is on                                        [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: bridge -n sw1-hF6GFk fdb replace 5a:1d:b4:4b:25:16 dev vx0 master static vlan 20
TEST: FDB entry installation                                        [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n sw1-hF6GFk neigh replace 2001:db8:2::2 lladdr 5a:1d:b4:4b:25:16 nud permanent dev br0.20
TEST: Neighbor entry installation                                   [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.20 down
TEST: H2 down                                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.20 up
TEST: H2 up                                                         [ OK ]

COMMAND: bridge -n sw1-hF6GFk link set dev vx0 neigh_suppress off
COMMAND: bridge -n sw1-hF6GFk -d link show dev vx0 | grep "neigh_suppress off"
        hairpin off guard off root_block off fastleave off learning off flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress off neigh_vlan_suppress off vlan_tunnel on isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0 
TEST: "neigh_suppress" is off                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 0

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

COMMAND: ip -n h2-g0sh0Q link set dev eth0.20 down
TEST: H2 down                                                       [ OK ]

COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:2::1 -w 5000 2001:db8:2::2 eth0.20
Raw IPv6 socket: Operation not permitted
TEST: ndisc6                                                        [FAIL]
    rc=1, expected 2

TEST: NS suppression                                                [FAIL]
    rc=1, expected 0

[   57.883133] br0: port 1(swp1) entered disabled state
[   57.884754] swp1 (unregistering): left allmulticast mode
[   57.885191] swp1 (unregistering): left promiscuous mode
[   57.885580] br0: port 1(swp1) entered disabled state

Tests passed:  14
Tests failed:  28
[   57.966498] vx0: left allmulticast mode
[   57.966802] vx0: left promiscuous mode
[   57.967091] br0: port 2(vx0) entered disabled state
[   57.992675] br0: port 1(swp1) entered disabled state
[   58.017115] swp1 (unregistering): left allmulticast mode
[   58.017520] swp1 (unregistering): left promiscuous mode
[   58.017898] br0: port 1(swp1) entered disabled state
bash-5.2# [   58.092405] vx0: left allmulticast mode
[   58.092704] vx0: left promiscuous mode
[   58.092972] br0: port 2(vx0) entered disabled state


