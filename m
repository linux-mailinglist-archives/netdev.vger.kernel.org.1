Return-Path: <netdev+bounces-299197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4PUOH2OOLmoWzQQAu9opvQ
	(envelope-from <netdev+bounces-299197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:20:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A5D680E68
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:20:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="iCD/ml38";
	dkim=pass header.d=redhat.com header.s=google header.b=FgfjfK3N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299197-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 541D630015BD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B7313E24;
	Sun, 14 Jun 2026 11:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48B75801
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 11:19:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781435996; cv=none; b=FyOJY3sFs5XmnkGriwwDcDF0dsoVpr8dol02jIt3XAPq3X3Xk2h+2kCYXKlrMNDxgsrnMILnUT3Rvf+dQHnBQVDkN4trBa0UKnj9bN20ztoUwkmpP4WlqKMb2F+d5ynqbEUSN9sVE/wBuibm5GJNltMGJE2VaaMVUaJrL0uVR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781435996; c=relaxed/simple;
	bh=2Gkj1TAMvgisXRCCGbSvr8DL0Lqah979yGwO67wQolU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOpiZzlPJXTiXFj+b1TrxA3lCEdv/ZlboTdBPBsv5M0dMO7P4ihPx4YfaAuQ78imEbTCt7zSghkuLx2oyLP+g7RyEa7O8EO09gtBKQHZHY+NZ0AvJn0Om+ivOOvpkxt4la7pKRgPW1Vr4ekloi11cpXkz1/ymhAJVKolkxaig20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCD/ml38; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgfjfK3N; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781435994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkd4mvxbS0UZ6zZjSfTSJXTskUPh6tCEruxpS1UjCaw=;
	b=iCD/ml38Rh01RA4aKV2KuvcxyvA1VDdGN+TzF3QJ14Kmc3DUd+jFvvnC2f8jbAX0w35o1Z
	uJBzqaEb5S3PZMyxhAF1LSwsybja8UlmJdlsh0XExadR3X130I1p/rN06ozA69k6B61dkQ
	tsXMgAQZZoekl7f40E4Ka5VTcAFl054=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qlK70gRsNOOCmDKPnt6kqA-1; Sun, 14 Jun 2026 07:19:51 -0400
X-MC-Unique: qlK70gRsNOOCmDKPnt6kqA-1
X-Mimecast-MFC-AGG-ID: qlK70gRsNOOCmDKPnt6kqA_1781435991
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490c4f61a34so16217875e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781435990; x=1782040790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkd4mvxbS0UZ6zZjSfTSJXTskUPh6tCEruxpS1UjCaw=;
        b=FgfjfK3NVNilBJ+2qTlto+75+Y4b+SjrLeFpq9adynjLGpszafS5UWCR9RsV+CK41m
         E7CBOpIVL8LcLc3SoyNWFljhRLnn6VQrQnPyd8XKO5DtWBipiaQJP9IyeTwGSxWkqAcS
         gwUTJJa+78mSaGeZ0SLJdabRL84hinb+QfwozgFcnPqPWx/NEO2vxHCfXelsgUTDjNsd
         mF4ep7+MEEuuF4w5Ti6XqsXX35cMUkIVD1siPR5tPH7qEn6/jk+vAz1qP/MoCL4t+8nA
         e774cOgS/YhyRoeAw48GnuuyyYfDX/bl2tLwFjDPFS9vl1TUkprZQxpbXPRuru1UM/lh
         nBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781435990; x=1782040790;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkd4mvxbS0UZ6zZjSfTSJXTskUPh6tCEruxpS1UjCaw=;
        b=cb6IrsuvkUIXL7dDd2zWVxZsNG/RUCQKA0T9xAhVrJ2vmrhddfSCK7M3obIfy+Rymc
         6AQX2is/vNfAY1gGlXohhRqwdkGaDp0uAUHNIWbrCQHeJYNfB7xrA6N46AUlguJ+Nwh6
         spp2YTbNnn9q3PMQ8pYnqvZrohKJFfuI2rDB1lro2BXT1lwJh8mKbcESGa5KzILNU50N
         nSov1cugdRmot4NPZKhPvD/iq7vwgOSIWqDvRcUqUypJluqiYayrvxXFrB12B6tkkrHi
         TGx7yyiAOhDhz61y7EJ6bhXX7heBRq33dRl7FpA1Y5hokC6gnde8Ezkfl5zrtx6mbc6e
         MgcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XzxiXTwnIIHzoUKrz/Wc2iTkwI8291t1Tsr7TWY9es0obz1wY6GK1ECKoqGnFcElqyhc/RoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwikKGIZimGkbEPqrzp5AqFXuZSGxsYo2LBbh95zRoILgfP1aPe
	BFIdbtSyZDdD1pq+h6XSSFqgz0e9cXoYOlqmu9SKUMAz03NJX1BHzLXE4xPFWH+Tork6GQG7rw6
	Ix1jDY+pEbYelNaVar2yp36z+bo947cMMWGUyLK/9rsUUqibHz8C/uwOSDg==
X-Gm-Gg: Acq92OG8/+ulfA8vwWQod3MuemWIPfVLJaGyUD7hSBrb2Dw+RY7gLJAo0eV3aYRcrFm
	EmuQCU0CVtxlY4PbUgySFFK7Dj0njiqrzTSA1llg3RIRFeMlP+k790ZiRiR+g5//20niRfbOA6u
	x6g4idAjTDIF8+umiAgRaHTVJV4S54vLYn50yk5DUUgiOezk6LdYtRYVof/Vvjvj6SUp8Heyo2h
	T24stjn5LeHry98lttm3lKrfsPi6zKR56gAm0zzknTsftKniEA44JSKwQICAh3gpW7HI11WPFQ5
	AnnGV96yHLZM5tGryQZKzGyHEC7SKOIuPlFRZ2cbfT4v9zgRPd1sLwXmo2/rx7NdYCwtbnU1tZP
	kHpwMnCpA5Z+qhYC6JmGQvsd1hiW31sfqyJlXTJjtUjyvmIaz1ZzZGAQ=
X-Received: by 2002:a05:600c:e556:20b0:490:b9c3:6c58 with SMTP id 5b1f17b1804b1-490ec4fe879mr89099785e9.16.1781435990629;
        Sun, 14 Jun 2026 04:19:50 -0700 (PDT)
X-Received: by 2002:a05:600c:e556:20b0:490:b9c3:6c58 with SMTP id 5b1f17b1804b1-490ec4fe879mr89099565e9.16.1781435990241;
        Sun, 14 Jun 2026 04:19:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202edf89sm165147515e9.1.2026.06.14.04.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 04:19:49 -0700 (PDT)
Message-ID: <554ff2bd-e4d7-4e64-8ec4-86dc7da85992@redhat.com>
Date: Sun, 14 Jun 2026 13:19:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/11] net: Enable BIG TCP with partial GSO
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-5-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611192955.604661-5-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65A5D680E68

On 6/11/26 9:29 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> skb_segment is called for partial GSO, when netif_needs_gso returns true
> in validate_xmit_skb. Partial GSO is needed, for example, when
> segmentation of tunneled traffic is offloaded to a NIC that only
> supports inner checksum offload.
> 
> Currently, skb_segment clamps the segment length to 65534 bytes, because
> gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
> to accidentally assign mss = 65535, as it would fall into the
> GSO_BY_FRAGS check further in the function.
> 
> This implementation, however, artificially blocks len > 65534, which is
> possible since the introduction of BIG TCP. To allow bigger lengths and
> avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
> the beginning and don't use a special value of mss for this purpose
> after mss was modified.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/netdevsim/psp.c |  2 +-
>  net/core/skbuff.c           | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> index d3e36c74be62..6b3532b5e360 100644
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -92,7 +92,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>  		 * provide a valid checksum here, so the skb isn't dropped.
>  		 */
>  		uh = udp_hdr(skb);
> -		udplen = ntohs(uh->len) ?: skb->len - skb_transport_offset(skb);
> +		udplen = udp_get_len(skb, uh, skb_transport_offset(skb));
>  		csum = skb_checksum(skb, skb_transport_offset(skb),
>  				    udplen, 0);
>  
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c64693fcb2d1..5dcee79df8cf 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4773,6 +4773,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	struct sk_buff *tail = NULL;
>  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
>  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
> +	bool gso_by_frags = mss == GSO_BY_FRAGS;
>  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
>  	unsigned int offset = doffset;
>  	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
> @@ -4788,7 +4789,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	int nfrags, pos;
>  
>  	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
> -	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
> +	    !gso_by_frags && mss != skb_headlen(head_skb)) {
>  		struct sk_buff *check_skb;
>  
>  		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
> @@ -4816,7 +4817,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	sg = !!(features & NETIF_F_SG);
>  	csum = !!can_checksum_protocol(features, proto);
>  
> -	if (sg && csum && (mss != GSO_BY_FRAGS))  {
> +	if (sg && csum && !gso_by_frags)  {
>  		if (!(features & NETIF_F_GSO_PARTIAL)) {
>  			struct sk_buff *iter;
>  			unsigned int frag_len;
> @@ -4850,9 +4851,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		/* GSO partial only requires that we trim off any excess that
>  		 * doesn't fit into an MSS sized block, so take care of that
>  		 * now.
> -		 * Cap len to not accidentally hit GSO_BY_FRAGS.
>  		 */
> -		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
> +		partial_segs = len / mss;

Sashiko/gemini says the above can lead to hit BUG_ON() later.

I *think* it's not a false positive, as it looks like skb_segment()
assumes an skb can hold `mss` bytes without resorting to frag_list
usage, and mss > MAX_SKB_FRAGS * PAGE_SIZE  breaks such assumption.

I think handling correctly this case will requires some non trivial
surgery to skb_segment: both `while (pos < offset + len) {` loops must
be updated to feed data from `frags` as needed instead of
BUG_ON()/net_warn_ratelimited(skb_shinfo(nskb)->nr_frags >= MAX_SKB_FRAGS);

/P


