Return-Path: <netdev+bounces-54025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E23805A41
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1233B1C21166
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441C55761;
	Tue,  5 Dec 2023 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2jm9uNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7DD197
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:47:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a196f84d217so623141966b.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701794862; x=1702399662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W03APc7fgUH6iCVB9JurtD59EeQ+Ft8Ntbptqk3WFiI=;
        b=Z2jm9uNSObSh4ryIMioreMmcMaRt+DPU+Iz2UlUp3f08TaFEdaS6fdcGSySqWnWb/h
         TRpv2UAAfSb4jIxgCO/9pW4B/7KEWKes5XYCOeSlS8ySEl8Lz1dHAe4Biqm0GC8SmCKq
         LlFUKi2lcGm/tuZvcw9GX2Xk+EF3Ip6duMYfD0aePZrqBzUA5icx6aGJPs01/PZ+OjXS
         gRPQml7G/cp8UN9TH6AnRc3YScmERc5VGLquBQa/IU1pBCHHJh5z/vJ/DOFXJRzhp5I7
         Sg5oLMvs9+UgPRdB90g8BZ56fR8rshwn+omoi0rRy9eOpnitlD/IEwPRTlWL0F2cAakz
         gAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794862; x=1702399662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W03APc7fgUH6iCVB9JurtD59EeQ+Ft8Ntbptqk3WFiI=;
        b=TapAtasSKst8OCFIe8LUsf62Mc9qGD4lP4DEjxu8KrQJGep+Xn3W0bg9kMIJ+G8gtI
         cJY8a1TAmBlZflkqWe0I9cakFaLoAnheSVAKq34h4nmbCWyav8o0onwO1hBHtCbCLRY5
         zfXrV0E3ePXC9GA7t941JHamOYRtQBy1v/nSiTc8TmM00bhtoYQzof6fdPf3c60HXlOX
         AQ1+aB87HfyHrSJSxBNraVvXoGF1o8K/UuY9jdgE1MSXxej9epc5sqBs3n5IgBRHF/qK
         XxZGGNCo6ljoHzHUz2N+AA1aw0C1vLsgHpt5TrVfwLE10Ax4LgIKWSSTBzkAJ0x8NIXF
         0yhg==
X-Gm-Message-State: AOJu0YzNOcbEduc/BS+1N55m6S86/1woM63PPxG7Ug0Su8g+s6S/0058
	HNixKeBUQzHKrRo1LMA71gAyFe0dIm3HGsJqPMm5SA==
X-Google-Smtp-Source: AGHT+IFzQnRjI6OjqdVXSDj404QwarCWbAC8g/LzMJ2FiDGEVOKuX+gkQ+Rq8R2okusCeIqJerG08WdJAK7vv3acOjs=
X-Received: by 2002:a17:906:73c2:b0:a19:a1ba:8cd8 with SMTP id
 n2-20020a17090673c200b00a19a1ba8cd8mr4445647ejl.118.1701794861827; Tue, 05
 Dec 2023 08:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205161841.2702925-1-edumazet@google.com>
In-Reply-To: <20231205161841.2702925-1-edumazet@google.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Tue, 5 Dec 2023 08:47:02 -0800
Message-ID: <CAK6E8=dCNTuZvyHJYUzv-BmFVkxa=cnDazgLdCtDLvrGmEWT0w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not accept ACK of bytes we never sent
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yepeng Pan <yepeng.pan@cispa.de>, Christian Rossow <rossow@cispa.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:18=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
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
Thank you Eric for the fix. It appears the newer RFC
https://www.rfc-editor.org/rfc/rfc9293.html also has this issue that
needs a revision?

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
> 2.43.0.rc2.451.g8631bc7472-goog
>

