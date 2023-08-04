Return-Path: <netdev+bounces-24478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76877048B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8611C21817
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640F17FF8;
	Fri,  4 Aug 2023 15:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969713ADF
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:26:58 +0000 (UTC)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BA49CC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:26:39 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48716a02895so592143e0c.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691162798; x=1691767598;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TISz3k+PMYGKrMgDH9pY8Cp9li66HI00FkNZizTo52w=;
        b=ExCswNAgk/v2e2egu6+hNMtaYHUBghOmS7c5SYQG314yWxfL45c5JbogeOf8a0K5zd
         sDIQfdFSOuXeIHAoJ73WePOZYNCex95APFciBPZeir24ctb1HWsNH/Ou2NxzgPxiaa/G
         YgAizDvo4Uh8/0bv99AR0xejdMjSAsRHAhsWHXvWEQze5ZzEmLE3T0MfBeUFegIZOwCT
         BDb/J6ayuGdEJzJa5likWPFNfzNHm3Zk4cZ9WkqL0aqeYZqJyr/G2v4MjxPLxIs6FqLH
         eehDYY7DdT/M1PsS195mcVSsN/VPAySeICj8u2w0/C+0AhRX22oFN/duheWEqY82a9b3
         qYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162798; x=1691767598;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TISz3k+PMYGKrMgDH9pY8Cp9li66HI00FkNZizTo52w=;
        b=QRxrMhWt+P5tNzZ9RmhXJutbvAIPWD0MP5PYMGJY5IZH5DWHYzHwzzGuHxNnEdeuoG
         3F6QOgCbCHWPEgRM7mXUyqviyyT4fxbfyNmWrRVaL5YarZMLtvZYjwDyhlKD9C6oevIX
         ilthaPClAoTKh5TuytKosy/LYZ4HfYQ0QFQObT+1DFXb08nDJ89U2LEtj9QJXzg6lFDV
         aAEppf5ylW6CfxyiXGRzeztPcWU3tyCseWKtyofwuDe7QJ/D8yt07UBfqB698FrhsBnQ
         LZ188WtSh9+vNSdfB8G8ohy+SpcPRnFKw8Bzhek0CSlRXCl1XG2RxIp/Mq3eX+nvWXO6
         cJIw==
X-Gm-Message-State: AOJu0Yx3E5aXngSQz1MD8thZjXMRkT9pEd4kgy9Vc1UYItqsq1mRilyL
	7OKDtgEgYOJh+hn/KRTYg145xbA2JDI5oISvwj7CCNdrGnnfSH84
X-Google-Smtp-Source: AGHT+IEoWukZdCUayYc8Z/czVgSIpSLbHA7yoE13OqC9Toa6S/N5naokCJMvr0IlYjGZX9SWBQRcnHFdIsAUz5koBa4=
X-Received: by 2002:a67:fe98:0:b0:444:db0a:51b with SMTP id
 b24-20020a67fe98000000b00444db0a051bmr1434229vsr.15.1691162798241; Fri, 04
 Aug 2023 08:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 08:26:37 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 11:26:37 -0400
Message-ID: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
Subject: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

With recent kernels (5.18 and newer) the ethernet is all wonky on my
ZCU104 board.

There is some behaviour inconsistency between kernel versions identified
during bisection, so maybe there is more than one issue with the ethernet?

  6.5-rc4: after 10 seconds, the following message is printed:

    [   10.761808] platform ff0e0000.ethernet: deferred probe pending

  but the network device seemingly never appears (I waited about a minute).

  6.1 and 6.4: after 10 seconds, the device suddenly appears and starts
  working (but this is way too late).

  5.18: the device never appears and no unusual messages are printed
  (I waited ten minutes).

With 5.17 and earlier versions, the eth0 device appears without any delay.

Unfortunately, as bisection closed on the problematic section, all the
built kernels became untestable as they appear to crash during early
boot.  Nevertheless, I manually selected a commit that sounded relevant:

  commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
  Author: Robert Hancock <robert.hancock@calian.com>
  Date:   Thu Jan 27 10:37:36 2022 -0600

      arm64: dts: zynqmp: Added GEM reset definitions

Reverting this fixes the problem on 5.18.  Reverting this fixes the
problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
these versions, with this change reverted, the network device appears
without delay.

Unfortunately, it seems this is not sufficient to correct the problem on
6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
a new, different problem?

I guess I can kick off another bisection to find out when this revert
stops fixing things...

Let me know if you need any more info!

Thanks,
  Nick

