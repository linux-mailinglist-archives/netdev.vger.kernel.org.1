Return-Path: <netdev+bounces-198908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB0ADE49B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4067A2764
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4181E5B60;
	Wed, 18 Jun 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2iriRO5"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C4156C6F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750231891; cv=none; b=XQxf8rJWaDmYNbnlF2pPh6l0whiDZUDOJRMDQl4CmOyUhrvecTVN+o62+3tTEUtHZfZQrPPB8E/t8VdhPHmz2GDm/q/2OHEmViEE3suCrL4RnJvSw1dzml5IgvVxTB5KuEF0xjMnAqKU1Pqys7RD1QAqRrtpa6QzOaImb36inBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750231891; c=relaxed/simple;
	bh=qGKtNA+4Ur+0wRwwDR2ly6BdRm8nznmwwWHMjHlMxqI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EpCW7Qn//8eAd1QVUn1OT/cOfId32X5fOLjBnprRfUxvaV6ZuadeGQ0I85NAjTPeuAkp6giR1Q2o/LOQ37Hquhmo5D7dqRefZLyt4wzBr1i77w4QUU3gcrCpmrpEHlew9HPul+YKvae1h+nk2gaE/yPpfS26wCkUNO6lPSIhkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2iriRO5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750231886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LmJLS/LfF8q1QehsgbJlKxthaaM7XEKqiN320caAco=;
	b=v2iriRO5XrGcDS4t443RomB1f03LSiiYcIO6+yBpEZAb9RcZyxtc1Wbj36kCDd8eqVIx09
	BWiR0R/3YqCjcYv6SX9GcAjXGEQz+DD6PoX6DB+Sgu4XZS8hslFY2UOUK4qecImvYoRkFa
	dfA0wMlPqbtmAR2RmgYWIlZBbT5qqbI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3853.100.6.1.1\))
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20250611164339.2828069-1-kuni1840@gmail.com>
Date: Wed, 18 Jun 2025 00:30:58 -0700
Cc: christian@heusel.eu,
 davem@davemloft.net,
 difrost.kernel@gmail.com,
 dnaim@cachyos.org,
 edumazet@google.com,
 horms@kernel.org,
 kuba@kernel.org,
 kuniyu@amazon.com,
 linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 regressions@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAD52833-6A51-494F-A437-2459B772E768@linux.dev>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
 <20250611164339.2828069-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 11, 2025, at 9:42=E2=80=AFAM, Kuniyuki Iwashima =
<kuni1840@gmail.com> wrote:
>=20
> From: Christian Heusel <christian@heusel.eu>
> Date: Wed, 11 Jun 2025 13:46:01 +0200
>> On 25/06/10 09:22PM, Jacek =C5=81uczak wrote:
>>> Hi,
>>=20
>> Hey,
>>=20
>>> Bisection points to:
>>> [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inherit sk_flags
>>> at connect().
>>=20
>> I'm also suffering from an issue that I have bisected to the same =
commit,
>> although in a totally different environment and with other =
reproduction
>> steps: For me the Xorg server crashes as soon as I re-plug my laptops
>> power chord and afterwards I can only switch to a TTY to debug. No
>> errors are logged in the dmesg.
>>=20
>> This is the relevant excerpt from the Xorg log (full one is =
attached):
>>=20
>> [    36.544] (EE) modeset(0): Failed to set CTM property: -13
>> [    36.544] (EE) modeset(0): Failed to set CTM property: -13
>> [    36.544] (II) modeset(0): EDID vendor "LEN", prod id 16553
>> [    36.544] (II) modeset(0): Printing DDC gathered Modelines:
>> [    36.544] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 =
1968 2000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
>> [    36.547] (EE) modeset(0): Failed to set CTM property: -13
>> [    36.547] (EE) modeset(0): Failed to set CTM property: -13
>> [    36.547] (II) modeset(0): EDID vendor "LEN", prod id 16553
>> [    36.547] (II) modeset(0): Printing DDC gathered Modelines:
>> [    36.547] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 =
1968 2000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
>> [    36.897] (WW) modeset(0): Present-unflip: queue flip during flip =
on CRTC 0 failed: Permission denied
>> [    37.196] (EE) modeset(0): Failed to set CTM property: -13
>> [    37.196] (EE) modeset(0): failed to set mode: No such file or =
directory
>>=20
>>=20
>> I can also confirm that reverting the patch on top of 6.16-rc1 fixes =
the
>> issue for me (thanks for coming up with the revert to Naim from the
>> CachyOS team!).
>>=20
>> My xorg version is 21.1.16-1 on Arch Linux and I have attached the
>> revert, my xorg log from the crash and bisection log to this mail!
>>=20
>> I'll also CC a few of the netdev people that might have further =
insights
>> for this issue!
>>=20
>>> Reverting entire SO_PASSRIGHTS fixes the issue.
>=20
> Thanks for the report.
>=20
> Could you test the diff below ?
>=20
> look like some programs start listen()ing before setting
> SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
>=20
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff =
*skb, const struct sock *sk,
> if (UNIXCB(skb).pid)
> return;
>=20
> - if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> + if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +     !other->sk_socket) {
> UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> }
> ---8<---

Hello,=20

On my MSI Claw with Lunar Lake chipset I am unable to make it past my =
bootloader even with this posted diff.
I bisected and it led to af_unix: Inherit sk_flags at connect().

In my case, I am unable to attach any logs because my device completely =
freezes before the journal initializes.

This diff, which makes it essentially a full revert, lets me boot into a =
kernel built from latest master:

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 22e170fb5dda..4dfe94c6d00c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1708,7 +1708,6 @@ static int unix_stream_connect(struct socket =
*sock, struct sockaddr *uaddr,
        unix_peer(newsk) =3D sk;
        newsk->sk_state =3D TCP_ESTABLISHED;
        newsk->sk_type =3D sk->sk_type;
-       newsk->sk_scm_recv_flags =3D other->sk_scm_recv_flags;
        init_peercred(newsk, &peercred);
=20
        newu =3D unix_sk(newsk);
@@ -1840,6 +1839,7 @@ static int unix_accept(struct socket *sock, struct =
socket *newsock,
        unix_state_lock(tsk);
        unix_update_edges(unix_sk(tsk));
        newsock->state =3D SS_CONNECTED;
+       tsk->sk_scm_recv_flags =3D READ_ONCE(sk->sk_scm_recv_flags);
        sock_graft(tsk, newsock);
        unix_state_unlock(tsk);
        return 0;
---8<---


