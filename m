Return-Path: <netdev+bounces-17679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB0752AA8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179941C21423
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D6E1F179;
	Thu, 13 Jul 2023 19:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C11ED53
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:00:54 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7822D67
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:00:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so14835e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689274849; x=1691866849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpaS1t14ocFfpWfA4r7YMHKUrjpT8EG6McsCuyMXf0w=;
        b=h9CKt8tSLkeJqOlX42EdZhaSr8bEX0S67A2Fv1Ie4Tfvr7GPUEj9PsQrGnrr4No529
         b5LH5p9kuuAsBuL+n74M89Z1UxADUNF+ST35xiT0fUvhzcwX4BVrGup61WLB06Ad4Qyv
         qSFsiKabxnzIDjXfPxlJPO9uE3kHtgilGhDVUUOL1WsKtNrxU/HcP+vi2/I7SzxFCNnS
         e0TbzhhhT39vKFu7OA3UIDktN5kO/Ez3tWvdbO27cOwn46Yy7giRCn9e/xbzKV8CM9Y0
         ncoTdlOJnr+VxbIAbl6myJ7j14xK+FsXckuhrapTzOMvRdDGJfQBH4UTPq211e79UkEH
         KWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274849; x=1691866849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpaS1t14ocFfpWfA4r7YMHKUrjpT8EG6McsCuyMXf0w=;
        b=kjTQuT2yubBy+oKFIxkd2r0AtkzdpOuQotIX/55NptNKPsgEnTblXEkCztiE9AMU9M
         gIUMaZyKg3nJTyjQ5uV4C9Ft+y5BRXEd6M8PA2iBLnQbOsiF9tAqlSueGr/ZULdB3gxQ
         z0X/6Fh1BDivn1rIT0R13/F5yKYrIkk2q7G3NBkPMNLm5H7jSqz063YjWeYishYHA+MM
         9AFTM8O0LaZGI1kzz6tn5HetEOzl2NKGIQI3uf/2ftmvcpu5cabp0ZaeDV7mHwhvz9/N
         JMuXcO/14+5yxaRW/hj+EoFBQBWe5ez62Cqv0G0aTqaUHPai6MPUwiSZVyVX02Sao7zB
         g1+A==
X-Gm-Message-State: ABy/qLakl+m3IBcw6qW83a4SOtLvbnsJGV4SK/2YU1l357Mt3qLtyzWN
	CLR7/6UtY4v8d3Z3R3lu6DKjPQgKYLoudxStztyZ6w==
X-Google-Smtp-Source: APBJJlESmB4Lu5P8++T2+oASx3PmdOOp2AtvnTbFgHLS7YLoUktqE/L70NW9IqnTBuc0Qz9I3BB4CHYA2RnxaglJevc=
X-Received: by 2002:a05:600c:2196:b0:3f7:e4d8:2569 with SMTP id
 e22-20020a05600c219600b003f7e4d82569mr241283wme.5.1689274848857; Thu, 13 Jul
 2023 12:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c2dccb05d0cee49a@google.com> <0000000000005ac8fc060061f4c5@google.com>
In-Reply-To: <0000000000005ac8fc060061f4c5@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 13 Jul 2023 21:00:37 +0200
Message-ID: <CANp29Y4ANdDSd4R8u=H5GX7t+1WZr=a2pemZ-VwQRraknJ8Pew@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_free_ack_frame (2)
To: syzbot <syzbot+ac648b0525be1feba506@syzkaller.appspotmail.com>
Cc: casey@schaufler-ca.com, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 7:49=E2=80=AFPM syzbot
<syzbot+ac648b0525be1feba506@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1661372c912d1966e21e0cb5463559984df8249b
> Author: Paul Moore <paul@paul-moore.com>
> Date:   Tue Feb 7 22:06:51 2023 +0000
>
>     lsm: move the program execution hook comments to security/security.c
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1024a074a8=
0000
> start commit:   33189f0a94b9 r8169: fix RTL8168H and RTL8107E rx crc erro=
r
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dea09b0836073e=
e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac648b0525be1fe=
ba506
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15346b1ec80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D162e3b89c8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, this one is invalid.

>
> #syz fix: lsm: move the program execution hook comments to security/secur=
ity.c
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --

