Return-Path: <netdev+bounces-279556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOz6I28D5GlxOgEAu9opvQ
	(envelope-from <netdev+bounces-279556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 00:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FAE422658
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 00:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B518300B478
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722134E771;
	Sat, 18 Apr 2026 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B4uwnfyT"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8473290A6
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776550764; cv=none; b=HsIS8lziATH466G++lcSZb4OWUANCyqACpGYaShk/g8rUI/yfXm0r3odJ+XEbdiQZSzdJUSXFiB4lyJlJo4qWRT3BA5Ap7gekz7e4ZTDtQVZ3l3/5+9DZLKgKpWFYPBhooilCC7llmFKKIAfRQpUxoNXSklVR3CAjtkqgwhnfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776550764; c=relaxed/simple;
	bh=swxbkozRstnvpymoFQCRFhRPwHx9yAb/SQAOYxlwLhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAqcsquevKDoTiwULuu5B4jI4hDRTN8KTvSebow9+SOctWjOhIlG33jeeE1aUSUkmYRtDV9mkGILvuBubeXJwCG2tPGh1drDBggF35rDFHpXBsCcazv1daErOHHKqhzlmwdXEioWSgSeY09zKHPC7+eCdo7BOdJabQqpXqQdaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=B4uwnfyT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kH8QAkIcUSNim/SI0aHSVBqziRWItbhyq4OxxQrrvD4=; b=B4uwnfyTkW9zhxS4J2jW0eZm5a
	PtKRjRkDUKYKhJQp4oLysyAu5+y+oWAAs77tbZwRZgqjbPTaLA0vbJx3EtE1dJvHEQOlYm9ScMP3r
	mOiA5eIJKgF0W47+1Q+Jed3Qttqq/t0+kCRgl5KhuwkSZMkt9IPlEHOhwbyixG70lT8v523xyfZsb
	h5gjpTt+ZNVurh9cm+LNnuRQnXoKcTkFT2m8EvbRAehOC4/KWsmKQaFxbYRFTSFaH3wJ2MYe0QilL
	D8go6+aSaKXCllaqFRz/0AmnU4H5e6ArDbBhLQKpYRn9SjjZqMlAsNDMsaRGsRR4lrgFxlQSDYe+i
	VEjBWBsA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wEE0O-000NZ0-2F;
	Sun, 19 Apr 2026 00:19:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wEE0O-0001xJ-0a;
	Sun, 19 Apr 2026 00:19:12 +0200
Message-ID: <d8d60970-6f73-4b9d-8808-76f4f8023100@iogearbox.net>
Date: Sun, 19 Apr 2026 00:19:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Apply max_dst_opts_cnt to
 ip6_tnl_parse_tlv_enc_lim
To: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260418121538.706095-1-daniel@iogearbox.net>
 <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27975/Sat Apr 18 08:26:10 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279556-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39FAE422658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 2:40 PM, Justin Iurman wrote:
> On 4/18/26 14:15, Daniel Borkmann wrote:
>> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
>> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
>> and applied them in ip6_parse_tlv(), the generic TLV walker
>> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
>>
>> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
>> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
>> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
>> loop is bounded only by optlen, which can be up to 2048 bytes.
>> Stuffing the Destination Options header with 2046 Pad1 (type=0)
>> entries advances the scanner a single byte at a time, yielding
>> ~2000 TLV iterations per extension header.
>>
>> Reuse max_dst_opts_cnt to bound the TLV iterations, matching
>> the semantics from 47d3d7ac656a.
>>
>> Fixes: 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination options")
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   v1->v2:
>>     - Remove unlikely (Justin)
>>     - Use abs() given max_dst_opts_cnt's negative meaning (Justin)
>>
>>   net/ipv6/ip6_tunnel.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
>> index 907c6a2af331..0f50b7fcb24e 100644
>> --- a/net/ipv6/ip6_tunnel.c
>> +++ b/net/ipv6/ip6_tunnel.c
>> @@ -430,11 +430,16 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>>                   break;
>>           }
>>           if (nexthdr == NEXTHDR_DEST) {
>> +            int tlv_max = abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
>> +            int tlv_cnt = 0;
>>               u16 i = 2;
>>               while (1) {
>>                   struct ipv6_tlv_tnl_enc_lim *tel;
>> +                if (tlv_cnt++ >= tlv_max)
>> +                    break;
>> +
>>                   /* No more room for encapsulation limit */
>>                   if (i + sizeof(*tel) > optlen)
>>                       break;
> 
> Thanks for v2, Daniel.
> 
> I'm still wondering: should we align the above parsing behavior with the one in ip6_parse_tlv() to keep things consistent? That is: don't increment tlv_cnt for Pad1/PadN, make sure we don't exceed 8 bytes per padding (consecutive Pad1's, or a PadN), and we could also check that a PadN payload is only made of zeroes. Open question...

Hm, so it would be sth like the below on top of this one, I'd wish we wouldn't
have to open code another ip6_parse_tlv().

Have you seen such cases with the encap limit in the wild (vs encap limit as
first tlv) where a stack places leading Pad1/PadN before encap limit which the
v2 patch wouldn't catch?

  net/ipv6/ip6_tunnel.c | 42 +++++++++++++++++++++++++++++++-----------
  1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 0f50b7fcb24e..1fa42a1cd97c 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -432,28 +432,48 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
  		if (nexthdr == NEXTHDR_DEST) {
  			int tlv_max = abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
  			int tlv_cnt = 0;
+			int padlen = 0;
  			u16 i = 2;
  
-			while (1) {
-				struct ipv6_tlv_tnl_enc_lim *tel;
+			while (i < optlen) {
+				struct ipv6_tlv_tnl_enc_lim *tel =
+					(struct ipv6_tlv_tnl_enc_lim *)(skb->data + off + i);
+				int tel_len;
  
-				if (tlv_cnt++ >= tlv_max)
+				if (tel->type == IPV6_TLV_PAD1) {
+					if (++padlen > 7)
+						break;
+					i++;
+					continue;
+				}
+
+				if (i + 2 > optlen)
+					break;
+				tel_len = tel->length + 2;
+				if (i + tel_len > optlen)
  					break;
  
-				/* No more room for encapsulation limit */
-				if (i + sizeof(*tel) > optlen)
+				if (tel->type == IPV6_TLV_PADN) {
+					padlen += tel_len;
+					if (padlen > 7)
+						break;
+					if (memchr_inv((u8 *)tel + 2, 0,
+						       tel->length))
+						break;
+					i += tel_len;
+					continue;
+				}
+				padlen = 0;
+
+				if (tlv_cnt++ >= tlv_max)
  					break;
  
-				tel = (struct ipv6_tlv_tnl_enc_lim *)(skb->data + off + i);
  				/* return index of option if found and valid */
  				if (tel->type == IPV6_TLV_TNL_ENCAP_LIMIT &&
  				    tel->length == 1)
  					return i + off - nhoff;
-				/* else jump to next option */
-				if (tel->type)
-					i += tel->length + 2;
-				else
-					i++;
+
+				i += tel_len;
  			}
  		}
  		nexthdr = hdr->nexthdr;
-- 
2.43.0

> Otherwise, LGTM:
> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Thanks,
Daniel

