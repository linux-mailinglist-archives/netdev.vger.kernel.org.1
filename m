Return-Path: <netdev+bounces-269096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLEINKDbummfcgIAu9opvQ
	(envelope-from <netdev+bounces-269096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:06:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D42BFE8C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E3532951BF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DD3A9608;
	Wed, 18 Mar 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P18TX5YL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sxfKXhqM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FD3101B8
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849504; cv=none; b=dBPrjx4aOmxU1Q3BVd9sgphCZ8gMakyTY8H1d7kOVLPVDObB1FP2oJaLWFZK68SKuDHdFjN18rpNnZuUDCNQNfHQjpXUqU/cHTbB83PWA20AA9CanZUwGERtVUmf9ai8agRbWzzbMBgfWknLF3yRysmbs/6JRxmSl6NfHBCMouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849504; c=relaxed/simple;
	bh=M6sqFlUOY20hvUySeVxukwiG5GGP2gqCZbZV5+uYIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mN2b/FCk0LIa9ofshfpOhd9mDuP3Av+UV2bGl9vE1cSfoAjMYjrYvBvMEzkal3DGVR31qTgJrDYZlBSR/B7BR2zKsTa3t9pWHm12p3HeRn+6G9fXXi4THDzE6VWvUI6vlZVWsoCtzUVx1ml0IPHqpwtbrvXh4J4kZFNIHwtBxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P18TX5YL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sxfKXhqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773849497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5aJP2sYwPoJ8gxJ8rE0z1ERasHV1dH20ZyzElyHL9Uw=;
	b=P18TX5YLMjsIMLUiv55MvO8LV0Nmf7cAuM6zTeC2ARwnzQKhfiwbi5nXn56bXjVipDJAay
	OVWbghyFP/kaFcKOHj0VcAHodx6Jh2iNuDAIOz8Qh3+V5C5Sg5y1CP0Z0C1Hl90WUcS7en
	cEwqgL1tGKtsipaRTzfiClyeXPH9OhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-oJUyuDYJM1Wl7C7F7ajESA-1; Wed, 18 Mar 2026 11:58:15 -0400
X-MC-Unique: oJUyuDYJM1Wl7C7F7ajESA-1
X-Mimecast-MFC-AGG-ID: oJUyuDYJM1Wl7C7F7ajESA_1773849494
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso91642015e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773849494; x=1774454294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aJP2sYwPoJ8gxJ8rE0z1ERasHV1dH20ZyzElyHL9Uw=;
        b=sxfKXhqMPlbgVbxM3NJuTVwLIWwbjubcXI39uGTYs1aKPxYj92Ep9zXeagnWESj3LF
         NUmKidgL3krrHWHsbH/a3nkJKJ9SD/dimbm0OPAQdOV1xqTlc3zy9S6/YIJ3gHLueHLC
         MjhqqWQxM9qGHGbY7aX2hZ0Y8RmpwC7KRwapTscMETeU+k2HvFLQE6OVdqUHRrEsKITX
         2JU4dCDZ9N42ppZfWeZ88FcL2Zi7qlEQ+3iDfCG6C97ze/qeNHDlnta3sRmlUSDF4SsE
         J8ospZJIczib0Ch9Ad8hWinvDjl4/eyg48SZuGQrleRAsqibZYfniGHM30zGz+85yEuF
         JVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849494; x=1774454294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aJP2sYwPoJ8gxJ8rE0z1ERasHV1dH20ZyzElyHL9Uw=;
        b=ktfb2NUK0oP1ERtL1tR1cTKGt10EYkz7w9wSzEqb9y+zbzcsc31IbZmlvrTwqx4Mtv
         UtgTPG1iJz3jiyKwaq32ouXgClWEB+gbZBojNfTd7wh+nkiGpXAQSngqDh9x5Or+b/kv
         wKKs72CCxGa7Tdu82dHdFKanDSlQMSZhDj7aInghks8o+v98HkW4ZKpYeh8cjkXI7H3h
         Cn/r+oTL6KrYStJgUU+Z5XIs9e20LUIRbJO0vq5iKoQh4CWUh587089ZsvKBrynLCN68
         rKYE5kfuN/GkCaqsgT+UVwrqm+1WJ6hgF5MXO+kkTOLe319HXm9axB9DcVInymuwXDIr
         lS2g==
X-Forwarded-Encrypted: i=1; AJvYcCVICnkHej3oDsgoLATM5bd1FtCtF7xQ/PdgHwfRUT9VZ7at4wcs42OgZ+GCZtPhhrO6mu3Vbrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZN8sdzK9duy0jZa+cwTVVxrsVJ7BKCbjdolWJRuRhh8X1CvV
	quFIHGeStGDZqUF7qGIKrHFjGbDf2XiY/XImwd8CPjDWyMT3Yy721zRNoe10iB3ZoSj6utIwtQU
	EclNdbXJbyHIs/YSPi4wYtXmCLL1iw7krAEgNZglmCGuoKU4ExnsuPc4NyA==
X-Gm-Gg: ATEYQzxP0puLhuCejUSrLh9ekUKTqJ6irwzJ/1hFXfeZWQuonhFx+Kd1feu//NsrTCD
	VmNV6BAfMZaCYmAzea/aKpfzi22y0HAkR8+jHUxokkTVXeT1RW4EMNkbUlVhJaXBUyEkGLX0ZcN
	r9p1k2PUaEIzON/rBqVMcdEEqt0h7zw5QbC/GREKO07PMrCb2QsRSRxB1Gsp4cUQE+DryRUdVjs
	qqsQMSdtpnGgvxjElsyWT/yMn6XQt0mkgKzkK1t/iAQ0HFl/I0nov1yEQSXCBf73/EZiAzrE7Ea
	DYmnablq1n8H3t74MDtwRxOQB7h6q3W4I4XYwDEZ95+T/cpnEKQdaEwfGVmBf8uSdVy5FVI1UFX
	3amCfnur5Sstv/2moeeNWcv3/nXPg1gwDyfSHHSiu2Iu+sNwW
X-Received: by 2002:a05:600c:a4b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486f446af0bmr60719335e9.19.1773849494013;
        Wed, 18 Mar 2026 08:58:14 -0700 (PDT)
X-Received: by 2002:a05:600c:a4b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486f446af0bmr60718735e9.19.1773849493380;
        Wed, 18 Mar 2026 08:58:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm234105e9.9.2026.03.18.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:58:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CA2195A31F8; Wed, 18 Mar 2026 16:58:11 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Minxi Hou <mhou@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net] net: openvswitch: Avoid releasing netdev before teardown completes
