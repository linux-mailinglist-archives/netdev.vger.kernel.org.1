Return-Path: <netdev+bounces-297343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7b8GBuGZKGrGGgMAu9opvQ
	(envelope-from <netdev+bounces-297343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DDE664AC1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:55:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RncOw3NB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297343-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803B83014C28
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BC3EB0E6;
	Tue,  9 Jun 2026 22:55:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB95350D7D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:55:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045725; cv=pass; b=YKwNtnKrT3j3wQK9tXSzS+INFCIxhhYdKuG5aupmjw0eM4PTnp5z2g0jLJdcjzRZuLyk4o1sEiCZT5NVAfFlt3nhB6NkmDVeJHCapKev04ma2MAzTcKrvADdQG7UrgxKecxLejqrMWuV1WP0/xMIyXQXXLK4zhZHTrjkhJ5SBvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045725; c=relaxed/simple;
	bh=IC5D0q9A1ff1mcEk8QQfu8ghFJ8rLbTLiw0NFDBICco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gt6xzEu2ShZrJrNPfDdvr+rLMl4UaWlZclrBnBmlKBmUPtkXspNOr4L9duIAR/wVMfk7txbHTO6pQG0Flgvd1eyxvxwMm9J7EA2cjwk66KT4Vrg00FBtEmt/CfpVqiUQpQV9osF4ZfH6ap991DpQ9cunfmS8OWKNE6AmjTbX/Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RncOw3NB; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5175b6c4e19so64412241cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781045722; cv=none;
        d=google.com; s=arc-20240605;
        b=Zy1wWhb7mjw0qyF5RZ/VrifnIxcoiN09/Ue+9jrwslT44exPNhGVYQ8jXNGAQd1qTU
         f44RxqjHQ27S0euqb6QKw1Ul0fx92IO9MBvlKAdfAgrjwKSr1tUcAnRjqrXaj7F7c3CV
         1LbapD8KaFh/AD6im7diTlE7o17Uq+w2zYUO/WCUrtL2DF+ArKIKhfTQnQGkgJepItgb
         /scQtC/NhLnAflRyf03l9qZMTOyWynhFKnFNrph94KQ4zqCvnHvufBimTp0c22ukJ19g
         H7dYWjPqKVElxo/aXxiCNJ792NsFJEIEayB6f4kPwkXKuBty1PwQgJEP/6YdxD2DS2S8
         Cj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        fh=A6sVZGKDPlswa70JK8EYlSBn54PKRS60TLZmZkq++ZU=;
        b=TALDZZkZ2AxD0i80tOWb33Gn4sAxoXB4duYTMU+Q2R2c2UTQ6j61vDuk/wdM7ru1aW
         xVrVoDxdjlJYNxde5GQOXpfcfVfhJ35ehuxqFW2m48EFRFHHY/z52l6qaylVRtiu0XaA
         JUiWhbikVDdzzVqtFfJ5dMXdexA25ZQ/g9ylTjLV+d8rKlNS8zVAnd2nRP8HnD5FY5uh
         cGj9uiIZM/mUXxkOxQwM2+Co5zSg7RcEpSmNgFT67LMfHnzA83yQ869yyC3npFnhI5WO
         HjrTrMUG+MQ3/lN2kVhNEdHdgXEyL4nP7Mno5fLrmDdIuSzP8jsk8p7mjqi4NZUW7uFA
         gz1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781045722; x=1781650522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        b=RncOw3NBkwVXauKevpicMX6Q01nCjX4k0el9j8YrraF+/d99wxiJjRbVWEmBg/X1FR
         vKJN9XjGlIWybArWM4fWGeHZGtTzm4QfFTE0h24fLe4ldpn45CWxVljMtt/eFK5Rb3i/
         EJbv/zhU3cH9nAsvwdY/Kyk2mV6dqD8X6NseWztRYxsGlmm8uCaeAZGl9le3YWtKQNzh
         XvlQBAaAeR+3RF33XgOgAz0jTer8UtfRYmTsHuwzOgyto8WSSZ9/4iqLs+7FSCYOFcQa
         8DCSMNBwTWLZW3X4TQJhJaDB9BUI8vdXs/k2siYyGEM/OlKrH/YWJdrsjYMXZvMa55ZT
         CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781045722; x=1781650522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        b=f3Uw22yeKOxJv7ZiCY/7CLg7FD735guRKPjO1QRujJEsLNfNgctrDuZnW+MsDUo+QM
         +3ggcONv0ZIPTCD2TOgxg2d9OEuWHe5bHyYEHEKtRratqt3TNf4m6fjJ9YCouX4eYyZ9
         OpfEfsE2FXZGwOFk0d2Juoh7YJOoBYEL2ToDA6D3XzJLTXdtMqF/V68PS2cwTgbWTrrh
         Ex/1WHU8HSknEXdMdox7S2NqR/njSqqrFrp4U5+sbThfzeFXitOeaUU40AXDQZ9DdZ/J
         Jd/4XyLkG6YkbzO4riMLVTWtq86+wzDOkigVAWTXeeEskXilGLyFk0ONSgUyizzNrSjd
         9eKQ==
X-Gm-Message-State: AOJu0YytCJxwAGejFqDZ5I7QorqBckiDrJbFDe93vIRWdVICCtHlp3FS
	RbRZmdVRKdf4EI0UN72mFG2qCLLnuE9B/sGzXoh0o4vQhZg/BERzRjQ5VZqOm/is+UCElbksZ/W
	y4KdjFEa692F+f/nue1wfCJ5Np5uUZQg=
X-Gm-Gg: Acq92OFkmx3xHKYGUL3JAOQ+1rIGZ0zYzJk8phRrgUnzKYKuLhpKaO9bizPbPEZS//i
	84jCDlvKKye4cLjda987BV116XZF79C0O/iTilWXfsKUz1Gasas2YxRrZQ6z0yMiSFQ7F7vKEbA
	tcsyRaIbQfsBH1JEy84iAd2KCRtq4C7J3VGUSdj22FT/tZ56m2BkWgtIrVRK5DQvbqxoZrfVtw3
	n3ZGW5TiodflhekFcZ2o5cPlvbCHyCoO0Ug14+4beiDnt4Pj+XEnE2j+DyRIDO+i8nmWo68fA0/
	MXOFItfbjAslM94kDZCGUf/ytjcWCYaqEsBtsiaM3/69xvh0
X-Received: by 2002:a05:622a:2cd:b0:517:6b57:8164 with SMTP id
 d75a77b69052e-51795cda6f0mr336323351cf.55.1781045722193; Tue, 09 Jun 2026
 15:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrice Brissette <patrice.brissette@gmail.com>
Date: Tue, 9 Jun 2026 18:55:10 -0400
X-Gm-Features: AVVi8Cd8WNNtCMxDvtFiwmiz7B97V2UaW09A0WMNcdeATbL9C44zOanZ4SJ4J7A
Message-ID: <CACWwMkvCAdjDPEraGhBdH67tkK=3p=aygZ2JYCRPkOzjVghFpw@mail.gmail.com>
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
To: Ido Schimmel <idosch@idosch.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@idosch.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux-foundation.org,m:mrinmoy_g@hotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[patricebrissette@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297343-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patricebrissette@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux-foundation.org,hotmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68DDE664AC1

Hi,

I'm following up on the status of this patch series. This feature is
critical for our EVPN Multihoming deployments, and the corresponding
FRRouting work is currently blocked pending support for this
functionality.

Has there been any progress on this effort, or has someone else picked
it up? What are the next steps?

For reference, the proposed work includes:

Adding support for a protocol field to bridge and VXLAN FDB entries.

Allowing the protocol field to identify the source of an FDB update,
for example:

Zebra for control-plane-originated entries

HW for data-plane-learned entries (e.g., ASIC-learned MACs)

Extending iproute2 to support configuration and display of this new field.

The primary use case is EVPN Multihoming with ARP/ND synchronization
for hosts that are multihomed to a set of routers. In this
environment, the same MAC address may be learned locally by hardware
when the host is directly attached, or installed by the control plane
when the entry is synchronized through BGP, as commonly occurs in
all-active scenarios.

The protocol field allows FRRouting to distinguish
control-plane-installed entries from hardware-learned entries,
enabling correct MAC mobility handling, ES peer synchronization, and
proper processing of MAC ownership changes.

Please let me know if anyone is already working on this. Otherwise, I
would be happy to pick it up and help move it forward.

Thanks,
Patrice


From: Ido Schimmel <idosch@idosch.org>
Date: Thursday, August 21, 2025 at 07:03
To: Mrinmoy Ghosh (mrghosh) <mrghosh@cisco.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
netdev@vger.kernel.org <netdev@vger.kernel.org>;
bridge@lists.linux-foundation.org <bridge@lists.linux-foundation.org>;
Mrinmoy Ghosh <mrinmoy_g@hotmail.com>; Patrice Brissette (pbrisset)
<pbrisset@cisco.com>
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb

On Mon, Aug 18, 2025 at 05:52:58PM +0000, Mrinmoy Ghosh wrote:
> This is to add optional "protocol" field for bridge fdb entries.
> The introduction of the 'protocol' field in the bridge FDB for EVPN Multi=
home, addresses the need to distinguish between MAC addresses learned via t=
he control plane and those learned via the data plane with data plane aging=
. Specifically:
> * A MAC address in an EVPN Multihome environment can be learned either th=
rough the control plane (static MAC) or the data plane (dynamic MAC with ag=
ing).

This is true for EVPN in general, so why mention MH?

> * The 'protocol' field uses values such as 'HW' for data plane dynamic MA=
Cs and 'ZEBRA' for control plane static MACs.

"HW" does not make sense to me. Why does the control plane care if the
entry was learned dynamically in the software data path (no offload) or
in the hardware data path? Entries installed by the kernel should be
installed with "RTPROT_KERNEL" regardless of the origin of the entry
(software / hardware).

That being said, you can encode whatever you want in the protocol field
and adjust rt_protos to display it however you like.

> * This distinction allows the application to manage the MAC address state=
 machine effectively during transitions, which can occur due to traffic has=
hing between EVPN Multihome peers or mobility of MAC addresses across EVPN =
peers.
> * By identifying the source of the MAC learning (control plane vs. data p=
lane), the system can handle MAC aging and mobility more accurately, ensuri=
ng synchronization between control and data planes and improving stability =
and reliability in MAC route handling.

This is quite vague. Can you be more specific on how exactly the control
plane is expected to use the protocol field in EVPN MH?

AFAIK, when the kernel notifies FRR about an FDB entry that was learned
on an ES peer, FRR installs the entry on all the ES peers as a static
entry (no aging, roaming enabled) with the "activity_notify" and
"inactive" flags so that the control plane will be notified when the
entry becomes active (i.e., was learned locally). See:

https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?i=
d=3De041178ba6bc2af0a1148145ee303c9db79fb4cb
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D5e88777a382480d0b1f7eafb6d0fb680ec7a40bb

I am not against adding a cookie ("protocol") to FDB entries, but I
would like to understand your motivation.

>
> This mechanism supports the complex state transitions and synchronization=
 required in EVPN Multihome scenarios, where MAC addresses may move or be l=
earned differently depending on network events and traffic patterns.
>
> Change Summary:
> vxlan_core.c:  Encode NDA_PROTOCOL, and create and update fdb protocol fi=
eld
>                Use RTPROT_UNSPEC when protocol not specified (default)
> vxlan_private.h: protocol field in vxlan_fdb, function signature updates
> vxlan_vnifilter.c: Use default RTPROT_UNSPEC, for default fdb create
> br.c: Use default RTPROT_UNSPEC as protocol, for swdev event
> br_fdb.c: Set NDA_PROTOCOL from protocol for fdb fill.
>           bridge fdb add, delete, learn update of protocol field
> br_private.h: protocol field in net_bridge_fdb_entry
>
> e.g:
> Test along with iproute2 change i.e https://lore.kernel.org/netdev/202508=
16031145.1153429-1-mrghosh@cisco.com/T/#u
>
> $ bridge fdb add 00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic=
 extern_learn proto hw
>
> $ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
> 00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto hw
>
> $ bridge -d -j -p fdb show dev hostbond2
>
> ...
>
> [ {
>         "mac": "00:00:00:00:00:88",
>         "vlan": 1000,
>         "flags": [ "extern_learn" ],
>         "master": "br1000",
>         "flags_ext": [ ],
>         "protocol": "hw",
>         "state": ""
>     },{
> ...
>
> Transition to Zebra:
> $ bridge fdb replace  00:00:00:00:00:88 dev hostbond2 vlan 1000 master dy=
namic extern_learn proto zebra
>
> $ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
> 00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto zebra
>
> $ bridge -d -j -p fdb show dev hostbond2 ...
> [ {
>         "mac": "00:00:00:00:00:88",
>         "vlan": 1000,
>         "flags": [ "extern_learn" ],
>         "master": "br1000",
>         "flags_ext": [ ],
>         "protocol": "zebra",
>         "state": ""
>     },
> ...
>
> iproute2 review: https://lore.kernel.org/netdev/20250816031145.1153429-1-=
mrghosh@cisco.com/T/#u
>
> Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
> Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
> Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 132 ++++++++++++++--------------
>  drivers/net/vxlan/vxlan_private.h   |  21 +++--
>  drivers/net/vxlan/vxlan_vnifilter.c |  11 +--
>  net/bridge/br.c                     |   4 +-
>  net/bridge/br_fdb.c                 |  52 ++++++++---
>  net/bridge/br_private.h             |   5 +-
>  6 files changed, 127 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index f32be2e301f2..eff342e467a6 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -206,6 +206,8 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct=
 vxlan_dev *vxlan,
>                        peernet2id(dev_net(vxlan->dev), vxlan->net)))
>                goto nla_put_failure;
>
> +     if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))

Maybe fill only if not 0?

You should patch vxlan_nlmsg_size() as well.

> +             goto nla_put_failure;
>        if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.eth_a=
ddr))
>                goto nla_put_failure;
>        if (nh) {
> @@ -852,12 +854,11 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vx=
lan, struct vxlan_fdb *fdb,
>        return err;
>  }
>
> -int vxlan_fdb_create(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __be16 port, __be32 src_vni,
> -                  __be32 vni, __u32 ifindex, __u16 ndm_flags,
> +int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __be16 port,
> +                  __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_f=
lags,
>                     u32 nhid, struct vxlan_fdb **fdb,
> -                  struct netlink_ext_ack *extack)
> +                  struct netlink_ext_ack *extack, u8 protocol)

