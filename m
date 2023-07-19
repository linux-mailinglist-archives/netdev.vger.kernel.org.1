Return-Path: <netdev+bounces-19126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1FE759CEC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB43281985
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A15156C9;
	Wed, 19 Jul 2023 17:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEF1FB5E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:57:03 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA41FF1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:56:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so7625e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689789414; x=1692381414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD1IusQWRz6p2k0vZ6mCPvoLmaSeWQRMjCUQkOWqtZ4=;
        b=tokZw9dfLqWCkA//xRWaD3/62VJCQvQV+NksrMsFB3gANBGXmcp0kknUxUY88Ja52d
         otMnaSRZyF0woIeqeePP9qQM7+7RxUCU0Hdaqq14PmVZzBVoY4EI5pz5tzaJj1UAFdud
         2NfcmFmW99tltTR6vU3ux+cnaAhdPEnNGa1vad8CwhiE0pM2UyKQlp4dr+wS4jQpA7bx
         uLakX3lCdxTDhkbwwVFfogIcAuDkY7ebx6HVutkOKNmLhW7/Vl30UzLarBnLCzXnR51v
         ls4NF1NRyc7kIsHAckEFx72s9UO15Ygztw90IMhfSekugKUEy86jP+gMGASY8Z1HbIJK
         XpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789414; x=1692381414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD1IusQWRz6p2k0vZ6mCPvoLmaSeWQRMjCUQkOWqtZ4=;
        b=lVodZo+y3WvJaFJpw3FqCs63/WSMQC3EdhphYOZbLU8t+vdyEfXWn4E4SmzuzlZQBg
         dbuvTwk4jVziJZJwaltYNa1mkRDvEKb9BIg/3ttIK/SUU3raRB6N4XuT8ieVd8j0s4LK
         SIqNcf2Ov/3BCC3cOt/onzm8mqNCievX+B4JkGBQmibzG9TxjRee4NV48eQXMRNYI/6/
         H3hW6CfooeSAPdqA0EcJNOar/gGv1biPJEJJM9Ko+s8q5YgShLq08jZ+y0nuF4sXUhcT
         cKPwm0DfKZkUWPaWxcQ7uSNAKkvTg+PGy9nOU36di5J9Uq9WgLB1zJfmtig/2yDkWsef
         4gyg==
X-Gm-Message-State: ABy/qLY7lrWL/ynXCnPLVerEX+itFRtB+eGeDn9jaGlCTpOy0X+s9pXS
	ToNMionZr4ICsiFSeXrkkQGMdn9+1P4rhL3DnRRgog==
X-Google-Smtp-Source: APBJJlG5bTRD5YkszX4iw8+wglBuRr66CaZUTcAakzDmbxj2WKqLn2P0+Qoo7JohL/GOWrxSJZrgc4+E+BQi5RXNWfo=
X-Received: by 2002:a05:600c:4754:b0:3f6:f4b:d4a6 with SMTP id
 w20-20020a05600c475400b003f60f4bd4a6mr4947wmo.7.1689789413718; Wed, 19 Jul
 2023 10:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ada87505fe7cf809@google.com> <0000000000002361ee0600da8ec5@google.com>
In-Reply-To: <0000000000002361ee0600da8ec5@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 19 Jul 2023 19:56:42 +0200
Message-ID: <CANp29Y6QHom7Db6y3azXS0MACKSW6hUQzypZs7qrB-3TtxO1zA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
To: syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
Cc: Jiadong.Zhu@amd.com, alexander.deucher@amd.com, davem@davemloft.net, 
	dhowells@redhat.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 7:42=E2=80=AFPM syzbot
<syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1dbcf770cc2d15baf8a1e8174d6fd014a68b45ca
> Author: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Date:   Wed May 24 03:42:19 2023 +0000
>
>     drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1622cafaa8=
0000
> start commit:   9a94d764e9bc Merge tag 'mlx5-updates-2023-06-16' of git:/=
/..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da4a7d74e6a7c3=
211
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D88f4b1e6cf88da1=
1f5cd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1152c4ff280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1307cbcf28000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, that's unrelated.

>
> #syz fix: drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

