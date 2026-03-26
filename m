Return-Path: <netdev+bounces-271788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H3xcO9t+xGnAzgQAu9opvQ
	(envelope-from <netdev+bounces-271788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:33:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38432DA84
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D458C301BA9D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19242D9484;
	Thu, 26 Mar 2026 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIa5xyKV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F1247DE1
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774485209; cv=pass; b=A41XJvuHU7Me47D7SiGjfeUrVMfLYQn90BIQv5oQVyHl9DFZ4w6sbG8tcO6SzyoB4PQ3+H2v+F3WxqX4FYJo7mi9XAwuB3+y7vxKiv/krtsNQ3eGBcMHZ9G08Xi2FyFS3UpkbzZrg8jZf0N+D+8SVScphxkb7MtiEegw2/rtHg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774485209; c=relaxed/simple;
	bh=xcYoU2EhupfeQFEMz+G4nlS3bJJinaBxrvHwAj3XtDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7zqwThZKP1CD/N5m2yyqbk+/f74YbRzbM1zO+3IGayUs073BOo3NdTbeDF4iZ56+NHd2F38PsNDXYoQCwNKYQgS78GVQ1MxVyjcFsGiu5cittOr8SnbqFJCDin0u0ZfiN40Fhe8ONDiHg+Cw7WTRs1njzRHZbJA2bsQGn7FQYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIa5xyKV; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a693cdf29so1394104c88.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774485206; cv=none;
        d=google.com; s=arc-20240605;
        b=aIMUH2sqrrYHE3mu/fPCgjblxURiBZ59Mhju9gPjC6NF9eRC0Sm760xZWApue2PJVh
         v7TswVGt5/SpKYFgyAcgP6F8eIXPcosms1PVjr3auESEbhFiNslQK/1cnf3ykMlutwwa
         OBBGxpWLphrf/Qaeyu1P5nkB/Ny3QfVZTSch6TOXP3H4olXXbb2c5yr/I5zmZ5k/P+no
         +Pp4WBdLX17+4aJmI9fBQSj73VC1oFSVAXdsS1NMsBdH5O+lxz77FRDPO15p6WrsrZNo
         Go2Il5EnV547+8eSrrqCstIy2/7h55l9WWQmtA3znB1UyOh12XtdpbAWipPltYfVc6Oh
         aN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lo7u2CLCsySezJ/m+R87LTCOQKYhnIiiwQZOPh9KHPw=;
        fh=+JP3ABAmt2sKhCdZluPiNGkyfLvrqv1G1MWuU2tASfM=;
        b=OHbnwzq6rzKuz5wcQDhBorq9ZddGFoqQ0nH5BSuAbJyETs+LgRzjasBmiys4mcAVn5
         q8urV7W9FkkyrBKm6Cj9o+rNyM6Pv1uWD3jYt1gwYVZDMZ9oEWn51xRur1y/hUmxXw5R
         ++DCC98uxV8p9oP0OX2w/7u91Od53D18Un9yIT2uxtFMkfwFQZe66FEIvywTZkVcB1hp
         dbpiT94bsoS4kSiyKfY73ExIlMoLzGyLylytUPMrnnS7FZqdaBd+aga73Lp8HRAV+hBs
         JHFdFJj17MYkQx+3qoVTgfkM9RSHiSJhEjihmnM5gVtVDM9RRSwHEwN90nh8IGB1Rnuu
         X6SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774485206; x=1775090006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo7u2CLCsySezJ/m+R87LTCOQKYhnIiiwQZOPh9KHPw=;
        b=XIa5xyKVb5wcqp90foRjJOgtu/n6/sPk6MKrsLHHXNf/vkA9XLIgO88pytb7Eb0gYB
         XL77ZhrAVcUbE/RjNKQCvgDmq6Wb84alrC9vEvKlLLOjqBjmRNP6e9xEWoA3NP3ZITlv
         eICgj0HzpG8VGhbOSE0ULx11plegphK2t5u46KoA8Jj4eF/3gGa/x3G5SgYEPJbIjWwm
         q5ci95tF5P6sxU5xfA6P5yU/ecctgBjDysw+MLuEMUXoU4G4cPotjIr9ZL2kN5egFsSL
         s0Erer7w3ksRsy5xryYzcz9QBxSC5WvrOUYYPjYqorSu4boTDbd6ID86w808+dKH1q6s
         UX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774485206; x=1775090006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lo7u2CLCsySezJ/m+R87LTCOQKYhnIiiwQZOPh9KHPw=;
        b=U6yPClh7Vnk8UKicUOIAWE5Bu2Ih275m6cG/igQFQEObff9kon6nGFjIOx7QgGUPaL
         Uqn1S4mBNT5Lrk/qStM/Xo+2wQI9IgitKhzAqg6BIymdtRwBPdgVew7wpnz76874Vgt0
         ieqpepLQwJ4jL8SjSQN5Jqw+jbtetpSLLaUdeVVo6A9Rl5lkQOv/FruZWQDTsnlXpD/R
         Qdn3vaDdrOJwnMu6U+yP5AJ9AXMC9Z+bK3s2ck/5D+q+nUvcpiqrTVFJ++uCp98u2P6F
         t1ARcx2qJl3za8KSdIHE4ppznUB86yVbRFFEYLALmtKb6F/PI6yKygcPzdvNOK5GI61l
         /23Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeNQEjS91DfaogUDLU98TQXtnJ7r3w0PNm7GSW1qT0vVfwggYdetZHQkinu4Huohqw4iIysN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClbYhs67Q0BwHDNnhNQyAMvZUMnX7ryYaA/d4Pm7CkekAj0Eu
	+B3FWLw2+e6Vz9JPk3PPQ0hL8ZLBtKMwrXy2ZMGTJHCLaBBLgHDQB1i1BZ2A0cYX0z3CmtJKvCu
	hR+T8Pjz4kYCe+vfu9xfwFLpuRkqV9A0ylW3GWdve
X-Gm-Gg: ATEYQzys09CBARmnTrWMm+7I2EoUHtRur8KVva3bH1De+Jde63WZmGAP9AdRs0+m+Rd
	J0Y6yUDIzcjxlJfdZ8fTItPO3sslbPR6Rr295uVxYY93lRWUUWijGJRcpXu2Oohx00ENjQyScgP
	O8xXBYTyV/8Ar1tS7xhKNId9Rfso2rvCU5Bh6pEL9LbggPgbFeX/2BzbC/Z7JkiPZkHSkDJqe3K
	3n7j7nfjK7TKAAPL9yNU/EvNRlMJXIsn9b/561mBj3VS/GeG6+wQ/dLXPwduZScpDDBXg4m8wGK
	TrUNA5UOiLp9AevxLIsce4mQvArDBA9ghJUy+G0+NW0Kitc3OF5FhLsRtQPWa9nWTaxnGA==
X-Received: by 2002:a05:7022:48f:b0:123:2de5:346e with SMTP id
 a92af1059eb24-12a9672ae4fmr2373174c88.0.1774485205821; Wed, 25 Mar 2026
 17:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69c34b1c.050a0220.abc16.000b.GAE@google.com> <20260325091214.24516-1-kohei@enjuk.jp>
In-Reply-To: <20260325091214.24516-1-kohei@enjuk.jp>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Mar 2026 17:33:14 -0700
X-Gm-Features: AaiRm52FZnReW96QyKNXCikodMxR4sLl4Lf1vVIrk4VLmb9KeJp5bh5-WmGGHWs
Message-ID: <CAAVpQUDAMyKqTwneX8TPh1a=+pW-FyR2URWuTzsJOrUO0iuiOA@mail.gmail.com>
Subject: Re: [syzbot] [usb?] [net?] KMSAN: uninit-value in rtl8150_open (2)
To: Kohei Enju <kohei@enjuk.jp>
Cc: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com, 
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271788-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email,syzkaller.appspot.com:url];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7C38432DA84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 2:12=E2=80=AFAM Kohei Enju <kohei@enjuk.jp> wrote:
>
> + Iwashima-san
>
> On Tue, 24 Mar 2026 19:40:28 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c612261bedd6 Merge tag 'io_uring-7.0-20260320' of git:/=
/gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D155801d6580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D963de479f54=
c6dbb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9db6c62463556=
4ad813c
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e=
25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/aa2bdf537bf6/d=
isk-c612261b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8fcd98072431/vmli=
nux-c612261b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/737b94c52155=
/bzImage-c612261b.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> >
> > usb 2-1: device reset failed
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in set_carrier drivers/net/usb/rtl8150.c:726 [=
inline]
> > BUG: KMSAN: uninit-value in rtl8150_open+0x1131/0x1360 drivers/net/usb/=
rtl8150.c:763
> >  set_carrier drivers/net/usb/rtl8150.c:726 [inline]
> >  rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:763
> >  __dev_open+0x8e3/0xd40 net/core/dev.c:1702
> >  __dev_change_flags+0x32f/0x950 net/core/dev.c:9764
> >  netif_change_flags+0x8d/0x1e0 net/core/dev.c:9827
> >  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
> >  devinet_ioctl+0x10dd/0x25a0 net/ipv4/devinet.c:1199
> >  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1015
> >  sock_do_ioctl net/socket.c:1254 [inline]
> >  sock_ioctl+0x769/0x1140 net/socket.c:1375
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >  __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:583
> >  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
> >  x64_sys_call+0x1975/0x3ea0 arch/x86/include/generated/asm/syscalls_64.=
h:17
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Local variable tmp.i created at:
> >  set_carrier drivers/net/usb/rtl8150.c:723 [inline]
> >  rtl8150_open+0xc26/0x1360 drivers/net/usb/rtl8150.c:763
> >  __dev_open+0x8e3/0xd40 net/core/dev.c:1702
>
> I see Iwashima-san was previously working on this issue here:
>   https://lore.kernel.org/all/20250827233108.3768855-1-kuniyu@google.com/=
T/
>
> The issue seems to be that set_carrier() ignores the return value of
> get_registers() and may use an uninitialized tmp.
>
> rtl8150 appears to have other call sites that use get_registers() the
> same way as mentioned in the thread above.

Right, feel free to take my patch over ;)

