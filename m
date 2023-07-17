Return-Path: <netdev+bounces-18301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA409756589
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A544B2810D1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8ACBE47;
	Mon, 17 Jul 2023 13:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120BBE46
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:53:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01689FF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689602023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K56/Xqw2n1ZvKULuZ30MMWN4kbPwGNfcAsA3x+nB8mA=;
	b=fJS/4NKzBZ2IFjWRwY4oiTr/c0O1Kb/v16sk31Jk68Lzx3CWY9/VL6xlnSTGFyRPS47Sf4
	58+OdOt4ZaB911G4SEq4LDhEb88a4/KkHhej7HhNK/c27jl1BkBaS5JE7x41AxiBxNEIn3
	i/HqQQzMQlwZRa5gkCYXamFs9B2IHgE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Xiw9bWnvPa6UJuAWNu9Xkw-1; Mon, 17 Jul 2023 09:53:39 -0400
X-MC-Unique: Xiw9bWnvPa6UJuAWNu9Xkw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635f38834acso52280986d6.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602016; x=1692194016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K56/Xqw2n1ZvKULuZ30MMWN4kbPwGNfcAsA3x+nB8mA=;
        b=EVDuJ949aGWXLhR33k7wO/wXErfx9I9NOgQlMiG5FkfHoLLJ62p5deZc5VW9sR0IwS
         ApxDe+a/k9uo/KWaWicEtGHziwyQjoG8wfloG5cuKErer6eoEFEXjSwWf3TsHKGm10wx
         XuXIkCP2ETZx2fFU23/ZpELtdayvmK7jtVee5w2QbGAnse3xkY/nZKIlIlYqljYt7FIL
         CCQNpeDlWphUlLSurjM62z9IQ78hUohVX019RFiwHFtkn4NRZ4vJxQg61jJlXlA6N84E
         2CbXLv0GIwXo0vh2QIU3YnfQMxLN8EK0gX1n+R6S/bJpXf0Gp614wKQmbhw1LVbXd3pT
         yvyQ==
X-Gm-Message-State: ABy/qLbTL4kE/CiXWUSjmP0PMIKJI78+6g5USZM4iQaJxK5UjVIgQ3a/
	y/5TxTWAo0hNLvfIaJ0wbw0Q6CZwhWninUiNWp+xDw/DhcR2Ly5JJgQHVM21GjwHh1DSy+b/zOx
	Ch8o3sE2RDcj31tc5l0U0+uxz
X-Received: by 2002:a0c:f194:0:b0:635:5a95:bb48 with SMTP id m20-20020a0cf194000000b006355a95bb48mr12113022qvl.24.1689602016387;
        Mon, 17 Jul 2023 06:53:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFV5fomCE7nyPplywCBoISP71GTts2gOATnk7D/Tsz54T+B6cPi/kr9VTBv7MVGW3wH/asTNw==
X-Received: by 2002:a0c:f194:0:b0:635:5a95:bb48 with SMTP id m20-20020a0cf194000000b006355a95bb48mr12113012qvl.24.1689602016127;
        Mon, 17 Jul 2023 06:53:36 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cf04a000000b0063c79938606sm2541741qvl.120.2023.07.17.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:35 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:53:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	osmocom-net-gprs@lists.osmocom.org
Subject: [PATCH net-next 1/3] gtp: Set TOS and routing scope independently
 for fib lookups.
Message-ID: <239feab76be1770fd8ed43e7ce6e004a2a7f8471.1689600901.git.gnault@redhat.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There's no reason for setting the RTO_ONLINK flag in ->flowi4_tos as
RT_CONN_FLAGS() does. We can easily set ->flowi4_scope properly
instead. This makes the code more explicit and will allow to convert
->flowi4_tos to dscp_t in the future.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/gtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index acb20ad4e37e..144ec626230d 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -243,7 +243,8 @@ static struct rtable *ip4_route_output_gtp(struct flowi4 *fl4,
 	fl4->flowi4_oif		= sk->sk_bound_dev_if;
 	fl4->daddr		= daddr;
 	fl4->saddr		= saddr;
-	fl4->flowi4_tos		= RT_CONN_FLAGS(sk);
+	fl4->flowi4_tos		= ip_sock_rt_tos(sk);
+	fl4->flowi4_scope	= ip_sock_rt_scope(sk);
 	fl4->flowi4_proto	= sk->sk_protocol;
 
 	return ip_route_output_key(sock_net(sk), fl4);
-- 
2.39.2


