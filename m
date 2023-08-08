Return-Path: <netdev+bounces-25368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30330773CE1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606CE1C20E5E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DB13FF8;
	Tue,  8 Aug 2023 15:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594B1C29
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:55:42 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040B16547
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:55:18 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a1c2d69709so10432008b6e.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510070; x=1692114870;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=bXOYXLqc2ci870MfOjbmesRwuawbZSHJqyvq+kgr5MNe2MP+uPg5tQiMTqJKZsj+x2
         QvuVsv4Y12ykFnuY4x+dkznphVvVicwnwVe7MbcKvxTazKsJDs1K6o/kMYuWQqErxlvv
         kdob42O55HaBpaTnJKQM4MqAKVkfHFrg/SijuA6G9aD099FErGkexpJrt9vTUABEWJ8F
         +P4/EmtdjP0t8xMBEIBuZrxbu0Q+wBKcQ1rV5YRP8/G6mYQdeO6bFsi30Gq31qCZ7/tt
         o9aVeoMT5QtLwNvrVvaA/K6WbG2zOy9s7YggpOO1SIrrdKaDRZU6ID2W3ZRm0HfhtA9i
         CcPA==
X-Gm-Message-State: AOJu0YxUwWxFa8LKxiJV3jpLKM/fxNPvwW/2gXJnQKpyHHvZa09gI2QR
	CuQJ14QcphK04QkpHfLI2V8Vx968I8PzC0KDt/uV8w1rFa0n
X-Google-Smtp-Source: AGHT+IHVxzz7rv3Yc6Ex9nVZyfccRlIl4YuPHqh33kxidSRG2ZsY/cJC8dt7jVr/W6xkY4FX1aCJajbFNScBQQQ0cLLlU2M2U+jQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c794:b0:1ba:7bf5:67cd with SMTP id
 dy20-20020a056870c79400b001ba7bf567cdmr16115130oab.11.1691502890465; Tue, 08
 Aug 2023 06:54:50 -0700 (PDT)
Date: Tue, 08 Aug 2023 06:54:50 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec3e1f060269b476@google.com>
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
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
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

