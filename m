Return-Path: <netdev+bounces-292350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI/nC5sKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:15:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796CF5E6ABF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD6D307375C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68942983C;
	Wed, 27 May 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llv4IKEf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJ1q/iwK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF44279E9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894646; cv=none; b=XiX1x+4FjJTuTXQPpYLMcr16Ve9hoOnuE0Z56lL/6nC8uUeKzdwCE/+SWwjCk1vWJ8yX1TKu+DhUG8Kih9jLzByDpTwOJJ39hCXSbA2WTd+woHETSuK6f17Y6Gzo4017tAW8IDy9fWkSfUwlsnXjZv4QQFh1S1aaK1C8X9aTTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894646; c=relaxed/simple;
	bh=g00hsTD+eQ47ShvAvTB993wWZNDT0rmGyXssLMx+5+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2RD5Ktfp5qdg5vJZfJS67TfbJSD1Hsw4Xr62qwilQZz1HoAUVIshz8aXmVMDelNgns00Yusg4jxRMjfJsiMq1blrHffnEhsXs2zc70bocTSwXq2JZ9Z6W6j9MYWyib8QMY37AYdd8mT5ccRIb+Krzov6o/KqniGjin7DhJiSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llv4IKEf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJ1q/iwK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyOM3jh0aOrLdKY3uIKIft0ADYNW2WtUX14WVL/FwbY=;
	b=llv4IKEfsoYMJXrqpGF8794fKhqieC02+cYW+ARanT5XsQH4v2bAS+7R5OMhbgQHmS3vYY
	fd32yW2X01+vGTaW2aJ24x7B1rUZ3PHr8ShgYkJGoIR/IeyaKJBQj1UYUqKobOeg691NFU
	VBHFE7A2Y7an59p+zqAuH0kiXZ8yKMOfY1JtLl0+pyp5kfvMICC11oiJRUJT3eBTTtQmrG
	n/ACRqWTQ0smzlz0tHvnKgTHFLrOGg4wpDoQS45072LMHp2F0k9yUxjmcRbP9XYIoIbIcM
	uEeckP2BQkcAgxpwP2UWnYjItd0z6XE66S3qHddPUcn1ePhudzdNUcQ3EcNGJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyOM3jh0aOrLdKY3uIKIft0ADYNW2WtUX14WVL/FwbY=;
	b=bJ1q/iwKbQxt0GCQP77WZRm4wKJxL90eKmC6enHZJ3wGSsnM4CEICKd8bnWdFH6IiBzrjO
	JjmzDcOGqK3iX5DQ==
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
Subject: [PATCH net-next v5 8/8] selftests: hsr: Add test for the inline PTP header on HSR
Date: Wed, 27 May 2026 17:08:58 +0200
Message-ID: <20260527-hsr_ptp-v5-8-158a7633eac0@linutronix.de>
In-Reply-To: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
	TAGGED_FROM(0.00)[bounces-292350-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,hsr_ptp.sh:url]
X-Rspamd-Queue-Id: 796CF5E6ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This test verifies the inline header which is used by HSR stack with the
ether type ETH_P_1588.
The HSR stack needs to recognize this header, strip it and send the
requested packet only on the requested port.

This test needs a HSR device and the two slave devices passed. It will
will send a sample PTP packet with this inline header, requesting one of
the ports combining with and without the HSR header. A total of four
packets is sent.
The test checks both ports devices for packets and complains if the
packet was not observed on the expected port and/ or observed on the
other port. The received content of the data is compared against the
send data sample.

Requested-by: Felix Maurer <fmaurer@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/net/hsr/.gitignore     |   1 +
 tools/testing/selftests/net/hsr/Makefile       |   3 +
 tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
 tools/testing/selftests/net/hsr/hsr_ptp_test.c | 438 +++++++++++++++++++++=
++++
 4 files changed, 551 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/.gitignore b/tools/testing/sel=
ftests/net/hsr/.gitignore
new file mode 100644
index 0000000000000..849eecb84c974
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/.gitignore
@@ -0,0 +1 @@
+hsr_ptp_test
diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selft=
ests/net/hsr/Makefile
index 31fb9326cf533..ec11fee56d8f8 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -7,8 +7,11 @@ TEST_PROGS :=3D \
 	hsr_redbox.sh \
 	link_faults.sh \
 	prp_ping.sh \
