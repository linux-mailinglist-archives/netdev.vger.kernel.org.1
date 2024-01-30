Return-Path: <netdev+bounces-66944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D00841958
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00DEB2390C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8436102;
	Tue, 30 Jan 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu8Gp+rW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BB36B18
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581904; cv=none; b=eHHLokVQcNG3KALiZK01pZPLYXi/0XrFjZRhdv+Sfo5uykR7imGzbYDZaoF0l+/hUaxilN+pLdwMv5HS9MdHHo7ODgHxg6q2EmGI2NqSCOZAIZTbxgbo/bwcvxTIKY0yXT2KQRwpZsZY8P/T8ZgAiQPwYvhzmHk6mY/rhcT86Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581904; c=relaxed/simple;
	bh=lob+0G7PLz8i8v2ac9xmv3Exl8aHcGewldvgdVqzh+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGZ4fp66K3rpwfI8bHgfiSk+CD/XBp0jEjzqZkNU0Ku7wwfOnXFOz9xQ0N6TPx0JSAfZdUmVQkbQ7uT6DIx9aAV+lnI7YS2EON1oBhOhEnJ4drqoCC9TiEdcJlURcDMnCvNrCNOfy8+cLkTe5XOC3PpDZs/l5SiffrL/z4yIjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu8Gp+rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53371C433F1;
	Tue, 30 Jan 2024 02:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706581903;
	bh=lob+0G7PLz8i8v2ac9xmv3Exl8aHcGewldvgdVqzh+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bu8Gp+rWz92YC5zBpsSo7Pdxd3Vijd4ZGICgx07egaywqkTQ1geb+i4C4PuNWmOML
	 sFV0tLSSj3zrJ/NVgTtBcJYQiCXuA01LvMTIzbbKh3ppzjEQImvKV250L1jf8CEV7U
	 q3hzUwWk29WR1X+8vHxF5zHnzC/+xUdLfujfJHnNEOasv54rXG5nFNI4ze+PuLqPz1
	 WycYA7kxOdI4TgfcP1t4CNYLLLx9zxAtLEE2IPTmqL47bHj+qfkBZIIvHl0VaE6J2M
	 KZf4Wqp9vSJIjfQTuCyLG1HwVtLltkree4GSJtMYpFyt2gylseH8LZWeDCI17UgcTb
	 mhoxR0LDt/zaQ==
Date: Mon, 29 Jan 2024 18:31:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Ido Schimmel
 <idosch@idosch.org>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config
 entries
Message-ID: <20240129183142.5b7ba871@kernel.org>
In-Reply-To: <87le88l6qz.fsf@nvidia.com>
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
	<20240126112538.2a4f8710@kernel.org>
	<87le88l6qz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 11:45:07 +0100 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > Thanks a lot for fixing this stuff! The patch went into the
> > net-next-2024-01-26--18-00 branch we got: pass 94 / skip 2 / fail 15
> >
> > https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-26--18-00&executor=vmksft-forwarding&pw-y=0
> >
> > Clicking thru a handful of the failures it looks like it's about a 50/50
> > split between timeouts and perf mismatch.   
> 
> Looking at some recent runs. A number of failures are probably due to
> the system failing to oversubscribe the interface with the tested
> qdiscs. That's sch_ets, sch_tbf_ets, sch_tbf_prio, sch_tbf_root,
> tc_police.
> 
> Not sure what to do about it. Maybe separate out heavy traffic tests,
> and add a make run_lotraf_tests?

Either that or the other way - express the expectation that the
environment is slow to the test. It came up in the "net-next is OPEN"
thread and also off-list. Perhaps we should discuss tomorrow on the
netdev call?

https://lore.kernel.org/all/20240129112057.26f5fc19@kernel.org/

To make sure I've done my homework I kicked off few more instances of
the tester metal-* and metal-*-dbg. They are running in AWS (AWS Linux,
again) but on bare metal. Former are identical to the previous ones,
just with KVM / HW virt support now, so those should really be all
green. The metal-*-dbg ones have kernel/configs/debug.config and
kernel/configs/x86_debug.config configed in, so "worst case slow".

> tc_actions started getting a passible deadlocking warning between Jan 27
> 00:37 and Jan 28 18:27:
> 
>     https://netdev-2.bots.linux.dev/vmksft-forwarding/results/438201/108-tc-actions-sh/
>     https://netdev-2.bots.linux.dev/vmksft-forwarding/results/438566/109-tc-actions-sh/
> 
> So either something landed that broke it, or the host kernel now has
> more debugging enabled, so it now gives a citation.

Hm. configs are identical.

$ git diff net-next-2024-01-26--18-00..net-next-2024-01-27--00-04 --stat 
 Documentation/devicetree/bindings/net/snps,dwmac.yaml            |  11 +++---
 Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml |  72 +++++++++++++++++++++++++++------------
 drivers/net/ethernet/amd/pds_core/adminq.c                       |  74 +++++++++++++++++++++++++++-------------
 drivers/net/ethernet/amd/pds_core/core.c                         | 130 +++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/net/ethernet/amd/pds_core/core.h                         |   3 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c                      |  12 ++++---
 drivers/net/ethernet/amd/pds_core/dev.c                          |  30 ++++++++++++-----
 drivers/net/ethernet/amd/pds_core/devlink.c                      |   3 +-
 drivers/net/ethernet/amd/pds_core/fw.c                           |   3 ++
 drivers/net/ethernet/amd/pds_core/main.c                         |  26 +++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c      |  16 ++++-----
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c         |   9 ++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                   | 160 +++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                   |  15 ++-------
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c               |  11 +++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c          |  17 +++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c            |  15 +++++----
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c         |   8 ++---
 drivers/net/ethernet/stmicro/stmmac/Kconfig                      |   6 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c             |  32 +++++++++++++++---
 net/core/dev.c                                                   |  27 +++++++++------
 net/core/dev.h                                                   |   1 +
 net/ipv4/ip_output.c                                             |   9 +----
 tools/testing/selftests/net/config                               |  14 ++++----
 24 files changed, 430 insertions(+), 274 deletions(-)

No idea.

> ip6gre_inner_v6_multipath is just noisy? It failed the last run, but
> passed several before.

FWIW I made this: https://netdev.bots.linux.dev/flakes.html

> router_multicast and router get a complaint about a missing control
> socket. I think at first approximation they need:
> 
>     # mkdir -p /usr/local/var/run
> 
> But even then I'm getting a fail. This and the others seem to all be in
> IPv6 multicast.


