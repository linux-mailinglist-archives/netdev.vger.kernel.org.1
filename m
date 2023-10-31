Return-Path: <netdev+bounces-45413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7E7DCC76
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD44281703
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A841CF96;
	Tue, 31 Oct 2023 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XVDRC83"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331F107B4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:03:55 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D35587
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:03:54 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b747c9b067so1626395241.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698753833; x=1699358633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNv5fvxCI1H/SoX6PwFYUditFSgyB5ulH9BPKrUlntk=;
        b=2XVDRC83yYL9zlg+OUM87+5S0+8jq+rG4Wz5ICcYT8+VAZ6puAXcGtuGS4cWVuweGT
         9fDBwVCcGbOzGXsrdTOibQVdU3CloBXhWtUlkG1pIJ236rkGoqCpca/rGPIDF9smhLdz
         X/uB822kM2AxN3MPHECeTYvoJ14SkvEDG/3LspcGi9mB5QL+Omt4fEApdoQs18YH0hJM
         m3FZrLHPStDRZ0wNAwCynn6T+sVuoNiItX3BEcTz7b5ZCwR3z0FroBOr0d25Juf5xGp7
         9TiSCDr1EINOyg4PE64zYzz5QCtj3Sp8AdMIp34kgFbk9Bgc4NYD499G/iFU7c/rqK17
         GrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698753833; x=1699358633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNv5fvxCI1H/SoX6PwFYUditFSgyB5ulH9BPKrUlntk=;
        b=bwTHX9774ra2x21x2JFhzmpkesl1B1aZGqt34kRw23YkzSUjKEPaEfL0PuhAwxbk5/
         EDZxp1x2HJ9EopAO3eor9yKkK8LTRMabjlF7j5mtXrJ+KZcWPnN1beK1O4jnCbdFrDCJ
         WjhZbN/jR8CjVB20jdpqWujaYOKPYLE7FbOOT8QfnD3/J1d3YMi8gsJ8R7pY0dx7rO7L
         EgllN3q1/+Ig7cI44qTEOXcKke6CDe1Cfwx3B+XgLJ9i2lP4nz2LEkBTy57ZcXLPovoD
         bk4ElF+xNIGzF/nQH2ohKRmU6v7ygZPJqQPQpWX5Wur2DGK8j59w9Ah82R3pcjpbf+iq
         PWow==
X-Gm-Message-State: AOJu0YyTyEUxR3GENPDcivEVouHpfkraELSMhyZ3NJr9EjPUBsKJ3YrZ
	Q/KArbl/Htfw3Dx0eTuXvPOXXLunQ5536Xp85wvvmw==
X-Google-Smtp-Source: AGHT+IHexuhndpduQqd8sNyxnuqBYhfRTa2AQGW2vltSeRJhS8pWrqjhYWsKWcUo2kBvO8i/HFTHlG1kJXlPELysp1s=
X-Received: by 2002:a1f:2748:0:b0:49d:9916:5740 with SMTP id
 n69-20020a1f2748000000b0049d99165740mr7922526vkn.9.1698753833334; Tue, 31 Oct
 2023 05:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061945.2801972-1-edumazet@google.com>
In-Reply-To: <20231031061945.2801972-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 31 Oct 2023 08:03:33 -0400
Message-ID: <CADVnQy=Ln_SyA=VBxNNSPBqt8KY11k0tDtXZtHMxBoyatcF5Wg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix fastopen code vs usec TS
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	kernel test robot <oliver.sang@intel.com>, David Morley <morleyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 2:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> After blamed commit, TFO client-ack-dropped-then-recovery-ms-timestamps
> packetdrill test failed.
>
> David Morley and Neal Cardwell started investigating and Neal pointed
> that we had :
>
> tcp_conn_request()
>   tcp_try_fastopen()
>    -> tcp_fastopen_create_child
>      -> child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock()
>        -> tcp_create_openreq_child()
>           -> copy req_usec_ts from req:
>           newtp->tcp_usec_ts =3D treq->req_usec_ts;
>           // now the new TFO server socket always does usec TS, no matter
>           // what the route options are...
>   send_synack()
>     -> tcp_make_synack()
>         // disable tcp_rsk(req)->req_usec_ts if route option is not prese=
nt:
>         if (tcp_rsk(req)->req_usec_ts < 0)
>                 tcp_rsk(req)->req_usec_ts =3D dst_tcp_usec_ts(dst);
>
> tcp_conn_request() has the initial dst, we can initialize
> tcp_rsk(req)->req_usec_ts there instead of later in send_synack();
>
> This means tcp_rsk(req)->req_usec_ts can be a boolean.
>
> Many thanks to David an Neal for their help.
>
> Fixes: 614e8316aa4c ("tcp: add support for usec resolution in TCP TS valu=
es")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310302216.f79d78bc-oliver.sang@=
intel.com
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Morley <morleyd@google.com>
> ---

Looks great to me. Thanks, Eric!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

