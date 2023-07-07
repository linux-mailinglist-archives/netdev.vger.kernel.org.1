Return-Path: <netdev+bounces-15993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD774AD6F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71411C20F70
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887A8836;
	Fri,  7 Jul 2023 08:55:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C003C0B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:55:26 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91591999
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:55:24 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b8a4571c1aso17821155ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 01:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688720124; x=1691312124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP9O7wz2wVY1uz0Tz+tNVR7jOVmsLzGbSd5qvYHHqCA=;
        b=IsIKT1LoI7ryS1HCmLzJXPacBhUWEGOmDTBTV/3Bbn8H81nUn8AawH+stBGkiRnDNp
         qGlWay7lOPnsVPdgqfefoHsSGHZOAAZ9Dz+kzirK3QxImuQ/LQvqxFrGB2Tw6JbAsVDG
         T4cLieoEJfCdTlI7UouJPxYy/UdehGL3qOahCK/GZuu+oDJ6uYOmnE7jd/CGKSYkLJnG
         8ToMnob9Nm6AVyAFMwFqtmvmv+rg4zLkMM5woOdVlHnXCyjFTcjf7Aiutb917nvRLRZx
         24m+HJmKggIhVPnnsmhhvxYoXuSpPWmGVe1Vu4oihoitautQFvh41nJdm+DmQ2SRfUYR
         2rvQ==
X-Gm-Message-State: ABy/qLbfTXAkVxHCiCl8/EsHonYs4F0VyeSRcQbrpjrksX9oqjVICUkn
	jRGTJB95DHtqlB8NUaK9XCbSVSVQ53dW+RFUW/8u7bMQK5O6
X-Google-Smtp-Source: APBJJlE3GQMXl1cHyHg5lh6Nt6ubMsGnT10l3ez2+JBHtCWT+vZpFky6rzT2FyrUgqeF+q0zYYmCWBHisoQaeXrNjkKwW/DiQAaD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:c1cd:b0:1b3:bfa6:d064 with SMTP id
 c13-20020a170902c1cd00b001b3bfa6d064mr3877302plc.1.1688720124415; Fri, 07 Jul
 2023 01:55:24 -0700 (PDT)
Date: Fri, 07 Jul 2023 01:55:24 -0700
In-Reply-To: <2225033.1688717605@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024166c05ffe1cbb0@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From: syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, kuba@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com

Tested on:

commit:         5133c9e5 Merge tag 'drm-next-2023-07-07' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124f34d8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f6b0c7ae2c9c303
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1624cf4f280000

Note: testing is done by a robot and is best-effort only.

