Return-Path: <netdev+bounces-45337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C17DC236
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BBC1C203A7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4541D536;
	Mon, 30 Oct 2023 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QYpRhANy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A2179B5
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 22:00:13 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632299E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:00:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5afabb23900so37498937b3.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698703211; x=1699308011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl6sqkkoABwL8j4SqRZMYnBmV6Bv+iWE2PJFKhoRckg=;
        b=QYpRhANy+JNMyamRlCGUiXHlNx2IHowH0Cy9kALa3G+r9NbHeZUZLAhKQ0X444ogQA
         Jp9oVoEH/UrnkwsfBIVroHB2dG3718wU2af9PqNjPV4G50fzNcT4RiTgj8I/3G5r+JxF
         RBPdeiF8bkeRj2+onW7pTZnA+pXsDplo3bF0+vKdGyLZbPewXR4dfUBdctHD0xZQysss
         qQ9XZ8ozlZiXQ+K77arKLLaa1OQuYklOTLfGSE7BEoBDEMW0X/0bQyJeVUKbItcVRCJi
         zJMIBZVEbOhumZy2MU0wJOiiHs02X2fqgqzNkBxU7dX/XIDpOG4sKhk9yPCw5ZqcPI5q
         ywfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703211; x=1699308011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl6sqkkoABwL8j4SqRZMYnBmV6Bv+iWE2PJFKhoRckg=;
        b=b+n9ZEsyOl3zYFs+TefdPeETwYsddpfTgGEr3qRHVWY6qKRyo+2bNpm4EWCJ+nt7/A
         U3NxaVkmku5PGg4Hsms9aUnm0/kwER+nc+q8SXinaJc00TuFMoEdr86fbdDYNudGqINV
         mzozC4REGF+tO+Y4bPd/49W3D4OEeMaqKEToknrAzl1+i0ewURp6E7i3apMSYfcZ1w/j
         GgYlmYk8UCUBUS/pGR1+W7tiInyha+5ehNx0OsmaqsZC69dBwyJtjmm91s7IkP9UOp2G
         nnMpCSE9JSHyfwzuDZzggkXcvn53yJKQo2bjbCqkuvVY3xzN6fDiGhohZjtzPXlWgft1
         JZpA==
X-Gm-Message-State: AOJu0YwoSkMy9nO0nNNNhZNg3UdEyQvXjjHPoMhpsb0OVpjL4wCB569L
	3iIhu4QgLfYYh6BAw+RnRJpbsCtrfX3RLE8+hpAk
X-Google-Smtp-Source: AGHT+IEHNaD64e1BKBY2tf605KyQyK8JDATjsKkIBbGALDgeIlIz/WaVE3v3elWG/kwwdddXmmLCJjBKqymvgbKBLZQ=
X-Received: by 2002:a25:9083:0:b0:d99:de67:c3dc with SMTP id
 t3-20020a259083000000b00d99de67c3dcmr9656516ybl.2.1698703211378; Mon, 30 Oct
 2023 15:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTrm2shkh=FHcjnqFpDLFCoBwGfsyoSuDH3UFSOeZt+HA@mail.gmail.com>
 <20231030212015.57180-1-kuniyu@amazon.com>
In-Reply-To: <20231030212015.57180-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 30 Oct 2023 18:00:00 -0400
Message-ID: <CAHC9VhRM_-414uEaYjkMDRgWU9LbESuVzvC+KF-m=5zNTNvj-w@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] dccp/tcp: Call security_inet_conn_request()
 after setting IPv6 addresses.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dccp@vger.kernel.org, dsahern@kernel.org, 
	edumazet@google.com, huw@codeweavers.com, kuba@kernel.org, kuni1840@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 5:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Mon, 30 Oct 2023 17:12:33 -0400
> > On Mon, Oct 30, 2023 at 4:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > Initially, commit 4237c75c0a35 ("[MLSXFRM]: Auto-labeling of child
> > > sockets") introduced security_inet_conn_request() in some functions
> > > where reqsk is allocated.  The hook is added just after the allocatio=
n,
> > > so reqsk's IPv6 remote address was not initialised then.
> > >
> > > However, SELinux/Smack started to read it in netlbl_req_setattr()
> > > after commit e1adea927080 ("calipso: Allow request sockets to be
> > > relabelled by the lsm.").
> > >
> > > Commit 284904aa7946 ("lsm: Relocate the IPv4 security_inet_conn_reque=
st()
> > > hooks") fixed that kind of issue only in TCPv4 because IPv6 labeling =
was
> > > not supported at that time.  Finally, the same issue was introduced a=
gain
> > > in IPv6.
> > >
> > > Let's apply the same fix on DCCPv6 and TCPv6.
> > >
> > > Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled=
 by the lsm.")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > > Cc: Huw Davies <huw@codeweavers.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  net/dccp/ipv6.c       | 6 +++---
> > >  net/ipv6/syncookies.c | 7 ++++---
> > >  2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > Thanks for catching this and submitting a patch!
> >
> > It seems like we should also update dccp_v4_conn_request(), what do you=
 think?
>
> Yes, and it's done in patch 1 as it had a separate Fixes tag.
> https://lore.kernel.org/netdev/20231030201042.32885-2-kuniyu@amazon.com/

Great, thanks for doing that.  netdev folks, please feel free to add
my ACK to both patches in the patchset.

Acked-by: Paul Moore <paul@paul-moore.com>

> It seems get_maintainers.pl suggested another email address of
> yours for patch 1.  It would be good to update .mailmap ;)

Yes, I really should, thanks for the reminder.  I'll send an update to
Linus once I get the merge window PRs sorted out.

--=20
paul-moore.com

