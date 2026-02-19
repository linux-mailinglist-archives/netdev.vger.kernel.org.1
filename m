Return-Path: <netdev+bounces-259443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKjVLVUAl2mItQIAu9opvQ
	(envelope-from <netdev+bounces-259443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8F15E8FD
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57CB3300E259
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B295223DD6;
	Thu, 19 Feb 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oKM1cLKo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lvLw/wKU"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190A1EB9E1;
	Thu, 19 Feb 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503696; cv=pass; b=KMikOX69sbub7B6h1C0DcTiR+uWJf8XivbzhzySNY1ctZsgbk0WCZDtBQ6eMsUNJ/POyOBplN5skf22BXfWhL7TyUO5MAuIxzNz5zFBV1oVTHcjXlQ+PbIZQXaWRp3S6shRoozmttvAjLIDShzPrxFxFJB7cvYM4+6magEH0GPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503696; c=relaxed/simple;
	bh=h63ZdEaaEPnZsRx6yiC2v1fC2mPZzy2aCrwUBkQ4jUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r70s1Q15MREBXbB5jMYpt+9DmrBlnsbctWFW9oJgxVigIJWrHgKivaAE9ENbtfRkCCjxkCK+8rXKiDnr7swnSNMGBrMUfDMUzsUbqhl1fRuS5Ii186yaOjRTJdNBi9JyYiwaeicZi+jiiR1OXQ44Zubxe4AtBkBHYsaYckiaJHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oKM1cLKo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lvLw/wKU; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1771503501; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FuEqPBV6oVYJEQ1tD/JwSXTRCbAuK6lO0BtMvK+k7HZINKUYyUovzinOVcL587Qiek
    i0Ouf8nGFwA2Ijb4na7VCIS+uA3u3yqDcwGU5rkcIx9dVA8HXqz5F8WgxJceg8XyLWOA
    pCwqphzo+GZS0fOpPBiTxLl7dP9l5u4P8d3YSUZmIV86Pz4lB2IS0Bgnil9TrA6Gf7Kl
    MbBIERE4xaSTn9K+jHt/GVDxdaKQXmJjuNLg+zR985jDgFaM+5azPc3BLGzTs2COr2Kw
    WZKcRA57UJDvPgiSF4YOYw8GD03zO7klrlnrztQXhvDq4N9VMLh7lI06NQB2xkYUBxoc
    FbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771503501;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LCyaAbyVtKip3XCHObo7iedMbzRRklZBba0c3rwtqjI=;
    b=PoecEVCFkZCPso5psypG/Io8BP3gqSACmoHmTI45heDJjCXCdnssS3knjhHozc0MLj
    wEjHJBSUOC6hoHXYfkjinlgM0K/9fLIuI070J+KQD4MCJe+EBr8HDB0iyNjBrKgj1H7Z
    bYdi83wFm0opIf5H6w6joH3XeYtG6XhaffVfrtQB0Z0buZ/cFLb39st2+fD4/q2dOnmW
    ZL8slWvAHS/f72VVr+OtQQbEQfDbuSBzOHQbZDoXWT7R5aoUE/K5BpPclfPhT99lFblE
    UpzFLsNlQDPLRaQ1g2ii3L62/GVsJQ9HADs3tZP8vEODg7JG2eRHwr48xUd72s0g4p2g
    BFsw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771503501;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LCyaAbyVtKip3XCHObo7iedMbzRRklZBba0c3rwtqjI=;
    b=oKM1cLKoA8HlN4JFrHXQDmlSXiBRsvJAT7pBV6LTxhxmL2NB+PEDnUus8pR0sDM1Sl
    niETk59rUepMYwHyiDF0h20ruT4s7PMH/YZaj5AG3SuW3h3VHzJ0hmgiSJByjVqgib/2
    k7h2dQFgqw6HTtyYXqffw2H60M6D1sg2FD96wAtx0nbH0P0tup/LLaM5Qh8/iWutcQaY
    4pX0kK4skeQaFFEIDEN08Ardx3+blTpaBlVQCoPTGPmOp49nZyl3E0WtjjXpd+3XzOKH
    cWOI8CDQCnNQTN58OCzbtXJlJyupzq71EtJXCsDSrmoHi3GH2wkwyGNc4NGoxSPM1go0
    g3LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771503501;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LCyaAbyVtKip3XCHObo7iedMbzRRklZBba0c3rwtqjI=;
    b=lvLw/wKUJhlBDrJaLdzUVK0hmnhu6BVuEa+pZjpNu2vKno7j0/46NUROAWGaph8DIs
    ritDlgFfU1z7tpqsjqCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861021JCIKTBS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Feb 2026 13:18:20 +0100 (CET)
Message-ID: <3601c855-ae24-4a61-ac67-891100411648@hartkopp.net>
Date: Thu, 19 Feb 2026 13:18:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: "Glasgall, Anna" <aglasgal@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn
 <willemb@google.com>, Paul Chaignon <paul.chaignon@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Tobias Klauser <tklauser@distanz.ch>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <789D0313-ED17-4DAA-B66F-754654B8EE16@akamai.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <789D0313-ED17-4DAA-B66F-754654B8EE16@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 16D8F15E8FD
X-Rspamd-Action: no action



On 19.02.26 12:50, Hudson, Nick wrote:
> [still learning git send-email]

Definitely :-D

No idea, why I am in the recipient list ;-)

