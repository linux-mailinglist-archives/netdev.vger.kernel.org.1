Return-Path: <netdev+bounces-286954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AgjCRu8AmonwAEAu9opvQ
	(envelope-from <netdev+bounces-286954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5051A26F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1437E30BCD15
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0733C1BD;
	Tue, 12 May 2026 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLwZ73D/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F233EAEC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563340; cv=pass; b=Pcld+OAckwMCEtc9Z9k1hvX+aVg0+KVywQFjyrUt77h03IZ549XJf5oN5eQphLWjbyil0g3N9PI9hgZ8kqoL66WsNsg4tlEMs/qBCLCwYG08rnpmhS5U4Kd1/2O9YNNmOGc+/9CXP9+uvzMPQDKmMpu4JEAgYUfQeLGlHjknnkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563340; c=relaxed/simple;
	bh=w6LcnvI+UACPGciOB3/FIjNHS7YFdMfDIftn70GGb8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UArfJuIDZUX5y+Wc0wa87GYetlu581HNXXPGtRkfDVByTUaJDyf7mgNo6wsOm+eRV0EeAZOBiMsKEtejY/UAEzbnZ8rsVWo4DKBCtjYM2LSnyYD93gJm0wN2Ww6QNH2VlB5rsb8SMYRC6YgcrhPgbmxEfO71Ix9gC1UW/2sPkM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLwZ73D/; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95697b46831so3459662241.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 22:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778563324; cv=none;
        d=google.com; s=arc-20240605;
        b=EtGA3JyPGdtMapa/ZjbK4Riy7Y2NFZX+OjzBfcHR6jM6WlguoQkvXxP2GqsU0WNPG8
         zeg5HMTX36sDqW1BbBLlROVgT+nLy7jEN96s5OHPN3F0ZVnWLja7nBWU+k27poL8kyli
         gYVlZNI3IYbw915RZQ8EeD2lxY/2y75u0hjP0TWeBab977xtAKxe6K1h7pHL6xV97hqK
         OBMxsvgmtg7KqWIAuaIFC1w8mek7Qn8x1+bjkf6Bsk+7geK1iRT+kEbVA/j6yKAK2WPg
         i+KZmlN8E60QqUnkVGULshbM4I0H92s820VekmIumCdrg348URVbaAiX9qmFOMBA+Fb7
         Wf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        fh=EbcXnDKF0UKHYD278Eya2iUOJ3MCxKhag2UsiPHLwvI=;
        b=fy1JoNbm1nI2bFUqxsEy+zHJZEw1zgPFnlVdOiRaq9qNelWGeEZKwZLq/wDbEb8o+f
         lE10UdNl9oD9dZTtoL2E8HNheYlNI+d7GIs0sE26geyRKimY2M/MDTOUFAvN5QewoMA6
         DfsEls5tkKOWn5j3vcOKRKQZjs3hT3qsgmyOS/Rqop26sKxN3qNA6iMYcpFihNAKNlDS
         YJjJK+47TlnFseAVXFS/VeJyuucGnBfAbC0gHBepiJKK8xiNVWZtDJ1o5m/TVf8U6udq
         X9fwnRd7WymRRhpLN+BLol9HaFsAMAlm14mbSEioYc+cblaiAuCmo5F4WnsYXJDyQKwS
         yoPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778563324; x=1779168124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        b=QLwZ73D/hOr1cbE6gxqw/nYkDtHXQKp49FSL0bDSYNHYRk7zdqG8f2h9BB7N1Sw6Ec
         pyVJUfICHKkJEu+3psHf8pAyniCnPODWJTkrOgVlJZ4N8DuBJIeoj0SDU2J9MBkog+Bs
         WHMiyd9ftZf+dYWdnj50j1z3bqI7e8gmeBjbgcnKx5VU2hu4md1NVZnrQIckRcTs48VS
         YorxDCKrQHc9AIhIMRHvNQCfUjrEQJK5Vqh97OHtIw2d+BFuQSZpcc7kQP1B6rjMAP0E
         EnMMtR8mBRQfdQMxTrcNwOPmUyJfqX2hoKXPRM6+XdJSaGQjrI9s0Bl/ZqaG287yKXjo
         8YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778563324; x=1779168124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYgT6JkoWsOe0O7WVvYu/GZhovUNbtX9Qj6rCvjhBPw=;
        b=JxQ5Gs1YX2TlHmygibPCFlljC2W9P5RO/h1vJrGsb167uqN/88rHncg1WuojN8iT/x
         YYJdaI5Ry5siol/CKb7igWEdPIWsm7KEBIAHGPHItT9mA7dqki/2bYC0iXcfwxhNaf7l
         zG/kDVdAlyA8hUPkFizpdxqwCkF7LOym55BNOBar4SHNeouqxtn1Vr5LY2vkB/mtd4aW
         xQit1U6fF3OEQi53IF0U/72gkx8VNMAs4/2rqkGkpxYiqx/FIB0vFL4m9Vecj9LkWQ/J
         AUdsnutEd9rdqFQXXU04OB5TmLcJXR9i/UnyJKNxodHxVHZmmjBYfMX13MamZS+KoRB5
         1RWw==
X-Forwarded-Encrypted: i=1; AFNElJ/t9vrFh67GiT/6rK6vf2yjA7pXFMt/sOOtFC+ofm++NSyZK2FFMwgkPZw3Si0IpUJZff60YJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUT+PXmsdT0Ioazr1wXx3Ez6So0OvMELIlVeXgq3de+1IDTlxe
	1cciEbGQsHHw7WRhG4r2KzXguviFXgyF6F+t7Cwqa2a3fVXuqtKYWyhpx/6CwiauJDRUZD8fDq0
	fEEMy0SUdNxmsu9ulo2OqJDcWgPqBE2k=
X-Gm-Gg: Acq92OGC4N44vu6Jc7e4Nx/HTkW1gB/REmO9X2/0IuKx7eVmbeS7qCMVTpJM9xjC8u9
	APIUZQfv5cGHdPleDOpJvQUiznzZgsVNKQZk6dd0CQ+6AvGMJCSqQ7mccuTPAAOb3onGzVhOWO7
	BEbw6yYCoxMwcBIua8+D+aVVRvEM8jcr1PAfHVXtXDNjKRhDoQl8E4EKaA4UPgqoqpCO3ACVEOc
	YkAovk+sriRE/VFobBM2G3Ump11RN88lyJBfbPPGKojvjUSaHDNJzyWHUwIFeLUISoM609pswKk
	YckZBL0Ely71MsAVIw==
X-Received: by 2002:a05:6102:38cb:b0:62e:63e8:427b with SMTP id
 ada2fe7eead31-631d5f7dd9emr5242022137.0.1778563323750; Mon, 11 May 2026
 22:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778378864.git.zylzyl2333@gmail.com> <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org> <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
In-Reply-To: <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
From: Yilin Zhu <zylzyl2333@gmail.com>
Date: Mon, 11 May 2026 22:21:51 -0700
X-Gm-Features: AVHnY4K18FPt2uO6-1U5OqSUkqde66HFo9bX9_ajKrRzv_V_NgvX7_lhx7IXbhw
Message-ID: <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org, 
	henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6DA5051A26F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,microchip.com,kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zylzyl2333@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,mail.gmail.com:mid,blackwall.org:email]