Date: Wed, 18 Mar 2026 16:55:51 +0100
Message-ID: <20260318155554.1133405-1-toke@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269096-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 622D42BFE8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The patch cited in the Fixes tag below changed the teardown code for
OVS ports to no longer unconditionally take the RTNL. After this change,
the netdev_destroy() callback can proceed immediately to the call_rcu()
invocation if the IFF_OVS_DATAPATH flag is already cleared on the
netdev.

The ovs_netdev_detach_dev() function clears the flag before completing
the unregistration, and if it gets preempted after clearing the flag (as
can happen on an -rt kernel), netdev_destroy() can complete and the
device can be freed before the unregistration completes. This leads to a
splat like:

[  998.393867] Oops: general protection fault, probably for non-canonical address 0xff00000001000239: 0000 [#1] SMP PTI
[  998.393877] CPU: 42 UID: 0 PID: 55177 Comm: ip Kdump: loaded Not tainted 6.12.0-211.1.1.el10_2.x86_64+rt #1 PREEMPT_RT
[  998.393886] Hardware name: Dell Inc. PowerEdge R740/0JMK61, BIOS 2.24.0 03/27/2025
[  998.393889] RIP: 0010:dev_set_promiscuity+0x8d/0xa0
[  998.393901] Code: 00 00 75 d8 48 8b 53 08 48 83 ba b0 02 00 00 00 75 ca 48 83 c4 08 5b c3 cc cc cc cc 48 83 bf 48 09 00 00 00 75 91 48 8b 47 08 <48> 83 b8 b0 02 00 00 00 74 97 eb 81 0f 1f 80 00 00 00 00 90 90 90
[  998.393906] RSP: 0018:ffffce5864a5f6a0 EFLAGS: 00010246
[  998.393912] RAX: ff00000000ffff89 RBX: ffff894d0adf5a05 RCX: 0000000000000000
[  998.393917] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff894d0adf5a05
[  998.393921] RBP: ffff894d19252000 R08: ffff894d19252000 R09: 0000000000000000
[  998.393924] R10: ffff894d19252000 R11: ffff894d192521b8 R12: 0000000000000006
[  998.393927] R13: ffffce5864a5f738 R14: 00000000ffffffe2 R15: 0000000000000000
[  998.393931] FS:  00007fad61971800(0000) GS:ffff894cc0140000(0000) knlGS:0000000000000000
[  998.393936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  998.393940] CR2: 000055df0a2a6e40 CR3: 000000011c7fe003 CR4: 00000000007726f0
[  998.393944] PKRU: 55555554
[  998.393946] Call Trace:
[  998.393949]  <TASK>
[  998.393952]  ? show_trace_log_lvl+0x1b0/0x2f0
[  998.393961]  ? show_trace_log_lvl+0x1b0/0x2f0
[  998.393975]  ? dp_device_event+0x41/0x80 [openvswitch]
[  998.394009]  ? __die_body.cold+0x8/0x12
[  998.394016]  ? die_addr+0x3c/0x60
[  998.394027]  ? exc_general_protection+0x16d/0x390
[  998.394042]  ? asm_exc_general_protection+0x26/0x30
[  998.394058]  ? dev_set_promiscuity+0x8d/0xa0
[  998.394066]  ? ovs_netdev_detach_dev+0x3a/0x80 [openvswitch]
[  998.394092]  dp_device_event+0x41/0x80 [openvswitch]
[  998.394102]  notifier_call_chain+0x5a/0xd0
[  998.394106]  unregister_netdevice_many_notify+0x51b/0xa60
[  998.394110]  rtnl_dellink+0x169/0x3e0
[  998.394121]  ? rt_mutex_slowlock.constprop.0+0x95/0xd0
[  998.394125]  rtnetlink_rcv_msg+0x142/0x3f0
[  998.394128]  ? avc_has_perm_noaudit+0x69/0xf0
[  998.394130]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  998.394132]  netlink_rcv_skb+0x50/0x100
[  998.394138]  netlink_unicast+0x292/0x3f0
[  998.394141]  netlink_sendmsg+0x21b/0x470
[  998.394145]  ____sys_sendmsg+0x39d/0x3d0
[  998.394149]  ___sys_sendmsg+0x9a/0xe0
[  998.394156]  __sys_sendmsg+0x7a/0xd0
[  998.394160]  do_syscall_64+0x7f/0x170
[  998.394162]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  998.394165] RIP: 0033:0x7fad61bf4724
[  998.394188] Code: 89 02 b8 ff ff ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 80 3d c5 e9 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
[  998.394189] RSP: 002b:00007ffd7e2f7cb8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  998.394191] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fad61bf4724
[  998.394193] RDX: 0000000000000000 RSI: 00007ffd7e2f7d20 RDI: 0000000000000003
[  998.394194] RBP: 00007ffd7e2f7d90 R08: 0000000000000010 R09: 000000000000003f
[  998.394195] R10: 000055df11558010 R11: 0000000000000202 R12: 00007ffd7e2f8380
[  998.394196] R13: 0000000069b233d7 R14: 000055df0a256040 R15: 0000000000000000
[  998.394200]  </TASK>

