Return-Path: <netdev+bounces-19122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B5B759CD4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E222819C4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0A13FF3;
	Wed, 19 Jul 2023 17:52:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43599111A9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:52:38 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012881BF6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:52:36 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3b8b73cbfso11750265b6e.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789156; x=1692381156;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiRiXJW3cvp7FSsZTUGSxXp2M76eBloK3LBfm2fpvAw=;
        b=jIaQhLobtT+j1hF9XrpXOTZo2p6ipRMDFbOKWODC3P/7ByL31lIA2iE2U212xiJYJh
         0pm6p150blkP463ZtH6Jk0zpclyQxFoX9u2vt003671FkAYy97bAJhll6PqC/tJM20Cb
         pRonIZWeayGbA7R6q0JFfzI19XVUXyuUxWApNsswSWiOFtcbkoSK8mlIaP3L8YSAGLz2
         QhGuHqixSulNlkXL05sXhvvZDpIc++uwnyj8UBZ2obeVfliMnIkrNizaaOkXUOOF0xYV
         zaISjoagEKxgENJTBgVoTq/nsabm9/sUY+NLjfguQjCXp99gHh2QdhTBNAEf5WfpRQCa
         hnig==
X-Gm-Message-State: ABy/qLY5cOwqJn0X+wjRwGuTJOxBaBUBjb0UxezktyESs5SjnNEZJhEi
	xT6fZrif1WDu0/zOFQA+5aZsyuBrUmJKp2mEj4YnidMD2Qwx
X-Google-Smtp-Source: APBJJlG5ugVl7dPPwQXLSskdx//wo3Cxwyt6xyJHDlFhfMqOYOoEiwYraGQnxOCt15oVej8GHXbJ8Vy/Q7WgiHAYGdyqnMHSkz9m
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0a:b0:3a3:644a:b55 with SMTP id
 m10-20020a0568080f0a00b003a3644a0b55mr30865038oiw.4.1689789156368; Wed, 19
 Jul 2023 10:52:36 -0700 (PDT)
Date: Wed, 19 Jul 2023 10:52:36 -0700
In-Reply-To: <30f03978-3035-a28e-c097-112036901bcb@nerdbynature.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069291b0600dab2d6@google.com>
Subject: Re: [syzbot] [wireguard?] [jfs?] KASAN: slab-use-after-free Read in wg_noise_keypair_get
From: syzbot <syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com>
To: broonie@kernel.org, dave.kleikamp@oracle.com, davem@davemloft.net, 
	edumazet@google.com, jason@zx2c4.com, jfs-discussion@lists.sourceforge.net, 
	kuba@kernel.org, kuninori.morimoto.gx@renesas.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lists@nerdbynature.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	povik@cutebit.org, syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com

Tested on:

commit:         6e2bda2c jfs: fix invalid free of JFS_IP(ipimap)->i_im..
git tree:       https://github.com/kleikamp/linux-shaggy.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172aecaaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f631232ee56196bd
dashboard link: https://syzkaller.appspot.com/bug?extid=96eb4e0d727f0ae998a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

