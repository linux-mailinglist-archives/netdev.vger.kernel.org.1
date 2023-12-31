Return-Path: <netdev+bounces-60650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE4820B85
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46711C20E23
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00933EA;
	Sun, 31 Dec 2023 14:35:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E9566D
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fe3fbbea8so84147005ab.1
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 06:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033305; x=1704638105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCueiKiN0GnkiTtAHxd2qHT++MKc3o8qWx28OZrtfG8=;
        b=eMV+02lJu882GWfS2WuHBaIo/wV3IVORuJnrlkgYZcc8MtbleRFB667YrA0n5KaVxJ
         LJQzx6lgRWiGNgSFthkvbPz5Qfajr+at4VXO/KWbcX03W8hOOBjWvKDnHL7mLL61M5AM
         hUwbSivgFCh9Zqr6NQUt4B5/No9rqMGkYKW9D4tWtvG+gbYbn8YK7gOHEhiC4GZscZij
         onuFCZHtqBKh34mHC0bcQIx6Cr5CF9dT0GU9Ry96VAb+RqWuTrYvjzOITgKXOFc2Xz/I
         HKPa90WbQbtk3EsPlDitU873YXwcPy9kCiG8N/cy4VD5YHVztcapqx+wfjCmgMA8t3JR
         u4uA==
X-Gm-Message-State: AOJu0YwwFcfQivgy2goFCJBxfHHsebj4pd8wptJmP5MJ3gNhGxx6ft46
	Gxhh/yhM1kQoNS36Z8Kr+SK+N1YExJUIQpBUNkmbmcN5A+L8
X-Google-Smtp-Source: AGHT+IGAvhkrORVeVhMPpx5OIiTSIS086ZNN12GLpzZ6Z8Ln85PlALz5NoJaLYhuQepZpu/ry5mAAeVJuUAgJ/Nj400t5atGEVvH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:360:128a:fd59 with SMTP id
 w12-20020a056e021a6c00b00360128afd59mr1400309ilv.4.1704033305361; Sun, 31 Dec
 2023 06:35:05 -0800 (PST)
Date: Sun, 31 Dec 2023 06:35:05 -0800
In-Reply-To: <675e418f-ef2f-4bb7-9fde-337171aea92e@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da0463060dcf2b01@google.com>
Subject: Re: [syzbot] [net?] general protection fault in qdisc_create
From: syzbot <syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com

Tested on:

commit:         92de776d Merge tag 'mlx5-updates-2023-12-20' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a43d1ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=84339b9e7330daae4d66
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1662b9a1e80000

Note: testing is done by a robot and is best-effort only.

