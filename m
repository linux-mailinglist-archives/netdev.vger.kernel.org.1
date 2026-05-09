Return-Path: <netdev+bounces-286114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RCzRBKDj/mnuygAAu9opvQ
	(envelope-from <netdev+bounces-286114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66AF4FE798
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4513018D77
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DD1261B9E;
	Sat,  9 May 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sH7yHv6Y"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88343800
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312091; cv=none; b=JX+AmvoSf6b1X6O2UWCHyn0HcFYCKx/jz6iauCHPm0ZxoRd2EAI2qUk6ti0+N8EbA5eh+HAhh6cuYwCchOQZ9bnoHn//NTSGHuBm4+G0O03Lu8QMduvm8h4i8ENBeAh2huASMva6IHZtCmhUytitQaOENyI77WYUG1X+3flDcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312091; c=relaxed/simple;
	bh=TVlPNu85G6/ldi3FS+DADn1zXwFVJQNWpT+W2xJ9KC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPG1qwiExW/GH0LxniQ5hoE4bfaxGWjQirpWSilFsV/+QeovBWn4T8Bc2CwiZUFHyUR+calK6F5CoFImudpwNOSAJ5eeIY04al/kWDGpljw60JlAVyrK1+flHA6i9pEd8HKqZghymYyrmZQQcN2QDqdaAUsq2+1uUhyv7mXP0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sH7yHv6Y; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lSSZOXVYIkliF65CDTIg93cMjVDzx6l1/UZlx8bgXq0=;
	b=sH7yHv6YmJ+sFrGafnaGg9WgfNT75KHLvZFPrw4RoSXrcaF6DUST77P7dz3WNqcG1KfM60KZk
	Bn/BXL83chg28tKrS+poad3vH34mmPcn7OHBd+YeddsJNH1tOnJzGBCU+DVeVyc3ry1ktKtZ8Sl
	QuG8Ha6bGjhAYNFtMfT6ccA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gCHcW62GWz1T4JG;
	Sat,  9 May 2026 15:27:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D0E540538;
	Sat,  9 May 2026 15:34:43 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 15:34:43 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 15:34:42 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <tpluszz77@gmail.com>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net] net: xfrm: Fix dev refcnt leak in async resumption
Date: Sat, 9 May 2026 15:44:43 +0800
Message-ID: <20260509074443.104163-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Queue-Id: B66AF4FE798
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286114-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

xfrm async resumption hold dev ref until after transport_finish.
When afinfo is NULL (e.g. x->props.family is invalid) and xfrm_gro
is not set, dev_put in transport_finish() and xfrm_gro path is skipped.
This will trigger refcnt leak.

Add dev_put in return path to fix it.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/xfrm/xfrm_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..c98a29d80a53 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -765,6 +765,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			return err;
 		}
 
+		if (unlikely(!afinfo) && async)
+			dev_put(skb->dev);
 		return err;
 	}
 
-- 
2.25.1


