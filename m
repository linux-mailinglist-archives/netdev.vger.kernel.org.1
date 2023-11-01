Return-Path: <netdev+bounces-45503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E687DDA8B
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 02:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344A8B20E71
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68964B;
	Wed,  1 Nov 2023 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF+04qsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71F62B
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 01:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EE9C433C8;
	Wed,  1 Nov 2023 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698801493;
	bh=Nba6ylNwvuUvLsMHOnd7vDr6OTFeqrwEKUClJP8rdnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iF+04qsFm7WOrh/U7P0/T0+sj3jQ47DijetytK2c9/ikYhcGOQww9O7cuLDCCqkMi
	 iNQPWVMYK7zpUARn0FxRDQ8WATBrv05Ht8J8/0fwXHVyZYiu7bV253UzA7xY+MEAJU
	 AF/8etJSBYrnbGi7xf7xGKa7Fn8K0CFI99mc7Om+hNojGg86maoUrP//GOcf2VUutA
	 rJegixJIvSYQX5rumxGXGn9ANhceVkMmpS2d5P0ZHtgZGzu+krYAeHgDeufOj85cra
	 n1Drwdw+pxLUx57Z4DBpq4qrd+kTUbBEVTjT4VO3l5meByCasosCCXFzeXVj5UrM9e
	 KF9y8OGqqMXPw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking follow up for 6.7
Date: Tue, 31 Oct 2023 18:18:12 -0700
Message-ID: <20231101011812.2653409-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
References: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Well, I had actually already merged the original pull request, and
> then started a full allmodconfig build.
> 
> And because I'm off gallivanting and traveling, that takes 2h on this
> poor little laptop, so I had left to do more fun things than watch
> paint dry.

Eish. Sorry.

> I pushed out my original merge. I'll pull the updates later.

In case it's helpful here's a tag with just the delta described.
Running a risk of another race condition :)


The following changes since commit f1c73396133cb3d913e2075298005644ee8dfade:

  net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers (2023-10-27 15:59:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-followup

for you to fetch changes up to f2fbb908112311423b09cd0d2b4978f174b99585:

  net: tcp: remove call to obsolete crypto_ahash_alignmask() (2023-10-31 13:11:51 -0700)

----------------------------------------------------------------
Follow up to networking PR for 6.7

 - Support GRO decapsulation for IPsec ESP in UDP.

 - Add a handful of MODULE_DESCRIPTION()s.

 - Drop questionable alignment check in TCP AO to avoid
   build issue after changes in the crypto tree.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Florian Westphal (4):
      xfrm: pass struct net to xfrm_decode_session wrappers
      xfrm: move mark and oif flowi decode into common code
      xfrm: policy: replace session decode with flow dissector
      xfrm: policy: fix layer 4 flowi decoding

Jakub Kicinski (5):
      net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
      net: fill in MODULE_DESCRIPTION()s under net/core
      net: fill in MODULE_DESCRIPTION()s under net/802*
      net: fill in MODULE_DESCRIPTION()s under drivers/net/
      Merge tag 'ipsec-next-2023-10-28' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next

Kees Cook (1):
      xfrm: Annotate struct xfrm_sec_ctx with __counted_by

Steffen Klassert (6):
      xfrm: Use the XFRM_GRO to indicate a GRO call on input
      xfrm: Support GRO for IPv4 ESP in UDP encapsulation
      xfrm: Support GRO for IPv6 ESP in UDP encapsulation
      Merge  branch 'xfrm: Support GRO decapsulation for ESP in UDP encapsulation'
      Merge branch 'xfrm: policy: replace session decode with flow dissector'
      xfrm Fix use after free in __xfrm6_udp_encap_rcv.

Stephen Rothwell (1):
      net: tcp: remove call to obsolete crypto_ahash_alignmask()

Yue Haibing (1):
      xfrm: Remove unused function declarations

 drivers/net/amt.c                           |   1 +
 drivers/net/dummy.c                         |   1 +
 drivers/net/eql.c                           |   1 +
 drivers/net/ifb.c                           |   1 +
 drivers/net/macvtap.c                       |   1 +
 drivers/net/netdevsim/netdev.c              |   1 +
 drivers/net/sungem_phy.c                    |   1 +
 drivers/net/tap.c                           |   1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c |   1 +
 include/net/gro.h                           |   2 +-
 include/net/ipv6_stubs.h                    |   3 +
 include/net/xfrm.h                          |  18 +-
 include/uapi/linux/xfrm.h                   |   3 +-
 net/802/fddi.c                              |   1 +
 net/802/garp.c                              |   1 +
 net/802/mrp.c                               |   1 +
 net/802/p8022.c                             |   1 +
 net/802/psnap.c                             |   1 +
 net/802/stp.c                               |   1 +
 net/8021q/vlan.c                            |   1 +
 net/core/dev_addr_lists_test.c              |   1 +
 net/core/selftests.c                        |   1 +
 net/ipv4/esp4_offload.c                     |   6 +-
 net/ipv4/icmp.c                             |   2 +-
 net/ipv4/ip_vti.c                           |   4 +-
 net/ipv4/netfilter.c                        |   2 +-
 net/ipv4/tcp_ao.c                           |   6 -
 net/ipv4/udp.c                              |  16 ++
 net/ipv4/xfrm4_input.c                      |  95 +++++++--
 net/ipv6/af_inet6.c                         |   1 +
 net/ipv6/esp6_offload.c                     |  10 +-
 net/ipv6/icmp.c                             |   2 +-
 net/ipv6/ip6_vti.c                          |   4 +-
 net/ipv6/netfilter.c                        |   2 +-
 net/ipv6/xfrm6_input.c                      | 103 ++++++++--
 net/netfilter/nf_nat_proto.c                |   2 +-
 net/xfrm/xfrm_input.c                       |   6 +-
 net/xfrm/xfrm_interface_core.c              |   4 +-
 net/xfrm/xfrm_policy.c                      | 301 ++++++++++++----------------
 39 files changed, 362 insertions(+), 248 deletions(-)

