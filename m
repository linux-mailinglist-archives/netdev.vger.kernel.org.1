Return-Path: <netdev+bounces-58970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC6818BA1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4623B224CB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7B1CF8D;
	Tue, 19 Dec 2023 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJ9Zb2XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C320315
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so14142a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703001284; x=1703606084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk5EdLhyt38pZfuik0Ss1id1m1ywXSvBSH4pMzHPXGM=;
        b=EJ9Zb2XWH1+9cUwtQff3bb9IbF5Y7iz/NFds4rs2oiUOpjmIwO63+q7Mip0IN5B3es
         Eo/X9/2WNPC63yya7Xino3Ldapq+xBL1qvriwG2EqB9Tws/LK+TOVe/tQw2iR3ucWknr
         lOx6n9kjVrdSYI1kbO22kIxyVW9Tl7FhwxBuR/tm6+AvNEWq9IHBMy5emArpKUq64DEq
         ZmY440oO74uoqkBU42V3AfGG64lys2zjghW4YDp6ESD8FQzs3cgh9HoSc9/wbqFxnKnz
         eeIrGsd3yQibMq3+v6A0PjjfX7dV+6T4PF+ChwF/JncwknlTuFyt2kxcAC7kpW0rN7rX
         QvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001284; x=1703606084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk5EdLhyt38pZfuik0Ss1id1m1ywXSvBSH4pMzHPXGM=;
        b=GOPSISRqs2QxAkXwJJRnJ/XF35GqCNdHwqtqWlHG4ZGXyx4weWRlRXJ0H3Xf05Ufsd
         hndwGBFTpqywU44+FcxSAVcMR65rYDutqzWeZS+gUsdiYjdaHyyVmb1/vPDejQChCWEW
         7r6sMt9cbBZW4Wk/jkwtzQEF+/OVDU+qK3hdLTGgHbAT9wenFgmbICedLd33e+G/V6L8
         /7Ri/TECOpKpXxDKe6k/ZvAFeOi+U12OYMozo8JoaVl5D+GTB6Vuf75HkttDMA7STTSB
         ografTr//fayKckCUYr8srBGf02QX0jNtPXx/bjzWPJ//PzAIxwg0CFPOS1VMIrhh1bj
         XuxQ==
X-Gm-Message-State: AOJu0Yx14EtkQj4SuOQQwSCxv1+T9FTH6hLWP8svoT/RU28/l8NEXmXK
	j4chNzg8PXjOhDeATgmGSiYlDUKCksiIyRX8OFQ3ikAFyZml
X-Google-Smtp-Source: AGHT+IG6kyBlOKQdUOaETO8OsLwdSv8eeAb37i/0LbWL3VA2Q+MxymIwm5h0Yw1/vyEjI9s9eeMQZSTC/8KpO4lCtnY=
X-Received: by 2002:a50:cd89:0:b0:553:6de7:43d7 with SMTP id
 p9-20020a50cd89000000b005536de743d7mr212979edi.6.1703001283963; Tue, 19 Dec
 2023 07:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-11-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-11-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:54:32 +0100
Message-ID: <CANn89iL7xHFsXMkK3+WCvun-KbYqBmUiOYNdk5w7_OVVRtV4vQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 10/12] tcp: Unlink sk from bhash.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now we do not use tb->owners and can unlink sockets from bhash.
>
> sk_bind_node/tw_bind_node are available for bhash2 and will be
> used in the following patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

