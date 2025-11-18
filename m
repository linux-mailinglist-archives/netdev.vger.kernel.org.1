Return-Path: <netdev+bounces-239378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32DC6746F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAE864E3FA2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379B29BD81;
	Tue, 18 Nov 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="M+00WVp1"
X-Original-To: netdev@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C51D88AC
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440633; cv=none; b=fpJXfQMU+fcEmqpScKumM9IzX9VVXGLGpmZbwno76CMnUHMP3+1AcAwnaDAvE8xqmBulvTfNoMwW4Ffi3515b+FHNueUHlVm61Kt3WknohDYNuyjQxCgRBxJPm5nkSfd3RVD/PGHEIgsmknDxbBcUZGYVRZ2kkzohUKu8maHxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440633; c=relaxed/simple;
	bh=G67+YTjw0sQnL+oACtYynU1IHOogg5MDw5y6kZ5V6Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLufDcqWbpPaAKNOq9BFP6rBKMC4VwrqPBFap+iou0SCuzYGSrVmm7fNqYTtQAnuPJ049RVkQiwBsyUYFLnpJmYZceT8A7bTG448Xtfsd1ihSOlYTWkq5vqn302BH7a5Xwbitmzi+pb2dsSNIH4TbgGUBBjwpdcjboaIV9hrb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=M+00WVp1; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id LD5rv5fbXSkcfLDSjvROVy; Tue, 18 Nov 2025 04:37:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id LDSivMBOphv1iLDSjvE8lS; Tue, 18 Nov 2025 04:37:05 +0000
X-Authority-Analysis: v=2.4 cv=A+xsP7WG c=1 sm=1 tr=0 ts=691bf7f1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4DtsFWJC70/ZxGj2xnZlig==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=HhfkYooplKnVZcu9EkYA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X9cu/yQPTE6JW96XJYHNZ2eicJLxbGVq7vGSolX653w=; b=M+00WVp1KjspPaaQaVW2oOjGNc
	YZa2jwyCBuMYZWTUI1f47KCF+v42Os2EjSDalbdLHYa4TVDSQKSsKAsxtJeSmnZxzkJU2E7oaLgcv
	nIvHsoIdipsozyl4GhIxjws6s2i3YBhQAInnfWxylSN7o9+Ko6R/7GqP8olwon+U76/dhdPmLuNzw
	+aDuVq8NLZlwCXMV/QkyZX+YLEM0EX1/KM+pKpkaqBzO+4dlLAjF3Flt/zcgww4+GW/lKiByVbU/1
	bD/NSQkQe7KNXpJuKqIBwSJf9BAKo1IsrIQ9jfNviZH439fnFJD7sR89BhUd3aQLpCFCmQdCWBcKt
	DGVqrQ8g==;
Received: from softbank126126126075.bbtec.net ([126.126.126.75]:49808 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vLDSh-00000001mw4-2tNr;
	Mon, 17 Nov 2025 22:37:04 -0600
Message-ID: <bf9c2ceb-f80f-4fea-999d-4f46b2369721@embeddedor.com>
Date: Tue, 18 Nov 2025 13:36:41 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <aPdx4iPK4-KIhjFq@kspp> <20251023172518.3f370477@kernel.org>
 <949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
 <20251024162354.0a94e4b1@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251024162354.0a94e4b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 126.126.126.75
X-Source-L: No
X-Exim-ID: 1vLDSh-00000001mw4-2tNr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: softbank126126126075.bbtec.net ([10.221.86.44]) [126.126.126.75]:49808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI4mr270fs1ZMW9zpG1ibIlGz6euqo12EsmiItlIdCHOrJcEToHNPTvWh7C33UvqSfN0Fq1coiFXOk+Hiov2f4uJjni4b/NTGD3YPCiCCZDIc/93V+T+
 l24hOO58cg21XIovXQaUZo/F+MIzlz+Br38yLydDyHzfCVLZFR2kKm1mA1cot1FMUeUi0Lg5qcRP77I5Vrw6kjmNdOv6zxrgOS0=



On 10/25/25 08:23, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 12:24:09 +0100 Gustavo A. R. Silva wrote:
>> On 10/24/25 01:25, Jakub Kicinski wrote:
>>> On Tue, 21 Oct 2025 12:43:30 +0100 Gustavo A. R. Silva wrote:
>>>>    struct ip_options_data {
>>>> -	struct ip_options_rcu	opt;
>>>> -	char			data[40];
>>>> +	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
>>>> +			 char			data[40];
>>>> +	);
>>>>    };
>>>
>>> Is there a way to reserve space for flexible length array on the stack
>>> without resorting to any magic macros? This struct has total of 5 users.
>>
>> Not that I know of. That's the reason why we had to implement macros like
>> TRAILING_OVERLAP(), DEFINE_FLEX(), DEFINE_RAW_FLEX().
>>
>> Regarding these three macros, the simplest and least intrusive one to use is
>> actually TRAILING_OVERLAP(), when the flex-array member is not annotated with
>> the counted_by attribute (otherwise, DEFINE_FLEX() would be preferred).
>>
>> Of course, the most straightforward alternative is to use fixed-size arrays
>> if flex arrays are not actually needed.
> 
> Honestly, I'm tired of the endless, nasty macros for no clear benefit.
> This patch is not happening.