+	hsr_ptp.sh \
 # end of TEST_PROGS
=20
 TEST_FILES +=3D hsr_common.sh
=20
+TEST_GEN_PROGS :=3D hsr_ptp_test
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/hsr/hsr_ptp.sh b/tools/testing/sel=
ftests/net/hsr/hsr_ptp.sh
new file mode 100755
index 0000000000000..034c635916f81
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_ptp.sh
@@ -0,0 +1,109 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ipv6=3Dfalse
+
+source ./hsr_common.sh
+
+optstring=3D"h4"
+usage() {
+	echo "Usage: $0"
+}
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage $0
+		exit 0
+		;;
+	"?")
+		usage $0
+		exit 1
+		;;
+esac
+done
+
+setup_hsr_interfaces()
+{
+	local HSRv=3D"$1"
+
+	echo "INFO: Preparing interfaces for HSRv${HSRv}."
+# Three HSR nodes. Each node has one link to each of its neighbour, two li=
nks in total.
+
+#    ns1eth1 ----- ns2eth1
+#      hsr1         hsr2
+#    ns1eth2       ns2eth2
+#       |            |
+#    ns3eth1      ns3eth2
+#           \    /
+#            hsr3
+#
+	# Interfaces
+	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
+	ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
+	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
+
+	# HSRv0/1
+	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 \
+		slave2 ns1eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 \
+		slave2 ns2eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 \
+		slave2 ns3eth2 supervision 45 version "$HSRv" proto 0
+
+	# IP for HSR
+	ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
+	ip -net "$ns1" addr add dead:beef:0::1/64 dev hsr1 nodad
+	ip -net "$ns2" addr add 100.64.0.2/24 dev hsr2
+	ip -net "$ns2" addr add dead:beef:0::2/64 dev hsr2 nodad
+	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
+	ip -net "$ns3" addr add dead:beef:0::3/64 dev hsr3 nodad
+
+	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
+	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
+
+	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
+	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
+
+	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
+
+	# All Links up
+	ip -net "$ns1" link set ns1eth1 up
+	ip -net "$ns1" link set ns1eth2 up
+	ip -net "$ns1" link set hsr1 up
+
+	ip -net "$ns2" link set ns2eth1 up
+	ip -net "$ns2" link set ns2eth2 up
+	ip -net "$ns2" link set hsr2 up
+
+	ip -net "$ns3" link set ns3eth1 up
+	ip -net "$ns3" link set ns3eth2 up
+	ip -net "$ns3" link set hsr3 up
+}
+
+run_ptp_hdr_tests()
+{
+	echo "INFO: Running PTP-header tests."
+
+	ip netns exec "$ns1" ./hsr_ptp_test -H hsr1 -A ns1eth1 -B ns1eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns1)."
+
+	ip netns exec "$ns2" ./hsr_ptp_test -H hsr2 -A ns2eth1 -B ns2eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns2)."
+
+	ip netns exec "$ns3" ./hsr_ptp_test -H hsr3 -A ns3eth1 -B ns3eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns3)."
+}
+
+check_prerequisites
+trap cleanup_all_ns EXIT
+
+setup_ns ns1 ns2 ns3
+setup_hsr_interfaces 1
+run_ptp_hdr_tests
+
+exit $ret
diff --git a/tools/testing/selftests/net/hsr/hsr_ptp_test.c b/tools/testing=
/selftests/net/hsr/hsr_ptp_test.c
new file mode 100644
index 0000000000000..881a723afa847
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_ptp_test.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple test to verify the usage of the inline header used for HSR with
+ * ether type ETH_P_1588.
+ * The inline header has to be stripped, the sent packet must only appear =
on the
+ * specified port and the interface needs to accept a foreign HSR header a=
nd
+ * prepand its own header.
+ *
+ * Socket handling inspired by raw.c from linuxptp.
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/if_ether.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <netpacket/packet.h>
+#include <sys/ioctl.h>
+
+#define PORT_1	1
+#define PORT_2	2
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+/* HSR Magic */
+#define HSR_INLINE_HDR 0xaf485352
+struct hsr_inline_header {
+	uint8_t tx_port;
+	uint8_t hsr_hdr;
+	uint8_t __pad0[4];
+	uint32_t magic;
+	uint8_t __pad1[2];
+	uint16_t eth_type;
+} __packed;
+
+#define MAC_LEN  6
+typedef uint8_t eth_addr[MAC_LEN];
+
+struct eth_hdr {
+	eth_addr dst;
+	eth_addr src;
+	uint16_t type;
+} __packed;
+
+struct hsr_hdr {
+	eth_addr dst;
+	eth_addr src;
+	uint16_t type;
+	uint16_t pathid_and_LSDU_size;
+	uint16_t sequence_nr;
+	uint16_t encap_type;
+} __packed;
+
+struct hsr_meta_header {
+	struct hsr_inline_header hsr_opt;
+	union {
+		struct hsr_hdr hsr_hdr;
+		struct eth_hdr eth_hdr;
+	};
+} __packed;
+
+static uint8_t ptp_packet[] =3D {
+	0x00, 0x12, 0x00, 0x2c, 0x00, 0x00, 0x02, 0x00,  0x00, 0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x88, 0x88, 0x88,  0x88, 0x88, 0x88, 0x88, =
0x00, 0x01, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x00, =
0x00, 0x00,
+};
+
+static uint8_t p2p_dst_mac[MAC_LEN] =3D {
+	0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e
+};
+
+static uint8_t slave_mac_addr[MAC_LEN];
+static int32_t fd_slaveA =3D -1;
+static int32_t fd_slaveB =3D -1;
+static int32_t fd_hsr =3D -1;
+static uint16_t hsr_seq =3D 37;
+
+static int sk_interface_index(int fd, const char *name)
+{
+	struct ifreq ifreq;
+	int32_t err;
+
+	memset(&ifreq, 0, sizeof(ifreq));
+	strncpy(ifreq.ifr_name, name, sizeof(ifreq.ifr_name) - 1);
+	err =3D ioctl(fd, SIOCGIFINDEX, &ifreq);
+	if (err < 0) {
+		printf("ioctl SIOCGIFINDEX failed: %m\n");
+		return err;
+	}
+	return ifreq.ifr_ifindex;
+}
+
+static int open_socket(const char *name, uint8_t *local_addr,
+		       uint8_t *p2p_dst_mac)
+{
+	struct sockaddr_ll addr;
+	int32_t fd, index;
+
+	fd =3D socket(AF_PACKET, SOCK_RAW, 0);
+	if (fd < 0) {
+		printf("socket failed: %m\n");
+		goto err;
+	}
+	index =3D sk_interface_index(fd, name);
+	if (index < 0)
+		goto err;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sll_ifindex =3D index;
+	addr.sll_family =3D AF_PACKET;
+	addr.sll_protocol =3D htons(ETH_P_ALL);
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr))) {
+		printf("bind failed: %m\n");
+		goto err;
+	}
+	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))) {
+		printf("setsockopt SO_BINDTODEVICE failed: %m\n");
+		goto err;
+	}
+
+	return fd;
+err:
+	if (fd >=3D 0)
+		close(fd);
+	return -1;
+}
+
+static int sk_interface_macaddr(const char *name)
+{
+	struct ifreq ifreq;
+	int32_t err, fd;
+
+	memset(&ifreq, 0, sizeof(ifreq));
+	strncpy(ifreq.ifr_name, name, sizeof(ifreq.ifr_name) - 1);
+
+	fd =3D socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (fd < 0) {
+		printf("socket failed: %m\n");
+		return -1;
+	}
+
+	err =3D ioctl(fd, SIOCGIFHWADDR, &ifreq);
+	if (err < 0) {
+		printf("ioctl SIOCGIFHWADDR failed: %m\n");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	memcpy(slave_mac_addr, &ifreq.ifr_hwaddr.sa_data, MAC_LEN);
+	return 0;
+}
+
+static int raw_open(const char *hsr_dev, const char *slaveA_dev, const cha=
r *slaveB_dev)
+{
+
+	if (sk_interface_macaddr(slaveA_dev))
+		goto err;
+
+	fd_slaveA =3D open_socket(slaveA_dev, slave_mac_addr, p2p_dst_mac);
+	if (fd_slaveA < 0)
+		goto err;
+
+	fd_slaveB =3D open_socket(slaveB_dev, slave_mac_addr, p2p_dst_mac);
+	if (fd_slaveB < 0)
+		goto err;
+
+	fd_hsr =3D open_socket(hsr_dev, slave_mac_addr, p2p_dst_mac);
+	if (fd_hsr < 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (fd_slaveA >=3D 0)
+		close(fd_slaveA);
+	if (fd_slaveB >=3D 0)
+		close(fd_slaveB);
+	if (fd_hsr >=3D 0)
+		close(fd_hsr);
+
+	return -1;
+}
+
+static int sk_receive(int fd, void *buf, int buflen)
+{
+	uint8_t control[256];
+	struct iovec iov =3D { buf, buflen };
+	struct msghdr msg;
+	int32_t cnt =3D 0;
+
+	memset(control, 0, sizeof(control));
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_iov =3D &iov;
+	msg.msg_iovlen =3D 1;
+	msg.msg_control =3D control;
+	msg.msg_controllen =3D sizeof(control);
+
+	cnt =3D recvmsg(fd, &msg, MSG_DONTWAIT);
+	if (cnt < 0)
+		return 0;
+	return cnt;
+}
+
+static int raw_recv(int fd, void *sample, int sample_len)
+{
+	struct hsr_hdr *hsr_hdr;
+	uint8_t buf[1500];
+	int32_t cnt;
+
+again:
+	cnt =3D sk_receive(fd, buf, sizeof(buf));
+	if (cnt =3D=3D 0)
+		return 0;
+
+	if (cnt < sizeof(struct hsr_hdr))
+		goto again;
+
+	hsr_hdr =3D (void *)buf;
+	/* Embedded magic packet passed? */
+	if (hsr_hdr->type =3D=3D htons(ETH_P_1588)) {
+		struct hsr_inline_header *hsr_opt =3D (void *)buf;
+
+		if (hsr_opt->magic =3D=3D ntohl(HSR_INLINE_HDR)) {
+			printf("Error: Found HSR_INLINE_HDR\n");
+			return -1;
+		}
+	}
+	/* Assuming it is *our* network and nobody but the test here sends
+	 * packets to p2p_dst_mac. Therefore any received packet needs to be
+	 * ours and every mismatch is considered as error.
+	 */
+	if (memcmp(hsr_hdr->dst, p2p_dst_mac, MAC_LEN))
+		goto again;
+
+	if (hsr_hdr->type !=3D htons(ETH_P_HSR)) {
+		printf("Error: Unexpected ether type: 0x%x\n", htons(hsr_hdr->type));
+		return -1;
+	}
+
+	if (hsr_hdr->encap_type !=3D htons(ETH_P_1588)) {
+		printf("Error: Unexpected encapsulated type: 0x%x\n",
+		       htons(hsr_hdr->encap_type));
+		return -1;
+	}
+
+	if (cnt < sizeof(struct hsr_hdr) + sample_len) {
+		printf("Error: Packet %d is too small for data check\n", cnt);
+		return -1;
+	}
+
+	if (!memcmp(&buf[sizeof(struct hsr_hdr)], sample, sample_len))
+		return 1;
+
+	printf("Error: Packet did not match the sample\n");
+	return -1;
+}
+
+static int recv_verify(int port, void *sample, int sample_len)
+{
+	int32_t error =3D 0;
+	int32_t ret;
+
+	ret =3D raw_recv(fd_slaveA, sample, sample_len);
+	if (ret < 0)
+		return ret;
+	if (port =3D=3D PORT_1 && ret =3D=3D 0) {
+		printf("Error: Missing packet on portA\n");
+		error =3D 1;
+	}
+	if (port =3D=3D PORT_2 && ret =3D=3D 1) {
+		printf("Error: Not expecting packet on portA\n");
+		error =3D 1;
+	}
+
+	ret =3D raw_recv(fd_slaveB, sample, sample_len);
+	if (ret < 0)
+		return ret;
+	if (port =3D=3D PORT_2 && ret =3D=3D 0) {
+		printf("Error: Missing packet on portB\n");
+		error =3D 1;
+	}
+	if (port =3D=3D PORT_1 && ret =3D=3D 1) {
+		printf("Error: Not expecting packet on portB\n");
+		error =3D 1;
+	}
+	return error;
+}
+
+static int32_t pkt_send(int port, bool hsr_hdr, void *data, int data_len)
+{
+	struct hsr_meta_header *hdr;
+	uint8_t packet[200];
+	ssize_t cnt;
+	size_t len;
+
+	memset(packet, 0, sizeof(packet));
+
+	len =3D sizeof(struct hsr_inline_header);
+	hdr =3D (struct hsr_meta_header *)packet;
+	memset(&hdr->hsr_opt, 0, sizeof(hdr->hsr_opt));
+	hdr->hsr_opt.magic =3D ntohl(HSR_INLINE_HDR);
+	hdr->hsr_opt.eth_type =3D htons(ETH_P_1588);
+	if (port !=3D PORT_1 && port !=3D PORT_2) {
+		printf("Wrong port requested\n");
+		return -1;
+	}
+	hdr->hsr_opt.tx_port =3D port;
+
+	if (hsr_hdr) {
+		uint16_t pathid_size;
+
+		len +=3D sizeof(struct hsr_hdr);
+		memcpy(&packet[len], data, data_len);
+
+		hdr->hsr_opt.hsr_hdr =3D 1;
+
+		memcpy(&hdr->hsr_hdr.dst, p2p_dst_mac, MAC_LEN);
+		memcpy(&hdr->hsr_hdr.src, slave_mac_addr, MAC_LEN);
+		/* Flip a bit in SRC MAC addr so it does not look like hosts */
+		hdr->hsr_hdr.src[3] ^=3D 0x21;
+
+		hdr->hsr_hdr.type =3D htons(ETH_P_HSR);
+		hdr->hsr_hdr.sequence_nr =3D htons(hsr_seq++);
+		hdr->hsr_hdr.encap_type =3D htons(ETH_P_1588);
+
+		/* The resulting packet must be alteast 66 bytes */
+		if (data_len + sizeof(struct hsr_hdr) < 66)
+			data_len =3D 66 - sizeof(struct hsr_hdr);
+
+		pathid_size =3D data_len + sizeof(struct hsr_hdr) - sizeof(struct eth_hd=
r);
+		pathid_size |=3D (port - 1) << 12;
+
+		hdr->hsr_hdr.pathid_and_LSDU_size =3D ntohs(pathid_size);
+	} else {
+		len +=3D sizeof(struct eth_hdr);
+		hdr->hsr_opt.hsr_hdr =3D 0;
+
+		memcpy(&hdr->eth_hdr.dst, p2p_dst_mac, MAC_LEN);
+		memcpy(&hdr->hsr_hdr.src, slave_mac_addr, MAC_LEN);
+		hdr->eth_hdr.type =3D htons(ETH_P_1588);
+
+		memcpy(&packet[len], data, data_len);
+	}
+
+	cnt =3D send(fd_hsr, packet, len + data_len, 0);
+	if (cnt < 1)
+		return -1;
+
+	return cnt;
+}
+
+int main(int argc, char *argv[])
+{
+	char *slaveA =3D NULL, *slaveB =3D NULL, *hsr_dev =3D NULL;
+	char *msg_mode;
+	int opt;
+
+	while ((opt =3D getopt(argc, argv, "A:B:H:")) !=3D -1) {
+		switch (opt) {
+		case 'A':
+			slaveA =3D strdup(optarg);
+			break;
+
+		case 'B':
+			slaveB =3D strdup(optarg);
+			break;
+
+		case 'H':
+			hsr_dev =3D strdup(optarg);
+			break;
+		default: /* '?' */
+			fprintf(stderr, "Usage: %s -A slaveA -B slaveB -H hsr_device\n",
+				argv[0]);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (!slaveA || !slaveB || !hsr_dev) {
+		fprintf(stderr, "Missing network devices\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (raw_open(hsr_dev, slaveA, slaveB) < 0)
+		return EXIT_FAILURE;
+
+	msg_mode =3D "PortA, no-hsr-header";
+	if (pkt_send(PORT_1, false, ptp_packet, sizeof(ptp_packet)) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(PORT_1, ptp_packet, sizeof(ptp_packet))) {
+		printf("Verify failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortB, no-hsr-header";
+	if (pkt_send(PORT_2, false, ptp_packet, sizeof(ptp_packet)) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(PORT_2, ptp_packet, sizeof(ptp_packet))) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortA, hsr-header";
+	if (pkt_send(PORT_1, true, ptp_packet, sizeof(ptp_packet)) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(PORT_1, ptp_packet, sizeof(ptp_packet))) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortB, hsr-header";
+	if (pkt_send(PORT_2, true, ptp_packet, sizeof(ptp_packet)) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(PORT_2, ptp_packet, sizeof(ptp_packet))) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}

--=20
2.53.0


