Return-Path: <netdev+bounces-278114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJiQMjwF3WkZZAkAu9opvQ
	(envelope-from <netdev+bounces-278114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C23EDA4F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5522300BBAB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC92271456;
	Mon, 13 Apr 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="tWPem7+r"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3C1096F;
	Mon, 13 Apr 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092471; cv=pass; b=FEq0CQPl4yRbF6oFNnG+l9WEhgDPJddfDfjqDM6i0PCIVur+L+kHA0NSicaGujQVvoaDoRW3LVO6vQeF+S+41jIE2EhvqrZynxB6N45tsNmB4Of2gdaREcJC3LnSVI5W78LiOY0Q9v/0JNUOBorZ7YDm41SRSe1PhfYCzA6UnyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092471; c=relaxed/simple;
	bh=yF1EOuSGbovi/OWyqyF20KilJgjRSzqfAfH2CoDWyMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EWvzZMuO2S2w/UdRgcCaKFeEfUV9XIugtl7MKq7pAOs36GiITdhcc5B0G7KmzJTVmzmEn1gx4pOlh14+K8wJD7BY0YjCPBhkOBiJXcp+uChbingG6kUsAVB+qvpot7B59hwRPXuK/np0D7r1YOZ+HHZv39tcJEHHFW9jggWBMY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=tWPem7+r; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1776092436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HCp6CLPPNiSF3liA/4Omngty6B+ulEsF/QWqJxYRu//l1jXcaWZ9LC1YTCmjOUbnQJMG+uRfXf5A/On1ZjxSc6y2V8Fsbf2BNAbN8kcZWTiVqkNJgE4n4+2Lfdt9R/K4/BKV26E42jQLqjQmVWTVS/T+1hNCD3hf/UTV7XjhCbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776092436; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GuZMQ4obIZBfLwzT7dBWa+wWhBwlSjqniuDoLorhniA=; 
	b=MALNYq6UMVrL7xvAfa4S10qJeShDwfzUqQ5AsieDixZ88vYxoH++3ZbjSLZDxaJH6S1Ob6hHkFowFHapAAXjxuvplb8P0rB9TVNLV0Qt5LG8WirWszTPRxLp9RowvH6k14zx9qFjB6K4pBeQIRpGt1nl1E/AA9l7dqrwA6fP+ek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776092436;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=GuZMQ4obIZBfLwzT7dBWa+wWhBwlSjqniuDoLorhniA=;
	b=tWPem7+rKELSJXTTak1d3EXPm64tq4CR6L0Zd812NuRFVzaQ4a20fYi+zDA5TCVi
	qMgCGK6eVNzkocaCR6aUBCzKhigMyYI42+Ai1wLk/jSF6DzhHCGh8UZaFtahiUlvwAh
	D1mLVgTucRxliLj+/Cxh2FDxEmQJBmxtgVYjVTQI=
Received: by mx.zohomail.com with SMTPS id 1776092434400296.8841184266247;
	Mon, 13 Apr 2026 08:00:34 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Jason@zx2c4.com,
	kuniyu@google.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+pFBD3bslSSshiJCd3rxy@syzkaller.appspotmail.com
Subject: [PATCH] wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit
Date: Mon, 13 Apr 2026 20:30:24 +0530
Message-Id: <20260413150024.1003490-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278114-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.zx2c4.com,vger.kernel.org,mpiric.us,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,pFBD3bslSSshiJCd3rxy];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C57C23EDA4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wg_netns_pre_exit() manually acquires rtnl_lock() inside the
pernet .pre_exit callback.  This causes a hung task when another
thread holds rtnl_mutex - the cleanup_net workqueue (or the
setup_net failure rollback path) blocks indefinitely in
wg_netns_pre_exit() waiting to acquire the lock.

Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
Add ->exit_rtnl() hook to struct pernet_operations."), where the
framework already holds RTNL and batches all callbacks under a
single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
window.

The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
because all RCU readers of creating_net either use maybe_get_net()
- which returns NULL for a dying namespace with zero refcount - or
access net->user_ns which remains valid throughout the entire
ops_undo_list sequence.

Reported-by: syzbot+pFBD3bslSSshiJCd3rxy@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 drivers/net/wireguard/device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..eb854c5294a3 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
 static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
-- 
2.34.1


