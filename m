Return-Path: <netdev+bounces-14025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971673E707
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409AD280E72
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D412B93;
	Mon, 26 Jun 2023 17:56:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBE134A1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:56:12 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629151709
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:56:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9b4b286aaso12505e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687802160; x=1690394160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KyqId0hy9n8ww7dcYImtfZGCEfGZtufQ6XSWSyML2w=;
        b=UWtA6BfqBZs0V7WU4CJsXSVx/DqY8RLqLfYuMZlc98E6LB0sbyhWRwGzRowIqb3fwb
         5SGmfJui+n46jrgKlCMTEBgO3XWs9VNxTAZO3zuBYF2gYwZA5Un1huHhl/12CyJGGmlc
         f2tbysJD8byNZvDVUxQ7lXacoxcNY9Z9g4/xPmTWLB1BFExo5WHNYu7gXcjGfPM4yT9p
         goqaekJCGUTzkMRrYE7bjxXPE7NTe5SOF/HMjEfz4VbBMv0eXLl/5h6YKAxn5lFuu/Ir
         goXiCjZrHj0/Q7ZIgI/cIaxmhMrZD5uOZoRx2mjLiqcX9KaOBlA+0b0UdDBnWdf9/2bL
         QZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802160; x=1690394160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KyqId0hy9n8ww7dcYImtfZGCEfGZtufQ6XSWSyML2w=;
        b=X2IbyrHVrvSwjYdVny6H6Yp/UbyH9v8FrWUQukeVJog0juclRHTWge0u7HJmWfCMeD
         wX+HVL6bAdida+sIVNdGqS+BDD91x0i9lPQ4S1o+Yo0YMNpXcBXFnC/Kpr/0X+Ua463T
         M/dI5Hek7ITvYMfvydSfj5i2HMgd3iyaJZjq7L7tX8T6MyxlYCiSh/Cvh0cWEOFSpEqj
         UhQ/82PLgRsgcvWMLRyd66m0g803pk340fCYR1F2Eh2fp5N1ymCuciQXZ4r1Jxfl0E6q
         W4mPCYKdZGe9i1MxzhmufLlbDTMrYwAIcj9mipjRE9zxW7zcQRIVbiL72eZsbRLlFd40
         90sA==
X-Gm-Message-State: AC+VfDxnafQzPknDtzhWB+nKH0P8DVaMrB1Qu9ULxC5J0DW3TmGHA7cb
	D/Uw5jQcvNmaA8vqOzuvNPXF5DLcNwizT3RhLKvVoA==
X-Google-Smtp-Source: ACHHUZ7fOtQqITnjUHE4upIpxoY78QOhNQWgm2nIIVhobHy5VsaUiiRz2ni1BkJ6rj6APH+79eaw69F6OE1YTga4dIY=
X-Received: by 2002:a05:600c:34d5:b0:3f4:fb7:48d4 with SMTP id
 d21-20020a05600c34d500b003f40fb748d4mr228125wmq.3.1687802159671; Mon, 26 Jun
 2023 10:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000302fb805fd180f4a@google.com> <d15cd98d8612e756b4c22a10394d680342512c44.camel@sipsolutions.net>
In-Reply-To: <d15cd98d8612e756b4c22a10394d680342512c44.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 26 Jun 2023 19:55:47 +0200
Message-ID: <CANp29Y6eSpawFhDhv2SW78PKhvCSke8z26=MYNdSu8V4vPSoag@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] [reiserfs?] general protection fault in __iterate_interfaces
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot <syzbot+1c54f0eff457978ad5f9@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 1:08=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2023-06-01 at 14:24 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13c96725280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6a2745d066d=
da0ec
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1c54f0eff4579=
78ad5f9
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1588e9992=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1013cbc1280=
000
> >
>
> Looking at the reproducers, there's basically nothing happening in wifi.
>
> So seems likely it's just some really bad memory corruption issue in
> reiserfs?

Looks like that indeed.

Let's update bug's subsystems on the syzbot dashboard:

#syz set subsystems: reiserfs

>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/d15cd98d8612e756b4c22a10394d680342512c44.camel%40sipsoluti=
ons.net.

