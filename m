Return-Path: <netdev+bounces-303480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jESdBaKvRGoGzAoAu9opvQ
	(envelope-from <netdev+bounces-303480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:11:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA3D6EA1E1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FHYf5yei;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303480-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC0F3040450
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264B39EF2E;
	Wed,  1 Jul 2026 06:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C039C00B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:11:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886279; cv=pass; b=p2TGQ7FBFYTBFrIXZvQMTf+ByWzdbJ66kDxwQm/mG3bLH+qG7rQPLHO7ifTyVfcN5dAhN8D2RkmGMlXKzycWjA/WnSrhA3qXAIgTAghy7UpdBCYyqliFR/CjagtkncyiOce9G5LkGvhQlZRlKTCqvZIcMwzWHITO/73l2yAvcu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886279; c=relaxed/simple;
	bh=ZxkEpGcaUnz5Szq84cetN2qcBNkJY5vj6Uao31D6ZxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8UhMm51qXHpMcXAj6Fi9iPDtMDRRYpD1sH1vm9l+QpkAe6syO5vGyrMWtFLZAAsfxYJQQGVq62HDFCumeR98LFgihAqJnhS3fSRAS+mR1OPxC/D/XWU04WPcGvPdCvjqhkQBXmm+KUhI1FHNsNf9l3Xjfnwkr0jsdWRtzZ9sb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHYf5yei; arc=pass smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c125c082ee2so30177666b.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782886277; cv=none;
        d=google.com; s=arc-20260327;
        b=fUsLDprIdJa/m0OhiVFrcfkPFSME6PApVQV3uSUaxc6j5qac2BXaF8HE0vwooxSYVl
         NPj0gFi9dr2j4biDF7zkQCpcaEmREDL9Bp2cujq2sKSSob9IE1s8V2X2hQBwlUUnbZwV
         1pXOjHMzCJ59K7Je6nfgYofOBlKxMK9U1GiWV5cUOsdUtuKznqXCN950sZMRAV+RgeIB
         NfYmEJbx6i+4ztJkEtuyhRj/TOFfS1o6T0wJBcsZ0cqm3quvpFPg9k6JWk9HZjljrH0E
         rdMWf0gYMB33GAtMOmjRpLFEd957GQRRmckHWgOPkli03ost92y+uSN1VOikWTZkegfV
         FneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        fh=fliYjrlKfSgcZa6/D778YFCpMDJy4XXdai1lapvhJBY=;
        b=dO+B7xklIfHigvLqTps2OalIxpl65LL+zgHDEdZVCxbK4Ol9LAdMUNajProhcc3RSk
         YyU/mhuqCbqVZ0DsDnf18iLzSa8lHeOga2JiMDJ3YS+hmsq4lCAIOOJv8kNsnqd6ipeo
         uyLtt1pAd+iptPy200gQ+oAGlcOgPDY+QH6WIpvcXS241SkT2+R63uVm0izA6bYuSQyW
         68MrOo3sav18NBq2P/HNXBj5iU6dkvv3UYXbQr+CC5/QyQVfR1xNTlVbCfxZxoz/otE3
         +XH0g11WBzOfyYVthJuUOMBNdBNwggDxUiFw2eQxkEVH4v0fcWAxoDLAgBuzaymXGrWd
         Qmlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782886277; x=1783491077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        b=FHYf5yeinqSQ77fSHMUS0tyfkDoeyRwpL9mpP8b/zxD+iYWrLGu3UURm+sIYNya7yO
         CZajTWjLTrf5adYR60SIR/5nzbpB4kKYz1WSjIidpCEaWEicR1IUBCw0mMNFT8GiOAOt
         wGtGgFmsyA53ziFcMMmRUg4gtXy3cKcCYPl1uLzXT5wE1g3h7N9aZUOPJUPvTSrM0u2b
         swMD77/UiUo5DX3B1RaCV4rs+QoTx6bM3GYLhphuJGIIWyGY/V4FUx8dICj1EdJ0n/z/
         9qksd34pWkShL8zh+HElXE6uk/8CpOj2XSGJghK/tEyNBUbdGCzGVfYeznNgTrAv2ctk
         iqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886277; x=1783491077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        b=Qnx1WVSfkUnlFu1D645i3WiwWwgIvZ/Kfc4GegFacWqUKRFixQkwEvRLmgSTCr2L8M
         adHSq76ZKUldb3MZWmDWYMDa09fBgNwOHUcg7W4uCLBGYpCKd6D5ZIKUdNo4qHkeVImb
         2yy4oPYoOx9EOb9ejxdnjLfT4XqhLhEs7+EtUv15VubBZxF8jmMTwrQCcKU/mnHWORVS
         H2CneGaDTQ2SyA+48eMjxCSZ0R/8EjqX7vB6wMZEGaiuxMORO8Myt+aZwjut7fT0a/x5
         /jNiVWMBGWKXG1oOQo6XQkUXjCi0C4QtScJAOyhhckl2BJxw4TyBrUHWdjm9PXILfnHk
         kgSw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5vfQ3sjzmUSA5mEQUy0JPOJ5NXxTIxVgWVfKNk12YrRUDWIhhpOx6cV2sYH1N54GVr+sJa/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZJujMLiog2GtOAnFaOVSDqb6z7oqMvH9cv36OB7atgnYfZKA
	kBvIuEH90Eak9mY4NDzx0PTDiOuqY+cuT+lAbCctXDjJpXTttgpN7/6ZBhhhvJDaVRiCLQNAZZG
	cgodi3UpQ6oiW15zmQ3EvPF3kLv2vhBM=
X-Gm-Gg: AfdE7cmppx4jOv67dOqAjXKFK1/YPd4/2LL05gPRGLZIiEZzEQ1Ti1A+k1BEmzRD6GB
	/5bpuxYYqvmxh1WGMDhnJGD8/sjynWJpBfBAIz1nP4C1MxtCi5bb6SZyx/9YVLxCa9iyfR7m76i
	/8O9GpGhY4V6R8TQxGNmZAFo9NbVm6cPZR9CG5g7hpJ4P/vKr2BpzZJUC7T20ItvkhNS0d9GxEI
	3GFUjeMb4Nqu61dQ6CPmqsr++WIUDU54aV2819BpTQ/2JexAVUvP0KWHF2OfgFW1xrqxRJWowig
	7Yr22Pk=
X-Received: by 2002:a17:907:3e18:b0:c12:a330:b92b with SMTP id
 a640c23a62f3a-c12aa14aac6mr6173366b.40.1782886276371; Tue, 30 Jun 2026
 23:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630065735.3341614-1-pawlik.dan@gmail.com> <akOCJI-2kAAwOQzz@chamomile>
In-Reply-To: <akOCJI-2kAAwOQzz@chamomile>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Wed, 1 Jul 2026 08:11:05 +0200
X-Gm-Features: AVVi8CfA9uhypD8RuUIaiCQhrLk2tdtBO915kC01GwUewd1n6TYEXO1SRl3IXQQ
Message-ID: <CALC2ApjGZFFPXr4d-r+4VNCpQO1N3Z4NOiBXwYU307jm-626OA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] netfilter: nf_flow_table_path: L2 bridge offload
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, coreteam@netfilter.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303480-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:email,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA3D6EA1E1

