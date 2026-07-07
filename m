Return-Path: <netdev+bounces-305513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDhxCyocTWr8vAEAu9opvQ
	(envelope-from <netdev+bounces-305513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B748F71D500
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="iGpe+Gu/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305513-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305513-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E975303638E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7ED3E9C0C;
	Tue,  7 Jul 2026 15:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8B34B697
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:17:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437421; cv=none; b=hFGdVSiNvoR/Lh1qWKj/LEbDuAXeyVL0VYdB4UHnloHp/Y2GkYZiQSdC/VfQGmie78kP4qjWMh4ciPp07rL+e25s8vj5FFRHSs3WWlOqz1iqTLoiSXgn1EKSkKxXJ0zgDZCkQ2bVlitg5YBpUa1tPhzkWNQUn5YgNqCmX2Ok9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437421; c=relaxed/simple;
	bh=6n8aPA1vZTHKTUYfm4zIRDmO2S0R8XGdy/C7T/5N6B8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eblDyWTljI4PWSEf9LTOlIXp1tTQSRrVuPKc/S2Lr18zapZ4zdcKvZXDA33D41ueREpwIRr+bN4sZVoqKdWC5Q5lHbG2rk1HHdx6wDyQmEcXxXVyzrkWQShYLZ6HV3xsIvAOSLOIK7ke+p8qdrhCCHnEml+LvHPAa1d1FQYsx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGpe+Gu/; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664db84f074so4918583d50.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437419; x=1784042219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+LREjqj7QKR0h0vN+5yo9g4950/7tRNrphjJDSrz5U=;
        b=iGpe+Gu/YT46RFsRLmyqO4SBPuyruiSVpO2SMnBWzewOPAqo7M1FDFh8yaMK7l9/Y/
         DsfkAOGU5NA5Khc/I3lYs6aoR1Ctkwbm0yEXRY82tLqQJtuJK7ExSATbKBfBMqwTOPk7
         LxZfBGUOvw+HL3RjFX6A3QsB7LmvI3xpB+H6QKJAl61KwWv4DEstRaRrC1a0i50fiZJg
         ifUALnhmB99GXGW0K3AGuuhy9waFdXFosfOGif/GkwIvzc4dtKhpUWOQYkTDnXJfPeWq
         AqaaEMba53OVHE8kvJV9/U0ibI1ownVwNWzPXuOAs5lc2IfeRQ0rIuRQExoIfbLP/a1I
         qXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437419; x=1784042219;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+LREjqj7QKR0h0vN+5yo9g4950/7tRNrphjJDSrz5U=;
        b=pEy8gI0DwcNx1zUcM3uZq+RU2rxh9zr+k76mBzVwb4guZTv7f7kDqDWvdw4RR7sdYP
         wf/CJ5FsQIdBSR2seK5zhYySoprkyniHdRxyDDCETyiuDIURACWXdJcVYIGvzQUjI/zQ
         okxbNMHgJJ3b0omAfj9sEhfYCfyzvTYczEp74vwMHhwvcU5r/WCQx1irt9DVh1iHXV0H
         xFuH1T2YjWpDsCys0XFCIglG1MqSwAYoUmarhWaTHavrzIY26bRNPBCtUEXWIVY0LO8K
         CzoZUMaLz2RC6ybKVotpXB64ZXacW03GbMaT7jGxCb/XhPbAqKR6eFi5K0CdUkDEremW
         U+IA==
X-Forwarded-Encrypted: i=1; AHgh+RpgXEHU4Y9Fkxz/tjaYK0cc42KMOTUKX9FIx3KNYi3n/ikRZ3PLqTDVlXEk6VZ9/hWl7YdZPSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEs3HX1dLFYJXPTTZKbLVfrOyBGrq+yLccqXGSCKVjbqqVTGyT
	sEE4Y4RTg6r0PN+lxHcD+qYBo+FSByiIexVP/hv3WCkiRxN8hlE9Acg/
X-Gm-Gg: AfdE7ckAzcnHOccJFwrT1DaGP04EZvXVohAV1TXIeQHTNeOhP965YO+S9TsrcXT8209
	NrBLMgBCXgnYcT7PzqN7gPkvoXP/VEx6zLGAV4M1kz/9OzNlfqY6g3j+ypcmaA2EflmU9gguH5A
	IIM9a+Ae6AbbxR316p1CN99L6t9prYwXziztdv3B1K0IwhdVFqD+wCGTzJHfX/Oug+B/UhwVwfv
	4Dcvfg5p5bJqCaOEMd+Uqa2gcR8tHzJKnChkLXTmrpGtsmUr2XzEBKtGt8qQNtfFr+nIhHlWxhd
	ugYI4Y+P6mQbMqot4pa0flWvOApS6KuDhxKiLC6lXpT4e7mcfGBzbKh6SG5ot4o9XFawtO+Yz50
	PtuxRD6R0wgppZAX0eCjDcUVC7GxIC0q6ieYzfTuX+m6VJ5y5AQRhOv1ezTvK+p9NnKtoV1O3bp
	3++c3Um7WFbU2GUVuqsH6vQ+NpalMYWbb+kgHi2nUC8m2nZN8BDRtBF2+Qa6FkMZ2yfw==
X-Received: by 2002:a05:690e:1189:b0:667:8dc9:2321 with SMTP id 956f58d0204a3-6678dc92498mr1718562d50.29.1783437419315;
        Tue, 07 Jul 2026 08:16:59 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm70583417b3.32.2026.07.07.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:16:58 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:16:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
In-Reply-To: <20260707021425.483-1-shiming.cheng@mediatek.com>
References: <20260707021425.483-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,isovalent.com,queasysnail.net,nbd.name,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:daniel.zahka@gmail.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:eilaimemedsnaimel@gmail.com,m:imv4bel@gmail.com,m:nbd@nbd.name,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:steffen.klassert@secunet.com,m:lena.wang@mediatek.com,m:matthiasbgg@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B748F71D500

Shiming Cheng wrote:
> The skb_gro_receive_list() function is missing a critical safety check
> that exists in the skb_gro_receive() implementation. Specifically, it
> does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> aggregation, as of commit 0ab03f353d36 ("net-gro: Fix GRO flush
> when receiving a GSO packet.").

It does not check .. as of commit .. ?

No, skb_gro_receive checkos NAP_GRO_CB(skb)->flush as of that commit.
 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/gro.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..b413f4a6462b 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	/* make sure to check flush flag and to not merge */
> +	if (unlikely(p->len + skb->len >= 65536 ||
> +		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> -- 
> 2.45.2
> 