Not sure what you mean by "nasty" and "no clear benefit", but here is an
alternative. See it as RFC:

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20251117&id=e0547082214e61b1db0f5068da0daa3d11f992a5

[PATCH RFC][next] ipv4/inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings

Use DEFINE_RAW_FLEX() to avoid thousands of -Wflex-array-member-not-at-end
warnings.

Remove fixed-size array char data[40]; from struct ip_options_data, so
that flexible-array member struct ip_options_rcu::opt.__data[] ends last
in this (and other) structure(s).

Compensate for this by using the DEFINE_RAW_FLEX() helper to declare each
on-stack struct instance that contains struct ip_options_data as a member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
  include/net/inet_sock.h |  1 -
  net/ipv4/icmp.c         | 88 +++++++++++++++++++++--------------------
  net/ipv4/ip_output.c    | 12 +++---
  net/ipv4/ping.c         |  6 +--
  net/ipv4/raw.c          |  6 +--
  net/ipv4/udp.c          |  6 +--
  6 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index ac1c75975908..3b5da5e54673 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -63,7 +63,6 @@ struct ip_options_rcu {

  struct ip_options_data {
  	struct ip_options_rcu	opt;
-	char			data[40];
  };

  struct inet_request_sock {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4abbec2f47ef..744d4e91cb9c 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -353,9 +353,11 @@ void icmp_out_count(struct net *net, unsigned char type)
  static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
  			  struct sk_buff *skb)
  {
-	struct icmp_bxm *icmp_param = from;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.opt.__data, 40);
  	__wsum csum;

+	icmp_param = from;
+
  	csum = skb_copy_and_csum_bits(icmp_param->skb,
  				      icmp_param->offset + offset,
  				      to, len);
@@ -775,9 +777,9 @@ icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
  void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
  		 const struct inet_skb_parm *parm)
  {
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.opt.__data, 40);
  	struct iphdr *iph;
  	int room;
-	struct icmp_bxm icmp_param;
  	struct rtable *rt = skb_rtable(skb_in);
  	bool apply_ratelimit = false;
  	struct sk_buff *ext_skb;
@@ -906,7 +908,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
  					   iph->tos;
  	mark = IP4_REPLY_MARK(net, skb_in->mark);

-	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in,
+	if (__ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb_in,
  			      &parm->opt))
  		goto out_unlock;

@@ -915,21 +917,21 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
  	 *	Prepare data for ICMP header.
  	 */

-	icmp_param.data.icmph.type	 = type;
-	icmp_param.data.icmph.code	 = code;
-	icmp_param.data.icmph.un.gateway = info;
-	icmp_param.data.icmph.checksum	 = 0;
-	icmp_param.skb	  = skb_in;
-	icmp_param.offset = skb_network_offset(skb_in);
+	icmp_param->data.icmph.type	 = type;
+	icmp_param->data.icmph.code	 = code;
+	icmp_param->data.icmph.un.gateway = info;
+	icmp_param->data.icmph.checksum	 = 0;
+	icmp_param->skb	  = skb_in;
+	icmp_param->offset = skb_network_offset(skb_in);
  	ipcm_init(&ipc);
  	ipc.tos = tos;
  	ipc.addr = iph->saddr;
-	ipc.opt = &icmp_param.replyopts.opt;
+	ipc.opt = &icmp_param->replyopts.opt;
  	ipc.sockc.mark = mark;

  	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
  			       inet_dsfield_to_dscp(tos), mark, type, code,
