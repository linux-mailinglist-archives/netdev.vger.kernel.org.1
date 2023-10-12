Return-Path: <netdev+bounces-40495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCF7C7895
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78F01C20AC4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6873E487;
	Thu, 12 Oct 2023 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACB3AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:25:34 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36AE9D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:25:30 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af7bdd319eso2208303b6e.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145930; x=1697750730;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3QvOYTxISpyAN6lBZKnAumWUoCDT9rshpzEVP85mU0=;
        b=IAjA1rhV6uEbBq+yZZ87R6PJaWuASfPV8Rn04vJevHRNSB+qm0pXvcaIuczVzmozKx
         lr/M39Y0zM5/8mKUuHhpe6zQ8S0HOTS5o6MoBjxJv8Ge05MEFqv/XazdsTL0vH0vkKVD
         V+XFSMzU6EyWVm1VyJ/6r2oJukxoADUk4F3lePe1SApaXX6V6zlZ3UbuQiFjqXtXFeKj
         cudkQrjvWmUh3PkboM7PxjQeH5cHWAEEdx22NrgVha680LGkUZQp+9sOKkkkg80GdnmG
         xbhci+BzUdiW8TuA3fodZ6bdMCB4eJz65+PRl/JCpGV+Z2sEG8H6SsKwmn2R7dQ3DjPd
         6cbQ==
X-Gm-Message-State: AOJu0YyNYByCtpe6bHf3aRiOGVqVDsEzEDUuTenNpg8iLweFCNnbcx/2
	x6nLPSkTmKse49UatVugPVZef8w/+CZXiz3DxDz7Bs5KxoS+
X-Google-Smtp-Source: AGHT+IHr9VDIw51thCNfY4Z/TaWoINBr61iwfFvvmuyI7d/MHpnu5HUkhyeevkB5Mp+bdpbYs9dP9oQ7BgdXZ0/HorlKMMmV8cNc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308e:b0:3ad:fc2e:fbc6 with SMTP id
 bl14-20020a056808308e00b003adfc2efbc6mr13661508oib.10.1697145930065; Thu, 12
 Oct 2023 14:25:30 -0700 (PDT)
Date: Thu, 12 Oct 2023 14:25:30 -0700
In-Reply-To: <00000000000006e7be05bda1c084@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b2b3d06078b94b0@google.com>
Subject: Re: [syzbot] [net] [crypto] general protection fault in
 scatterwalk_copychunks (4)
From: syzbot <syzbot+66e3ea42c4b176748b9c@syzkaller.appspotmail.com>
To: aviadye@mellanox.com, borisp@mellanox.com, bp@alien8.de, 
	daniel@iogearbox.net, davem@davemloft.net, ebiggers@kernel.org, 
	herbert@gondor.apana.org.au, hpa@zytor.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liujian56@huawei.com, mingo@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, vfedorenko@novek.ru, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit cfaa80c91f6f99b9342b6557f0f0e1143e434066
Author: Liu Jian <liujian56@huawei.com>
Date:   Sat Sep 9 08:14:34 2023 +0000

    net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17338965680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10160198680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15feabc0680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

