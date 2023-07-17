Return-Path: <netdev+bounces-18360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FA756982
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C51C20B4B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174615D0;
	Mon, 17 Jul 2023 16:47:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664C10E7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:47:10 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF18F
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:47:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401d1d967beso7771cf.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689612428; x=1692204428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+e3D526DKZcQ2/LAze/ywkjnh9HvcdhsT43CIzyhYY=;
        b=7e7AHSmKQjlPgGKaHQMt+n0aS+VVfmzs90QReaDQ30pWE3QbgvP4dlI/Eq6qWlom3Q
         tgsW7dq6VqsVnuMLzpC8HXpF6wS+Il45ekw6QnKdbZGn73Q7eC8/Yh5eD4nvIwav25k0
         YwOK6reB2bI0Y0MYUtSJ/3wNBcYbxZjtYl77R6rmYbgESIxXVNYbIJp4/9xZco/ph3Z3
         1xDkRJ7QPr6Fa+6zMY8s8mkIcRogUQTKMcJ07Y8d5d7u/ReENB0jfz9bAFol9ZrdAaHu
         0buWWeiD1Cvhwv2tcdjUP+4ZnYf/SgoRf9Rv7C8mTDJ9tYZGgzFtOaxKX7CzP9FWFygB
         24gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612428; x=1692204428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+e3D526DKZcQ2/LAze/ywkjnh9HvcdhsT43CIzyhYY=;
        b=EBG6jKcFuG87DscS/R8XZWOlCE7P33MsKmz2HYGyk2eNngGjFMxZiUlk5oqhLKYic8
         huQ3nB3KBGC7LlxHqKdeFHJR3DWpNWqY76kXqDhIF87xoGJPYIWwlFbJxK2Nbtkn401+
         2r7gxQ9c4BBtha5ffcrO/951ziqgEfuS+Bxr/M4mi5EnHi/DUZFBjR+QIN1XNY8QaVNp
         IAAJl5KfVhQdFIKQudx5FSh4++WUmGU23kLqIHdMMv3LdHlvHdr8Z6gsI4ET19uBSTqW
         vm/+7hfA3GjAh/EJJ6u+9OZ9Zx98EDYdX2+nEabuIGSQ+UG75dkhMfSQdr8w9rGOx+/f
         SvTQ==
X-Gm-Message-State: ABy/qLZLEmjX3q3QBjazHefT9sMpgpzushMHbp19KW32tSQ4RgMEjKkz
	rzw4IAwwBqpGijKHk7gKtWM+fo5VRWukJDci+pjNww==
X-Google-Smtp-Source: APBJJlGQHhjBTJOyR4ALML7m1VsuAIj3b+ZyvPRhX6Gs6PxHm6xVz7ix159HwbDQ9XiLkj/CyDwHvjJeQtoFD0rzAw0=
X-Received: by 2002:ac8:5b44:0:b0:403:96e3:4745 with SMTP id
 n4-20020ac85b44000000b0040396e34745mr1459522qtw.20.1689612428412; Mon, 17 Jul
 2023 09:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713112404.2022373-1-imagedong@tencent.com>
In-Reply-To: <20230713112404.2022373-1-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Jul 2023 18:46:57 +0200
Message-ID: <CANn89iJMzChaDsB+bPAuCEDUHVApsYs8KtD3oEC+oU_Qvi1KvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com, 
	morleyd@google.com, imagedong@tencent.com, mfreemon@cloudflare.com, 
	mubashirq@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 1:24=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped directly if rmem schedule fails, which means
> tcp_try_rmem_schedule() returns an error. This can happen on following
> cases:
>
> 1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
>    the receive queue of the tcp socket is not empty.
> 2. The receive buffer of the tcp socket is full, which can happen on smal=
l
>    packet cases.
>
> If the user hangs and doesn't take away the packet in the receive queue
> with recv() or read() for a long time, the sender will keep
> retransmitting until timeout, and the tcp connection will break.
>
> In order to handle such case, we introduce the tcp protocol OOM detection
> in following steps, as Neal Cardwell suggested:
>

For the record, I dislike this patch. I am not sure what Neal had in mind.

I suggested instead to send an ACK RWIN 0, whenever we were under
extreme memory pressure,
and we only could queue one skb in the receive queue.

For details, look at the points we call sk_forced_mem_schedule().
This would be a matter of refactoring code around it, in tcp_data_queue()

The patch would be much simpler. Nothing changed at the sender side :/

