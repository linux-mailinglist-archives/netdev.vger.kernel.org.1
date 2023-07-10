Return-Path: <netdev+bounces-16579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E246974DE9D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A141C20B6D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8B14ABE;
	Mon, 10 Jul 2023 19:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAEFC09
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:53:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B021A8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689018782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gy/vSNQrD1I/JzE/a01WIAugyPEbnbITAis3wuB31bs=;
	b=aan28VfYjxfn0pZ9h5rLXwCnT59glfV/fnMpjmzK0kGXK4ICnM6lkPzDX1uYuaK0cqj7YP
	uTemOP5bCP+XAB9Dy0fsDwZPdoyMN0++8RxuM1I/UcEO7xEJn9M8mR9W3Kg9hucgPNtLqt
	5WQG6o/qpFV+2yHDlN3ne/OrIG5gO90=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-BAGkf_MKOKCKt3gXtKR2Ig-1; Mon, 10 Jul 2023 15:53:00 -0400
X-MC-Unique: BAGkf_MKOKCKt3gXtKR2Ig-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a4074304faso898382b6e.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018779; x=1691610779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy/vSNQrD1I/JzE/a01WIAugyPEbnbITAis3wuB31bs=;
        b=L++K6F2p9iTEkphBf0VpDWgtSYF8vDhKBcT6RrHF2FNJrRGEekAPRieWDS/ytzH6XG
         nmuRE8q042DoSQ9WYBVbta3Xk8187ltiJRtBw8BL8W2xUmeDV5DvaU5Z4Up84Mhz4ZSH
         3vQkTKPIXKGYZF+xMx5AZrvFU0aTSl9Iatd/NOB7njiin+JmU7/L9nZc4xKXO2xggYMf
         KM0Ne4YYdlO0Vppoq+KRrp0zt8OFD1sfryWIcvOGhUkOB+xAbf6YI+K+iSalKam9XNMM
         etY6FD2XcGNiZ/mOjmfvBhqN45OO58WmONxlUzqGUGikvqd7r7WHn2ov/Jc25ExbB9mU
         WAZA==
X-Gm-Message-State: ABy/qLYpTM5bIarh7Pjm82pkT7XNVWq7nt5AH1o8Ebo9WiB3eCQqMnzc
	6OIjIOtrC73LtJeNQwG1xZDVIFit8+lSlLFamme66naBGYgBboGZ3h13paIQsK1DRmiJmM4Fxsp
	KvbuhcKTWGBOa1TNtZnjScAl3
X-Received: by 2002:a54:449a:0:b0:3a1:dd1e:a726 with SMTP id v26-20020a54449a000000b003a1dd1ea726mr9887204oiv.44.1689018779412;
        Mon, 10 Jul 2023 12:52:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfk5sAu+Gz4ewFF0ZgHQ4JXru7kUigoww2rD7ehqaN1ZIbUUPXVTG7Kygn3sRVlp5C3Ukyjg==
X-Received: by 2002:a54:449a:0:b0:3a1:dd1e:a726 with SMTP id v26-20020a54449a000000b003a1dd1ea726mr9887189oiv.44.1689018779163;
        Mon, 10 Jul 2023 12:52:59 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id r23-20020a544897000000b003a3d273aef8sm274972oic.6.2023.07.10.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:52:58 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	joabreu@synopsys.com,
	alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org,
	vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next] MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DRIVER
Date: Mon, 10 Jul 2023 14:50:57 -0500
Message-ID: <20230710195240.197047-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

linux-arm-msm is the list most people subscribe to in order to receive
updates about Qualcomm related drivers. Make sure changes for the
Qualcomm ethernet driver make it there.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f115c355a41..e344af30e7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17541,6 +17541,7 @@ QUALCOMM ETHQOS ETHERNET DRIVER
 M:	Vinod Koul <vkoul@kernel.org>
 R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
 L:	netdev@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
-- 
2.41.0


