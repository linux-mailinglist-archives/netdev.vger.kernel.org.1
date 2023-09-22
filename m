Return-Path: <netdev+bounces-35795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20FC7AB18D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 951912828B0
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386A200D4;
	Fri, 22 Sep 2023 12:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D83D9F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 12:01:30 +0000 (UTC)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66E19B
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-57b6d19955bso1210421eaf.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384088; x=1695988888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj2QWvmiK+0WWAcmrF4T0yz3RCgK8HWXoA++/rR1IPw=;
        b=QNitjobuhNFxEGc9JUip5vrAYNSvBLC3DGYypFuMXvVaoJ6yD3GB4z4uwWfjXUOjBl
         kj33W8WWjpuE9hIAPhMpTCMSlWQ+8yMr70mXzoyqG8lhquBc+VWO1ojDG8lyLlA0DWI0
         X1ItzGbjoJq8N813FFfO5uW6aeQoyBN9YfpxITa4qAXYZ1Yh8PQzrCxZEBUARgEFHio8
         /0FIQIf0S+GHdSFe/kI4k/SK9dde2kmZufii6Ibh6VgYP2Lrao6IHY/jDiwq8S6N1XYU
         akQk7WUm+EYGlbSgkdToqpiENAngCWMN+H7rtUPq5Iy5QcgKT2pZkj5i/KFejPAOMxnS
         UPBg==
X-Gm-Message-State: AOJu0YzjfpYoQRjoxaM+BgAH/FhpeOD+2zgbE10PkQGa4oFi+t/O803E
	syqhuoxjGvslSAAx87tOBe11QSILr4Eh0u82LnTV4iWvMRbh
X-Google-Smtp-Source: AGHT+IGQtOov5rgUCSHUmJaUiEHw6Xxzi7sjyCjTogbyObjGLfUVrtFsovgvSWXfW6nmE42beN87+I5IFZm0BLhP45xFVBRc0qio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:954d:b0:1d6:41c0:c9bf with SMTP id
 v13-20020a056870954d00b001d641c0c9bfmr3173482oal.5.1695384088583; Fri, 22 Sep
 2023 05:01:28 -0700 (PDT)
Date: Fri, 22 Sep 2023 05:01:28 -0700
In-Reply-To: <000000000000140b1405fce42c66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005be6710605f15e50@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From: syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b66646680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b66646680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b66646680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f06d04680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fdcd0680000

Reported-by: syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

