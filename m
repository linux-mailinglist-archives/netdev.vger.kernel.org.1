Return-Path: <netdev+bounces-268323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDnuJKGJuGlwfgEAu9opvQ
	(envelope-from <netdev+bounces-268323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:52:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD792A1BCE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E26B3091FED
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB83364EBC;
	Mon, 16 Mar 2026 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ITt3HTnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930A37417A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701218; cv=none; b=qsTzEkwMDuese2FszgsFSrTZlZW56r2NjKutDqnyB/toEkrlVsMvQ8xE1TC24fwoYsUglH7s7dcj25NYwuu+Ou2HV8IFa7bKATznAcsBnPqwrlIayVNiVGnrYpg4LqonTGp0vMM6FXtp6Q5HHGsUyCX3JHt18YNIqNaDyr/f7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701218; c=relaxed/simple;
	bh=uRcYOdoEIOTrbzdl5OtQx/obDy/syxMYn1Qli1rs0fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPBZcQeIPWYOHmX66d2aaIsQCBfxKjvSArB/oEWNJIm/G0QQ7GtqPzCc2Bu3C8EuXqePh4HWd/F8SVOLa0dCPtxleIBnUBa1Qw6wlgTZJ3wPomCBYLfrPoBYcYy2HSk+ECHB1LEPsAJ1HwVfoASBikD9Kaxtja841DkydDTmw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ITt3HTnc; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uOPDW+ZTVePxH0gGYlRI4rBYIVODDGVeAgFz5+qHK2o=; t=1773701217; x=1774565217; 
	b=ITt3HTnc/eJzRXBea587StxTj5IZKRq3NlgETPF/zFHAVKKHHsGxmKyJRP7S7/Zt1oKo6giEhQ+
	0JyQOKiF7M8W3w3kOXtesW30P0rpwpwL5iEVr5rgJKTe0udmXCF7A9AbqCnaMi35yQvNXARKpaXXq
	fIc0Fem6aOZdWqIfEWvlFJdQcOn6UVvnUDU1hhL/uM6hLgXsHo7UJ4VG/xzhGHXpL73gUFv29eK31
	1vubsjL7az6+sQjr9D3tCwt+4noooAXDTCbcjIaDNkTkAlCuHLbA4LXXjTTaTPspzuwoKjHAPQAhQ
	+LihpQEWw2xBbhY42SVMq2Dp2QWMSl/9po7A==;
Received: from ouster448.stanford.edu ([172.24.72.71]:53396 helo=ouster2022)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w2GUH-0004uJ-U2; Mon, 16 Mar 2026 15:32:39 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v17 01/14] net: homa: define user-visible API for Homa
Date: Mon, 16 Mar 2026 15:32:13 -0700
Message-ID: <20260316223228.2611-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316223228.2611-1-ouster@cs.stanford.edu>
References: <20260316223228.2611-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: f4a4dde8f780d4bd3651f5249280c166
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268323-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cs.stanford.edu:mid,subdimension.ro:email]
X-Rspamd-Queue-Id: EAD792A1BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
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
 MAINTAINERS               |   7 +
 include/uapi/linux/homa.h | 300 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..1ea0811588ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11656,6 +11656,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA
+F:	net/homa/
+F:      include/uapi/linux/homa.h
+
 HONEYWELL ABP2030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..77e89f538258
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
+#include <linux/types.h>
+#ifndef __KERNEL__
+#include <netinet/in.h>
+#include <sys/socket.h>
+#endif
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
+	size_t length;
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
+		struct sockaddr_storage storage;
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
+	 * information about individual RPCs.
+	 */
+	struct homa_rpc_info *rpc_info;
+
+	/**
+	 * @rpc_info_length: (in) Number of bytes of storage available at
+	 * rpc_info.
+	 */
+	size_t rpc_info_length;
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
+#define HOMAIOCINFO  _IOWR('h', 1, struct homa_info)
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.43.0


