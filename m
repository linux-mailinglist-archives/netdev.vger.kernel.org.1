Return-Path: <netdev+bounces-49270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF47F15C9
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D828243B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961C13FEC;
	Mon, 20 Nov 2023 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67322138
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso5985540a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 06:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490921; x=1701095721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=ZJL19H01qKXCFzZTr//ms1teKCEgcCcomLiQNtXY6KMLczBmvGCY7GwAAQ8OiwlRHy
         Mfh4kL7qDLEjteO+UvBsmQ87iRTK7FBz1bipCKajzeR9O+Z2NaIyqOQfO96GLgwQWDJS
         cb27gr8xMB/L7p0z93PXhNn3V06l6dE/hFxIPW0zz7olIRPUutpY/P0RXMQFAkHDcCoo
         AiunYfkNd/Mopr5SvqDbS9+l89e3aX3sH5jJ99xyTTryw7KgH6SBiqi0CHMJRjkqkgXp
         uVY1TP7uZw0yt8F8pKzuuXPgG91I94nAu+I6rGZxP0ASi6bmpGSc72FzpXZvYmyp0t8/
         36Ww==
X-Gm-Message-State: AOJu0Yy8YmONdM4S5yVLlalxACTB8s5aS4HFx8KrRC0LqK0X/+L40rnK
	O1Shalwxn5NZG/Q1sKhgX4GABwIaTAscrWsfXiOCho9+QOhM
X-Google-Smtp-Source: AGHT+IEzo56JbmoqVwXpNg8mySCpYTtfjo3yW4Qe9XqQZVtkbrSYD8LRgMtcpz+jO1iIYLRpugHW71s2+YOd//5V4KN6QrJvxIwu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:6897:0:b0:5c2:1816:24c5 with SMTP id
 e23-20020a656897000000b005c2181624c5mr1598710pgt.10.1700490920919; Mon, 20
 Nov 2023 06:35:20 -0800 (PST)
Date: Mon, 20 Nov 2023 06:35:20 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000490858060a96651c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

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

