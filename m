Return-Path: <netdev+bounces-46379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE62A7E3691
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6111C20944
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFA8101CF;
	Tue,  7 Nov 2023 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA510A03
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:25:08 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A36BD
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:25:06 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9adea7a4cso6772030fac.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699345506; x=1699950306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VeWHnX3FKLObEtyX6GlSBLB+HcaO16fQrZJABNKmrA=;
        b=aZm7URqjxWX7XH9qntDikyE7l06ukR7a/GQqmnbcd6P2yPuV+g7jvHjmwwraT1BS0l
         RSCMT6tUa9sSoZyO4pMy6fVxx2criMfB+dIOqZVqky2ZCYQDvIZsJWJO/ROOCySDmewP
         fxoBFh/UgqozB411HjN4AvhmvYqgEDY022FCy5w8AsqfRpOCTyEESQUlvjqtc1Z0DaR5
         lAmO+u3zpkWARQiDKe5Xss0ylHgDlcK1TaNjm7S55S7+m4tmkX5gpOPOCzj46/t6hpp2
         tRbUyOl6tuZrdD0APZCoDEnR6O1B7J73LWTiHG78NBu3BAt97btUnQsTyrogPNQUleAz
         XePA==
X-Gm-Message-State: AOJu0Yx+GWnaJYeIV3uhoHthi5UIPapPt8wahT5s2wigEBYMaAUhJS9p
	VAsSeVMBzokTkItjvQMJ+bpYzA8sSfiPl9nwwnKZJ+/3QX6T
X-Google-Smtp-Source: AGHT+IGJEd5Nq1Mz1pOFbxEaR60SDM8zts1GWxm0RyeCCsYGeWxT13dinNOJtnz8GWzdFwASj7cOe1upjxWEL6VJP2SWJnCZs7e9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:241a:b0:1dd:7381:e05 with SMTP id
 n26-20020a056870241a00b001dd73810e05mr950466oap.3.1699345506174; Tue, 07 Nov
 2023 00:25:06 -0800 (PST)
Date: Tue, 07 Nov 2023 00:25:06 -0800
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f0e4406098bb529@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From: syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@nvidia.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1734cd60e80000
start commit:   d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b4cd60e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4cd60e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

Reported-by: syzbot+9817a610349542589c42@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

