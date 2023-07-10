Return-Path: <netdev+bounces-16591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E774DF06
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FAF280BDA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238C154A4;
	Mon, 10 Jul 2023 20:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C014273
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:17:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87ABB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689020250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MatPkdlfWwwrlUu3EVslUzYwQyXM940i5KEhzgEgAcU=;
	b=RD+hDi9cpwOmhPSzV/tdg0/baATuWNefhMompjAqVSuZ4QytETaisOeHxZt0owdZC7ys+u
	7px/Q50prhgEOFo6e2Gi5o3D+hMswORxkyC09mG20TG6WHDu6wKOfoHj1Hgu9GSzm2jKX4
	UtxYzTrE38izrpgcaKfY4tJu8FXOKsg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-P-JMhA96Pf-C3XCSHk6R8Q-1; Mon, 10 Jul 2023 16:17:29 -0400
X-MC-Unique: P-JMhA96Pf-C3XCSHk6R8Q-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-57704af0e64so56990327b3.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020249; x=1691612249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MatPkdlfWwwrlUu3EVslUzYwQyXM940i5KEhzgEgAcU=;
        b=EkKKn4+aem5gsZBAPE47EkYWET0Uuy+ZdYpl6G8nYcUT8rAS2v9bVX1grc/AuNN/WS
         D2oSOj8ebYB7Z4/1XLcoa8K/516aUHjY8y4GM7Ewm4RVmdf4R0JKhxFW0PC9aFr5Czsp
         DzXX5GJyV7prmMxvAK+cW77H5lo0s1+9Q5UbJm3kvdJOYY9gICznScSMrHb4DmtHC8i2
         gERM6BQ8e5PW6LS9Q0YP404g8AUWXRArNlUQASU4gg5hEr7VcIPZeYM2RQvjhWjnoJIc
         6GLbgQkuptPVOI1TDmDHtp+Vg8lLSkijR1fgx8NMZRwjgfcCDFiWGBMmF8KR1Ax2k+vG
         PPaQ==
X-Gm-Message-State: ABy/qLYFrFFTLcaHspxXrEYwU9EfyFzXdNFWNO8NEz4vDM05HG+yXRIP
	mrVQ4sXrcGgI6by5ACfwOB74hKHcRmxnOd723Apv0g5XrhyhVR6TBMuEgH7/9Hn00lUjIsr6PDu
	S85jNqFOjZ1eQVGdp
X-Received: by 2002:a81:4995:0:b0:569:e7cb:cd4e with SMTP id w143-20020a814995000000b00569e7cbcd4emr12772035ywa.48.1689020248800;
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHyRJxkGXCriSJqC1waS5qykotJRzMqF5zfNpiybzK4XMv35z9jl2wuOjlnU4LLJpYREhCLgA==
X-Received: by 2002:a81:4995:0:b0:569:e7cb:cd4e with SMTP id w143-20020a814995000000b00569e7cbcd4emr12772020ywa.48.1689020248527;
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
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
	andrew@lunn.ch,
	simon.horman@corigine.com,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: dwmac-qcom-ethqos: Improve error handling
Date: Mon, 10 Jul 2023 15:06:36 -0500
Message-ID: <20230710201636.200412-1-ahalaney@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series includes some very minor quality of life patches in the
error handling.

I recently ran into a few issues where these patches would have made my
life easier (messing with the devicetree, dependent driver of this
failing, and incorrect kernel configs resulting in this driver not
probing).

v1: https://lore.kernel.org/netdev/20230629191725.1434142-1-ahalaney@redhat.com/
Changes since v1:
    * Collect tags (Andrew Lunn)
    * Switch to of_get_phy_mode() (Andrew Lunn)
    * Follow netdev patch submission process (net-next subject, wait
      until merge window is open) (Simon)

Andrew Halaney (3):
  net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over
    device_get_phy_mode()
  net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
  net: stmmac: dwmac-qcom-ethqos: Log more errors in probe

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.41.0


