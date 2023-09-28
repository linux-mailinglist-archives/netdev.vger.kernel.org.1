Return-Path: <netdev+bounces-36849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C17B2013
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 77CE528296D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5C3FB3A;
	Thu, 28 Sep 2023 14:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013D38BD6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:49:28 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DBF195;
	Thu, 28 Sep 2023 07:49:26 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qlsKO-0005Ty-TE; Thu, 28 Sep 2023 16:49:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 0/4] netfilter updates for net-next
Date: Thu, 28 Sep 2023 16:48:57 +0200
Message-ID: <20230928144916.18339-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

This small batch contains updates for the net-next tree.

First patch, from myself, is a bug fix. The issue (connect timeout) is
ancient, so I think its safe to give this more soak time given the esoteric
conditions needed to trigger this.
Also updates the existing selftest to cover this.

Add netlink extacks when an update references a non-existent
table/chain/set.  This allows userspace to provide much better
errors to the user, from Pablo Neira Ayuso.

Last patch adds more policy checks to nf_tables as a better
alternative to the existing runtime checks, from Phil Sutter.

The following changes since commit 19f5eef8bf732406415b44783ea623e3a31c34c9:

  MAINTAINERS: Add an obsolete entry for LL TEMAC driver (2023-09-28 15:55:14 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-23-09-28

for you to fetch changes up to 013714bf3e125a218bb02c938ff6df348dda743e:

  netfilter: nf_tables: Utilize NLA_POLICY_NESTED_ARRAY (2023-09-28 16:31:29 +0200)

----------------------------------------------------------------
netfilter pull request 2023-09-28

----------------------------------------------------------------
Florian Westphal (2):
      netfilter: nf_nat: undo erroneous tcp edemux lookup after port clash
      selftests: netfilter: test nat source port clash resolution interaction with tcp early demux

Pablo Neira Ayuso (1):
      netfilter: nf_tables: missing extended netlink error in lookup functions

Phil Sutter (1):
      netfilter: nf_tables: Utilize NLA_POLICY_NESTED_ARRAY

 net/netfilter/nf_nat_proto.c                       | 64 +++++++++++++++++++++-
 net/netfilter/nf_tables_api.c                      | 43 ++++++++++-----
 tools/testing/selftests/netfilter/nf_nat_edemux.sh | 46 +++++++++++++---
 3 files changed, 126 insertions(+), 27 deletions(-)

