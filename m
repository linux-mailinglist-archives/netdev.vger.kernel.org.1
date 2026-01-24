Return-Path: <netdev+bounces-253107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOHpIg0ldWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF57ECC6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625E1300823F
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4247946C;
	Sat, 24 Jan 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uNaklqUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3D1ACEDE
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284874; cv=none; b=B2fNDwPw44RgRk1jE0h+WLIRYS9MqeG5U6yZQ80W8iLtZT9hHkdaEk0Y+9ZY0vt81CLL0Fh4+BDUiRZBab7VmJv99x7mFaM+ZrSk0UslVV8tOs7hfyHs9jCWm52nUXTmvKn6Hec/VsH3xY9xXet4rk77usz3txa17hO5H+VJ8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284874; c=relaxed/simple;
	bh=44g3M4q1yoJaGQcdEzWmxfuD040I2ravxuv9yblmcpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeGZkNm61liumQ7Ex/Fqt+ZeXdG4C5WbE4pktsPrSZsB3REjbDBKgO4kDm6fVYo7NxMzvq7Y7hDZYJ8kU+Hs38hq7xN3WwlrZGQ6/xhRkJTNQ3x1zAKVTNAW+HTB3MqeUmnbw2bGKVU3L2tBnjPmcZh735L8kF9BKBoSzCw8cSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uNaklqUc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2670932so3048390f8f.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 12:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284871; x=1769889671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGC0m2ye2pwP0cVwDiynPNblZnAM9h+mDQG9FxIKvrM=;
        b=uNaklqUcnPRP0Ry9eGKuaKl704RpukqnoZzQBd1n4ZeLIE20bpm13emfGyM8nYsXpR
         j/kdJ+56U0ONdiKhHG0iwWNdyKKxP5EMWQI3s/WVeZGW1Yf5ENhnKwYPTEqkeTJpjMWc
         xsAR7pyvQW6tA85YX5e50CT2gYZrj1Zf1dkpri0dgblR1DFPkw4tPaatTm9E9VSC72wj
         2Pm3T5rM2VqHObGVcU4OXLRAG7Uz5ESw5wzojREj7hKShigO5+1AY2D3L6T1JLR6L8VC
         tQJRrbQYPDrJxUONvgFiB6V4IQcXzo92CxewK2YS8UnwcBRvLGqLgGprAmt9xXzSrV2Z
         R7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284871; x=1769889671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGC0m2ye2pwP0cVwDiynPNblZnAM9h+mDQG9FxIKvrM=;
        b=C8HikAsRtwy5meOtrsh4YtmC/T0P5RGW6T+6LVQPAJwmKHadUCxRtcLcfNtC00lnQ/
         eGMrTDZQg8tFla3rg7SOvcLcVHMdBOn/iSXCahN9Kyf4MlDKn/96aYrrj5XCSBRzlhON
         lXM05dj3fP6qSUexpUvWAC2vWTdRVIA9K56B6UPfhfB7rYYD/TkNQ/1s/fGvbck9nCph
         w1So2aTFQJzcLAtAwCYRVy0/d7TxVXuvZe9h61c/ICjjteDtIBk8DejlpSWUOrc1LkBL
         67X1OFUXSbOpBPW8MQNNDSuvm8k6JcCZ7ufYlQpBPygRpyNlxF2Naq2InCA6KuiCp3W1
         iFFg==
X-Gm-Message-State: AOJu0YytPrcXj4rd+bJFkT0v5SEA7BhZB58Qi/t4J7kqURTxDaTk6esB
	Xn50VSCOE6c7RQ31kXeaBbbzby55/v/WvpP49wu5BcDD2Xq5R1UXThK2P7hgJ3yVt2qVC4ZVIy1
	t16mf
