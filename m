Return-Path: <netdev+bounces-52122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E397FD5F2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2BC282F6B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91E1CFB6;
	Wed, 29 Nov 2023 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C78B5
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:42:07 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2858cb6b1a8so7073044a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701258127; x=1701862927;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjPA4/c9WZ5F20R0UIB2Kd3JkPUDLADtTQZRXgPbEls=;
        b=Ajk1CtOZVqn4at5jLExqADS4TFVUa9z1yXgoVPz88icedMqz+N2bqL24BX5OgCws4j
         UVnQRCVijkCbEl1q2V7D636FJsxjpPyvxviCj6G5th8AQUlm/vKm3+lyrRBIuhmwdOKX
         m+CvGRzJJb04d+l5On4KtbaUWMVrYAy6rheno58W6b5gmJsw78X3uqqxpez10yzu2sod
         k3OXtlmXxeSGvkmk1Dr4U2GyhE3NmnZMofP7wlNZgB9GGRgSCHYpovSS3FtIqMjGH0v8
         Ug9n+88CAXFK1JmZytABIBXw4G4gnTEJpTyCrkb0KnBBNb5jGMkHKe4w7eXqRGaZp/U4
         LxOA==
X-Gm-Message-State: AOJu0Yw/dPORJtB5yrvUFdYxF2bRJnTkkiUF/vc9IZbSBRN6h5gZUwJw
	bR0Ymj6AnaFEZuxJSMwQirseW46sPKJ/JkFR2XtFG8DG4yoB
X-Google-Smtp-Source: AGHT+IGbTN6xrle3YcbjSc2dUkUNdkT+KI44D8h/5Q5ENIpOrNqCRlZlOPhp74t7acqNCThMkM2zuB6AQt0YMxOb0C3zZQRUpPR1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4614:b0:285:71b3:7b41 with SMTP id
 w20-20020a17090a461400b0028571b37b41mr3815999pjg.4.1701258127230; Wed, 29 Nov
 2023 03:42:07 -0800 (PST)
Date: Wed, 29 Nov 2023 03:42:07 -0800
In-Reply-To: <CANn89i+6BuZA6AjocG_0zTkD1u=pNgZc_DpZMO=yUN=S1cHS3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000584f41060b490648@google.com>
Subject: Re: [syzbot] [net?] general protection fault in page_pool_unlist
From: syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
To: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com

Tested on:

commit:         f1be1e04 Merge branch '40GbE' of git://git.kernel.org/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1333cb78e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f8efb58a4db2ca98d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174c37a4e80000

Note: testing is done by a robot and is best-effort only.

