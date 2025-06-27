Return-Path: <netdev+bounces-201956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E693AEB93C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E27561A91
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA12D978F;
	Fri, 27 Jun 2025 13:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C461DFE1
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032280; cv=none; b=V0siRtMVkGI1htCn/igX2tCayZGhPZRog7uKUSNv3LfdV1Gt+bAueWcrEG6Q8p/V2NUYprRpsnIsjZeQ0ceFXpa0ZgM4QzXzMAo78QWAoKuuqbP7HUTWv4qoMarC2x8S+jhhmp7sbgY2TKTtWWEb9MGZiikNMwZLcxAv5VEB4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032280; c=relaxed/simple;
	bh=lTKhwoXGcWDLcCvjZmKQhCoBnNVf7g5g3nklrzYStts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWEREhdv/EKRRwkAncIAi5Ae4yztAf+7VN8Z7ncFLJEEUY4b6BTNlk5dV6hlhcIzqoJ2GSEIsaH4Rv9+c44Ro/33w2KaRG6i3WUCzPbLJ8xNHhZ7V8DNjZvDcDGzqhS7iuG83BwHK8ZqkgSS6bPYbtKObRRipBXiTaBs1DrTQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1751032249ta15c396d
X-QQ-Originating-IP: SmH2KTZMoQyMxO6g9zv5w6oc7clway5ap4tQpLPGRPs=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 21:50:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8761632092007464865
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
Subject: [net-next v8 0/3] add broadcast_neighbor for no-stacking networking arch
Date: Fri, 27 Jun 2025 21:49:27 +0800
Message-Id: <cover.1751031306.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NWT6b+CD3I3QE/Tr8m5gi9oH0xcIMkeWqGxv25znpdJn4+Gw0SZfm0Av
	oVhRYa1bI9VXMbLDrbheolqMSybYRhmyD43GGWkckF9/9FodhkyfxFE6pAMNXol5cGDM2ML
	VxVTRNuFn30ocK9SsQvqG1n5i8kDrRwrXbUOTcZh7YQArDTrhrobLxNWS3mdiaXYh6e6fCv
	MGLNBhrIYcG6pRdf2MvlA6J6Q11Qev8qy3a3HSICx2qv4HWJnVT15TLdHP/fJPk+Nifjaay
	oh4IBWOXt4xUBQJz8We4n1tvTgNnQBhayFmihJoMtRh7DWJ+7Bw+uS+qCfSVsl4PLt/EctE
	BAOQ8vyUoCc6V9K+TTWvgFUbCiMgC7b+j6Y4Wpb2qRNzWaxFynEWdlp1cnK0qr41kA+0BAG
	ioJ17qE9j0v/sEFUTyf3KXc1EHjCdq3v690/kZ/TVgTOxFgL2ZtXNg9E9cJrlm+9HHU2Xn3
	de/md8uLmVtbM5RKhGWuoniIJJ2YiOvBJOi/bbLGBNQFPpw1sBV9gsq7UnAFyAwmIZXdRPd
	W00nsnG70bLp320Rcd0CG6BoQ6MCBJyglsahWk4SP5+8ZlLD8K0eZFAifuBkLovLrDRdrjH
	XYlEmXgtcXPNvm2Oh0vD/s3FjscNLPa0FxoUO72fX2zKYd7NFH+Q7R4wbCl0WtkAcx0AFK6
	txZYuUKSHoHaVKrXvTe+PgMyjsAu5IFAcotOxYo+yWRLko+D/BPIxR6suxYpZe8KqViw98B
	V0NRvjKELkYCj+XBpnKvXCqVsRU5wZk9htFeBNNQd88tJBxLahf8AfWu/rB2ib3DTOtTxhL
	jolJwaE/ksb/T8MhHSlQQLTdYAmCGrGRpFSFUi/XoKFXnrrmUYOFglBWt7u69zazHk9NZv5
	HdDxfrQEmYKXsgHqM7ZWShMNmu0JQl+Ehl1VfvPHVJfMHVcCpBs+LyS4rQ2LPCEq5E6Knyw
	weSC3EUnGwo9O9Yy9mElGPjzNL8nAgfgqEu8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v8 change log:
- please see change log in every patch

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
 drivers/net/bonding/bond_3ad.c       | 13 ++++
 drivers/net/bonding/bond_main.c      | 91 ++++++++++++++++++++++++----
 drivers/net/bonding/bond_netlink.c   | 16 +++++
 drivers/net/bonding/bond_options.c   | 42 +++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +
 include/uapi/linux/if_link.h         |  1 +
 8 files changed, 165 insertions(+), 13 deletions(-)

-- 
2.34.1


