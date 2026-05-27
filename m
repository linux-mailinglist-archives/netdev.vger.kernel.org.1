Return-Path: <netdev+bounces-292342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK8nHTMKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:13:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18F5E6A57
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2ED300D956
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F293428838;
	Wed, 27 May 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRkoPhkJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3l60Ve6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2552426EA2
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894630; cv=none; b=JJVaAjN8GpQp+5MF/I4yfrTSE5Prz47FYY2W+sldTGgu2XKFGQyTRoTr2QXKhjsOsgBGVl4p0yzweRxOtrD2SEQ4H/TX4TPcRsb2En1H4xM0NK17c/WPBNLVX/NaXNY0qCnVBa+tSbFpkcGROUNmQwOZ8PycJxPa5p6YlaGuHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894630; c=relaxed/simple;
	bh=9ZEieCcrkSYiIOTc4VPlo6oflXZSUXBhpfeNOwskez8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpS2AdxBw3rUDXDbN5ZmF4B+NZPayw2bHAyLKbEPfZX1Rj6aRt6EjmM0jY5SL2rv0S3Ic0riG1MmFv/8jdW62fQ30FG40HIpiLG2DlVo5qIAY3z/d0z7PPoMvCfispFLNZL+IN+wLPKHRzU4lAK2Gj3NULOmH9pgb7r6u7VxT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRkoPhkJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3l60Ve6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFCeYLW2qz20PLByRkhB8J0SIUN9K+7WWwsKQQL+15k=;
	b=NRkoPhkJi9kZgfZhzoWZIjK7nVBiZ23VXRDfmPcoMREIIcsOo+wUJ33q/lrqjhLhzpciAW
	mutU4P9sg0pDGkLxeHJYbDLw0IUFd3ITEYC49UnDLtGPW+DaLe2QvxXy6umDv4aGadoYoN
	ov4d94kT1LMhEcc9xmnPgmqTOGcZP5hKm7nZ1gPZqt3sAl5KcsvrgqJpVGd79Rbli2To9V
	bV68Dz+LcgvgaW+1wwBmHEbcarnFXNoJ+0Sqs8/bICB2BJ4RD9T3MeahjF1nllpwHUaK0z
	n/EC+DxVIXr7O5eNIv24O5RATjGOhvEgoBgRWQz5KUiCRXRko3pWz3jzq5ap1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFCeYLW2qz20PLByRkhB8J0SIUN9K+7WWwsKQQL+15k=;
	b=z3l60Ve6X2xNTcKcY8j72AyUAjUC6VWjiVirohCpZXxgrsm8aSBWlOaVHVRzJrvBhUYvSW
	lx64jUpR9ZZKjsCA==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v5 0/8] hsr: Add additional info to send/ receive skbs
Date: Wed, 27 May 2026 17:08:50 +0200
Message-ID: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292342-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC18F5E6A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I am trying to extend linuxptp to support PTP over a HSR network.

This is the kernel side of the changes. In short PTP over HSR sends its
packets to a multicast address and every node needs to forward the PTP
packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
In order to achieve this, the HSR stack must not duplicate and forward
the PTP packets as it would do with other packets. The delay caused by
the duplication and forwarding adds overhead which in turn makes the
timing information within the PTP packet inaccurate.

My current approach is to open the slave devices (eth0/ eth1) from
userland in order to receive the PTP packets. Sending happens from the
hsr0 device. The actual packet has an inline header prepended of type
struct hsr_inline_header. The size of the header is equivalent to
ethhdr. The header has a type (h_proto) at the same position as ethhdr
and expects it to be ETH_P_1588 as this extra meta information is only
relevant for PTP packets. It makes no sense to send PTP packets via the
HSR interface because it gets duplicated and the timestamp information
is lost so this should not break anything. As an additional safe guard
there is a magic value at h_source position. The value has '0xaf' at the
most significant byte which makes the address a locally administered
multicast address.

The header passes two information from userland: On which slave port
the packet has to be sent and does the HSR stack need to prepend a
header or not.
The header is skipped so that the remaining stack sees the actual data
and can send it as requested.

The PRP packets are sent directly via the SLAVE interface. The standard
mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
packets. There is not really a reason to use hsr interface.

HSR hardware offloading is optional. The driver needs to know if the
operating mode is HSR or PRP. In PRP mode it needs to check the ether
type and for ETH_P_1588 it must not perform any offloading.
In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
the ether-type is ETH_P_HSR there must be no offloading if the
encapsulated protocol is ETH_P_1588.

This has been tested in a pure software environment and in an HW-assisted
environment where the HW is able to duplicate and duplicate packets
but does not do it for PTP packets.
It has not been tested within an environment where the HW is able to
forward the PTP packet and correctly update the timing information.

---
v4=E2=80=A6v5: https://lore.kernel.org/r/20260508-hsr_ptp-v4-1-aa19aa7c6a71=
@linutronix.de
- Split the patch into smaller pieces
- Added a test for the added inline header (which signals the port while
  sending packets).
- Replaced __pskb_copy() with skb_clone() + skb_cow_head() in
  hsr_create_tagged_frame() to preserve timestamp request.

v3=E2=80=A6v4: https://lore.kernel.org/r/20260429-hsr_ptp-v3-1-afbf8f200f48=
@linutronix.de
- Removed skb extention. The information within HSR is passed via
  struct hsr_frame_info. Driver with HSR-offloading capabilities need to
  know the HSR mode (HSR or PRP) and parse the skb to decide what needs
  to be done (whether to send on both ports and if adding a header is
  needed).

v2=E2=80=A6v3: https://patch.msgid.link/20260309-hsr_ptp-v2-0-798262aad3a4@=
linutronix.de
- Remove af_packet changes entirely.
- Add an internal header to pass additional information for HSR-PTP
  packets.
- Remove PRP, userland will use slave devices directly.
- Drop all received PTP packets. Userland needs to use the slave device
  for RX.

v1=E2=80=A6v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a77da@=
linutronix.de
- Added PRP support
- skb extention is used instead of extending struct skb_shared_info
- in af_packet
  - packet_sendmsg_spkt() is no longer extended
  - jump labels are used to avoid the overhead if there no socket that
    is using this HSR extension.

---
Sebastian Andrzej Siewior (8):
      hsr: Add header_ops::parse_protocol
      hsr: Use skb_clone() while adding the HSR header
      hsr: Add a magic header for sending PTP packets
      hsr: Drop received PTP packets
      hsr: Use the port and header information in hsr_forward_skb()
      hsr: Assign a socket for cloned skbs
      hsr: Move struct hsr_ethhdr to a global header
      selftests: hsr: Add test for the inline PTP header on HSR

 include/linux/if_hsr.h                         |  16 +
 net/hsr/hsr_device.c                           |  62 +++-
 net/hsr/hsr_forward.c                          |  77 ++++-
 net/hsr/hsr_forward.h                          |   3 +-
 net/hsr/hsr_framereg.h                         |   2 +
 net/hsr/hsr_main.h                             |   5 -
 net/hsr/hsr_slave.c                            |  37 ++-
 tools/testing/selftests/net/hsr/.gitignore     |   1 +
 tools/testing/selftests/net/hsr/Makefile       |   3 +
 tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
 tools/testing/selftests/net/hsr/hsr_ptp_test.c | 438 +++++++++++++++++++++=
++++
 11 files changed, 710 insertions(+), 43 deletions(-)
---
base-commit: 9e171fc1d7d7ab847a750c03571c87ac3c17bd84
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>


