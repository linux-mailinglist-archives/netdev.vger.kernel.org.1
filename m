Return-Path: <netdev+bounces-272662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCscKcPVxmmtPAUAu9opvQ
	(envelope-from <netdev+bounces-272662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:08:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B88BC349DAC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACFD307AFE4
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0E358D3D;
	Fri, 27 Mar 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nMo5XT3v"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB9299AB1
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638197; cv=none; b=O73gGFazC95hkpwd4uo9Xx4u9AIlAxCL+Spkl6Hte3agj9OV2aXz/6lHBQ5c3PzyXMb62qFL9JE+BNh6JakmQ8B7ysOCkc/u+82Iu/RcSrIhV6DSqwlWc/2+5aeIW8uR37qibtblqL1dye97pBNRznq0odLMNJrMg+Q18Aq505Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638197; c=relaxed/simple;
	bh=FMj4JDNml4IHgbFLqADMxjkynxmofp6i1qbnAEtkLH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuiOQiOwSGukKhcpzJoJGqDLFlPajOtsOXaKl8s0fKJX0t+beDkL5klIgT7ayb4ZIEyQ+EhBwFyBbCkqZUbZc6G8163f9Bv6hyTwaAvvG3hvZQBcYh9w1pg6m4IA/OMZfZdimJRUKK7kzdVxnCl8jZ1fcJFhi6r3iY/7NiUCGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nMo5XT3v; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af12c536-adcb-4071-9b25-15035273a217@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774638183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO/5qicVfTEJ1swHeCBLcKJzHUpAEZ9P5IIYfc/8GJM=;
	b=nMo5XT3vkHXISmzOpAxOEdV1skAZl5Vr90vpydWqrJRx/XrxkDqX6v3pHONvj/Rzx944jV
	b1v5r2ia5iS6qz2pllc4vph1eUJ79xn1jJACNGmKva/z1XyR9zP+b2i+Sgsls0jP1KZptu
	TfghKeMuCQRaT0XMhRHTAN8rwDs2390=
Date: Fri, 27 Mar 2026 12:02:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Glasgall, Anna"
 <aglasgal@akamai.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
 <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
 <9E9BE3BD-1640-49E7-8801-130945073B24@akamai.com>
 <c0c453f9-28aa-462f-884d-0e9beb2fdf0a@linux.dev>
 <8B5AD797-623A-441E-8D46-EEBDC44793F0@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8B5AD797-623A-441E-8D46-EEBDC44793F0@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B88BC349DAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 3:55 AM, Hudson, Nick wrote:
> 
> 
>> On Mar 26, 2026, at 5:49 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> !-------------------------------------------------------------------|
>> This Message Is From an External Sender
>> This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>
>>
>>
>> On 3/26/26 10:02 AM, Hudson, Nick wrote:
>>>>>     static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>>>>        u64 flags)
>>>>> @@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>>>>    unsigned int gso_type = SKB_GSO_DODGY;
>>>>>    int ret;
>>>>>   + if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
>>>>> +        BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>>>>> +        BPF_F_ADJ_ROOM_FIXED_GSO)))
>>>> Under which case this new check will be hit?
>>> If a user supplies +ve len_diff and attempts to pass a DECAP flag.
>>> The commit message had
>>>      Add flag validation to bpf_skb_net_grow() to reject invalid encap
>>>      flags early.
>>
>> There is DECAP_MASK check in bpf_skb_adjust_room() and then !shrink is rejected. What am I missing?
> 
> Duh, right.
> 
> Do you prefer the do all the flag checking in bpf_skb_adjust_room or keep the encap/decap split?
> 

The new decap flag checks added in patch 4? I do not have a strong 
preference on whether they should be moved to shrink() or remain in 
bpf_skb_adjust_room().

If the decap flag checks move into shrink(), it would also make sense to 
move the corresponding length checks into grow() and shrink(). These 
check refactoring probably needs another patch after the macro 
refactoring patch mentioned earlier.

