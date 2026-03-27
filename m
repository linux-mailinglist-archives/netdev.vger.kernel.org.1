Return-Path: <netdev+bounces-272628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ2gCVTFxmm8OQUAu9opvQ
	(envelope-from <netdev+bounces-272628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:58:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F6348C07
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2157B30CCEAB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089834035A5;
	Fri, 27 Mar 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="REZSkiJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692B402448
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634172; cv=pass; b=t0Bjw3DloIgSrNTUbYKJzxmGe5Gouu6kiYHxISyLfcApLN1jLI76J9oHkl0AAYVh1PdvYzheN63Kb+PJbG9HrY4rBvXWflRcZ596nNIn7M/ccbO76OzwwrX6p8XTRtzCEvPUoLN66NdufyFZS4mzubHrL62PAaxFDgidWOaPCVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634172; c=relaxed/simple;
	bh=dkIOtQ3zu1m8d2A9QgVzKWqC1eb4yW1zDp6LErYwYAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z92a6sVdpFcwbDSR0lTfl+C5tedLaTq/IH/F6LEkOOVjWUpVV2Xe8pb0JuSInnVv1eS3BvLN8lfJt5dDNnqUpHkrCeXYxmFDYK2kI0wJjoCkspvHuLrB3Bo9Za4pU6xEnXloaWn2QxLkIiCYzmK24TaS8+9ByaZb0Kz8k3iptfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=REZSkiJ3; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7393c6832bso865659a12.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774634171; cv=none;
        d=google.com; s=arc-20240605;
        b=DwSfNdchnQVIHrCMdMROIaOZpGJ0syOh5p31HtuLX13enYF91ZC/sqITMofcA1XLgY
         cX4F1Em8HfeOl9F0lEIAQKyD2Cd3sI/kRCYgxmaCdFb9S4pLUJD0RVBfxbZsID7FU2AZ
         EI4Nd7VD8fwiLhf7eo9ZThnvR/GX5zfvC/p+5ecfa9XS3XjKQLbAQoX9ZWEOrTxImrN9
         keZC/dn1lGrwOyTgrD51j91/A54Bd2N6rkc0SH06oYPVq0i4bQO6RtStFEmxrsb70r2G
         c+0kQBbFo2zDLpDut6H/gkFOUgd+U1r3Gs22py3N7SbtTJgOdY8lAjWF/KzT67ioW7rU
         TLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        fh=WY11N44hPaq76vT66MwSAt5qwoja0EOqbU82/5sLO0s=;
        b=YIm4+zeHtKxQALivNlnsdzHbntBf+TFCwwSDX9aYFtMxAVRGpLJI/41+dRVHfvbotT
         O0qe16PxPxKohyT6WJMfaFV1uDhUWRyS5H7+ovRGkYFGFo5iGwSnYjpgSpmbdhH8a6YL
         GCzb2JRsnOm5HW3CwSqkX4xctc1WQ+BU0JR6Qy5Excs0FAdepZBkQ/DSr1p/hHZErbMl
         iVRMmGu2Z2MJ//ip86GvU8s6wJr0/y7PBGIvql9ABftFDbHj5b6cb5mPDrl6inpe0qod
         +sQ0Td/2jZO2C2AJGSvPiR7HjugeAmiaH17UjTHkiVt4ya6u7bbfS59Gw0OVd8CvrHnq
         e64A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774634171; x=1775238971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        b=REZSkiJ3vg8wwgVDyKnZxtm+F6wy927+ty0dQmCf4dLF+5eKirQxIxkhGB+YqtBw++
         XgTlgOmH4whRvCW5QGSynvMM3uvg4Ym608dnboJeal9s3HauJiX7SmOC1xLwBHVvlU3C
         cHmmEV7eITFHl0RS4BCHnvZc1lWqCbTmFgFaTwgTsANZAxCLMhaaXyh15qORTBdXHhKs
         Irw1z5licEX29n3liYEM7zRlV9OtFAhOdEekyZjIvvYTm1qKT9XqC3jTKAtzhFI3ll6c
         vywQdaDJ9U8vGf852zUDPDGQpw4VN9RiLbExk5tc1o/57pLaOawy4RLTzSG1JzI0GZSF
         ZcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634171; x=1775238971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1EnQcn8nG5hIuUi9o2FJT/iD/jkMGN0EX2uMt+uZkc=;
        b=XJSEeXdsoDlFvEspSJ+a21NwlNWDDMSy6Q7umvN2Mc/KX7lPWobO4RVtOVgObB50Kc
         kzdZVWGG52VxMahrOFFYY71MpmHGkGZzBA0lYya1z6y6MwWMc1Fy5G1Bh8vvwdtJXAV3
         VCFXVUc3hvXVP2QddTOPVd/9qr7+wFTC+l5pbv10c14eV6rr0grRoWMOUU7QGbfUlBKm
         5cueoHCgpNf7ukoFXsAXsNiZm0b98ivI6lhXY8cVJWbig/3yYP97+CjCVwqRJQIQaHDt
         mznzehmuNRwL2kYbbA7wvS3wVK8W/duTbNHapo64TTLiKGC51yczoC8UCW2StCfMhBah
         TX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWlxVHFq4yjFs0m+bpOtFgP8OKKV7YzvqyBREblP64s4XkZ1uHSe65DaEutfwiXdq+YrCMc+LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYUJP2r/ae1dYNWds+s/iGP+FW/t5JbPR7QDL8FLRpOmXT9me
	HMMXv10ypONw6F4v8xng/zY7mRiaqim9v5a5SJfFTu5eYRqjkhKOHTszkrwJDYaXPjw7hlMorJ2
	TbRAB8kTZaN3jgEG3oJJueg/Mr5MHwg6UipbmP4LV
X-Gm-Gg: ATEYQzzZPxfmKT3ftb0cKqQa2ytGqCslq6jQX/nJ78ADBkhlhELmMvTzN82QqZudHdP
	0GHdWywJEbZuMGfnbypGo3w5YjKXKPqa/lJ22UH0a0edI9zARFw0Q3BYTKDUO2UWpSpqrT9erjz
	XOjlab9ZS0x+d70tjqKJTtIqTxuBGtK6DuvEUtT0nv9QrNDKaaEmHGFkNCQbSMBzjqUFZGzb9MQ
	p6DleXnsVaTOADbd+UGCxWi6UUYZCicJya68cqZFn7N7vYsZMWVxSvZu/V9o52zZCK48FzaWUbQ
	6QgwSnkAHWEwi/Qkag==
X-Received: by 2002:a05:6a00:a24b:b0:827:3914:f130 with SMTP id
 d2e1a72fcca58-82c9605964fmr3457259b3a.36.1774634170864; Fri, 27 Mar 2026
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327164838.38231-1-gnoack3000@gmail.com> <20260327164838.38231-2-gnoack3000@gmail.com>
In-Reply-To: <20260327164838.38231-2-gnoack3000@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 27 Mar 2026 13:55:58 -0400
X-Gm-Features: AQROBzAkl2N3nYLN6Qz6Tf_ibeBjdYLVvulOQv-Ni6FR5-N-G3uDI_RGAB1oCno
Message-ID: <CAHC9VhRktViRp_U3ZAvo2e7vbjUd6RZb-y8+YPXhtLpt7hsXYg@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[digikod.net,canonical.com,namei.org,hallyn.com,maowtm.org,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,digikod.net:email,maowtm.org:email,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url]
X-Rspamd-Queue-Id: 932F6348C07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:49=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gma=
il.com> wrote:
>
> From: Justin Suess <utilityemal77@gmail.com>
>
> Add an LSM hook security_unix_find.
>
> This hook is called to check the path of a named UNIX socket before a
> connection is initiated. The peer socket may be inspected as well.
>
> Why existing hooks are unsuitable:
>
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
>
> (1) We cannot resolve the path from the struct sockaddr in existing hooks=
.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
>
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
>
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
>
> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

This patch doesn't look like it changed significantly in this
revision, is there a reason you dropped the tags from Georgia and I?

--=20
paul-moore.com

