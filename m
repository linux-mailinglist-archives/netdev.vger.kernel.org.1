Return-Path: <netdev+bounces-44306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD07D785C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62E31C20A9A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C43347A4;
	Wed, 25 Oct 2023 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdwTAoy6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC427EFF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:06:38 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E92BB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:06:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-457e36dcab6so933686137.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698275196; x=1698879996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtBcd4EK8o/4SAJnz/Re0VYmWw9I9ktKq6hlhcjyGhc=;
        b=gdwTAoy6NqUv68prV+5WdsFrN0YwZ3mw3WuiGJseoMyZ/Mg8OB0aITiwFoJUWIt8TX
         IzhsALTrVGv8dOo2wLQ7/fbBdEvlMXxVeLbfF6m5Xa9vCWrIMUjMbMRuQb8aDa5e7eFO
         uyMTKK2LCGlCdi8wFkgMKxquzslQf90/LyMsGErLkLT3dQdmpk/BakZdiaG0cpsRbLwc
         1kkcYMAZ16usXZ0PXLDsrKosx74pKbLwm5gzt//a76eRBBy8kAqEFrRvDQPBgK2pQw2Y
         C2N43XIyoOSZsvAvSzcv01/MZsF1sw4qvyRBmWJb9K+6lkYH9jsVtpsdL2ezOsPljcF7
         0VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275196; x=1698879996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtBcd4EK8o/4SAJnz/Re0VYmWw9I9ktKq6hlhcjyGhc=;
        b=mfQqIPXo1uuVQJLqMOY0Lsun/sd+IgzFPX8cGujDauWUNZytJhoFbYJlP5atbcUtoe
         LNkfc+Ra8KysDghLOsY0d5GTeFIdV1SpSsAy/wkjiLeDllTrSNnGV6R8M3mxmeitoAk2
         l3gRfXeQkJTTSG6itVHbeUbnhgQ5VWZSNGV12t3mm3GQN3AdpKJ7pUvazUsYaVAhqdn4
         rXhkGAZXxFhqDWO8nts7uNctB42/+bAngHBFESTdoatBvVdLsh/KZZDQuzzU0kA+O+RP
         Pl+jofHJuAvcWO/VkG5CcxAltlAAfOlOmr1nbGu1OPGrpYW8vTyOrHTor1WOlVh7CqjQ
         4tgw==
X-Gm-Message-State: AOJu0YzRm1ltTaQoCkBYSVEyqjYXK9nOhH6FbBQnr2/d5Cr6QXUp14Uo
	Xt4dHt6MIVOXCQXNxSOCEL17I5F76xHPMEwZk3o=
X-Google-Smtp-Source: AGHT+IHztNvZ5WFdnLnmtTqu4tMS1cdCw316guNwu49swB3xMsVExeCYQXMlKWFSahnXoslCYA73B1duEmbVgV1izsE=
X-Received: by 2002:a05:6102:1250:b0:457:a98f:1e23 with SMTP id
 p16-20020a056102125000b00457a98f1e23mr507514vsg.8.1698275195867; Wed, 25 Oct
 2023 16:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com> <20231025160119.13d0a8c2@kernel.org>
In-Reply-To: <20231025160119.13d0a8c2@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 25 Oct 2023 19:05:59 -0400
Message-ID: <CAF=yD-JV031xfCDwb_=GG-i8+CR3OnQMCMTsMvWU0vwDtByB=w@mail.gmail.com>
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Willem de Bruijn <willemb@google.com>, 
	syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 24 Oct 2023 15:49:36 -0400 Willem de Bruijn wrote:
> > @@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap,=
 struct sk_buff *skb)
> >       int rc =3D 1;
> >       u32 data_size;
> >
> > +     if (skb->mac_len < ETH_HLEN)
> > +             return 0;
>
> I think this one may want 1 to indicate error, technically. No?

Absolutely, thanks. For both tests.

Will send a v2, with that Fixes tag too.

