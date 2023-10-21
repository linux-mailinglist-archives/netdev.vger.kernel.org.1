Return-Path: <netdev+bounces-43263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D537D2080
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 01:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70745B20DA1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A0B20B2E;
	Sat, 21 Oct 2023 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKKnOrEz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF30809
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 23:57:21 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D454E4
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 16:57:20 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45853ab5556so642058137.2
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 16:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697932639; x=1698537439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqnmzhclvOwwqTGAwkq/nEDEAnrVxCndy+B1Qnb4eVE=;
        b=xKKnOrEzvQw3KL1nqvg+a1igbPEqDm9SPtLHB11rJ+t2gwWGM4dBkqpRDVvyEBWZcv
         qVmALw3fcCo8BuW26kye3WRTpfuJ4TcHsZFT9cZ31eKoWlMm2mZh7aLgvDYzrfrZ3rEQ
         bwAvrO7NR5tU2I14Q4kEEoFtDJe4OjUWsWM9xQ/eKFfsBryzw4nxfKvKVYSg8RNeur3l
         riwq3XvcVsDIzTFOnZf8tK1LBl1UGBnGRAIC8M1oveF2PPk+WhaqK9U0Rp3LqefeGpaN
         GAGyRonxpgdAAYH5DnjDD2/CwxyllV5knyx69hUmIIQMFfHrLXP7lkaKnhZTqX30JvpT
         lnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697932639; x=1698537439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqnmzhclvOwwqTGAwkq/nEDEAnrVxCndy+B1Qnb4eVE=;
        b=uHTpqSvtV6syYqlUgSE6nIA60dxOLdXJcMbt1T5RwY46iKFbSl6gCJQ3sNJMaRHP9r
         mjMKvNXwiSD8OGdp9uOaP/7slY7kM4mgGflYmUjTdyu94DaIW2bW77uT+9kLvWq7ULD3
         ifxlDCB1Y4jC3s2mD6Do2Nyed43Lk/EUJm3lPtTlWQh+ON3/LBJ1NO/E5OGcpyVAmeQy
         D3cZ5fhlJ2qWbUjyDVrP8EqgvMw2L86IXJSEIjZsq3Sy8jtzEscguaANu0ZPAIIV+KQG
         78clpdTAqsviPD+jXaiY4EqlMKpYkVEl9VZSAR8POhAMGaCH8sfNRPIudCICcHX+rPpP
         5npQ==
X-Gm-Message-State: AOJu0Yx0OsehSDD3vUOwLM6y747AwUIs+El+OfSnO9Rnjw8Xy+OdWZfL
	Qre3OTWSdiQkr1U61fjt+59b28OMiTeon4ow7FJnp7x51gz7fOtgxJLwbw==
X-Google-Smtp-Source: AGHT+IHbMZr4SiEUcEfBSSW7Z3hs9Vd2eGh3Gh7PTUECYcdvCeeQc+BKmI1uWKTKi+yN6trTCWv9Ar1XRMlxqV7HlOQ=
X-Received: by 2002:a67:c21e:0:b0:457:c982:57f9 with SMTP id
 i30-20020a67c21e000000b00457c98257f9mr5233478vsj.23.1697932638956; Sat, 21
 Oct 2023 16:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697847587-6850-1-git-send-email-fred.chenchen03@gmail.com>
In-Reply-To: <1697847587-6850-1-git-send-email-fred.chenchen03@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 21 Oct 2023 19:57:02 -0400
Message-ID: <CADVnQyks4eWus9k5cZnZhVFS17r45RS8V776UgOkFhUF=HTS=A@mail.gmail.com>
Subject: Re: [PATCH v1] tcp: fix wrong RTO timeout when received SACK reneging
To: Fred Chen <fred.chenchen03@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org, 
	yangpc@wangsu.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:20=E2=80=AFPM Fred Chen <fred.chenchen03@gmail.co=
m> wrote:
>
> This commit fix wrong RTO timeout when received SACK reneging.
>
> When an ACK arrived pointing to a SACK reneging, tcp_check_sack_reneging(=
)
> will rearm the RTO timer for min(1/2*srtt, 10ms) into to the future.
>
> But since the commit 62d9f1a6945b ("tcp: fix TLP timer not set when
> CA_STATE changes from DISORDER to OPEN") merged, the tcp_set_xmit_timer()
> is moved after tcp_fastretrans_alert()(which do the SACK reneging check),
> so the RTO timeout will be overwrited by tcp_set_xmit_timer() with
> icsk_rto instead of 1/2*srtt.
>
> Here is a packetdrill script to check this bug:
> 0     socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0    bind(3, ..., ...) =3D 0
> +0    listen(3, 1) =3D 0
>
> // simulate srtt to 100ms
> +0    < S 0:0(0) win 32792 <mss 1000, sackOK,nop,nop,nop,wscale 7>
> +0    > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>
> +.1    < . 1:1(0) ack 1 win 1024
>
> +0    accept(3, ..., ...) =3D 4
>
> +0    write(4, ..., 10000) =3D 10000
> +0    > P. 1:10001(10000) ack 1
>
> // inject sack
> +.1    < . 1:1(0) ack 1 win 257 <sack 1001:10001,nop,nop>
> +0    > . 1:1001(1000) ack 1
>
> // inject sack reneging
> +.1    < . 1:1(0) ack 1001 win 257 <sack 9001:10001,nop,nop>
>
> // we expect rto fired in 1/2*srtt (50ms)
> +.05    > . 1001:2001(1000) ack 1
>
> This fix remove the FLAG_SET_XMIT_TIMER from ack_flag when
> tcp_check_sack_reneging() set RTO timer with 1/2*srtt to avoid
> being overwrited later.
>
> Fixes: 62d9f1a6945b ("tcp: fix TLP timer not set when CA_STATE changes fr=
om DISORDER to OPEN")
> Signed-off-by: Fred Chen <fred.chenchen03@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ab87f02..eee4e95 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2222,16 +2222,17 @@ void tcp_enter_loss(struct sock *sk)
>   * restore sanity to the SACK scoreboard. If the apparent reneging
>   * persists until this RTO then we'll clear the SACK scoreboard.
>   */
> -static bool tcp_check_sack_reneging(struct sock *sk, int flag)
> +static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
>  {
> -       if (flag & FLAG_SACK_RENEGING &&
> -           flag & FLAG_SND_UNA_ADVANCED) {
> +       if (*ack_flag & FLAG_SACK_RENEGING &&
> +           *ack_flag & FLAG_SND_UNA_ADVANCED) {
>                 struct tcp_sock *tp =3D tcp_sk(sk);
>                 unsigned long delay =3D max(usecs_to_jiffies(tp->srtt_us =
>> 4),
>                                           msecs_to_jiffies(10));
>
>                 inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
>                                           delay, TCP_RTO_MAX);
> +               *ack_flag &=3D ~FLAG_SET_XMIT_TIMER;
>                 return true;
>         }
>         return false;
> @@ -3009,7 +3010,7 @@ static void tcp_fastretrans_alert(struct sock *sk, =
const u32 prior_snd_una,
>                 tp->prior_ssthresh =3D 0;
>
>         /* B. In all the states check for reneging SACKs. */
> -       if (tcp_check_sack_reneging(sk, flag))
> +       if (tcp_check_sack_reneging(sk, ack_flag))
>                 return;
>
>         /* C. Check consistency of the current state. */
> --

Thanks a lot for the fix! The code looks good to me, and I ran it
through our internal packetdrill test suite, and, with a few expected
tweaks to reflect the fix, the tests all pass.

Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal

