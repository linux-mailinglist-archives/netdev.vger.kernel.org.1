Return-Path: <netdev+bounces-51455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2517FAA0D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB631C20AFA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45CE3DBBF;
	Mon, 27 Nov 2023 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmShpKu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA819A9
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:15:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54a94e68fb1so9076140a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701112504; x=1701717304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjdsAYaBUOrZ26qfQ6Jgiw57PN3OpOdatD/IlJzmr2w=;
        b=RmShpKu5oOZu/MdqY0YlVIif2cp/xjOr8oVDrDtgqJ1Zoh2Bg1s0wzQuKPgH2ZDu5n
         iQR/Vg+tkSPs5GVmSUBikQ9Pw63iNXg8gyhPuJN4R2a5YyjQxkK13cLJwPpcYZ+NuuV6
         VuRjB05fpGkzABRufd51ueatnWAmkayTfkJkAsKDoDtFxMHDKlqIQIYZOdfQghoOs6PV
         XD/apbi2O8GVEXXz7zL9CiO750grYSeyv3i2KeJiP9ctkzsarOSvQVSwwJtAIOMH483r
         pduOa4DDjnQKdfjsHUJWHa37lFS+ZrjpO/KD5tK/hvV9gUdeegIQIRtpFSH9SkbzSnN9
         jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701112504; x=1701717304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjdsAYaBUOrZ26qfQ6Jgiw57PN3OpOdatD/IlJzmr2w=;
        b=TyYokXecl4Em4Le7essPl+aUHQye9JIZ1BRW6KI9N1yXplKWIdQZxD8k8tFAmTcOfH
         DkmJ2SeLTtBUrhMs66Q6CS91PQX9S9PqKzDPh3YrqfIaUVz0kR3Hh3I2g9ztYGAzYJuz
         2EgOdW4ZCjiGDa02DAYe9nXawprtEpMFuIT+CF7+ltKNHuiCBsk1GbaRXMh4Rv4yHCUi
         XVdiEzwSps82PNbX0aGNchHUHcBvgNXc9MEaQD8Ly52S5UNqijv1EgpsIxb4H9x3igAv
         3P9HQvS3SAeKn7EySmTsnxlrpuqr6o6V+9UtK55HlDDa+CgnZE92uCygTHs8XLCXn/1R
         0qvg==
X-Gm-Message-State: AOJu0YzuFwdIXKqtuw8x0NvclFxQwYpjWXO9jSwSfO2PHTVUEneMw09K
	qOIXAx2gtJ+YOuPoh7zDXc4oEoNSfU9UYEXmo/Y=
X-Google-Smtp-Source: AGHT+IE9K6eGV0ubA8YjoNUAUV3bLA8P3ILpukWu5q16MNfqV99nw7oM2r+lJ+/XrUHXFsrRW1c88/+0BxjWyYwUr9g=
X-Received: by 2002:a17:906:51ca:b0:a0f:fe8:6a72 with SMTP id
 v10-20020a17090651ca00b00a0f0fe86a72mr4470487ejk.27.1701112503801; Mon, 27
 Nov 2023 11:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122173041.3835620-1-anthony.l.nguyen@intel.com>
 <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
 <CA+5PVA6FrzEy1RSMnHA_xixdOZDF19VZcuC1O9bMhdH39OXLRA@mail.gmail.com> <e77ba51d-2bd9-ed70-ec9c-60799fa21053@intel.com>
In-Reply-To: <e77ba51d-2bd9-ed70-ec9c-60799fa21053@intel.com>
From: Mario Limonciello <superm1@gmail.com>
Date: Mon, 27 Nov 2023 13:14:52 -0600
Message-ID: <CA+EcB1OSrgy8Ni0Y2cd-5xfr9FHQJ2-RK3umwVwDoQYf2A3stQ@mail.gmail.com>
Subject: Re: [linux-firmware v1 0/3][pull request] Intel Wired LAN Firmware
 Updates 2023-11-22
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Josh Boyer <jwboyer@kernel.org>, linux-firmware@kernel.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 11:21=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@inte=
l.com> wrote:
>
> On 11/27/2023 6:06 AM, Josh Boyer wrote:
> > On Wed, Nov 22, 2023 at 7:10=E2=80=AFPM Josh Boyer <jwboyer@kernel.org>=
 wrote:
> >>
> >> On Wed, Nov 22, 2023 at 12:30=E2=80=AFPM Tony Nguyen <anthony.l.nguyen=
@intel.com> wrote:
> >>>
> >>> Update the various ice DDP packages to the latest versions.
> >>>
> >>> Thanks,
> >>> Tony
> >>>
> >>> The following changes since commit 9552083a783e5e48b90de674d4e3bf23bb=
855ab0:
> >>>
> >>>    Merge branch 'robot/pr-0-1700470117' into 'main' (2023-11-20 13:09=
:23 +0000)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware.git d=
ev-queue
> >>>
> >>> for you to fetch changes up to c71fdbc575b79eff31db4ea243f98d5f648f7f=
0f:
> >>>
> >>>    ice: update ice DDP wireless_edge package to 1.3.13.0 (2023-11-22 =
09:14:39 -0800)
> >>>
> >>> ----------------------------------------------------------------
> >>> Przemek Kitszel (3):
> >>>        ice: update ice DDP package to 1.3.35.0
> >>>        ice: update ice DDP comms package to 1.3.45.0
> >>>        ice: update ice DDP wireless_edge package to 1.3.13.0
> >>
> >> Sending a pull request and all of the patches to the list individually
> >> seems to have confused the automation we have to grab stuff from the
> >> list.  The first two patches are merged and pushed out:
> >>
> >> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/75
> >> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/76
> >>
> >> but we never got an auto-MR for patch #3, and the pull request MR now
> >> conflicts because we applied the first two patches in the series from
> >> the individual patches.
> >>
> >> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/74
> >>
> >> Mario or I can fix this up, but in the future it'll just be easier if
> >> you send either a pull request or individual patches, not both.
> >
> > The third patch is now merged and pushed out.
> >
> > https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/85
>
> Thanks Josh. I was out for the Thanksgiving holiday. Will send one or
> the other on future sends.
>
> - Tony

Even better - if you can open up MR directly at
https://gitlab.com/kernel-firmware/linux-firmware we don't need to worry
about the robot messing up or you needing to pull one back because of
a mistake etc.

Win win for everyone.

