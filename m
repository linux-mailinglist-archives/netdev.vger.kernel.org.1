Return-Path: <netdev+bounces-293271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HnjIVoAGmpu0ggAu9opvQ
	(envelope-from <netdev+bounces-293271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:08:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA5608C95
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8630A30571B9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E44218A0;
	Fri, 29 May 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LicfbSI4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB749279903;
	Fri, 29 May 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088577; cv=none; b=Ik9qz9ymo6kWi+Fe29I20gMzL5m5vPgg6VZXDMFYh/7YRcUvPMxRnIBdyjIqQqg2jaT4KzCLSi51JXZbNAfbosFQNFVJCx0K1Sf4AS0X75uDIMlESytu8vTwpdWdCJlmedQIJmpN/aGHQ+bvl8D69mj1zb52ujexouxlagTOnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088577; c=relaxed/simple;
	bh=8jYQGaGUJpVg3/B6it/+/Vy0WnHiXbpFGrpzfa8tCeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qkOe1wQ2zJCcg1uLE15vq8s43fSW/ag3SBmo7mlpkwDbmA7hwCmbUTVQIEh+M5pjLdlOse9RsYHo8QPGdDF8KnwQFIY3Ov2/UG0VPJsgOZfQboPPWoVILIhmf5fPgX5uLLslbJWi14QITuAusoqle64dIPVuzErDdsFcbApjARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LicfbSI4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612761F00893;
	Fri, 29 May 2026 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780088576;
	bh=tuBSYnJizG2FgUAZ2znL44jJXAVY+HslhTrHaVXLHGo=;
	h=From:To:Cc:Subject:Date;
	b=LicfbSI4jmG7TT54/GjmC2qLSLKO91ee4oz2SXbbxURV/6Fxf8jnZhOU4MOwnURcI
	 qgCyUsvZeXxbacm24SKbgJSC87hXyWL0tqxinxGQ41C07U6vL7XtBJRoVm10g6If1O
	 1sgEXy22xbOgDPiExt7VEoMyKqaQYcw6vEpVqti3S+Y3J5ET1t8l2++m6LjGyt9Blo
	 po1v4MHkIawCXGKE2WZOHQcaf10jyCbzCnzs31vhXvW+DckXYIrn/fNGm17m3jy8G6
	 Rf0SjfJkjNRwk/iPjh7bNo3Bs9iXDT5zuTWMlrr7PufbrFop7YmxgqYMt/boku4V7o
	 WlrfYqG5TMykg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.1-rc6 (part 2)
Date: Fri, 29 May 2026 14:02:55 -0700
Message-ID: <20260529210255.4017083-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293271-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07DA5608C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit 3e20009988e2470063824c58b19d1c80816cc46d:

  Merge tag 'net-7.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-28 13:13:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6-2

for you to fetch changes up to 78ef59e7a6459b16f8102e0ee1c718443323d1af:

  Merge branch 'wireguard-fixes-for-7-1-rc6' (2026-05-29 13:01:31 -0700)

----------------------------------------------------------------
Quick follow up, nothing super urgent here. Main reason I'm sending
this out is because the IPsec and Bluetooth PRs did not make it
yesterday. I don't want to have to send you all of this + whatever
comes next week, for rc7. The fixes under "Previous releases -
regressions" are for real user-reported regressions from v7.0.

Previous releases - regressions:

 - Revert "ipv6: preserve insertion order for same-scope addresses"

 - xfrm: move policy_bydst RCU sync, a fix which added a sync RCU
   on netns exit got backported to stable and was causing serious
   accumulation of dying netns's for real workloads

 - pcs-mtk-lynxi: fix bpi-r3 serdes configuration

Previous releases - always broken:

 - usual grab bag of race, locking and leak fixes for Bluetooth

 - handful of page handling fixes for IPsec

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

Dipayaan Roy (2):
      net: mana: Add NULL guards in teardown path to prevent panic on attach failure
      net: mana: Skip redundant detach on already-detached port

Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Fernando Fernandez Mancera (1):
      Revert "ipv6: preserve insertion order for same-scope addresses"

Frank Wunderlich (1):
      net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes configuration

Heitor Alves de Siqueira (3):
      Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()

Herbert Xu (1):
      xfrm: ipcomp: Free destination pages on acomp errors

Jakub Kicinski (4):
      Merge branch 'net-mana-fix-null-dereferences-during-teardown-after-attach-failure'
      Merge tag 'for-net-2026-05-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'ipsec-2026-05-29' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'wireguard-fixes-for-7-1-rc6'

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jiayuan Chen (2):
      ipv6: fix possible infinite loop in rt6_fill_node()
      ipv6: fix possible infinite loop in fib6_select_path()

Jingguo Tan (2):
      xfrm: esp: restore combined single-frag length gate
      vsock/virtio: bind uarg before filling zerocopy skb

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp

Maoyi Xie (1):
      xfrm: route MIGRATE notifications to caller's netns

Michael Bommarito (1):
      xfrm: ah: use skb_to_full_sk in async output callbacks

Muhammad Bilal (3):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()
      Bluetooth: ISO: fix UAF in iso_recv_frame
      Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock

Pavel Begunkov (1):
      net: skbuff: fix pskb_carve leaking zcopy pages

Pavitra Jha (1):
      Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

Shaomin Chen (1):
      xfrm: iptfs: reset runtime state when cloning SAs

Shuai Zhang (2):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

Siwei Zhang (2):
      Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()

Steffen Klassert (1):
      Revert "esp: fix page frag reference leak on skb_to_sgvec failure"

Usama Arif (1):
      xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit

Yuqi Xu (1):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhengchuan Liang (1):
      xfrm: input: hold netns during deferred transport reinjection

Zhenghang Xiao (2):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff

e521588 (1):
      esp: fix page frag reference leak on skb_to_sgvec failure

 drivers/bluetooth/btusb.c                     |  8 ++-
 drivers/bluetooth/hci_qca.c                   |  4 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 78 ++++++++++++++++-----------
 drivers/net/pcs/pcs-mtk-lynxi.c               |  3 ++
 drivers/net/wireguard/send.c                  | 20 +++----
 include/net/xfrm.h                            |  3 +-
 net/bluetooth/6lowpan.c                       |  2 +
 net/bluetooth/hci_conn.c                      |  4 +-
 net/bluetooth/hci_core.c                      | 43 ++-------------
 net/bluetooth/hci_sync.c                      | 16 +++++-
 net/bluetooth/hidp/core.c                     | 23 ++++++--
 net/bluetooth/iso.c                           | 12 +++--
 net/bluetooth/l2cap_core.c                    | 41 +++++++++++---
 net/bluetooth/l2cap_sock.c                    | 16 +++---
 net/core/filter.c                             |  2 +-
 net/core/skbuff.c                             | 10 ++++
 net/ipv4/ah4.c                                |  2 +-
 net/ipv4/esp4.c                               |  4 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/ipv6/ah6.c                                |  2 +-
 net/ipv6/esp6.c                               |  4 +-
 net/ipv6/route.c                              |  5 ++
 net/key/af_key.c                              |  6 +--
 net/sctp/socket.c                             |  2 +
 net/vmw_vsock/virtio_transport_common.c       | 12 +++--
 net/xfrm/xfrm_input.c                         | 16 ++++--
 net/xfrm/xfrm_ipcomp.c                        | 12 +++--
 net/xfrm/xfrm_iptfs.c                         | 28 ++++++++--
 net/xfrm/xfrm_policy.c                        | 17 +++---
 net/xfrm/xfrm_state.c                         | 23 ++++++--
 net/xfrm/xfrm_user.c                          |  5 +-
 tools/testing/selftests/net/ioam6.sh          |  2 +-
 32 files changed, 273 insertions(+), 154 deletions(-)

