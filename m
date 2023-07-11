Return-Path: <netdev+bounces-16959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1074F96A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3F71C20D92
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8381EA7B;
	Tue, 11 Jul 2023 20:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDA171D9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:58:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A310F1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689109086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+hIo3oC9fPc83S0WFvpQBdDffxEHtx3wU0gPObo34Y=;
	b=jShkMvC1mmDl0s1nKINgK6oDVXOEyQDPBc0+401fmwBL97ifb2yfwjQRPI8mBQ78V46twY
	UGU8wK+AC+OnjJHA8sSySYvFjphQiFJm3ZyO5iTRNAwnDzbU/e1+35aRgN4FlzI5gxo9d6
	8kUVXauisU6/MuCICp0HZ+Q+TOi+fws=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-o7uOVVvFNrSCT86nGp92dg-1; Tue, 11 Jul 2023 16:58:03 -0400
X-MC-Unique: o7uOVVvFNrSCT86nGp92dg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-57a3620f8c0so50125317b3.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109082; x=1691701082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+hIo3oC9fPc83S0WFvpQBdDffxEHtx3wU0gPObo34Y=;
        b=Owsa7NmMBfbyev3diJLSCEL0hmvQXDeBFLAyliM7XA+TUGcjAWftRrDlUZKJNfAEcT
         eQuou2r0Ckq/5ojCtbnPQUTYRiElXisi7L3zFgBL+5BiZwoHIwhZf5b5UaFYL0cBOeF3
         ndnJIi7o+NLqL8NHp4VMQxRrpb6Bn+uMecirEZ+00m2f//DJHCuQe186Yg+LYIYDM2o5
         0BOkfkRIX6AZQY7Ax6ErPCzPBhaLmCI2gcGwslk/S59MsMvNEgwGz7onpKihFZJXfZDi
         PE/6STy3TCkRo+55OpSGqL+JIDRP9z/AJk+VYIgJyfV3ZQJeg8vc52tzbicvDU0LtPvf
         DtHA==
X-Gm-Message-State: ABy/qLa0O/YVWAN6kC4Jdukt0+z6Y83Q1AqEIkDj3KuObIlNkCqR32a5
	ZsnB8cKjpFAfjIUMRqzS1UgVtYCIlmITg3JZkbdhcFrLykCMNbtNMQjNd9VvVN7/2Tx7dfqdcwZ
	kArIEXXqRSiJ22ltO
X-Received: by 2002:a0d:e284:0:b0:570:28a9:fe40 with SMTP id l126-20020a0de284000000b0057028a9fe40mr16227296ywe.5.1689109082641;
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGA6n45gkHkTv6XI6HgkyWTiJIRi19JmwhiTyxapecnmiZP7znNfnQP5MUvwPurdzpN+R7zUA==
X-Received: by 2002:a0d:e284:0:b0:570:28a9:fe40 with SMTP id l126-20020a0de284000000b0057028a9fe40mr16227284ywe.5.1689109082375;
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j136-20020a81928e000000b00545a08184cesm785353ywg.94.2023.07.11.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
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
	jsuraj@qti.qualcomm.com,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT net-next 0/3] net: stmmac: Increase clk_ptp_ref rate
Date: Tue, 11 Jul 2023 15:35:29 -0500
Message-ID: <20230711205732.364954-1-ahalaney@redhat.com>
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

DO NOT MERGE, patch 2 and 3 are duplications at differing levels
(platform vs driver wide). They work fine together but it makes no sense
to take both.

Disclosure: I don't know much about PTP beyond what you can google in an
afternoon, don't have access to documentation about the stmmac IP,
and have only tested that (based on code comments and git commit
history) the programming of the subsecond register (and the clock rate)
makes more sense with these changes.

I'm hoping to start some discussion and get some insight about this.
Recently I found myself discussing PTP and some possible changes from
downstream that might need to be upstreamed. In doing so, I noticed that
the PTP reference clock (clk_ptp_ref) was running at a much lower value
than was being discussed. Digging in a bit, nobody is calling
clk_set_rate() of any value on clk_ptp_ref, so you get whatever the
default rate is when enabled. On Qualcomm platforms I have access to
this results in a 19.2 MHz clock instead of a possible 230.4 MHz clock.

This series proposes setting the clock rate. Patch 2 is the "safe"
approach where a platform must handle it, patch 3 is the big hammer
where we max out the clock for all users. I think patch 2 is using
a proper callback (I want to document those a bit in the future to make
it easier for future folks using them). My guess is that doing this
driver wide might be undesirable for some reasons I'm not
aware of (right now I blindly request the max frequency but the IP
could have an upper limit here, platform maintainers maybe upset if
their careful validation at prior frequencies changes, etc).

I've only tested that the Qualcomm boards I have access to in a remote
lab still work (i.e. throughput testing, etc) and that the PTP
programming is now what I expected it to be theoretically.

I'd really appreciate someone with the ability (and know how!) to test
PTP tried this on at least the Qualcomm platforms. Bonus points if
someone explains how one would even test PTP networks like this.

Thanks,
Andrew

Andrew Halaney (3):
  net: stmmac: Make ptp_clk_freq_config variable type explicit
  net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
  net: stmmac: Use the max frequency possible for clk_ptp_ref

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c  |  3 +--
 .../stmicro/stmmac/dwmac-qcom-ethqos.c         | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  5 +++++
 include/linux/stmmac.h                         |  4 +++-
 4 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.41.0


