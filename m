Return-Path: <netdev+bounces-303445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n+ejOI2ARGq3vwoAu9opvQ
	(envelope-from <netdev+bounces-303445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065B6E94E6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=huXjDDr5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303445-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303445-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28A4930332CC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DA36403B;
	Wed,  1 Jul 2026 02:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DCE362156
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:50:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874226; cv=none; b=ILjT9RqSl+q/knHmgJtFRmP3Ra+SJzxI2kJxUfJzrDg+JKaSHdw5uPKG9QBoqnksYNicfSVf0+5SBa/od9pj762m3To/Nfjg8lm/pTx9YpM8L2mPlAFJjldN2CxhWqmWCo9UceO2izcEDR05s+uxWYjHcPhCjrlwapPf2upivLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874226; c=relaxed/simple;
	bh=Fd4mk5sXLw7e7+6DDtJon/FdfjtcF2UVWfn1rurRvA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4Whqgz+uhT+JycnyDRMGoGIC8dpwaz0lVKb/yZ3VRZ4DmK6fMohjAzu1+cCGucu5LRPalgnHwLRje0SgEJKk0frnBTJyfYFbj29B3LlXg4oI0JCjN8r/BP686jx64ZaF4c1J3OSDY03NX+Dd0dOCDBKY5A/PYYgr7e/ypKDlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huXjDDr5; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8475eca3a66so154804b3a.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782874225; x=1783479025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37VIR1rBhW6b7K3kcG+oxX/iYB8pGoIcye/0cqdq+No=;
        b=huXjDDr5GCwZtkCjGgihi8stmuPmgANjemV0+Nt16EQfV08XEMKcVYKMbBaLG7CoLe
         3Qtj+GBIde6IJKDYRpxm7tJyY9Kh7gJNwfqqVB2TdPgt4ZYoec+cyXea0yP51vM+DwWJ
         wASbPvm+zz9GlHtt0RMMjDLmSbclTtW8A1kEr9pEWK/aCjHEQaVWnD+KIKQ2bhQJq7DW
         PxMltBe0pGN5bSFUDxuA2Q2aJbAhJHyNwLeESFU4+fdepOT2f9S/mfvkf2QYYzlvl/Gq
         +q5A4nwomRFktuFBR2Dh/KB9iA0jPd9GfP0EC2CjBFEsJpF9ohmgqVSOoQuZMTwpEkD3
         4o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782874225; x=1783479025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37VIR1rBhW6b7K3kcG+oxX/iYB8pGoIcye/0cqdq+No=;
        b=ayZp1oC0hPvbzbJabu39CjKdwtOyEMi90j5f/mp98RbxR0Ul+2fu8rrACC5w3WSiti
         pl0HHKIOcShrMptA8zFgDsWGj9iU1oA2+0oPyJuIB71yRN6f1raWLZZlo9xBVdu3WuyP
         9PKeuYXTs3l2xMykS625rUl9GpeKZ2HrnDVTy1bRj5fyiqE9KzbcknN0TK61WxsiiEBg
         e4gzkHDeSZCEmBuQYhCapwems2e7eH/7aru7Ez9Dr+/bGy9S8PDbCodQs7Q0GdjmCBxF
         wcZgB2zSf94osQTHLQTQJ1KyRydrwX8HOl9Wx+Z5/dInjyNSOll9D5sX+iABEJhrr5FH
         mGzA==
X-Forwarded-Encrypted: i=1; AHgh+RqUdann+SnXwxvCEO6bV2LaIntF+GYvlXAPk2M1LFib3uY90ujAfw2tnz99xDa3N73rJqx9zfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPr1bsO+HqS2s2dfmh2f6yihrIWtjNUCYV/imxIU7VBaNVIIq
	7ypS8m3+Yf4a7hzXnonATU7WgWe/k7qbno1HvB/LL/s/iCHfSbMcLmhPZcFyKK4fzTemCQ==
X-Gm-Gg: AfdE7cmK2XWDtQwpl7u0KjeysVSlMpvHwq4EvpQuZaPCh4PxkFxRMCtpY0+R4g/iFru
	z6DHztTXp9KciXrBs5b9sp7W0dC6IU8L46l+rtvsit7em7m9nBbFl08vUKH6effXaof0VovCrRT
	zmNhAJXjXi+7xfIvBjxBUFaHw0ZBSBmn5cmYqJJwcNpCSZFpdwrKF4Z7ygc0ZcgMM5g9tW7okNm
	jVEMU/VWQR6GQ2QrikGB+JeN29nTv91Hf9cgxpwdBo/hkuSopvC6/NkihpuPnNT7E5Yli6ubhH2
	6v3mcQKa6MCx8z5zejLgirf2Javt2IF/1hchKA2AtsrQf/J1I+s7ltyy4tRib1PKT3N3ArF0E6v
	D4DaJJVYOWqurIgWuLXbI1YJmFhbxAtVz+RCKbXShdilzAyefpUBvz7NlqbW9O1c3+orkszHrxP
	vrr9T4JzGhsW5MpUxZSe49+GfuiSpcr9fkGEdA7JjITdjmFAdStoJJpnqEFCkHMeZbmxZqWtA3c
	242krzE
X-Received: by 2002:a05:6a00:c87:b0:847:7a61:e692 with SMTP id d2e1a72fcca58-8479f258554mr5639636b3a.41.1782874224444;
        Tue, 30 Jun 2026 19:50:24 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2000:42fa:a9ac:394f:87c2:491a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm3038110b3a.44.2026.06.30.19.50.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 19:50:23 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: stephen@networkplumber.org
Cc: kuniyu@google.com,
	laoar.shao@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2-next] ss: stop displaying dccp sockets
