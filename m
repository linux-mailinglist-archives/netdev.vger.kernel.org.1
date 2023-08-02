Return-Path: <netdev+bounces-23624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6E76CC6F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920521C21256
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8A6FDB;
	Wed,  2 Aug 2023 12:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDD187A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:16:50 +0000 (UTC)
Received: from mail-lf1-x162.google.com (mail-lf1-x162.google.com [IPv6:2a00:1450:4864:20::162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF1126
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:16:48 -0700 (PDT)
Received: by mail-lf1-x162.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so6299094e87.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1690978606; x=1691583406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI0xScBewLpP69CRTitC0lTT7+EQ4m3F00K4EPi3Rvc=;
        b=Mbafs0baJURckkIHcwi0pOJ6UDeZzv5ZovlhZi8oTGUC/gXOxjLjfvTKqkXCbyMwZ2
         nyWkDOXap24VDElJYdG7iUDsu5/SOsjsisMDT0uw2jO2uabGEd1E85G2cmEEXTH0mKDG
         vuTSVqVwWTHZx7Z2b33jurtmq+2pFhvrRUkrBmx7pHsFWCCIoRdsrNhA/uSe5VhyoYJ5
         1I8gO8XHCXjtCTegTEc+2IRSleM4wTcs+nYFTXMIzd4Jah3zhK61ruCvm2gWUJPXNQYg
         p32aOmxkC7V1lMgxcbub+WERhjxwBB30A9Rgmn9i60a4ZjC2AXpchC0GKqaxYoumYjRr
         wQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978606; x=1691583406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI0xScBewLpP69CRTitC0lTT7+EQ4m3F00K4EPi3Rvc=;
        b=Kcm1pJ0ppG5BVQmyQzKS3YDZUF74v6s48mlsvzOqwnpv5QYBPnD3oipx2uDW6JfGiQ
         9v96xQWICctRaU9ZSRStauDomGNEpADy+mD45ifTC3ftRktoErRGqEhprgJXs+9aO2yU
         ZiclSlwGTUSREsx8FOHmOvcYzG7lW6G7usZBnPZdfEU9j98a9lWRR5ayY7JwoJ6vuuWR
         EZzPPkX/54XnzLrrf3KlOu3Tkqo9LnYGPzQYoefMPh//heWjPWRFSKddRO8O+h8AIR9p
         1MT5MV5ylaqQqVD/LMr9BmyoPCynBURbR06cJLu42z2tUGresFGakndHapP1N0+8pv29
         KcRg==
X-Gm-Message-State: ABy/qLb9H2StNPccKoIGfQnCdwK4WpX2i8MsUOgVZ0UxVyqJXdgWwn2D
	kzUTpymAWqhYRZ6i+ZZcmUjdvdvKFDz3udunzaYSzqWWAhNTnQ==
X-Google-Smtp-Source: APBJJlE48gCCETGUTzl7w+GwHpvtWhiyjXW+/IDQTPtJtflWvIY+F//loA9GYiYXlZQ2AkOWG4isovje9bGf
X-Received: by 2002:ac2:58c9:0:b0:4f5:a181:97b8 with SMTP id u9-20020ac258c9000000b004f5a18197b8mr3787757lfo.25.1690978606213;
        Wed, 02 Aug 2023 05:16:46 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a26-20020a17090640da00b00993ad4112f7sm1949585ejk.260.2023.08.02.05.16.46;
        Wed, 02 Aug 2023 05:16:46 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D8FFE60036;
	Wed,  2 Aug 2023 14:16:45 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1qRAmT-00Cgt0-In; Wed, 02 Aug 2023 14:16:45 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date: Wed,  2 Aug 2023 14:16:14 +0200
Message-Id: <20230802121614.3024701-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This kind of interface doesn't have a mac header. This patch fixes
bpf_redirect() to a ppp interface.

CC: stable@vger.kernel.org
Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 1ed52441972f..8efbe29a6f0c 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
-- 
2.39.2


