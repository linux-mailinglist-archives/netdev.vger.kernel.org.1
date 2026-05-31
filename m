Return-Path: <netdev+bounces-293465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMDIDGJ5HGrVOAkAu9opvQ
	(envelope-from <netdev+bounces-293465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EB6176B1
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39F83036ED7
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E70392819;
	Sun, 31 May 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apsnNg01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D90391E7C
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250935; cv=pass; b=vF100Jl6ZQPivYGRui+U+2vD4JgRlHpKON2ixEOTBRLFRm2x5iPYUX+VvFxBa2HBGdW/1h9Zi01AyP6eNI+UjsYCSVCN11ygNhkF2lwXQCqGOeVcw2sm2N2NRoMip+lRG+nJC4avvoRnK5LC440ZFYN396UTDIU1kgJjI8of/Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250935; c=relaxed/simple;
	bh=LX4HPkltEGsHPK17yME6ZDWufNBKXuBoPdfhHIdKp8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC+BCCYHjpOgb1NIlbIA7n3r8+8Ilv8w79oOcLRJZIX+yQCn51SWRkoXZQzaQEe6uTrf96IMlFlfV085cD6+hHiCoES+DLIkiB4jqEV1c1aDoDv7jY+Vrdul1YRwLhvvxgge0qJ7s+TT2/r6IukiHbIUOSj1iceALAZHiB70RwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apsnNg01; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5174a1d78f8so6904011cf.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 11:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780250933; cv=none;
        d=google.com; s=arc-20240605;
        b=BpbMH+ClZSUZS/CjDQs23Vo0/v+nlC0bL6mTmS4MvxU9elhWVb0sNXG7eUKLLK53nq
         u4eoi4qi/TNijlZK2KZk2THFG+5tTatXLAenjoaqWsYiyJWdtGb/KH9Z+OE4LOiSJpj9
         U8Gldc+SlV2usL5bu/IIuM3HxUc6VEictjmB6ndc1y0DvwXcMggJOI8UZcL8MwQ+4SGg
         XoHBvfQYOCWUkwusBUYWccfF3iccMOqr19cygwycD/15sMr+AcyMSZ5wmHm6ooi8k7H1
         lN4KQNhaL2A6dAVDvRWmnf3gB9j7hhdXV7BHhihJAF9H8ym7WVeMj0sWDwit8NQAz2c5
         uNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        fh=eUEgOgdUlsJ+TnUoO8By2sjm6VFatlupx8fs9abAOs8=;
        b=ObNeDzh7MTSn4zeugsRHdj2cQ8TAwJKk5hlF2v0PPBCgjmJlS1pg7tPQJRbtBiwT9W
         yzW5iawiurv5fTiH0NSGxtMtpgSOsKmIjsErEudzR5vdfRaww2rprqJHednU8yu1zkuS
         1EbNtAA+uBza+A4DkN3KpIqSAOtC89USM4TEHXXUjC745nDJeGGc9x+HQAaztUm/E5Dn
         l/4KGXb093tORymc71pSxi3Xgw5qg++LjCP0g3k9sl690Mu4uTgBNvbY5ICvffrYfwEV
         J0J8Iq0vSvJ1NQJZnI+bsvJEYOtW5rJyAc5Xlb1cBWzN+dAVKL4T88YzX8MZhN5ZNxnf
         gnCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780250933; x=1780855733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        b=apsnNg01Ldjc6kkTGoBAFG/3+dB6SlqNw5lzJ5lL7zxKHrUhAOAo2TTQpGG6sWGB8u
         2wx+fnSfBeYls/D3ZHynkfNxCfFhvnE0Rh8sZGo0AyH56dVFagpYx9kxwx3oJbuScl0e
         QIJ9/pQTUELVEi53XDx6s68rYbY2puot7IM1G0+D19OiJrEvF6zuMg9OWXObfhaE8X5b
         XZOlZhAZOa3QcSQ1p05fjOMwoj9WouaS11JZXzGUfJSWa/YsYXP50Sv/l9H6G44rWnVC
         MZgD0Pd8aRdfOy131GtJjgF/q2qd3iHk5fgGFVUm3Fy6v8c2ynJAWIwuoED0cK24oS6T
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250933; x=1780855733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igFYe+C9WOBYLpObw2m/zg4GWFSBeVyEOXzH0bhFKC8=;
        b=Y6kGNTdnGBhQIxa3hu0O/2SlkSAxSfw+53TBwwutujoaSJbnCz9jYDYpykW26QLyuA
         ZdXbeCebDTJDxIGswj2Ir1gK8y7cnND6IZJt41h3NPfggp+OREDEwjAJ2t4T6WM0NBzL
         2VQCbkKve6AYt3aiMXm+opNd8UsTPGi3TukpmuK0UfjseDV/ElmAoowhvGrZkMAGU1//
         Cg6ymZH6++mk0+QN/J8sJYWa4cxmGYZ3zHRva5BqIyHY9MdQShFWn95ltheLub/F/fw9
         TBkjDOePDSJ/fOSb7iuz3lQfT45Tpp8UgrPUteh6hqMX6iy3TK+h4p7+/Ks8LX443fiy
         ESGA==
X-Forwarded-Encrypted: i=1; AFNElJ+W2Y13b3v3/kQXVRs6A4YIYcOMo40tbG+/McUpa8fMj7fmgk48MwMKMXeVAPUq0urT4W35FHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKh2nKwaqa8sM2HM84HfWB1rhWWE2jdald8Ed7nd5JLYpdjxh
	Y3ITA5Sk4qTJ+ce9YnIwHJ2tZcRtq4sVq/iH6n+fa6qKLpP79f2HJ23t91Pp2W+hRWiBYMIn4fb
	bnrprCUut1SUYayxup5RrkuxmDjrV+fQ+gIZp2BJ1I7l7Zb+CWF2Zpap2Z2I=
X-Gm-Gg: Acq92OHauq8oSTvzpR+sabi8mIXZZ7/ZYdOV5MPSwhCPtlviYq4AM2r1PhyAp5TGw8K
	bfJiJDsT5tyJSq6qh72wrvIKj+pHHlaAeF3A/dMddkurcwS1xQmIcpRehuJu++rWCLP1UeJxW9V
	NrYSqDKn6pkshL6I6QraE06wwz4NCnBeOLHb2t5zUimKV3ql0hT9vdgOHPuwBhGKG+oSEgrhg8z
	72QdcJHtXSTMuPeE+cLDHOukE3e6ESv4zPzX9rnAweVvnOtNng+PgjaVcWGB/VnH5HFzAE962gT
	zC64ppombcMxEFsmRD2Bg3Gy+Yg5Dsey1RgXuyCqaxpHrT+zTg6KOelCaGsCB2qYgiir9ctJ88L
	VuooOdVpKyFBZf/3vmdLVsBB+z2KP+kEllFeGJQ==
X-Received: by 2002:a05:622a:4107:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-5173a93bd0fmr112626241cf.43.1780250932611; Sun, 31 May 2026
 11:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531124828.2323406-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260531124828.2323406-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 31 May 2026 11:08:41 -0700
X-Gm-Features: AVHnY4Lvjf1C_TM2wnah_-lmgXjYPamVSXQUTpmEplMnYHoO98UurOO7hdKuwdc
Message-ID: <CANn89i+FMBS31D6onh6cpASh7fApp3FfEn8j4YWCfEwDb8C_4g@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 896EB6176B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 5:48=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> inet6_create() copies net->ipv6.sysctl.bindv6only into sk->sk_ipv6only
> without any locking. bindv6only is writable through the IPv6 sysctl
> table via proc_dou8vec_minmax(), and adjacent lockless sysctl reads in
> the same function already use READ_ONCE().
>
> This read is reachable whenever AF_INET6 sockets are created while
> /proc/sys/net/ipv6/bindv6only is being updated. In our QEMU/KCSAN stress
> test on Linux v6.18.21, one actor repeatedly toggled
> /proc/sys/net/ipv6/bindv6only while four concurrent readers repeatedly
> created AF_INET6 stream and datagram sockets and queried IPV6_V6ONLY.
> The writer completed 75313 sysctl updates in 45 seconds, and the readers
> created more than 360000 IPv6 sockets in the same window.
>
> KCSAN reported the following race:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in inet6_create / proc_dou8vec_minmax
>
> write (marked) to 0xffffffffaa27bbcd of 1 bytes by task 95 on cpu 1:
>  proc_dou8vec_minmax+0x206/0x220
>  proc_sys_call_handler+0x21d/0x300
>  proc_sys_write+0xe/0x20
>  vfs_write+0x559/0x6d0
>  ksys_write+0x88/0x110
>  __x64_sys_write+0x3c/0x50
>  x64_sys_call+0x1016/0x2020
>  do_syscall_64+0xb0/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffffffffaa27bbcd of 1 bytes by task 97 on cpu 0:
>  inet6_create+0x351/0x700
>  __sock_create+0x149/0x280
>  __sys_socket+0x9f/0x130
>  __x64_sys_socket+0x3b/0x50
>  x64_sys_call+0x1c76/0x2020
>  do_syscall_64+0xb0/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x01 -> 0x00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Wrap the bindv6only read in READ_ONCE() to annotate the intentional
> lockless access and match the surrounding per-net sysctl reader
> contract.
>
> This issue was first flagged by our static analysis tool while scanning
> lockless sysctl readers, then manually audited and runtime-reproduced
> with QEMU + KCSAN on Linux v6.18.21.
>
> Build-tested by compiling net/ipv6/af_inet6.o on x86_64 netdev/main.
> Runtime-tested with a QEMU/KCSAN stress test that concurrently toggled
> /proc/sys/net/ipv6/bindv6only and created AF_INET6 sockets.
>
> Fixes: 9fe516ba3fb2 ("inet: move ipv6only in sock_common")

Wrong Fixes: tag, lack of READ_ONCE() was before the patch?

Also Fixes: tags are going to trigger extra work for many stable
teams, for no reason.

> Cc: stable@vger.kernel.org

No need to CC stable for this kind of patch.

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>

Please cut the verbosity, we do not need to copy/paste fifty lines
just to explain the obvious.

I hope you understand there is no serious bug here, KCSAN is a
debugging feature, not a production one.

One or two lines should be enough, you can take a look at
f062e8e25102324364aada61b8283356235bc3c1 ("ipv6: annotate data-races
in net/ipv6/route.c")