Date: Wed,  1 Jul 2026 10:50:05 +0800
Message-ID: <20260701025005.76589-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630185600.43d55c7c@phoenix.local>
References: <20260630185600.43d55c7c@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:kuniyu@google.com,m:laoar.shao@gmail.com,m:netdev@vger.kernel.org,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8065B6E94E6

DCCP support was retired in kernel commit 2a63dd0edf38 ("net: Retire
DCCP socket."). However, ss still attempts to query DCCP sockets via
netlink, which triggers repeated SELinux warnings in dmesg:

  SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
    sclass=netlink_tcpdiag_socket pid=188945 comm=ss

Stop sending DCCPDIAG_GETSOCK netlink messages to suppress these
warnings and align ss with the kernel change.

After this commit, running `ss -d` fails with:

  # ./misc/ss -d
  ./misc/ss: invalid option -- 'd'
  [...]

  # ./misc/ss --dccp
  ./misc/ss: unrecognized option '--dccp'
  [...]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 man/man8/ss.8 |  5 +----
 misc/ss.c     | 41 ++++++-----------------------------------
 2 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 70e0a566..3871612d 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -377,9 +377,6 @@ Display TCP sockets.
 .B \-u, \-\-udp
 Display UDP sockets.
 .TP
-.B \-d, \-\-dccp
-Display DCCP sockets.
-.TP
 .B \-w, \-\-raw
 Display RAW sockets.
 .TP
@@ -411,7 +408,7 @@ supported: unix, inet, inet6, link, netlink, vsock, tipc, xdp.
 .B \-A QUERY, \-\-query=QUERY, \-\-socket=QUERY
 List of socket tables to dump, separated by commas. The following identifiers
 are understood: all, inet, tcp, udp, raw, unix, packet, netlink, unix_dgram,
-unix_stream, unix_seqpacket, packet_raw, packet_dgram, dccp, sctp, tipc,
+unix_stream, unix_seqpacket, packet_raw, packet_dgram, sctp, tipc,
 vsock_stream, vsock_dgram, xdp, mptcp. Any item in the list may optionally be
 prefixed by an exclamation mark
 .RB ( ! )
diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a..b5f59a37 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -195,7 +195,6 @@ static const char *dg_proto;
 enum {
 	TCP_DB,
 	MPTCP_DB,
-	DCCP_DB,
 	UDP_DB,
 	RAW_DB,
 	UNIX_DG_DB,
@@ -215,7 +214,7 @@ enum {
 #define PACKET_DBM ((1<<PACKET_DG_DB)|(1<<PACKET_R_DB))
 #define UNIX_DBM ((1<<UNIX_DG_DB)|(1<<UNIX_ST_DB)|(1<<UNIX_SQ_DB))
 #define ALL_DB ((1<<MAX_DB)-1)
-#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<DCCP_DB)|(1<<SCTP_DB))
+#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<SCTP_DB))
 #define INET_DBM (INET_L4_DBM | (1<<RAW_DB))
 #define VSOCK_DBM ((1<<VSOCK_ST_DB)|(1<<VSOCK_DG_DB))
 
@@ -274,10 +273,6 @@ static const struct filter default_dbs[MAX_DB] = {
 		.states   = SS_CONN,
 		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
 	},
-	[DCCP_DB] = {
-		.states   = SS_CONN,
-		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
-	},
 	[UDP_DB] = {
 		.states   = (1 << SS_ESTABLISHED),
 		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
@@ -388,13 +383,12 @@ static int filter_db_parse(struct filter *f, const char *s)
 		int dbs[MAX_DB + 1];
 	} db_name_tbl[] = {
 #define ENTRY(name, ...) { #name, { __VA_ARGS__, MAX_DB } }
-		ENTRY(all, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, RAW_DB,
+		ENTRY(all, UDP_DB, TCP_DB, MPTCP_DB, RAW_DB,
 			   UNIX_ST_DB, UNIX_DG_DB, UNIX_SQ_DB,
 			   PACKET_R_DB, PACKET_DG_DB, NETLINK_DB,
 			   SCTP_DB, VSOCK_ST_DB, VSOCK_DG_DB, XDP_DB),
-		ENTRY(inet, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
+		ENTRY(inet, UDP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
 		ENTRY(udp, UDP_DB),
-		ENTRY(dccp, DCCP_DB),
 		ENTRY(tcp, TCP_DB),
 		ENTRY(mptcp, MPTCP_DB),
 		ENTRY(sctp, SCTP_DB),
@@ -935,8 +929,6 @@ static const char *proto_name(int protocol)
 		return "mptcp";
 	case IPPROTO_SCTP:
 		return "sctp";
-	case IPPROTO_DCCP:
-		return "dccp";
 	case IPPROTO_ICMPV6:
 		return "icmp6";
 	}
@@ -3897,8 +3889,6 @@ static int tcpdiag_send(int fd, int protocol, struct filter *f)
 
 	if (protocol == IPPROTO_TCP)
 		req.nlh.nlmsg_type = TCPDIAG_GETSOCK;
-	else if (protocol == IPPROTO_DCCP)
-		req.nlh.nlmsg_type = DCCPDIAG_GETSOCK;
 	else
 		return -1;
 
@@ -4134,7 +4124,7 @@ static int inet_show_netlink(struct filter *f, FILE *dump_fp, int protocol)
 
 	/* Suppress netlink errors. Older kernels do not support extended
 	 * protocol requests using INET_DIAG_REQ_PROTOCOL, and some protocols
-	 * may not be available in the running kernel (e.g. SCTP, DCCP).
+	 * may not be available in the running kernel (e.g. SCTP).
 	 * In both cases the kernel returns EINVAL which would cause
 	 * rtnl_dump_error() to print a confusing "RTNETLINK answers" error.
 	 */
@@ -4309,18 +4299,6 @@ static int mptcp_show(struct filter *f)
 	return 0;
 }
 
-static int dccp_show(struct filter *f)
-{
-	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
-		return 0;
-
-	if (!getenv("PROC_NET_DCCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_DCCP) == 0)
-		return 0;
-
-	return 0;
-}
-
 static int sctp_show(struct filter *f)
 {
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
@@ -5779,7 +5757,6 @@ static void _usage(FILE *dest)
 "   -M, --mptcp         display only MPTCP sockets\n"
 "   -S, --sctp          display only SCTP sockets\n"
 "   -u, --udp           display only UDP sockets\n"
-"   -d, --dccp          display only DCCP sockets\n"
 "   -w, --raw           display only RAW sockets\n"
 "   -x, --unix          display only Unix domain sockets\n"
 "       --tipc          display only TIPC sockets\n"
@@ -5795,7 +5772,7 @@ static void _usage(FILE *dest)
 "       --inet-sockopt  show various inet socket options\n"
 "\n"
 "   -A, --query=QUERY, --socket=QUERY\n"
-"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|dccp|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
+"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
 "\n"
 "   -D, --diag=FILE     Dump raw information about TCP sockets to FILE\n"
 "   -F, --filter=FILE   read filter information from FILE\n"
@@ -5907,7 +5884,6 @@ static const struct option long_opts[] = {
 	{ "threads", 0, 0, 'T' },
 	{ "bpf", 0, 0, 'b' },
 	{ "events", 0, 0, 'E' },
-	{ "dccp", 0, 0, 'd' },
 	{ "tcp", 0, 0, 't' },
 	{ "sctp", 0, 0, 'S' },
 	{ "udp", 0, 0, 'u' },
@@ -5961,7 +5937,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSO",
+				 "halBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5996,9 +5972,6 @@ int main(int argc, char *argv[])
 		case 'E':
 			follow_events = 1;
 			break;
-		case 'd':
-			filter_db_set(&current_filter, DCCP_DB, true);
-			break;
 		case 't':
 			filter_db_set(&current_filter, TCP_DB, true);
 			break;
@@ -6290,8 +6263,6 @@ int main(int argc, char *argv[])
 		udp_show(&current_filter);
 	if (current_filter.dbs & (1<<TCP_DB))
 		tcp_show(&current_filter);
-	if (current_filter.dbs & (1<<DCCP_DB))
-		dccp_show(&current_filter);
 	if (current_filter.dbs & (1<<SCTP_DB))
 		sctp_show(&current_filter);
 	if (current_filter.dbs & VSOCK_DBM)
-- 
2.52.0


