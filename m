Return-Path: <netdev+bounces-195926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E85AD2C38
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E4E7A7F80
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC525D204;
	Tue, 10 Jun 2025 03:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB213BC02
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527191; cv=none; b=EtWTHw58ZaBzVkIsg/L1PsODTKbRQNKJUFXEYOfi/Y1d4fRvNS1G+k4Q7gsxhz3S3oeqWvMdHZf3j19qefyDCXeY0kcFbfa7Wm0EDvBrtAaoFP+5oJYqp3mQkEGErpXIXVI/iJb9m/rV/eDMabgo0qFFJJVw7iNaQ6KuOZKtBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527191; c=relaxed/simple;
	bh=+GAGzflEhlC6FD81N+B7BulvBRIUzGB/zE8mIFnXklE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jO/IacqYN4yV+K8hC6ZuOm7jrL3WVyR6MQJZDkuCkMEl0jFcLoO2zxxULxjW6HCtHif65X6GBw83BZWY0768GE2Nu1nVGmUNNSCxtn96aEzF44eeHNEHJ2tdzqtQoi4meJOsGHbGBKlntE0PsIUrkaRbOkBTlmcL1vA+nJGKTFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1749527143t40d5e94a
X-QQ-Originating-IP: 6YLZVe03CfVtyZtYmhXoS75v59wL4641pHSGVVpnEIc=
Received: from localhost.localdomain ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 11:45:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 807393703523562276
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
Subject: [net-next v6 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Tue, 10 Jun 2025 11:44:41 +0800
Message-Id: <cover.1749525581.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mq+dXfLz1bhawD1ORetWSIZ0Ij+sM+UEZjDYnmufd3XU7ujmzYB+56rw
	GaxauR+fAFCpF1/DCD4WiePYOZE1/pvxm8es3+XKcof1SjqVM3exPBhljGFS7pK6m1/ocbW
	n6PLiL3QWgPoau62oxUks3s52PwpSZ/8VEkj3bS9CsoKDB3zX0tedYat5ENit9rXfvsx1bj
	k9cuq54Gwk+wvJhX5pPIkBPgIETkUgMivoc1/7HU6+ghR6RmOc6MAOa+OlATyVddISQtDbP
	5EDSfca1p6FNEt4RAJpJP0hx9zA55ecAGDwmpHzLUeBHYQO3Uok5lBgHtL1rB6xiGs7rHZG
	CuTrQAB2E8K8u774SnWvj9RGDqeHUVz/+JM+uc7zXTjaT7VzwIQ1Ggc01vTnRsJ0mbkks0s
	cZhfw9B8SpkjZGczutMTzpki/KMSoRbBNxkpIS4H68079xC13hmUWys9zQ0FUErfab/yAYO
	PyZEPAs6n0Cseb1iVLFRHIt588BCcBbY7Ik1kvaOdy5bvWXYiSbV+/if3AGrOKASvgjV/XJ
	F922lJCwj+B5VsvEPB+C2GqsChdwGvv8GcvtGac/txHe/PjVDn/qmuSWf3cWe2k/cd2tjs5
	9mbzu2q1uxhBNpXexa/efH6HixOIqvh3aislkjAIv0RO8MVYKw4ZgWa44qxqGuN7o3tl3It
	o/p9Gjtdmcozrrrer73B/ow9dPFQpUjs13BR1kWR8HRbLSkrN+fkVR8im42+wcrHKZ3IF3x
	5AngtWKKpnsccR++hjBvy93+nw2+9wMRxhilsDsq06As2ruHzPQ2Qj0gTwr4+XH1+cPjIKh
	ahAOQaLjl/xVizgjPWMOovSEjz4xpLY7IO448LEdMn+q8smmFcmzVOGxx/0IyntK/OkI1HT
	J1ksfxwqxAkquLmmCWl66JQ2WivHNOBorqRzwe9G9lhslsfcbK6suQD/wY1oB7Gkg9exFaX
	JfbCqFsbXGZpngAYaGMR7cj8eVTvJHr++TkijvTiopolLug==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v6 change log:
- del unnecessary rcu_read_lock in bond_xmit_broadcast  

v5 change log:
- format commit message of all patches
- use skb_header_pointer instead of pskb_may_pull
- send only packets to active slaves instead of all ports, and add more commit log

v4 change log:
- fix dec option in bond_close

v3 change log:
- inc/dec broadcast_neighbor option in bond_open/close and UP state.
- remove explicit inline of bond_should_broadcast_neighbor
- remove sysfs option
- remove EXPORT_SYMBOL_GPL
- reorder option bond_opt_value
- use rcu_xxx in bond_should_notify_peers.

v2 change log:
- add static branch for performance
- add more info about no-stacking arch in commit message
- add broadcast_neighbor info and format doc
- invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode for performance
- explain why we need sending peer notify when failure recovery
- change the doc about num_unsol_na
- refine function name to ad_cond_set_peer_notif
- ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
- refine bond_should_notify_peers for lacp mode.

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
Cc: Zengbing Tu <tuzengbing@didiglobal.com>

Tonghao Zhang (4):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery
  net: bonding: add tracepoint for 802.3ad

 Documentation/networking/bonding.rst | 11 +++-
 drivers/net/bonding/bond_3ad.c       | 19 ++++++
 drivers/net/bonding/bond_main.c      | 87 ++++++++++++++++++++++++----
 drivers/net/bonding/bond_netlink.c   | 16 +++++
 drivers/net/bonding/bond_options.c   | 35 +++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +
 include/trace/events/bonding.h       | 37 ++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 9 files changed, 197 insertions(+), 13 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


