Return-Path: <netdev+bounces-26673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5A77887B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F12820B9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2C5693;
	Fri, 11 Aug 2023 07:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DC1FBA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:39:29 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF7E75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:39:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40a47e8e38dso125531cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739568; x=1692344368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mGj/IvUxGsWCDiYlrlJ8w5YX+AESHKKi7ix/f+88H8=;
        b=QpKmBm9X10I1cpwca31UgiVWToGYbGkx/PnuwE5LYZ+ZGiu7acRaeRgkjRl5/6Bcs9
         DSyvJMQ3Wj06s0HofvgOKcku+03sC55CqTxSFfTptpfWDJQzoWUyHZ9ds8KSWNR4+93U
         JzDmWk2Tenttj5CFeiglCAd36kqD1RCUNBnxELu2MSeq/1n3xlKQjmAKMk659OkX0bcr
         e7SI89UbclSBqJ9qD/uK8dcduxIjyHpl9PZi1JKqX8MB0B9peMGdL2ESlP3IE/xhqPl+
         savezKpXgvmXNH42EWoN7Ef0tuWQekuPjjZrPv1SRQEapYDv+frIdlSAMAs6FrK8a2cd
         b8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739568; x=1692344368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mGj/IvUxGsWCDiYlrlJ8w5YX+AESHKKi7ix/f+88H8=;
        b=J817k8RvITTZtXPNLaHO2FWOwXu+p0VtRqDN74RNGnyaM5tKA4kYovCe83tddF/jPj
         crHMZXKwstpzCsH+ThPgRgXIJXJfyqHFxyEpRtswMCz2esxZFIKWcMxdJ4qLfjE+CrTA
         WGVbDi/eLiDtiKPeZwSB2s+ESkxrjANNBHaQrSfUQ369WxNa0UUeP7rpXPDZZKXed612
         CeMjBNeNbzsltsU5YQOCifx4ELRA8I39Ytmk9acEPhhGDJ49anNEydljTaRLWMEbAy3L
         0XzHA6dqFS8BNcZndbPGwexmQSdj70hDP07CRtNoRll21yHNnER7sG/I70uKQ7zV8Y1H
         KLYg==
X-Gm-Message-State: AOJu0YxLmkbS8YAbVo1s5bkx2xnim/OnkLRxposka+E/xR9qe6830bh7
	WNs4jVrtB+oGb/vUxgaoFxFNn8yHP6T4XRCMwIymzA==
X-Google-Smtp-Source: AGHT+IGEo8hTHIWhEthJEXMpXEEsoBCNaV27+0xDNHg7511j4iphouiDh8GHMv7wfDzaHVWNQL2F4sklwgNRGDCjoZA=
X-Received: by 2002:a05:622a:1b8c:b0:403:affb:3c03 with SMTP id
 bp12-20020a05622a1b8c00b00403affb3c03mr183373qtb.10.1691739568069; Fri, 11
 Aug 2023 00:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Aug 2023 09:39:15 +0200
Message-ID: <CANn89iKYKSBsaYiXKoJs-iHK5+zx74hKiDwMxV0_58kNEB3QBw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: tcp: support probing OOM
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, flyingpeng@tencent.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In this series, we make some small changes to make the tcp retransmission
> become zero-window probes if the receiver drops the skb because of memory
> pressure.
>
> In the 1st patch, we reply a zero-window ACK if the skb is dropped
> because out of memory, instead of dropping the skb silently.
>
> In the 2nd patch, we allow a zero-window ACK to update the window.
>
> In the 3rd patch, fix unexcepted socket die when snd_wnd is 0 in
> tcp_retransmit_timer().
>
> In the 4th patch, we refactor the debug message in tcp_retransmit_timer()
> to make it more correct.
>
> After these changes, the tcp can probe the OOM of the receiver forever.
>
> Changes since v3:
> - make the timeout "2 * TCP_RTO_MAX" in the 3rd patch
> - tp->retrans_stamp is not based on jiffies and can't be compared with
>   icsk->icsk_timeout in the 3rd patch. Fix it.
> - introduce the 4th patch
>
> Changes since v2:
> - refactor the code to avoid code duplication in the 1st patch
> - use after() instead of max() in tcp_rtx_probe0_timed_out()
>
> Changes since v1:
> - send 0 rwin ACK for the receive queue empty case when necessary in the
>   1st patch
> - send the ACK immediately by using the ICSK_ACK_NOW flag in the 1st
>   patch
> - consider the case of the connection restart from idle, as Neal comment,
>   in the 3rd patch

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

