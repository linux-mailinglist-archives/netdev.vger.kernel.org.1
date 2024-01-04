Return-Path: <netdev+bounces-61660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A382481F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD233B241A3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947DA28E24;
	Thu,  4 Jan 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oN98fxAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962782C6A6
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbe02bb7801so705406276.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704392580; x=1704997380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNMLqvav7zGTiOoMm95LsW5xUXppJOdUUrzamQ5bRkI=;
        b=oN98fxADs0gr41YT1y8I5chY+V82wdBVD8/PPxaHreepqcb7nkHckOjEhTDlH5XnhE
         M4KW/vA0Cslm27imIhAC2d4P2E1ihyNbR0YwCn5+P3w82Q5Cwo33AB4bsmQCbNqbcUVz
         kg2QBiy8Y+vJL0VT+h9HgncuacjsnKIWyBOvPstGhd+gOCiVykM6EtCEMQfmIqIHeNdx
         PjgrNm3MNzJIo5EIKEGRIJhJJuyFWQ4PGahHu6pJIJgV2ygqK2Q+UfV1uTdlkL40Ze+J
         /maP7s9n54zZYDfRQ054CGm/YvcZinFQD8SC0LdFsF+i1Sj7Ew0xzQI3cFoMf1FUpgtG
         1Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392580; x=1704997380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNMLqvav7zGTiOoMm95LsW5xUXppJOdUUrzamQ5bRkI=;
        b=LxIjDWkfeST4yn4MvyaJs2J9wQ8iwA2H6GPBmVrUrP/mDmdwNVncUVAHlCKNOJsMwb
         h4tr6GNNs9DFu2a//2pW8L4xiIkBO1hfcgRL0j2+6hd/9algwvJBCFhYjcihLVumwL5a
         mrM5p9uikgYjU0TkQrrEgrE8Xqz77Qt8QtinW4+pQ/tXU4GN1O0zXaQh0E+YqmcSRgQJ
         DCeaQcZibjc7rggPIa8QZrCQoYXQq2n2I1KVnZ6ds3FjSZlk0CTpa9m7m7N7aoFommKy
         y3pcr/TMb9pS6oaUWREeteG8usqrkEljsfGpiS46q7ubxpfz+Ga+y7V0sioDhLVEeHbd
         0tUw==
X-Gm-Message-State: AOJu0YyX8X+CUHZGj9hWAIqF/LSqSeHRbS4FBKJ5n8BfN9yS9n4ATnY4
	aD8LgpEbc6RMuTN2EGu7GoGKFav47e6NAalwrglT2gNqpsAL
X-Google-Smtp-Source: AGHT+IEwymGOfakokySH5A+A/H+0w5luOtw10DHz4EBfgtxXjM0bFyN/f1OaYrWMYpmGY9IuPoWdEnIJ3+HKZwnBvUc=
X-Received: by 2002:a25:bc86:0:b0:dbd:56f8:16f8 with SMTP id
 e6-20020a25bc86000000b00dbd56f816f8mr832742ybk.3.1704392580398; Thu, 04 Jan
 2024 10:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
 <ZZby7xSkQpWHwPOA@nanopsycho>
In-Reply-To: <ZZby7xSkQpWHwPOA@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jan 2024 13:22:48 -0500
Message-ID: <CAM0EoMmCn8DpMzPCt9GMW16C08n8mfM8N==pfPJy6c=XgEqMSw@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, idosch@idosch.org, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:03=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Jan 04, 2024 at 05:10:58PM CET, jhs@mojatatu.com wrote:
> >On Thu, Jan 4, 2024 at 7:58=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Inserting the device to block xarray in qdisc_create() is not suitable
> >> place to do this. As it requires use of tcf_block() callback, it cause=
s
> >> multiple issues. It is called for all qdisc types, which is incorrect.
> >>
> >> So, instead, move it to more suitable place, which is tcf_block_get_ex=
t()
> >> and make sure it is only done for qdiscs that use block infrastructure
> >> and also only for blocks which are shared.
> >>
> >> Symmetrically, alter the cleanup path, move the xarray entry removal
> >> into tcf_block_put_ext().
> >>
> >> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking in=
fra")
> >> Reported-by: Ido Schimmel <idosch@nvidia.com>
> >> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> >> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
> >> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c8=
8e@gmail.com/
> >> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotm=
ail.com
> >> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@googl=
e.com/
> >> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotm=
ail.com
> >> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@googl=
e.com/
> >> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotm=
ail.com
> >> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@googl=
e.com/
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >
> >Did you get a chance to run the tdc tests?
>
> I ran the TC ones we have in the net/forwarding directory.
> I didn't manage to run the tdc. Readme didn't help me much.
> How do you run the suite?

For next time:
make -C tools/testing/selftests TARGETS=3Dtc-testing run_tests

We'll let you off the hook this time. We'll do the rest of the testing.

cheers,
jamal