-			       &icmp_param);
+			       icmp_param);
  	if (IS_ERR(rt))
  		goto out_unlock;

@@ -942,7 +944,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
  	room = dst_mtu(&rt->dst);
  	if (room > 576)
  		room = 576;
-	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
+	room -= sizeof(struct iphdr) + icmp_param->replyopts.opt.opt.optlen;
  	room -= sizeof(struct icmphdr);
  	/* Guard against tiny mtu. We need to include at least one
  	 * IP network header for this message to make any sense.
@@ -950,15 +952,15 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
  	if (room <= (int)sizeof(struct iphdr))
  		goto ende;

-	ext_skb = icmp_ext_append(net, skb_in, &icmp_param.data.icmph, room,
+	ext_skb = icmp_ext_append(net, skb_in, &icmp_param->data.icmph, room,
  				  parm->iif);
  	if (ext_skb)
-		icmp_param.skb = ext_skb;
+		icmp_param->skb = ext_skb;

-	icmp_param.data_len = icmp_param.skb->len - icmp_param.offset;
-	if (icmp_param.data_len > room)
-		icmp_param.data_len = room;
-	icmp_param.head_len = sizeof(struct icmphdr);
+	icmp_param->data_len = icmp_param->skb->len - icmp_param->offset;
+	if (icmp_param->data_len > room)
+		icmp_param->data_len = room;
+	icmp_param->head_len = sizeof(struct icmphdr);

  	/* if we don't have a source address at this point, fall back to the
  	 * dummy address instead of sending out a packet with a source address
@@ -969,7 +971,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,

  	trace_icmp_send(skb_in, type, code);

-	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
+	icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);

  	if (ext_skb)
  		consume_skb(ext_skb);
@@ -1206,7 +1208,7 @@ static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)

  static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
  {
-	struct icmp_bxm icmp_param;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.opt.__data, 40);
  	struct net *net;

  	net = skb_dst_dev_net_rcu(skb);
@@ -1214,18 +1216,18 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
  	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
  		return SKB_NOT_DROPPED_YET;

-	icmp_param.data.icmph	   = *icmp_hdr(skb);
-	icmp_param.skb		   = skb;
-	icmp_param.offset	   = 0;
-	icmp_param.data_len	   = skb->len;
-	icmp_param.head_len	   = sizeof(struct icmphdr);
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = skb->len;
+	icmp_param->head_len	   = sizeof(struct icmphdr);

-	if (icmp_param.data.icmph.type == ICMP_ECHO)
-		icmp_param.data.icmph.type = ICMP_ECHOREPLY;
-	else if (!icmp_build_probe(skb, &icmp_param.data.icmph))
+	if (icmp_param->data.icmph.type == ICMP_ECHO)
+		icmp_param->data.icmph.type = ICMP_ECHOREPLY;
+	else if (!icmp_build_probe(skb, &icmp_param->data.icmph))
  		return SKB_NOT_DROPPED_YET;

-	icmp_reply(&icmp_param, skb);
+	icmp_reply(icmp_param, skb);
  	return SKB_NOT_DROPPED_YET;
  }

@@ -1353,7 +1355,7 @@ EXPORT_SYMBOL_GPL(icmp_build_probe);
   */
  static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
  {
-	struct icmp_bxm icmp_param;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.opt.__data, 40);
  	/*
  	 *	Too short.
  	 */
@@ -1363,19 +1365,19 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
  	/*
  	 *	Fill in the current time as ms since midnight UT:
  	 */
