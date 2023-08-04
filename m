Return-Path: <netdev+bounces-24307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19B76FBAC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D869C28251D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE52F8493;
	Fri,  4 Aug 2023 08:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837B6FAD
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:09:16 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901D1702
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:09:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so12870895ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691136554; x=1691741354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUZxDB/WaWlM0vIuEq531Xkx51/oJ1nwgyfX8OwGUMc=;
        b=IIdcYBk5w/uNoQxAGW5EQV5g4ViNKlQG1+oNtLXlFTNxvhaWfnZ5oPHO/K/Izfk/V3
         nEwEyMvW351ubQ5AU4UsTEDHlpAboY4iOqWDaGSUIXFZCRbnWkcl7TMK7Cvm0JS+NEKp
         FTlBMJQHn50/XpxifMNS5Ey2DNAZZ+X30brXF6WLRZtEcBbXwkumbLmFQRnAhSqi+KP/
         vcLBJTc0+VphMsbG+RRx71WwHiC1nxTlpkyIPUvZ7Va/1FY/BIfNkkgF7an7k5n4iCgr
         8f5bYe7BVG0vMxgIEh8VZ61hQoky/ji41rxrV/K89FCGLWhhX4yWt1wSgUDX4KCuegIt
         dnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136554; x=1691741354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUZxDB/WaWlM0vIuEq531Xkx51/oJ1nwgyfX8OwGUMc=;
        b=S88jfVsi8oieey+T4XKuMyE+jMIvlGQ9exYrOM3SY9dwBQf3p0RWpkNdW5yUP2l3cU
         ab6aX4Pyp6lRJ6bYoJGJL5lqSx6Al64rhk2Ch2G94vLOvR6Lpkyl16fTK1Qiraq7ELQ1
         gKSFHgTsKiPSJcULu7kKe72S/1McLc5HAz/Cw4RM/GBBvnS1iMZ/UkJ6+3oR72UBJ/8h
         fEFTN9d4tpvNnro+xiJ/Yw8vPO303vcvcBickiJYGxA/eS/qqzXIhLm2iSK0aasm6pbB
         xHyO6X4MOVff8QmEaJ/bb7qlUTAEA0+NXt81qjyUruwtIbrISMUPHlkqRNO71MXYmlPh
         jawg==
X-Gm-Message-State: AOJu0YyNuWo48VXsaTtzU+7yScDQwH+tYnxyt9T68d0NJmFKIKr1VQM9
	DtY2E2HRMjDff6DwfCY2Jn4=
X-Google-Smtp-Source: AGHT+IEazZVvfX6SnmYTjBOueQK3hWBvzrblrfgcP0vKrtcXxzbno9Vl/ue9GRaH9XSDroSU+h/1nw==
X-Received: by 2002:a17:903:1ce:b0:1bb:bbda:70d9 with SMTP id e14-20020a17090301ce00b001bbbbda70d9mr1005644plh.63.1691136554350;
        Fri, 04 Aug 2023 01:09:14 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001b9da42cd7dsm1108216pll.279.2023.08.04.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:09:13 -0700 (PDT)
Date: Fri, 4 Aug 2023 16:09:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZMyyJKZDaR8zED8j@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLzY42I/GjWCJ5Do@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 10:38:11AM +0300, Ido Schimmel wrote:
> > > >> Will you get a notification in this case for 198.51.100.0/24?
> > > > 
> > > > No. Do you think it is expected with this patch or not?
> > > 
> > > The intent is that notifications are sent for link events but not route
> > > events which are easily deduced from the link events.
> > 
> > Sorry, I didn't get what you mean. The link events should be notified to user
> > via rtmsg_ifinfo_event()? So I think here we ignore the route events caused by
> > link down looks reasonable.
> 
> The route in the scenario I mentioned wasn't deleted because of a link
> event, but because the source address was deleted yet no notification
> was emitted. IMO, this is wrong given the description of the patch.
> 

Hi Ido,

I reconsidered this issue this week. As we can't get the device status in
fib_table_flush(). How about adding another flag to track the deleted src
entries. e.g. RTNH_F_UNRESOLVED. Which is only used in ipmr currently.
When the src route address is deleted, the route entry also could be
considered as unresolved. With this idea, the patch could be like:

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 51c13cf9c5ae..5c41d34ab447 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -420,7 +420,7 @@ struct rtnexthop {
 #define RTNH_F_ONLINK          4       /* Gateway is forced on link    */
 #define RTNH_F_OFFLOAD         8       /* Nexthop is offloaded */
 #define RTNH_F_LINKDOWN                16      /* carrier-down on nexthop */
-#define RTNH_F_UNRESOLVED      32      /* The entry is unresolved (ipmr) */
+#define RTNH_F_UNRESOLVED      32      /* The entry is unresolved (ipmr/dead src) */
 #define RTNH_F_TRAP            64      /* Nexthop is trapping packets */

 #define RTNH_COMPARE_MASK      (RTNH_F_DEAD | RTNH_F_LINKDOWN | \
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 65ba18a91865..a7ef21a6d271 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1883,7 +1883,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
                    fi->fib_tb_id != tb_id)
                        continue;
                if (fi->fib_prefsrc == local) {
-                       fi->fib_flags |= RTNH_F_DEAD;
+                       fi->fib_flags |= (RTNH_F_DEAD | RTNH_F_UNRESOLVED);
                        ret++;
                }
        }
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 74d403dbd2b4..88c593967063 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
        struct trie *t = (struct trie *)tb->tb_data;
+       struct nl_info info = { .nl_net = net };
        struct key_vector *pn = t->kv;
        unsigned long cindex = 1;
        struct hlist_node *tmp;
@@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)

                        fib_notify_alias_delete(net, n->key, &n->leaf, fa,
                                                NULL);
+                       if (fi->fib_flags & RTNH_F_UNRESOLVED) {
+                               fi->fib_flags &= ~RTNH_F_UNRESOLVED;
+                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
+                       }
                        hlist_del_rcu(&fa->fa_list);
                        fib_release_info(fa->fa_info);
                        alias_free_mem_rcu(fa);

Thanks
Hangbin

