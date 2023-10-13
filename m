Return-Path: <netdev+bounces-40903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504417C9191
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36882823DC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124A31A7D;
	Fri, 13 Oct 2023 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411A2C874
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 23:50:36 +0000 (UTC)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF60C2
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:50:31 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57badc96ba6so3731787eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697241031; x=1697845831;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVucjE2yjEUScH3CxBlb1yDLAQs8UXrP8jjUHECcl9E=;
        b=K1KvbPIkzodnSC0c9uLCz63Le02xQZx5gKW/BaxZqTXpjCvJbvFHKp6v1y7zADCWBf
         ItZqCLtk46CpSNhMy0tZWNiND4Z1iALqiieN3SuSfvMhMwZ9XCxg3pK1DTGwPAoFXMKg
         UeI7Z0g04cKJ4Z+Df1OmqzqT8uaoar3aOaV744/L+5dRkHso/rm+7jqgElj1uQS1+zot
         92ZwRWQp5VkrXjMtyliLNVY/rAoUXF0STajnAMYuialFJSP1NRe8MBbz+acKwRt6HXFK
         J+SuWmHMzuuez6XgLtlz1G9SjXg/XgXEk3WvT9+Udn866CK2BMNvq98OGIp6I8twSQHm
         KCdw==
X-Gm-Message-State: AOJu0YwOD2SfbTlsx+spC7oXtUiiURJlo4Twkbq/gCsedd/cJ5xusfFl
	zV0ATUj9oOVboH9Es4aHvG8dWVIWLihatqoy2hM7VFu3ItAY
X-Google-Smtp-Source: AGHT+IE3mNXgUnbffBl6NSf5U/f6BkF5zcp3zWCtahDMEOqUgDVEwA664Ic/SJhZmaojLteaqQnARfehrtWV0EEV2R2SYULgmyRN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9881:b0:1dc:e729:66f7 with SMTP id
 eg1-20020a056870988100b001dce72966f7mr9518941oab.8.1697241031086; Fri, 13 Oct
 2023 16:50:31 -0700 (PDT)
Date: Fri, 13 Oct 2023 16:50:31 -0700
In-Reply-To: <0000000000006a3d0d060785f027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c19b400607a1b88c@google.com>
Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From: syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
To: SHA-cyfmac-dev-list@infineon.com, ajay.kathat@microchip.com, 
	amitkarwar@gmail.com, aspriel@gmail.com, brcm80211-dev-list.pdl@broadcom.com, 
	claudiu.beznea@microchip.com, davem@davemloft.net, edumazet@google.com, 
	franky.lin@broadcom.com, ganapathi017@gmail.com, geomatsi@gmail.com, 
	gregkh@linuxfoundation.org, hante.meuleman@broadcom.com, 
	huxinming820@gmail.com, imitsyanko@quantenna.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, kvalo@kernel.org, 
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sharvari.harisangam@nxp.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 7b0a0e3c3a88260b6fcb017e49f198463aa62ed1
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Apr 14 14:50:57 2022 +0000

    wifi: cfg80211: do some rework towards MLO link APIs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fdd89d680000
start commit:   ce583d5fb9d3 Merge tag 'for-v6.6-rc2' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1003d89d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fdd89d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a58e5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170cf875680000

Reported-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com
Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

