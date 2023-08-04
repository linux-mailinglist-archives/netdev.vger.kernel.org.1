Return-Path: <netdev+bounces-24334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D376FD0A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9842822A7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B1A924;
	Fri,  4 Aug 2023 09:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4B9479
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:16:42 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474155B1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 02:16:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso175691cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691140588; x=1691745388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmNl3T8MlCmqqijxqD/Hey3+h48zjDtpjrFP9ZdqUlw=;
        b=0riHllquqQtKiHEy5asi3gtQgp6sDjqUjhRZQJN51+IT+lpCdCGMWqa0yKlqBm7adH
         Y93zj4RyVcR0yVVuytPsno1brCwXtc1TUcpluVLgmxZhvuKGJIyxQH067UUpyb6bTe8M
         YCfxwzjmU/UghtsMhcDySjvawlwrmSo1VnvwhMgt3i40cafzXviLemffX/6/vTa3RijN
         2S+HpT5NJJa97ci/4PFrzIkGATqcEI/dmAhVIh5wyKzOVfVB90rgboW0MTnIbpyaECYD
         /KnQpFJzIOrl+JxAw1JmaJpXy4nGRuzpeJaw+0pw97IbZzgOPIjRt+9lb73cLMD3u9Pz
         rAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140588; x=1691745388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmNl3T8MlCmqqijxqD/Hey3+h48zjDtpjrFP9ZdqUlw=;
        b=MyQlrUYzkzXEsxZIMM0FV2vSR2xFaYAAr9R02wVhdS6yx0pym0OEdUyAU5nvN8Q2du
         sw/zKsUW8a/UlUjfOeQ/WwCM16cqTd80Fy91kFQCFUGzxyAB56w2S/NxMbj9QiUc+RIE
         IQzE0RuRyAz1z2jqQT2+CDbe8pPHIw+2MC27/e3223lrJPP67R5JCNlouI6KCdMqiBPS
         mG4TU569Epl6FesP1V37GF7ULeTeLrKik6TC0xmKve66eWdPXg6gNgK8MsVRiikZUvkS
         ug/Fyb+RpJIGPhpGpr7DwSxNdzolAt/ASfDUEsAwHGMbdS/69do9nEGGSB/x3zbROFz/
         ra8Q==
X-Gm-Message-State: AOJu0YzcYHuWI63jAzyjYGzrElxLwUfbmk25wSvn/GNzZneTgTggGrbd
	1l6p22HBmFx7q6ZKFC3YlTcrMMdoQksdA5bOTh1MzQ==
X-Google-Smtp-Source: AGHT+IGLi401rMmPOiHowz9rZghey0A3Q32W1kQ+21CNkMXONKsh7yd5C2MC0gMCHmpssLbmZBDPmmtlIjo/qqKlXg0=
X-Received: by 2002:a05:622a:1648:b0:3f8:5b2:aef5 with SMTP id
 y8-20020a05622a164800b003f805b2aef5mr116060qtj.29.1691140588528; Fri, 04 Aug
 2023 02:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803224552.69398-1-kuniyu@amazon.com> <20230803224552.69398-2-kuniyu@amazon.com>
In-Reply-To: <20230803224552.69398-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 11:16:17 +0200
Message-ID: <CANn89iJosh3=28rngTQQgBJ4S2LBrGPwUuXD4RENdYqkudg4ig@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/2] tcp: Disable header prediction for MD5 flow.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 12:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> TCP socket saves the minimum required header length in tcp_header_len
> of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
> to generate a part of TCP header in tcp_sock(sk)->pred_flags.
>
> In tcp_rcv_established(), if the incoming packet has the same pattern
> with pred_flags, we enter the fast path and skip full option parsing.
>
> The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> again later in tcp_rcv_established() unless other options exist.  We
> add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len in two paths to avoid the
> slow path.
>
> For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> to tcp_header_len in tcp_create_openreq_child() after 3WHS.
>
> On the other hand, we do it in tcp_connect_init() for active open
> connections.  However, the value is overwritten while processing
> SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
>
> These two cases will have the wrong value in pred_flags and never go
> into the fast path.
>
> We could update tcp_header_len in tcp_rcv_synsent_state_process(), but
> a test with slightly modified netperf which uses MD5 for each flow shows
> that the slow path is actually a bit faster than the fast path.
>
>   On c5.4xlarge EC2 instance (16 vCPU, 32 GiB mem)
>
>   $ for i in {1..10}; do
>   ./super_netperf $(nproc) -H localhost -l 10 -- -m 256 -M 256;
>   done
>
>   Avg of 10
>   * 36e68eadd303  : 10.376 Gbps
>   * all fast path : 10.374 Gbps (patch v2, See Link)
>   * all slow path : 10.394 Gbps
>
> The header prediction is not worth adding complexity for MD5, so let's
> disable it for MD5.
>
> Link: https://lore.kernel.org/netdev/20230803042214.38309-1-kuniyu@amazon=
.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

