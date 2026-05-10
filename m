Return-Path: <netdev+bounces-286336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJaLIHK2AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E810D5052DF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA49C303350C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818433B27DA;
	Sun, 10 May 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Vq46uGiv"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371603B27CF;
	Sun, 10 May 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431459; cv=none; b=YCLZ1Fn+YY0gQ3SD+F+Z17RUNP2zwn4EtpxfUPQPL5Yl60z8ID4QdHE6hwCJg1pVO7hDEyliOCechKZZ9qjw1GiA2D0eQt9/v3TtydVIDY4+f3u4ZcW4aEEFhXwDdmCqBvduRXj/pfhJwGAV+Zq6/YjFfXmyjGuD3pF5Sxgafa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431459; c=relaxed/simple;
	bh=3XFxg4578Egfz87dGChvi1XzwYpSp7bqgoFpUif/CTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un8Ho6MqZT0wkAd6r5Re08c6ag2j7axYQ6PIl3lkclUZzPTSzBpS3D+tOqyewxdB0r9wpwbHBulkfyrsnyTZvbh6i47FuAHhQ/ipKfIPFetkqQ4+/FikCNKpQb6nebIQzea8wD53hDjqr9f3T0KQyFvyFPU5HmWMT9EiVcybyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Vq46uGiv; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gD7wx3hYvzDqWT;
	Sun, 10 May 2026 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778431457; bh=etVC0bTQFaLljz45Ozw6Z5ar3mBaujDjOBP6pEiANco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vq46uGiv15Wf7VYRGysTH9++I3onNG2LPm8Anl9fPbr3rsNSvOfW8dfIZXYcIH1jg
	 PX3WKTBIYThXaqr3AUQYP+uL7nQ56N0IarVevJDd4T/+QjqkI8hLXQSAk8mqQjtQsr
	 TfKLmq933IparXKKgEMugCvO7PpuKtOKlDzHzihA=
X-Riseup-User-ID: CA6881DCE3628AC70C0111573035719C860D40349A9E12D1DA98BC111642190B
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gD7ws2PVnz1yDs;
	Sun, 10 May 2026 16:44:13 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Filip Pokryvka <fpokryvk@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
Subject: [PATCH net-next 4/5] selftest: netdevsim: cleanup the devices and module on failure
Date: Sun, 10 May 2026 18:43:36 +0200
Message-ID: <20260510164337.7611-5-ihuguet@riseup.net>
In-Reply-To: <20260510164337.7611-1-ihuguet@riseup.net>
References: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E810D5052DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@riseup.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riseup.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email,riseup.net:mid,riseup.net:dkim]
X-Rspamd-Action: no action

In case of failures only the netns were cleaned, leaving behind the
netdevsim devices created for the test and the module loaded. On
failure, delete the devices and unload the module.

Signed-off-by: Íñigo Huguet <ihuguet@riseup.net>
---
 .../selftests/drivers/net/netdevsim/peer.sh   | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index 5e7b6c1d0bfb..ec96015bc9eb 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -46,10 +46,13 @@ setup_ns()
 	set +e
 }
 
-cleanup_ns()
+cleanup()
 {
 	ip netns del nscl
 	ip netns del nssv
+	echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
+	echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_DEL
+	modprobe -r netdevsim
 }
 
 assert_carrier_up()
@@ -64,7 +67,6 @@ assert_carrier_up()
 
 	if [ "$sysfs_carrier" -ne 1 -o "$ethtool_carrier" != "true" ]; then
 		echo "$nsim_dev's carrier should be UP, but it isn't"
-		cleanup_ns
 		exit 1
 	fi
 }
@@ -81,7 +83,6 @@ assert_carrier_down()
 
 	if [ "$sysfs_carrier" -ne 0 -o "$ethtool_carrier" != "false" ]; then
 		echo "$nsim_dev's carrier should be DOWN, but it isn't"
-		cleanup_ns
 		exit 1
 	fi
 }
@@ -120,6 +121,8 @@ udevadm settle
 
 setup_ns
 
+trap cleanup EXIT
+
 NSIM_DEV_1_FD=$((256 + RANDOM % 256))
 exec {NSIM_DEV_1_FD}</var/run/netns/nssv
 NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
@@ -131,28 +134,24 @@ NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifinde
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
 	echo "linking with non-existent netdevsim should fail"
-	cleanup_ns
 	exit 1
 fi
 
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
 	echo "linking with non-existent netnsid should fail"
-	cleanup_ns
 	exit 1
 fi
 
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
 	echo "linking with self should fail"
-	cleanup_ns
 	exit 1
 fi
 
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
 if [ $? -ne 0 ]; then
 	echo "linking netdevsim1 with netdevsim2 should succeed"
-	cleanup_ns
 	exit 1
 fi
 
@@ -161,7 +160,6 @@ fi
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
 if [ $? -eq 0 ]; then
 	echo "invalid arg should fail"
-	cleanup_ns
 	exit 1
 fi
 
@@ -228,13 +226,6 @@ fi
 
 echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
 
-echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
-
 kill $pid
-echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_DEL
-
-cleanup_ns
-
-modprobe -r netdevsim
 
 exit $res
-- 
2.53.0