Move this after 'nhid' so it's closer to the other attributes.

I will add an item to my TODO list to move these arguments into an FDB
config structure.

>  {
>        struct vxlan_rdst *rd =3D NULL;
>        struct vxlan_fdb *f;
> @@ -872,6 +873,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
>        if (!f)
>                return -ENOMEM;
>
> +     f->protocol =3D protocol;

Multicast FDB entries can have multiple remotes and each can be added by
a different entity. I think it makes more sense to move the protocol
field to the remote structure.

>        if (nhid)
>                rc =3D vxlan_fdb_nh_update(vxlan, f, nhid, extack);
>        else
> @@ -964,14 +966,12 @@ static void vxlan_dst_free(struct rcu_head *head)
>        kfree(rd);
>  }
>
> -static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
> -                                  union vxlan_addr *ip,
> -                                  __u16 state, __u16 flags,
> -                                  __be16 port, __be32 vni,
> -                                  __u32 ifindex, __u16 ndm_flags,
> -                                  struct vxlan_fdb *f, u32 nhid,
> -                                  bool swdev_notify,
> -                                  struct netlink_ext_ack *extack)
> +static int
> +vxlan_fdb_update_existing(struct vxlan_dev *vxlan, union vxlan_addr *ip,
> +                       __u16 state, __u16 flags, __be16 port, __be32 vni=
,
> +                       __u32 ifindex, __u16 ndm_flags, struct vxlan_fdb =
*f,
> +                       u32 nhid, bool swdev_notify,
> +                       struct netlink_ext_ack *extack, u8 protocol)
>  {
>        __u16 fdb_flags =3D (ndm_flags & ~NTF_USE);
>        struct vxlan_rdst *rd =3D NULL;
> @@ -1005,6 +1005,11 @@ static int vxlan_fdb_update_existing(struct vxlan_=
dev *vxlan,
>                        f->flags =3D fdb_flags;
>                        notify =3D 1;
>                }
> +             if (f->protocol !=3D protocol) {
> +                     f->protocol =3D protocol;
> +                     f->updated =3D jiffies;
> +                     notify =3D 1;
> +             }
>        }
>
>        if ((flags & NLM_F_REPLACE)) {
> @@ -1063,13 +1068,12 @@ static int vxlan_fdb_update_existing(struct vxlan=
_dev *vxlan,
>        return err;
>  }
>
> -static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
> -                                const u8 *mac, union vxlan_addr *ip,
> -                                __u16 state, __u16 flags,
> -                                __be16 port, __be32 src_vni, __be32 vni,
> -                                __u32 ifindex, __u16 ndm_flags, u32 nhid=
,
> -                                bool swdev_notify,
> -                                struct netlink_ext_ack *extack)
> +static int vxlan_fdb_update_create(struct vxlan_dev *vxlan, const u8 *ma=
c,
> +                                union vxlan_addr *ip, __u16 state,
> +                                __u16 flags, __be16 port, __be32 src_vni=
,
> +                                __be32 vni, __u32 ifindex, __u16 ndm_fla=
gs,
> +                                u32 nhid, bool swdev_notify,
> +                                struct netlink_ext_ack *extack, u8 proto=
col)
>  {
>        __u16 fdb_flags =3D (ndm_flags & ~NTF_USE);
>        struct vxlan_fdb *f;
> @@ -1081,8 +1085,8 @@ static int vxlan_fdb_update_create(struct vxlan_dev=
 *vxlan,
>                return -EOPNOTSUPP;
>
>        netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
> -     rc =3D vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
> -                           vni, ifindex, fdb_flags, nhid, &f, extack);
> +     rc =3D vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni, vni,
> +                           ifindex, fdb_flags, nhid, &f, extack, protoco=
l);
>        if (rc < 0)
>                return rc;
>
> @@ -1099,13 +1103,11 @@ static int vxlan_fdb_update_create(struct vxlan_d=
ev *vxlan,
>  }
>
>  /* Add new entry to forwarding table -- assumes lock held */
> -int vxlan_fdb_update(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __u16 flags,
> -                  __be16 port, __be32 src_vni, __be32 vni,
> -                  __u32 ifindex, __u16 ndm_flags, u32 nhid,
> -                  bool swdev_notify,
> -                  struct netlink_ext_ack *extack)
> +int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __u16 flags,
> +                  __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex=
,
> +                  __u16 ndm_flags, u32 nhid, bool swdev_notify,
> +                  struct netlink_ext_ack *extack, u8 protocol)
>  {
>        struct vxlan_fdb *f;
>
> @@ -1119,7 +1121,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
>
>                return vxlan_fdb_update_existing(vxlan, ip, state, flags, =
port,
>                                                 vni, ifindex, ndm_flags, =
f,
> -                                              nhid, swdev_notify, extack=
);
> +                                              nhid, swdev_notify, extack=
,
> +                                              protocol);
>        } else {
>                if (!(flags & NLM_F_CREATE))
>                        return -ENOENT;
> @@ -1127,7 +1130,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
>                return vxlan_fdb_update_create(vxlan, mac, ip, state, flag=
s,
>                                               port, src_vni, vni, ifindex=
,
>                                               ndm_flags, nhid, swdev_noti=
fy,
> -                                            extack);
> +                                            extack, protocol);
>        }
>  }
>
> @@ -1142,7 +1145,7 @@ static void vxlan_fdb_dst_destroy(struct vxlan_dev =
*vxlan, struct vxlan_fdb *f,
>  static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>                           union vxlan_addr *ip, __be16 *port, __be32 *src=
_vni,
>                           __be32 *vni, u32 *ifindex, u32 *nhid,
> -                        struct netlink_ext_ack *extack)
> +                        struct netlink_ext_ack *extack, u8 *protocol)
>  {
>        struct net *net =3D dev_net(vxlan->dev);
>        int err;
> @@ -1222,6 +1225,11 @@ static int vxlan_fdb_parse(struct nlattr *tb[], st=
ruct vxlan_dev *vxlan,
>
>        *nhid =3D nla_get_u32_default(tb[NDA_NH_ID], 0);
>
> +     if (tb[NDA_PROTOCOL])
> +             *protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +     else
> +             *protocol =3D RTPROT_UNSPEC;
> +
>        return 0;
>  }
>
> @@ -1238,6 +1246,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct =
nlattr *tb[],
>        __be32 src_vni, vni;
>        u32 ifindex, nhid;
>        int err;
> +     u8 protocol;

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-order=
ing-reverse-xmas-tree-rcs

Make this change throughout the patch.

>
>        if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
>                pr_info("RTM_NEWNEIGH with invalid state %#x\n",
> @@ -1249,7 +1258,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct =
nlattr *tb[],
>                return -EINVAL;
>
>        err =3D vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &if=
index,
> -                           &nhid, extack);
> +                           &nhid, extack, &protocol);
>        if (err)
>                return err;
>
> @@ -1257,10 +1266,10 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struc=
t nlattr *tb[],
>                return -EAFNOSUPPORT;
>
>        spin_lock_bh(&vxlan->hash_lock);
> -     err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
> -                            port, src_vni, vni, ifindex,
> -                            ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
> -                            nhid, true, extack);
> +     err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags, p=
ort,
> +                            src_vni, vni, ifindex,
> +                            ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER, nh=
id,
> +                            true, extack, protocol);
>        spin_unlock_bh(&vxlan->hash_lock);
>
>        if (!err)
> @@ -1314,9 +1323,10 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, str=
uct nlattr *tb[],
>        u32 ifindex, nhid;
>        __be16 port;
>        int err;
> +     u8 protocol;
>
>        err =3D vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &if=
index,
> -                           &nhid, extack);
> +                           &nhid, extack, &protocol);
>        if (err)
>                return err;
>
> @@ -1470,13 +1480,12 @@ static enum skb_drop_reason vxlan_snoop(struct ne=
t_device *dev,
>
>                /* close off race between vxlan_flush and incoming packets=
 */
>                if (netif_running(dev))
> -                     vxlan_fdb_update(vxlan, src_mac, src_ip,
> -                                      NUD_REACHABLE,
> -                                      NLM_F_EXCL|NLM_F_CREATE,
> -                                      vxlan->cfg.dst_port,
> -                                      vni,
> -                                      vxlan->default_dst.remote_vni,
> -                                      ifindex, NTF_SELF, 0, true, NULL);
> +                     vxlan_fdb_update(vxlan, src_mac, src_ip, NUD_REACHA=
BLE,
> +                                      NLM_F_EXCL | NLM_F_CREATE,
> +                                      vxlan->cfg.dst_port, vni,
> +                                      vxlan->default_dst.remote_vni, ifi=
ndex,
> +                                      NTF_SELF, 0, true, NULL,
> +                                      RTPROT_UNSPEC);

Entries installed by the kernel should have RTPROT_KERNEL

>                spin_unlock(&vxlan->hash_lock);
>        }
>
> @@ -3963,15 +3972,13 @@ static int __vxlan_dev_create(struct net *net, st=
ruct net_device *dev,
>        /* create an fdb entry for a valid default destination */
>        if (!vxlan_addr_any(&dst->remote_ip)) {
>                spin_lock_bh(&vxlan->hash_lock);
> -             err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
> -                                    &dst->remote_ip,
> +             err =3D vxlan_fdb_update(vxlan, all_zeros_mac, &dst->remote=
_ip,
>                                       NUD_REACHABLE | NUD_PERMANENT,
>                                       NLM_F_EXCL | NLM_F_CREATE,
> -                                    vxlan->cfg.dst_port,
> -                                    dst->remote_vni,
> -                                    dst->remote_vni,
> -                                    dst->remote_ifindex,
> -                                    NTF_SELF, 0, true, extack);
> +                                    vxlan->cfg.dst_port, dst->remote_vni=
,
> +                                    dst->remote_vni, dst->remote_ifindex=
,
> +                                    NTF_SELF, 0, true, extack,
> +                                    RTPROT_UNSPEC);
>                spin_unlock_bh(&vxlan->hash_lock);
>                if (err)
>                        goto unlink;
> @@ -4416,10 +4423,10 @@ static int vxlan_changelink(struct net_device *de=
v, struct nlattr *tb[],
>                                               &conf.remote_ip,
>                                               NUD_REACHABLE | NUD_PERMANE=
NT,
>                                               NLM_F_APPEND | NLM_F_CREATE=
,
> -                                            vxlan->cfg.dst_port,
> -                                            conf.vni, conf.vni,
> -                                            conf.remote_ifindex,
> -                                            NTF_SELF, 0, true, extack);
> +                                            vxlan->cfg.dst_port, conf.vn=
i,
> +                                            conf.vni, conf.remote_ifinde=
x,
> +                                            NTF_SELF, 0, true, extack,
> +                                            RTPROT_UNSPEC);
>                        if (err) {
>                                spin_unlock_bh(&vxlan->hash_lock);
>                                netdev_adjacent_change_abort(dst->remote_d=
ev,
> @@ -4767,14 +4774,11 @@ vxlan_fdb_external_learn_add(struct net_device *d=
ev,
>
>        spin_lock_bh(&vxlan->hash_lock);
>        err =3D vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->rem=
ote_ip,
> -                            NUD_REACHABLE,
> -                            NLM_F_CREATE | NLM_F_REPLACE,
> -                            fdb_info->remote_port,
> -                            fdb_info->vni,
> -                            fdb_info->remote_vni,
> -                            fdb_info->remote_ifindex,
> -                            NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
> -                            0, false, extack);
> +                            NUD_REACHABLE, NLM_F_CREATE | NLM_F_REPLACE,
> +                            fdb_info->remote_port, fdb_info->vni,
> +                            fdb_info->remote_vni, fdb_info->remote_ifind=
ex,
> +                            NTF_USE | NTF_SELF | NTF_EXT_LEARNED, 0, fal=
se,
> +                            extack, RTPROT_UNSPEC);
>        spin_unlock_bh(&vxlan->hash_lock);
>
>        return err;
> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_=
private.h
> index 6c625fb29c6c..19d1b93be279 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -39,6 +39,7 @@ struct vxlan_fdb {
>        struct vxlan_fdb_key key;
>        u16               state; /* see ndm_state */
>        u16               flags; /* see ndm_flags and below */
> +     u8 protocol; /* protocol for FDB entry */
>        struct list_head  nh_list;
>        struct hlist_node fdb_node;
>        struct nexthop __rcu *nh;
> @@ -180,24 +181,22 @@ vxlan_vnifilter_lookup(struct vxlan_dev *vxlan, __b=
e32 vni)
>  }
>
>  /* vxlan_core.c */
> -int vxlan_fdb_create(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __be16 port, __be32 src_vni,
> -                  __be32 vni, __u32 ifindex, __u16 ndm_flags,
> +int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __be16 port,
> +                  __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_f=
lags,
>                     u32 nhid, struct vxlan_fdb **fdb,
> -                  struct netlink_ext_ack *extack);
> +                  struct netlink_ext_ack *extack, u8 protocol);
>  int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>                       const unsigned char *addr, union vxlan_addr ip,
>                       __be16 port, __be32 src_vni, __be32 vni,
>                       u32 ifindex, bool swdev_notify);
>  u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
>  u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
> -int vxlan_fdb_update(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __u16 flags,
> -                  __be16 port, __be32 src_vni, __be32 vni,
> -                  __u32 ifindex, __u16 ndm_flags, u32 nhid,
> -                  bool swdev_notify, struct netlink_ext_ack *extack);
> +int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __u16 flags,
> +                  __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex=
,
> +                  __u16 ndm_flags, u32 nhid, bool swdev_notify,
> +                  struct netlink_ext_ack *extack, u8 protocol);
>  void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>                    __be32 default_vni, struct vxlan_rdst *rdst, bool did_=
rsc);
>  int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxla=
n_vnifilter.c
> index adc89e651e27..908b6b489ac8 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -482,15 +482,12 @@ static int vxlan_update_default_fdb_entry(struct vx=
lan_dev *vxlan, __be32 vni,
>
>        spin_lock_bh(&vxlan->hash_lock);
>        if (remote_ip && !vxlan_addr_any(remote_ip)) {
> -             err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
> -                                    remote_ip,
> +             err =3D vxlan_fdb_update(vxlan, all_zeros_mac, remote_ip,
>                                       NUD_REACHABLE | NUD_PERMANENT,
>                                       NLM_F_APPEND | NLM_F_CREATE,
> -                                    vxlan->cfg.dst_port,
> -                                    vni,
> -                                    vni,
> -                                    dst->remote_ifindex,
> -                                    NTF_SELF, 0, true, extack);
> +                                    vxlan->cfg.dst_port, vni, vni,
> +                                    dst->remote_ifindex, NTF_SELF, 0, tr=
ue,
> +                                    extack, RTPROT_UNSPEC);
>                if (err) {
>                        spin_unlock_bh(&vxlan->hash_lock);
>                        return err;
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 1885d0c315f0..55f017e00247 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -173,8 +173,8 @@ static int br_switchdev_event(struct notifier_block *=
unused,
>        case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>                fdb_info =3D ptr;
>                err =3D br_fdb_external_learn_add(br, p, fdb_info->addr,
> -                                             fdb_info->vid,
> -                                             fdb_info->locked, false);
> +                                             fdb_info->vid, fdb_info->lo=
cked,
> +                                             false, RTPROT_UNSPEC);
>                if (err) {
>                        err =3D notifier_from_errno(err);
>                        break;
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 902694c0ce64..e1b93e495db3 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -123,6 +123,8 @@ static int fdb_fill_info(struct sk_buff *skb, const s=
truct net_bridge *br,
>                goto nla_put_failure;
>        if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
>                goto nla_put_failure;
> +     if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))
> +             goto nla_put_failure;

Need to patch fdb_nlmsg_size()

>        if (nla_put_u32(skb, NDA_FLAGS_EXT, ext_flags))
>                goto nla_put_failure;
>
> @@ -1153,7 +1155,8 @@ static int fdb_add_entry(struct net_bridge *br, str=
uct net_bridge_port *source,
>  static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>                        struct net_bridge_port *p, const unsigned char *ad=
dr,
>                        u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
> -                     bool *notified, struct netlink_ext_ack *extack)
> +                     bool *notified, struct netlink_ext_ack *extack,
> +                     u8 protocol)

Move this after 'vid' so it's closer to the other attributes.

>  {
>        int err =3D 0;
>
> @@ -1177,7 +1180,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct n=
et_bridge *br,
>                                           "FDB entry towards bridge must =
be permanent");
>                        return -EINVAL;
>                }
> -             err =3D br_fdb_external_learn_add(br, p, addr, vid, false, =
true);
> +             err =3D br_fdb_external_learn_add(br, p, addr, vid, false, =
true,
> +                                             protocol);
>        } else {
>                spin_lock_bh(&br->hash_lock);
>                err =3D fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nf=
ea_tb);
> @@ -1206,6 +1210,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>        struct net_bridge_vlan *v;
>        struct net_bridge *br =3D NULL;
>        u32 ext_flags =3D 0;
> +     u8 protocol =3D RTPROT_UNSPEC;
>        int err =3D 0;
>
>        trace_br_fdb_add(ndm, dev, addr, vid, nlh_flags);
> @@ -1237,6 +1242,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>        if (tb[NDA_FLAGS_EXT])
>                ext_flags =3D nla_get_u32(tb[NDA_FLAGS_EXT]);
>
> +     if (tb[NDA_PROTOCOL])
> +             protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +
>        if (ext_flags & NTF_EXT_LOCKED) {
>                NL_SET_ERR_MSG_MOD(extack, "Cannot add FDB entry with \"lo=
cked\" flag set");
>                return -EINVAL;
> @@ -1261,10 +1269,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *=
tb[],
>
>                /* VID was specified, so use it. */
>                err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfe=
a_tb,
> -                                notified, extack);
> +                                notified, extack, protocol);
>        } else {
>                err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_=
tb,
> -                                notified, extack);
> +                                notified, extack, protocol);
>                if (err || !vg || !vg->num_vlans)
>                        goto out;
>
> @@ -1276,7 +1284,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>                        if (!br_vlan_should_use(v))
>                                continue;
>                        err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, =
v->vid,
> -                                        nfea_tb, notified, extack);
> +                                        nfea_tb, notified, extack, proto=
col);
>                        if (err)
>                                goto out;
>                }
> @@ -1288,7 +1296,8 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>
>  static int fdb_delete_by_addr_and_port(struct net_bridge *br,
>                                       const struct net_bridge_port *p,
> -                                    const u8 *addr, u16 vlan, bool *noti=
fied)
> +                                    const u8 *addr, u16 vlan, u8 protoco=
l,
> +                                    bool *notified)
>  {
>        struct net_bridge_fdb_entry *fdb;
>
> @@ -1296,6 +1305,13 @@ static int fdb_delete_by_addr_and_port(struct net_=
bridge *br,
>        if (!fdb || READ_ONCE(fdb->dst) !=3D p)
>                return -ENOENT;
>
> +     /* If the delete comes from a different protocol type,
> +     * that type is used in the notification as some software
> +     * may be expecting multiple deletes (control learned +
> +     * hardware datapath learned) */
> +     if (protocol !=3D RTPROT_UNSPEC)
> +             fdb->protocol =3D protocol;

I don't understand this. The protocol that should be notified is the one
of the FDB entry being deleted.

> +
>        fdb_delete(br, fdb, true);
>        *notified =3D true;
>
> @@ -1304,12 +1320,13 @@ static int fdb_delete_by_addr_and_port(struct net=
_bridge *br,
>
>  static int __br_fdb_delete(struct net_bridge *br,
>                           const struct net_bridge_port *p,
> -                        const unsigned char *addr, u16 vid, bool *notifi=
ed)
> +                        const unsigned char *addr, u16 vid, u8 protocol,
> +                        bool *notified)
>  {
>        int err;
>
>        spin_lock_bh(&br->hash_lock);
> -     err =3D fdb_delete_by_addr_and_port(br, p, addr, vid, notified);
> +     err =3D fdb_delete_by_addr_and_port(br, p, addr, vid, protocol, not=
ified);
>        spin_unlock_bh(&br->hash_lock);
>
>        return err;
> @@ -1324,8 +1341,12 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr=
 *tb[],
>        struct net_bridge_vlan_group *vg;
>        struct net_bridge_port *p =3D NULL;
>        struct net_bridge *br;
> +     u8 protocol =3D RTPROT_UNSPEC;
>        int err;
>
> +     if (tb[NDA_PROTOCOL])
> +             protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +
>        if (netif_is_bridge_master(dev)) {
>                br =3D netdev_priv(dev);
>                vg =3D br_vlan_group(br);
> @@ -1341,19 +1362,20 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlatt=
r *tb[],
>        }
>
>        if (vid) {
> -             err =3D __br_fdb_delete(br, p, addr, vid, notified);
> +             err =3D __br_fdb_delete(br, p, addr, vid, protocol, notifie=
d);
>        } else {
>                struct net_bridge_vlan *v;
>
>                err =3D -ENOENT;
> -             err &=3D __br_fdb_delete(br, p, addr, 0, notified);
> +             err &=3D __br_fdb_delete(br, p, addr, 0, protocol, notified=
);
>                if (!vg || !vg->num_vlans)
>                        return err;
>
>                list_for_each_entry(v, &vg->vlan_list, vlist) {
>                        if (!br_vlan_should_use(v))
>                                continue;
> -                     err &=3D __br_fdb_delete(br, p, addr, v->vid, notif=
ied);
> +                     err &=3D __br_fdb_delete(br, p, addr, v->vid, proto=
col,
> +                                            notified);
>                }
>        }
>
> @@ -1414,7 +1436,7 @@ void br_fdb_unsync_static(struct net_bridge *br, st=
ruct net_bridge_port *p)
>
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_p=
ort *p,
>                              const unsigned char *addr, u16 vid, bool loc=
ked,
> -                           bool swdev_notify)
> +                           bool swdev_notify, u8 protocol)
>  {
>        struct net_bridge_fdb_entry *fdb;
>        bool modified =3D false;
> @@ -1445,6 +1467,7 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
>                        err =3D -ENOMEM;
>                        goto err_unlock;
>                }
> +             fdb->protocol =3D protocol;
>                fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>        } else {
>                if (locked &&
> @@ -1483,6 +1506,11 @@ int br_fdb_external_learn_add(struct net_bridge *b=
r, struct net_bridge_port *p,
>                    test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags=
))
>                        atomic_dec(&br->fdb_n_learned);
>
> +             if (fdb->protocol !=3D protocol) {
> +                     modified =3D true;
> +                     fdb->protocol =3D protocol;
> +             }
> +
>                if (modified)
>                        fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>        }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index b159aae594c0..dc14c3c102b2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -291,6 +291,7 @@ struct net_bridge_fdb_entry {
>        struct net_bridge_fdb_key       key;
>        struct hlist_node               fdb_node;
>        unsigned long                   flags;
> +     u8 protocol;

Align the name like other fields. I guess position in the structure is
OK since this field is not write-heavy and there is a 16 bytes hole
here.

>
>        /* write-heavy members should not affect lookups */
>        unsigned long                   updated ____cacheline_aligned_in_s=
mp;
> @@ -870,8 +871,8 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb=
[], struct net_device *dev,
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)=
;
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port =
*p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_p=
ort *p,
> -                           const unsigned char *addr, u16 vid,
> -                           bool locked, bool swdev_notify);
> +                           const unsigned char *addr, u16 vid, bool lock=
ed,
> +                           bool swdev_notify, u8 protocol);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_p=
ort *p,
>                              const unsigned char *addr, u16 vid,
>                              bool swdev_notify);
> --
> 2.43.0
>
>

