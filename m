Return-Path: <netdev+bounces-16859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CED74F0B0
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EF51C20F33
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8618C35;
	Tue, 11 Jul 2023 13:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00D18C2C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:52:36 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADDDBC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a4074304faso2287617b6e.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083555; x=1691675555;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=Dx/6W19Cw5qsJgVNmczFgUrg1Dzk8T5fB2uC2iGDDwoABS+VfoIpHklsn8rXaLZSfu
         a9gSC+L9PuYt/gXY3oGBnPLey2pet42tI8iefKSRWMn1zVgZZbccr+uQQ1LyptCr8YzX
         /xCABaLYXVsLjtgcylDIukPtnDDnPKRQPfsMgyS+mMvD4TkexktEP9jBbkVfPWQ2BP9t
         yNADfOUCNgS4QMzxJnIcD+yu/UbcWBMoEteYlFpjuBqPh5pLErvFp+Up4V6FAh9d1kcu
         AxuAL9AvNXVIsVucXsjyp7gofRWdRYfa7LjltT+e4OHqH6Lu7THlzh8v1MHTXHac1ETV
         C3Nw==
X-Gm-Message-State: ABy/qLZJbxym8Tgo+8W4zReXoY7Qs8rlSu86QS37tAszXy4kFQh2aVsC
	fBfSn2MufVziSw+xSKNu2smJ1C4NuhXablEAryGyAWBgYNa9
X-Google-Smtp-Source: APBJJlGDsG+nOMkSJbLXJKRNGNJfHOn13Ov445zenjdwf+cSdHKoP10U8UttX2mqO6muw59vtWRMSKpRyJ6QOj+P2/CyrzrHnT/T
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:bd03:0:b0:3a3:a8d1:1aa1 with SMTP id
 n3-20020acabd03000000b003a3a8d11aa1mr1493645oif.2.1689083554789; Tue, 11 Jul
 2023 06:52:34 -0700 (PDT)
Date: Tue, 11 Jul 2023 06:52:34 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000477efc0600366975@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