X-Gm-Gg: AZuq6aLML0ptntlEZNNGLJx0POaeM37zA9B7EJEU2yYKTHf7bdX8f0CKPzngkMTEAQB
	+itKtRj+/aw+4Qmv2JSX5MxqC4S0XOYovHE2CTfRGEeMfycAnNtnU37IzyXBvM3DItpKgIG4+vm
	AVcEO8IHMfd5pwJF9Re/XholbQbXDW2QEg11q9cMCRYWyWNotTyqmxWWjHn8M/fsXJO79rMamIY
	MVRjodnhPfjFJ5vAGgiye2jRSeji27MMaD0GVJFqwaDvYWW2gcydKid/v6MRkEJmQHPDFHWmhAK
	G4feoiJGn3v8f2CjAtJ/n1pp5y8dvap1Ng1+UGqyNAcPJrj765TvdnYqlFVkFNQIunq6wLNrVTR
	XmkKwxUy9dluGpYbhj595D12OUMomRnPfPb12D3cE3mpDCJTHy4sn1PW4mfrMnwgtK7OOgHu1Zt
	M9ShYtZbn3u3olQEmY3pTLpP83jO5dPdj9FA6s/XOGPNjWHvlY+RHXJAyOX0Uu
X-Received: by 2002:a05:6000:22c9:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-435b16067aemr11164677f8f.47.1769284871380;
        Sat, 24 Jan 2026 12:01:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f73855sm16343214f8f.29.2026.01.24.12.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 12:01:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ss: fix grammar, articles, and phrasing in man page
Date: Sat, 24 Jan 2026 12:00:41 -0800
Message-ID: <20260124200107.222116-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253107-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CCCF57ECC6
X-Rspamd-Action: no action

This patch addresses grammatical errors, awkward phrasing, missing
articles, and singular/plural agreement issues throughout the ss
man page documentation.

Main corrections:

Grammar and agreement (10 instances):
  - Fix singular/plural: "connection" -> "connections"
  - Fix "five kind" -> "five kinds"
  - Fix "packet" -> "packets" (7 instances throughout memory descriptions)
  - Fix "the retransmission occurred" -> "retransmissions have occurred"
  - Fix "process using socket" -> "processes using sockets"
  - Fix "thread using socket" -> "threads using sockets"
  - Fix "socket option" -> "socket options"

Article corrections:
  - Fix "an uuid" -> "a uuid" (use "a" before consonant sounds)
  - Fix "construct arbitrary set" -> "construct an arbitrary set"
  - Fix "these information" -> "this information" (uncountable noun)
  - Add "instead of human-readable values" (complete phrase)

Awkward phrasing (4 instances):
  - Fix "how long time the timer will expire" -> "how long until the timer will expire"
  - Fix "how long time since" -> "how long it has been since" (3 instances for lastsnd, lastrcv, lastack)

Additional grammar fixes:
  - Add relative pronoun: "memory can be allocated" -> "memory that can be allocated" (2 instances)
  - Fix conditional: "If need memory" -> "If memory is needed"
  - Fix gerund: "before allocate" -> "before allocating"
  - Fix sentence fragment: "Following normal arithmetic rules." -> "following normal arithmetic rules"
  - Add missing period to back_log description

Formatting:
  - Remove duplicate .TP markup between --tipc and --vsock options

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ss.8 | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index e23af826..70e0a566 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -13,7 +13,7 @@ It can display more TCP and state information than other tools.
 
 .SH OPTIONS
 When no option is used ss displays a list of open non-listening
-sockets (e.g. TCP/UNIX/UDP) that have established connection.
+sockets (e.g. TCP/UNIX/UDP) that have established connections.
 .TP
 .B \-h, \-\-help
 Show summary of options.
@@ -31,7 +31,7 @@ Suppress sending and receiving queue columns.
 Print each socket's data on a single line.
 .TP
 .B \-n, \-\-numeric
-Do not try to resolve service names. Show exact bandwidth values, instead of human-readable.
+Do not try to resolve service names. Show exact bandwidth values, instead of human-readable values.
 .TP
 .B \-r, \-\-resolve
 Try to resolve numeric address/ports.
@@ -55,7 +55,7 @@ timer:(<timer_name>,<expire_time>,<retrans>)
 .P
 .TP
 .B <timer_name>
-the name of the timer, there are five kind of timer names:
+the name of the timer, there are five kinds of timer names:
 .RS
 .P
 .B on
@@ -72,11 +72,11 @@ timer and tail loss probe timer
 .RE
 .TP
 .B <expire_time>
-how long time the timer will expire
+how long until the timer will expire
 .P
 .TP
 .B <retrans>
-how many times the retransmission occurred
+how many times retransmissions have occurred
 .RE
 .TP
 .B \-e, \-\-extended
@@ -95,7 +95,7 @@ the socket's inode number in VFS
 .P
 .TP
 .B <cookie>
-an uuid of the socket
+a uuid of the socket
 .RE
 .TP
 .B \-m, \-\-memory