X-Rspamd-Action: no action

On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>
> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> > On 10/05/2026 12:15, Ren Wei wrote:
> >> From: Yilin Zhu <zylzyl2333@gmail.com>
> >>
> >> CFM registers a bridge frame handler when the first MEP is created and
> >> unregisters it when the last MEP is deleted. The registered object also
> >> contains the hlist_node used by the bridge-local frame_type_list.
> >>
> >> The CFM frame type is currently global, so enabling CFM on multiple
> >> bridges links the same hlist_node into multiple bridge-local lists. A
> >> later unregister on one bridge can then operate on list state belonging
> >> to another bridge.
> >>
> >> Move the CFM frame type into struct net_bridge and register/unregister
> >> the bridge-owned object. This keeps frame handler list membership local
> >> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
> >>
> >> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
> >> frame RX added.")
> >> Cc: stable@kernel.org
> >> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> >> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> >> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> >> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >> ---
> >>   net/bridge/br_cfm.c     | 14 ++++++--------
> >>   net/bridge/br_private.h | 18 +++++++++++-------
> >>   2 files changed, 17 insertions(+), 15 deletions(-)
> >>
> >
> > I think MRP suffers from the same bug, but I also think we can contain the
> > fix within the packet type structure instead of making the already huge
> > struct net_bridge even bigger. Also, linking a struct within net_bridge
> > to a list within the same net_bridge looks weird.
> >
> > IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
> > dynamically and link it, then br_del_frame should take a type instead of a ptr
> > and remove that frame type and free it with kfree_rcu. That would require
> > br_add_frame return value to be checked in the respective cfm/mrp functions.
> > Warnings for already existing types on add or missing types on del should be
> > added.
> >
>
> Actually I have a better idea since these handlers can be added only once per
> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
> not compiled in. Would you like me to prepare it or do you want to give it a go?
>

