Return-Path: <netdev+bounces-45692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098677DF0A7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DB1B2112C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75B13FED;
	Thu,  2 Nov 2023 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25128821
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:55:09 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381B185
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 03:55:04 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d32c33f7b7so133012a34.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698922503; x=1699527303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la7hzjP2zBKUn3oiit+lIJoZEhMcvAayTPixEdh76yQ=;
        b=Eqq2WNRFKO+yopiUqOPgffMIwgWLr19kIqonBC2s4c+FU4rRRH+emuWmXXyY+1pZGB
         2OhTjfYA13N3cmdJJaZr3f83VeTEw0bqhd4NKWqPEuYd5h0DH9865NY3dd7yd5IXeShC
         LnIFjIWdF6Rv7zhaSpUDLu5IXDPayH9TAPJ2QL2crDNragXbipXIXuoDEx1tvf3kGGfU
         e9jvs7iN6epHDff5wLvpeyLpsKlhmd4Sx0gmIAazi9c7Mi/aEN7ZwehxPqPlMSHaEoQH
         X9RnUWZUiR1JL/aIyN4hnlb7XzFC7M3wMF2mBHONiWVAKVMSqFIhvWGw4Sx3Zasju9R9
         V4iA==
X-Gm-Message-State: AOJu0YwStRilkJPHClVNVL2Q82bFjrFaOU84cN0ssWUC1yjdJkybUb5B
	sGnMH91R3923dMkdR5FsudaqHq9gjmEK0otzepfJtkfDNZjO
X-Google-Smtp-Source: AGHT+IElbKg+EeRIp1W9TwX1La69cw8Mn5P2aiLEy92t+6/mJ3coq2apA+VdMgsutl5EcPvBfgvYaOyr/g+K7qN1O8/97/Nr1hUF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1d0:b0:1e9:90f0:613f with SMTP id
 n16-20020a05687001d000b001e990f0613fmr8462067oad.0.1698922503157; Thu, 02 Nov
 2023 03:55:03 -0700 (PDT)
Date: Thu, 02 Nov 2023 03:55:03 -0700
In-Reply-To: <0000000000009ee19a0609135c34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d3e3d0609293891@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in
 nsim_dev_trap_report_work (2)
From: syzbot <syzbot+193dae06b6680599fbab@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, 
	idosch@nvidia.com, jiri@nvidia.com, kuba@kernel.org, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, saeedm@nvidia.com, syzkaller-bugs@googlegroups.com, 
	tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 644a66c60f02f302d82c3008ae2ffe67cf495383
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:36 2022 +0000

    net: devlink: convert reload command to take implicit devlink->lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c76cf3680000
start commit:   66f1e1ea3548 Add linux-next specific files for 20231027
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10276cf3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c76cf3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2911330219149de4
dashboard link: https://syzkaller.appspot.com/bug?extid=193dae06b6680599fbab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b8e977680000

Reported-by: syzbot+193dae06b6680599fbab@syzkaller.appspotmail.com
Fixes: 644a66c60f02 ("net: devlink: convert reload command to take implicit devlink->lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

