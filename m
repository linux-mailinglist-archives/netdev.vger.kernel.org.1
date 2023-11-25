Return-Path: <netdev+bounces-51062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B97F8D58
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54E62813DD
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6302E412;
	Sat, 25 Nov 2023 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E49F7
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 10:54:07 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfa28b5895so19646075ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 10:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700938447; x=1701543247;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7cwREvOXWT3hEhw9BX2KKETmIIsgJqgxROY2YXvuYQ=;
        b=ngCvsh6kMfyK/PQcgzZjfgi4lXsGKTN2WOHwcspY/L5St+QnQJ1YkBUPalJht/8/3N
         iF3600hheC2vjKpoB+zGHH6RhlxSlFej0UoQ+SDLSMamk1/MwUpQqAca/hFJo+wmmmh2
         rIdnMtzaEnx2c8wTN22hcAbWbfsNrdgS4TIUWYmmdwfQw+wVtuWiTqUfpOL5mUKQCxd1
         OgQd6TlhH9St9d7SlxzadYT2LsRKjyQO9PlEWRNOJSNM+9TDTlIO1BagPN8IMZJx7QAs
         QxvBFHsx6xnRFEOGDXBliN0Mi2tVK+3mNb8cF4LcmD+EiGpk72Pfa0gP1PU5SAZ5PLfa
         dL8w==
X-Gm-Message-State: AOJu0YwmSKd5ltQfOggPG/KvUUaNECQFwM0s24oo9PdvDeCU67tAUFAT
	8NetvNgLaiNn05SEMaMuPWKNVfSRp3bUC6YgmH+rDjAc0uYP
X-Google-Smtp-Source: AGHT+IFsHJbrj8tawgd8wr4MPhqfDgWPYBPTeLiYRW/WvQGOEl2Ay2ZBGg2xxVYCR9Py8gdIg4mUmDJWd0m7IbAMS21Z5zJmBeYT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:9a44:b0:1ca:858d:5be7 with SMTP id
 x4-20020a1709029a4400b001ca858d5be7mr1358254plv.3.1700938447221; Sat, 25 Nov
 2023 10:54:07 -0800 (PST)
Date: Sat, 25 Nov 2023 10:54:07 -0800
In-Reply-To: <f0c24608-a74a-40e3-a7b6-7dc7ca285a35@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee78fb060afe9767@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         be04e5de lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=170076d0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

