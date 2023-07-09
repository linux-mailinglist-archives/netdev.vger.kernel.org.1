Return-Path: <netdev+bounces-16237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2074C0CC
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 06:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FC42811FF
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 04:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65E187E;
	Sun,  9 Jul 2023 04:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6C185C
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 04:09:37 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D36E4A
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 21:09:36 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-666e5f0d639so4148067b3a.3
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 21:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688875775; x=1691467775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7q0J7G+yI5lmdgF+X7aufQLFQ3cYs8ipxCSvg9o7VM=;
        b=b9qZDrlJXtc+4NMwZwsX61PIjt0ln5USQF5OgdaOO9NkhaBM2VFUkkYpWpZQelknLa
         hoLgO7xYzkWwdI+TRrbICJm5APCunRTv2kWm/71jPG2els3NacAmzdtW6+fjcflb/Cl3
         Db0TZ+ia9Pz79aLMkwcP17ERQBLVz+sv75GTjmcCPrWJK7Sdc0sBq8HP8H9NBbl4AEB8
         aJVFbqxKw5w5foukm5T4Lyma+uxL5KxhYjujI7+TLsZIMARlaqqs+52SmT3Ml6R8y1BL
         XKgzOsXbiRy6xLj2XbDxoO5tAfsUBzxv5M+L+Fe/72DFLHeE8cGaVdcHFPnSCbA1ujCm
         HKQg==
X-Gm-Message-State: ABy/qLamUmRB5LNbeUwRBd6cYFqt/WDfTn8jAul/twE9qwrC9X1SB/Rk
	TSQIVsWvEyYZsrzxeS0iCFSf+GleWVrLhCJ5q0ypHvnqWiJ6
X-Google-Smtp-Source: APBJJlE7ScwMHQc7rQl3m/vhOqETjF/F63AB3cxj4/jZQIaXv/SjKsRxE6pYb/Cl0DHsdYhsfVgS5VlBlphx6XYqI8GqQo9hjrg9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9b:b0:678:e0b1:7f28 with SMTP id
 fb27-20020a056a002d9b00b00678e0b17f28mr12294027pfb.6.1688875775705; Sat, 08
 Jul 2023 21:09:35 -0700 (PDT)
Date: Sat, 08 Jul 2023 21:09:35 -0700
In-Reply-To: <20230709011213.17890-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae45de0600060878@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_vrefresh
From: syzbot <syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com>
To: airlied@gmail.com, astrajoan@yahoo.com, daniel@ffwll.ch, 
	davem@davemloft.net, dri-devel@lists.freedesktop.org, dsahern@kernel.org, 
	edumazet@google.com, ivan.orlov0322@gmail.com, jacob.e.keller@intel.com, 
	jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com

Tested on:

commit:         1c7873e3 mm: lock newly mapped VMA with corrected orde..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101196d2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f6b0c7ae2c9c303
dashboard link: https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e44354a80000

Note: testing is done by a robot and is best-effort only.

