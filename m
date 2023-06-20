Return-Path: <netdev+bounces-12303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AAB7370CA
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB9F2812FA
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485E174F0;
	Tue, 20 Jun 2023 15:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88562101D1
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:44:59 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D3E72
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:44:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77e4126badcso48360639f.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275896; x=1689867896;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TMtFy17G7L+rvVwecyWYDQmCWWgoRXIULxDBOATWxg=;
        b=po7BCRhBTMb0RXZ2grbat+GoPaXZqOqQj8l68xbhO38ra6DOH8Kqv9l83+j/RAlP4X
         3nChEK8fm70/sdp5CBv/6aJ70xOPjc0jte1ewToqW+Y/zpbGjgGsJ0tOTU4bDhkodsoB
         gMAaQDGqgg4Y7CJtlvNSbHyrpDGzhNdN2Ol84sytKFKF4x/VXMDmDHgjxQjInt3ReF66
         tdr2k8kjMuNP/WUj0asXVC05ORyi3pEzWlYKXQg3RAen/x9pYYjxev9APjTlzfLCOYaC
         iH8elzh9Mg8jEEK0wCbz3xZx+H0uO8bLvsotgcdGZOotQzrKzzCNuExRgDesFEcy0XVE
         gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275896; x=1689867896;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TMtFy17G7L+rvVwecyWYDQmCWWgoRXIULxDBOATWxg=;
        b=LvRDdF+JuV3JTmopdInzAX1dgbdnYEOtzZqcuF/7gG5p6r7e20loAoYy34/RwAdJoX
         q0G6GEiYSjyOTaB72erKkPz891Jn02Oalthj9fLcBKNS8r9YDIIAP+uV6FPWcbaxskIR
         Arr/kPpHNCkrMrxG5AHB5jxq96YD/pRwBuvfbIIgG5D4S5S4ipFjvxwvfAmW6KqaGetU
         6LTazUqCk1zkY8EkowmWKffvNuxMTKr0NyVgPbLZEr91bU2RVv9XO2nGoKp6cWOlAVRz
         JrskK4YzLnHnl7ZOKigFwLdetY5LHDbxCDSMEFuSCtgjzLrk9EUvfG42sZ2JkdLaxboS
         eDrw==
X-Gm-Message-State: AC+VfDznqUeiiAVZdh66+XmaS+mJEo3PS2Vk8shbu9cp+MK5Sxl7Z+Yf
	RMFR2lgZ8YWDqENhSHfwa2PI2Z8xvsq8Rfyn7oQ=
X-Google-Smtp-Source: ACHHUZ4fWiFcHsJgH0xy4YPKM3Bx4mCKRUI1lHYn7v0osxdhnXu1HZvm/oU2cpplbQb4nxbCbbu0AwotP1c9F7PhZak=
X-Received: by 2002:a92:a04c:0:b0:33f:eb60:519d with SMTP id
 b12-20020a92a04c000000b0033feb60519dmr6617527ilm.2.1687275896656; Tue, 20 Jun
 2023 08:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6638:248a:b0:418:84e1:3636 with HTTP; Tue, 20 Jun 2023
 08:44:56 -0700 (PDT)
From: YOHANNA ALVAREZ <mammera98@gmail.com>
Date: Tue, 20 Jun 2023 15:44:56 +0000
Message-ID: <CAAxZ1x_bOr_bHVN+-7+SYeNdpYCtpWYsy_Nh5w9r6pXye8fPXA@mail.gmail.com>
Subject: facixbooka@yahoo.com
To: Facix Booka <facixbooka@yahoo.com>, netdev <netdev@vger.kernel.org>, 
	Oliver Neukum <oneukum@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

https://fancywonderlandcowboy.tumblr.com/#==gN1MjM0MTb1MjM0UGZ2QTN0MzLjNmLrlGdl5mLsJmbxd3LvoDc0RHa

