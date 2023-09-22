Return-Path: <netdev+bounces-35864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92F7AB6A3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8EF6E28217C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B041E49;
	Fri, 22 Sep 2023 17:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D091EA77
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:00:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A07198
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695402003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nfMgSZq58g3qrYeg5vo/uyeqKNdUVkirqKpqK2sv3uU=;
	b=CgGaMQjQv+kReLQEH0XT09jkA0/2SpXFhrVqEoL4GBdrGM6n90l61+gvqJlkxdohB5ofZ4
	1WRRlGsqINVOr2bGkgzMu0WBOBWF75miP93BTc8Hk0vDhcJUbOBHSvpaMidMLVBkX/jNZ4
	DXdjHerlO+Sz5WUEf6chXV6uIQKmz20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-wDuNaNtANRG64eGiyQ-nuw-1; Fri, 22 Sep 2023 13:00:02 -0400
X-MC-Unique: wDuNaNtANRG64eGiyQ-nuw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe1521678fso18631325e9.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695402000; x=1696006800;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfMgSZq58g3qrYeg5vo/uyeqKNdUVkirqKpqK2sv3uU=;
        b=cUwR32SB1ksSkSEqpBQGB5Nr/umEGCxLY853ns+u8GHTHTcQnMfa+9oRs5WLdm6lLp
         tVRrEmAq5ig3DGKU4lhTwvxmVImgeqbpMv+/kbJfnPOV4rgHXRkYbkGulLdJjBZ+L8bc
         zLiFnmoib0mpkOSlFSJ8rvSHx2Gb+gIAMIRoTTJsHKxRHqLrWqZl5JjyU7fey9qqtGp6
         a2wgjyXgvwGwQVwFbBcoXINJmo2Fo41b/KoOpnSMpmGrGKnDWl8JeF3G2CLX9d1WTbfw
         2Dpjqncix5HNIMNbI1B97Ys/gvHbYiVZju4TgqOuR9jSuHkGxqHyAKHqKMuuvoKrkXRn
         6qwA==
X-Gm-Message-State: AOJu0YxGXxFUu9BQE7aqVSN5AeOXilPuAi7f0iZ22jPycjSzkl7JYCw1
	rCUwMP+Hui/2Es2KAZKb/mkRKdNKDW89veB2hdFAZ3dy6sLhdYCvmarhnEjof8V9yl6hp6GSfU7
	193edGR2qvuN2q/WThkgQx1AR
X-Received: by 2002:a7b:cd12:0:b0:401:bdd7:499d with SMTP id f18-20020a7bcd12000000b00401bdd7499dmr8665933wmj.25.1695402000361;
        Fri, 22 Sep 2023 10:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAAroBXJmlMBoAzInDqt+++kcg+0fXJeGaQXbLHDK+j0t441SxRcDmnZ5vffvNAvLikFDLcw==
X-Received: by 2002:a7b:cd12:0:b0:401:bdd7:499d with SMTP id f18-20020a7bcd12000000b00401bdd7499dmr8665914wmj.25.1695402000025;
        Fri, 22 Sep 2023 10:00:00 -0700 (PDT)
Received: from debian (2a01cb058d23d600e398941248bfb832.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e398:9412:48bf:b832])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b00401d6c0505csm5086177wmc.47.2023.09.22.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:59:59 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:59:57 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <099adf0eac09ba8227e18183a9fae6c046399e46.1695401891.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Walk the hashinfo->bhash table so that inet_diag can dump TCP sockets
that are bound but haven't yet called connect() or listen().

This allows ss to dump bound-only TCP sockets, together with listening
sockets (as there's no specific state for bound-only sockets). This is
similar to the UDP behaviour for which bound-only sockets are already
dumped by ss -lu.

The code is inspired by the ->lhash2 loop. However there's no manual
test of the source port, since this kind of filtering is already
handled by inet_diag_bc_sk().

No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
socket, bound respectively to 40000, 64000, 60000, the result is:

  $ ss -lt
  State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
  UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
  UNCONN 0      0               [::]:60000         [::]:*
  UNCONN 0      0                  *:64000            *:*

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/inet_diag.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413..de9c0c8cf42b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1077,6 +1077,60 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		s_i = num = s_num = 0;
 	}
 
+	/* Dump bound-only sockets */
+	if (cb->args[0] == 1) {
+		if (!(idiag_states & TCPF_CLOSE))
+			goto skip_bind_ht;
+
+		for (i = s_i; i <= hashinfo->bhash_size; i++) {
+			struct inet_bind_hashbucket *ibb;
+			struct inet_bind_bucket *tb;
+
+			num = 0;
+			ibb = &hashinfo->bhash[i];
+
+			spin_lock_bh(&ibb->lock);
+			inet_bind_bucket_for_each(tb, &ibb->chain) {
+				if (!net_eq(ib_net(tb), net))
+					continue;
+
+				sk_for_each_bound(sk, &tb->owners) {
+					struct inet_sock *inet = inet_sk(sk);
+
+					if (num < s_num)
+						goto next_bind;
+
+					if (sk->sk_state != TCP_CLOSE ||
+					    !inet->inet_num)
+						goto next_bind;
+
+					if (r->sdiag_family != AF_UNSPEC &&
+					    r->sdiag_family != sk->sk_family)
+						goto next_bind;
+
+					if (!inet_diag_bc_sk(bc, sk))
+						goto next_bind;
+
+					if (inet_sk_diag_fill(sk, NULL, skb,
+							      cb, r,
+							      NLM_F_MULTI,
+							      net_admin) < 0) {
+						spin_unlock_bh(&ibb->lock);
+						goto done;
+					}
+next_bind:
+					num++;
+				}
+			}
+			spin_unlock_bh(&ibb->lock);
+
+			s_num = 0;
+		}
+skip_bind_ht:
+		cb->args[0] = 2;
+		s_i = num = s_num = 0;
+	}
+
 	if (!(idiag_states & ~TCPF_LISTEN))
 		goto out;
 
-- 
2.39.2


