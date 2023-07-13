Return-Path: <netdev+bounces-17667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C2752A01
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803F71C213D2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3B1F19B;
	Thu, 13 Jul 2023 17:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295C1F173
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:49:33 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5678E2720
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:49:32 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3df1e1f38so1715734b6e.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689270571; x=1691862571;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpXZu9kLoCoL0GAf9Mkv1VSpnIG+XGAoWicN/hHKyA4=;
        b=gKQDBjWjhOEmHe1S+qAx+4tzdebgfUAqzrhk7S9DGCM2tQDChF+RBVY9WKPipjH20k
         Cv2oUgUV8J5xef+V2hbD7nQRVOwWlhqNuVkkLFvnJJEX+0/LtFY8FWBXsqUYQ3bizM5/
         VU/NC9Hii5b2YoYYvP31FQAyl9MGtRi/fv5zlXwn9S8Dqe5lJqRmWl8xtcBI6Ouc9kFA
         jXlYXHSfaliZVCpH+I6Tud5f4OqQwouFBEP/dKD6ZIvHGvIEXEyGji0gKfyTfRRVTms2
         W1mlSHLWMsNreFpx49k7530WIcgMlON9IbaeuqjIThkrNw+hNTw9lpySOx5ABMzk959P
         0m4A==
X-Gm-Message-State: ABy/qLYDpifXD/3R4p4lxjEpPGfbJnW02HGNboGFGJxTQUw5c2CyYBQN
	n6/B8cY4IvcW7u7b2QX8SCMUWwppiNKvov/cUApo+JS+O+EO
X-Google-Smtp-Source: APBJJlGN9W5XdNXXehBzjUnB4kBTA2iqNXiDhtVJyC/P38CxxXOcAxcnjlKaW1qshLuWFfQkyWklM43sW3RYct+1AdFj3tYAOsQS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8b:b0:3a1:edf0:c79f with SMTP id
 o11-20020a0568080f8b00b003a1edf0c79fmr2890448oiw.3.1689270571679; Thu, 13 Jul
 2023 10:49:31 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:49:31 -0700
In-Reply-To: <000000000000c2dccb05d0cee49a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ac8fc060061f4c5@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_free_ack_frame (2)
From: syzbot <syzbot+ac648b0525be1feba506@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 1661372c912d1966e21e0cb5463559984df8249b
Author: Paul Moore <paul@paul-moore.com>
Date:   Tue Feb 7 22:06:51 2023 +0000

    lsm: move the program execution hook comments to security/security.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1024a074a80000
start commit:   33189f0a94b9 r8169: fix RTL8168H and RTL8107E rx crc error
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15346b1ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162e3b89c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: lsm: move the program execution hook comments to security/security.c

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

