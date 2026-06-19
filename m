Return-Path: <netdev+bounces-300738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yvI1OLN6NWqwxQYAu9opvQ
	(envelope-from <netdev+bounces-300738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F26B6A7434
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b=PUM5tOcc;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="a Ubmkxr";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5970F307A0C7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7273B3C1A;
	Fri, 19 Jun 2026 17:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5A331EB7
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 17:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889711; cv=none; b=X3/DWi9RdFCjnz9wC8Y3UFIb+9r7q0zjN7mLAJVz2KhCw740d8o3X8NyARUYc/3fFdkrh+9x3iO0LEQno2/GScUtVC7BjvuBTZhTsYQ1KI88pb02Y7z40C1UrxAo2P54EbqvellscZ75RrVUw1/A00O0evJtptNhLKvsRXH2MRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889711; c=relaxed/simple;
	bh=QxiPQUYuUVs3TXWBrt7QMtv+h+Pw2cm4zibGgGAjXp0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XTXBBAkIx39izF9CD66LRCWfqeswWXCPEkA/yesl6xyBvcYjdY/lP2PO2gDmJT/S9x4czD2Cm72c7CEavaYosvqYD7jQncD7Z14/gDsRtWWPBTI7kGZzRbJMvJzUuR1NDX21+mjfc7yjL0zutJwNoVes/sH38FGh80FNM/goASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=PUM5tOcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUbmkxrT; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B38E6EC0317;
	Fri, 19 Jun 2026 13:21:47 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 13:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781889707;
	 x=1781976107; bh=vn6w0LySri7NAOlBj1lFQFriL1z7l8PZPVSjiwl/tYE=; b=
	PUM5tOccBuFbvRUpTSQIUU9XxIBYuRkQgxxN+Px+3AuXN8ot/n+4+rtMzYLMioL2
	YihGIF/xB3baXXncTWz+WbsspuePIweXO5taU9WbQWtIsVYr7dCOikw1rOCim5Oy
	nLHYZhiWMgCJSITuikiceCqQlc0Zp5gZjx6/nHTe1hTvKfP7o8y0leyNGAMh+nlU
	DEWPM9kD/+Ai4wy+vIj3LXSqWo3JhLPwHD7mDW9oQxqE/uVRRI5yhxonBeoFAHnO
	3kjDlpWaQvc75HYpglLuu8EZkUiHiCtE1fgUtPA4Dzfr0QE6jYt6dWcwsGn1MWNH
	HToDLZLxyJBLS8lfiiJ8CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781889707; x=
	1781976107; bh=vn6w0LySri7NAOlBj1lFQFriL1z7l8PZPVSjiwl/tYE=; b=a
	UbmkxrTyKyj9xNDkJtHoukp7OeFEzw97h9xjuhQJGVHaEJB2KB2GCmUeaACcpMC9
	mE25OmXxVGLTBxV8U3UzztfDUYKprVbHnKDbzJG79nlGgPMN2G7NKOBnSc6rJ6C+
	xYfCuu1qS+5Xz1UyyefCjNHqBo4vwHYbGNJRV/+G9ZCqeoT3eKaFElmaobNuggjI
	0Bq6Q1J/VidZN/t3s1TX96k6N6wGmfdKGOITZSbdQnT9SL7Ko4cIrO50IWoe7Fx4
	6hZawfjYDChrz9SY5P/Oluf98KwP7jpIduUuy9GJ6wicKfIuASVr57t3hlY2X3B3
	i3QGUUjbEBQZXO63JAUvg==
X-ME-Sender: <xms:qno1arNpPqVwO5nZ65DWpToceWxGf5Io4fTTj7L8YpFJ_D2AOqN6_g>
    <xme:qno1agynHPW0GFE-Ro_T1mlHa5DS8WM_dQda2RXnuYS7DWb97dctjm6h5VvgghwRT
    S-vL3y7o80bSmQEH16Jd7bvWgeR6onU0ijFFkPah5bqTf7BAAjT7Ok>
X-ME-Proxy-Cause: dmFkZTFn0xoDB0Ky0XJSTL505lUv52hyqXf5jIoR7AzQn4+3o2WEybO1jGx4IFKWDPwtsJ
    ty3Mvc26UuIbMvw05dUbCF7siMLm6pvTYBiFyqYXhQFbXXtKvMjdN5DepFDiy2yJnuKCyA
    OUSzj5QD2z50+3QhhGKFsmns905VMqsrBx4IC8h4YRQY6CXfXwXE7cgZ3LnBHipEcTfrfH
    B2pNBZE+bK+yZH1JyF0VpLgk23hEMhe0yvJgrL0iyBxs559ZmNmgnzceCuyzr3prTJvUW3
    d3ND6CITsbo68yhzKcreIzxnWS4Hs23fcKdfv97cMNnXGhu4Lwb4+U1c7uuWamr+Z1zEpH
    m+AfwgSvtdcMpffAV0LBLKuijA1YnE7CxCi2Gv92BIgEEU4wYQbWaGAtGkxjz+awkvqN/S
    tXAtJzyBgoSwLpcS6nOuZ1sv7EuX8b1LgbXq+nTefg9JEF3+T/Wus8+98yztG1W1YoLtSC
    Ce9nlHq0WArfYFsv29/mUeiwrB5XRjy2/9XmFOpLVk80zUK1+7HPMlZTq8Q6ZVwz1/SyLN
    wT+R55Pz2AzyU/iJH/LEB41O1K/O9T7bBDK8Ab59qhqLVKRAGI7pA0wAAfOBpnGEIp3RuT
    HEC3EE25fvXJ8qcUvNpU6yY7fsllvjGuUHFGWsdjDgwLYkJO1XfyJkbHWZKQ
X-ME-Proxy: <xmx:qno1ajJ9OVuQKvE5C7WMykEbPUoFOFiijRzq83M3iE_5b4V_3WdZ0A>
    <xmx:qno1aiV4DBTtFlpPeDVxmgqXLBSGl3VTifl1uDLBtmqeoLWx6EvgWA>
    <xmx:qno1avjjlNHjyveuFoFFT_eYthU-i99LqOkGp7YBnuun5yzuXluKuw>
    <xmx:qno1amvmghhw9isJGpefgVGOwq-Jkeg60s3DYYmo4EBhFToaLvae3Q>
    <xmx:q3o1aoXdOPkcWi3lsTa9R2GBQGJMFCQ_I5uSOpfvCgjIqL8UeYfTugky>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 755AC18E0078; Fri, 19 Jun 2026 13:21:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApWnn0dTpVfs
Date: Fri, 19 Jun 2026 20:21:26 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Paolo Abeni" <pabeni@redhat.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <1cf2746f-f15b-406d-bb49-2c3f2dee1ec2@app.fastmail.com>
In-Reply-To: <554ff2bd-e4d7-4e64-8ec4-86dc7da85992@redhat.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-5-alice.kernel@fastmail.im>
 <554ff2bd-e4d7-4e64-8ec4-86dc7da85992@redhat.com>
Subject: Re: [PATCH net-next v7 04/11] net: Enable BIG TCP with partial GSO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_TO(0.00)[redhat.com,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-300738-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fastmail.im:dkim,fastmail.im:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F26B6A7434

On Sun, Jun 14, 2026, at 14:19, Paolo Abeni wrote:
> On 6/11/26 9:29 PM, Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>> 
>> skb_segment is called for partial GSO, when netif_needs_gso returns true
>> in validate_xmit_skb. Partial GSO is needed, for example, when
>> segmentation of tunneled traffic is offloaded to a NIC that only
>> supports inner checksum offload.
>> 
>> Currently, skb_segment clamps the segment length to 65534 bytes, because
>> gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
>> to accidentally assign mss = 65535, as it would fall into the
>> GSO_BY_FRAGS check further in the function.
>> 
>> This implementation, however, artificially blocks len > 65534, which is
>> possible since the introduction of BIG TCP. To allow bigger lengths and
>> avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
>> the beginning and don't use a special value of mss for this purpose
>> after mss was modified.
>> 
>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> ---
>>  drivers/net/netdevsim/psp.c |  2 +-
>>  net/core/skbuff.c           | 10 +++++-----
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
>> index d3e36c74be62..6b3532b5e360 100644
>> --- a/drivers/net/netdevsim/psp.c
>> +++ b/drivers/net/netdevsim/psp.c
>> @@ -92,7 +92,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>>  		 * provide a valid checksum here, so the skb isn't dropped.
>>  		 */
>>  		uh = udp_hdr(skb);
>> -		udplen = ntohs(uh->len) ?: skb->len - skb_transport_offset(skb);
>> +		udplen = udp_get_len(skb, uh, skb_transport_offset(skb));
>>  		csum = skb_checksum(skb, skb_transport_offset(skb),
>>  				    udplen, 0);
>>  
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index c64693fcb2d1..5dcee79df8cf 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -4773,6 +4773,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  	struct sk_buff *tail = NULL;
>>  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
>>  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
>> +	bool gso_by_frags = mss == GSO_BY_FRAGS;
>>  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
>>  	unsigned int offset = doffset;
>>  	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
>> @@ -4788,7 +4789,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  	int nfrags, pos;
>>  
>>  	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
>> -	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
>> +	    !gso_by_frags && mss != skb_headlen(head_skb)) {
>>  		struct sk_buff *check_skb;
>>  
>>  		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
>> @@ -4816,7 +4817,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  	sg = !!(features & NETIF_F_SG);
>>  	csum = !!can_checksum_protocol(features, proto);
>>  
>> -	if (sg && csum && (mss != GSO_BY_FRAGS))  {
>> +	if (sg && csum && !gso_by_frags)  {
>>  		if (!(features & NETIF_F_GSO_PARTIAL)) {
>>  			struct sk_buff *iter;
>>  			unsigned int frag_len;
>> @@ -4850,9 +4851,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>>  		/* GSO partial only requires that we trim off any excess that
>>  		 * doesn't fit into an MSS sized block, so take care of that
>>  		 * now.
>> -		 * Cap len to not accidentally hit GSO_BY_FRAGS.
>>  		 */
>> -		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
>> +		partial_segs = len / mss;
>
> Sashiko/gemini says the above can lead to hit BUG_ON() later.
>
> I *think* it's not a false positive, as it looks like skb_segment()
> assumes an skb can hold `mss` bytes without resorting to frag_list
> usage, and mss > MAX_SKB_FRAGS * PAGE_SIZE  breaks such assumption.
>
> I think handling correctly this case will requires some non trivial
> surgery to skb_segment: both `while (pos < offset + len) {` loops must
> be updated to feed data from `frags` as needed instead of
> BUG_ON()/net_warn_ratelimited(skb_shinfo(nskb)->nr_frags >= MAX_SKB_FRAGS);

Thanks, these are some valid points. I analyzed the code in skb_segment
better, and from what I can tell, this issue exists before my changes,
even without BIG TCP (I have a reproduction). Moreover, I don't think
that my changes make the situation worse, because what truly matters is
the geometry of the SKB coming into skb_segment, not the sizes of the
frags as such.

The root of the issue is that skb_segment attempts to produce SKBs of
the same size and without frag_list, but the incoming SKB can have a
frag_list and more than 17 frags much smaller than PAGE_SIZE. For
example, if the incoming SKB has 30 frags (using frag_list) of 500 bytes
each, it's just 15000 bytes (much smaller than 64k or MAX_SKB_FRAGS *
PAGE_SIZE), but the partial GSO flow will try to fit almost all of them
(mss will be almost 15000) into a single non-frag_list SKB. Since
skb_segment just reuses the existing frags without combining them in any
way, this will end up with "too many frags".

This means that the assumption that an SKB can hold mss bytes without
frag_list is wrong, and skb_segment is already broken as it relies on
this assumption.

As for the solution, we can't just break the loop early before we put
len bytes into an output SKB, because it will break the guarantee that
the output SKBs have the same size. The only way I can imagine is to
dry-run the loop over all frags in advance and determine the smallest
length that any 17 consecutive frags can take together, and limit len
to that value.

Why adding BIG TCP into the picture doesn't make the situation worse, in
my opinion? There are two main practical ways to get into skb_segment
with BIG TCP:

1. Sending a TCP stream from an application. tcp_sendmsg_locked doesn't
   build frag_list SKBs, stopping at sysctl_max_skb_frags. If a non-
   frag_list SKB enters skb_segment, it can handle it even if it's well
   above 64k. From my observation, 32768-byte high order pages are
   allocated to back the frags.

2. Receiving a TCP stream with GRO, then forwarding it out of another
   network interface, e.g., that uses GSO partial. This is indeed broken
   if GRO resorts to frag_list, but, as shown above, it's broken even
   without BIG TCP.

Down below, I'll attach a reproducer patch (mostly generated with AI)
that adds debug prints to skb_segment and a script that sets up
forwarding to a GSO partial VXLAN netdev. Setting
net.core.high_order_alloc_disable is not even necessary: I can still
observe a 29026-byte SKB with 21 frags and frag_list (most frags are
1448 bytes), it's just these frags are allocated from two order-3 pages.

Here are example logs that show the geometry of an SKB that comes from
regular GRO (no BIG TCP) and breaks skb_segment:

skbuff: skb_segment: start head=ffff888101008a00 len=29026 doffset=66 mss=28960 gso_by_frags=0 features=0x0000010e501d0049
skbuff: skb_segment: input head[0] skb=ffff888101008a00 len=29026 data_len=28960 headlen=66 nr_frags=16 frag_list=ffff888104b7e900 head_frag=0 gso_size=1448 gso_segs=20 gso_type=0x801
skbuff: skb_segment: input head[0] frag[0] page=ffffea000420f7c0 head=ffffea000420f7c0 order=0 off=2480 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[1] page=ffffea000420f7c0 head=ffffea000420f7c0 order=0 off=3928 size=168 base_pages=1
skbuff: skb_segment: input head[0] frag[2] page=ffffea00048261c0 head=ffffea00048261c0 order=0 off=0 size=1280 base_pages=1
skbuff: skb_segment: input head[0] frag[3] page=ffffea00048261c0 head=ffffea00048261c0 order=0 off=1280 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[4] page=ffffea00048261c0 head=ffffea00048261c0 order=0 off=2728 size=1368 base_pages=1
skbuff: skb_segment: input head[0] frag[5] page=ffffea0004886400 head=ffffea0004886400 order=0 off=0 size=80 base_pages=1
skbuff: skb_segment: input head[0] frag[6] page=ffffea0004886400 head=ffffea0004886400 order=0 off=80 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[7] page=ffffea0004886400 head=ffffea0004886400 order=0 off=1528 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[8] page=ffffea0004886400 head=ffffea0004886400 order=0 off=2976 size=1120 base_pages=1
skbuff: skb_segment: input head[0] frag[9] page=ffffea00048883c0 head=ffffea00048883c0 order=0 off=0 size=328 base_pages=1
skbuff: skb_segment: input head[0] frag[10] page=ffffea00048883c0 head=ffffea00048883c0 order=0 off=328 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[11] page=ffffea00048883c0 head=ffffea00048883c0 order=0 off=1776 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[12] page=ffffea00048883c0 head=ffffea00048883c0 order=0 off=3224 size=872 base_pages=1
skbuff: skb_segment: input head[0] frag[13] page=ffffea00041bf840 head=ffffea00041bf840 order=0 off=0 size=576 base_pages=1
skbuff: skb_segment: input head[0] frag[14] page=ffffea00041bf840 head=ffffea00041bf840 order=0 off=576 size=1448 base_pages=1
skbuff: skb_segment: input head[0] frag[15] page=ffffea00041bf840 head=ffffea00041bf840 order=0 off=2024 size=1448 base_pages=1
skbuff: skb_segment: input frag_list[0] skb=ffff888104b7e900 len=11584 data_len=11584 headlen=0 nr_frags=11 frag_list=0000000000000000 head_frag=0 gso_size=0 gso_segs=0 gso_type=0x0
skbuff: skb_segment: input frag_list[0] frag[0] page=ffffea00041bf840 head=ffffea00041bf840 order=0 off=3472 size=624 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[1] page=ffffea000413ae40 head=ffffea000413ae40 order=0 off=0 size=824 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[2] page=ffffea000413ae40 head=ffffea000413ae40 order=0 off=824 size=1448 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[3] page=ffffea000413ae40 head=ffffea000413ae40 order=0 off=2272 size=1448 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[4] page=ffffea000413ae40 head=ffffea000413ae40 order=0 off=3720 size=376 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[5] page=ffffea000421d8c0 head=ffffea000421d8c0 order=0 off=0 size=1072 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[6] page=ffffea000421d8c0 head=ffffea000421d8c0 order=0 off=1072 size=1448 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[7] page=ffffea000421d8c0 head=ffffea000421d8c0 order=0 off=2520 size=1448 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[8] page=ffffea000421d8c0 head=ffffea000421d8c0 order=0 off=3968 size=128 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[9] page=ffffea0004826440 head=ffffea0004826440 order=0 off=0 size=1320 base_pages=1
skbuff: skb_segment: input frag_list[0] frag[10] page=ffffea0004826440 head=ffffea0004826440 order=0 off=1320 size=1448 base_pages=1
skbuff: skb_segment: setup after push head=ffff888101008a00 len=29026 payload=28960 offset=66 mss=28960 partial_segs=20 sg=1 csum=1 list_skb=ffff888104b7e900 features=0x0000010e501d0049
skbuff: skb_segment: segment begin offset=66 len=28960 end=29026 pos=66 i=0 nfrags=16 hsize=0 list_skb=ffff888104b7e900 frag_skb=ffff888101008a00
skbuff: skb_segment: alloc nskb=ffff888101cf5100 hsize=0 doffset=66 headroom=190
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=0 source_skb=ffff888101008a00 source=frag[0] page=ffffea000420f7c0 off=2480 size=1448 pos=66 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=1 pos=66 next_pos=1514 next_i=1
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=1 source_skb=ffff888101008a00 source=frag[1] page=ffffea000420f7c0 off=3928 size=168 pos=1514 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=2 pos=1514 next_pos=1682 next_i=2
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=2 source_skb=ffff888101008a00 source=frag[2] page=ffffea00048261c0 off=0 size=1280 pos=1682 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=3 pos=1682 next_pos=2962 next_i=3
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=3 source_skb=ffff888101008a00 source=frag[3] page=ffffea00048261c0 off=1280 size=1448 pos=2962 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=4 pos=2962 next_pos=4410 next_i=4
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=4 source_skb=ffff888101008a00 source=frag[4] page=ffffea00048261c0 off=2728 size=1368 pos=4410 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=5 pos=4410 next_pos=5778 next_i=5
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=5 source_skb=ffff888101008a00 source=frag[5] page=ffffea0004886400 off=0 size=80 pos=5778 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=6 pos=5778 next_pos=5858 next_i=6
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=6 source_skb=ffff888101008a00 source=frag[6] page=ffffea0004886400 off=80 size=1448 pos=5858 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=7 pos=5858 next_pos=7306 next_i=7
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=7 source_skb=ffff888101008a00 source=frag[7] page=ffffea0004886400 off=1528 size=1448 pos=7306 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=8 pos=7306 next_pos=8754 next_i=8
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=8 source_skb=ffff888101008a00 source=frag[8] page=ffffea0004886400 off=2976 size=1120 pos=8754 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=9 pos=8754 next_pos=9874 next_i=9
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=9 source_skb=ffff888101008a00 source=frag[9] page=ffffea00048883c0 off=0 size=328 pos=9874 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=10 pos=9874 next_pos=10202 next_i=10
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=10 source_skb=ffff888101008a00 source=frag[10] page=ffffea00048883c0 off=328 size=1448 pos=10202 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=11 pos=10202 next_pos=11650 next_i=11
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=11 source_skb=ffff888101008a00 source=frag[11] page=ffffea00048883c0 off=1776 size=1448 pos=11650 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=12 pos=11650 next_pos=13098 next_i=12
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=12 source_skb=ffff888101008a00 source=frag[12] page=ffffea00048883c0 off=3224 size=872 pos=13098 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=13 pos=13098 next_pos=13970 next_i=13
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=13 source_skb=ffff888101008a00 source=frag[13] page=ffffea00041bf840 off=0 size=576 pos=13970 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=14 pos=13970 next_pos=14546 next_i=14
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=14 source_skb=ffff888101008a00 source=frag[14] page=ffffea00041bf840 off=576 size=1448 pos=14546 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=15 pos=14546 next_pos=15994 next_i=15
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=15 source_skb=ffff888101008a00 source=frag[15] page=ffffea00041bf840 off=2024 size=1448 pos=15994 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=16 pos=15994 next_pos=17442 next_i=16
skbuff: skb_segment: sg source exhausted pos=17442 target_end=29026 old_frag_skb=ffff888101008a00 old_nfrags=16 next_list=ffff888104b7e900
skbuff: skb_segment: sg entered frag_list skb=ffff888104b7e900 len=11584 headlen=0 nr_frags=11 head_frag=0 start_i=0 next_list=0000000000000000
skbuff: skb_segment: sg add nskb=ffff888101cf5100 out_frag=16 source_skb=ffff888104b7e900 source=frag[0] page=ffffea00041bf840 off=3472 size=624 pos=17442 target=[66,29026)
skbuff: skb_segment: sg consumed source nskb=ffff888101cf5100 out_nr_frags=17 pos=17442 next_pos=18066 next_i=1
skbuff: skb_segment: sg output full nskb=ffff888101cf5100 nr_frags=17 max=17 pos=18066 target_end=29026 source_i=1 source_nfrags=11 source_skb=ffff888104b7e900
skbuff: skb_segment: too many frags: 18066 28960
skbuff: skb_segment: error err=-22 segs=ffff888101cf5100 tail=0000000019d2a099 offset=66 len=28960 pos=18066 i=1 nfrags=11 list_skb=0000000000000000 frag_skb=ffff888104b7e900

Here goes the reproducer patch (applies on top of net-next):

--cut--
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..f23aff92f857 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -65,6 +65,7 @@
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
 #include <linux/crc32.h>
+#include <linux/ratelimit.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -4759,6 +4760,77 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_segment_list);
 
+static DEFINE_RATELIMIT_STATE(skb_segment_trace_ratelimit, 5 * HZ, 1);
+
+//#define SKB_SEGMENT_TRACE_THRESHOLD GSO_LEGACY_MAX_SIZE
+#define SKB_SEGMENT_TRACE_THRESHOLD 20000
+
+static bool skb_segment_trace(const struct sk_buff *skb,
+			      unsigned int mss)
+{
+	if (!mss || mss == GSO_BY_FRAGS)
+		return false;
+
+	if (mss <= SKB_SEGMENT_TRACE_THRESHOLD && skb->len <= SKB_SEGMENT_TRACE_THRESHOLD)
+		return false;
+
+	return __ratelimit(&skb_segment_trace_ratelimit);
+}
+
+static void skb_segment_dbg_dump_skb(const char *stage, const char *role,
+				     unsigned int idx,
+				     const struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	unsigned int nr_frags = shinfo->nr_frags;
+	unsigned int i;
+
+	pr_info("skb_segment: %s %s[%u] skb=%px len=%u data_len=%u headlen=%u nr_frags=%u frag_list=%px head_frag=%u gso_size=%u gso_segs=%u gso_type=0x%x\n",
+		stage, role, idx, skb, skb->len, skb->data_len,
+		skb_headlen(skb), nr_frags, shinfo->frag_list,
+		skb->head_frag, shinfo->gso_size, shinfo->gso_segs,
+		shinfo->gso_type);
+
+	for (i = 0; i < nr_frags; i++) {
+		const skb_frag_t *frag = &shinfo->frags[i];
+
+		struct page *page = skb_frag_page(frag);
+		struct page *head = compound_head(page);
+		unsigned int off = skb_frag_off(frag);
+		unsigned int size = skb_frag_size(frag);
+		unsigned int base_pages;
+
+		base_pages = ((off + size - 1) >> PAGE_SHIFT) - (off >> PAGE_SHIFT) + 1;
+
+		pr_info("skb_segment: %s %s[%u] frag[%u] page=%px head=%px order=%u off=%u size=%u base_pages=%u\n",
+			stage, role, idx, i, skb_frag_page(frag),
+			head, compound_order(head),
+			skb_frag_off(frag), skb_frag_size(frag),
+			base_pages);
+	}
+}
+
+static void skb_segment_dbg_dump_tree(const char *stage,
+				      const struct sk_buff *skb)
+{
+	struct sk_buff *iter;
+	unsigned int i = 0;
+
+	skb_segment_dbg_dump_skb(stage, "head", 0, skb);
+	skb_walk_frags(skb, iter)
+		skb_segment_dbg_dump_skb(stage, "frag_list", i++, iter);
+}
+
+static void skb_segment_dbg_dump_list(const char *stage,
+				      const struct sk_buff *skb)
+{
+	const struct sk_buff *iter;
+	unsigned int i = 0;
+
+	for (iter = skb; iter; iter = iter->next)
+		skb_segment_dbg_dump_skb(stage, "out", i++, iter);
+}
+
 /**
  *	skb_segment - Perform protocol segmentation on skb.
  *	@head_skb: buffer to segment
@@ -4775,6 +4847,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4784,6 +4857,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *frag_skb;
 	skb_frag_t *frag;
 	__be16 proto;
+	bool trace = false;
 	bool csum, sg;
 	int err = -ENOMEM;
 	int i = 0;
@@ -4861,6 +4935,18 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			partial_segs = 0;
 	}
 
+	trace = skb_segment_trace(head_skb, mss);
+	if (trace) {
+		pr_info("skb_segment: start head=%px len=%u doffset=%u mss=%u gso_by_frags=%u features=%pNF\n",
+			head_skb, head_skb->len, doffset, mss, gso_by_frags,
+			&features);
+		skb_segment_dbg_dump_tree("input", head_skb);
+		pr_info("skb_segment: setup after push head=%px len=%u payload=%u offset=%u mss=%u partial_segs=%u sg=%u csum=%u list_skb=%px features=%pNF\n",
+			head_skb, head_skb->len, head_skb->len - offset,
+			offset, mss, partial_segs, sg, csum, list_skb,
+			&features);
+	}
+
 normal:
 	headroom = skb_headroom(head_skb);
 	pos = skb_headlen(head_skb);
@@ -4888,10 +4974,22 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
+		if (trace)
+			pr_info("skb_segment: segment begin offset=%u len=%u end=%u pos=%d i=%d nfrags=%d hsize=%d list_skb=%px frag_skb=%px\n",
+				offset, len, offset + len, pos, i, nfrags,
+				hsize, list_skb, frag_skb);
+
 		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			if (trace)
+				pr_info("skb_segment: clone frag_list skb=%px headlen=%u len=%u nr_frags=%u pos=%d target_end=%u sg=%u\n",
+					list_skb, skb_headlen(list_skb),
+					list_skb->len,
+					skb_shinfo(list_skb)->nr_frags,
+					pos, offset + len, sg);
+
 			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			if (unlikely(!nskb))
 				goto err;
@@ -4903,9 +5001,22 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			pos += skb_headlen(list_skb);
 
 			while (pos < offset + len) {
+				if (trace)
+					pr_info("skb_segment: clone walk pos=%d target_end=%u i=%d nfrags=%d frag_skb=%px\n",
+						pos, offset + len, i, nfrags,
+						frag_skb);
+				if (trace && i >= nfrags)
+					pr_info("skb_segment: clone walk would BUG: pos=%d target_end=%u i=%d nfrags=%d list_skb=%px\n",
+						pos, offset + len, i, nfrags,
+						list_skb);
 				BUG_ON(i >= nfrags);
 
 				size = skb_frag_size(frag);
+				if (trace)
+					pr_info("skb_segment: clone walk frag[%d] page=%px off=%u size=%d pos=%d next=%d target_end=%u\n",
+						i, skb_frag_page(frag),
+						skb_frag_off(frag), size, pos,
+						pos + size, offset + len);
 				if (pos + size > offset + len)
 					break;
 
@@ -4916,6 +5027,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			list_skb = list_skb->next;
 
+			if (trace)
+				pr_info("skb_segment: clone walk done nskb=%px pos=%d i=%d next_list=%px\n",
+					nskb, pos, i, list_skb);
+
 			if (unlikely(pskb_trim(nskb, len))) {
 				kfree_skb(nskb);
 				goto err;
@@ -4945,6 +5060,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			skb_reserve(nskb, headroom);
 			__skb_put(nskb, doffset);
+
+			if (trace)
+				pr_info("skb_segment: alloc nskb=%px hsize=%d doffset=%u headroom=%u\n",
+					nskb, hsize, doffset, headroom);
 		}
 
 		if (segs)
@@ -4997,6 +5116,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (trace)
+					pr_info("skb_segment: sg source exhausted pos=%d target_end=%u old_frag_skb=%px old_nfrags=%d next_list=%px\n",
+						pos, offset + len, frag_skb,
+						nfrags, list_skb);
 				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
 				    skb_zerocopy_clone(nskb, list_skb,
 						       GFP_ATOMIC))
@@ -5019,11 +5142,24 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 					frag--;
 				}
 
+				if (trace)
+					pr_info("skb_segment: sg entered frag_list skb=%px len=%u headlen=%u nr_frags=%d head_frag=%u start_i=%d next_list=%px\n",
+						frag_skb, frag_skb->len,
+						skb_headlen(frag_skb), nfrags,
+						frag_skb->head_frag, i,
+						list_skb->next);
+
 				list_skb = list_skb->next;
 			}
 
 			if (unlikely(skb_shinfo(nskb)->nr_frags >=
 				     MAX_SKB_FRAGS)) {
+				if (trace)
+					pr_info("skb_segment: sg output full nskb=%px nr_frags=%u max=%u pos=%d target_end=%u source_i=%d source_nfrags=%d source_skb=%px\n",
+						nskb, skb_shinfo(nskb)->nr_frags,
+						MAX_SKB_FRAGS, pos,
+						offset + len, i, nfrags,
+						frag_skb);
 				net_warn_ratelimited(
 					"skb_segment: too many frags: %u %u\n",
 					pos, mss);
@@ -5035,18 +5171,46 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			__skb_frag_ref(nskb_frag);
 			size = skb_frag_size(nskb_frag);
 
+			if (trace)
+				pr_info("skb_segment: sg add nskb=%px out_frag=%u source_skb=%px source=%s[%d] page=%px off=%u size=%d pos=%d target=[%u,%u)\n",
+					nskb, skb_shinfo(nskb)->nr_frags,
+					frag_skb, i < 0 ? "head_frag" : "frag",
+					i, skb_frag_page(nskb_frag),
+					skb_frag_off(nskb_frag), size, pos,
+					offset, offset + len);
+
 			if (pos < offset) {
+				if (trace)
+					pr_info("skb_segment: sg trim front nskb=%px out_frag=%u trim=%u old_off=%u old_size=%d\n",
+						nskb, skb_shinfo(nskb)->nr_frags,
+						offset - pos,
+						skb_frag_off(nskb_frag), size);
 				skb_frag_off_add(nskb_frag, offset - pos);
 				skb_frag_size_sub(nskb_frag, offset - pos);
+				if (trace)
+					pr_info("skb_segment: sg trim front done nskb=%px out_frag=%u new_off=%u new_size=%u\n",
+						nskb, skb_shinfo(nskb)->nr_frags,
+						skb_frag_off(nskb_frag),
+						skb_frag_size(nskb_frag));
 			}
 
 			skb_shinfo(nskb)->nr_frags++;
 
 			if (pos + size <= offset + len) {
+				if (trace)
+					pr_info("skb_segment: sg consumed source nskb=%px out_nr_frags=%u pos=%d next_pos=%d next_i=%d\n",
+						nskb, skb_shinfo(nskb)->nr_frags,
+						pos, pos + size, i + 1);
 				i++;
 				frag++;
 				pos += size;
 			} else {
+				if (trace)
+					pr_info("skb_segment: sg trim tail nskb=%px out_frag=%u trim=%u pos=%d size=%d target_end=%u\n",
+						nskb,
+						skb_shinfo(nskb)->nr_frags - 1,
+						pos + size - (offset + len),
+						pos, size, offset + len);
 				skb_frag_size_sub(nskb_frag, pos + size - (offset + len));
 				goto skip_fraglist;
 			}
@@ -5059,6 +5223,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		nskb->len += nskb->data_len;
 		nskb->truesize += nskb->data_len;
 
+		if (trace)
+			pr_info("skb_segment: segment built nskb=%px len=%u data_len=%u nr_frags=%u hsize=%d offset=%u seg_len=%u pos=%d i=%d next_offset=%u\n",
+				nskb, nskb->len, nskb->data_len,
+				skb_shinfo(nskb)->nr_frags, hsize, offset,
+				len, pos, i, offset + len);
+
 perform_csum_check:
 		if (!csum) {
 			if (skb_has_shared_frag(nskb) &&
@@ -5106,6 +5276,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			skb_shinfo(tail)->gso_segs = DIV_ROUND_UP(tail->len - doffset, gso_size);
 	}
 
+	if (trace)
+		skb_segment_dbg_dump_list("output", segs);
+
 	/* Following permits correct backpressure, for protocols
 	 * using skb_set_owner_w().
 	 * Idea is to tranfert ownership from head_skb to last segment.
@@ -5118,6 +5291,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	return segs;
 
 err:
+	if (trace)
+		pr_info("skb_segment: error err=%d segs=%px tail=%p offset=%u len=%u pos=%d i=%d nfrags=%d list_skb=%px frag_skb=%px\n",
+			err, segs, tail, offset, len, pos, i, nfrags,
+			list_skb, frag_skb);
 	kfree_skb_list(segs);
 	return ERR_PTR(err);
 }
diff --git a/tools/testing/selftests/net/big_tcp_repro.sh b/tools/testing/selftests/net/big_tcp_repro.sh
new file mode 100755
index 000000000000..7c465938526d
--- /dev/null
+++ b/tools/testing/selftests/net/big_tcp_repro.sh
@@ -0,0 +1,226 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Reproducer for GRO frag_list failure in skb_segment.
+#
+# Topology:
+#
+#   client ns                 router ns                         server ns
+#   c0 10.0.0.1  <--veth-->  r0 10.0.0.2
+#                             r1 10.0.1.1  <--veth-->          s1 10.0.1.2
+#                             ptun0 10.0.2.1 <--outer vxlan--> ptun1 10.0.2.2
+#                             tun0 192.0.2.1 <--inner vxlan--> tun1 192.0.2.2
+#
+# The client emits non-GSO TCP packets. The router receives them on r0 with
+# plain GRO enabled, forwards the GRO skb into the inner VXLAN tunnel, then
+# sends the already-encapsulated skb through the outer VXLAN tunnel with
+# tx-gso-partial enabled. The outer tunnel forces the SKB into skb_segment for
+# partial GSO, where "skb_segment: too many frags" can be caught.
+
+set -euo pipefail
+
+CLIENT_NS=$(mktemp -u btcp-client-XXXXXXXX)
+ROUTER_NS=$(mktemp -u btcp-router-XXXXXXXX)
+SERVER_NS=$(mktemp -u btcp-server-XXXXXXXX)
+
+CLIENT_IP=10.0.0.1
+ROUTER_CLIENT_IP=10.0.0.2
+ROUTER_UNDERLAY_IP=10.0.1.1
+SERVER_UNDERLAY_IP=10.0.1.2
+ROUTER_OUTER_IP=10.0.2.1
+SERVER_OUTER_IP=10.0.2.2
+ROUTER_INNER_IP=192.0.2.1
+SERVER_INNER_IP=192.0.2.2
+
+NETPERF_TIME=${NETPERF_TIME:-10}
+NETPERF_WRITE=${NETPERF_WRITE:-262144}
+LOWER_MTU=${LOWER_MTU:-9000}
+SHOW_DMESG=${SHOW_DMESG:-1}
+CLEAR_DMESG=${CLEAR_DMESG:-0}
+
+OLD_HIGH_ORDER_ALLOC_DISABLE=
+
+require_command()
+{
+	if ! command -v "$1" >/dev/null 2>&1; then
+		echo "SKIP: missing $1"
+		exit 4
+	fi
+}
+
+cleanup()
+{
+	for ns in "$SERVER_NS" "$ROUTER_NS" "$CLIENT_NS"; do
+		ip netns pids "$ns" 2>/dev/null | xargs -r kill 2>/dev/null || true
+	done
+
+	ip netns del "$SERVER_NS" 2>/dev/null || true
+	ip netns del "$ROUTER_NS" 2>/dev/null || true
+	ip netns del "$CLIENT_NS" 2>/dev/null || true
+
+	if [ -n "$OLD_HIGH_ORDER_ALLOC_DISABLE" ]; then
+		sysctl -qw "net.core.high_order_alloc_disable=$OLD_HIGH_ORDER_ALLOC_DISABLE" || true
+	fi
+}
+
+ethtool_must()
+{
+	local ns=$1
+	local dev=$2
+
+	shift 2
+	ip netns exec "$ns" ethtool -K "$dev" "$@"
+}
+
+ethtool_try()
+{
+	local ns=$1
+	local dev=$2
+
+	shift 2
+	ip netns exec "$ns" ethtool -K "$dev" "$@" >/dev/null 2>&1 || true
+}
+
+setup_namespaces()
+{
+	ip netns add "$CLIENT_NS"
+	ip netns add "$ROUTER_NS"
+	ip netns add "$SERVER_NS"
+
+	for ns in "$CLIENT_NS" "$ROUTER_NS" "$SERVER_NS"; do
+		ip -n "$ns" link set lo up
+		ip netns exec "$ns" sysctl -qw net.ipv4.conf.all.rp_filter=0
+		ip netns exec "$ns" sysctl -qw net.ipv4.conf.default.rp_filter=0
+	done
+	ip netns exec "$ROUTER_NS" sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec "$CLIENT_NS" sysctl -qw net.ipv4.tcp_wmem="4096 4194304 4194304"
+	ip netns exec "$SERVER_NS" sysctl -qw net.ipv4.tcp_rmem="4096 4194304 4194304"
+
+	ip -n "$CLIENT_NS" link add c0 type veth peer name r0 netns "$ROUTER_NS"
+	ip -n "$ROUTER_NS" link add r1 type veth peer name s1 netns "$SERVER_NS"
+
+	ip -n "$CLIENT_NS" addr add "$CLIENT_IP/24" dev c0
+	ip -n "$ROUTER_NS" addr add "$ROUTER_CLIENT_IP/24" dev r0
+	ip -n "$ROUTER_NS" addr add "$ROUTER_UNDERLAY_IP/24" dev r1
+	ip -n "$SERVER_NS" addr add "$SERVER_UNDERLAY_IP/24" dev s1
+
+	ip -n "$ROUTER_NS" link set dev r1 mtu "$LOWER_MTU"
+	ip -n "$SERVER_NS" link set dev s1 mtu "$LOWER_MTU"
+
+	ip -n "$CLIENT_NS" link set c0 up
+	ip -n "$ROUTER_NS" link set r0 up
+	ip -n "$ROUTER_NS" link set r1 up
+	ip -n "$SERVER_NS" link set s1 up
+
+	ip -n "$CLIENT_NS" route add "$SERVER_INNER_IP/32" via "$ROUTER_CLIENT_IP" dev c0
+}
+
+setup_tunnels()
+{
+	ip -n "$ROUTER_NS" link add ptun0 type vxlan \
+		id 100 local "$ROUTER_UNDERLAY_IP" remote "$SERVER_UNDERLAY_IP" dev r1 dstport 4790
+	ip -n "$SERVER_NS" link add ptun1 type vxlan \
+		id 100 local "$SERVER_UNDERLAY_IP" remote "$ROUTER_UNDERLAY_IP" dev s1 dstport 4790
+
+	ip -n "$ROUTER_NS" addr add "$ROUTER_OUTER_IP/24" dev ptun0
+	ip -n "$SERVER_NS" addr add "$SERVER_OUTER_IP/24" dev ptun1
+	ip -n "$ROUTER_NS" link set ptun0 up
+	ip -n "$SERVER_NS" link set ptun1 up
+
+	ip -n "$ROUTER_NS" link add tun0 type vxlan \
+		id 200 local "$ROUTER_OUTER_IP" remote "$SERVER_OUTER_IP" dev ptun0 dstport 4789
+	ip -n "$SERVER_NS" link add tun1 type vxlan \
+		id 200 local "$SERVER_OUTER_IP" remote "$ROUTER_OUTER_IP" dev ptun1 dstport 4789
+
+	ip -n "$ROUTER_NS" addr add "$ROUTER_INNER_IP/24" dev tun0
+	ip -n "$SERVER_NS" addr add "$SERVER_INNER_IP/24" dev tun1
+	ip -n "$ROUTER_NS" link set tun0 up
+	ip -n "$SERVER_NS" link set tun1 up
+
+	ip -n "$SERVER_NS" route add "$CLIENT_IP/32" via "$ROUTER_INNER_IP" dev tun1
+}
+
+setup_offloads()
+{
+	# Client must put non-GSO packets onto c0 so router-side r0 can GRO them.
+	ethtool_must "$CLIENT_NS" c0 tso off gso off
+	ethtool_try "$CLIENT_NS" c0 tx-gso-partial off
+	ethtool_try "$CLIENT_NS" c0 tx-udp_tnl-segmentation off
+	ethtool_try "$CLIENT_NS" c0 tx-udp_tnl-csum-segmentation off
+
+	# Router ingress: normal GRO, not rx-gro-list.  We want skb_gro_receive()
+	# to fill order-0 frags and then use frag_list as the fallback.
+	ethtool_must "$ROUTER_NS" r0 gro on
+	ethtool_try "$ROUTER_NS" r0 rx-gro-list off
+
+	# Outer tunnel: this is the partial-GSO-capable software egress.
+	ethtool_must "$ROUTER_NS" ptun0 \
+		tx-gso-partial on \
+		tx-udp_tnl-segmentation on \
+		tx-udp_tnl-csum-segmentation on
+
+	# Lower veth must not absorb the whole outer tunnel GSO packet.
+	ethtool_must "$ROUTER_NS" r1 tso off gso off
+	ethtool_try "$ROUTER_NS" r1 tx-gso-partial off
+	ethtool_try "$ROUTER_NS" r1 tx-udp_tnl-segmentation off
+	ethtool_try "$ROUTER_NS" r1 tx-udp_tnl-csum-segmentation off
+}
+
+show_relevant_state()
+{
+	echo "Client TX offloads:"
+	ip netns exec "$CLIENT_NS" ethtool -k c0 | grep -E 'tcp-segmentation-offload|generic-segmentation-offload|tx-gso-partial|tx-udp_tnl' || true
+	echo
+	echo "Router GRO ingress:"
+	ip -n "$ROUTER_NS" -d link show r0 | grep -E 'gso|gro' || true
+	ip netns exec "$ROUTER_NS" ethtool -k r0 | grep -E 'generic-receive-offload|rx-gro-list' || true
+	echo
+	echo "Router partial-GSO outer tunnel:"
+	ip netns exec "$ROUTER_NS" ethtool -k ptun0 | grep -E 'tx-gso-partial|tx-udp_tnl' || true
+}
+
+run_traffic()
+{
+	ip netns exec "$SERVER_NS" netserver >/dev/null
+	sleep 1
+
+	if [ "$CLEAR_DMESG" = 1 ]; then
+		dmesg -C || true
+	fi
+
+	echo "Running TCP_STREAM from $CLIENT_NS to $SERVER_INNER_IP for ${NETPERF_TIME}s"
+	ip netns exec "$CLIENT_NS" netperf -H "$SERVER_INNER_IP" \
+		-t TCP_STREAM -l "$NETPERF_TIME" -- -m "$NETPERF_WRITE" >/dev/null
+
+	if [ "$SHOW_DMESG" = 1 ]; then
+		echo
+		echo "Recent skb_segment logs:"
+		dmesg | grep 'skb_segment' || true
+	fi
+}
+
+require_command ip
+require_command ethtool
+require_command netperf
+require_command netserver
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "SKIP: must be run as root"
+	exit 4
+fi
+
+if ! { ip link help 2>&1 || :; } | grep -q gso_ipv4_max_size; then
+	echo "SKIP: iproute2 does not support gso/gro IPv4 max size knobs"
+	exit 4
+fi
+
+trap cleanup EXIT
+
+OLD_HIGH_ORDER_ALLOC_DISABLE=$(sysctl -n net.core.high_order_alloc_disable 2>/dev/null || true)
+#sysctl -qw net.core.high_order_alloc_disable=1
+
+setup_namespaces
+setup_tunnels
+setup_offloads
+show_relevant_state
+run_traffic
--cut--

Thanks,
Alice

