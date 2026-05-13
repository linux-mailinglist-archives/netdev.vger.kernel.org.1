Return-Path: <netdev+bounces-287708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL+YIxjFBGqbNwIAu9opvQ
	(envelope-from <netdev+bounces-287708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:38:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77294539167
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CF033034D87
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC13B0ADD;
	Wed, 13 May 2026 18:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE903AEF3E
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697380; cv=none; b=Ia/vHmIlswK+oCfn7plLsKiM3rclBbWcCEl9STuYLK+g4jvLZXe7m8SIjWluKJAvbOx9gDqdYo+EBgBNvmfn8GOo34mfesofTZxY3VJOkJCP/DsO4DxZeuOEwUsFvr76+OlIrn3agCx1JFY0hezXj4KXa95fb+5UZ/AXdtQdf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697380; c=relaxed/simple;
	bh=aPeYaW9AUJnEZDpa8VfIqEnqS0ks0v0SsKXhoV+Jzd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnMjppZ6/R7jXCI9g+UrdCyIKLVFeOXy2WqVIXqQ4XA9sLlnqbNE+WRkf4psItkpvwnZ+R44IaI5oUCI4q9RRgwK5OWx6Xp1mcd62srtHzw3KA01cGqqpKmgvV1gzbdROonOr2gXxX/lpGge4kp5bX2k46gdXNNWCoYt+PeVTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so4329704f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697376; x=1779302176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y241hz5AZ3XRjdMX0rkgsL+n7zioWgCIbmFy01u0VNE=;
        b=MH7Sw/WTHOQB0AHe1fJCkN22MA25OyGmYtQzxrnmCo9Jrsu6GyEJUYkRWCBh11uwgX
         iNBQNDkH0SClLrFz6m5x9D5R4R74JM3gy9fMhuNOdqDglZYu7bbT8MsgV50DSm0EiA9T
         h1XSXSTm4f22bR7RWfVZfjZPMQa5PAXWBFHG6lt0F9STWJmtAtwFLHyKCer8z+yMpgKt
         UIep7t45cEZbX8mrsAXnPMEPcB04f+fgnGNe/kE0NXohebgxwOkKubczzm/jXyBmIFHf
         MJed4WJQWOWcHXmkXp2xo/vXtxs/pwKa0gS0hOOeF7jxA3qM1H73ZZy+wHpXjFgSNEsl
         TGbA==
X-Gm-Message-State: AOJu0YzpwLqImWJVNNmI+33lWVLTh4KWyFa5cIovX7+rIS0t4wkxCMDm
	wdLoraEnLO9FTU0leCWbsmsZ+np1uzKl1ZKRYgQkvDY4gmeWrZ+hn73u9k7hKM4e
X-Gm-Gg: Acq92OGvdZxS+gh1wckWQRaarjenrXlh5zknn5hhZkFBO6WkXHCBnQVo2z9H/vbu/RJ
	13oMHo/MyWxipfwsBGCs1ODerpyYCUOGsLsEXxpqwMMbApp8LBRdKzLs57WqKneZukBUmeD+MKt
	mBXnwF0Y4Awe/ZdsYDKgzOnCd0zWc0zvi8hGSVbtDjaof/ulboHyethSelnKpJ/6HpnsPf8qzsX
	aFQl89Is/1LKjbrI0oofcFl6hkIYN7xX6/5Zz3ACEj1SnO3toBdCX+g2dqBBBf3wSPG3toPy04h
	KQV5KbTx5FHgmswrUzpK6x3fmTr2xkLdc0ikvHA2TrxB7ErH/SSJxsIHCSvbiApO4MBhv0Xtumi
	udBUjExBLR4FlcLuVpfqT/028b1W7973pR4IHPkIDWzatBdKFQZ0tmT/n9piVUFZEzjW4R+2mFY
	fPh3QIJhfHKIZorR9kuL8be/er5arKQr+r83TgJbqQvd2JQ8SyRKzvy1eWxL4=
X-Received: by 2002:a05:6000:2f83:b0:43d:761d:5423 with SMTP id ffacd0b85a97d-45c584a80e3mr6819397f8f.16.1778697376323;
        Wed, 13 May 2026 11:36:16 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:15 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 0/6] openvswitch: remove support for legacy tunnel ports
