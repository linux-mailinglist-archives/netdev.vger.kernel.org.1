Return-Path: <netdev+bounces-121245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE395C55E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23C11F22CD1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22016F2F4;
	Fri, 23 Aug 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eagAVZar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B108768EC;
	Fri, 23 Aug 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394224; cv=none; b=QJSoFZMFqrsQIoV3nyc1TbmEl02Cr5U+fojReRTG6SvK509cSQ/ArlpqrTpOqM7N35KPjHvzR9qVBziKJ0lmhgj9bH8ASOkhXUqhCjbLA5WjVwgnGi/lOAJQEDfDIhbySQYGyMg2+cdw0g3B8ZJsWphwO9eP1FKoiK8hV1m3PCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394224; c=relaxed/simple;
	bh=z3mK0pnB6r8H+ole1+hP6AUNfokWAte8IJOO0j2aM/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLy/vu6p9zxiZnNPqJp+MpYeXlQ7Fz2Uuvehl07PLsobeZmq0mFSODoQAV1vTPQiKr16Tx2F4nEcl4q15/m7bX8QOiebGsrgWKfw0ilKmzckMb55Iw0atjlOAwqOCQSXwl5mUX/Lbmjbd5lCojDfQmZqa9Y4YZ6TzAtghNLiZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eagAVZar; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hNhusyVj8iKc3hNhvseTYx; Fri, 23 Aug 2024 08:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724394219;
	bh=iQq19mCMzjHlVz5sYuACQpPZfj10+p6o5t4TzgNeqWU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eagAVZar1w5/qoToACyJVPmFsMnkpiUJ3nMxa0YORqPpAOGiN3NhNERMirSyTDhlu
	 8zfDkP22Jkw61BF2iHWJFIHxg3a1K/yRZoXilQeP6RHzMQ0mG5W00qdJ8hOPBSxgyt
	 mYaykRy4ZeLLrr1HOW7F+PkyNBdA3SOJLTm4qqBzRPFV1ZrHq4DR3aak+u0ZE7kKwY
	 kyzlaHJtrmk8oRjx/5e3vrEVT0fLCFUa04ik8QQrN4L67cDTqHjJMC/Ibgib5Dhm2V
	 6cp9CCa/wYtZBxEcSf9wJ+5ZT3l77r4B7ppVGNTL5di2GhmJ79acVwqy6HaIYA1gQe
	 TcKlp8TmIyoGw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Aug 2024 08:23:39 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] idpf: Slightly simplify memory management in idpf_add_del_mac_filters()
Date: Fri, 23 Aug 2024 08:23:29 +0200
Message-ID: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In idpf_add_del_mac_filters(), filters are chunked up into multiple
messages to avoid sending a control queue message buffer that is too large.

Each chunk has up to IDPF_NUM_FILTERS_PER_MSG entries. So except for the
last iteration which can be smaller, space for exactly
IDPF_NUM_FILTERS_PER_MSG entries is allocated.

There is no need to free and reallocate a smaller array just for the last
iteration.

This slightly simplifies the code and avoid an (unlikely) memory allocation
failure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..b6f4b58e1094 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3669,12 +3669,15 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		entries_size = sizeof(struct virtchnl2_mac_addr) * num_entries;
 		buf_size = struct_size(ma_list, mac_addr_list, num_entries);
 
-		if (!ma_list || num_entries != IDPF_NUM_FILTERS_PER_MSG) {
-			kfree(ma_list);
+		if (!ma_list) {
 			ma_list = kzalloc(buf_size, GFP_ATOMIC);
 			if (!ma_list)
 				return -ENOMEM;
 		} else {
+			/* ma_list was allocated in the first iteration
+			 * so IDPF_NUM_FILTERS_PER_MSG entries are
+			 * available
+			 */
 			memset(ma_list, 0, buf_size);
 		}
 
-- 
2.46.0


