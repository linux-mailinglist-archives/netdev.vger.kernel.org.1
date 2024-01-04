Return-Path: <netdev+bounces-61669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B36D82492A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AAD284AD3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6200C2C859;
	Thu,  4 Jan 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="phGW+BPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342F2CCBD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so1467145276.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704396980; x=1705001780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEUinSrKMm+v8zfgDlMdzpma67gTTKJWypNCCmuEFE8=;
        b=phGW+BPreJYZ9sbCSTdH2YZGbsAtXMufLpG7HC65lkx00v4BwtNyX3GPKtQ0tZ9oFy
         YZwaj2EWRh8KmqPsecO3RvW8FhIbZ3lSiWgcEBu0Lg9JGIT1JaLPmt6Sit3C1n+9c753
         uNbUw37An0PCOq6jH0KqjwGd//IY+QJBN176kRbMXVSeplE8e4Tgn2O/cRpPyNsIFS9+
         HpJ34vjC4nt5AfTNNZ2EAFcyVMuB5NsBY5ewJ4Bw+g73yigKOys4wLSM8h9UDkKskc/a
         +MzPanNbV1Hz2r6PFg8ozofQNZQ8+UwKlOf9KWdOltjbHwO1p+q5zxZVhOsHzHfa7hsA
         qgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396980; x=1705001780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEUinSrKMm+v8zfgDlMdzpma67gTTKJWypNCCmuEFE8=;
        b=F0rtOu9wD60CKqzSXh8Sa/aa9HmLiGnY/Yh4eDl4CnRTCGJ1Vi+yUQL35tRRTC8e3t
         wTLvKEv1dvlA1mNW2vZe+m1XungTfRghVHstQfD1xP0W+nRQQy515CZIalvFdXfGlh8G
         DPIqH5iWOm8y+gSErm85iiUPLkHru3OqPphhpg5VGZPJLfhO0glN932KOn+cYT7JmQy7
         cCB/tM5LiHPeazgc5pt5A2I7MpKyTdtYMCN4qdE1i/DGNOuiRoCD1E2dTshy/yecMraD
         dXFjFnFV1QKnCp2rueGC+z5yQjvq+eysDBCUvH3ATjpBxaIxV/ZwG6opbaUOI7eqLtTH
         YdVA==
X-Gm-Message-State: AOJu0YyTuI5/cgw412v83dZhAfgqf9JoHbHB7cwi6KGAfCP5nlGaRJ7s
	3Zb5/jmfkCyBy56LK3Bdh3QkpmyWVeFHukKLPjcfFdBx5QPk1Hu8tVUYSyU=
X-Google-Smtp-Source: AGHT+IGHDsvG+ZHHsoC5S6kvVYzCQ5ewFL/85hCxvLXroOuvNqrUGJ0jHS0bVF3jEGN6Rl/rb2on+FMa6YI+IoD7OwY=
X-Received: by 2002:a25:b295:0:b0:dbc:bb00:5f91 with SMTP id
 k21-20020a25b295000000b00dbcbb005f91mr833408ybj.23.1704396980731; Thu, 04 Jan
 2024 11:36:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <b0a7aa1c-9767-412e-8f79-8a703a9a05b5@mojatatu.com>
In-Reply-To: <b0a7aa1c-9767-412e-8f79-8a703a9a05b5@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jan 2024 14:36:09 -0500
Message-ID: <CAM0EoMkRu4-k90CbJbGWE+N0yy1M-NtzdN1vDohNfnK-TpMgig@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	xiyou.wangcong@gmail.com, pctammela@mojatatu.com, idosch@idosch.org, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 2:27=E2=80=AFPM Victor Nogueira <victor@mojatatu.com=
> wrote:
>
> On 04/01/2024 09:58, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Inserting the device to block xarray in qdisc_create() is not suitable
> > place to do this. As it requires use of tcf_block() callback, it causes
> > multiple issues. It is called for all qdisc types, which is incorrect.
> >
> > So, instead, move it to more suitable place, which is tcf_block_get_ext=
()
> > and make sure it is only done for qdiscs that use block infrastructure
> > and also only for blocks which are shared.
> >
> > Symmetrically, alter the cleanup path, move the xarray entry removal
> > into tcf_block_put_ext().
> >
> > Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking inf=
ra")
> > Reported-by: Ido Schimmel <idosch@nvidia.com>
> > Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> > Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
> > Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88=
e@gmail.com/
> > Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google=
.com/
> > Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google=
.com/
> > Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google=
.com/
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

