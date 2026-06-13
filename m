Return-Path: <netdev+bounces-298907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GPiEEugALWp7YwQAu9opvQ
	(envelope-from <netdev+bounces-298907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBA67DE98
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:04:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cUwyDmd6;
	dkim=pass header.d=redhat.com header.s=google header.b=eDOOOwXT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298907-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298907-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 867E13028E9C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6233120A;
	Sat, 13 Jun 2026 07:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722113B58A
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 07:04:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334245; cv=none; b=sqTr/iFeugQPdakisYPHhsorKzSq0SuUS+R101dALVgD3dX6xsgGfrdKKPq2Ta763suY4c0Ve69q3JUXgtbHsiNX4o233gs1KkOTRnKyGp47tIkQ6vd/DDVgKLQMCdvfuUKfZ8Z3glqYwujQYwEPQBkbcOzye0tGdCIkTokDAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334245; c=relaxed/simple;
	bh=Xs9nia55xXUUlN2PV5chD7GQx+qWkVCeZz5Ph6ZPaZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljnJF+Dw3mivK3Wfa0hbgsxRwPOAdTCWnyL+tcbStF+FlAgizxS1wPYgMSOYxCiHMSRp51QDeuTZFGu5JPn64kNzeBp0lP9jo8xD6tNgXyIgzLHZp6LD1NlRJiMjWSPR7IZgw5VfQc37KU+hakHjow3CTE64WpfxkRsDpcVU3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUwyDmd6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDOOOwXT; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781334241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EreY/yKlC3Kp2dA9cbWzZG8YYEl55OvJbhqoHDYKfgk=;
	b=cUwyDmd6fCZ080KJ+mA2nxkE4sOuNTbyjiUusujEn7+B1hKxdG/E5FmDVhOa5EJ6WxP4KT
	wTNgX5OHvBB6CZTn0FgVKznHE7OXo8rOBJkYc0mkSlc6P61yrIX9hi2nasPq8mxbq9QPbJ
	/LO6LDW2haQeP+jY2L+Fi0awSx8okCM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-zokmH5VWN9e3OTxcZ9wDNA-1; Sat, 13 Jun 2026 03:04:00 -0400
X-MC-Unique: zokmH5VWN9e3OTxcZ9wDNA-1
X-Mimecast-MFC-AGG-ID: zokmH5VWN9e3OTxcZ9wDNA_1781334239
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-460198535bcso1079256f8f.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781334239; x=1781939039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EreY/yKlC3Kp2dA9cbWzZG8YYEl55OvJbhqoHDYKfgk=;
        b=eDOOOwXTORJbGTQT1GR3fEAwaE6eIYJIHYRxToE7eeeWz2Gf5ufNQPm+30gGtQMwlX
         hwDWbTkei3QoVD72svSBYZzrpiCe9ZvN9fcbxWR7HFukK1zMgw6RMdnunBm4JMzOarge
         wLY14oMrw96jPw1PXDgjh6qbOahczgC7U31dXv2tYiv6exY4Mf5lnWfZtscyxHu1ROI7
         589Onv6371WVUOjnFEIfteo0SGdxb7I36faZW5NoVxxNQLZuj6R/43EdyxYbyvcCAOTL
         iHVQl2oBMoHJLGHkfvhyTukNfVGTd5i3bXNioQSLme3KAsIYVaWoKBLEU1Qv2QuQjEkn
         cvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334239; x=1781939039;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EreY/yKlC3Kp2dA9cbWzZG8YYEl55OvJbhqoHDYKfgk=;
        b=X9tW9AjJthYm1sodS5uY3PrIkHFHY6AicMXifFGxSFISX9/9jL7fu/qYyiT6im7B2r
         yROrmXJn591S6s3l9RoPe18F2fq2mkauY2aBrQa/Ij0MIgNk2RlpcaUsAgwHpvQ0tk++
         0PWZoBFJaabvmcK+EjuFO+yuv9FkszhQsHl0SMWY2ua7ZptoDto5FYLFMaKT7uAaVteq
         QxFLUBC3dJ7UmD1M37JFjMZTLAI70Afn+lOrjJwAhYvu7mEcGkKLEoMb8nK5PPKRbcS8
         zSw0Gn2K+mjBuxADx1JvwIVC8GECQRssT5HGihG4UB5SuQ31DsEz7MQK3LcKEEpHKZQO
         DxmQ==
X-Gm-Message-State: AOJu0Yxda+oAGKcmBbprjBP9nM8PJ/oSjGXvaIls+0/N7kJsSQIEECA2
	umHXjxkOrKNG8hHGPDfioedU84hInAW0X3uoxH9peCnbB3mS5VwqzlirhATgis65D8zHk7K23lw
	HbUtYeTl/m05nVd7+cZng4TNZmDmfRyNMTANAdJWfM1o3VMru4Fsxi5+iJQ==
X-Gm-Gg: Acq92OG8JpQXlTFWuVABKULX2X40B9qdWOKWO8zCyKMdY+8EfJjFqyhCi+THD6PYWEC
	mDSKmg0dUmMq+9DD+ZCxatAmT0CLqkwFs5vSld+1VldBsJQkQ+haUeDfochrfj/tmBF2S1X1uM8
	2bCatZZxDQeGJLbG8xxEY6TsPJyydSeLg+OGR2xiV7Es8n8NA+nLrWZl1ipKjA6DGcWfa0Zcsu0
	kOfWHdM7mdu0Bn97sSmsQQZlYiFnz49bRzk8CHr8Mh44yFRAwmxCtvx6JmGhTrhCxdl6Tb0XYH5
	0nH/n2CIcfgNYqACfoaPsl7HcCCJE4EzWUpp3bpDA91AcoLrNEQkleJ2V2pA+DWtOa334SZdRoC
	5FmA5XVEnLGTvRTclOF4h5VwR9OGiBpu2uxuX93rKHaJeLLiyrxMZLvs=
X-Received: by 2002:a5d:5d85:0:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4606dbf15a9mr8221373f8f.35.1781334238795;
        Sat, 13 Jun 2026 00:03:58 -0700 (PDT)
X-Received: by 2002:a5d:5d85:0:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4606dbf15a9mr8221327f8f.35.1781334238353;
        Sat, 13 Jun 2026 00:03:58 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm13540936f8f.10.2026.06.13.00.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:03:57 -0700 (PDT)
Message-ID: <7b42a031-5574-4398-8e9e-36248e22df2d@redhat.com>
Date: Sat, 13 Jun 2026 09:03:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip_tunnel: drop stale dst from generated PMTU ICMP
 replies
To: laikabcprice@gmail.com, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613-master-v1-1-df796e8e2d74@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260613-master-v1-1-df796e8e2d74@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:laikabcprice@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3EBA67DE98

On 6/13/26 3:00 AM, Laika Price via B4 Relay wrote:
> From: Laika Price <laikabcprice@gmail.com>
> 
> iptunnel_pmtud_build_icmp(...) and iptunnel_pmtud_build_icmpv6(...) take
> in an sk_buff, modify it to create a PMTU ICMP error reply, and return it.
> As part of these modifications, the source/destination ethernet and IP
> addresses are swapped around which makes the sk_buff's current dst invalid.
> 
> If the stale dst is left, the packet can skip input routing and be
> forwarded using the original output device. This was observed when sending
> packets to a VXLAN over a WireGuard tunnel - the ICMP reply was generated
> but it was sent over the VXLAN instead of to the WireGuard tunnel.
> 
> Drop the stale dst after building the PMTU reply so that the packet is
> routed using its new headers when it is reinjected.
> 
> Signed-off-by: Laika Price <laikabcprice@gmail.com>
> ---
>  net/ipv4/ip_tunnel_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index d3c677e9b..949150e43 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -267,6 +267,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
>  
>  	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
>  	skb_reset_mac_header(skb);
> +	skb_dst_drop(skb);
>  
>  	return skb->len;
>  }
> @@ -370,6 +371,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
>  
>  	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
>  	skb_reset_mac_header(skb);
> +	skb_dst_drop(skb);
>  
>  	return skb->len;
>  }
> 
This apparently causes self-tests pmtu failure for the virtio_net device:

# 135.54 [+6.50] TEST: IPv4, bridged vxlan4: PMTU exceptions
            [FAIL]
# 142.17 [+6.63] TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop
objects       [FAIL]
# 148.71 [+6.53] TEST: IPv6, bridged vxlan4: PMTU exceptions
            [FAIL]
# 155.44 [+6.74] TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop
objects       [FAIL]
# 161.94 [+6.49] TEST: IPv4, bridged vxlan6: PMTU exceptions
            [FAIL]
# 168.69 [+6.76] TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop
objects       [FAIL]
# 175.01 [+6.32] TEST: IPv6, bridged vxlan6: PMTU exceptions
            [FAIL]
# 181.83 [+6.82] TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop
objects       [FAIL]
# 188.42 [+6.59] TEST: IPv4, bridged geneve4: PMTU exceptions
            [FAIL]
# 195.31 [+6.89] TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop
objects      [FAIL]
# 201.99 [+6.68] TEST: IPv6, bridged geneve4: PMTU exceptions
            [FAIL]
# 209.10 [+7.11] TEST: IPv6, bridged geneve4: PMTU exceptions - nexthop
objects      [FAIL]
# 216.12 [+7.02] TEST: IPv4, bridged geneve6: PMTU exceptions
            [FAIL]
# 223.36 [+7.23] TEST: IPv4, bridged geneve6: PMTU exceptions - nexthop
objects      [FAIL]
# 230.26 [+6.90] TEST: IPv6, bridged geneve6: PMTU exceptions
            [FAIL]
# 237.52 [+7.26] TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop
objects      [FAIL]
# 264.58 [+27.06] TEST: IPv4, OVS vxlan4: PMTU exceptions
             [FAIL]
# 293.85 [+29.27] TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop
objects           [FAIL]
# 322.61 [+28.76] TEST: IPv6, OVS vxlan4: PMTU exceptions
             [FAIL]
# 350.36 [+27.75] TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop
objects           [FAIL]
# 376.99 [+26.62] TEST: IPv4, OVS vxlan6: PMTU exceptions
             [FAIL]
# 404.00 [+27.02] TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop
objects           [FAIL]
# 429.71 [+25.71] TEST: IPv6, OVS vxlan6: PMTU exceptions
             [FAIL]
# 455.60 [+25.88] TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop
objects           [FAIL]
# 481.32 [+25.72] TEST: IPv4, OVS geneve4: PMTU exceptions
             [FAIL]
# 507.38 [+26.06] TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop
objects          [FAIL]
# 533.62 [+26.24] TEST: IPv6, OVS geneve4: PMTU exceptions
             [FAIL]
# 560.92 [+27.30] TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop
objects          [FAIL]
# 588.20 [+27.29] TEST: IPv4, OVS geneve6: PMTU exceptions
             [FAIL]
# 615.22 [+27.02] TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop
objects          [FAIL]
# 641.40 [+26.18] TEST: IPv6, OVS geneve6: PMTU exceptions
             [FAIL]
# 666.47 [+25.07] TEST: IPv6, OVS geneve6: PMTU exceptions - nexthop
objects          [FAIL]

See:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
on how to reproduce that results.

/P


