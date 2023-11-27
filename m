Return-Path: <netdev+bounces-51324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A47FA1FC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A0128107E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7AF30F83;
	Mon, 27 Nov 2023 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjghdP8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22112F87F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A3C433C9
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701093981;
	bh=BmuSE7ZaTnrcYNfLlPXtccWvlof7sMxV8qH4uZPkv8U=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=gjghdP8QjzXnAQrZOI8uOZ/qIMhBMMRWwDC0YSWgK9z+X8GhIlrBlZ5ztAW6zUZk4
	 n6O1u2AWU+CFaadaYlrpB2UbG9XceHQKHBI1PPv4Xbh/u377/owi6nLG0LDiDlfFiA
	 mqomkYKZJIwbj4UGpq/0MTZtuGt8mv2m+MTTMQ1Wa6U1TOJEj0hA8HtmggQFP4xFZE
	 IdR4U+2WPEY/umN8R4HdjKqY0HIBvpvVYszM0XX9ZTRTsDE6Rpb5esoNGr1lNTv9yo
	 VpEU7V7MZ2BQTMOuLQAZC/oyNFdOFaBtwMEwhHh9r8WC33CFQ3k6a3yRgtl2oRDIS9
	 hdf5pjpadNsOA==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5cc589c0b90so42369797b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 06:06:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxmVq9ihbBTh9yFhN8Aee6wtNmfVx9NHQxvy8auLSxoMtwq/UyJ
	iyBw4SyiBiPjDu+bEQwfDxb2HabeDwCvIx3cEI4=
X-Google-Smtp-Source: AGHT+IGTZ6UEKvlqQWDyg5eno14eao8w1c0u8ZnRaTU1IIVNiEllou3Y4ol4rc1zECA0MbzzJwB0Oz2cddT3Fz9unTk=
X-Received: by 2002:a0d:fcc3:0:b0:5cc:765e:f4fe with SMTP id
 m186-20020a0dfcc3000000b005cc765ef4femr6499419ywf.27.1701093980317; Mon, 27
 Nov 2023 06:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122173041.3835620-1-anthony.l.nguyen@intel.com> <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
In-Reply-To: <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 27 Nov 2023 09:06:09 -0500
X-Gmail-Original-Message-ID: <CA+5PVA6FrzEy1RSMnHA_xixdOZDF19VZcuC1O9bMhdH39OXLRA@mail.gmail.com>
Message-ID: <CA+5PVA6FrzEy1RSMnHA_xixdOZDF19VZcuC1O9bMhdH39OXLRA@mail.gmail.com>
Subject: Re: [linux-firmware v1 0/3][pull request] Intel Wired LAN Firmware
 Updates 2023-11-22
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Mario Limonciello <superm1@gmail.com>, linux-firmware@kernel.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 7:10=E2=80=AFPM Josh Boyer <jwboyer@kernel.org> wro=
te:
>
> On Wed, Nov 22, 2023 at 12:30=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@in=
tel.com> wrote:
> >
> > Update the various ice DDP packages to the latest versions.
> >
> > Thanks,
> > Tony
> >
> > The following changes since commit 9552083a783e5e48b90de674d4e3bf23bb85=
5ab0:
> >
> >   Merge branch 'robot/pr-0-1700470117' into 'main' (2023-11-20 13:09:23=
 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware.git dev-=
queue
> >
> > for you to fetch changes up to c71fdbc575b79eff31db4ea243f98d5f648f7f0f=
:
> >
> >   ice: update ice DDP wireless_edge package to 1.3.13.0 (2023-11-22 09:=
14:39 -0800)
> >
> > ----------------------------------------------------------------
> > Przemek Kitszel (3):
> >       ice: update ice DDP package to 1.3.35.0
> >       ice: update ice DDP comms package to 1.3.45.0
> >       ice: update ice DDP wireless_edge package to 1.3.13.0
>
> Sending a pull request and all of the patches to the list individually
> seems to have confused the automation we have to grab stuff from the
> list.  The first two patches are merged and pushed out:
>
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/75
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/76
>
> but we never got an auto-MR for patch #3, and the pull request MR now
> conflicts because we applied the first two patches in the series from
> the individual patches.
>
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/74
>
> Mario or I can fix this up, but in the future it'll just be easier if
> you send either a pull request or individual patches, not both.

The third patch is now merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/85

josh