@@ -118,41 +118,41 @@ bl<back_log>,d<sock_drop>)
 .P
 .TP
 .B <rmem_alloc>
-the memory allocated for receiving packet
+the memory allocated for receiving packets
 .P
 .TP
 .B <rcv_buf>
-the total memory can be allocated for receiving packet
+the total memory that can be allocated for receiving packets
 .P
 .TP
 .B <wmem_alloc>
-the memory used for sending packet (which has been sent to layer 3)
+the memory used for sending packets (which has been sent to layer 3)
 .P
 .TP
 .B <snd_buf>
-the total memory can be allocated for sending packet
+the total memory that can be allocated for sending packets
 .P
 .TP
 .B <fwd_alloc>
 the memory allocated by the socket as cache, but not used for
-receiving/sending packet yet. If need memory to send/receive packet,
-the memory in this cache will be used before allocate additional
+receiving/sending packets yet. If memory is needed to send/receive packets,
+the memory in this cache will be used before allocating additional
 memory.
 .P
 .TP
 .B <wmem_queued>
-The memory allocated for sending packet (which has not been sent to layer 3)
+The memory allocated for sending packets (which has not been sent to layer 3)
 .P
 .TP
 .B <opt_mem>
-The memory used for storing socket option, e.g., the key for TCP MD5 signature
+The memory used for storing socket options, e.g., the key for TCP MD5 signature
 .P
 .TP
 .B <back_log>
 The memory used for the sk backlog queue. On a process context, if the
-process is receiving packet, and a new packet is received, it will be
+process is receiving packets, and a new packet is received, it will be
 put into the sk backlog queue, so it can be received by the process
-immediately
+immediately.
 .P
 .TP
 .B <sock_drop>
@@ -160,10 +160,10 @@ the number of packets dropped before they are de-multiplexed into the socket
 .RE
 .TP
 .B \-p, \-\-processes
-Show process using socket.
+Show processes using sockets.
 .TP
 .B \-T, \-\-threads
-Show thread using socket. Implies
+Show threads using sockets. Implies
 .BR \-p .
 .TP
 .B \-i, \-\-info
@@ -255,15 +255,15 @@ egress bps
 .P
 .TP
 .B lastsnd:<lastsnd>
-how long time since the last packet sent, the unit is millisecond
+how long it has been since the last packet sent, the unit is millisecond
 .P
 .TP
 .B lastrcv:<lastrcv>
-how long time since the last packet received, the unit is millisecond
+how long it has been since the last packet received, the unit is millisecond
 .P
 .TP
 .B lastack:<lastack>
-how long time since the last ack received, the unit is millisecond
+how long it has been since the last ack received, the unit is millisecond
 .P
 .TP
 .B pacing_rate <pacing_rate>bps/<max_pacing_rate>bps
@@ -359,7 +359,7 @@ and is therefore a useful reference.
 Switch to the specified network namespace name.
 .TP
 .B \-b, \-\-bpf
-Show socket classic BPF filters (only administrators are allowed to get these
+Show socket classic BPF filters (only administrators are allowed to get this
 information).
 .TP
 .B \-4, \-\-ipv4
@@ -392,7 +392,6 @@ Display SCTP sockets.
 .B \-\-tipc
 Display tipc sockets (alias for -f tipc).
 .TP
-.TP
 .B \-\-vsock
 Display vsock sockets (alias for -f vsock).
 .TP
@@ -438,7 +437,7 @@ Please take a look at the official documentation for details regarding filters.
 .SH STATE-FILTER
 
 .B STATE-FILTER
-allows one to construct arbitrary set of states to match. Its syntax is
+allows one to construct an arbitrary set of states to match. Its syntax is
 sequence of keywords state and exclude followed by identifier of
 state.
 .TP
@@ -496,7 +495,7 @@ Test if the destination or source matches HOST. See HOST SYNTAX for details.
 .TP
 .B {dport|sport} [OP] [FAMILY:]:PORT
 Compare the destination or source port to PORT. OP can be any of "<", "<=", "=", "!=",
-">=" and ">". Following normal arithmetic rules. FAMILY and PORT are as described in
+">=" and ">", following normal arithmetic rules. FAMILY and PORT are as described in
 HOST SYNTAX below.
 .TP
 .B dev [=|!=] DEVICE
-- 
2.51.0


