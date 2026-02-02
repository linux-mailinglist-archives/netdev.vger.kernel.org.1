Return-Path: <netdev+bounces-255927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFr9OXLQgGlBBwMAu9opvQ
	(envelope-from <netdev+bounces-255927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:27:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EACEF37
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71EA30427C1
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2FB2765C3;
	Mon,  2 Feb 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Agq9KvgT"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62E23C4E9
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049118; cv=none; b=dGXuUVLMLy6je4z46jehbf5SHgsCQa5U0PTFRobD9zoIsjA+Y4eiYH/+nWoGleguyEPBZJR5yFbqrRWDztG9Z3Y3VPTjdLLgNpVkQlqSuBq4t5zFvNcvJc28lxTrf7qzuqg12zHCGxCIZtV/q7f3FZNgGTLlUJbS6tNE6Jw0GS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049118; c=relaxed/simple;
	bh=b8Z3/LKuA+OW063oB2bh8WJdnmTEl/LI0BKNPYDDaZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ru+hcnGmL/9HvwhY7fdXiMBS7cFP8kmyd37tYS62cAtvoShCt7z9uEqwq8ERoWqDJ5W6pKvQlEsaPk57OU+Jw+fqQY/zmtMM5PvR27pE8lqL066A3nmk2Ic429AYzeOm5tNyAlFLV6mRa9i+cK2P6FN14be+dhsNH5DZK0b8ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Agq9KvgT; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 612GIRwd025215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Feb 2026 01:18:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=1rZ2SEYb9Cchgc3kP9Zh8vieF6lrwjUU6HQCddLtTBk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770049108; v=1;
        b=Agq9KvgTjCzE3Mg3Gg3RuebX3twA/tQPT6qwicWfwyXycOuUHLLkVYUhfUBpY+Wz
         uGs0sFMNPB87h4kAXxnrekCohRm1pi3sZzo6FaJ3THUpuJee4l4NTlm0hjEfqApn
         2Rxghv1aSYaIT2XSdC2touXJ0yt6C4omirerbeJaedBO6iiT3DBfaRkCJSvQ6xdD
         ypxwWEoy4Kc2KZ9vb/DH5Y3SLmdUMPo0BppWQGK/XNVfeyV4SxwJe/WG9ISY+y/I
         F6nZ1SRyDbTAVrHMoTDa3PAF60SyG1woCR3EMTQMj6JGaseYEqXAQ4UQh7RRytCu
         NPnMEO5VVPLBJB8Dwe7qPw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when changing RX queue length
Date: Mon,  2 Feb 2026 16:17:14 +0000
Message-ID: <20260202161826.114393-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255927-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 465EACEF37
X-Rspamd-Action: no action

When changing RX queue length via 'ethtool -G $DEV rx $NUM', a WARNING
indicates the driver missed unregistering xdp_rxq_info [1], and then
NULL pointer dereference panics the kernel. [2]

The following sequence in ice_set_ringparam() triggers this bug.
1. Allocate new rx_rings
2. rx_rings[i] = *vsi->rx_rings[i];
3. ice_down() unregisters vsi->rx_rings[i]->xdp_rxq
4. ice_up() registers rx_ring[i]->xdp_rxq
   a. __xdp_rxq_info_reg() sees the copied state REG_STATE_REGISTERED
      and calls xdp_rxq_info_unreg() to fix it [1]
   b. xdp_unreg_mem_model() looks up the stale mem.id in rhashtable,
      which was already removed in step 3, causing NULL dereference [2]

The root cause is that struct copying includes xdp_rxq_info which
contains registration state that should not be duplicated.

Fix by clearing xdp_rxq_info after copying the ring so it starts with
REG_STATE_NEW instead of the stale REG_STATE_REGISTERED.

[1]
 Missing unregister, handled but fix driver
 WARNING: net/core/xdp.c:182 at __xdp_rxq_info_reg+0x89/0x150, CPU#4: ethtool/1105
 [...]
 RIP: 0010:__xdp_rxq_info_reg+0x89/0x150
 [...]
 Call Trace:
  <TASK>
  ice_queue_mem_alloc+0x159/0x240
  ice_vsi_cfg_rxq+0xc3/0x160
  ice_vsi_cfg_rxqs+0x4f/0x70
  ice_up+0xd/0x20
  ice_set_ringparam+0x34f/0x4e0

[2]
 BUG: kernel NULL pointer dereference, address: 0000000000000008
 [...]
 RIP: 0010:xdp_unreg_mem_model+0x113/0x340
 [...]
 Call Trace:
  <TASK>
  __xdp_rxq_info_reg+0xfd/0x150
  ice_queue_mem_alloc+0x159/0x240
  ice_vsi_cfg_rxq+0xc3/0x160
  ice_vsi_cfg_rxqs+0x4f/0x70
  ice_up+0xd/0x20
  ice_set_ringparam+0x34f/0x4e0

Fixes: 111a8e2be488 ("ice: implement Rx queue management ops")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
I see the Fixes: commit exists in only tnguy/next-queue.git, so I'm
sending this patch to iwl-next, not iwl-net.

Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
the commit hash will be stale soon, and I don't know how to handle this.

I'd appreciate it if iwl-folks know the way to handle it. Thanks!
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ddd252fb1124..e4c286a22ff5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3338,6 +3338,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
+		memset(&rx_rings[i].xdp_rxq, 0, sizeof(rx_rings[i].xdp_rxq));
 
 		/* this is to allow wr32 to have something to write to
 		 * during early allocation of Rx buffers
-- 
2.51.0


