Return-Path: <netdev+bounces-30470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA7787805
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBDC2816A8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504115AF7;
	Thu, 24 Aug 2023 18:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E518032
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA671BF1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLXDxLfpL9zLoWLRxApVYve11hS/OEKZe5Jy4SYblss=;
	b=D89olKtSfR2cYQvbsASFJfWvuU398byhR+5AemSdKcCMdSyJyEyPckXXqpGFsnLtdDXjIQ
	of6Ih/NSxHJ157Km0p5n0McNZltGJ6Sj3PbMCqdxyIPlst7xrQitts+KGfglK8P6Equ/pJ
	HzvVUbFCC9XUzhJFzMdqmY0vCo3l02I=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-B-Fd6xj-Oi-HzxVwOGP6RA-1; Thu, 24 Aug 2023 14:33:06 -0400
X-MC-Unique: B-Fd6xj-Oi-HzxVwOGP6RA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ccbcb5034aso101694fac.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901985; x=1693506785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLXDxLfpL9zLoWLRxApVYve11hS/OEKZe5Jy4SYblss=;
        b=V3au/6Nlp8gm4VzfeluKQhSjiNPpcr0Gu6ZkH9HOZyFsoYnuA/H1RdqnyYUL8Jsvpu
         KRetctnH4/h8yh0YFjfdZ/5N1WQeJy007227HAYqNRUeXgpJ8hUR944JXrEAPI0QkE6R
         fPjjlRYxlY3dEiLBWetSHcneo4L0MpGFinZmnd/7tRTkohXfMCGNxfTENUWxWq8823l+
         PYCOXiz7Z7Hzbs6FGmBC+4U2iuee3p7M/Bq7O5sdvtXXchX+HJogehys+YdTVMuzSJoG
         HPVfjBKbDCO/87hOp2SP2Fv4D/VELs+eBSDB5gxMrQZbw9/iy8BP6bdM3y1G9G9ygg8g
         AQ1w==
X-Gm-Message-State: AOJu0YzD+hqNnz7qZG9K94tNeROdM1G7P5WQQ4ssBgdoabSteA+YuHwx
	xakXGUXYP0sTIQIKeAunvKC4aNh62nfAjpfaoFgdmcglcGN4z+Sj82kEqdzea5MQ5wf/LZEF0ip
	MU2N2APh6CGoKfVTA
X-Received: by 2002:a05:6871:299:b0:1b4:60b3:98bc with SMTP id i25-20020a056871029900b001b460b398bcmr646684oae.2.1692901985291;
        Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJca0VCeTskNWvGHD1H3TewlM9C3a0yafFFNkx3PrLHoWuGVt7iXKwhjuSJvnGG6tkI3pdg==
X-Received: by 2002:a05:6871:299:b0:1b4:60b3:98bc with SMTP id i25-20020a056871029900b001b460b398bcmr646661oae.2.1692901985092;
        Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:57 -0500
Subject: [PATCH net-next 6/7] net: stmmac: Fix comment about default addend
 calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The comment neglects that freq_div_ratio is the ratio between
the subsecond increment frequency and the clk_ptp_rate frequency.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dfead0df6163..64185753865f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
 
-	/* calculate default addend value:
-	 * formula is :
-	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sub_second_inc
+	/* Calculate default addend so the accumulator overflows (2^32) in
+	 * sub_second_inc (ns). The addend is added to the accumulator
+	 * every clk_ptp cycle.
+	 *
+	 * addend = (2^32) / freq_div_ratio
+	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
 	 */
 	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 	temp = temp << 32;

-- 
2.41.0


