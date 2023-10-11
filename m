Return-Path: <netdev+bounces-39813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17577C4893
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EE4281E8A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5740CA5F;
	Wed, 11 Oct 2023 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axGWzn8h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B5D2E3
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:30 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D394
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ae2896974bso4385541b6e.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995868; x=1697600668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG0lTECjijmEFm9e9LYjeMTQQ21OTNTMYQZ13fnzpuM=;
        b=axGWzn8hiUh+VppaJb9gJp8LfGPRDN9YmF4pNUE8l9zQO2RbauZLxlP9V9DUjH1FZM
         tiapdNpFstjlAGu/zlrzIZJ/zilkQMzaNzyOOGUMWaj/nSvib+PmHfVIpW8t+2HFV5N7
         bdYtar/9RtShmQ4Gn/c54hgRPInun9QhyIMjBrpa+1kTxmqEUeCU92kNuh4+xV5N4HI+
         FourD7bjQbwB91vPnE2lY6SDJqB8A7UN0VtiyOH7Yj7Sn4TDm+0S0HtT5mBUc3U+XdF8
         qFTMHXwkhJkTIgtKj6+t4nFtjMy6PgSA8EiSdGAtvBd8O+on6koj8jZYYJkyLfsIHbad
         VlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995868; x=1697600668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG0lTECjijmEFm9e9LYjeMTQQ21OTNTMYQZ13fnzpuM=;
        b=DNNfSEi4lU12NVv4EzicRHiAwlH+v9JC0z0tsY8I46qZ1awYp2ANbg/YZdHD0lW+iV
         uhr315rGge2r94zRnXiaSJ3Vx+p6ubM7ThYMEYpBSRbMOevZp493FKnDi1Y7bSFDjqTQ
         JBq4ODgdEqn46XrpbGXqcy4mSxd0YC7AqUUqNEPqPzu72+2iUi5OkeWco9OtMkV0Ogh8
         7eXsJYfbdROgePnRlIMfcgamS3amoCSeu3fucVifjQarbczI5tkpcdAEjKurTIh9cCBb
         yL82ZDttXSo0XLd1apyreaoQWrNQcOSmwqQIbenTyciydrrdrDiQteeI+Y1ANCKepYe+
         Ektw==
X-Gm-Message-State: AOJu0Yxzxne164/cuELMbvyTvLbhWlFw7xc3sT2mqXsa/0+fLwVBiTP6
	FEweKSCWZAfRxQVUHsq2TBhU0RRPcpBELg==
X-Google-Smtp-Source: AGHT+IFB+t2SmAwSL29E78ppnJwERh8c1+2v+39QdJb3/4uEQO7vQ9u/QRkvikRsqeYPhd8K3UL+sA==
X-Received: by 2002:a05:6808:152a:b0:3a8:6a03:c0c with SMTP id u42-20020a056808152a00b003a86a030c0cmr27307955oiw.27.1696995868320;
        Tue, 10 Oct 2023 20:44:28 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 6/7] net: openvswitch: uninline ovs_fragment to control stack usage
Date: Wed, 11 Oct 2023 13:43:43 +1000
Message-ID: <20231011034344.104398-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011034344.104398-1-npiggin@gmail.com>
References: <20231011034344.104398-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ovs_fragment uses a lot of stack, 400 bytes. It is a leaf function
but its caller do_output is involved in openvswitch recursion.
GCC 13.2 for powerpc64le is not inlining it, but it only has a single
call site, so it is liable to being inlined.

Mark it noinline_for_stack, to ensure it doesn't bloat stack use in
the recursive path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 87ec668d5556..ef3a59012d26 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -900,9 +900,9 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	skb_pull(skb, hlen);
 }
 
-static void ovs_fragment(struct net *net, struct vport *vport,
-			 struct sk_buff *skb, u16 mru,
-			 struct sw_flow_key *key)
+static noinline_for_stack
+void ovs_fragment(struct net *net, struct vport *vport, struct sk_buff *skb,
+		  u16 mru, struct sw_flow_key *key)
 {
 	enum ovs_drop_reason reason;
 	u16 orig_network_offset = 0;
-- 
2.42.0


