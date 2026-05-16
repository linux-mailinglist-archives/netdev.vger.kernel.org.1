Return-Path: <netdev+bounces-288658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN1RG4W8CGrK3AMAu9opvQ
	(envelope-from <netdev+bounces-288658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 20:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20055D5D4
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D9530ADC98
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22E34BA42;
	Sat, 16 May 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aTGQzeED"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B5363C40
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956835; cv=none; b=dnq+ro3+kFh8lloaXvEWG/2VuJX4QsD9eDgCzV3P7MfdjWslH8L3bziANxdtCybSkJj8Uwr9WLzoukM32YhHC3vYSl2MvO/oZ4WSvevuFuTe0JrAFPQKcKyPonJoqkYFxUoEJC+Qwa91kBhV8KF0rangtcddGSXXKbh8RfhbnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956835; c=relaxed/simple;
	bh=VlzjVr4Rhu/SvH8Nt5oSFcfF1g5cGMDAQXdfOSuw+/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TOEJPsYI8jLDrD1KD5zFgKhUviRW4gngVzmOhBGuaXUE7idFAhA92cKpm44oYgJKqEknLzL/97jk/+vdsM/I2po/KiHUh4DXaFAAU18jj0oLuzHwJLIOtXt9cJs7AOHvgFV7KvVFN2ANmtTXFW+CPCDiUWb73cfcd75zebJpdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aTGQzeED; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e00da94e-3ce2-45b0-b928-8835c3d345e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778956817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11Gci8ivGSpGfce0+gtV3tlX6LTfe9d5ZxtETMgwj5w=;
	b=aTGQzeEDpbXAqsRJ7PwppT8egtiWgEP1ovLga4uO66ix+YYrXEp3igYbIOy0NE2sNP69oE
	S17UlVQTokfPRgPs55eNCwzi/hjZ2KW5hMSv3/2nRz8mPoHyinXKHaHnfvTU3VTfE73ym8
	t0zCV9MNNEHVM38RP9s1B8SIvOyg/qY=
Date: Sat, 16 May 2026 11:40:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown
 (4)
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <6a081669.050a0220.f80e4.0002.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6a081669.050a0220.f80e4.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0F20055D5D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288658-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

diff --git a/drivers/infiniband/core/nldev.c 
b/drivers/infiniband/core/nldev.c
index 3cb3cb7629fe..96c745d5bac4 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	return err;
  }

-static DEFINE_MUTEX(nldev_dellink_mutex);
-
  static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
  			  struct netlink_ext_ack *extack)
  {
@@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	 * implicitly scoped to the driver supporting dynamic link deletion 
like RXE.
  	 */
  	if (device->link_ops && device->link_ops->dellink) {
-		mutex_lock(&nldev_dellink_mutex);
  		err = device->link_ops->dellink(device);
-		mutex_unlock(&nldev_dellink_mutex);
  		if (err)
  			return err;
  	}
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..92847e955ca2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -642,6 +642,8 @@ static void rxe_sock_put(struct sock *sk,
  	}
  }

+static DEFINE_MUTEX(rxe_net_del_mutex);
+
  void rxe_net_del(struct ib_device *dev)
  {
  	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
@@ -649,9 +651,10 @@ void rxe_net_del(struct ib_device *dev)
  	struct sock *sk;
  	struct net *net;

+	mutex_lock(&rxe_net_del_mutex);
  	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
  	if (!ndev)
-		return;
+		goto out;

  	net = dev_net(ndev);

@@ -664,6 +667,8 @@ void rxe_net_del(struct ib_device *dev)
  		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);

  	dev_put(ndev);
+out:
+	mutex_unlock(&rxe_net_del_mutex);
  }

  static void rxe_port_event(struct rxe_dev *rxe,

