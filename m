Return-Path: <netdev+bounces-18057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0916754737
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0BD1C20A4B
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095515A1;
	Sat, 15 Jul 2023 07:22:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4107A4C
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 07:22:24 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921C26B5
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 00:22:19 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b8a9860ba3so4031203a34.1
        for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689405738; x=1691997738;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deZLZrvEZSfc6NLa+Id53ZoNS1q+sg7vXw6lADs5UZc=;
        b=il9R/m2xxxR5S126VzdZAaHOUpijs0/BQFdip26lanSowpvabmBgBhWuyUOYpa1nTb
         Y9pIKHDcZ60eHTeULZ7NKBa8XG7TFC+LLUtvRZ7qREQ15d6ju6X7kJaP+RnmlaX0YCg+
         KjNUBzaq6m3M5eSOIID8KAybzsWX/a6o8dkTmfAHq+xvIIscQSvKjuEmZQB5F74c2Opf
         H04N7HQvWs9MVLVX0XuvXUY5TSi+bxFqM9E2jwfUPn0yYmpmhfuS3T+DV/zfGckY8XBE
         HmkLlgFnl4OWb8FnmtUCvkC6HMCsTxRewxhTi286DWhEYcMbeyNlJuRMc5uhgPVBujJE
         Lp8A==
X-Gm-Message-State: ABy/qLahM8abOJBdmV5R8EmUNCwOteNO4aHrwl/w02ClyempuTI+bJ81
	2UWF2FJtAafz7R8GeW9SKSbIKmOxXd7gEltNzxL84hoYLu1r
X-Google-Smtp-Source: APBJJlHH3FSfjH01K1UTktigpFdlK7JuDCmmfNBSiY8NRr4eGW+fSxrKOo/LJfiNFaYQXY2HWu5EgCuMiPB05g3I5MvkoHyT3gES
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7406:0:b0:6b7:4ec4:cbb1 with SMTP id
 n6-20020a9d7406000000b006b74ec4cbb1mr5640443otk.7.1689405738355; Sat, 15 Jul
 2023 00:22:18 -0700 (PDT)
Date: Sat, 15 Jul 2023 00:22:18 -0700
In-Reply-To: <0000000000000de35905ead6dcc1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea91fa0600816cb8@google.com>
Subject: Re: [syzbot] [afs?] general protection fault in skb_queue_tail (3)
From: syzbot <syzbot+160a7250e255d25725eb@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	kuba@kernel.org, kvalo@kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pchelkin@ispras.ru, quic_kvalo@quicinc.com, syzkaller-bugs@googlegroups.com, 
	toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 061b0cb9327b80d7a0f63a33e7c3e2a91a71f142
Author: Fedor Pchelkin <pchelkin@ispras.ru>
Date:   Wed May 17 15:03:17 2023 +0000

    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12253b7ca80000
start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=701f2aae1cb0470e
dashboard link: https://syzkaller.appspot.com/bug?extid=160a7250e255d25725eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482f0b6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e4dce880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

