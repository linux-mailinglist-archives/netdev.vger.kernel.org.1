Return-Path: <netdev+bounces-96430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E067C8C5C26
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262131C21A7A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7418131E;
	Tue, 14 May 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="N6c6ioH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F492AF09
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717804; cv=none; b=Msu1FI5XhkcwaqFmgygdlnawkXPUUZ1XyagW93crsJNNZN9SXk11DWV2zlIsHs9wsfDZv8ZlR8sKBOpaY6y9ApryqKnFr93mXva3NehoVuPqmcYwdTStgpQXJLG7pKRwNde1958pWRAiwjsDYDDDHto096xEVliieASKavCRIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717804; c=relaxed/simple;
	bh=KPoIrVTlqJASUyZenFkCWNjMaBPiZy28O19tkBzTlgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=c/+j5v8Ds56otDLTh3J0wrNQ7x9i/dsDIi3Ge0Hcn19rnslpAefVSiqfUnRSwJYHNjgRLLozSf3kK5M73uSbNXCxO1ZZRg6oZ2zZQjC4hPQGT10PfIS5Ojfg4e4i9jJ3+XP+1XvHL4k02RlmSEzD+EfMLxN4YYX07VI2w3PIZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=N6c6ioH8; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1715716675-1cf439709d7cc90001-BZBGGp
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id Nkf4KQ3CSO9wSgX1; Tue, 14 May 2024 15:58:17 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=ueMObw3WGkxRrJSejoNY6zp9+2a0e8jj8V1NHQ2LHZQ=;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
	MIME-Version:Date:Message-ID; b=N6c6ioH8bqI+/u3+D8Gif0XhJhbvoM/std3NHdGUtxd2T
	K2GKljvRctzVHzQ6Y6w6egkCKObIJyT6zNYp+82sLxk0EyfIiS4GGmV7K/lQixywQOZ2gkuuKROdO
	QENgV1VjMAlOBjSbFt6uvNvL4fLQwiOP6zpaAnCivIL6CPfq8=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13280368; Tue, 14 May 2024 15:57:26 -0400
Message-ID: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Tue, 14 May 2024 15:57:29 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, Zhengchao Shao <shaozhengchao@huawei.com>,
 netdev@vger.kernel.org
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH net] bonding: fix oops during rmmod
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH net] bonding: fix oops during rmmod
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1715716697
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3101

"rmmod bonding" causes an oops ever since commit cc317ea3d927 ("bonding:
remove redundant NULL check in debugfs function").  Here are the relevant
functions being called:

bonding_exit()
  bond_destroy_debugfs()
    debugfs_remove_recursive(bonding_debug_root);
    bonding_debug_root = NULL; <--------- SET TO NULL HERE
  bond_netlink_fini()
    rtnl_link_unregister()
      __rtnl_link_unregister()
        unregister_netdevice_many_notify()
          bond_uninit()
            bond_debug_unregister()
              (commit removed check for bonding_debug_root == NULL)
              debugfs_remove()
              simple_recursive_removal()
                down_write() -> OOPS

However, reverting the bad commit does not solve the problem completely
because the original code contains a race that could cause the same
oops, although it was much less likely to be triggered unintentionally:

CPU1
  rmmod bonding
    bonding_exit()
      bond_destroy_debugfs()
        debugfs_remove_recursive(bonding_debug_root);

CPU2
  echo -bond0 > /sys/class/net/bonding_masters
    bond_uninit()
      bond_debug_unregister()
        if (!bonding_debug_root)

CPU1
        bonding_debug_root = NULL;

So do NOT revert the bad commit (since the removed checks were racy
anyway), and instead change the order of actions taken during module
removal.  The same oops can also happen if there is an error during
module init, so apply the same fix there.

Fixes: cc317ea3d927 ("bonding: remove redundant NULL check in debugfs function")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/net/bonding/bond_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2c5ed0a7cb18..bceda85f0dcf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6477,16 +6477,16 @@ static int __init bonding_init(void)
 	if (res)
 		goto out;
 
+	bond_create_debugfs();
+
 	res = register_pernet_subsys(&bond_net_ops);
 	if (res)
-		goto out;
+		goto err_net_ops;
 
 	res = bond_netlink_init();
 	if (res)
 		goto err_link;
 
-	bond_create_debugfs();
-
 	for (i = 0; i < max_bonds; i++) {
 		res = bond_create(&init_net, NULL);
 		if (res)
@@ -6501,10 +6501,11 @@ static int __init bonding_init(void)
 out:
 	return res;
 err:
-	bond_destroy_debugfs();
 	bond_netlink_fini();
 err_link:
 	unregister_pernet_subsys(&bond_net_ops);
+err_net_ops:
+	bond_destroy_debugfs();
 	goto out;
 
 }
@@ -6513,11 +6514,11 @@ static void __exit bonding_exit(void)
 {
 	unregister_netdevice_notifier(&bond_netdev_notifier);
 
-	bond_destroy_debugfs();
-
 	bond_netlink_fini();
 	unregister_pernet_subsys(&bond_net_ops);
 
+	bond_destroy_debugfs();
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	/* Make sure we don't have an imbalance on our netpoll blocking */
 	WARN_ON(atomic_read(&netpoll_block_tx));

base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
2.25.1


