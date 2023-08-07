Return-Path: <netdev+bounces-24930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CB7722D2
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01B01C20403
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7AFBF0;
	Mon,  7 Aug 2023 11:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3CDF71
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:39:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4A268A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 04:39:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so97275e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691408299; x=1692013099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W+bofDGJlB4M5uPfge6sirfCHYwbUhgLAeHUFoaWIs=;
        b=oK6l60z3Y/5Wy8fWWjBLc/gvsatLjg8OEhPFkO7kO+u77JF6wUsxpXgdPSy9a5bo7W
         zKkWWxjj/9Wt3AGNzGGGSE3JL0YqxAwmng2sHl6++BVkQa6MRVUZ0pTuMkqhonqp7cVL
         ooxMdgywEpg3u69CuhN/PSltoIPqWxsH2dKODl/IJ+j0Qibff4MoI0VZG2s5MSIOLiMm
         Hv7xGb8InonKy5qRRtaVSo6bIJGE7CxKsH+pICSO4LHQ08tIoAyhjOS8H3uEcQsel7wS
         XV+KpClkKXgOdMvNiCEBdnDJNddhHbV9f0w3sYEdSkPRTNAEZZbjDntaHS60Jembj3gk
         6f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408299; x=1692013099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W+bofDGJlB4M5uPfge6sirfCHYwbUhgLAeHUFoaWIs=;
        b=edIVmc0ytPY5Vm8BkGpNEWPR4DNCJNqUDodj8GArS+4RLZP8FDNQ/xXnPikyqhugiL
         gxevraysxryiUiY6xCpziErSVGeyh0ub3ml8oGrHxMjJHiSt9X7rVyMHcGll92lDrvni
         V6vpr+EP7RoA4cchBn+MnedZhlutgyTDzNHrYPiofIs9pzw835zZdi1JJOFnrXNIDDRY
         LjlqbfWEH8ewjuguZWMkPCCqx5bUvGCPQ9nB5l62MtHP0KW89d0lvvKS8DObH79u0AKl
         GinbM/5BdT06kVy8dbOFIjMwzf7Dyqyg1+bKkQ2ctWSOVnAy5kxd6LYXWvzJ/g+aS+Ap
         m4Vw==
X-Gm-Message-State: AOJu0YzdeP9WIsmYEli9kKHf2X2mzw+35iM4f8jzafFGPEXtQZ8x26Ik
	kso3RJII2duBZGnPb7nACKN0B2UYCmemuJT+T08Evw==
X-Google-Smtp-Source: AGHT+IGmhutOzq3fC03uoNya0cqOJh4UT8fO+Jie4zzFpBH4+HCUPwSHATUE0aSXieDtSvPS6NpGxhP3oVmADaOnfiE=
X-Received: by 2002:a05:600c:1d13:b0:3fe:b38:5596 with SMTP id
 l19-20020a05600c1d1300b003fe0b385596mr143015wms.6.1691408299251; Mon, 07 Aug
 2023 04:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005003fe05a8af2231@google.com> <000000000000597f580602464669@google.com>
In-Reply-To: <000000000000597f580602464669@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 7 Aug 2023 13:38:07 +0200
Message-ID: <CANp29Y7srmhGbKYB_6Y5KvijXrgHtzU9NqKcBcnit0wLmvbdCA@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in skb_queue_tail
To: syzbot <syzbot+743547b2a7fd655ffb6d@syzkaller.appspotmail.com>
Cc: andreyknvl@google.com, ath9k-devel@qca.qualcomm.com, 
	brookebasile@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	kvalo@codeaurora.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pchelkin@ispras.ru, 
	quic_kvalo@quicinc.com, syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 6, 2023 at 9:38=E2=80=AFPM syzbot
<syzbot+743547b2a7fd655ffb6d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 061b0cb9327b80d7a0f63a33e7c3e2a91a71f142
> Author: Fedor Pchelkin <pchelkin@ispras.ru>
> Date:   Wed May 17 15:03:17 2023 +0000
>
>     wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1243d549a8=
0000
> start commit:   559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALL=
O..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddd7c9a79dfcfa=
205
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D743547b2a7fd655=
ffb6d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d5d7f4f00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D106ff834f0000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Seems reasonable.

#syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000597f580602464669%40google.com.

