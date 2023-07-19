Return-Path: <netdev+bounces-19119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86E759CA5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF08F1C210B8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92635111A9;
	Wed, 19 Jul 2023 17:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2F1FB48
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:42:32 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F310CC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:42:28 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a3a8d12040so11693774b6e.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788547; x=1692380547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GdSlJQiKv484CM7UIkrDgwXqQQM0s/UqcfPqk1L/74=;
        b=RmcSuzj4iOMXgXdhOyqlsFxrJg4Kp4gd+U/4xPH6rn6bMQZWWoVPfDEL5FCpJohArm
         zn0H6Jt/+LXUDrVta0stq+vaHJzFJ7YQujGj2xGIZvq0BRESNzhPc67yqaS1sQcfnOVi
         hibYxjE/tZFU6slA3X19aCdoRSyE4ehXd42zDYSbR+oSDD2sbj0lOFhQSVPhREXP4YVa
         PGMHZsGj0u81/ZPcIUwlLsbjSoDCcHcuMN7Sghv3iuPFArfjR9Spki/8wjfKpBWRQ/uz
         gfeH3mih2thaeZuG6sH0JsmOzU45j2OnXBqBzUT2nO62PPJ2CObFCMtlsM+mtX/tP4jc
         mMxg==
X-Gm-Message-State: ABy/qLbchHrlIzJjbHFK8H9ih39ZalhQczoiyp3QTewexNTooOQjesKR
	7XhFKi+L0/b2tNQxQUaQZv8UbtFd97Bniwdu6PfoacxNrr0e
X-Google-Smtp-Source: APBJJlGc+FLMHZg6mdALKsMlGrkkyQ9/UibmMwawm8SN0wVBXG3jpPAmimRjmmikWRK5g6vvUtlS7JtRmzwo7B46VeTGBSh53ppP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3013:b0:38d:ca0a:8e18 with SMTP id
 ay19-20020a056808301300b0038dca0a8e18mr28834819oib.2.1689788547816; Wed, 19
 Jul 2023 10:42:27 -0700 (PDT)
Date: Wed, 19 Jul 2023 10:42:27 -0700
In-Reply-To: <000000000000ada87505fe7cf809@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002361ee0600da8ec5@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
From: syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
To: Jiadong.Zhu@amd.com, alexander.deucher@amd.com, davem@davemloft.net, 
	dhowells@redhat.com, herbert@gondor.apana.org.au, jiadong.zhu@amd.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 1dbcf770cc2d15baf8a1e8174d6fd014a68b45ca
Author: Jiadong Zhu <Jiadong.Zhu@amd.com>
Date:   Wed May 24 03:42:19 2023 +0000

    drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1622cafaa80000
start commit:   9a94d764e9bc Merge tag 'mlx5-updates-2023-06-16' of git://..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=88f4b1e6cf88da11f5cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1152c4ff280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1307cbcf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

