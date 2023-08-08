Return-Path: <netdev+bounces-25407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06090773E08
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE784281224
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E9C1429B;
	Tue,  8 Aug 2023 16:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272713FF3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:23:43 +0000 (UTC)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701C28EBF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-63cceb8c21aso71263136d6.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511811; x=1692116611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=YHnS4imAxW1n530FD4OGJWrAPMaDGvEOsg/wGj2BlB8WQQb4JidaK+sOPIO0Ezg8IV
         /WATYrgOBQVEgvvAAiRvZdbPz0xUYQLfwuqaCRDxFDvmGUF6HDAoIt9U0e6rODO7jfD4
         VFcpGbWRP+Ymk7wVVWSkV6/xFTxhV8AWv++nxY59Uub2KCnsWLZEzsVgendLQjMdYoZW
         RFw4AlXubjV9OT0BCZHexv9EP5Qg2cFDVgFVhKAKjrg6qCrbQh7TXCs/8xfJ/GcBqqic
         P18VwDTvUN02+jHqruaX3enUdzVLfD/DZ13kA3JkuL/R12LIEN3FXkUu/ur+iagzgOmS
         ZOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511811; x=1692116611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=J8XsAgVtmvHuMH6qoyLFH5ZCWm3zbHkBFQntPaRrLgFEWXozaxlbIdm9KFxtfZYk2M
         3TXrHus7lcd8kWMNIWxtlg+TMPsghrx5B4APjz6OXWEA7OcWazpCCOJPmKgV8yD5xlkc
         IGfWez/5kfPNNyfx9wr277EL90QKIfFenm+bb7+HV94xBev+dfPDGONMJ1p8b6F17Dfx
         VpT/lMrwBHHXYuTTqLyxh2LnbkeStYW989AdQQ2e2ykl7N2qdZF64M82pPCbJr9/2gmy
         etKjZyxOOicfeSQvJTu2+q4uQ9hu8oQyNmte+fCI6PP3lNVu/Y7scnV9nRzSmPaRI3Aw
         eQ/g==
X-Gm-Message-State: AOJu0YyFe2jehKVd8MbOCe71BwDYuj8j5SZ5KBHcOBZHnqJrpKuepcrn
	JSM0jjvcmCgs0iNibCx01UDEq/bx9eM=
X-Google-Smtp-Source: AGHT+IG4txtV+6uc+oKF7CSQYQrKbqcJE3xU2dySXADEt+XujAyR+d+nq4ZhFg4L/8/3n+EKVUl8bqf3zUk=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:98a1:340:cd3f:85e0])
 (user=nogikh job=sendgmr) by 2002:a05:6902:4a7:b0:d11:3c58:2068 with SMTP id
 r7-20020a05690204a700b00d113c582068mr72309ybs.2.1691505300509; Tue, 08 Aug
 2023 07:35:00 -0700 (PDT)
Date: Tue,  8 Aug 2023 16:34:57 +0200
In-Reply-To: <0000000000004a33ca0601500f33@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000004a33ca0601500f33@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808143457.3503251-1-nogikh@google.com>
Subject: Re: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: Aleksandr Nogikh <nogikh@google.com>
To: syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Cc: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:

#syz fix: can: j1939: transport: make sure the aborted session will be deactivated only once

