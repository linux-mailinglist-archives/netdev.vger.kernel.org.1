Return-Path: <netdev+bounces-18669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF797583F3
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5FE1C20DA4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E571615AED;
	Tue, 18 Jul 2023 17:58:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B061134BD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB0C433C7;
	Tue, 18 Jul 2023 17:57:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kpxCgze3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1689703075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3DDMndpyGQ9Js5DGZvxnMtOBjS6KRA0SgH3Yn0/Ifk=;
	b=kpxCgze3//UDLfXXgnuNrv610j7ULn8L+B+24oWcd835YN8n7rX6hFjjd24pY9PvFlifiM
	GEomOZNUeCUiuYbUEp1z3t7XGCUoO2PGOI/rccRKEORgBfRf+MCulHD2aPmRdvZO1U7yx7
	5rs9GGnKNHQtYn6kOwqa0FfqeAdzxMY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54d611f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jul 2023 17:57:55 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so4975091a12.2;
        Tue, 18 Jul 2023 10:57:55 -0700 (PDT)
X-Gm-Message-State: ABy/qLbpIPUmBGdPVREJdDb2S8xyD462a7debVsmW14UnCTeP5BPKZ69
	JBUwZ2ybpJJrmxjjHWtmRij3KU+tC/6RcDb+ohU=
X-Google-Smtp-Source: APBJJlEbE+jfEDYuzLdPmOtu5UXWbBGlbEEOaC0BX+lIg944+HdN56uIq7onSwd1wZz7Xep4OTrRvB60bolSKxN+89w=
X-Received: by 2002:aa7:c704:0:b0:51e:e67:df4d with SMTP id
 i4-20020aa7c704000000b0051e0e67df4dmr326904edq.38.1689703072538; Tue, 18 Jul
 2023 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002bfa570600c477b3@google.com>
In-Reply-To: <0000000000002bfa570600c477b3@google.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 18 Jul 2023 19:57:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9reBny-ufJp58uOg+KdMptircBRhLFd-N2KwxNUp6myTA@mail.gmail.com>
Message-ID: <CAHmME9reBny-ufJp58uOg+KdMptircBRhLFd-N2KwxNUp6myTA@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] [jfs?] KASAN: slab-use-after-free Read in wg_noise_keypair_get
To: syzbot <syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com>
Cc: broonie@kernel.org, davem@davemloft.net, edumazet@google.com, 
	jfs-discussion@lists.sourceforge.net, kuba@kernel.org, 
	kuninori.morimoto.gx@renesas.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	povik+lin@cutebit.org, shaggy@kernel.org, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Freed in:

 diUnmount+0xf3/0x100 fs/jfs/jfs_imap.c:195
 jfs_umount+0x186/0x3a0 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194

So maybe not a wg issue?

