Return-Path: <netdev+bounces-53325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2F8025E3
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5111C203D7
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93389168DA;
	Sun,  3 Dec 2023 17:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D98EB
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 09:12:08 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b8b5b4edd8so985718b6e.2
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 09:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701623527; x=1702228327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnOA559cJsD74+jDbOxr5NeqaYT/3Or+g749X6dWlG8=;
        b=PlT7e6CLV1Zi+kE3cCBovDhhVOuA6Q1pJ4gjhKZVRS2Fyg6rfbnorD/AUdB1MM+Rch
         QC9ThkLe25TSsn301hYiGSA+cIzTrgsol6aqO/0KaslkJ5k05n2VMLb6wAC5yDtF0BVd
         9fRD0OVk+3tMQtgfshpkDAtjPLN5/+TCMGGP+SiW9kgCA0slvHhUeF74PJXW/9tpRrQW
         MZTM7NKVNI8HQf6enzbHw4sg2cAHn/mKPN2qpnX8lSzvu4ploKRTMF5DZS8qhldE2uMn
         eniBqWYcc/DYunScoeFeuC+zrODbS1lhKKsNksdxyB7ZrS7BQEHNA5e9kKuW3vc8hxRX
         y+/A==
X-Gm-Message-State: AOJu0YxQlxJASjD4RyBu1OGVq4Am70BujjL61Q4jMMtV9RtipGys9aRi
	E82J0ve62rr77zglJz/UYznPTTVOKWqR4TNllkZdX65ewJkD
X-Google-Smtp-Source: AGHT+IH3w+druH4uU8r+K5NJ9qcpom8kNoVM9v6ZZSeyWL37VhQJ0+itbXF4vhBXyRu7Z4vNSKIwSHKDrjDQp8ZxDNH4icrTItQ3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:2b15:0:b0:3b8:b1e3:c576 with SMTP id
 i21-20020aca2b15000000b003b8b1e3c576mr1312744oik.5.1701623527802; Sun, 03 Dec
 2023 09:12:07 -0800 (PST)
Date: Sun, 03 Dec 2023 09:12:07 -0800
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea98f3060b9e19c3@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From: syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, emmanuel.grumbach@intel.com, 
	gregory.greenman@intel.com, jiri@nvidia.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot suspects this issue was fixed by commit:

commit 88717def36f7b19f12d6ad6644e73bf91cf86375
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Wed Sep 13 11:56:51 2023 +0000

    wifi: iwlwifi: mvm: add a debug print when we get a BAR

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161d9230e80000
start commit:   d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=9817a610349542589c42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eab18680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: iwlwifi: mvm: add a debug print when we get a BAR

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

