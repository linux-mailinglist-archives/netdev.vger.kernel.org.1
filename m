Return-Path: <netdev+bounces-282137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODwCB/pA8WlsfQEAu9opvQ
	(envelope-from <netdev+bounces-282137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:21:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75648CF82
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3243F3012D79
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6D38B7A6;
	Tue, 28 Apr 2026 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ADYl0HFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAB389DE0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418477; cv=none; b=QSKdxGSoK6nrKEVJplg8ptJCfj6+3ZlSRPVTxsd79ZbfpXeMBsCPxJJzuY4ckq+zDvWdaSpc0GhkG2POk/C3UxA6YTjmQC6qDvjovXzGSooubCXYQi9aWNPlFAKnnnGQMX6qcE2B7IHoMff/zYGu9876vqIc8tGoGvh3W0PW0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418477; c=relaxed/simple;
	bh=iXCqb/jSypGjzOWEfsFzFNgXngZBr1Y04Eqa5PYfze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMeC/PVzCiODmMWpnj2Ssd3BPaVxCd6G65/0dlOP2dCJVtzJIlGhmL11M+fRAvoisXwZbJkWE/uCXQx7q3OSx61Hd5poLknu35e3KyLrHku1hG5UhW124YeqoN9Reqv+pB1A2/UsUfcrZaFg4ULGSo98bwLAJP3vS5enu06nmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ADYl0HFO; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RsM3pgwyAzi6Q7rWTAjJJ1D+QxJTs68za7yGKOcKsSE=; t=1777418475; x=1778282475; 
	b=ADYl0HFO/q19fZD6EO2F50rp0+KKjopJyI8g9eoQqltkTATPSL5FdDUrYiMnB31xcGa313tCrmE
	1UamHsDSs6vG7P1x6uOm+n2K+cRaoKYyt+vurk/B8yJMvqY2TDtTKpVu+VTzDRUhNX3Thpdx81P4r
	gNEklKECIxsjhv8wTKk+2k56kF87f9NCEL+k17/3TcLezHAVXlbOAGkE8TfTLNLQGO0geMJQOHdlU
	mnSYDZT4LFvqX3XwyT06L0v4E9YUEVOmtKKsRRk3ivaiikEJnKqdmfvHHS+irvZ2fSWao9XhNjjW+
	jMRW5cq8vibVtBXCbNhjrrICOgezx+S3QPOQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:54475 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wHreJ-0005UM-NJ; Tue, 28 Apr 2026 16:15:29 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v19 01/15] net: homa: define user-visible API for Homa
Date: Tue, 28 Apr 2026 16:15:04 -0700
Message-ID: <20260428231520.1857-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428231520.1857-1-ouster@cs.stanford.edu>
References: <20260428231520.1857-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: fa7c0fddc7e344a07e8bf75884be31b0
X-Rspamd-Queue-Id: 0F75648CF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282137-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.556];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanford.edu:email,atlassian.net:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cs.stanford.edu:mid,subdimension.ro:email,interlan.net:email]

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v19:
* Change ioctl numbers to use numbers not currently in use.

Changes for v18:
* Fix types to conform to Linux standards (e.g. __u64 instead of size_t)

Changes for v16:
* Implement HOMAIOCINFO ioctl.

Changes for v14:
* Add "WITH Linux-syscall-note" SPDX license note

Changes for v11:
* Add explicit padding to struct homa_recvmsg_args to fix problems compiling
  on 32-bit machines.

Changes for v9:
* Eliminate use of _Static_assert
* Remove declarations related to now-defunct homa_api.c

Changes for v7:
* Add HOMA_SENDMSG_NONBLOCKING flag for sendmsg
* API changes for new mechanism for waiting for incoming messages
* Add setsockopt SO_HOMA_SERVER (enable incoming requests)
* Use u64 and __u64 properly
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 include/uapi/linux/homa.h                     | 300 ++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761fff..8107ef37dd4d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -256,6 +256,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:zapman@interlan.net>
 'h'   00-1F  linux/hpet.h                                              conflict!
 'h'   80-8F  fs/hfsplus/ioctl.c
+'h'   90-8F  uapi/linux/homa.h
 'i'   00-3F  linux/i2o-dev.h                                           conflict!
 'i'   0B-1F  linux/ipmi.h                                              conflict!
 'i'   80-8F  linux/i8k.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..467814ca426a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11732,6 +11732,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
