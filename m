Return-Path: <netdev+bounces-51711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFC7FBD49
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E643282E59
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4405C062;
	Tue, 28 Nov 2023 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgHfHB3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C61735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfaf05db73so157225ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183253; x=1701788053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsh2mMUKOXR8rABG0J7/JCsvNsJy41xjQD3uPT5bxQQ=;
        b=WgHfHB3gtR4cQNfCXmT6g5D69yDeXnejdR9BJtKnJkXs8TBpaYH7O/2KKBSFlhsKui
         lmUVfK4uoM2Fn9M5TbUcyzZ2zCKz+sz2sM2svN8wAPJOaaQ+asuUVSrzi5WHn/lbFu9f
         806fxUWYtNJ3SnAAEJ3IFeATf/fFl/gJxZRYZcBxw2In+eoY3y96YqgXG0WnBBdZaVLL
         Ab9PdDVnHJvuGfnG/Kv3cBPn/L+w4V1MMgDxTFV3gaEhzqLjUTvwa5MdNBPKCgoPIKTr
         GKyZ8u5lWFTP4+cJGmFdJP/cRUDEVVsDq0oLU7MlkXVtSq3h0EGpq6zYe9rTY2Htq+iq
         RB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183253; x=1701788053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsh2mMUKOXR8rABG0J7/JCsvNsJy41xjQD3uPT5bxQQ=;
        b=vlYZahjCVgeP2PWMaV5hXLBKTX7cpD6VtOUomGfzUy8iQGfaKnS3SNxIq6bDHuKTkd
         Yy33d8hWAeMIToUZJ67UoJC6F8B6orv8ONNp7OVgfygLGSqIzRj+Qw9Daqb1Jzg/2J2Y
         Ivn/0XjPUeOW8q4GIkzVcGNVuG+Ny8FkyQl8LwG1iPzFlCXx+vlKCzJHpdb+iF41HGSJ
         jz4CR+qa51Bk8wz80TEgxBtrozgnSjlThTc2kxmNOtwZyp9S97XkeFjGsHdcmrXmQQFm
         X2soER+TyJW37BGg9r0sB4ECzWUJ3MDwEr4o9BQrG5zm1qjBbPUOw/6F/OsF9xNOjpIK
         32EQ==
X-Gm-Message-State: AOJu0YwAiGICa+43sluwbJGZ8jyITeVvT+4NMMCogSSZ4tI8fD2xXQsa
	wRqRfLQvNcusLhWOGZSDAuMzR5gwdJz9I186zAKdoA==
X-Google-Smtp-Source: AGHT+IGa7uI6oT3u3fJpJBJLDKtUv6BkE/bZhI/Oz3lcbQXkUrx2pktUUQxDz/STXFo5kafOwENu7BifWcNK7JUsFF0=
X-Received: by 2002:a17:903:4d1:b0:1cf:a032:aeff with SMTP id
 jm17-20020a17090304d100b001cfa032aeffmr891111plb.11.1701183252371; Tue, 28
 Nov 2023 06:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com> <20231124182844.3d304412@kernel.org>
In-Reply-To: <20231124182844.3d304412@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 28 Nov 2023 15:54:00 +0100
Message-ID: <CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 3:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Nov 2023 05:12:23 -0800 syzbot wrote:
> > <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77=
bc6c5ed5e6
>
> One nit - p9 is not really net.

At least it's not reflected in MAINTAINERS:

$ ./scripts/get_maintainer.pl --nom --nor ./net/9p/
v9fs@lists.linux.dev (open list:9P FILE SYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)

Maybe it could be worth it to add "X: net/9p/" to "NETWORKING [GENERAL]"?
Syzbot would then eventually also pick up the change.

--=20
Aleksandr

>
> Thanks again for restarting the reports!
>

