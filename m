Return-Path: <netdev+bounces-20879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE95761AA3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2BA2815D1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC3200BB;
	Tue, 25 Jul 2023 13:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCE1F936
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:53:49 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AD71FF0
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:53:46 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5ad07254cso4009521b6e.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293225; x=1690898025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=CSlNx0Y/lORkumO4eUpWZbPx1NTpBO9locF7dUl3EQT1+plvySxa6hy72JBBA8oSOp
         YJJt0AMDM26xJ4Ki2TsLTtqwyI8ICGlONZdZ60D+oWPZAZBFiQsBHWcik0DUoOuiaK4m
         nNL1G5oNL3MJtBEWFConlqkCgX+qOfR6pBdSelj3F1JU6qlaaqN3289A44mbiM0APJeD
         YgshroXA2WKdFi4ri4bhR7aQlqG3t2XQIL4yufytDVBg/3CyaSV+4vrrmp15ipDawulh
         Fp1nNxDPKkV2boYuH34h7mEPNug5ppKEAGjAJ6RTecP+qrgc05dN0g8ecIHtUXHBUO53
         Wquw==
X-Gm-Message-State: ABy/qLbwNES5Tsqe0Y71bE/mpuDP6IhJdMUuzeDJbDPLmJAvk+CsUxvP
	siAOSFVZYBLufNL1+97sQtfze2i3xE2XMn69VDhpeNdHmB3x
X-Google-Smtp-Source: APBJJlFTc3F/yCQIEjusQ5xmHQUk99lac6DPdjFsUr1VsAB/ucUksQNNIo1zzodCuXIkwCozJhHXL8R9/JQR1zDBvQAjEPB97Uv/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2005:b0:3a3:8c81:a887 with SMTP id
 q5-20020a056808200500b003a38c81a887mr25942704oiw.6.1690293225794; Tue, 25 Jul
 2023 06:53:45 -0700 (PDT)
Date: Tue, 25 Jul 2023 06:53:45 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a33ca0601500f33@google.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
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

