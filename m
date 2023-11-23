Return-Path: <netdev+bounces-50310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC957F552C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DD51C20A75
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151607F7;
	Thu, 23 Nov 2023 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQbO/s/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC487E3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F69C433C7
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700698231;
	bh=2z++ao5Z92LYjEsItcgfxQ/N0za3SceWCo22uU5kZ98=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=XQbO/s/P2OxvZcjJcVPmjlTJID7w/7Dzr3dfERWoTdoNRkkV99pSKD8EGSemUlScX
	 hKBbfTa6Ep+f4yOuAlcNjHjlXHam9pB4f1dgMVK9ITaCareqmfXfRQX0CRrXh/ZP4u
	 EdO1f6J1ryma4eE9pXWXlEfLA0vBt5qNfnTFYOtLiJhNFpSV8ei6WdfNvq+7/+Dn7l
	 fUxIjOsxl9r3UnsJtzBW+KYVRQR/ARMXa2Z7xyS6KrrVppevKbYVRcgs2NimDtWW5B
	 52iydLXL1HkJTu9ewoLAf1xcYVy3HYi0FMFDvjoehAeY+JgAQe35O5WjaJ5dd5z1DZ
	 AT3lK0FWGTOWg==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so343129276.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:10:31 -0800 (PST)
X-Gm-Message-State: AOJu0Yy+ofL0EjuA60KFAO/aNF6+t3+r5esmhZZb90glyhelInqS3Dst
	zTSjp6GtJgbflcfAusMbut+StxNq5vkoKPSlviU=
X-Google-Smtp-Source: AGHT+IHvCfwEg2pEMmIqxwzrxk78HAkBlqCZL/jXSBSgoBhIXMbDD9apymuUnB1Xp3/3m8HT2/N2QwhYmvubpwsHcFg=
X-Received: by 2002:a25:374c:0:b0:da3:ab31:ce22 with SMTP id
 e73-20020a25374c000000b00da3ab31ce22mr4072066yba.2.1700698230669; Wed, 22 Nov
 2023 16:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122173041.3835620-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231122173041.3835620-1-anthony.l.nguyen@intel.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 22 Nov 2023 19:10:19 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
Message-ID: <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
Subject: Re: [linux-firmware v1 0/3][pull request] Intel Wired LAN Firmware
 Updates 2023-11-22
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Mario Limonciello <superm1@gmail.com>
Cc: linux-firmware@kernel.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:30=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@inte=
l.com> wrote:
>
> Update the various ice DDP packages to the latest versions.
>
> Thanks,
> Tony
>
> The following changes since commit 9552083a783e5e48b90de674d4e3bf23bb855a=
b0:
>
>   Merge branch 'robot/pr-0-1700470117' into 'main' (2023-11-20 13:09:23 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware.git dev-qu=
eue
>
> for you to fetch changes up to c71fdbc575b79eff31db4ea243f98d5f648f7f0f:
>
>   ice: update ice DDP wireless_edge package to 1.3.13.0 (2023-11-22 09:14=
:39 -0800)
>
> ----------------------------------------------------------------
> Przemek Kitszel (3):
>       ice: update ice DDP package to 1.3.35.0
>       ice: update ice DDP comms package to 1.3.45.0
>       ice: update ice DDP wireless_edge package to 1.3.13.0

Sending a pull request and all of the patches to the list individually
seems to have confused the automation we have to grab stuff from the
list.  The first two patches are merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/75
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/76

but we never got an auto-MR for patch #3, and the pull request MR now
conflicts because we applied the first two patches in the series from
the individual patches.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/74

Mario or I can fix this up, but in the future it'll just be easier if
you send either a pull request or individual patches, not both.

josh

>
>  WHENCE                                             |   8 ++++----
>  ...e_comms-1.3.40.0.pkg =3D> ice_comms-1.3.45.0.pkg} | Bin 725428 -> 733=
736 bytes
>  ...1.3.10.0.pkg =3D> ice_wireless_edge-1.3.13.0.pkg} | Bin 725428 -> 737=
832 bytes
>  .../ice/ddp/{ice-1.3.30.0.pkg =3D> ice-1.3.35.0.pkg} | Bin 692660 -> 692=
776 bytes
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename intel/ice/ddp-comms/{ice_comms-1.3.40.0.pkg =3D> ice_comms-1.3.45=
.0.pkg} (89%)
>  rename intel/ice/ddp-wireless_edge/{ice_wireless_edge-1.3.10.0.pkg =3D> =
ice_wireless_edge-1.3.13.0.pkg} (88%)
>  rename intel/ice/ddp/{ice-1.3.30.0.pkg =3D> ice-1.3.35.0.pkg} (88%)