Best regards,
Oliver

> 
> This was supposed to be sent with this:
> 
> 
> Our use case involves a BPF program that removes VXLAN headers from
> packets that are subsequently forwarded via a tap interface. The new
> flags allow the BPF program to strip the tunnel header and selectively
> clear the tunnel-specific GSO state. This allows larget packets to be
> forwarded without segmentation through the (non-robust) tap interface
> for the decapsulated packets.
> 
> 
> 
>> On 19 Feb 2026, at 10:47, Nick Hudson <nhudson@akamai.com> wrote:
>>
>> Enable BPF programs to properly handle GSO state when decapsulating
>> tunneled packets by adding selective GSO flag clearing and a trusted
>> mode for GSO handling.
>>
>> New decapsulation flags:
>>
>> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
>>   (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
>> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
>>   (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
>>   IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
>> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
>>   IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
>> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
>>   SKB_GSO_DODGY when the BPF program is trusted and modifications
>>   are known to be valid
>>
>> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
>> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
>> Run Everywhere) lookups in BPF programs.
>>
>> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
>> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this
>> for trusted programs that guarantee GSO correctness.
>>
>> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
>>   bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
>>                       BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
>>                       BPF_F_ADJ_ROOM_DECAP_L4_UDP);
>>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Josh Hunt <johunt@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
>> net/core/filter.c              | 73 ++++++++++++++++++++++++++++------
>> tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
>> 3 files changed, 145 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c8d400b7680a..0cb24ab70af7 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3010,8 +3010,42 @@ union bpf_attr {
>>   *
>>   * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>>   *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
>> - *  Indicate the new IP header version after decapsulating the outer
>> - *  IP header. Used when the inner and outer IP versions are different.
>> + *  Indicate the new IP header version after decapsulating the
>> + *  outer IP header. Used when the inner and outer IP versions
>> + *  are different. These flags only trigger a protocol change
>> + *  without clearing any tunnel-specific GSO flags.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
>> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
>> + *  when decapsulating a GRE tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
>> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
>> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
>> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
>> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
>> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
>> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
>> + *  or IPv4-in-IPv6).
>> + *
>> + * When using the decapsulation flags above, the skb->encapsulation
>> + * flag is automatically cleared if all tunnel-specific GSO flags
>> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
>> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
>> + * removed from the packet. This handles cases where all tunnel
>> + * layers have been decapsulated.
>> + *
>> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
>> + *  Do not mark the packet as dodgy (untrusted) and preserve
>> + *  the existing gso_segs count. By default, packet modifications
>> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
>> + *  revalidation. This flag is useful when decapsulating the
>> + *  tunnel, the BPF program is trusted, and the modifications
>> + *  are known to be valid.
>>   *
>>   * A call to this helper is susceptible to change the underlying
>>   * packet buffer. Therefore, at load time, all checks on pointers
>> @@ -6209,7 +6243,7 @@ enum {
>> };
>>
>> /* BPF_FUNC_skb_adjust_room flags. */
>> -enum {
>> +enum bpf_adj_room_flags {
>> BPF_F_ADJ_ROOM_FIXED_GSO = (1ULL << 0),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 = (1ULL << 1),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 = (1ULL << 2),
>> @@ -6219,6 +6253,11 @@ enum {
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH = (1ULL << 6),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 = (1ULL << 7),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 = (1ULL << 8),
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE = (1ULL << 9),
>> + BPF_F_ADJ_ROOM_DECAP_L4_UDP = (1ULL << 10),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 = (1ULL << 11),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 = (1ULL << 12),
>> + BPF_F_ADJ_ROOM_NO_DODGY = (1ULL << 13),
>> };
>>
>> enum {
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index ba019ded773d..681dd53ab841 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3484,14 +3484,28 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>> #define BPF_F_ADJ_ROOM_DECAP_L3_MASK (BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>>
>> -#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> - BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK (BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK (BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6)
>> +
>> +#define BPF_F_ADJ_ROOM_ENCAP_MASK (BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>> BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>> BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>> BPF_F_ADJ_ROOM_ENCAP_L2( \
>> -  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
>> - BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>> +
>> +#define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
>> + BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> + BPF_F_ADJ_ROOM_DECAP_MASK | \
>> + BPF_F_ADJ_ROOM_NO_CSUM_RESET | \
>> + BPF_F_ADJ_ROOM_NO_DODGY)
>>
>> static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>     u64 flags)
>> @@ -3503,6 +3517,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>> unsigned int gso_type = SKB_GSO_DODGY;
>> int ret;
>>
>> + if (unlikely(flags & (BPF_F_ADJ_ROOM_DECAP_MASK |
>> +      BPF_F_ADJ_ROOM_NO_DODGY)))
>> + return -EINVAL;
>> +
>> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>> /* udp gso_size delineates datagrams, only allow if fixed */
>> if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
>> @@ -3588,8 +3606,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>> if (skb_is_gso(skb)) {
>> struct skb_shared_info *shinfo = skb_shinfo(skb);
>>
>> - /* Header must be checked, and gso_segs recomputed. */
>> + /* Add tunnel GSO type flags as appropriate. */
>> shinfo->gso_type |= gso_type;
>> +
>> + /* Header must be checked, and gso_segs recomputed. */
>> shinfo->gso_segs = 0;
>>
>> /* Due to header growth, MSS needs to be downgraded.
>> @@ -3610,11 +3630,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>> static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>>       u64 flags)
>> {
>> + bool no_dodgy = flags & BPF_F_ADJ_ROOM_NO_DODGY;
>> int ret;
>>
>> if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>>        BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> +       BPF_F_ADJ_ROOM_DECAP_MASK |
>> +       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>> +       BPF_F_ADJ_ROOM_NO_DODGY)))
>> return -EINVAL;
>>
>> if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
>> @@ -3647,9 +3670,36 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>> if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>> skb_increase_gso_size(shinfo, len_diff);
>>
>> - /* Header must be checked, and gso_segs recomputed. */
>> - shinfo->gso_type |= SKB_GSO_DODGY;
>> - shinfo->gso_segs = 0;
>> + /* Selective GSO flag clearing based on decap type.
>> + * Only clear the flags for the tunnel layer being removed.
>> + */
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
>> + shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
>> +      SKB_GSO_UDP_TUNNEL_CSUM);
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> + shinfo->gso_type &= ~(SKB_GSO_GRE |
>> +      SKB_GSO_GRE_CSUM);
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
>> + shinfo->gso_type &= ~SKB_GSO_IPXIP4;
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
>> + shinfo->gso_type &= ~SKB_GSO_IPXIP6;
>> +
>> + /* Clear encapsulation flag only when no tunnel GSO flags remain */
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>> + if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
>> +  SKB_GSO_UDP_TUNNEL_CSUM |
>> +  SKB_GSO_GRE |
>> +  SKB_GSO_GRE_CSUM |
>> +  SKB_GSO_IPXIP4 |
>> +  SKB_GSO_IPXIP6)))
>> + skb->encapsulation = 0;
>> + }
>> +
>> + /* NO_DODGY: preserve gso_segs, don't mark as dodgy. */
>> + if (!no_dodgy) {
>> + shinfo->gso_type |= SKB_GSO_DODGY;
>> + shinfo->gso_segs = 0;
>> + }
>> }
>>
>> return 0;
>> @@ -3709,8 +3759,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>> u32 off;
>> int ret;
>>
>> - if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
>> -       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> + if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
>> return -EINVAL;
>> if (unlikely(len_diff_abs > 0xfffU))
>> return -EFAULT;
>> @@ -3729,7 +3778,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>> return -ENOTSUPP;
>> }
>>
>> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>> if (!shrink)
>> return -EINVAL;
>>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 5e38b4887de6..664bc8438186 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -3010,8 +3010,42 @@ union bpf_attr {
>>   *
>>   * * **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>>   *  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
>> - *  Indicate the new IP header version after decapsulating the outer
>> - *  IP header. Used when the inner and outer IP versions are different.
>> + *  Indicate the new IP header version after decapsulating the
>> + *  outer IP header. Used when the inner and outer IP versions
>> + *  are different. These flags only trigger a protocol change
>> + *  without clearing any tunnel-specific GSO flags.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
>> + *  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
>> + *  when decapsulating a GRE tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
>> + *  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
>> + *  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
>> + *  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
>> + *  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
>> + *
>> + * * **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
>> + *  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
>> + *  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
>> + *  or IPv4-in-IPv6).
>> + *
>> + * When using the decapsulation flags above, the skb->encapsulation
>> + * flag is automatically cleared if all tunnel-specific GSO flags
>> + * (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
>> + * SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
>> + * removed from the packet. This handles cases where all tunnel
>> + * layers have been decapsulated.
>> + *
>> + * * **BPF_F_ADJ_ROOM_NO_DODGY**:
>> + *  Do not mark the packet as dodgy (untrusted) and preserve
>> + *  the existing gso_segs count. By default, packet modifications
>> + *  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
>> + *  revalidation. This flag is useful when decapsulating the
>> + *  tunnel, the BPF program is trusted, and the modifications
>> + *  are known to be valid.
>>   *
>>   * A call to this helper is susceptible to change the underlying
>>   * packet buffer. Therefore, at load time, all checks on pointers
>> @@ -6209,7 +6243,7 @@ enum {
>> };
>>
>> /* BPF_FUNC_skb_adjust_room flags. */
>> -enum {
>> +enum bpf_adj_room_flags {
>> BPF_F_ADJ_ROOM_FIXED_GSO = (1ULL << 0),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 = (1ULL << 1),
>> BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 = (1ULL << 2),
>> @@ -6219,6 +6253,11 @@ enum {
>> BPF_F_ADJ_ROOM_ENCAP_L2_ETH = (1ULL << 6),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV4 = (1ULL << 7),
>> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 = (1ULL << 8),
>> + BPF_F_ADJ_ROOM_DECAP_L4_GRE = (1ULL << 9),
>> + BPF_F_ADJ_ROOM_DECAP_L4_UDP = (1ULL << 10),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP4 = (1ULL << 11),
>> + BPF_F_ADJ_ROOM_DECAP_IPXIP6 = (1ULL << 12),
>> + BPF_F_ADJ_ROOM_NO_DODGY = (1ULL << 13),
>> };
>>
>> enum {
>> -- 
>> 2.34.1
>>
> 


