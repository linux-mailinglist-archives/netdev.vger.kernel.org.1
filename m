Return-Path: <netdev+bounces-19698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034175BBD5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EAA1C21539
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5A386;
	Fri, 21 Jul 2023 01:34:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B2363
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 01:34:23 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2BE52
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:34:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b89d47ffb6so8619255ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689903262; x=1690508062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BOF2G2EDfQyAQ0VqC7/myG88I7Vh/DV+pD5JO+qIUQ=;
        b=dxZtYovTYrqh4iLWd5CN+rc9fdR7y0Aq+CWnS+LpQPGfyLs0LNpIQLKZCRQErZvJOR
         QYuSAp1qwoWJTiyvADNqtPHvUNSHMVRkBUJJVWqAAxD5U6kTqE7UQQjvda+ZbJ+tin49
         YZXjw8QNLXz2HQVUI6lw0IKcc0HU15ItieT9kg+hIa1vPa9N56xMQ3YxFC9tN45FUWqx
         biNxvBNPSowBp9DyleJr5+evhPH+SuDokQJiVRDX0GS5kYQQIXMnt1ARCfltwtEo1aCv
         IOSQaistrsF+FnAfKlNjagNovmywa58f4KhzPHbbKhd3vB1ATmG1K6VXmEKSvswYqP+h
         Z9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689903262; x=1690508062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BOF2G2EDfQyAQ0VqC7/myG88I7Vh/DV+pD5JO+qIUQ=;
        b=MD3UPotwOrYtbb/wsBtMMFJlp1Iy5MgyQzSi+DiQW3aW2A17OL/qGhdhnI+dv/5Cdh
         gOmOgnLJXnAsMndpJoWKgkU9IoSeobqiqfssjCDbW5KlXPdsbBSt6wfdHiqyi7eHCuyv
         770F4CZFqjJ4nyHKVN9evj9SkSyLodpiYMUJqRgSdJ3xwZqn5heRqIaxxFXU4zLaLkll
         eI/H4aU2JMOCc4WUdaE3lBASYAdy1HH0LrKqDWsUiLTR9uMT4T1JPOK4y2Ayk0bFkb6D
         VOrkmnYTSxqMm5STX25Jm8goIHETmVlsDbAiAkxiPkqgjwmb0tOkGfFbx5iNMOoCzmdZ
         FLmQ==
X-Gm-Message-State: ABy/qLYnAbwvXIlo5fgf7frYD+wOR1AYfv/10GL0WU9Xvwp2njolIrj/
	/yiVYsN24ZMDQ70d1XL8Ko8=
X-Google-Smtp-Source: APBJJlEm7yGV0tvcFtBte4XEWyJF68jm5GxcwJM9BEDq3OVvU8CLAxkHhH8REKDEcTF3ZVcuneOJNA==
X-Received: by 2002:a17:903:234d:b0:1b8:77b3:6be2 with SMTP id c13-20020a170903234d00b001b877b36be2mr733306plh.39.1689903261706;
        Thu, 20 Jul 2023 18:34:21 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001b7e63cfa19sm2055199plg.234.2023.07.20.18.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 18:34:20 -0700 (PDT)
Date: Fri, 21 Jul 2023 09:34:16 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZLngmOaz24y5yLz8@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLlE5of1Sw1pMPlM@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 05:29:58PM +0300, Ido Schimmel wrote:
> > > > IMO, the number of routes being flushed because a preferred source
> > > > address is deleted is significantly lower compared to interface down /
> > > > deletion, so generating notifications in this case is probably OK. It
> > 
> > How about ignore route deletion for link down? e.g.
> > 
> > diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> > index 74d403dbd2b4..11c0f325e887 100644
> > --- a/net/ipv4/fib_trie.c
> > +++ b/net/ipv4/fib_trie.c
> > @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
> >  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> >  {
> >         struct trie *t = (struct trie *)tb->tb_data;
> > +       struct nl_info info = { .nl_net = net };
> >         struct key_vector *pn = t->kv;
> >         unsigned long cindex = 1;
> >         struct hlist_node *tmp;
> > @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> > 
> >                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
> >                                                 NULL);
> > +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
> > +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> > +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> > +                       }
> 
> Will you get a notification in this case for 198.51.100.0/24?

No. Do you think it is expected with this patch or not?
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip address add 192.0.2.1/24 dev dummy1
> # ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
> # ip link set dev dummy2 carrier off
> # ip -4 r s
> 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
> 198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 linkdown 
> # ip address del 192.0.2.1/24 dev dummy1
> # ip -4 r s

+ ip link set dev dummy2 carrier off
+ sleep 1
+ ip -4 r s
default via 10.73.131.254 dev eth0 proto dhcp src 10.73.131.181 metric 100
10.73.130.0/23 dev eth0 proto kernel scope link src 10.73.131.181 metric 100
192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 linkdown
+ sleep 1
+ ip address del 192.0.2.1/24 dev dummy1
Deleted 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
Deleted broadcast 192.0.2.255 dev dummy1 table local proto kernel scope link src 192.0.2.1
Deleted local 192.0.2.1 dev dummy1 table local proto kernel scope host src 192.0.2.1
+ sleep 1
+ ip -4 r s
default via 10.73.131.254 dev eth0 proto dhcp src 10.73.131.181 metric 100
10.73.130.0/23 dev eth0 proto kernel scope link src 10.73.131.181 metric 100

Thanks
Hangbin