Likely still broken, maybe still worth to share compiler-tested code for 
this. It is based on patch 3 (with the new flags check in grow). The 
error return value can differ for some invalid shrink cases because of 
the check ordering, but I do not think that matters.

diff --git a/net/core/filter.c b/net/core/filter.c
index de61503f06f6..895e94865a9f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3510,6 +3510,8 @@ static u32 bpf_skb_net_base_len(const struct 
sk_buff *skb)
  					 BPF_F_ADJ_ROOM_DECAP_MASK | \
  					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)

+#define BPF_SKB_MAX_LEN SKB_MAX_ALLOC
+
  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
  			    u64 flags)
  {
@@ -3518,6 +3520,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, 
u32 off, u32 len_diff,
  	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
  	const u8 meta_len = skb_metadata_len(skb);
  	unsigned int gso_type = SKB_GSO_DODGY;
+	u32 len_max = BPF_SKB_MAX_LEN;
  	int ret;

  	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
@@ -3525,6 +3528,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, 
u32 off, u32 len_diff,
  			       BPF_F_ADJ_ROOM_FIXED_GSO)))
  		return -EINVAL;

+	if (skb->len + len_diff > len_max && !skb_is_gso(skb))
+		return -ENOTSUPP;
+
  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
  		/* udp gso_size delineates datagrams, only allow if fixed */
  		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
@@ -3632,6 +3638,8 @@ static int bpf_skb_net_grow(struct sk_buff *skb, 
u32 off, u32 len_diff,
  static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
  			      u64 flags)
  {
+	u32 len_cur = skb->len - skb_network_offset(skb);
+	u32 len_min = bpf_skb_net_base_len(skb);
  	int ret;

  	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
@@ -3639,6 +3647,22 @@ static int bpf_skb_net_shrink(struct sk_buff 
*skb, u32 off, u32 len_diff,
  			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
  		return -EINVAL;

+	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
+			len_min = sizeof(struct iphdr);
+			break;
+		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
+			len_min = sizeof(struct ipv6hdr);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (len_diff >= len_cur || len_cur - len_diff < len_min)
+		return -ENOTSUPP;
+
  	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
  		/* udp gso_size delineates datagrams, only allow if fixed */
  		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
@@ -3677,8 +3701,6 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, 
u32 off, u32 len_diff,
  	return 0;
  }

-#define BPF_SKB_MAX_LEN SKB_MAX_ALLOC
-
  BPF_CALL_4(sk_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
  	   u32, mode, u64, flags)
  {
@@ -3723,9 +3745,7 @@ static const struct bpf_func_proto 
sk_skb_adjust_room_proto = {
  BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
  	   u32, mode, u64, flags)
  {
-	u32 len_cur, len_diff_abs = abs(len_diff);
-	u32 len_min = bpf_skb_net_base_len(skb);
-	u32 len_max = BPF_SKB_MAX_LEN;
+	u32 len_diff_abs = abs(len_diff);
  	__be16 proto = skb->protocol;
  	bool shrink = len_diff < 0;
  	u32 off;
@@ -3750,29 +3770,6 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, 
skb, s32, len_diff,
  		return -ENOTSUPP;
  	}

-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		if (!shrink)
-			return -EINVAL;
-
-		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
-			len_min = sizeof(struct iphdr);
-			break;
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
-			len_min = sizeof(struct ipv6hdr);
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	len_cur = skb->len - skb_network_offset(skb);
-	if ((shrink && (len_diff_abs >= len_cur ||
-			len_cur - len_diff_abs < len_min)) ||
-	    (!shrink && (skb->len + len_diff_abs > len_max &&
-			 !skb_is_gso(skb))))
-		return -ENOTSUPP;
-
  	ret = shrink ? bpf_skb_net_shrink(skb, off, len_diff_abs, flags) :
  		       bpf_skb_net_grow(skb, off, len_diff_abs, flags);
  	if (!ret && !(flags & BPF_F_ADJ_ROOM_NO_CSUM_RESET))

