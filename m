Return-Path: <netdev+bounces-24720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E808771697
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 21:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1718B281192
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2396C8F7F;
	Sun,  6 Aug 2023 19:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D37F0
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:38:33 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3347F171E
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:38:32 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5ab57036fso7002017b6e.3
        for <netdev@vger.kernel.org>; Sun, 06 Aug 2023 12:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691350711; x=1691955511;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHAFAUtlpPTsblmGRi8/yz/rtfn+G6tOKLxXyDwkU7c=;
        b=iTNkbwHAw2CqJrnMCGXsphXJPDXnaRdy3/oHsSFQQKRYCdL5ZcBIO4Pk9+wJgPUokk
         XT/1k6BG2o0pn/s6diL+ZmuWya47qN9QVpR5cOoFCVJjpH3j4nzdOSL9RVJWYtpGGv9f
         LI+qtXA1bSEmnbUmHsmXhX/S/R2mZtb9Ju0jOUW3cHgg5PznP20Xhft7rITkJsEefnlN
         Kg/9Ie3okulI+PHPn9q4Q+qiBI69sHglzAZvVzrC1GMIYci6nkfcuLhAzAO71ILD8rde
         HmaYrp+5bap8yALVrpH/3wC1sItyGf8dUv8bOd5k/bWm9AkJ6RvSzPBpo/9MPKM2XTjX
         wymg==
X-Gm-Message-State: AOJu0YzEdJSxRzqivC4HQ+uMaGQ+TZgoAuoXfsg8ZTG5Za1I07Ph60en
	oF6fKszR/GOUaR48JqxP1F8zqeaQLvcUc02IC8OpMH6oz0fj
X-Google-Smtp-Source: AGHT+IF40jj0zFbkkF2AkDSkU6OeSWL//98qOUQ8SLl2cjxFtDsY+SqCrZULINynDdtK/cdLxjdxmz+HSUoxFnDSbnBts8CbBw0I
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3020:b0:3a7:275a:dc69 with SMTP id
 ay32-20020a056808302000b003a7275adc69mr11976106oib.1.1691350711498; Sun, 06
 Aug 2023 12:38:31 -0700 (PDT)
Date: Sun, 06 Aug 2023 12:38:31 -0700
In-Reply-To: <0000000000005003fe05a8af2231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000597f580602464669@google.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in skb_queue_tail
From: syzbot <syzbot+743547b2a7fd655ffb6d@syzkaller.appspotmail.com>
To: andreyknvl@google.com, ath9k-devel@qca.qualcomm.com, 
	brookebasile@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	kvalo@codeaurora.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pchelkin@ispras.ru, 
	quic_kvalo@quicinc.com, syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 061b0cb9327b80d7a0f63a33e7c3e2a91a71f142
Author: Fedor Pchelkin <pchelkin@ispras.ru>
Date:   Wed May 17 15:03:17 2023 +0000

    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1243d549a80000
start commit:   559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=743547b2a7fd655ffb6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d5d7f4f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106ff834f00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

