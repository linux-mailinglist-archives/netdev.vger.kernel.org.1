Return-Path: <netdev+bounces-35315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEC7A8C44
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 21:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A681C20963
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14891A583;
	Wed, 20 Sep 2023 19:07:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656A3CCEC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 19:07:12 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4539F8F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:07:11 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a505727e7eso56776241.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695236830; x=1695841630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsRDkQmtc4l3w6HTU87+YCUCh7mLN+xZYxvp89CA8Gg=;
        b=uwpv/SP+RmHyFqSUj589Tng9w9KQplwm+JO36JNyJiX2oUCTcWTZ6eQwkUzjx2BFcq
         6Ta4QUcWf8oODjOkfwVID+7pyEp5ZjOm8U9qY17tQNo62+StEUp8VUA1UUVruy6Nehgo
         pPJImW5JoPKZY+ahNyz95unOex33BRVJouR94ZUkYDjiqtLqsitsHbukHHgS2HU6PErc
         vXR7fqSMQ/psEJRD4lvPM9LPi3nLKOSJr/N64pvdcytd9hhnuXsMegi3hccFBbJjxv+Q
         +lGycbqggH+RzqO+QZ97YR9r8eA8rbCDLsCq/yh0h4u4XMEkRGcoid5cvsZZk0W9bekK
         Hi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236830; x=1695841630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsRDkQmtc4l3w6HTU87+YCUCh7mLN+xZYxvp89CA8Gg=;
        b=Txqxz6RrqGy3/lbXDdAOCmC9AA5DXKT1BgYv+lJen/FKJWv+gsA0bQ8X19xn53s/pL
         Xpjj3e5Y6RAqIzeWcxBkq5DI9SdXJRIH5RL3eba3G+LvWailSfBUGCQ+1ndy6F4N4o0S
         YIkM8KUf1qIkJCvB0cmqMbJHSDroLpjVlc0JwXeLN1j+0KI2yC8zdkrxvDI4cqx0Yu1O
         cVqJcNhPSvPM83Lmp1k+NYrpGtQMvPQjn0MiwKlDAhDeT7Qxf5vf/6uI0CVjltB5Ysxl
         ll6nV52Xo4BNW9y8pSfB95NpT4puJRnevZSnanZfyGtn1AZqzXEUs8aMn5Sd+KQxQTMJ
         k/5A==
X-Gm-Message-State: AOJu0Ywt/Xibvb9EmR75lCO7+HLb9I4sAhP1zoCfvpcQ8iIT6Dc5buI6
	KbodxbYh8v1yhD5b6rw5l2rIg2QUMAMLePnDjtJCpA==
X-Google-Smtp-Source: AGHT+IFCCmh9DSe/PJ94p7WMuJJ3oFG9Io8LngkZG/x2Iqg4ZaLKy8Q6/oaqnMSpYkCO6THrWIjLNkIkp9rpagkVndc=
X-Received: by 2002:a67:e912:0:b0:450:fcad:ff18 with SMTP id
 c18-20020a67e912000000b00450fcadff18mr3600791vso.34.1695236830040; Wed, 20
 Sep 2023 12:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com> <20230920172943.4135513-4-edumazet@google.com>
In-Reply-To: <20230920172943.4135513-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 20 Sep 2023 15:06:53 -0400
Message-ID: <CADVnQy=aNNg41GX4vv4qCm9WPBqoof3T5rK6hFOpMYqKfTVkSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, Yuchung Cheng <ycheng@google.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 1:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While BPF allows to set icsk->->icsk_delack_max
> and/or icsk->icsk_rto_min, we have an ip route
> attribute (RTAX_RTO_MIN) to be able to tune rto_min,
> but nothing to consequently adjust max delayed ack,
> which vary from 40ms to 200 ms (TCP_DELACK_{MIN|MAX}).
>
> This makes RTAX_RTO_MIN of almost no practical use,
> unless customers are in big trouble.
>
> Modern days datacenter communications want to set
> rto_min to ~5 ms, and the max delayed ack one jiffie
> smaller to avoid spurious retransmits.
>
> After this patch, an "rto_min 5" route attribute will
> effectively lower max delayed ack timers to 4 ms.
>
> Note in the following ss output, "rto:6 ... ato:4"
>
> $ ss -temoi dst XXXXXX
> State Recv-Q Send-Q           Local Address:Port       Peer Address:Port =
 Process
> ESTAB 0      0        [2002:a05:6608:295::]:52950   [2002:a05:6608:297::]=
:41597
>      ino:255134 sk:1001 <->
>          skmem:(r0,rb1707063,t872,tb262144,f0,w0,o0,bl0,d0) ts sack
>  cubic wscale:8,8 rto:6 rtt:0.02/0.002 ato:4 mss:4096 pmtu:4500
>  rcvmss:536 advmss:4096 cwnd:10 bytes_sent:54823160 bytes_acked:54823121
>  bytes_received:54823120 segs_out:1370582 segs_in:1370580
>  data_segs_out:1370579 data_segs_in:1370578 send 16.4Gbps
>  pacing_rate 32.6Gbps delivery_rate 1.72Gbps delivered:1370579
>  busy:26920ms unacked:1 rcv_rtt:34.615 rcv_space:65920
>  rcv_ssthresh:65535 minrtt:0.015 snd_wnd:65536
>
> While we could argue this patch fixes a bug with RTAX_RTO_MIN,
> I do not add a Fixes: tag, so that we can soak it a bit before
> asking backports to stable branches.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

