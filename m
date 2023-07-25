Return-Path: <netdev+bounces-20847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5D76190E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CACF280DF9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEF1ED48;
	Tue, 25 Jul 2023 12:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591C8F4F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:57:29 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472413D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:57:22 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5b92b4b63so4123437b6e.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289842; x=1690894642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOw8M5MEfuKWRaEOU1htxwvLHkFjQE/8NWsGwEPUhhQ=;
        b=cwdlsKSuhUUZ0ZeXDP0yEcWIcHRp7UH9cat495kGaJMBntS/GGbngYBJHsc9V9mCLu
         rrz34QSDNvJXh92QEpEuTMRpzVGmm9lgTt3NHP84pnlQarW4XE2MplWSoGvvnQajqdt9
         NCnNLqH01YO0GPAK3svtWrzHNE2/auY11nZQedlnvjsZFRIWT6Uh/kVSK0tLpTxcCsUk
         63SpgfWgPh7BQdzDgJfNisHm/dWqR1S4fznhhWXMjnxxzoIMt4j1IdGbGU7FGnWgR3dM
         JuNtGbyclLVgC6OL6Tx1/r4gopfU1Jl2D4HHLiGAoSkjTE0juwl6BmF8HIqoIIbEmDWl
         VMMQ==
X-Gm-Message-State: ABy/qLZlPf/id6eg8T4AYCSAxma3ik4f43rhuxB1h3NyZk3SI1rjVPqC
	UzxrPjpRtObOXMUQx62W4WNGsIUJ1vB5TqQowsHxkdcOl8ph
X-Google-Smtp-Source: APBJJlGT5ZLlw0oGMTwCLMxeRVwuZL4LAuQ2BEQbUtmWWbEDKq21tCrSij87dhru4aCbHfthAYp+54z2UOiiNwEt9tNqBfQ6biJk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13cf:b0:3a5:a925:80a0 with SMTP id
 d15-20020a05680813cf00b003a5a92580a0mr18099491oiw.2.1690289842333; Tue, 25
 Jul 2023 05:57:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 05:57:22 -0700
In-Reply-To: <0000000000000cb2c305fdeb8e30@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009eae2406014f451d@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
From: syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
To: alexander.deucher@amd.com, davem@davemloft.net, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 30c3d3b70aba2464ee8c91025e91428f92464077
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Tue May 30 16:57:59 2023 +0000

    drm/amd: Disallow s0ix without BIOS support again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ad506ea80000
start commit:   ded5c1a16ec6 Merge branch 'tools-ynl-gen-code-gen-improvem..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=e79818f5c12416aba9de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c6193b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c7a795280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amd: Disallow s0ix without BIOS support again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

