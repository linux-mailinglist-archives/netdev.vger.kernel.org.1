Return-Path: <netdev+bounces-20742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10060760DAF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D921C20CEA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDBA13FE3;
	Tue, 25 Jul 2023 08:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DC7486
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:55:19 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501141BEE
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:54:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso53942187b3.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690275294; x=1690880094;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/B/cwBITrcp6YMK1dYqIGTxmL0cVgD8ah6GakAHUfE=;
        b=4r+2Vv2lkO5XxAaE7r208KlJTD9Yq3ahzvvFWm4CLqyBhITlnDDZtKbRSyWRoPGp5M
         L0jFRi27SyD8HOvVCVDoeJJRsPElH+2wWGGW5rmHADOVDMo2g7tYWkEjta9e9KCPEAu9
         oQxsaaf9CK/4qIeCpw3Z2/sObRse+403srhicgpB2vB1Cl6YwwDg0FHFbRvWym3LT/mC
         64ZlVe9iIExM3emKABjKJVWEda68s993pgBtafRmN6AZALGp5cPNSWgiNBtxyOehLhg3
         uWlWk0yZ6iDf7bDg8dpR3siULbdE+GbV/3jgza14Acv+iqfq5pZkCsg9gdu6qTTYKd4c
         h8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275294; x=1690880094;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/B/cwBITrcp6YMK1dYqIGTxmL0cVgD8ah6GakAHUfE=;
        b=ZbCB769N9bE3enTW3jCi6ll5+EHVu6Kym6nLlbWEf75l7Q/48OK4exPLxFVd3wwMFl
         cLOBcttwVV/N8jTFlG109PlhqhD+2vY6KcMF5FLyR3UILz93f7eU9MvHVHBOU3N+uI+G
         KU3JyP14wNamKxL1b9TXTgd2bncBgryV3bPPSy+xlpy2+7tgHp+cC+gA/4paLEXGzdes
         h40Nl7LHstQ4YTTp7p5tB8D14SCwrtL906KZk0QfwxZ5NUMQ+ipb1T9S1/cjGni4yTAa
         +gslUmvT8odJakmQ3lpdr8lkKCpzM6ZGclSOSWtFf0E5BjrLJCef7snQw2F5k1hzXUGx
         ooEA==
X-Gm-Message-State: ABy/qLYrsIqDX54iPrRWJ/ZEQsJD1ojgf/0jTJ3tpeBJFh2MKmeBJWot
	Y17nx8WYAZRluAyEZ1JtvZwUyJUP
X-Google-Smtp-Source: APBJJlEKmek+a6BKsm9iBt6wCMVu+64Bu2bNSSZrAcuXfo7sY2IfQJKVXVC0wRNo5F3jIb3uaJE+bqk3
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:b5af:c23f:2354:ac])
 (user=maze job=sendgmr) by 2002:a05:6902:1369:b0:d12:eab5:5130 with SMTP id
 bt9-20020a056902136900b00d12eab55130mr27484ybb.13.1690275294451; Tue, 25 Jul
 2023 01:54:54 -0700 (PDT)
Date: Tue, 25 Jul 2023 01:54:43 -0700
Message-Id: <20230725085443.2102634-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH netfilter] netfilter: nfnetlink_log: always add a timestamp
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Compared to all the other work we're already doing to deliver
an skb to userspace this is very cheap - at worse an extra
call to ktime_get_real() - and very useful.

(and indeed it may even be cheaper if we're running from other hooks)

(background: Android occasionally logs packets which
caused wake from sleep/suspend and we'd like to have
timestamps reliably associated with these events)

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/netfilter/nfnetlink_log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index e57eb168ee13..53c9e76473ba 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -470,7 +470,6 @@ __build_packet_message(struct nfnl_log_net *log,
 	sk_buff_data_t old_tail =3D inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
-	ktime_t tstamp;
=20
 	nlh =3D nfnl_msg_put(inst->skb, 0, 0,
 			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
@@ -599,10 +598,9 @@ __build_packet_message(struct nfnl_log_net *log,
 			goto nla_put_failure;
 	}
=20
-	tstamp =3D skb_tstamp_cond(skb, false);
-	if (hooknum <=3D NF_INET_FORWARD && tstamp) {
+	if (hooknum <=3D NF_INET_FORWARD) {
+		struct timespec64 kts =3D ktime_to_timespec64(skb_tstamp_cond(skb, true)=
);
 		struct nfulnl_msg_packet_timestamp ts;
-		struct timespec64 kts =3D ktime_to_timespec64(tstamp);
 		ts.sec =3D cpu_to_be64(kts.tv_sec);
 		ts.usec =3D cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
=20
--=20
2.41.0.487.g6d72f3e995-goog


