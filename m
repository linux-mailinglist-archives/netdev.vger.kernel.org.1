Return-Path: <netdev+bounces-31468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8111278E39A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB3328121A
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 23:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3018F4E;
	Wed, 30 Aug 2023 23:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FC8F47
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 23:59:43 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C04CD6;
	Wed, 30 Aug 2023 16:59:41 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 0/5] Netfilter fixes for net
Date: Thu, 31 Aug 2023 01:59:30 +0200
Message-Id: <20230830235935.465690-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

The following patchset contains Netfilter fixes for net:

1) Fix mangling of TCP options with non-linear skbuff, from Xiao Liang.

2) OOB read in xt_sctp due to missing sanitization of array length field.
   From Wander Lairson Costa.

3) OOB read in xt_u32 due to missing sanitization of array length field.
   Also from Wander Lairson Costa.

All of them above, always broken for several releases.

4) Missing audit log for set element reset command, from Phil Sutter.

5) Missing audit log for rule reset command, also from Phil.

These audit log support are missing in 6.5.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-08-31

Thanks.

----------------------------------------------------------------

The following changes since commit bd6c11bc43c496cddfc6cf603b5d45365606dbd5:

  Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-08-29 11:33:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-08-31

for you to fetch changes up to ea078ae9108e25fc881c84369f7c03931d22e555:

  netfilter: nf_tables: Audit log rule reset (2023-08-31 01:29:28 +0200)

----------------------------------------------------------------
netfilter pull request 23-08-31

----------------------------------------------------------------
Phil Sutter (2):
      netfilter: nf_tables: Audit log setelem reset
      netfilter: nf_tables: Audit log rule reset

Wander Lairson Costa (2):
      netfilter: xt_sctp: validate the flag_info count
      netfilter: xt_u32: validate user space input

Xiao Liang (1):
      netfilter: nft_exthdr: Fix non-linear header modification

 include/linux/audit.h         |  2 ++
 kernel/auditsc.c              |  2 ++
 net/netfilter/nf_tables_api.c | 49 ++++++++++++++++++++++++++++++++++++++++---
 net/netfilter/nft_exthdr.c    | 20 +++++++-----------
 net/netfilter/xt_sctp.c       |  2 ++
 net/netfilter/xt_u32.c        | 21 +++++++++++++++++++
 6 files changed, 81 insertions(+), 15 deletions(-)