To fix this, reorder the operations in ovs_netdev_detach_dev() to only
clear the flag after completing the other operations, and introduce an
smp_wmb() to make the ordering requirement explicit. The smp_wmb() is
paired with a full smp_mb() in netdev_destroy() to make sure the
call_rcu() invocation does not happen before the unregister operations
are visible.

Reported-by: Minxi Hou <mhou@redhat.com>
Tested-by: Minxi Hou <mhou@redhat.com>
Fixes: 549822767630 ("net: openvswitch: Avoid needlessly taking the RTNL on vport destroy")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/openvswitch/vport-netdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 6574f9bcdc02..c688dee96503 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -151,11 +151,15 @@ static void vport_netdev_free(struct rcu_head *rcu)
 void ovs_netdev_detach_dev(struct vport *vport)
 {
 	ASSERT_RTNL();
-	vport->dev->priv_flags &= ~IFF_OVS_DATAPATH;
 	netdev_rx_handler_unregister(vport->dev);
 	netdev_upper_dev_unlink(vport->dev,
 				netdev_master_upper_dev_get(vport->dev));
 	dev_set_promiscuity(vport->dev, -1);
+
+	/* paired with smp_mb() in netdev_destroy() */
+	smp_wmb();
+
+	vport->dev->priv_flags &= ~IFF_OVS_DATAPATH;
 }
 
 static void netdev_destroy(struct vport *vport)
@@ -174,6 +178,9 @@ static void netdev_destroy(struct vport *vport)
 		rtnl_unlock();
 	}
 
+	/* paired with smp_wmb() in ovs_netdev_detach_dev() */
+	smp_mb();
+
 	call_rcu(&vport->rcu, vport_netdev_free);
 }
 
-- 
2.53.0


