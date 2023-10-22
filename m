Return-Path: <netdev+bounces-43321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298AF7D25DB
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6891C20A48
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454013AC3;
	Sun, 22 Oct 2023 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58889125D9
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:25:53 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C7FAF2
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:25:51 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: osmocom-net-gprs@lists.osmocom.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	laforge@gnumonks.org
Subject: [PATCH net 0/2] GTP tunnel driver fixes
Date: Sun, 22 Oct 2023 22:25:16 +0200
Message-Id: <20231022202519.659526-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains two fixes for the GTP tunnel driver:

1) Incorrect GTPA_MAX definition in UAPI headers. This is updating an
   existing UAPI definition but for a good reason, this is certainly
   broken. Similar fixes for incorrect _MAX definition in netlink
   headers were applied in the past too.

2) Fix GTP driver PMTU with GRO packets, add missing call to
   skb_gso_validate_network_len() to handle GRO packets.

Please apply, Thanks.

Pablo Neira Ayuso (2):
  gtp: uapi: fix GTPA_MAX
  gtp: fix fragmentation needed check with gso

 drivers/net/gtp.c        | 5 +++--
 include/uapi/linux/gtp.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.30.2