Date: Wed, 13 May 2026 20:35:20 +0200
Message-ID: <20260513183559.2141010-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77294539167
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287708-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ovs-vswitchd doesn't use OVS_VPORT_TYPE_GRE/VXLAN/GENEVE with upstream
Linux kernel module since adding support for standard tunnel devices
with COLLECT_METADATA back in 2017.  The code to use them is still
present, but it is only activated as a fallback for old kernels, so
not used in practice.  And it is marked for removal in the next OVS
release this summer.  Modern way to use tunnels with OVS is to create
standard tunnel ports with RTM_NEWLINK + COLLECT_METADATA and add them
as OVS_VPORT_TYPE_NETDEV.

Device reference management and the netlink options parsing for these
legacy port types is complicated and was a CVE magnet recently.  Since
there are no actual users for these port types for a very long time,
let's just remove the support entirely.


There are 3 parts to this set:

1. The first patch does the tunnel port removal, which is the primary
   goal here.

2. Patches 2 and 3 remove extra infrastructure that is no longer in
   use by anything inside the openvswitch module.  It may technically
   be used by some out-of-tree module, but it is unlikely, so the
   proposal here is to also just remove it.  Or we can consider
   deprecation.  It's not really a user API, it's an API for modules.
   Which can be considered as users, I guess.  Not sure.

3. Patches 4-6 remove functions from gre/vxlan/geneve modules that
   were added for openvswitch in the past to support the tunnel types.
   And openvswitch is the only in-tree consumer of these functions,
   so we could remove them.  But they are also exported symbols, so
   can in theory be used by some out-of-tree modules, though I doubt
   that.  Not sure what the process should be here.  Removal seems
   reasonable, but we may consider deprecation first.

Thoughts?


Ilya Maximets (6):
  openvswitch: remove support for legacy tunnel types
  openvswitch: vport: remove infrastructure for vport options
  openvswitch: vport: remove infrastructure for separate modules
  net: geneve: remove unused geneve_dev_create_fb
  net: gre: remove unused gretap_fb_dev_create
  net: vxlan: remove unused vxlan_dev_create

 drivers/net/geneve.c                          |  48 -----
 drivers/net/vxlan/vxlan_core.c                |  42 +----
 include/net/geneve.h                          |   5 -
 include/net/gre.h                             |   2 -
 include/net/vxlan.h                           |   3 -
 include/uapi/linux/openvswitch.h              |  31 +++-
 net/ipv4/ip_gre.c                             |  47 -----
 net/openvswitch/Kconfig                       |  35 ----
 net/openvswitch/Makefile                      |   4 -
 net/openvswitch/datapath.c                    |  22 +--
 net/openvswitch/vport-geneve.c                | 143 ---------------
 net/openvswitch/vport-gre.c                   | 106 -----------
 net/openvswitch/vport-netdev.c                |  28 +--
 net/openvswitch/vport-netdev.h                |   3 +-
 net/openvswitch/vport-vxlan.c                 | 172 ------------------
 net/openvswitch/vport.c                       |  76 +-------
 net/openvswitch/vport.h                       |  23 +--
 tools/testing/selftests/net/config            |   3 -
 .../selftests/net/openvswitch/openvswitch.sh  |  37 ----
 .../selftests/net/openvswitch/ovs-dpctl.py    |  93 +++-------
 20 files changed, 59 insertions(+), 864 deletions(-)
 delete mode 100644 net/openvswitch/vport-geneve.c
 delete mode 100644 net/openvswitch/vport-gre.c
 delete mode 100644 net/openvswitch/vport-vxlan.c

-- 
2.53.0


