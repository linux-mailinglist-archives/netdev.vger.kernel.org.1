Return-Path: <netdev+bounces-16860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A658374F0B9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B61B2817C5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984118C36;
	Tue, 11 Jul 2023 13:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D018C2C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:53:37 +0000 (UTC)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17194
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-563afee3369so3492778eaf.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083615; x=1691675615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCTVwmB5J6a5dx6XYxqF53hqOsGWkSYIyrPo76Icn50=;
        b=KkhXRWAHQ4bLI/XpZYt8FuK3pgHIB/Mmpi70vHn0MH0Xe8k6tEeB5fBFCVTct09erT
         kAzlhfg+TraxXiImBieVRFgP4m5JnMqvZvz/aZ6SXqQnB8IN+LZ10C5RZ7TEOu9GDLWP
         loCDJTHusJEEU0zTFdR6RjBepRVa+Y2R+ta0IKk8oKLkFMAO1ECcyzlT5WS/2uovWVfD
         OH2mOKTnJbGVe9ofVgvWmqfVKu8OcAjzBRloj8Har/HI7mVfJ5docW7HftklI5D5KrNY
         TGL//J/r+EY9+3uTjiGb1eJfEAbDVDis49EsF5cqvVfg9XYwTNlT7krgWW/Xj8UpOsHo
         W7hQ==
X-Gm-Message-State: ABy/qLbMLsO8nK3yjSHpBO3m8t12g5U08ELrjDh1d4pDJ7W3Pycfz8w1
	1WbFBgopwrmIdrUGhv04BZ/a8EZNUEisxw+NltaVWovQGKWV
X-Google-Smtp-Source: APBJJlECruf66V+JyRtf/KQM/NOn3dy9C/Lb8k9+y2hASr80eBt7evZQjebFhxPNCMT+nnvVQAppHWH3WgcG/RDwIiq/YDiQySGh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:db54:0:b0:3a2:214d:3da9 with SMTP id
 s81-20020acadb54000000b003a2214d3da9mr1601278oig.10.1689083614942; Tue, 11
 Jul 2023 06:53:34 -0700 (PDT)
Date: Tue, 11 Jul 2023 06:53:34 -0700
In-Reply-To: <000000000000de1eec059692c021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5c040600366c6f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in j1939_sock_pending_del
From: syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
To: bst@pengutronix.de, dania@coconnect-ltd.com, davem@davemloft.net, 
	dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, 
	mkl@pengutronix.de, netdev@vger.kernel.org, nogikh@google.com, 
	o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This bug is marked as fixed by commit:
can: j1939: socket: rework socket locking for

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4

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