Hi Nik,

Thanks for the suggestion.

I'll give it a go. IIUC, the idea is to remove the shared
br_frame_type list entries for CFM/MRP, track their per-bridge enable
state with bridge option bits, and dispatch the CFM/MRP handlers directly
from the receive path when the corresponding EtherType and option bit
match.

I'll include MRP in v2.

Thanks,
Yilin

> > Would you please take care of MRP as well?
> >
> > Cheers,
> >   Nik
> >
> >> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> >> index 118c7ea48c35..547c7415c0ea 100644
> >> --- a/net/bridge/br_cfm.c
> >> +++ b/net/bridge/br_cfm.c
> >> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port,
> >> struct sk_buff *skb)
> >>       return 1;
> >>   }
> >> -static struct br_frame_type cfm_frame_type __read_mostly = {
> >> -    .type = cpu_to_be16(ETH_P_CFM),
> >> -    .frame_handler = br_cfm_frame_rx,
> >> -};
> >> -
> >>   int br_cfm_mep_create(struct net_bridge *br,
> >>                 const u32 instance,
> >>                 struct br_cfm_mep_create *const create,
> >> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
> >>       INIT_HLIST_HEAD(&mep->peer_mep_list);
> >>       INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
> >> -    if (hlist_empty(&br->mep_list))
> >> -        br_add_frame(br, &cfm_frame_type);
> >> +    if (hlist_empty(&br->mep_list)) {
> >> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
> >> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
> >> +        br_add_frame(br, &br->cfm_frame_type);
> >> +    }
> >>       hlist_add_tail_rcu(&mep->head, &br->mep_list);
> >> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
> >>       kfree_rcu(mep, rcu);
> >>       if (hlist_empty(&br->mep_list))
> >> -        br_del_frame(br, &cfm_frame_type);
> >> +        br_del_frame(br, &br->cfm_frame_type);
> >>   }
> >>   int br_cfm_mep_delete(struct net_bridge *br,
> >> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> >> index bed1b1d9b282..a3ed9ee826f5 100644
> >> --- a/net/bridge/br_private.h
> >> +++ b/net/bridge/br_private.h
> >> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
> >>   typedef struct mac_addr mac_addr;
> >>   typedef __u16 port_id;
> >> +struct net_bridge_port;
> >> +struct sk_buff;
> >> +
> >>   struct bridge_id {
> >>       unsigned char    prio[2];
> >>       unsigned char    addr[ETH_ALEN];
> >> @@ -70,6 +73,13 @@ struct mac_addr {
> >>       unsigned char    addr[ETH_ALEN];
> >>   };
> >> +struct br_frame_type {
> >> +    __be16            type;
> >> +    int            (*frame_handler)(struct net_bridge_port *port,
> >> +                         struct sk_buff *skb);
> >> +    struct hlist_node    list;
> >> +};
> >> +
> >>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> >>   /* our own querier */
> >>   struct bridge_mcast_own_query {
> >> @@ -585,6 +595,7 @@ struct net_bridge {
> >>       struct hlist_head        mrp_list;
> >>   #endif
> >>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
> >> +    struct br_frame_type    cfm_frame_type;
> >>       struct hlist_head        mep_list;
> >>   #endif
> >>   };
> >> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct
> >> net_device *backup_dev);
> >>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff
> >> *skb);
> >>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
> >> -struct br_frame_type {
> >> -    __be16            type;
> >> -    int            (*frame_handler)(struct net_bridge_port *port,
> >> -                         struct sk_buff *skb);
> >> -    struct hlist_node    list;
> >> -};
> >> -
> >>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
> >>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
> >
>

