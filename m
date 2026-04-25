Return-Path: <netdev+bounces-281102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XpupFHpz7Gl0YwAAu9opvQ
	(envelope-from <netdev+bounces-281102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 09:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4A46576C
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC019300C58D
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822B2C21E8;
	Sat, 25 Apr 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NSeHWaFM"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183EF2BEC43
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777103735; cv=none; b=TIr3qOl0HuqyaVukiZA7PmRehGjGHAQl7H+ohOEhCI+ryUR18rl8AmYRHuFokVpakDp84fgxw99upUX7P8QOAieAvydICGTrGBz8742tJCpuNJJjtyAwP8lwwDdoaDOva+KD2zscqJoqj6SDA8UOzleMPQ17QtPjTW2Y/DUyavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777103735; c=relaxed/simple;
	bh=fVBm6wS4L6L1yOivEcfgzQ8WdPmIAhd3oVtjQ+CI6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwrT39Qsd74DZje7LUrmTJYG9XWiOpD5DitvsWHGor/p1xmNu2eG4+LmJZorvhaVIQw4Phc1Xxp2vwi7dzBQQTa8d73zIBa8Vq6A2KZMJQub6avV2w00flVPnhQQZ2Er5gXu5MYQiv4k/Kua9mdCjDf77cmzkfK2a4tYmyPhslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NSeHWaFM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QoRTEGFw9YjoUpYPd7/jNDkMmXXe7dBuLEvV5Qmrx38=; b=NSeHWaFMzC6FbpNadwvf5oaBnV
	Sh0stp45XVzYuhPf5ZFPkHZRtYkWXvjsgOpXUmqHN6/GSXSWPCI6NtEPBDNea+XeT34tDqXNkfu79
	z2B00uW8168fK+M6skxgk2KeeXuw34tJP4AGEjZKflxmZ4P+LrcpZMRPdd1YgIMks2uHKkhHKePIE
	j5xygnUpbhGKBdm+vI07tohk38CJPFdsyVzzHzVYFmhLTW5XYfJVEwZewDVmtGTwbOkwkPvB73dJb
	TiVxlvmw9tYH+C4Q9uq/xD+a/G14AzE386vChHs9K9srvqwsiTbcxnz3LJafvdyh3GDsaehZV4D5e
	kZe8yPUw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wGXrH-000FZ8-1g;
	Sat, 25 Apr 2026 09:55:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2] ipv6: Implement limits on extension header parsing
Date: Sat, 25 Apr 2026 09:55:21 +0200
Message-ID: <20260425075521.736328-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27982/Sat Apr 25 08:24:36 2026)
X-Rspamd-Queue-Id: 96F4A46576C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281102-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]

ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
protocol_deliver_rcu}() iterate over IPv6 extension headers until they
find a non-extension-header protocol or run out of packet data. The
loops have no iteration counter, relying solely on the packet length
to bound them. For a crafted packet with 8-byte extension headers
filling a 64KB jumbogram, this means a worst case of up to ~8k
iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
for example, is used where it parses the inner quoted packet inside
an incoming ICMPv6 error:

  - icmpv6_rcv
    - checksum validation
    - case ICMPV6_DEST_UNREACH
      - icmpv6_notify
        - pskb_may_pull()       <- pull inner IPv6 header
        - ipv6_skip_exthdr()    <- iterates here
        - pskb_may_pull()
        - ipprot->err_handler() <- sk lookup

The per-iteration cost of ipv6_skip_exthdr itself is generally
light, but skb_header_pointer becomes more costly on reassembled
packets: the first ~1232 bytes of the inner packet are in the skb's
linear area, but the remaining ~63KB are in the frag_list where
skb_copy_bits is needed to read data.

Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
(default 8, minimum 1). All four extension header walking functions
are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
("ipv6: Implement limits on Hop-by-Hop and Destination options").
As documented, init_net is used to derive max_ext_hdrs_number to
be consistent given a net cannot always reliably be retrieved.

Note that the check in ip6_protocol_deliver_rcu() happens right
before the goto resubmit, such that we don't have to have a test
for ipv6_ext_hdr() in the fast-path.

There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
IPv6 extension headers ordering and occurrence. The latter also
discusses security implications. As per RFC8200 section 4.1, the
occurrence rules for extension headers provide a practical upper
bound, thus 8 was used as the default.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1->v2:
   - Set the default to 8 (Justin)
   - Update IETF references (Justin)
   - Add core path coverage as well (Justin)

 Documentation/networking/ip-sysctl.rst |  7 +++++++
 include/net/dropreason-core.h          |  6 ++++++
 include/net/ipv6.h                     |  2 ++
 include/net/netns/ipv6.h               |  1 +
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/exthdrs_core.c                | 11 +++++++++++
 net/ipv6/ip6_input.c                   |  6 ++++++
 net/ipv6/ip6_tunnel.c                  |  5 +++++
 net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
 9 files changed, 47 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..f7412f4049d1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2537,6 +2537,13 @@ max_hbh_length - INTEGER
 
 	Default: INT_MAX (unlimited)
 
