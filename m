Return-Path: <netdev+bounces-14018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8574F73E67F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D0B1C2096F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81B125CB;
	Mon, 26 Jun 2023 17:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A212B61
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:33:50 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5310CB
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:33:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b520329adeso11755ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687800829; x=1690392829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEHQhgpFKMsTuJO1gaPsFUGULqdk+UqIM1V+w6jylQY=;
        b=WUzQHMVReE+7A4jyY1OHrX/0XK8Ft81f92saQ2WzGhOBpqAeX8p7ZFDJAYogR/xgXU
         Gxq4BQN5vqyp72nWa2xagFM1sPp3129QmjdVNZe0Yer+4hztcXp6xGtu9SzPf+NARVTX
         g2X1EvTk+YsHYWY833qS7+mDs6ubDoE/EXpNUZ2/1PJYvlYRlWgdEI51uw9v+klQdRl5
         ZYGlzIgxA2WlQk+/tcc5+EuGKQGp+DDUhiA1CF6WsTr1HtLt0gukF9C82QWYQHC0+bLS
         AgVQdXd0A0aMUm1RS6ynoChTVtbgOaEgmoY5ALpEXnmF41csucRHEwmaU2B/R5exfUBR
         OWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800829; x=1690392829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEHQhgpFKMsTuJO1gaPsFUGULqdk+UqIM1V+w6jylQY=;
        b=alqaK3x1xcncYQO0pP3nT3KehJFAEsHY70EUQrRbykPQPMcnxc6ssBjvMKzjFmahPq
         PLcLxxNLEzQxIIAvQwwZwi59IkLuoKp56/OPkF2NkFeIzPX/E/0OqwhDNHhHis1oouqf
         2kO4oA9Ow+fABGLe3tXv7wtxIZT41g8gWeBAFKYaXUag9DXv9OPq3Ki66h6mZ5NHBxpm
         4bZOPGA2lfHQD8laqNMxWckl1THZs6g4OKOcVVuFoRL5f0EO6tcg9aiFvCaYlds/TfU0
         Jb4lMKc/7VCNU+sclfjFS9uZb8yQzP6HgO+KUirHvNtaPFnwC3/CFrdkzj7Xdi3dgrMs
         7+Hw==
X-Gm-Message-State: AC+VfDz7tVqAqbfBauqhAzarZRqXVPmZCj5hsr2REBuoiDQhRNW502jv
	lKf74PpC7knh9dls8kj/9x28qR63SFFdgnMil6SllA==
X-Google-Smtp-Source: ACHHUZ57Zos1qaGDmwDBGu9insDrkpZMQfA+N4jgHinvEqmUvezRmf4oeeqlM0rlA6hsWf2uxHtmht42Clzl+Gfa0L8=
X-Received: by 2002:a17:902:da92:b0:1b3:e003:be96 with SMTP id
 j18-20020a170902da9200b001b3e003be96mr1928618plx.21.1687800828760; Mon, 26
 Jun 2023 10:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626164313.52528-1-kuniyu@amazon.com>
In-Reply-To: <20230626164313.52528-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jun 2023 19:33:37 +0200
Message-ID: <CANn89iJKB7_ZZx7ezakK03jjeYV-FkhuJU6ir8-h+XDGr2=qmA@mail.gmail.com>
Subject: Re: [PATCH v2 net] netlink: Add __sock_i_ino() for __netlink_diag_dump().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 6:43=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot reported a warning in __local_bh_enable_ip(). [0]
>
> Commit 8d61f926d420 ("netlink: fix potential deadlock in
> netlink_set_err()") converted read_lock(&nl_table_lock) to
> read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.
>
> However, __netlink_diag_dump() calls sock_i_ino() that uses
> read_lock_bh() and read_unlock_bh().  If CONFIG_TRACE_IRQFLAGS=3Dy,
> read_unlock_bh() finally enables IRQ even though it should stay
> disabled until the following read_unlock_irqrestore().
>
> Using read_lock() in sock_i_ino() would trigger a lockdep splat
> in another place that was fixed in commit f064af1e500a ("net: fix
> a lockdep splat"), so let's add __sock_i_ino() that would be safe
> to use under BH disabled.
>

> Fixes: 8d61f926d420 ("netlink: fix potential deadlock in netlink_set_err(=
)")
> Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D5da61cf6a9bc1902d422
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

