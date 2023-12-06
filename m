Return-Path: <netdev+bounces-54216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D876880641D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774D91F216FD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26B805;
	Wed,  6 Dec 2023 01:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7A196
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 17:28:05 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8b0fb63cbso5899429b6e.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 17:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826085; x=1702430885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ySauBYp0pXzqSF3h5YZYqJdikNmojNceW9Ms4nmH48=;
        b=L1DbiI0Ct05OvFOa/dfM2jzOMFMjjcbgVWcL5mREIPBTV3vu3tpmHHfwbSlwtlhwjT
         UI2htKOzRd5aWUn273I8K2jn/PEMyk5T2Xy63n1LhV0xPOHWDMD8FVsh2jfrBIrqUscf
         Wk8KBwARp2dpipIzFnkGzdcgE4CaDcURWuuxVLkXH5O4Fgs30WY1EU0qQckBfBbDZvPh
         BsO0PZyOqIbTiyNqFx4D7w8AS/EGt9xIc8MxOyeZ6RYlzZqGogjWs5v6m320MNbxKZCL
         Ok+xp+AV3QpYzeXL5UqS8m1xKpOK+beXauv6hdlFK1+tlI1aWUg9WhIRxyYxfZfRSDvJ
         vDnQ==
X-Gm-Message-State: AOJu0YwLpBjxYx4dRpx+IbS2p5YSGsqlKjYwpxM4KfMTc3j+5yTJsz3c
	EcIpSEibh5hYwETI+SsGdxxSOs0f8JSVINljLV/16loJQcIP
X-Google-Smtp-Source: AGHT+IERo+uS3K5PcCNLP0zvPy2IvH185FonEs/HGwm+m6q13cU7lDnfz/RiiSjaBSIUmpp2rN0ho2Cm9BzujinCS+f+Q1Hly+Gw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2009:b0:3b2:e2b6:75a3 with SMTP id
 q9-20020a056808200900b003b2e2b675a3mr171604oiw.6.1701826084931; Tue, 05 Dec
 2023 17:28:04 -0800 (PST)
Date: Tue, 05 Dec 2023 17:28:04 -0800
In-Reply-To: <20231206005340.11534-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004310b8060bcd43a7@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From: syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1577c0d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fa938ce80000

Note: testing is done by a robot and is best-effort only.

