Return-Path: <netdev+bounces-19367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE075A83D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A41C211C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E591171C1;
	Thu, 20 Jul 2023 07:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4A168C2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:51:43 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC026BA
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:51:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66767d628e2so290018b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689839479; x=1690444279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhYvtTtHmfJBqp6GKvLZlFDBwUaqqvTf5c+aUS7ZlSg=;
        b=s0E4duPAk1syIb7WXYNFSpfbBTJOmQXVUzRr2B79jf7+mto40MXjSqyD1NVQTfJp93
         P9eJWuJpgHgGk1z4QiwwJOE9pLZEUTKDs3x7ZnHaxtDga01UUlRoshrjjJI+MJddlgYl
         YA6l9qcjJrYXY/qezhrC7egnbLuTGgICeO+F9e3/4vhqcBeqNDrXGXEf5W1Oq6vZ4DYA
         WaDdnDpOYxkCbcmkizW6Hlldvd9xonlLrvnmXgFVCPg7+X7k2kZbs+ndUkevZ59Vtg0e
         3R+yHhydNWqDa7r7nw4yC1A18s99p36idMaSAKXkUFJvx+ImeQ3Sm3IizXK4jqyZfxnX
         h+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839479; x=1690444279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhYvtTtHmfJBqp6GKvLZlFDBwUaqqvTf5c+aUS7ZlSg=;
        b=D90ZDjrPp9nHUR6aMUcRVtVTUoljtjsWA29sC180o7OEXo4LN/YxSpg5C1j8BDMf27
         46BBr424v7YGqvBuYPAs1I+0d7zsas/BLfAj/5CXGo4ZAvj1/hTFBbA9OBjxVXDsTg/F
         8IcZ/ptcYzUN2b1WbgmE2Z57vSFJpPRrLulkK/heoRqb5xW8JcSD5gjhSreMCVGBIJmp
         xoYpTeoZ+Guw2u+hVFE09HniKWqhpFKViEzaz8HIxPejya9dXiGoa6VltkOEZjMisfwH
         TrUybX0iVBZQw6cxI0f9e5H4Ic9gw3Oh7M5FhYj9oUckWMvMitc8zo2FYQqqyWhtCvNn
         ywgQ==
X-Gm-Message-State: ABy/qLb9tgAu6ma15DDwui9zafP4ryiIPcD82toKmth/p3A35WnS11WB
	3AcvjUgPzh5HRmxtsbqIoo76YVIc0iKhsw==
X-Google-Smtp-Source: APBJJlEpnqUBaUBoQRM3o66/mPjx8g3HqTGmm3TaDElFRDGsxZFlJNQ8wcwawI9qU02RjAc3Fvh7Cg==
X-Received: by 2002:a05:6a20:2588:b0:12d:e596:df21 with SMTP id k8-20020a056a20258800b0012de596df21mr4557592pzd.7.1689839479480;
        Thu, 20 Jul 2023 00:51:19 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001bb381b8260sm601597plh.100.2023.07.20.00.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:51:18 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:51:13 +0800
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
Message-ID: <ZLjncWOL+FvtaHcP@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085814.4301b9dd@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Stephen Hemminger wrote:
> On Tue, 18 Jul 2023 13:19:06 +0300
> Ido Schimmel <idosch@idosch.org> wrote:
> 
> > fib_table_flush() isn't only called when an address is deleted, but also
> > when an interface is deleted or put down. The lack of notification in
> > these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
> > skip DELROUTE message on device down") introduced a sysctl to make IPv6
> > behave like IPv4 in this regard, but this patch breaks it.
> > 
> > IMO, the number of routes being flushed because a preferred source
> > address is deleted is significantly lower compared to interface down /
> > deletion, so generating notifications in this case is probably OK. It

How about ignore route deletion for link down? e.g.

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 74d403dbd2b4..11c0f325e887 100644
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
+                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
+                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
+                       }
                        hlist_del_rcu(&fa->fa_list);
                        fib_release_info(fa->fa_info);
                        alias_free_mem_rcu(fa);

> > also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
> > calls fib6_clean_all() and not fib6_clean_all_skip_notify().
> 
> Agree. Imagine the case of 3 million routes and device goes down.
> There is a reason IPv4 behaves the way it does.

