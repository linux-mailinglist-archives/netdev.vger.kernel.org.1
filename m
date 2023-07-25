Return-Path: <netdev+bounces-20849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F383761916
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D8E2816EB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E701ED5B;
	Tue, 25 Jul 2023 12:59:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D51426D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:59:15 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E3173B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:59:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so74745e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690289952; x=1690894752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDsZSuqmM+rGTTq3XGxWZQLIR3riOkpSD8E9SwglKOE=;
        b=eEgaJ3PGFMgMtDL8tppMmm1dwf5hx4pCk1penH5gz3wKBQRxlBdCi5JzlGxR29Qyy1
         W05bxTpnhpfSzdDS2vrmktGgqjuKBoyakBDVmfyivi5jRg+xNFAxpd341k65RoV6eMDo
         7TkfaVR1WPXWBYEv6YFGMocbSLAlKs1C8alDwwVgOrNGkeXfWFsIYhOjkGmUVRPosv69
         2x+3iGRZWijDSiJgdwiP8NP/THF9ppFvA7bfuy5Dvc1HBvzVQWnflF1Lrq8p0igWRj19
         dwgHUQC6T8Owy9wUBOqjee76i3uXcp295YV08f2qRIbSODQuPR5BMO+JPaK4CLBHd21o
         Ic4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289952; x=1690894752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDsZSuqmM+rGTTq3XGxWZQLIR3riOkpSD8E9SwglKOE=;
        b=T2zrVpKeRgJeTiwCKuyQvvXGm0IG9TyS79C7IVu4XdiQKSS4pvk9xFYJ8/Rgdgeiif
         As8svMvqlfMiPP1eEHtTIjlRdVvqMwnADCnqysh6D7z0uLs9IfUHciW5TGX2I8OTisfA
         mBdSXQgm32ouPKAQ9WxfypEfEdQSd0JI3xrn2vO/vvOVH9FJv1H1QxPiYwYRPdEgLtxg
         jC6rdRIwB7pwTY7q+z6TzumM2I6ZDkZHvNAwT3W0F0I0dYIbGp08kXb7gXTzF7epKCaD
         +byPZf46zqeqMMF09i/mZIPuLf5TJ6sj0Gy2G0PAkJsrF7TtAvwmlCJRIYrY3FlXW6Ia
         T7kQ==
X-Gm-Message-State: ABy/qLZ92pHNH7ZyBVEHB9NuSY0N3SeC38JD5P/WeU2mMffPwsxg95ha
	fmyGtSU4/l3zLjTGWxD3AhrQEyF6O4BmmLaXig2UPg==
X-Google-Smtp-Source: APBJJlG9w9Bhd6k3m0KjdikxCNQJAaXn/pCg6GjVlrrAKs0CjdmP/TLCGF0kN5RwhXuRKmTs659P1g6WoKbZUtPtISo=
X-Received: by 2002:a05:600c:8612:b0:3f4:2736:b5eb with SMTP id
 ha18-20020a05600c861200b003f42736b5ebmr53184wmb.1.1690289951656; Tue, 25 Jul
 2023 05:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000cb2c305fdeb8e30@google.com> <0000000000009eae2406014f451d@google.com>
In-Reply-To: <0000000000009eae2406014f451d@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 25 Jul 2023 14:58:59 +0200
Message-ID: <CANp29Y4ytfDf7B58CMGZpzhhuJ-LgfyxuAzxK6-yrnRGsXTUQw@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
To: syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
Cc: alexander.deucher@amd.com, davem@davemloft.net, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 2:57=E2=80=AFPM syzbot
<syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 30c3d3b70aba2464ee8c91025e91428f92464077
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Tue May 30 16:57:59 2023 +0000
>
>     drm/amd: Disallow s0ix without BIOS support again
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13ad506ea8=
0000
> start commit:   ded5c1a16ec6 Merge branch 'tools-ynl-gen-code-gen-improve=
m..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D526f919910d4a=
671
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De79818f5c12416a=
ba9de
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c6193b280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16c7a79528000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, that's rather unlikely.

>
> #syz fix: drm/amd: Disallow s0ix without BIOS support again
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
d/syzkaller-bugs/0000000000009eae2406014f451d%40google.com.

