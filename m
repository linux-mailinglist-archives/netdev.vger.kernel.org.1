Return-Path: <netdev+bounces-17281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6837510C5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CACC281A28
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BA20F8B;
	Wed, 12 Jul 2023 18:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D914F84
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:54:35 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB491FC1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b75210454eso8394086a34.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188073; x=1691780073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZMH+f/qQs35ft7PcSxeJWZ8yv3i3Olk8Bn6x6Aux/0=;
        b=TYUjbeUQrGv3JSqKHdIrBs2F65FyJzeoodY8naB2+A1odrWQbLVfzya7PfVYiIJ4Pm
         FCc574M/g6ecU39NdxOz6+/XEjb8a445QGmPtvMHw0jdEIRP7hqarJy71guaHKI2/P3g
         zX6haD383UDK7FkuGIGxy9qMxDlaJpGv3ItxL12SIetnMZiaJZElEgbngdDS5/03k0bN
         evl49P5GYRO/KAzPKHwv7KyYLMhZ2iil/EErmaGOmGE1QmywFrYZbxfFq3szAw5LA3ek
         GfXMQfgCStRDdCsVDaaBde+sfqGGX1UJDg7PkvTGbhEFmfKZ9Lj1PPELTIYAIQ8/z784
         mQeA==
X-Gm-Message-State: ABy/qLYaZlvj6++04KvKFu1JW6jI8sEcDunQy/nBdxBBdJOeFPAsTKjz
	OKlnHFL6uJXU/0N4d8prSVFO++koKI3NM+GyCBLkdXHlWmWp
X-Google-Smtp-Source: APBJJlFsJIcb0rdx4JjgRS1wq5NhoTjU9MPmFzmv1EP3Vle1AIKr62xgl7dheKEiVE6GkXdOnIQBkcJkfp2R0puLgy6N5pzwWkeT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2056:b0:6af:a3de:5d26 with SMTP id
 f22-20020a056830205600b006afa3de5d26mr6113119otp.7.1689188073476; Wed, 12 Jul
 2023 11:54:33 -0700 (PDT)
Date: Wed, 12 Jul 2023 11:54:33 -0700
In-Reply-To: <000000000000881d0606004541d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001416bb06004ebf53@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From: syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	dhowells@redhat.com, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 12:11:22 2023 +0000

    udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15853bcaa80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17853bcaa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13853bcaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000

Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