-	icmp_param.data.times[1] = inet_current_timestamp();
-	icmp_param.data.times[2] = icmp_param.data.times[1];
-
-	BUG_ON(skb_copy_bits(skb, 0, &icmp_param.data.times[0], 4));
-
-	icmp_param.data.icmph	   = *icmp_hdr(skb);
-	icmp_param.data.icmph.type = ICMP_TIMESTAMPREPLY;
-	icmp_param.data.icmph.code = 0;
-	icmp_param.skb		   = skb;
-	icmp_param.offset	   = 0;
-	icmp_param.data_len	   = 0;
-	icmp_param.head_len	   = sizeof(struct icmphdr) + 12;
-	icmp_reply(&icmp_param, skb);
+	icmp_param->data.times[1] = inet_current_timestamp();
+	icmp_param->data.times[2] = icmp_param->data.times[1];
+
+	BUG_ON(skb_copy_bits(skb, 0, &icmp_param->data.times[0], 4));
+
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->data.icmph.type = ICMP_TIMESTAMPREPLY;
+	icmp_param->data.icmph.code = 0;
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = 0;
+	icmp_param->head_len	   = sizeof(struct icmphdr) + 12;
+	icmp_reply(icmp_param, skb);
  	return SKB_NOT_DROPPED_YET;

  out_err:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ff11d3a85a36..e0b20226b0b7 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1606,7 +1606,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
  			   const struct ip_reply_arg *arg,
  			   unsigned int len, u64 transmit_time, u32 txhash)
  {
-	struct ip_options_data replyopts;
+	DEFINE_RAW_FLEX(struct ip_options_data, replyopts, opt.opt.__data, 40);
  	struct ipcm_cookie ipc;
  	struct flowi4 fl4;
  	struct rtable *rt = skb_rtable(skb);
@@ -1615,18 +1615,18 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
  	int err;
  	int oif;

-	if (__ip_options_echo(net, &replyopts.opt.opt, skb, sopt))
+	if (__ip_options_echo(net, &replyopts->opt.opt, skb, sopt))
  		return;

  	ipcm_init(&ipc);
  	ipc.addr = daddr;
  	ipc.sockc.transmit_time = transmit_time;

-	if (replyopts.opt.opt.optlen) {
-		ipc.opt = &replyopts.opt;
+	if (replyopts->opt.opt.optlen) {
+		ipc.opt = &replyopts->opt;

-		if (replyopts.opt.opt.srr)
-			daddr = replyopts.opt.opt.faddr;
+		if (replyopts->opt.opt.srr)
+			daddr = replyopts->opt.opt.faddr;
  	}

  	oif = arg->bound_dev_if;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index ad56588107cc..ebc7d24a4a68 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -690,6 +690,7 @@ EXPORT_IPV6_MOD_GPL(ping_common_sendmsg);

  static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  {
+	DEFINE_RAW_FLEX(struct ip_options_data, opt_copy, opt.opt.__data, 40);
  	struct net *net = sock_net(sk);
  	struct flowi4 fl4;
  	struct inet_sock *inet = inet_sk(sk);
@@ -697,7 +698,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  	struct icmphdr user_icmph;
  	struct pingfakehdr pfh;
  	struct rtable *rt = NULL;
-	struct ip_options_data opt_copy;
  	int free = 0;
  	__be32 saddr, daddr, faddr;
  	u8 scope;
@@ -746,9 +746,9 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  		rcu_read_lock();
  		inet_opt = rcu_dereference(inet->inet_opt);
  		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
  			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = &opt_copy->opt;
  		}
  		rcu_read_unlock();
  	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5998c4cc6f47..802ebde0246d 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -481,6 +481,7 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,

  static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  {
+	DEFINE_RAW_FLEX(struct ip_options_data, opt_copy, opt.opt.__data, 40);
  	struct inet_sock *inet = inet_sk(sk);
  	struct net *net = sock_net(sk);
  	struct ipcm_cookie ipc;
@@ -491,7 +492,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  	__be32 daddr;
  	__be32 saddr;
  	int uc_index, err;
-	struct ip_options_data opt_copy;
  	struct raw_frag_vec rfv;
  	int hdrincl;

@@ -561,9 +561,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  		rcu_read_lock();
  		inet_opt = rcu_dereference(inet->inet_opt);
  		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
  			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = &opt_copy->opt;
  		}
  		rcu_read_unlock();
  	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5865..fa2c4eeed55c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1269,6 +1269,7 @@ EXPORT_IPV6_MOD_GPL(udp_cmsg_send);

  int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  {
+	DEFINE_RAW_FLEX(struct ip_options_data, opt_copy, opt.opt.__data, 40);
  	struct inet_sock *inet = inet_sk(sk);
  	struct udp_sock *up = udp_sk(sk);
  	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
@@ -1286,7 +1287,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
  	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
  	struct sk_buff *skb;
-	struct ip_options_data opt_copy;
  	int uc_index;

  	if (len > 0xFFFF)
@@ -1368,9 +1368,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
  		rcu_read_lock();
  		inet_opt = rcu_dereference(inet->inet_opt);
  		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
  			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = &opt_copy->opt;
  		}
  		rcu_read_unlock();
  	}
-- 
2.43.0


Thanks
-Gustavo