+F:	include/uapi/linux/homa.h
+F:	net/homa/
+
 HONEYWELL ABP2030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..9e21b4b251e2
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ WITH Linux-syscall-note */
+
+/* This file defines the kernel call interface for the Homa
+ * transport protocol.
+ */
+
+#ifndef _UAPI_LINUX_HOMA_H
+#define _UAPI_LINUX_HOMA_H
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+/* IANA-assigned Internet Protocol number for Homa. */
+#define IPPROTO_HOMA 146
+
+/**
+ * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
+ * request or response message.
+ */
+#define HOMA_MAX_MESSAGE_LENGTH 1000000
+
+/**
+ * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
+ * buffers. Must be power of two.
+ */
+#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
+#define HOMA_BPAGE_SHIFT 16
+
+/**
+ * define HOMA_MAX_BPAGES - The largest number of bpages that will be required
+ * to store an incoming message.
+ */
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) >> \
+		HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MIN_DEFAULT_PORT - The 16 bit port space is divided into
+ * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
+ * for well-defined server ports. The remaining ports are used for client
+ * ports; these are allocated automatically by Homa. Port 0 is reserved.
+ */
+#define HOMA_MIN_DEFAULT_PORT 0x8000
+
+/**
+ * struct homa_sendmsg_args - Provides information needed by Homa's
+ * sendmsg; passed to sendmsg using the msg_control field.
+ */
+struct homa_sendmsg_args {
+	/**
+	 * @id: (in/out) An initial value of 0 means a new request is
+	 * being sent; nonzero means the message is a reply to the given
+	 * id. If the message is a request, then the value is modified to
+	 * hold the id of the new RPC.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (in) Used only for request messages; will be
+	 * returned by recvmsg when the RPC completes. Typically used to
+	 * locate app-specific info about the RPC.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	__u32 flags;
+
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
+};
+
+/* Flag bits for homa_sendmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_SENDMSG_PRIVATE       0x01
+#define HOMA_SENDMSG_VALID_FLAGS   0x01
+
+/**
+ * struct homa_recvmsg_args - Provides information needed by Homa's
+ * recvmsg; passed to recvmsg using the msg_control field.
+ */
+struct homa_recvmsg_args {
+	/**
+	 * @id: (in/out) Initial value is 0 to wait for any shared RPC;
+	 * nonzero means wait for that specific (private) RPC. Returns
+	 * the id of the RPC received.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (out) If the incoming message is a response,
+	 * this will return the completion cookie specified when the
+	 * request was sent. For requests this will always be zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	__u32 num_bpages;
+
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
+
+	/**
+	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
+	 * region for the socket pool. When returned from recvmsg, the
+	 * offsets indicate where fragments of the new message are stored. All
+	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE
+	 * bytes) and are bpage-aligned. The last entry may refer to a bpage
+	 * fragment and is not necessarily aligned. The application now owns
+	 * these bpages and must eventually return them to Homa, using
+	 * bpage_offsets in a future recvmsg invocation.
+	 */
+	__u32 bpage_offsets[HOMA_MAX_BPAGES];
+};
+
+/** define SO_HOMA_RCVBUF: setsockopt option for specifying buffer region. */
+#define SO_HOMA_RCVBUF 10
+
+/**
+ * define SO_HOMA_SERVER: setsockopt option for specifying whether a
+ * socket will act as server.
+ */
+#define SO_HOMA_SERVER 11
+
+/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
+struct homa_rcvbuf_args {
+	/** @start: Address of first byte of buffer region in user space. */
+	__u64 start;
+
+	/** @length: Total number of bytes available at @start. */
+	__u64 length;
+};
+
+/* Meanings of the bits in Homa's flag word, which can be set using
+ * "sysctl /net/homa/flags".
+ */
+
+/**
+ * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism
+ * (always send all packets immediately).
+ */
+#define HOMA_FLAG_DONT_THROTTLE   2
+
+/**
+ * struct homa_rpc_info - Used by HOMAIOCINFO to return information about
+ * a specific RPC.
+ */
+struct homa_rpc_info {
+	/**
+	 * @id: Identifier for the RPC, unique among all RPCs sent by the
+	 * client node. If the low-order bit is 1, this node is the server
+	 * for the RPC; 0 means we are the client.
+	 */
+	__u64 id;
+
+	/** @peer: Address of the peer socket for this RPC. */
+	union {
+		struct __kernel_sockaddr_storage storage;
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	} peer;
+
+	/**
+	 * @completion_cookie: For client-side RPCs this gives the completion
+	 * cookie specified when the RPC was initiated. For server-side RPCs
+	 * this is zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @tx_length: Length of the outgoing message in bytes, or -1 if
+	 * the sendmsg hasn't yet been called.
+	 */
+	__s32 tx_length;
+
+	/**
+	 * @tx_sent: Number of bytes of the outgoing message that have been
+	 * transmitted at least once.
+	 */
+	__u32 tx_sent;
+
+	/**
+	 * @tx_granted: Number of bytes of the outgoing message that the
+	 * receiver has authorized us to transmit (includes unscheduled
+	 * bytes).
+	 */
+	__u32 tx_granted;
+
+	/** @reserved: Reserved for future use. */
+	__u32 reserved;
+
+	/**
+	 * @rx_length: Length of the incoming message, in bytes. -1 means
+	 * the length is not yet known (this is a client-side RPC and
+	 * no packets have been received).
+	 */
+	__s32 rx_length;
+
+	/**
+	 * @rx_remaining: Number of bytes in the incoming message that have
+	 * not yet been received.
+	 */
+	__u32 rx_remaining;
+
+	/**
+	 * @rx_gaps: The number of gaps in the incoming message. A gap is
+	 * a range of bytes that have not been received yet, but bytes after
+	 * the gap have been received.
+	 */
+	__u32 rx_gaps;
+
+	/**
+	 * @rx_gap_bytes: The total number of bytes in gaps in the incoming
+	 * message.
+	 */
+	__u32 rx_gap_bytes;
+
+	/**
+	 * @rx_granted: The number of bytes in the message that the sender
+	 * is authorized to transmit (includes unscheduled bytes).
+	 */
+	__u32 rx_granted;
+
+	/**
+	 * @flags: Various single-bit values associated with the RPC:
+	 * HOMA_RPC_BUF_STALL:  The incoming message is currently stalled
+	 *                      because there is insufficient receiver buffer
+	 *                      space.
+	 * HOMA_RPC_PRIVATE:    The RPC has been created as "private"; set
+	 *                      only on the client side.
+	 * HOMA_RPC_RX_READY:   The incoming message is complete and has
+	 *                      been queued waiting for a thread to call
+	 *                      recvmsg.
+	 * HOMA_RPC_RX_COPY:    There are packets that have been received,
+	 *                      whose data has not yet been copied from
+	 *                      packet buffers to user space.
+	 */
+	__u16 flags;
+#define HOMA_RPC_BUF_STALL    1
+#define HOMA_RPC_PRIVATE      2
+#define HOMA_RPC_RX_READY     4
+#define HOMA_RPC_RX_COPY      8
+};
+
+/**
+ * struct homa_info - In/out argument passed to HOMAIOCINFO. Fields labeled
+ * as "in" must be set by the application; other fields are returned to the
+ * application from the kernel.
+ */
+struct homa_info {
+	/**
+	 * @rpc_info: (in) Address of memory region in which to store
+	 * information about individual RPCs. Actual type is
+	 * "struct homa_rpc_info *".
+	 */
+	__u64 rpc_info;
+
+	/**
+	 * @rpc_info_length: (in) Number of bytes of storage available at
+	 * rpc_info.
+	 */
+	__u64 rpc_info_length;
+
+	/**
+	 * @bpool_avail_bytes: Number of bytes in the buffer pool for incoming
+	 * messages that is currently available for new messages.
+	 */
+	__u64 bpool_avail_bytes;
+
+	/** @port: Port number handled by this socket. */
+	__u32 port;
+
+	/**
+	 * @num_rpcs: Total number of active RPCs (both server and client) for
+	 * this socket. The number stored at @rpc_info will be less than this
+	 * if @rpc_info_length is too small.
+	 */
+	__u32 num_rpcs;
+
+	/**
+	 * @error_msg: Provides additional information about the last error
+	 * returned by a Homa-related kernel call such as sendmsg, recvmsg,
+	 * or ioctl. Not updated for some obvious return values such as EINTR
+	 * or EWOULDBLOCK.
+	 */
+#define HOMA_ERROR_MSG_SIZE 100
+	char error_msg[HOMA_ERROR_MSG_SIZE];
+};
+
+/* I/O control calls on Homa sockets.*/
+#define HOMAIOCINFO  _IOWR('h', 0x90, struct homa_info)
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.43.0


