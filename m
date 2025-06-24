Return-Path: <netdev+bounces-200488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F350AE59C3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBCC4A330A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8A256D;
	Tue, 24 Jun 2025 02:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6E1FECBA
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731695; cv=none; b=HKRx2FQEkL2lR/G0wcBHRkFrAB6u0P9fAbR9dkW7Dsd9ATz/JQF+o+53IZycFR41Hf9+1Y84Kemv6kmzZOnNeY7qaN+GEi80WfmWHRUGBPD22f34kPm4ZXqogPDoUJTbYrpijdQBHoWALBQIDP4hjUhyqWZ3qyeO6XtF/ai0Fko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731695; c=relaxed/simple;
	bh=b1rgYTKhkyPRyHl7/4Gi5QLolb2gubZFGI5smUerzb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWNYBu75zMUyp/H9eDogbejmkd8A6FX41wn5Y3WNoLZiuAF6wvG/qSWug3MErvWCOM9diS9GzGkBmJRDZyLZ2IgviOnSh5h/M4xLjAvKAAT46Atj4JNOWsQIXfE6kpy6/grUwSewbo48akOLCLlu/iVA167QhaVcem+OKHRNDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1750731667td4979fcf
X-QQ-Originating-IP: aADcDFWM96QwKUQqVMMoublHPxNTiP+3XHm5VJ9WtUU=
Received: from localhost.localdomain ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 10:21:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4700279334984943765
EX-QQ-RecipientCnt: 15
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [net-next v7 2/3] net: bonding: add broadcast_neighbor netlink option
Date: Tue, 24 Jun 2025 10:18:04 +0800
Message-Id: <9138ca7c04ba34ee73ba358ade281e05f5fd5c72.1750642573.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1750642572.git.tonghao@bamaicloud.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NBUSIVIw0bNzbWRxQq52TIzmD4HI75+bGH8wskA/LJB2PDkoo1xoo8LB
	61BNUrMhePVbsDaHxblyWXKI925ycMVzBW61Hn0Q4bKf+CVOHiRbEF+sH1scQ5bTNTQUTr1
	4mdPR10nRxw0un2YxQAqABGMroMhcToW5tuSQvwEoqsp2DB7FAPsaI4T9jOuB8I82nltRNq
	YeFDA9KFT/klkRo7SY4+L0rt3l8sEglNR9Jz2VEjGy10Md9zcX/KDweZTIeZVPiwdWeY5Yr
	BcZo36eBDx0Rt0GzjMSMBh55fdSDnvUDAWz+i4OJaAwTKKrwh7qYOaga6O8iHCu9y6AHr4V
	TNSUfDd0h+DRdwSHMpel4P1X0hiG+zna/fzw++jMKptWbpWFk9aRCRcS8SUP84Ymgx3dwQG
	GF9loK2NgxkRlaSv/TMUw7+qxKvxJ4PcloRvLe9iXSzC6LmaTk6YHbGFkijJNGSRAC5UfTg
	mg4pZiw9v88gC6hwsrAbS+5o3O0JHKqc9efdfsJlyh+MG4+szrEunX/xOSM6jiRJ5aF//ET
	Ot8elK9sQMrjBgdeWb2M081OTZWgzCcnQava+T5EezXvGmfWi2i4Ej2vN2nTdPRaPs7JWOV
	EvACizVFdcYJ6uQAdjoqcOJFgAwjWhD/I110MdDp4ZVclbfskm1KoSH8e42+7hQ8eN0AmQ+
	uZlJLGMTdxCdpUj5IeK5q8liB2zAwu4eAj3n74AcJOrzpfae/12Ai9jZ38wb3pjut8IdAhZ
	DVQ1kgPg4MDx1gVKiYggadJ9ZUoCTi001pyhOARam2GoUhqKEXDaOjrce8bE4JCfPlwyt6p
	z3JI3Hk413ymMRD2w+X9YfVZKiAp0EmYDaxzWNz+QVxdRgBLa+Zj7z310JnOzO+qShcPPIi
	OTuDoWoIdyzCBWWj0ghlvl1kgvO6oNd9+bsUvy0QXjdAbvoEoETOs+it1an02n+d5hj6FGJ
	c6chfeTKxH8RC5MKSrhwTlUh596tHRqLpY/bxwpDGIR3VNEbvD/HOGVaTwYXytyoWWtOjf4
	0a8jXLHWeL0mLiuTqS
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

User can config or display the bonding broadcast_neighbor option via
iproute2/netlink.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_netlink.c | 16 ++++++++++++++++
 include/uapi/linux/if_link.h       |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ac5e402c34bc..57fff2421f1b 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -124,6 +124,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
+	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -561,6 +562,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_BROADCAST_NEIGH]) {
+		int broadcast_neigh = nla_get_u8(data[IFLA_BOND_BROADCAST_NEIGH]);
+
+		bond_opt_initval(&newval, broadcast_neigh);
+		err = __bond_opt_set(bond, BOND_OPT_BROADCAST_NEIGH, &newval,
+				     data[IFLA_BOND_BROADCAST_NEIGH], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -630,6 +641,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(struct nlattr)) +
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
 		0;
 }
 
@@ -793,6 +805,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.coupled_control))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_BROADCAST_NEIGH,
+		       bond->params.broadcast_neighbor))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3ad2d5d98034..53b2f6ebda8b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1534,6 +1534,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.34.1


