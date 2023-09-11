Return-Path: <netdev+bounces-32834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF979A86C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C425D28116C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33711711;
	Mon, 11 Sep 2023 13:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0F1170F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:58:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D359DCE5
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694440724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A36/jUHiNm3kPuZ+L53KLWDeRgfIZbwcm1XGDxvpiWs=;
	b=DTRfODe2MwKc+zVv6y3/QBAfYP81+n0lxrdYzv/J8OK5/s+8dSJrkb/ZLssOlaqML6gjVt
	7qcOt8ngopDPCxDufrQ8qtIxqJuhNks9tDa3Ia5I+ulNe9MqWajBjDBSauVYgGk1IEVTLW
	6gVCA7MVkA6IGXVjjSjjifpbzfO4oxs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-w7jGQg0_OQ-Hyc8Nbx3AaQ-1; Mon, 11 Sep 2023 09:58:43 -0400
X-MC-Unique: w7jGQg0_OQ-Hyc8Nbx3AaQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b961c3af8fso49275061fa.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440721; x=1695045521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A36/jUHiNm3kPuZ+L53KLWDeRgfIZbwcm1XGDxvpiWs=;
        b=E065wzoBesUEq8yIjG9y/GMIsC5stWwSKC2dhePiRdzEQpCWq2mTYh1LWVzv9aX08B
         Q+w0H471nuwrELoxP8wPmOjo/8VhxB8VzfHE4TFPy0dc5dO/i5+LumQUJ778MIrbVqFC
         frZ9qd1eh0J4enBXgwk9wozqLVWV6rfRKMIp67ireESQ/tn+Y6/gNGWlHro4T1huqRhr
         xcYXusU8xL4ZEVcelQ69CKjZlcajcAjmeDMMdE7QM4EJBwbWn7Y0L+rStwqF3DD2aTez
         ZRQuar2en53k/mhz6QQhlUIKKIxXJbYForEAe+Pd8j5JgLYZF3TqvcxGqbnyJCkHWNGl
         8dsg==
X-Gm-Message-State: AOJu0YyWTXRPN2vPOLWtnHafw4BfyjvUa9509FUeG8ukF/r9PaXda2Gq
	4rWNrq8s/qYSgK9BQ6z/DpBlQoc9EDAr63pf25DZLbH13aeFy51KjMFqhyp1ZsNkQPu/bymIkyM
	7RdsRIm8+h+o4OAIH
X-Received: by 2002:ac2:4ece:0:b0:4fc:3756:754e with SMTP id p14-20020ac24ece000000b004fc3756754emr6711879lfr.56.1694440721086;
        Mon, 11 Sep 2023 06:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCdjrohb0Z6US6Uo0TPXg4UkXz9wIkaXq+F/rQatOYdo18Jpk+r9G7b3qDcWRWtJh0gCDxlg==
X-Received: by 2002:ac2:4ece:0:b0:4fc:3756:754e with SMTP id p14-20020ac24ece000000b004fc3756754emr6711866lfr.56.1694440720669;
        Mon, 11 Sep 2023 06:58:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sb1-20020a170906edc100b009a1c05bd672sm5362988ejb.127.2023.09.11.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:58:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D42BADC70F5; Mon, 11 Sep 2023 15:58:39 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Marek Majtyka <alardam@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] veth: Update XDP feature set when bringing up device
Date: Mon, 11 Sep 2023 15:58:25 +0200
Message-ID: <20230911135826.722295-1-toke@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There's an early return in veth_set_features() if the device is in a down
state, which leads to the XDP feature flags not being updated when enabling
GRO while the device is down. Which in turn leads to XDP_REDIRECT not
working, because the redirect code now checks the flags.

Fix this by updating the feature flags after bringing the device up.

Before this patch:

NETDEV_XDP_ACT_BASIC:		yes
NETDEV_XDP_ACT_REDIRECT:	yes
NETDEV_XDP_ACT_NDO_XMIT:	no
NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
NETDEV_XDP_ACT_HW_OFFLOAD:	no
NETDEV_XDP_ACT_RX_SG:		yes
NETDEV_XDP_ACT_NDO_XMIT_SG:	no

After this patch:

NETDEV_XDP_ACT_BASIC:		yes
NETDEV_XDP_ACT_REDIRECT:	yes
NETDEV_XDP_ACT_NDO_XMIT:	yes
NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
NETDEV_XDP_ACT_HW_OFFLOAD:	no
NETDEV_XDP_ACT_RX_SG:		yes
NETDEV_XDP_ACT_NDO_XMIT_SG:	yes

Fixes: fccca038f300 ("veth: take into account device reconfiguration for xdp_features flag")
Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/veth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9c6f4f83f22b..0deefd1573cf 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1446,6 +1446,8 @@ static int veth_open(struct net_device *dev)
 		netif_carrier_on(peer);
 	}
 
+	veth_set_xdp_features(dev);
+
 	return 0;
 }
 
-- 
2.42.0


