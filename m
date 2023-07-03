Return-Path: <netdev+bounces-15060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4A74574C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EDF280CE1
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73A1C08;
	Mon,  3 Jul 2023 08:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2317F8
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:25:54 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B21BB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:25:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so59665e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688372752; x=1690964752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp3fp1qSItiz/81j1Jn0Y8MmMEZQA55BLYUlwg/+odc=;
        b=yk2kmk3giv6AbVNYYmuOrSSV4ibY/DiCDzMFp6kkVVmyHJB/VgRqhSO2IHEsthpn+Z
         w0T32K3+/LrjO46wkWn/GlXUjcDlNKnNFudXIw8avOiz3YFQ5RG4EkrH2z/gPBGQD4QK
         +5OMT/V366rvNA3Z9nO4qm0rhpSnp20TbxHeAKbFa4zoLdNGLbffUoW0Yb79mMb29DZ5
         dCrigVVqTB5sKkl4oL4sedGs2h+sqO2r1exAnyrAxNenrqJn7+pml0/SgosMN5KD5iDV
         ELHb+6fqm0I48+KeTzV3lk8z8wuI0aahka+5tQXlUpUSjwW1OPd/scHDcWHBg4TqiCET
         IUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372752; x=1690964752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp3fp1qSItiz/81j1Jn0Y8MmMEZQA55BLYUlwg/+odc=;
        b=hOqc+biQQnUQZCIEgjoWhrHR7GqLmR3S2QRyT56GEBPlrShGB1vBEYwgI52Ix9bRY8
         8mJ/zPWpjrhdbym5vLiO5gItSL1yqdnvcVUYqiRXyF8Y1x3PSGGv1jBs79PTH3OA9vYM
         JEzfvbXJRtMaYcY4uD+meEWyHLl/EtMTO68uRiWHtUnSO5CPeGmUDG6lOyXDrrQS1bqD
         45KVk+Gf3bd/CUrVv0bGYBNkUppGioZBqg6+3+HC7D2xrTyfwVg8KqdOkE7mvGRODxBl
         0iXEDNvgkt15e3xG23cSIA+dT0gVlOr/34i5/BIU+iyv5+qP0tOPQlI3ZTX0KT2kGebT
         Id5g==
X-Gm-Message-State: ABy/qLYwSK4zgNspQOQWVyXxOcIqagzGXEzOApnZ7sT3dUgzhFrqV/hD
	fPpsvhH+p1EUm1SUU1+xiyU9bbEDPKT5g4bdyMeokw==
X-Google-Smtp-Source: APBJJlFBYWOLhrjQUwd+7EicrNp4kb6xDnv4wVbLgv4t0PscUrrTuqeYRl4SjoUM0MPqsLDIIkvD3dHia9umBOL2GoE=
X-Received: by 2002:a05:600c:8518:b0:3f6:f4b:d4a6 with SMTP id
 gw24-20020a05600c851800b003f60f4bd4a6mr114174wmb.7.1688372752025; Mon, 03 Jul
 2023 01:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703-richten-ehren-5a4c9b042a23@brauner> <000000000000b359eb05ff9094f0@google.com>
In-Reply-To: <000000000000b359eb05ff9094f0@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 3 Jul 2023 10:25:40 +0200
Message-ID: <CANp29Y7n1pmATF7Qeu7AnXOiidnSnOF5X8SY5af4x=CViDmfDg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
To: syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz dup: net-next test error: UBSAN: array-index-out-of-bounds in alloc_pi=
d

On Mon, Jul 3, 2023 at 10:02=E2=80=AFAM syzbot
<syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com> wrote:
>
> > On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link =
atta..
> >> git tree:       bpf-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D127adbfb28=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D924167e366=
6ff54c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D319a9b09e5de=
1ecae1e1
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bin=
utils for Debian) 2.35.2
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/=
disk-c20f9cef.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vml=
inux-c20f9cef.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f863418=
3/bzImage-c20f9cef.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com
> >
> > #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-ou=
t-of-bounds in alloc_pid
>
> can't find the dup bug
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000b359eb05ff9094f0%40google.com.

