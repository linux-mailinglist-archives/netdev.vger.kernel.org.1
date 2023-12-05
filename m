Return-Path: <netdev+bounces-54043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DC805B68
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEFB1F207C4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE696A323;
	Tue,  5 Dec 2023 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGDaIUNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820E122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:48:46 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4649299d0a0so741350137.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 09:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701798526; x=1702403326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbMfFmVqoXvr8pImmYuMXZkjwRP+lR7eYnWdpD2Yc6o=;
        b=TGDaIUNZLb4ATsOGZqUwaZjSMF0rBe0rMDtYurTD/VgstqGSVXFbsFg4o5AoBKmM9I
         gZLqCasMk7wI39DIsH5BvLGHIBoBX3VhtwKckY+nzqllN9xdmEd0gaI5zLeySRTcx7K7
         mm1+UbBo3MdjvIuvDytDrmfRCVo0agtKkKUGPmk1h+KJsy9umowSb/Fq2zAcHgqGNWa1
         3f0l4X5ON04nCrL7tFsSSGAfwGinZKOSzZ+I0i+eZT1RihZkFV+tRaxUhoZJSXnvavvd
         qUeyqOBzshqyNzh5JR+r0Z9vQ6XNu6z2hnTFRlRXvs/j+QUI3JCx1dJIt3SgWrjxv6lA
         0ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798526; x=1702403326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbMfFmVqoXvr8pImmYuMXZkjwRP+lR7eYnWdpD2Yc6o=;
        b=E3JNi0VQrN418nilGa24HefjbVFEvfJKcV410/7eAe618ygTdmMqlrEtXD6bXbykzg
         R9NrWxiq7HKOdf7PUmLnLXz3oaaBTPCwmiaH9XWHRZ1mqLyebraeQreZUUG2bL1W9QCn
         kOZypljh1S6PZk6ZotimecllLSSwzsanv/XqUIBdJRfapMsVLQ7bFSjfD5SUeln+R/eQ
         ea+foAgkwD6X7ZQtBqq9NFX/I0ZsVtGxt/iUzlsL/f5vZ4NH7Ptm2GLZOXPpVXkw7tR4
         afGKBZjc5qWxEtSrJ812ITyaSLpRhQV6QN9BGkU3ZfdMZH26SdmTg+brfR4Ry02f0B24
         vEvA==
X-Gm-Message-State: AOJu0YzGdVMwFYczcb5lq24yEtgse8Px+Ovi5HDAuTD7cIwjzJ5lW52D
	OlW8ZcskgIWY2rvL5DqrghiVMfXdap2QTN4WK3nM9GqRz9vUXGYN9PYr6t8q
X-Google-Smtp-Source: AGHT+IF7v9rDSvMmWXpLCFGt+X7DrIbLGzkBgIn0KRe55tLyKFKETBIY5oudPxpooya4lL4EzdEIE3aLPjRqofsd3mM=
X-Received: by 2002:a1f:da82:0:b0:4b2:f753:73b7 with SMTP id
 r124-20020a1fda82000000b004b2f75373b7mr967563vkg.13.1701798525834; Tue, 05
 Dec 2023 09:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205161841.2702925-1-edumazet@google.com>
In-Reply-To: <20231205161841.2702925-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 5 Dec 2023 12:48:24 -0500
Message-ID: <CADVnQykebdmw8X8rrWH5cw_F7gwJqH2Sza6gzMcBh55WV2k=sA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not accept ACK of bytes we never sent
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yepeng Pan <yepeng.pan@cispa.de>, Christian Rossow <rossow@cispa.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:18=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This patch is based on a detailed report and ideas from Yepeng Pan
> and Christian Rossow.
>
> ACK seq validation is currently following RFC 5961 5.2 guidelines:
>
>    The ACK value is considered acceptable only if
>    it is in the range of ((SND.UNA - MAX.SND.WND) <=3D SEG.ACK <=3D
>    SND.NXT).  All incoming segments whose ACK value doesn't satisfy the
>    above condition MUST be discarded and an ACK sent back.  It needs to
>    be noted that RFC 793 on page 72 (fifth check) says: "If the ACK is a
>    duplicate (SEG.ACK < SND.UNA), it can be ignored.  If the ACK
>    acknowledges something not yet sent (SEG.ACK > SND.NXT) then send an
>    ACK, drop the segment, and return".  The "ignored" above implies that
>    the processing of the incoming data segment continues, which means
>    the ACK value is treated as acceptable.  This mitigation makes the
>    ACK check more stringent since any ACK < SND.UNA wouldn't be
>    accepted, instead only ACKs that are in the range ((SND.UNA -
>    MAX.SND.WND) <=3D SEG.ACK <=3D SND.NXT) get through.
>
> This can be refined for new (and possibly spoofed) flows,
> by not accepting ACK for bytes that were never sent.
>
> This greatly improves TCP security at a little cost.
>
> I added a Fixes: tag to make sure this patch will reach stable trees,
> even if the 'blamed' patch was adhering to the RFC.
>
> tp->bytes_acked was added in linux-4.2
>
> Following packetdrill test (courtesy of Yepeng Pan) shows
> the issue at hand:
>
> 0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +0 bind(3, ..., ...) =3D 0
> +0 listen(3, 1024) =3D 0
>
> // ---------------- Handshake ------------------- //
>
> // when window scale is set to 14 the window size can be extended to
> // 65535 * (2^14) =3D 1073725440. Linux would accept an ACK packet
> // with ack number in (Server_ISN+1-1073725440. Server_ISN+1)
> // ,though this ack number acknowledges some data never
> // sent by the server.
>
> +0 < S 0:0(0) win 65535 <mss 1400,nop,wscale 14>
> +0 > S. 0:0(0) ack 1 <...>
> +0 < . 1:1(0) ack 1 win 65535
> +0 accept(3, ..., ...) =3D 4
>
> // For the established connection, we send an ACK packet,
> // the ack packet uses ack number 1 - 1073725300 + 2^32,
> // where 2^32 is used to wrap around.
> // Note: we used 1073725300 instead of 1073725440 to avoid possible
> // edge cases.
> // 1 - 1073725300 + 2^32 =3D 3221241997
>
> // Oops, old kernels happily accept this packet.
> +0 < . 1:1001(1000) ack 3221241997 win 65535
>
> // After the kernel fix the following will be replaced by a challenge ACK=
,
> // and prior malicious frame would be dropped.
> +0 > . 1:1(0) ack 1001
>
> Fixes: 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack Mitig=
ation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Yepeng Pan <yepeng.pan@cispa.de>
> Reported-by: Christian Rossow <rossow@cispa.de>
> ---
>  net/ipv4/tcp_input.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index bcb55d98004c5213f0095613124d5193b15b2793..62cccc2e89ec68b3badae0316=
8f1bfcd2698e0b7 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3871,8 +3871,12 @@ static int tcp_ack(struct sock *sk, const struct s=
k_buff *skb, int flag)
>          * then we can probably ignore it.
>          */
>         if (before(ack, prior_snd_una)) {
> +               u32 max_window;
> +
> +               /* do not accept ACK for bytes we never sent. */
> +               max_window =3D min_t(u64, tp->max_window, tp->bytes_acked=
);
>                 /* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation=
] */
> -               if (before(ack, prior_snd_una - tp->max_window)) {
> +               if (before(ack, prior_snd_una - max_window)) {
>                         if (!(flag & FLAG_NO_CHALLENGE_ACK))
>                                 tcp_send_challenge_ack(sk);
>                         return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
> --

Thanks, Eric!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

