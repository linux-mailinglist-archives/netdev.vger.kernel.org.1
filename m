Return-Path: <netdev+bounces-279907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGQTOIV95mkHxAEAu9opvQ
	(envelope-from <netdev+bounces-279907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C1433434
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF2D30166FB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0173C2768;
	Mon, 20 Apr 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3VVBkaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5604282F04
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712999; cv=pass; b=cvzmyi9gDHuQsNhkO8xSCRVHBBUVmDRnFEyKeufVnWtzAZq5b36aURbzZJc4wdVXr3nQl8jSI1ckUOMiMmYBTCeiIa5WouQU7frOnKM+K8uF05hM7P9uyi6o9Ud4OcZSW/UYzp6SxfGeCWU/oi2IDvI8a24waCP33O3L4S6bKKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712999; c=relaxed/simple;
	bh=Urc4fTcbbk2a40JtrOyUlkKJdjhGu8/jYnZtRKrjbmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cel0FNRH/OBJoVgmTaedlVqcj1ozaRHaBJ/OlPMtr4ojiumW1FEnSSLfwqOuBE53HZDGYTdnSGNuSMJ6ODhCyYNecLDB6/Ud1+o6A4d5BHKhtxENKZksfVw0fVv5K/OguWZpFIR/B5CyPxo1UYUYTYZwKRpL+tWAbQB4DLsumRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3VVBkaC; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64e87a81639so3250852d50.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776712997; cv=none;
        d=google.com; s=arc-20240605;
        b=ewHw9Ec+gfiTQnPmkbXZnjOW3zXDKTxLy974RO5QID1fA4SvvYf36TpDrQbiuzY5uK
         y0Evg/cY8xIVxBSrHVCuoO14sCYZ8WgVwVFZQlCXGRQ3IbBdM7QE+MqOZw+wsyVEnCCn
         29+w/QHxY+7JHy2vdX21J286lHqgOHVnoA9yQ/Eewh/+dcKRMcRrmP0bMzaUa/FbHLwi
         b6ol9D1m6dWENx1j0iDrmhcSB4UUR9olHWIpio6oEySG1TARk242rKZRnEsibVNNBOP9
         NJ1ZDTf/ydmyLSP+VcFYb21hlfnSxd40bgJ472Ral6ZGccOXNZjY63e0ORzYqVZBSUOq
         gxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        fh=H6B6LtTjpEZctxx6wntle2EBB1LMlFMmLnTfz/31f/I=;
        b=P874HxMXHvnHP5d15DjTZ1sTnMuqWS47IF2/gnpn30oenD8nunJcIYnMM1ZR+uTTNG
         XyhPZloix5BHUZKvsosVVIL9wMgdPMD1r66/o2Ylwf1M5viUHRKJRkFbov6WGiO5vQU7
         ml1JwGavPyOpeSrQh6BJRlLFFP+c5sfhvOHZzZCQkXuVpSFBc3cqImdWhj5vFY/eLE54
         eKwXvlH8d8yBfA/0PzVgV+cKotwHlVFUHiK5iJUb1rhU5QyIV571TMip9Anjz+1Evu5s
         AtF5Mjihbi9HFbGpE8EgGhY5I62+oS/+wjfYhUwNwhwa58+RnU+tsQK65+vKSClfsxX/
         /9tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712997; x=1777317797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        b=B3VVBkaCz0DSlWRysjem6+2RdUQ1uDcVpfWW9kubqOGtWORcANAPRm2cEpFdWmsk+x
         INcPoxDnEkQ8L8+K0W+BKn5N16jIBq8goQHNh1FfJtEU6w2ewgO4487OSTvlcwfulW/W
         KUxzwhMNrBvka9XiPINFr3NxJ/6X1j1JXQLFTjoMNcWvm1T+/EoH1iQbl9gBe2bpMWJM
         6tzY+mdKpKVvhfBYXeMD6H0L+2in/EMyRWpdyUcaJE6+nx/EUQhYHOnTEb86dAVOedq5
         wQd/q+yWw/KdH4JylXtP7EIFztCmikzOqGZG8zqGxqBqHlhmiJjvRsoeNiFFQV2lMd2s
         Ph+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712997; x=1777317797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUIn3hEw6JYFkddfNv6BL46EZAbPO+C2iSOKicXTGNM=;
        b=hqbJFy/ZoUblyNKAKM9RAp1i/lDiWjsP1zv97585nISlPTxn4HqXc1JAeeES1zcmZn
         ZxG+s7RJHg8YFhd4Uc1X++ubCgg6Rw6rTuAtMitvuNfcsP1wsSFt0OHQQ2+lMoM8+zHe
         HfbvZ8UfYTicSWmuxBoAM7inqdX625w2TpJqHtcqBfUUpdIhpzSIEwftt7V4Ipn5a4CC
         QD+ZLYQLJqOQiwZsETQtc/D0QWoTktFZcYQytJ0L9r2ITAoukE7ai5ZIMyJmFGALJM3x
         y3ujvFezt6L66YG+3zoA55l5LYQHiMgRsaTJmo2gJ9m3QZOFoQXdLbK95GrvOWGQR5Ku
         Q5bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zZGmOGyN2y2qMIgLMp3/k/wFxGNhtOHblaa8LKDFxqNrltt0DtuJGDKRUaGwtsPFxIbFpxzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwzuXVAWtT5Rf4bYmLTtYdrQXxQyl9iA9+Om5Jc2CU5RODBTd
	JKe/9/aE4kGqw7m6QmevPSQcyryS5xIofsnEBLpzq22QK9nEs9YIQndzNiR/xG4fEtTxGHgGKI2
	/KDjktV9w7U9iRovLgCdEL930SF1Khfk=
X-Gm-Gg: AeBDietl8P2Q/7rMYkWzkkm/IpiOZgkx4exwIun+BHxdGscKaB48wUB9+V3bqqb84qc
	UZQz2pSpTjU3JyFPaRja4ivY7ys7eE+wVf6vyLmchHbyXeoOcYNZUp5z8u87lqRK1dE0JDWxOCi
	jPnkCeKSovSv7gdXXypiPXB2zwcNfaFW1bN7Uxb5g1q8VhyVRZgUZ86cdZUYXE3ETu8ODiZcSje
	FXOFhmSgE/eVJKZEjFksG6DOI152RSrrlVeE86k3AaDG5xREf4DRpbImAHkA/b8I7VlHEGqi08h
	4ymD9Mf1YiytVELivJ8uqu4P8ZrJqz9dtIl5hO+/ymqcRd7AtET7pWBHFrI2SOows5HfBhYtATx
	DFA==
X-Received: by 2002:a53:cf44:0:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-65310a0bde6mr9520237d50.36.1776712996801; Mon, 20 Apr 2026
 12:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418053401.128483-1-suunj1331@gmail.com> <20260418053401.128483-2-suunj1331@gmail.com>
In-Reply-To: <20260418053401.128483-2-suunj1331@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:23:04 -0400
X-Gm-Features: AQROBzCElDRvhVtJbXCcMB4PIv35kNLuKPjgXleuneDJqn-BnYQgD22cYaV6t4o
Message-ID: <CABBYNZLBoU3byfK_G+=sTkBx3wNwEh2X6_7dG4+4LFtrc3Skpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, me@brighamcampbell.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 3C2C1433434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi SeungJu,

On Sat, Apr 18, 2026 at 1:34=E2=80=AFAM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> iso_sock_connect() copies the destination address into
> iso_pi(sk)->dst under lock_sock, then releases the lock and reads
> it back with bacmp() to decide between the CIS and BIS connect
> paths:
>
>     lock_sock(sk);
>     bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
>     iso_pi(sk)->dst_type =3D sa->iso_bdaddr_type;
>     release_sock(sk);
>
>     if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))  // <- no lock held
>
> This read after release_sock() races with any concurrent write to
> iso_pi(sk)->dst on the same socket.
>
> Fix by performing the bacmp() inside the lock_sock critical section
> and caching the result in a local variable.
>
> This patch addresses only the bacmp() race in iso_sock_connect();
> other unprotected iso_pi(sk) accesses are fixed separately in the
> next patch.
>
> KCSAN report:
>
> BUG: KCSAN: data-race in memcmp+0x39/0xb0
>
> race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by tas=
k 549 on cpu 1:
>  memcmp+0x39/0xb0
>  iso_sock_connect+0x275/0xb40
>  __sys_connect_file+0xbd/0xe0
>  __sys_connect+0xe0/0x110
>  __x64_sys_connect+0x40/0x50
>  x64_sys_call+0xcad/0x1c60
>  do_syscall_64+0x133/0x590
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00 -> 0xee
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d5=
1b370a0f8 #40 PREEMPT(lazy)
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  net/bluetooth/iso.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..14963ba68597 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1169,6 +1169,7 @@ static int iso_sock_connect(struct socket *sock, st=
ruct sockaddr_unsized *addr,
>         struct sockaddr_iso *sa =3D (struct sockaddr_iso *)addr;
>         struct sock *sk =3D sock->sk;
>         int err;
> +       bool bcast;
>
>         BT_DBG("sk %p", sk);
>
> @@ -1191,9 +1192,11 @@ static int iso_sock_connect(struct socket *sock, s=
truct sockaddr_unsized *addr,
>         bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
>         iso_pi(sk)->dst_type =3D sa->iso_bdaddr_type;
>
> +       bcast =3D !bacmp(&iso_pi(sk)->dst, BDADDR_ANY);
> +
>         release_sock(sk);
>
> -       if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
> +       if (!bcast)
>                 err =3D iso_connect_cis(sk);
>         else
>                 err =3D iso_connect_bis(sk);
> --
> 2.52.0
>

https://sashiko.dev/#/patchset/20260418053401.128483-1-suunj1331%40gmail.co=
m

Seems valid, so we migth just use sa in the place of iso_pi(sk) to
avoid using it without sk being locked. Other problems it may reveal
need to be addressed in separate patches.

--=20
Luiz Augusto von Dentz

