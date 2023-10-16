Return-Path: <netdev+bounces-41313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B247CA8DC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705801C20B4A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506822772D;
	Mon, 16 Oct 2023 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA727719
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:09:27 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19099D9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:09:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ce84:d8c0:f79a:fa0])
	by albert.telenet-ops.be with bizsmtp
	id yd9L2A00W0pDX7N06d9MDP; Mon, 16 Oct 2023 15:09:23 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qsNLR-006jYs-DZ;
	Mon, 16 Oct 2023 15:09:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qsNLU-00A9nT-Ox;
	Mon, 16 Oct 2023 15:09:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v3 0/2] sunrpc: Fix W=1 compiler warnings
Date: Mon, 16 Oct 2023 15:09:17 +0200
Message-Id: <cover.1697460614.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

	Hi all,

This patch series fixes W=1 compiler warnings in sunrpc, related to
variables that are used only when debugging is enabled.

Changes compared to v2:
  - New patch "sunrpc: Wrap read accesses to rpc_task.tk_pid",
  - Add Acked-by.

Changes compared to v1:
  - s/uncontionally/unconditionally/,
  - Drop CONFIG_SUNRPC_DEBUG check in fs/lockd/svclock.c to fix build
    failure.

Thanks for your comments!

Geert Uytterhoeven (2):
  sunrpc: Wrap read accesses to rpc_task.tk_pid
  sunrpc: Use no_printk() in dfprintk*() dummies

 fs/lockd/svclock.c                     |  2 --
 fs/nfs/filelayout/filelayout.c         | 12 ++++++------
 fs/nfs/flexfilelayout/flexfilelayout.c |  9 +++------
 include/linux/sunrpc/debug.h           |  6 +++---
 include/linux/sunrpc/sched.h           | 10 ++++++++++
 net/sunrpc/clnt.c                      |  2 +-
 net/sunrpc/debugfs.c                   |  2 +-
 7 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

