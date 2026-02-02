Return-Path: <netdev+bounces-255783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALfWNeZkgGml7gIAu9opvQ
	(envelope-from <netdev+bounces-255783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:48:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F1BC9CCB
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E4E300D72A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B328B3E7;
	Mon,  2 Feb 2026 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsmE26uI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013241DF987
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022116; cv=none; b=qvlGGt/ZSqop83tnMPjQ7tQPBGHtRclg66fi2kuh34e+uIJHO5sUh/efcyCVj9XQ26iJCetu5jAh30CIb+18+VpyolrZ/0LC3724GMtnYrsZfwK9fI6M2s4lk8XsJwBPzlBxHDq2QpqVRBFYa1psOy/ocmnM8HsoIr4z4x7dFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022116; c=relaxed/simple;
	bh=DmkFICASqUCuaw1zsTrqq3F5bMziojXG5teY9pvx6LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ondW7s2tcUkJCTI8KDasa4DOvi2KFiPkqc/dFGbkJ93VtQXQBBSLTOrVbeKCSEeoltFTqe+inH8/0pVAaWQ6F86W4eSZ3unHRcVc+R2/YXIpIOl8nZE0J5LVzo9PYxsfxLVfNpjg0CEipKJl2pAvhcEGX4XEwYp8QsxtkegxS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsmE26uI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770022113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HTwQrQT+ZoBH+fw1ExFDWdLwscSVJv6fNBdaB+KAnVs=;
	b=EsmE26uIYa7Er0JUyVQSPPtIDztuEI2LeqbnLUny1bNJmVGwkTxT/Jua8zYlZg76UeOydf
	9bsHp8g0y8mQo/zpguqitFsTGDDeo5eetQKZ9KlXRcFsU562F8+qPGbc+NC5LPx3YOgaMw
	l26gGHfrNMd9gfVSDmD+SehoHIF30pI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-t_tByHraPmeWlBukj8Y70w-1; Mon,
 02 Feb 2026 03:48:29 -0500
X-MC-Unique: t_tByHraPmeWlBukj8Y70w-1
X-Mimecast-MFC-AGG-ID: t_tByHraPmeWlBukj8Y70w_1770022108
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED371180047F;
	Mon,  2 Feb 2026 08:48:27 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 146911956053;
	Mon,  2 Feb 2026 08:48:23 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	mschmidt@redhat.com,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: fix deadlock in reset handling
Date: Mon,  2 Feb 2026 09:48:20 +0100
Message-ID: <20260202084820.260033-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255783-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 85F1BC9CCB
X-Rspamd-Action: no action

Three driver callbacks schedule a reset and wait for its completion:
ndo_change_mtu(), ethtool set_ringparam(), and ethtool set_channels().

Waiting for reset in ndo_change_mtu() and set_ringparam() was added by
commit c2ed2403f12c74 ("iavf: Wait for reset in callbacks which trigger
it") to fix a race condition where adding an interface to bonding
immediately after MTU or ring parameter change failed because the
interface was still in __RESETTING state. The same commit also added
waiting in iavf_set_priv_flags(), which was later removed by commit
53844673d55529 ("iavf: kill "legacy-rx" for good").

Waiting in set_channels() was introduced earlier by commit 4e5e6b5d9d13
("iavf: Fix return of set the new channel count") to ensure the PF has
enough time to complete the VF reset when changing channel count, and to
return correct error codes to userspace.

Commit ef490bbb226702 ("iavf: Add net_shaper_ops support") added
net_shaper_ops to iavf, which required reset_task to use _locked NAPI
variants (napi_enable_locked, napi_disable_locked) that need the netdev
instance lock.

Later, commit 7e4d784f5810 ("net: hold netdev instance lock during
rtnetlink operations") and commit 2bcf4772e45adb ("net: ethtool: try to
protect all callback with netdev instance lock") started holding the
netdev instance lock during ndo and ethtool callbacks for drivers with
net_shaper_ops.

The combination of waiting for reset and the new locking requirements
creates a deadlock: the callback holds the lock and waits for reset_task,
but reset_task is blocked waiting for the same lock:

  Thread 1 (callback)               Thread 2 (reset_task)
  -------------------               ---------------------
  netdev_lock()
  ndo_change_mtu() or ethtool op
    iavf_schedule_reset()
    iavf_wait_for_reset()           iavf_reset_task()
      waiting...                      netdev_lock() <- DEADLOCK

Reproducer:

  # echo 16 > /sys/class/net/$PF/device/sriov_numvfs
  # ip link set $VF up
  # ip link set $VF mtu 5000
  RTNETLINK answers: Device or resource busy

  # dmesg | tail -1
  iavf: MTU change interrupted waiting for reset

Fix this by temporarily releasing the lock while waiting for reset to
complete. This follows the pattern used elsewhere in the kernel (e.g.,
do_set_master() releases rtnl_lock before calling ndo_add_slave()).

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8aa6e92c16431f..d7738fb8fa60bc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -189,13 +189,22 @@ static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
  * iavf_wait_for_reset - Wait for reset to finish.
  * @adapter: board private structure
  *
+ * The iavf driver selects NET_SHAPER, so callbacks that trigger reset are
+ * always called with netdev instance lock held, while reset_task also needs
+ * this lock. Release the lock while waiting to avoid deadlock.
+ *
  * Returns 0 if reset finished successfully, negative on timeout or interrupt.
  */
 int iavf_wait_for_reset(struct iavf_adapter *adapter)
 {
-	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
-					!iavf_is_reset_in_progress(adapter),
-					msecs_to_jiffies(5000));
+	struct net_device *netdev = adapter->netdev;
+	int ret;
+
+	netdev_unlock(netdev);
+	ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
+					       !iavf_is_reset_in_progress(adapter),
+					       msecs_to_jiffies(5000));
+	netdev_lock(netdev);
 
 	/* If ret < 0 then it means wait was interrupted.
 	 * If ret == 0 then it means we got a timeout while waiting
-- 
2.52.0


