Return-Path: <netdev+bounces-265615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJK+GijvrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946123C5AF
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A99330451E9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E63DBD71;
	Mon,  9 Mar 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fpsnCs/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="039FDwXS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D73DEAC3
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071601; cv=none; b=ZatHedi5QGMYt1LYggbNJmP8y2AOfpWkpmwFWH00Jz8EbFrBMXRhrn3vUefa6U3S2eJ8erPcUcYFkK4Db7Mc+8gHeYjyhONK9YfdauFkJ3Ql1WQgBrqhA83kOvBVuipRkNV7cQyhgOkqsIRnLOeX+aONaF+2MVFOFUrpW01TRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071601; c=relaxed/simple;
	bh=EfeZDEosO+M6F5G/FvLk1SeYgv7uuiq7H7B8kLk2A+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kikkw5HXo2pMjkQDliqec87tIpOcPK7w47Frh8eIZWBnOK0BLBvU5Q+bJuX/wn7vGn7se75V+nzdXnWUrqx0annBZ3iwgl5c7E2SWTc42dRhy3Kj1DLPLOaMho6x/0vALAqH6Hxc9TV7dOiq603XnTPNOEpJ5FTpHswufdLIwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fpsnCs/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=039FDwXS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773071597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQqyjVzSdrj/c3AeSvqR8huj83ceHJGRgwiMHxVNx9g=;
	b=1fpsnCs/nVlu+/mtml5kFFlhh7PhbFnnK0H6iP+Aj1U0hhec0Jna8K86ND1Em3bJuu/3+q
	hE0/EylhJgXs4o7VKoR4kCkFZGFOcVjrmmGax3CylpPuLc542AXaLOx2wRwekuuLJF5Nk5
	8RJ4+CPwgUwAIxKaf5xzAo1f6L0n/q4eBQZQIaBhgJ3vKjEnusH4dXDeotgNIx6wpFnghm
	8ngVP7YbKHk7leI3oy1oXBKpaGLe0RKxLdyLBvCeZ0TeRbEF6fNJD3GqulQBTrY1HJ4NjH
	8F3rGSynasBTx49B1tuSZk96AVFv2AgTJsnXLPYCmLnyOG+ZgdURBx4TKH4lgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773071597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQqyjVzSdrj/c3AeSvqR8huj83ceHJGRgwiMHxVNx9g=;
	b=039FDwXSyDlxxuMBBMlMit9QBGmJTv6t/hZXwxoR9gpuFq0qxGX6BpdmW+lQTuEFq/Be9T
	jVq3y1cvy4LL0jBQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH RFC net-next v2 0/2] hsr: Add additional info to send/ receive skbs
Date: Mon,  9 Mar 2026 16:52:34 +0100
Message-ID: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1946123C5AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265615-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[msgid.link:query timed out];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

I am trying to extend linuxptp to support PTP over a HSR network.

This is the kernel side of the changes. In short PTP over HSR sends its
packets to a multicast address and every node needs to forward the PTP
packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
In order to achieve this, the HSR stack must not duplicate and forward
the PTP packets as it would other packets. The delay caused by the
duplication and forwarding adds overhead which in turn makes the timing
information within the PTP packet inaccurate.

My current approach is to open the hsr0 device from userland and send
and receive the PTP packets individually on both slave interfaces. I
added additional hints to the af_packet interface, which is used by
linuxptp, to be able send a packet on a specific interface (A or B) and
also to have the information recorded for received packets.
Additionally, the PTP-timestamps which arrive on the slave interface are
forwarded to the hsr interface.

This solves the following:
- Forwarding a SYNC and a FOLLOW_UP packet.
  Userland receives a SYNC, FOLLOW_UP and timestamp packet from port A.
  The received port is known and recorded. The SYNC packet and the
  updated FOLLOW_UP packet can then be forwarded on port B. The update
  is based on the time spent during the forward so the forwarding delay
  is accounted for.
  In this scenario the HSR header is used from the original sender of
  the SYNC and FOLLOW_UP header and the stack must not prepand the
  system's HSR header nor replace the provided header.

- Sending PDELAY_REQ and PDELAY_RESP*
  These packets are only exchanged between the two nodes directly
  connected and they must not be forwarded within the HSR ring.
  These packets are sent as PTP packets and the HSR stack must prepand
  system's HSR header including a sequence number.
  This logic is also used for SYNC packet if the node acts as a GM.

This has been tested in a pure software environment and in an HW-assited
environment where the HW is able to duplicate and deduplicate packets
but does not do it for PTP packets.
It has not been tested within an enviroment where the HW is able to
forward the PTP packet and correctly update the timming information.

---
v1=E2=80=A6v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a77da@=
linutronix.de
- Added PRP support
- skb extention is used instead of extending struct skb_shared_info
- in af_packet
  - packet_sendmsg_spkt() is no longer extended
  - jump labels are used to avoid the overhead if there no socket that
    is using this HSR extension.

---
Sebastian Andrzej Siewior (2):
      hsr: Allow to send a specific port and with HSR header
      af_packet: Add port specific handling for HSR

 include/linux/if_hsr.h         |  81 ++++++++++++++++++++
 include/linux/skbuff.h         |   3 +
 include/uapi/linux/if_packet.h |   9 +++
 net/core/skbuff.c              |   4 +
 net/hsr/Kconfig                |   1 +
 net/hsr/hsr_device.c           |   7 ++
 net/hsr/hsr_forward.c          | 118 ++++++++++++++++++++++++++---
 net/hsr/hsr_framereg.h         |   1 +
 net/hsr/hsr_slave.c            |  35 +++++++--
 net/packet/af_packet.c         | 167 +++++++++++++++++++++++++++++++++++++=
++++
 net/packet/internal.h          |   1 +
 11 files changed, 412 insertions(+), 15 deletions(-)
---
base-commit: 3daa4f5dc6cc1ac1ab2f95b5b4c16bc5fb87f48f
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>


