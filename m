Return-Path: <netdev+bounces-200487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41626AE59C2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977291BC1061
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF01F582C;
	Tue, 24 Jun 2025 02:21:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36831256D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731690; cv=none; b=Y5fWtryHAkVMvA2ho15/tGvQXUy+FHpMCGEx2WfmahmV9zwLorJbzB/Tevn0M0cfvJG7d7j4+g6lD6aJ4dibfjdXuN4EvtSKCV4xUdohVj3ouxHcm3eW2owfuVgEL0pi7Wb3hJytwYlkVB/6rRM/DVvfs+DFVtU3ZV6iCsRa0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731690; c=relaxed/simple;
	bh=Q7eLi67U937b/+J9nKSeyx0e4PtMXP4FzJ63vN1h6sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uH4oflpwdBC/k4xYHhfU7AMo7U5ntXA5/np8ziUQbF3ntJjWO4ze8GEMXoefffUChdjFkPxEsXmpaPVCLmXyffl3mK3+5Jrornb6UyoI18A2b6jmEBiCF3oQ3nU1pZrS2IjoqsZAdqW+u50sV/7v9LMhfttIXmrAI4RKLKo7k84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1750731660ta35934b7
X-QQ-Originating-IP: 5k4lZ328bVOYaoQz/flnw/6J1tuIK5NM8UfnE6DVJxk=
Received: from localhost.localdomain ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 10:20:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12397596444691776919
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
Subject: [net-next v7 0/3] add broadcast_neighbor for no-stacking networking arch
Date: Tue, 24 Jun 2025 10:18:02 +0800
Message-Id: <cover.1750642572.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NBjdfkqVynM2pREZTQOoZ+VopxV1toU6DeDLrRLAzCS9YT5jslqg54Lw
	2jKbnj43cs/UHrxZcUWajk78a5OLyjZprjKp7KQ91Qw6hlgzqoTv+ahT/EN9jI77gUTmVhd
	7co0VCJPf2jJV4ynXN1ahHJmVmJDRPmCY3/R/DHugnKgNuEcxsdJdWOxrD1oO+Rpdl25WES
	WLLB/EdXgIUoTznDvwIKe7xqAPzx3F1EzOEJnGRsabRGcJhBda2jodbLbYUWEN4IMw+Aopq
	Fnp72FwwNbrEw8FPC/p+rSzpKsokMss1YgJjzZBojZi4p4gK+LMKyQWyNhC30YwCTTchACX
	V/7OWIASXlfySno90ulXIPSgJEmg4hKgFOqK/iPy4kdz08d6e9acXN/ZV4V9T+PP4MO2xnG
	A8orVQubtTfTZnpUSAw+N8uU5/M3cbP6YPi3pEduCVMg6l2j+rTIXhzIZR/j8oVHBOLZLpD
	QwxM+zZKjEZZFUmrvVxQGv3TgHHhEMnyCyRsKd24BGcN4EYIFde9l1Mwj9UrIXlhDDB2MyD
	Yy81rNbpV5FQgZR4bggqApXqYIhdL/FGxtVxmcMwY8yP4cbiBgzS59RGA+sg6boMdWs9p8n
	YJnYeiq9dCUCw/EkzijAJDqhMdtNabgqAYt2Tz779tBKs0XyijCEhO5Z+zjSiNdmKcP1y9W
	o3hT/CCxKjcBxXbMOHs3X84XGM9D0ctM/x5pOs1ef3OX62YX7wMRLnADn3EB10gDN7w0ds7
	7nRPfaxot0Mv8AKAAny756HVWIsiWDiisUsZvJYkRvafU9TkevBW1EfllsHDc4Td+G6BL6i
	xOAz7ENo84gXffjfktPH6JZ78P5Kca+Lnlq9IbehjB/2NxoOSmsupyQL9VjOWmPHdWNw8zI
	NjLS+TNk7Ibzr004a+BfijnxFcrUDDEovajWSJzrlSQlzZMwiNC2v6hLz4eCcgDb73aOP3z
	Q87YyIYmezccOUz1Q4rb/ERu/EJDGMWgIVEf9Q6VS79Yo3J/hdQm3Dp3F
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v7 change log:
- cleanup broadcast_neighbor when changing mode
- drop 4/4 patch, post separately
- add more commit info in 3/3 patch

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

Tonghao Zhang (3):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery

 Documentation/networking/bonding.rst | 11 +++-
 drivers/net/bonding/bond_3ad.c       | 13 +++++
 drivers/net/bonding/bond_main.c      | 87 ++++++++++++++++++++++++----
 drivers/net/bonding/bond_netlink.c   | 16 +++++
 drivers/net/bonding/bond_options.c   | 37 ++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +
 include/uapi/linux/if_link.h         |  1 +
 8 files changed, 156 insertions(+), 13 deletions(-)

-- 
2.34.1


