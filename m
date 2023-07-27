Return-Path: <netdev+bounces-21932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0B76552D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1461C21684
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DEE171D4;
	Thu, 27 Jul 2023 13:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C23171C9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:36:17 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D92728;
	Thu, 27 Jul 2023 06:36:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qP1A0-0003DR-Ir; Thu, 27 Jul 2023 15:36:08 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 0/5] netfilter updates for net-next
Date: Thu, 27 Jul 2023 15:35:55 +0200
Message-ID: <20230727133604.8275-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

This batch contains a few updates for your *net-next* tree.
Note that this includes two patches that make changes to lib/.

1.  silence a harmless warning for CONFIG_NF_CONNTRACK_PROCFS=n builds,
from Zhu Wang.

2, 3:
Allow NLA_POLICY_MASK to be used with BE16/BE32 types, and replace a few
manual checks with nla_policy based one in nf_tables, from myself.

4: cleanup in ctnetlink to validate while parsing rather than
   using two steps, from Lin Ma.

5: refactor boyer-moore textsearch by moving a small chunk to
   a helper function, rom Jeremy Sowden.

The following changes since commit bc758ade614576d1c1b167af0246ada8c916c804:

  net/mlx4: clean up a type issue (2023-07-26 22:08:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-23-07-27

for you to fetch changes up to 86e9c9aa2358a74bcc5e63f9fc69c2d01e64c002:

  lib/ts_bm: add helper to reduce indentation and improve readability (2023-07-27 13:45:51 +0200)

----------------------------------------------------------------
netfilter net-next pull request 2023-07-27

----------------------------------------------------------------
Florian Westphal (2):
      netlink: allow be16 and be32 types in all uint policy checks
      netfilter: nf_tables: use NLA_POLICY_MASK to test for valid flag options

Jeremy Sowden (1):
      lib/ts_bm: add helper to reduce indentation and improve readability

Lin Ma (1):
      netfilter: conntrack: validate cta_ip via parsing

Zhu Wang (1):
      nf_conntrack: fix -Wunused-const-variable=

 include/net/netlink.h                   | 10 +++-----
 lib/nlattr.c                            |  6 +++++
 lib/ts_bm.c                             | 43 +++++++++++++++++++++++----------
 net/netfilter/nf_conntrack_netlink.c    |  8 ++----
 net/netfilter/nf_conntrack_proto_dccp.c |  2 ++
 net/netfilter/nft_fib.c                 | 13 +++++-----
 net/netfilter/nft_lookup.c              |  6 ++---
 net/netfilter/nft_masq.c                |  8 +++---
 net/netfilter/nft_nat.c                 |  8 +++---
 net/netfilter/nft_redir.c               |  8 +++---
 10 files changed, 61 insertions(+), 51 deletions(-)

