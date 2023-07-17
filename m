Return-Path: <netdev+bounces-18302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A675658D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AA51C20A45
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF81BE4E;
	Mon, 17 Jul 2023 13:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9ACBE49
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:53:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03389103
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689602027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FaL2wcUnzSu1vhXihNYR8wHXoQel/dQpHY6Vim2NOYE=;
	b=aEo0lUZQqqFd3Z7SFmj1ZIxyk19c2CNSoGibUTRzMfi6e96pAqQR/z96udh+SQbxol8Ny0
	gDQOIATOSWMMwJtzvC3fQzXdZV11OzDOEdr14y3PWbbQ6jMobtZrjCm4CIam8OK1+8vN2c
	1zXRl9qd0AVhrBzV+p4TAN/T7OMhyVk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Z1lFuUU_M9K5pJHd-3lvDg-1; Mon, 17 Jul 2023 09:53:46 -0400
X-MC-Unique: Z1lFuUU_M9K5pJHd-3lvDg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7679e5ebad2so692804485a.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602025; x=1692194025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaL2wcUnzSu1vhXihNYR8wHXoQel/dQpHY6Vim2NOYE=;
        b=KlKom7NKK3DmBJF46ITVgtDbYinO3tBrCBjjBh4/5yDx7/628hREFFKheJxUNQ+FAV
         8MRNr/x31WwLfFnltoKTVvIRnR6y5xEsxDKDl2MXHsDCuCjwUYf0PfBh2BN+Y6Hz6cnV
         BGLd3C62fSLG2DoBFlhPWckX+TFha4Oy2Zsy6XrYpg9jqmzFajYRc8GkCsMZ6odVojEs
         yEW5/RFkBXQ3wAjIzsOyWzkWpxPuF1g/093fa24brXz2I8xa6ItlJkZX+dYSIJg5OqHv
         YGkQUlZpM684GpEC0Rg8zYOINzrPVrebObB0IeNfcXlWiX0f0lMFfn1bLpIAvfwYZIjb
         TLXw==
X-Gm-Message-State: ABy/qLYTeP359WC5YxE9lP3wrohGqYLNAdu8JFWXWjJnoNwn24tV5TeS
	YrUsJOCHzVYCcYfF+YytNfufaFrL79VEQXaCISUKW2k07w55CtclgMqQ4wj49/BQECgfwD1dpz3
	DSYUBRWzNzUV1wwfy
X-Received: by 2002:a05:620a:1a90:b0:768:1e31:db83 with SMTP id bl16-20020a05620a1a9000b007681e31db83mr4067794qkb.17.1689602025553;
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGweCsSR9gCfZzTn6i1Ji1R15Px6FwQk49TxS1l0nFmF1AM1O1d+wX5CSPTKaBcC3vqMulNxg==
X-Received: by 2002:a05:620a:1a90:b0:768:1e31:db83 with SMTP id bl16-20020a05620a1a9000b007681e31db83mr4067777qkb.17.1689602025324;
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id pe20-20020a05620a851400b00767502e8601sm6134375qkn.35.2023.07.17.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:53:40 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Subject: [PATCH net-next 3/3] sctp: Set TOS and routing scope independently
 for fib lookups.
Message-ID: <8ecb4d62fea0ba72bc8a5525d097b36a6c6d0b32.1689600901.git.gnault@redhat.com>
References: <cover.1689600901.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689600901.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There's no reason for setting the RTO_ONLINK flag in ->flowi4_tos as
RT_CONN_FLAGS() does. We can easily set ->flowi4_scope properly
instead. This makes the code more explicit and will allow to convert
->flowi4_tos to dscp_t in the future.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 274d07bd774f..33c0895e101c 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -435,7 +435,8 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = RT_CONN_FLAGS_TOS(asoc->base.sk, tos);
+		fl4->flowi4_tos = RT_TOS(tos);
+		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
 	}
-- 
2.39.2


