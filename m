Return-Path: <netdev+bounces-16849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BD74EFDE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CA0280D32
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5718C33;
	Tue, 11 Jul 2023 13:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728618C02
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:06:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F18E5F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689080794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKlrculu500+hhy1U5AOcV+R3wyEM9d5epSI3K+C/wI=;
	b=SNCEW94GrjiXUJlunIBaSeaVYEPmonunqYRk2UfIVfNb5Fo9oT8LbUKIOA0/Up5o4TjBN8
	sr0SiYcMzn0iN2MKfFVP5FKcIZ+g2wB7ahwTSDRe11eGyxqc3QzPBsyXGfbrQjQSq6rAoQ
	Xc2By2mGEfOEiZVUXSf/hqF9u/Yati0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-yB52GNoLNRa730DWq4v0GA-1; Tue, 11 Jul 2023 09:06:32 -0400
X-MC-Unique: yB52GNoLNRa730DWq4v0GA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7677e58c1bfso749491585a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080792; x=1691672792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlrculu500+hhy1U5AOcV+R3wyEM9d5epSI3K+C/wI=;
        b=J06rappNITen5peL7fxCWXc5FPMMs/XJ2+UCcfVPoyjgr8v03S6NH/QPudlN8PNsiU
         QuUWPTiaIgqJAyUF7MjrbdIpqtCnA6mW50qXGgoulhDtkN+WGi70LGtEyOMJraRu0hvl
         SIngjAD6GLCzuvbdNOLl+8uMSfCWbmRJ/QNGm2lB09flV5VGOCOPP1fz0tfd6cygAgaT
         F0ycjfJJmV81fT3wMsqfUt/IAtH5SSVC3onp2aHbtukwfpY/PBmFf2f7tfeEj30gpXKm
         8Yr5QUKINZHckGdAF8paNWg+cBnWu3i+FW81gtyqY2uPJNT+xGHq7YS+Jdr3sWDOmljv
         5nug==
X-Gm-Message-State: ABy/qLaCGzxr66UJ8S74iZNgbUJyEQqYH0fnFobUo2yEldhVkgzfiHFm
	YF9xHdB3IQLZqk09zN+aE/wWFT4NHU51pS8zpjZYCrtBC1b8teS+XYvg1+X5aV/j1zNzQrqAMdZ
	mapKxMOpulWZGz748
X-Received: by 2002:a05:622a:282:b0:403:971a:44ab with SMTP id z2-20020a05622a028200b00403971a44abmr17125152qtw.58.1689080791688;
        Tue, 11 Jul 2023 06:06:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6geKSzPbeKVKHlDVTBrbPQc0AUUpMjMzeYVNH2/7FBXJk4awgqKDePQbi8+NAGiB8ngcfIQ==
X-Received: by 2002:a05:622a:282:b0:403:971a:44ab with SMTP id z2-20020a05622a028200b00403971a44abmr17125120qtw.58.1689080791315;
        Tue, 11 Jul 2023 06:06:31 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id k1-20020ac80201000000b00403a06202c2sm1082885qtg.49.2023.07.11.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:31 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:06:26 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Dmitry Kozlov <xeb@mail.ru>
Subject: [PATCH net-next 4/4] pptp: Constify the po parameter of
 pptp_route_output().
Message-ID: <6c74dc733dbb80f7b350c7184e4dac3694922e55.1689077819.git.gnault@redhat.com>
References: <cover.1689077819.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689077819.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make it explicit that this function doesn't modify the socket passed as
parameter.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/ppp/pptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 32183f24e63f..57d38b27812d 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -129,10 +129,10 @@ static void del_chan(struct pppox_sock *sock)
 	spin_unlock(&chan_lock);
 }
 
-static struct rtable *pptp_route_output(struct pppox_sock *po,
+static struct rtable *pptp_route_output(const struct pppox_sock *po,
 					struct flowi4 *fl4)
 {
-	struct sock *sk = &po->sk;
+	const struct sock *sk = &po->sk;
 	struct net *net;
 
 	net = sock_net(sk);
-- 
2.39.2


