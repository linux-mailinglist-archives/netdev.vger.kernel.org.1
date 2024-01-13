Return-Path: <netdev+bounces-63434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446482CDED
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A85283F9F
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 17:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950D5240;
	Sat, 13 Jan 2024 17:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63566123
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bedd61c5dcso388173639f.0
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 09:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705166944; x=1705771744;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICsUNI7Afo1PaF9JpZaaVdJbx+JyaYF4RtdCTjtQr2E=;
        b=EEOf2dcpcrXqPHzEew3cK02+oaclqWULh9InrsMX1ssrNVKDNqz5p2beER3OeSRNgN
         Cx/QN91Qi8ND7HmLtgYFeDXlB90nU7fb3wHxFy16CG23X8vFudA9nNKatBpj9XT/251G
         t1kMqiQMzZFLZ/SyUlJiupjmmsEVoIJ64Ux3/PFkxGzriO2nO6/TxCDU+BAM1YKQg2dt
         MGJJyayxrbaNtqaH+ayIiuUHW+K7RsuwIUsNIbxzLBZ8LYcN9UmoNLsXWEfaWzMNTUlz
         Q4y6XhdAnjwSL5lxw7Gh9DChwsCqofuj7wjKRKGmkn/QS7HrXHbShnWWSaLClt97ZmUo
         Y9Tg==
X-Gm-Message-State: AOJu0YzoEYuBRnsqkgDVmbTvBbkjeJfQ36Iz3l748ItNnHE71h4HTN/R
	YpIGCxeZtwM/qkdK7czoKxsnePEHfvwfUSR2GITry01rliJN
X-Google-Smtp-Source: AGHT+IHcLfzVAyzvzQwfkVETCBuZ267lqDZoU9EjATlm1vKKLELh2mnr630YV9hDNu5o4qUMvxVVbcfwfndUYj9z7niA2zqVDvIP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:360:5cc5:8ded with SMTP id
 g12-20020a056e021e0c00b003605cc58dedmr387058ila.3.1705166944013; Sat, 13 Jan
 2024 09:29:04 -0800 (PST)
Date: Sat, 13 Jan 2024 09:29:03 -0800
In-Reply-To: <00000000000026100c060e143e5a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb160f060ed71da5@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
From: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, davem@davemloft.net, 
	dianders@chromium.org, dri-devel@lists.freedesktop.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jernej.skrabec@gmail.com, 
	krzysztof.kozlowski@linaro.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, mripard@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, samuel@sholland.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, u.kleine-koenig@pengutronix.de, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit d665e3c9d37ad31aec2d0d9d086e7c903ddd7250
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Date:   Sun May 7 16:26:06 2023 +0000

    drm/sun4i: Convert to platform remove callback returning void

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D146b91f5e800=
00
start commit:   acc657692aed keys, dns: Fix size check of V1 server-list h.=
.
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D166b91f5e800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D126b91f5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5c882ebde8a5f3b=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2b131f51bb4af224a=
b40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D103698bde8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1617e0fbe80000

Reported-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Fixes: d665e3c9d37a ("drm/sun4i: Convert to platform remove callback return=
ing void")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

