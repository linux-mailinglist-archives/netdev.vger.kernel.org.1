Return-Path: <netdev+bounces-21101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30976275A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2797B1C20F72
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CE2770E;
	Tue, 25 Jul 2023 23:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B808462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:32:32 +0000 (UTC)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3C120
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:32:30 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-565d6b6c1c7so9692010eaf.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327950; x=1690932750;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAib9FhsF/p+ZXO7Hu3qYWPzTDSVp9gbYDlcfRv4tfU=;
        b=boKkI8tBp8QZysR2ECBzlLz4m7DZpfawcTInjdTAwo8mEIEtccHe/Ltj2CbVikZWkY
         xoO707G1AmGWP7EY5jrGYGuvJyBuUJUiCiKi0d8hZeC6AeKl2RlBpj+v73omtSHtOmRi
         sX3ubfIdsMwGrg9QZLIdjSLgqWACc0D5l5LTxVEQX3OAMFhjLFzU604aXz7VYAWuKt1q
         JJwpfh1ClJ28DHHXwCE2k6eu8u2opwkuAKtUiwcFig49R/trW30R8woiIs86pHPc0fw0
         iHHps8xP/K1NkG7C/tF3Vd3H6I3tTZoFFIpQ71gLJjp24t6FlBgeJxFq10PEWRo0cSrt
         NEDw==
X-Gm-Message-State: ABy/qLYqdlMnYb0bWYHeVaBPE1PazoRLuETtZL1Sz9QcI47Jqqaud8cw
	eLTpf0uiRh5B/pLA5cagI4HOWVkYnzXE9kdpfm5o/9vSKYba
X-Google-Smtp-Source: APBJJlFEYk/bqYGyuJAaHAL1JEWuUOwkkcZpbbHJ/FVewEDv5hVdmh7chgIV5DaFhIO4BzQtyA3NJlRpkIZDZVk0K+a5hwacR/az
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:4f8b:0:b0:569:d5ae:eb6e with SMTP id
 c133-20020a4a4f8b000000b00569d5aeeb6emr495681oob.0.1690327949950; Tue, 25 Jul
 2023 16:32:29 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:32:29 -0700
In-Reply-To: <0000000000000ced8905fecceeba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002c74d0601582595@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
From: syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
To: alexander.deucher@amd.com, davem@davemloft.net, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 30c3d3b70aba2464ee8c91025e91428f92464077
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Tue May 30 16:57:59 2023 +0000

    drm/amd: Disallow s0ix without BIOS support again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122e2c31a80000
start commit:   [unknown] 
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc501b7bf9e1bc09958
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f71275280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11081055280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amd: Disallow s0ix without BIOS support again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

