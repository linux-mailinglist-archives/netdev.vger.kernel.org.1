Return-Path: <netdev+bounces-14154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1973F4DB
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D9280E2A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788579FD;
	Tue, 27 Jun 2023 06:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6779F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:53:28 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9892D2136;
	Mon, 26 Jun 2023 23:53:09 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 0/6] Netfilter fixes for net
Date: Tue, 27 Jun 2023 08:52:58 +0200
Message-Id: <20230627065304.66394-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

The following patchset contains Netfilter fixes for net:

1) Reset shift on Boyer-Moore string match for each block,
   from Jeremy Sowden.

2) Fix acccess to non-linear area in DCCP conntrack helper,
   from Florian Westphal.

3) Fix kernel-doc warnings, by Randy Dunlap.

4) Bail out if expires= does not show in SIP helper message,
   or make ct_sip_parse_numerical_param() tristate and report
   error if expires= cannot be parsed.

5) Unbind non-anonymous set in case rule construction fails.

6) Fix underflow in chain reference counter in case set element
   already exists or it cannot be created.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-06-27

Thanks.

----------------------------------------------------------------

The following changes since commit 6709d4b7bc2e079241fdef15d1160581c5261c10:

  net: nfc: Fix use-after-free caused by nfc_llcp_find_local (2023-06-26 10:57:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-06-27

for you to fetch changes up to b389139f12f287b8ed2e2628b72df89a081f0b59:

  netfilter: nf_tables: fix underflow in chain reference counter (2023-06-26 17:18:55 +0200)

----------------------------------------------------------------
netfilter pull request 23-06-27

----------------------------------------------------------------
Florian Westphal (1):
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Pablo Neira Ayuso (2):
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails
      netfilter: nf_tables: fix underflow in chain reference counter

Randy Dunlap (1):
      linux/netfilter.h: fix kernel-doc warnings

 include/linux/netfilter.h               |  4 +--
 lib/ts_bm.c                             |  4 ++-
 net/netfilter/nf_conntrack_proto_dccp.c | 52 +++++++++++++++++++++++++++++++--
 net/netfilter/nf_conntrack_sip.c        |  2 +-
 net/netfilter/nf_tables_api.c           |  6 +++-
 5 files changed, 60 insertions(+), 8 deletions(-)