+max_ext_hdrs_number - INTEGER
+	Maximum number of IPv6 extension headers allowed in a packet.
+	Limits how many extension headers will be traversed. The value
+	is read from the initial netns.
+
+	Default: 8
+
 skip_notify_on_dev_down - BOOLEAN
 	Controls whether an RTM_DELROUTE message is generated for routes
 	removed when a device is taken down or deleted. IPv4 does not
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e0ca3904ff8e..1fd91e59b84e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -99,6 +99,7 @@
 	FN(FRAG_TOO_FAR)		\
 	FN(TCP_MINTTL)			\
 	FN(IPV6_BAD_EXTHDR)		\
+	FN(IPV6_TOO_MANY_EXTHDRS)	\
 	FN(IPV6_NDISC_FRAG)		\
 	FN(IPV6_NDISC_HOP_LIMIT)	\
 	FN(IPV6_NDISC_BAD_CODE)		\
@@ -494,6 +495,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_MINTTL,
 	/** @SKB_DROP_REASON_IPV6_BAD_EXTHDR: Bad IPv6 extension header. */
 	SKB_DROP_REASON_IPV6_BAD_EXTHDR,
+	/**
+	 * @SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS: Number of IPv6 extension
+	 * headers in the packet exceeds net.ipv6.max_ext_hdrs_number.
+	 */
+	SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS,
 	/** @SKB_DROP_REASON_IPV6_NDISC_FRAG: invalid frag (suppress_frag_ndisc). */
 	SKB_DROP_REASON_IPV6_NDISC_FRAG,
 	/** @SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT: invalid hop limit. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d042afe7a245..c540b750726e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -90,6 +90,8 @@ struct ip_tunnel_info;
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
+#define IP6_DEFAULT_MAX_EXT_HDRS_CNT	 8
+
 /*
  *	Addr type
  *	
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e4288170f..2cea457bddb4 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -54,6 +54,7 @@ struct netns_sysctl_ipv6 {
 	int max_hbh_opts_cnt;
 	int max_dst_opts_len;
 	int max_hbh_opts_len;
+	int max_ext_hdrs_cnt;
 	int seg6_flowlabel;
 	u32 ioam6_id;
 	u64 ioam6_id_wide;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..19424c3f2dfc 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -945,6 +945,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.flowlabel_state_ranges = 0;
 	net->ipv6.sysctl.max_dst_opts_cnt = IP6_DEFAULT_MAX_DST_OPTS_CNT;
 	net->ipv6.sysctl.max_hbh_opts_cnt = IP6_DEFAULT_MAX_HBH_OPTS_CNT;
+	net->ipv6.sysctl.max_ext_hdrs_cnt = IP6_DEFAULT_MAX_EXT_HDRS_CNT;
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..9df892e7f7fb 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -4,6 +4,8 @@
  * not configured or static.
  */
 #include <linux/export.h>
+
+#include <net/net_namespace.h>
 #include <net/ipv6.h>
 
 /*
@@ -72,7 +74,9 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
 int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		     __be16 *frag_offp)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	u8 nexthdr = *nexthdrp;
+	int exthdr_cnt = 0;
 
 	*frag_offp = 0;
 
@@ -82,6 +86,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 
 		if (nexthdr == NEXTHDR_NONE)
 			return -1;
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			return -1;
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -1;
@@ -188,8 +194,10 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
 int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 		  int target, unsigned short *fragoff, int *flags)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
 	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	int exthdr_cnt = 0;
 	bool found;
 
 	if (fragoff)
@@ -216,6 +224,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			return -ENOENT;
 		}
 
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			return -EBADMSG;
+
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -EBADMSG;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 967b07aeb683..a5bbbc16e8d7 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -403,8 +403,10 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
 void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 			      bool have_final)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
+	int exthdr_cnt = 0;
 	unsigned int nhoff;
 	SKB_DR(reason);
 	bool raw;
@@ -487,6 +489,10 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 				nexthdr = ret;
 				goto resubmit_final;
 			} else {
+				if (unlikely(exthdr_cnt++ >= exthdr_max)) {
+					SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
+					goto discard;
+				}
 				goto resubmit;
 			}
 		} else if (ret == 0) {
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index c468c83af0f2..4546a60942ab 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -395,15 +395,20 @@ ip6_tnl_dev_uninit(struct net_device *dev)
 
 __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
 	unsigned int nhoff = raw - skb->data;
 	unsigned int off = nhoff + sizeof(*ipv6h);
 	u8 nexthdr = ipv6h->nexthdr;
+	int exthdr_cnt = 0;
 
 	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
 		struct ipv6_opt_hdr *hdr;
 		u16 optlen;
 
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			break;
+
 		if (!pskb_may_pull(skb, off + sizeof(*hdr)))
 			break;
 
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d..93f865545a7c 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &flowlabel_reflect_max,
 	},
+	{
+		.procname	= "max_ext_hdrs_number",
+		.data		= &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "max_dst_opts_number",
 		.data		= &init_net.ipv6.sysctl.max_dst_opts_cnt,
-- 
2.43.0


