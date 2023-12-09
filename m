Return-Path: <netdev+bounces-55543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970E80B391
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30401F20FD2
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE711C95;
	Sat,  9 Dec 2023 10:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3EEB
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:20:03 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58db2015327so3146461eaf.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702117203; x=1702722003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzTKkayoaN26UAkjoOlMDL5VfK6M0KZqgpnzmdfUgck=;
        b=mdY6OEo2FQh0a8R7W1Nm2xvHZgPneibc+hOJ9k79rMYitS8BdsINxYmPapoG4+yh0I
         hnIIkb6FIyh9TH0BktNq9WyX76N20gS9cGFFAvpln27G9Wx6W54w9B5wXOxmGknb4sty
         NQ+sJFd+F4J9QvRsYxUQWjk7DGUsW8mMDN/F2Rj4gVGLLSAUkNEsNgN/Q4L492NivTIi
         EneIzzhMJkxUg0gvPI/T6i3Tra6IeKHJWlWobXnKjMSrImOHHV7VDC4iU+fzB2Zyo/JD
         3YgJdpaCE/BfI4sXrRfXqHMaxwsHro4b4Pg52svGAbVEffTxd585nFrLCPPzg6kX0HPx
         5vYQ==
X-Gm-Message-State: AOJu0YzA5E/s0n42bVDx2xkkqdUq7iOqFjExJlH4E5EJG+zeDu1S+yJQ
	khD0WJ4eHV++0HRAVlBfihS/R8QXSlZVZeQ9SgyYxJEUXR4H
X-Google-Smtp-Source: AGHT+IEk926lM5pj/9LbooEoD3qXdZbKj4Vj79uN+R/s5Tnixbsp0bpX7U6paOZtjG/0nJtrWkQ9ZXqn7OCoT5Sag8emrp72f4kV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:dfba:0:b0:590:8aa7:1e1c with SMTP id
 k26-20020a4adfba000000b005908aa71e1cmr739667ook.1.1702117202886; Sat, 09 Dec
 2023 02:20:02 -0800 (PST)
Date: Sat, 09 Dec 2023 02:20:02 -0800
In-Reply-To: <f8bda66b-bb17-4bf8-b97a-4f7f0788d28f@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e8971060c110bcc@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=117f5cf4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a0b898611ad691
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134888b6e80000

Note: testing is done by a robot and is best-effort only.

