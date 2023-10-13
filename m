Return-Path: <netdev+bounces-40728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1801F7C8856
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D09B2098B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FA18C2A;
	Fri, 13 Oct 2023 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Dj7Af0rY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257611CAA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:11:13 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C3BD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:11 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5815818406dso1197668eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697209871; x=1697814671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ5gxDRs3d+Ci/el2gmmFaFHyI4bqijdewAtwduymnw=;
        b=Dj7Af0rYLlfsgeKhNfuiyKM+/wdUPR+bvMyovb4vakOQgsNOLWEhIE3iz4aKBpbp9G
         TMvAeZj6XFj1g2KtuQN/r8UUXyFazz/kVRuEP7DgH8Nl0IEK8xIW6dw/QRVVezuqBl/t
         81MTixnpr9pCC9lkjKf2BnllYMxw4nJjlQQ+vM4OYtqz9y8DfuD2fmzLrQITwJA7FlJG
         7AT1dwN9XVM7RAUTDAQm4IBqqTkI/lFrF2EjXseSDImi44fIZTQHcNR4P0DAaO3udumX
         vjWFKnxJCBs3TSQ6srzfw0voEkBkcXCbV1Fa7RXKP4u+VfpimHMDnlLMxPzOdaSKJAVj
         Pktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209871; x=1697814671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJ5gxDRs3d+Ci/el2gmmFaFHyI4bqijdewAtwduymnw=;
        b=Zy4kaAQlpI5HU/LqKvLgcFjWMaHV4JPO9TshWiUml2mLUPo2DPvAPX6fK2W/vqQ26T
         Oy/cchxfjglDL/RuMua4S1Cvu0ZIJtZZdtPLpT4bF1qOBDEtPkpJrQeGMUiMmdOHoDDZ
         rWcKebh0ajL6F4T8QvEUBH2R/ROWJdyD3QGUIbcZ37gRBJ0VOEhhRNr4XDj0Pafd6t0x
         fViJjXyAkV1e2HhVdckxVM5/4J8HPDZ3CjmgNhbZs1c0XvksBwx7oNzumrFV2hFSw2gJ
         /iXCvIZpchfK1IckbCGgIU5telQ/NBEXUCeG3l3MArSeD9XZYxkSDuR6a2FwXBC20ReE
         BHVQ==
X-Gm-Message-State: AOJu0Yzkgsr9Fra85WxUNdrZeivOVafW6hPnHLEUrL9X2ExciyZbqhmj
	GnqjQjbR/Yosa8k0CpHm8pkBMX0poTVdCOrOYbCF6g==
X-Google-Smtp-Source: AGHT+IH3XTIU2C3uI7iMsIcQGZO/4jj5/hBSL3CGNzs7DaB4h9VYEQSxhhSxjotco16QFDsi4DeVmQ==
X-Received: by 2002:a05:6358:278c:b0:143:8084:e625 with SMTP id l12-20020a056358278c00b001438084e625mr29413892rwb.11.1697209870681;
        Fri, 13 Oct 2023 08:11:10 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:aa18:90b1:177c:3fd3])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0064f76992905sm13716881pfn.202.2023.10.13.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:11:10 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 0/2] net/sched: sch_hfsc: safely allow 'rt' inner curves
Date: Fri, 13 Oct 2023 12:10:55 -0300
Message-Id: <20231013151057.2611860-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As reported [1] disallowing 'rt' inner curves breaks already existing
scripts. Even though it doesn't make sense 'qdisc wise' users have been
relying on this behaviour since the qdisc inception.

We need users to update the scripts/applications to use 'sc' or 'ls'
as a inner curve instead of 'rt', but also avoid the UAF found by
Budimir, which was present since the qdisc inception.

Instead of raising an error when classes are added with a 'rt' as a
parent, upgrade the 'rt' to an 'sc' on the fly, avoiding the UAF, and set
a warning for the user. Hopefully the warning laso triggers users to update
their scripts/applications.

[1] https://lore.kernel.org/all/297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io/

Pedro Tammela (2):
  Revert "net/sched: sch_hfsc: Ensure inner classes have fsc curve"
  net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner
    curve

 net/sched/sch_hfsc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.39.2


