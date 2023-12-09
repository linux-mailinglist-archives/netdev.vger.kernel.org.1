Return-Path: <netdev+bounces-55551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEA80B3DD
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B338281028
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA2134D8;
	Sat,  9 Dec 2023 11:03:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7B1AD
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 03:03:06 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb34e3da36so4788517fac.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 03:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119785; x=1702724585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvy4N+xBFdWEhX7gts5zd9HDZEkBme/lPMrmQcBrz/o=;
        b=e8SoB7iNKJ4O0NS7phL6uotXFvrT+5Tp8H1qtZDG49DD4+KoH/c0r1L1nDrpprf5OR
         4Qc01C1J5d/rG/9ux+AHvnkC1i5O1T19n7BiWdrP5FZvDzlyb31bDqoSFfbDpMFMT8IW
         03HV95BINNRNTaD5UfbaeqysRHYyk+07oopAwWCgGMuDXoiup6rcGKc23Jl/e+RNa2sy
         ULAKAPligWjBrmCtLWxyWVdGUw3Nx81IjJdOg19KD+TSrX8OP22wcEHKToS2OitzlZRl
         oKtKkZhInHtyR4C2YMdsp0jAy+n79fPkrEWOslF0NbhIAlQCqynQaIZqspu6UmHFEFtl
         rN9w==
X-Gm-Message-State: AOJu0YwrlkAnwayA1I/P1bRDnmPAP2kLAQcAJYIXNLONnUdYt3leYlxr
	GyDmYpIzZxRvf/jC1/FYA66pnwhzTs76wY8G+9jkKZ+ENBZ2
X-Google-Smtp-Source: AGHT+IEs0ucuoB+Vua4GGz+6FYGyUS4H62F2AXdK3glUw83TVYPZn3nRZM4ohhxr5G5d2oXjPCGxdjFiwSoAXtL3dE7q9onU6yH3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:70a0:b0:1fa:d9e9:2cc with SMTP id
 v32-20020a05687070a000b001fad9e902ccmr1568837oae.3.1702119785471; Sat, 09 Dec
 2023 03:03:05 -0800 (PST)
Date: Sat, 09 Dec 2023 03:03:05 -0800
In-Reply-To: <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002da54a060c11a5ad@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         f2e8a57e Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1714d166e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a0b898611ad691
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1330e596e80000

Note: testing is done by a robot and is best-effort only.

