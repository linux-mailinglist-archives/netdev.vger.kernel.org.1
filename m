Return-Path: <netdev+bounces-23537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4B76C617
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705BB1C21242
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92491C35;
	Wed,  2 Aug 2023 07:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8562112
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:05:18 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3191B4
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:05:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-268b3ddc894so2055416a91.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959917; x=1691564717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO8vAVzgN6IG55jyyopFY9yJYNXdSCCieL6b42ixNX0=;
        b=O7DH0O7KZXU1xqzyitLBzpjU9fDWy9gmJSdUJBcqNhBIAZYo/OQuctnhixis1tcGDs
         cEmn3xhen75jF8SiFAifXt3DVIUJba5L03QO/scEt+zBh+B/lcMpMtheWkLK2Rzo6HXd
         8AxUqZI1MlZR5wZODcH+yiAm43Q/NMIkOVfm7JcCZTs6G7TYOoz9r4UGIZ/hemV4jhkd
         2b/46nCC05KEQvdRd+C+EngXmOncjRF5aOUn4ldrjoksXKY2EVmAkmWBuTIggZnLQwi1
         T5wykHmOx6FTA61500k6K9hW6YrATKJQtLJNn5q7Z+PpPHLB/+BaZn61gYRrB5G02GuH
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959917; x=1691564717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO8vAVzgN6IG55jyyopFY9yJYNXdSCCieL6b42ixNX0=;
        b=K+0t4JszBjLb6icyTox3dlK1JvnuJ2d4cHZ47Aor+1J0fWA+jbB1+GzfLsr5A1VSHS
         eceLpqKJSK6alAVmLoTNeuvyrfrgdrM01I1/syZ53cp2p/CDq/dXJ+RuRwtOygyVFbPn
         pkBfxtwfs+EljOrg9gdDZjfpFfk1ZGufDyDFINyvL7UpnVg+Oj+LNGlhKu1VMG5lSndk
         vY64Ngf/Gto4odA35eNVk6ZOIuLm9gOrHO2/sd8f4Bdje9Grb8x5YpU2G9ZRATIPsWKq
         v98r3ZGFyaJW5d9ItSHRG6i045IMCxieEqYdKYaKNLTsiyn7u0elah3aJTLmiUcJtto7
         qPVw==
X-Gm-Message-State: ABy/qLZiTy/o/IbFQTIs1DA7l1VIrtydwYk0tuskGrqF+zCaPfLiJ0MP
	0KyRJRCLPK+lvcCnPtpjKrY=
X-Google-Smtp-Source: APBJJlHN0CQ3lvmmbDxe/kxtkiOF/VvyOEIHIfnodBKURUl2XWJW5Q+Ua3pTZmaCr87KxTS7NzWSgA==
X-Received: by 2002:a17:90b:1c84:b0:268:557e:1848 with SMTP id oo4-20020a17090b1c8400b00268557e1848mr13057098pjb.2.1690959916853;
        Wed, 02 Aug 2023 00:05:16 -0700 (PDT)
Received: from localhost.localdomain ([107.172.242.4])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm3901303pjj.1.2023.08.02.00.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:05:15 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ilias.apalodimas@linaro.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
Date: Wed,  2 Aug 2023 15:04:54 +0800
Message-Id: <20230802070454.22534-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the generic XDP processing flow, if an skb with a page pool page
(skb->pp_recycle == 1) fails to meet XDP packet requirements, it will
undergo head expansion and linearization of fragment data. As a result,
skb->head points to a reallocated buffer without any fragments. At this
point, the skb will not contain any page pool pages. However, the
skb->pp_recycle flag is still set to 1, which is inconsistent with the
actual situation. Although it doesn't seem to cause much real harm at the
moment(a little nagetive impact on skb_try_coalesce), to avoid potential
issues associated with using incorrect skb->pp_recycle information,
setting skb->pp_recycle to 0 to reflect the pp state of the skb.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 10e5a036c706..07baf72be7d7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4934,6 +4934,8 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 			goto do_drop;
 		if (skb_linearize(skb))
 			goto do_drop;
+		if (skb->pp_recycle)
+			skb->pp_recycle = 0;
 	}
 
 	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
-- 
2.40.1


