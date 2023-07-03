Return-Path: <netdev+bounces-15063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BEE74575C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558E0280CD6
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D2818;
	Mon,  3 Jul 2023 08:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C43A42
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:33:26 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC94DD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:33:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so60585e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688373204; x=1690965204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wriP2XUrnLtI+7GWf032nay1vqXA7Kps9xjESoFP7kE=;
        b=La84kUPlP1niN59EnYFq8q7DPZlQKSzPo2QQJikmqpprzPyCxAwb4E3IgXNjl9syuC
         dy+Du5m0kUXDwTNE/4d47X2h+yhuH7atqEyui2Uk1p1Yok/zepI4XhGjIcv8BPpaejjt
         7ifRc5TGcJ7nJqYm1u+jXjJDUReBJR5M8RjjooNvk1yz4yzrilCfDWLVUw4BsotNr6q+
         ferkveled2VUO31hgxghZUjLK3cE37d6p7Ku3yhsDgJveMSyLXYXB9oQgHK6BsooNsNm
         dLZGst2BPKcVQxBztDQQwmJjlh8LqBNf0/6MiXctIfVACrJVSZ6rMuM5p56N8BPUlswM
         FA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688373204; x=1690965204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wriP2XUrnLtI+7GWf032nay1vqXA7Kps9xjESoFP7kE=;
        b=iTvkFnrr9lwHa0ChBwslv26Dpsoh9E3KM1m2DZu9wCjw9tcK54FRoAQo89J5fedcpC
         pjxlP12SCt3zhhQQUWhLQ80MKjgK2cK0D31IWCHaXG++9rK7U/QvqdQEgyjCky9C2Z+N
         DR6IGOYpeWltoGA2sduFf3w8b0D4AJFIeJ7s7EvuL0h6qbQzD8FsbvyIyP0X8/Xp34UF
         BpQhJxwboJQxFpAxh6Pa1lAt2DoTClhx2XKxfAIcw+gKYlkDl4nC1gkiXRFRCVbN0MOL
         2EYS8fOeFZTqpwejxprv+mkE0z41lrgw3VYrW5GRM+XUZWkQcNC7p1amb5S7ZJ+Y8uCl
         ehMQ==
X-Gm-Message-State: ABy/qLZB3SqNODqy4pOISBUQjUz5nNpAEiBfAQ2q/N2E4sEAzSSILYRg
	iZITZJGjU7FkIhPaI53j82HP2mGr7javvijmvCd7LHJ+H7Akn7I+Ov27UA==
X-Google-Smtp-Source: APBJJlHCMX7Exg4kL0Im+kwDJxYL/zpztui5/XBZvyxdLBPkrE8suJFG7vi5iAaG+uYEYS0xT/xA9zGbhdTWyrNFh1I=
X-Received: by 2002:a05:600c:3b9e:b0:3f7:e463:a0d6 with SMTP id
 n30-20020a05600c3b9e00b003f7e463a0d6mr150843wms.0.1688373204036; Mon, 03 Jul
 2023 01:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703-unpassend-bedauerlich-492e62f1a429@brauner> <000000000000d2451605ff9093bc@google.com>
In-Reply-To: <000000000000d2451605ff9093bc@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 3 Jul 2023 10:33:11 +0200
Message-ID: <CANp29Y5KParuHYw2sJdDMXXP7zaa-ss1nPN4n5x2qxGJnhtubg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] net test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
To: syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 3, 2023 at 10:01=E2=80=AFAM syzbot
<syzbot+3945b679bf589be87530@syzkaller.appspotmail.com> wrote:
>
> > On Sun, Jul 02, 2023 at 11:19:54PM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
> >> git tree:       net
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11b1a6d728=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D924167e366=
6ff54c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3945b679bf58=
9be87530
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bin=
utils for Debian) 2.35.2
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/=
disk-97791d3c.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vml=
inux-97791d3c.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34a=
b/bzImage-97791d3c.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com
> >
> > #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-ou=
t-of-bounds in alloc_pid
>
> can't find the dup bug
>

#syz dup: net-next test error: UBSAN: array-index-out-of-bounds in alloc_pi=
d