Hi Florian, Pablo,

I'll leave it up to you - if `br_netfilter` isn't the right approach
in this case, then we can drop that series.

Before your reply, I wasn't familiar with Eric Woudstra's
"bridge-fastpath" series - thanks for the tip.
I'll take a look at it and try to build on those patches.

Thanks, and best regards,
Dan


wt., 30 cze 2026 o 10:45 Pablo Neira Ayuso <pablo@netfilter.org> napisa=C5=
=82(a):
>
> Hi,
>
> On Tue, Jun 30, 2026 at 08:57:30AM +0200, Daniel Pawlik wrote:
> > This series adds L2 bridge offload support to nft_flow_offload, allowin=
g
> > bridged IPv4/IPv6 flows to be accelerated by the flowtable fast path
> > without requiring L3 routing.
> >
> > Background
> > ----------
> > Hardware flow offload engines (e.g. MediaTek PPE) can accelerate bridge=
d
> > traffic but require that nft_flow_offload detect and handle bridged flo=
ws
> > differently from routed ones: no routing table lookup, MAC addresses fr=
om
> > the Ethernet header, and VLAN context pre-populated from the bridge por=
t.
> >
> > v2: Fix missing Returns: tags in kernel-doc comments for the three new
> >     bridge helpers (br_fdb_has_forwarding_entry_rcu,
> >     br_vlan_get_offload_info_rcu, br_vlan_is_enabled_rcu).
> >
> > Patches
> > -------
> > 1/5  net: export __dev_fill_forward_path
> >      Refactors dev_fill_forward_path() to expose __dev_fill_forward_pat=
h()
> >      which accepts a caller-supplied net_device_path_ctx, needed to
> >      pre-populate VLAN state before the forward path walk.
> >
> > 2/5  net: bridge: add flow offload helpers
> >      Adds br_fdb_has_forwarding_entry_rcu(), br_vlan_get_offload_info_r=
cu()
> >      and br_vlan_is_enabled_rcu() to expose bridge state to nft_flow_of=
fload
> >      without requiring inclusion of net/bridge/br_private.h.
> >
> > 3/5  netfilter: nf_flow_table_path: add L2 bridge offload
> >      Core of the series. Adds nft_flow_offload_is_bridging() detection,
> >      nft_flow_route_bridging() which avoids nf_route() (fails for
> >      bridged-only subnets), MAC/VLAN pre-population for bridged flows,
> >      and a dst leak fix. nft_flow_route() becomes a thin dispatcher.
> >
> > 4/5  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path in=
fo
> >      Fixes zero-source-MAC in PPE entries when a bridged flow traverses
> >      MT7996/MT7915 WiFi WDMA hardware.
> >
> > 5/5  netfilter: nf_flow_table_path: add VLAN passthrough support
> >      Records VLAN encap info for passthrough-mode bridge ports so hardw=
are
> >      offload entries include the correct VLAN tag.
> >
> > Rebase note
> > -----------
> > Originally developed against OpenWrt pending-6.18 patches by Ryan Chen
> > <rchen14b@gmail.com> and Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
> > Rebased to current upstream: path discovery infrastructure moved to
> > nf_flow_table_path.c in commit 93d7a7ed0734 ("netfilter: flowtable: mov=
e
> > path discovery infrastructure to its own file"), so all netfilter chang=
es
> > now land in that file rather than nft_flow_offload.c.
> >
> > How to enable bridge offload
> > -----------------------------
> > 1. Load kmod-br-netfilter so that bridged IP traffic traverses the
> >    netfilter forward chain.
> >
> > 2. Enable netfilter hooks on the bridge:
> >      echo 1 > /sys/class/net/<br>/bridge/nf_call_iptables
> >      echo 1 > /sys/class/net/<br>/bridge/nf_call_ip6tables
>
> This requires br_netfilter which is a no go.
>
> Sorry, but we should really target at the native nf_conntrack_bridge
> support.
>
> > 3. Register bridge member interfaces in the nft flowtable:
> >      table inet filter {
> >          flowtable f {
> >              hook ingress priority filter
> >              devices =3D { eth0, wlan0 }
> >          }
> >          chain forward {
> >              type filter hook forward priority filter
> >              meta l4proto { tcp, udp } flow add @f
> >          }
> >      }
>
> Yes, but br_netfilter makes no sense for nftables.
>
> br_netfilter was made to fill gap at the time ebtables was lagging a
> lot behind iptables in terms of features. And getting ebtables on pair
> with iptables in functionality was not feasible either, because it
> required many new extensions that were specific of the bridge family,
> which probably was not a big deal, but it also required to get
> the ebtables command line tool on pair with iptables userspace, which
> has received more development attention/effort that the bridge tool.
>
> All of this does not stand true anymore with nftables, where the
> bridge family capabilities are at pair with the inet families.
>
> I am looking now at the native flowtable bridge support, I will get
> back to you with updates.

