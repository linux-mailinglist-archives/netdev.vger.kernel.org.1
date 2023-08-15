Return-Path: <netdev+bounces-27601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5260877C83C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D041C20C2D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88BA6FA9;
	Tue, 15 Aug 2023 06:59:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD961857
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:59:48 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2219A0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:59:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34ab3599df8so19075ab.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692082784; x=1692687584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPApdsQIHjX5ZEMalsPZBQcxVIzaH6ygbukwtyI6E2o=;
        b=GUFsP+WjmGRjNsI8S+wEJo5xg2pTrLmvtGgoK2iUlBrFGs5YT3iiM6yrMfGwETMW/Z
         v00RoS6Jxy3ICz6eb6nutJ0pwpxDwZ++7NuSMHAHTo1zwLZqIVOKNsZT1p8HeSSJzOe/
         OndWy+qBxWEosMRRgcJiVWPs/gL5zYvF4jzaAiU6ZkuXglvBULDdH5iCRCc4BbRM/N+7
         Y7EalEx5mY8UOrTuyt9yOXREBzYNjSnnfj+DH2GL2Nf/+lGLL4B6/G1ltiYHr8pAcDGk
         ulsJgj4mw5Rp0WPUq2xbkPnrFwCPGc8rlvNhmWQUjOEXSXxVIkGLeiW5BTaBrE4/FLyu
         AzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692082784; x=1692687584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPApdsQIHjX5ZEMalsPZBQcxVIzaH6ygbukwtyI6E2o=;
        b=FfY2xsgDFp8ivGmz1s5rCF2q6fbMsKByUstxRNmrojFISdoRLcu5AxDIrZZfXcYH9v
         TovE/Al7a5bPBpRjUKgfOY5NKHqdc+s2D+NjW4kidn9V4qkTnXCIxHZlZKmZ0MFt3Hd8
         Wqs3oErhFbYWYP31fQ/rIGwA8u76BTQlC29ddR9fGUbhZp4t4WMfxFFm1jpxFEQwpD6K
         TdPV/rcbCwAq6wnTP2PgSJJ/rTl7HussUIxwGNyZy5ECs0EtqTd0E5yszePdjrxaYIYm
         h91MR+7eb0cbfNRkRPChkZyu65zisa4Zyr7CbwNPblLn/T2kXQtjnAVn0TvDVWLjS4aL
         zupg==
X-Gm-Message-State: AOJu0Yz99JaW2I+OBuosQi2jP24fcdBr6b65wCZCZPZ6wluWCJSEyyZc
	Ak9TV6M4blReTtDiuCxqJGWKXa8F6vUo+/SgiiiDig==
X-Google-Smtp-Source: AGHT+IHZakWR7fnuvNC605Ms2oumG3fmoNqdaL4iM2iv3HyGaf/orS3GKaJJIOxuYZN4XMAn8qW0bE705EIca9RB7K8=
X-Received: by 2002:a05:6e02:214b:b0:349:1dfe:ff2a with SMTP id
 d11-20020a056e02214b00b003491dfeff2amr801645ilv.19.1692082784077; Mon, 14 Aug
 2023 23:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811023747.12065-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230811023747.12065-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Aug 2023 08:59:32 +0200
Message-ID: <CANn89i+RkWM6ZV4xzfTcPNG9o2J7bggTmzuOZi=MWMHxqdkauw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: fix the RTO timer retransmitting skb every
 1ms if linear option is enabled
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, apetlund@simula.no, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 4:38=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In the real workload, I encountered an issue which could cause the RTO
> timer to retransmit the skb per 1ms with linear option enabled. The amoun=
t
> of lost-retransmitted skbs can go up to 1000+ instantly.
>
> The root cause is that if the icsk_rto happens to be zero in the 6th roun=
d
> (which is the TCP_THIN_LINEAR_RETRIES value), then it will always be zero
> due to the changed calculation method in tcp_retransmit_timer() as follow=
s:
>
> icsk->icsk_rto =3D min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>
> Above line could be converted to
> icsk->icsk_rto =3D min(0 << 1, TCP_RTO_MAX) =3D 0
>
> Therefore, the timer expires so quickly without any doubt.
>
> I read through the RFC 6298 and found that the RTO value can be rounded
> up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
> regarded as the lower bound in this patch as suggested by Eric.
>
> Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

