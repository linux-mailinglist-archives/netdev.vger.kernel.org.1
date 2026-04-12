Return-Path: <netdev+bounces-277728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDlFzDk2mn26wgAu9opvQ
	(envelope-from <netdev+bounces-277728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CB3E2185
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A8B3012C50
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B02848AA;
	Sun, 12 Apr 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWtbW6m0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4728466F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952933; cv=pass; b=EDd3fYCxcRqb+twRef46VupB2Q+S6c2YYaIZ7NSMs0kXzXQCBN+TYCX76DAGEDCB4paKjo9llGMVGLFYdgsbkCvcdqdnuxhp4xB09tmTZEhHDf7JqdRpPSd7mhY1hzGCLFNv7MAxTyD92SCpWLY5yWXezBcEC4jyTAEnoXXzTC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952933; c=relaxed/simple;
	bh=CmZGUTedxvErfz78jHYNYnI+6tTt3jotKf5C2gH4HaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE+eu+qo2KXQkki6C28x+IfSJdjzrY0PIJx4exoiCJcE9nqtCt9HauRb5dJDzuxoBc7YvWf84lmQIOhT0Fbfyn7yHPw7A9bVZzjDKrh8r0IiMFJcAV8Dx3kp7nKGjX3tnKj7EN0qkD4i+v9gWZg3rKg4dSyt3nVjli+CyqcuM7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWtbW6m0; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1279eced0b9so4640050c88.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 17:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775952930; cv=none;
        d=google.com; s=arc-20240605;
        b=DsFqATnD1RjYaACrKHIZA6VHGWK64K5PnsaVPXCYjoTJVb/XRWcv5cwlsTNl8Z+9Ez
         ydO5RUa0S2kqS9n8P9OJVx3moDVEvP8wuO48OFrIWX7uhP4nCrmM2TJPkBZfunFNVFfU
         BQXun666m2fB2xKTC1ZJCFONkDVl74DRVv+4K4dSGdMLIkg7R6hGdExCDfvseQCJmohL
         9bAsZOeBqK6fL4aJqMPApznAoCffNhK42ReYlPydd5WGSpIv2SL40qceG0PD6jQmJFs1
         XbVwGx4xvsFDFxSUNRfXNOdUs9/nvoCX3wW2UTxhX8K1eBY4eOm/QBx/vussncmMlrVT
         WKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        fh=ZM/WEpTZmrWSFYgYlFCja+NTKLB3v46txG8R9IBPzcY=;
        b=Ehy7xKocsQ/xtpjS66MDa/GSiVZB4kbaVS2/b28htzXSNXWKvFi2lbMP110evO/V6y
         AgJ1s62HuOH2c9j3+Zkoz0m/F9uBAxbri2SM7e0bRmnHLB/QkMScoh5bAm73nt3+HPqv
         KRqJX2aaqWzqP/w5fsFrsmJDkS+GjC+Z9avqXiMVya/kqKi8HxRgtCmMQ4zQ4Ga2p0gK
         PGOla64TpIu9cidLVl7NZYm1XYH1HgXIZ5WW0yRn+ecKzfVrUTLdYM+fCMuEZeCkGrG/
         92QdHmWy0J4glmmrtld8DAPqcy1RoHtqybOdZ5yyHd1BSQZ9mSkuEWltwlZlrzOxoOLb
         Jhyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775952930; x=1776557730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        b=WWtbW6m0FkFagck99/qkv0N3zZBBdt8R5ky24ZHbh+r16LBl2R+/xN2iopIgy1LXou
         7qdSdEEHGrrbvyIZV4qyqoXZ4BBy6tZnOrFRBSOi23ywegFicUj8rfVFS3iFksT7i5cM
         8n4gi7WGxv+tel1nT+kAgw4hayYxJl2342BzqNCPUejk0qCftF6WhrtLkZk1w/uJluHF
         MnBy6NEaOdTop1xF0xV60q7Ah5iXTpXbxsg0ig9515rU83WrjpvRIEwm6K7Ir0zVzSuA
         zJ6wfekQrZaMr8exQV0JpFGqC4MvPaV3Tx+iXC6/Eow4J435BYEIryuI8crUf83BCgR+
         Oy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952930; x=1776557730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        b=gedTaXszfU5OEH/ujwoN97z3PI5wQGEnuPbhjVkIDLL5fiacaCwclWu/FfmEumvRTh
         Q+yvPxcyJMNpgvPwTd3utncxgLJgHtpbB5FtaDYTpQB8rC7PLF0XglSTiDaL+FYenFNS
         eabUOJ4h0udbwGgCZu9INzaM1DqZ7IMeNOMJ7kXDOGCEY73Gl5qgyj/lPAS7Se8l29YG
         vCWF+HodveN9BeFIFi42WxSg8hbsFvAYq3Pd6ioW89GLusqAY6VnBDuvyuOA5f19rXYe
         ZmhIYgMrrXkhRPdqBHVXoqXHDqSofqZYG2/Dc53iUzUMRHJYiQPNU7sNdaYhuvFWsfct
         6rtg==
X-Forwarded-Encrypted: i=1; AJvYcCVfu2Ynt+awPCt2KHxwXM1C0OOm6xEQLmeffA0MrYsAXEH0REfOIMzSn+vJAxRsxnHLvu76n4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWedLLPxC6TX9K4oy1ZqAEW93HItZvsenZYnI1R/dq2VG1tWAy
	PpV20uk/dqiZeLuhAI9YYy50+/R2pzx6KQeRXVWFlcU7IWVKxaqQ5qLT3Hu4ZwyVyCebp8cxAIE
	swYJyJKKB6Cx9DcJEd4ZahASFGriuNfg=
X-Gm-Gg: AeBDievvp5JTkkCrJ6iZP/nyrcGGpOSdhNc4FtGCYRNU0IUrUdsu3zBI9Pmg37TnOKq
	9GYcTT7QsQctvRgc4foVNURttEyWl+sGyrjV+KE66PjFhAuJj4k6PNF6fnzJcr7/t6JgrertWyO
	TgCAY3zHpN3deD73ZooXUuad/zke1wCJM5f9xruCO3zIuw1Yll1kJV1kWqeSlrxZbyxYrUq2FUB
	DBszzIhFWpQsonTjRPJ5qEOPR8tioW7/3maTx2WUEQXaa3cwOhtIhyuBrgXcAHrBo/zTclfksEr
	XXd12o4=
X-Received: by 2002:a05:7022:790:b0:12c:8b9:71f7 with SMTP id
 a92af1059eb24-12c34eeb715mr4553437c88.24.1775952930140; Sat, 11 Apr 2026
 17:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410015336.7353-1-prathameshdeshpande7@gmail.com> <c30f21a3-5a27-43fb-957d-107775b00faf@nvidia.com>
In-Reply-To: <c30f21a3-5a27-43fb-957d-107775b00faf@nvidia.com>
From: prathamesh deshpande <prathameshdeshpande7@gmail.com>
Date: Sun, 12 Apr 2026 01:15:12 +0100
X-Gm-Features: AQROBzANFPTqvpmn7u2azZ01KYmXw0rBHGp7wlUf4BAl0HcvZMwTXNSWCUa335s
Message-ID: <CAJr+Z9mbQUgiKPEvTc1ASYo_sLjLFm6Fn78SsK9hZZzrpWGAhQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277728-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 040CB3E2185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carolina,

Thanks for the feedback. I have just submitted v4 which addresses this
by checking the pin index against MAX_PIN_NUM.

Thanks,
Prathamesh


On Sat, Apr 11, 2026 at 12:35=E2=80=AFPM Carolina Jubran <cjubran@nvidia.co=
m> wrote:
>
>
> On 10/04/2026 4:53, Prathamesh Deshpande wrote:
> > In mlx5_pps_event(), several critical issues were identified during
> > review by Sashiko:
> >
> > 1. The 'pin' index from the hardware event was used without bounds
> >     checking to index 'pin_config' and 'pps_info->start', leading to
> >     potential out-of-bounds memory access.
> > 2. 'ptp_event' was not zero-initialized. Since it contains a union,
> >     assigning a timestamp partially leaves the 'ts_raw' field with
> >     uninitialized stack memory, which can leak kernel data or
> >     corrupt time sync logic in hardpps().
> > 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> > 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
> >
> > Fix these by zero-initializing the event struct, adding a bounds
> > check against n_pins, and adding appropriate NULL guards.
> >
> > Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core secti=
on")
> > Suggested-by: Carolina Jubran <cjubran@nvidia.com>
> > Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> > ---
> > v3:
> > - Fix union corruption by using a local timestamp variable [Sashiko].
> > - Validate pin index against n_pins with WARN_ON_ONCE [Carolina].
> > - Remove redundant pin < 0 check and cleanup TODO comment.
> > v2:
> > - Zero-initialize ptp_event to prevent stack information leak [Sashiko]=
.
> > - Add bounds check for hardware pin index to prevent OOB access [Sashik=
o].
> > - Add NULL guard for pin_config to handle initialization failures [Sash=
iko].
> > - Add NULL check for clock->ptp as originally intended.
> >
> >   .../net/ethernet/mellanox/mlx5/core/lib/clock.c | 17 ++++++++++++----=
-
> >   1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > index bd4e042077af..674dd048a6b8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > @@ -1164,16 +1164,22 @@ static int mlx5_pps_event(struct notifier_block=
 *nb,
> >                                                              pps_nb);
> >       struct mlx5_core_dev *mdev =3D clock_state->mdev;
> >       struct mlx5_clock *clock =3D mdev->clock;
> > -     struct ptp_clock_event ptp_event;
> > +     struct ptp_clock_event ptp_event =3D {};
> >       struct mlx5_eqe *eqe =3D data;
> >       int pin =3D eqe->data.pps.pin;
> >       unsigned long flags;
> >       u64 ns;
> >
> > +     if (!clock->ptp_info.pin_config)
> > +             return NOTIFY_OK;
> > +
> > +     if (WARN_ON_ONCE(pin >=3D clock->ptp_info.n_pins))
> > +             return NOTIFY_OK;
>
>
> Sorry if my previous comment wasn't clear enough.
>
>
> The firmware will never report a pin higher than n_pins, thats not the
> concern
>
> here. if future hardware reports n_pins > 8, checking against n_pins
> would still
>
> allow OOB access on those arrays. The check should compare against
> MAX_PIN_NUM
>
> instead, since thats the actual hard limit of the driver's data
> structures. and if a new
>
> device supports more than 8 pins, the WARN_ON_ONCE would let us know we n=
eed
>
> to update the driver.
>
>
> Thanks,
>
> Carolina
>


--=20
Thanks and Regards,
Prathamesh Deshpande

