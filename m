Return-Path: <netdev+bounces-31222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93F78C392
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036A62810F5
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F6154B9;
	Tue, 29 Aug 2023 11:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32588BEE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:48:12 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BA1AC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:48:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007abb15e9so6655764e87.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693309684; x=1693914484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiVeAWUqW1iK1vq8hMzNIn9s3HBdb3CWil3I/WKSdkI=;
        b=kkHFLPnpgXwUgaKTVXfGAzRnoW1VY3T3oloCw5daWql9fb7mZF3OHYfnmbFD3wQfmu
         9XPhQ616WJjBUjokvlFdyUo4UW/o3zNHLCm14gSp/yzG0+xuD2S8nQ1aQATFIhkz/aV7
         T180i2kdZwClYgjXsF/jQDChM/fldUh/qzAmlYcAwtCapT4FFlatXgrX8mgZ29bzFCIB
         kiaO9h5O7YSZDTwZPhvPwqm4GCMO3xbabcSb3+qN09Zax+tTLtCCsXYphGThsagllm6Z
         ky3x/y6YYuLKlcPcB1dXwBwehwSQoPiHC1a71L/E6UygBQtK/m3uyEcjUWNf/6rwsPvW
         BHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309684; x=1693914484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiVeAWUqW1iK1vq8hMzNIn9s3HBdb3CWil3I/WKSdkI=;
        b=RFG32Q47/sZFBIxp2j7Fe1jVSXZ0F0TWTlfuv7ZhlO/NRhAuniKXfnrRLdmn4fLsNu
         atbjoWTN5WTGUVqZXlCl7cbUkKb1I8PgYnRHOUxQI9aLYgH9UbNDEob6YEm1XbYNoStC
         96ZH4jj9PQFGocRbaJGduhmBbB14s5yow7ofdJwAc1ZeYR8g+GcsvfKCtqwYYvwrux0S
         UgR5kI1fJ8bduiVd6A33/T4hu32CqwWLwuKeH61783SifeIxKNu5xSP5rEQtH+XxTjmz
         7GTqguh8EUPTTl2BR/X63ArpGx6vPxpMDwgCdsP5icNYpivMufTD5tcdfyYr65W/nXzQ
         4vqw==
X-Gm-Message-State: AOJu0YzpJh8K9/vDXdgI7FfVF8I6Pcbg/W1AJe4ydhd01jdbS73htFwV
	vodZWum+TF6w2PkrEgp0aWE=
X-Google-Smtp-Source: AGHT+IFgiCII0IMKJOiJE013LhCpxsW+68fnKjAH1+MhU9i8QyaQHtc7iJlJ2ykj1Q0m4qZConUVdA==
X-Received: by 2002:a19:9147:0:b0:500:9c05:1059 with SMTP id y7-20020a199147000000b005009c051059mr9593564lfj.41.1693309683907;
        Tue, 29 Aug 2023 04:48:03 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id y24-20020a1c4b18000000b003feae747ff2sm16942302wma.35.2023.08.29.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:48:03 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [chrony-dev] Support for Multiple PPS Inputs on single PHC 
Date: Tue, 29 Aug 2023 13:47:51 +0200
Message-Id: <20230829114752.2695430-1-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y/hGIQzT7E48o3Hz@hoboy.vegasvil.org>
References: <Y/hGIQzT7E48o3Hz@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am interested in moving forward this conversation. I have found myself
in a situation where I need to use multiple external timestamp channels
with different clients. In my specific application, I use channel 0 with
ts2phc to synchronize a PPS clock reference, and I want to use channel 1
to timestamp external events. Since ts2phc is consuming from the fifo, 
if I add another consumer everything starts to go wrong.

I would like to share my idea on how to solve this. Like Richard
mentions, I just create a separate work queue per channel, and add a
sysfs interface to dynamically be able to move queues from the
shared/multiplexed queue to individual queues.

This is the first time I try to contribute something using this mailing
list, so please forgive me if I'm doing something wrong.

Let me know what you thing about my code (the patch should be on the
next message). Thanks.

Xabier.


