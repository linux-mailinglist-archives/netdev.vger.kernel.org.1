Return-Path: <netdev+bounces-14436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BCB7414E7
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612DD280D6D
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925DC8DD;
	Wed, 28 Jun 2023 15:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43517C2D9;
	Wed, 28 Jun 2023 15:27:56 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F90268E;
	Wed, 28 Jun 2023 08:27:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qEX5D-00081m-Eo; Wed, 28 Jun 2023 17:27:51 +0200
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: "ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, dxu@dxuuu.xyz"@breakpoint.cc,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next v4 0/2] libbpf: add netfilter link attach helper
Date: Wed, 28 Jun 2023 17:27:36 +0200
Message-Id: <20230628152738.22765-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v4: address comment from Daniel Xu:
  - use human-readable test names in 2/2

v3: address comments from Andrii:
  - prune verbose error message in 1/2
  - use bpf_link_create internally in 1/2
  - use subtests in patch 2/2

When initial netfilter bpf program type support got added one
suggestion was to extend libbpf with a helper to ease attachment
of nf programs to the hook locations.

Add such a helper and a demo test case that attaches a dummy
program to various combinations.

I tested that the selftest fails when changing the expected
outcome (i.e., set 'success' when it should fail and v.v.).

Florian Westphal (2):
  tools: libbpf: add netfilter link attach helper
  selftests/bpf: Add bpf_program__attach_netfilter helper test

 tools/lib/bpf/bpf.c                           |  6 ++
 tools/lib/bpf/bpf.h                           |  6 ++
 tools/lib/bpf/libbpf.c                        | 42 +++++++++
 tools/lib/bpf/libbpf.h                        | 15 ++++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../bpf/prog_tests/netfilter_link_attach.c    | 86 +++++++++++++++++++
 .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
 7 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

-- 
2.39.3


