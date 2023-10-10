Return-Path: <netdev+bounces-39585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DEB7BFFBB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D044281C2C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16124C7D;
	Tue, 10 Oct 2023 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA1200DC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:01 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699DAC;
	Tue, 10 Oct 2023 07:53:59 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7H-0001Ne-Lp; Tue, 10 Oct 2023 16:53:47 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 0/8] netfilter updates for next
Date: Tue, 10 Oct 2023 16:53:30 +0200
Message-ID: <20231010145343.12551-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

The following request contains updates for your *net-next* tree.

First 5 patches, from Phil Sutter, clean up nftables dumpers to
use the context buffer in the netlink_callback structure rather
than a kmalloc'd buffer.

Patch 6, from myself, zaps dead code and replaces the helper function
with a small inlined helper.

Patch 7, also from myself, removes another pr_debug and replaces it
with the existing nf_log-based debug helpers.

Last patch, from George Guo, gets nft_table comments back in
sync with the structure members.

The following changes since commit f0107b864f004bc6fa19bf6d5074b4a366f3e16a:

  atm: fore200e: Drop unnecessary of_match_device() (2023-10-10 12:41:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-23-10-10

for you to fetch changes up to 94ecde833be5779f8086c3a094dfa51e1dbce75f:

  netfilter: cleanup struct nft_table (2023-10-10 16:34:28 +0200)

----------------------------------------------------------------
netfilter net-next pull request 2023-10-10

----------------------------------------------------------------
Florian Westphal (2):
      netfilter: conntrack: simplify nf_conntrack_alter_reply
      netfilter: conntrack: prefer tcp_error_log to pr_debug

George Guo (1):
      netfilter: cleanup struct nft_table

Phil Sutter (5):
      netfilter: nf_tables: Always allocate nft_rule_dump_ctx
      netfilter: nf_tables: Drop pointless memset when dumping rules
      netfilter: nf_tables: Carry reset flag in nft_rule_dump_ctx
      netfilter: nf_tables: Carry s_idx in nft_rule_dump_ctx
      netfilter: nf_tables: Don't allocate nft_rule_dump_ctx

 include/net/netfilter/nf_conntrack.h   | 14 ++++--
 include/net/netfilter/nf_tables.h      |  5 ++-
 net/netfilter/nf_conntrack_core.c      | 18 --------
 net/netfilter/nf_conntrack_helper.c    |  7 +--
 net/netfilter/nf_conntrack_proto_tcp.c |  7 +--
 net/netfilter/nf_tables_api.c          | 80 +++++++++++++---------------------
 6 files changed, 50 insertions(+), 81 deletions(-)

