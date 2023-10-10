Return-Path: <netdev+bounces-39390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF797BEF6A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E01C20A62
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E3181;
	Tue, 10 Oct 2023 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh6Inl8T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767917E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:02:10 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A084A6;
	Mon,  9 Oct 2023 17:02:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so57225251fa.2;
        Mon, 09 Oct 2023 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696896126; x=1697500926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDnb1p+glowcF71zVOlOG3V+bIV/ai4H1gZvWv2Y0Wk=;
        b=Qh6Inl8TgJn6SUGyQk/wF1dBTvT3oN1OPWB7iZztC0vw1CMSLe30mwi7zPntk1UCpf
         dbNqHn75lu4UbWF8PUf++L0ghkt+W9oiuI099sVAZfiWQ7Dvchnp1Tezv+jeEKPIR7VE
         dFcaQUzZ2C5O2E2HCW+qUaeovzO9C5XP/HoQk2WGRPaPBzga8H6xMrkC5MmTcHbkyQGW
         VIZVlEHp5eIl5Zpc1rrsgOUqKPEIdVGmc6E3wks6pfOcBFP4SKzfBrqDTVhQpD7BPMPn
         5GGMoSFw4nKf+qCRS2pM8KzQOU0uX6/C573l8FB3L2Y0wz97KZIR/T48tLyBtoTYWjSV
         asdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696896126; x=1697500926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDnb1p+glowcF71zVOlOG3V+bIV/ai4H1gZvWv2Y0Wk=;
        b=LfhcTfTGXMP9T0DLnsYW0CqmpssMsMPM2kF30/SWTOaOf7glxUxBPneqjK/dYurDyz
         iwpp1P5jKfRdUso6ojxWZwju5asOgZKqNW6ucm9CZWuK4eUoIR2NTJaSl4THj9UPV+sP
         DZKbNBzS1v31ED8/gU2hq2o8bRPEEFwWOgj7N+LRH9LtjiuivukbLrhK/gmJ27vFEk0G
         1gHeTYyTxTzeDiWDfzAKKUUTnUeqwgXp6rHgqQlUBGWG1YUW5/SqZC2DM4SCaoGDUqPw
         Qwz4yMTAn0bRN/mn2qF2iyxPQpXbrBCRWMgmuZGdx/uE/TPHy212xP4v2+fsDEpLZlGB
         T6Pg==
X-Gm-Message-State: AOJu0YxFX2Q6fUFv/WUcZQFtSbXkEDsj72mQEzhuQK+K19GtFC5OWE0Y
	oxaUlNerQADtCm6OyOgJXCdCzptQC0OHeT8REMQ=
X-Google-Smtp-Source: AGHT+IF+aZwlOMjAQJgZgnMUJ38QN5pEMIHjDdXYb1dQAkpabk8532OdjITUL5Bq/m7RpYz2asYp1TbSHngKE9JyhYM=
X-Received: by 2002:a2e:8707:0:b0:2bc:d889:2d89 with SMTP id
 m7-20020a2e8707000000b002bcd8892d89mr14554685lji.44.1696896125904; Mon, 09
 Oct 2023 17:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009134826.1063869-1-arnd@kernel.org> <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook> <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
 <202310091246.ED5A2AFB21@keescook> <15f6b85f-b1ce-409a-a728-38a7223a7c6c@app.fastmail.com>
 <202310091310.F560494@keescook>
In-Reply-To: <202310091310.F560494@keescook>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Oct 2023 17:01:53 -0700
Message-ID: <CABBYNZJYYoseM04eWd+rRVmyS1YbssHxt9bowkX544VXGcZUeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chun-Yi Lee <jlee@suse.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, stable@vger.kernel.org, 
	Iulia Tanasescu <iulia.tanasescu@nxp.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Oct 9, 2023 at 1:15=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Mon, Oct 09, 2023 at 10:08:01PM +0200, Arnd Bergmann wrote:
> > On Mon, Oct 9, 2023, at 21:48, Kees Cook wrote:
> > > On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
> > >> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> > >> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> > >> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> > >> >>
> > >> >> Sorry, I have to retract this, something went wrong on my
> > >> >> testing and I now see the same problem in some configs regardless
> > >> >> of whether the patch is applied or not.
> > >> >
> > >> > Perhaps turn them into macros instead?
> > >>
> > >> I just tried that and still see the problem even with the macro,
> > >> so whatever gcc is doing must be a different issue. Maybe it
> > >> has correctly found a codepath that triggers this?
> > >>
> > >> If you are able to help debug the issue better,
> > >> see these defconfigs for examples:
> > >>
> > >> https://pastebin.com/raw/pC8Lnrn2
> > >> https://pastebin.com/raw/yb965unC
> > >
> > > This seems like a GCC bug. It is complaining about &hdev->bdaddr for
> > > some reason. This silences it:
> > >
> > > -   if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> > > +   a =3D hdev->bdaddr;
> > > +   if (!bacmp(&a, &ev->bdaddr)) {
> >
> > Right, I see this addresses all instances. I tried another thing
> > and this also seems to address them for me:
> >
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3273,7 +3273,7 @@ static void hci_conn_request_evt(struct hci_dev *=
hdev, void *data,
> >         /* Reject incoming connection from device with same BD ADDR aga=
inst
> >          * CVE-2020-26555
> >          */
> > -       if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> > +       if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> >                 bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %=
pMR\n",
> >                            &ev->bdaddr);
> >                 hci_reject_conn(hdev, &ev->bdaddr);
> >
> > and also this one does the trick:
> >
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -266,7 +266,7 @@ void bt_err_ratelimited(const char *fmt, ...);
> >  #define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
> >  #endif
> >
> > -#define bt_dev_name(hdev) ((hdev) ? (hdev)->name : "null")
> > +#define bt_dev_name(hdev) ((hdev)->name)
> >
> >  #define bt_dev_info(hdev, fmt, ...)                            \
> >         BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> >
> > So what is actually going on is that the bt_dev_dbg() introduces
> > the idea that hdev might be NULL because of the check.
>
> Oh thank you for finding that. Yeah, it looked to me like it thought
> hdev was NULL, but I couldn't find where. :)
>
> I think the best work-around here is your "hdev && " addition.

Perhaps we could something like:

#define bt_dev_bacmp(hdev, bdaddr) ((hdev) ? bacmp(&(hdev)->bdaddr,
bdaddr) : -EINVAL)

Or the fact that we test for hdev makes the compiler assume it could
NULL? If I recall correctly we did that because in some codepaths
there is actually no hdev to use so it is passed as NULL.

> --
> Kees Cook



--=20
Luiz Augusto von Dentz

