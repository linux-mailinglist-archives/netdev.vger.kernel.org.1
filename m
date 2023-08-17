Return-Path: <netdev+bounces-28313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8177EFC7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 06:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAFC1C2125F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 04:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD7801;
	Thu, 17 Aug 2023 04:19:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E22638
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 04:19:44 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C282D58
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b30377d94so8633372a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245982; x=1692850782;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5174e1lhoEtAOJSx6OzZg8YIf4r3sHHxcBtCy/AqYyo=;
        b=laL5U1gwykbm6HFMDhSCpiLTYsfXmkeKpl60vHG0pzj/SSx3oksYz6BK5edmaZ9JMH
         UwznCBPqBn8VTF1EptHVai1ojs8aBZMhuD5x5nBvn9Hmh+uEBQPih7pp4sn8EUQ8BEDw
         yFR+jgLCgkTxKYIrVivfHl/R10nEGd8QUsYbwQjuHNO7HAbrXQsahCXs0yWftE5D9jZ4
         W2//X5lqSp7bGJrS4EU0W+OXRLICarenGGYk9hAKzAXARlBTTjizH1rXQoaaIUvEdHyM
         5zxDB8n5kmOmjPcN4cH1r+vutTdVrHDCPx/TNwz39TApT8g2gzwCB0b5GiBETCySkB27
         9YHw==
X-Gm-Message-State: AOJu0YwESfAdFJHxoB1gm6xDpgEHsQkRsNA+nC2J1zlbDsMTM2F5DgkX
	oxgf6V7daXBnpyi2MoTEc4SFhDHwtr44sytmZ4IRrLVznCXg
X-Google-Smtp-Source: AGHT+IEZTSdaa9kcYRvTXFZpDfiX5p9rZQWqGwpWUOdqE4TBv2CeMoaYVGf46u3LVELNCiS2dd8ME/kduWdrJuI3NqGAvxNOuL9V
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c901:b0:26b:5182:d042 with SMTP id
 v1-20020a17090ac90100b0026b5182d042mr837650pjt.2.1692245982314; Wed, 16 Aug
 2023 21:19:42 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:19:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a60932060316b8f1@google.com>
Subject: [syzbot] [net?] WARNING in dev_index_reserve
From: syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, leonro@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 956db0a13b47df7f3d6d624394e602e8bf9b057e
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Mon Aug 14 20:56:25 2023 +0000

    net: warn about attempts to register negative ifindex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f68f03a80000
start commit:   950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e8f03a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e8f03a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be0117a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14950727a80000

Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Fixes: 956db0a13b47 ("net: warn about attempts to register negative ifindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

