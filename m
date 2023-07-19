Return-Path: <netdev+bounces-19014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F55759534
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208922818ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E38107B5;
	Wed, 19 Jul 2023 12:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A68101E6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:36:10 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C938E0;
	Wed, 19 Jul 2023 05:36:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5178285a12.3;
        Wed, 19 Jul 2023 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689770169; x=1690374969;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZdKOkj/pVrFSmE8tkXiZ35iQBmOuKBnbuFSjBYYCYM=;
        b=qKujtPbWHCdhULLk6BL+9cSOPZl355b9NMUZuqVpy1vP9noL9gzlP0beeIT8Aybc9r
         22QjjwKM9utPp+OeTlI1AABqGgDU7PqYvGPvSOV5z5K2b/kCNgEvTfFSv+UGZzHrVZ3H
         H9lBLip5BoITAL9mXlNUdZUrpe7s0FZ5XKJoBe6fHGIAIGhcEIka1h9kWHJOkUfoV73l
         vW7KXdMPLDe9tO0R/BebWTSW/2lnDjCbgXkZyZn1jVhPWPnrjYAP8sPo11DohIadhTEW
         sfQMJD/9tfuVzDzTJV8bNoruPxgtXuNm+fZLA3ic8k6xs9vsf6z3uzyo0zv+8v8GYke2
         AaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689770169; x=1690374969;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZdKOkj/pVrFSmE8tkXiZ35iQBmOuKBnbuFSjBYYCYM=;
        b=W2izTA5jHmDsOzruWANzRFP6U2Vf51J38TgO+qkX1LLKcp5DRo4vNq2MnObfsP8ENZ
         ZZF5TiP0v1/qfjQeTSdP7FwCebJmSPy4Lbed+gg80wLO9b5ZeJg7Ut8jfdWRr0dY3OmO
         AfC5iL0QrG+dXWGs7cWMJmtLh54+4gLtQuUl5XEj+8aCFJYiTN1/ek8HM5wXdKbpYKQn
         gN6WfSrR1a5X+KuY/Hi4v7mGERrx7V5Ktzkxv2IdXOXQfteNd1keOfNojQU2adbcwCcU
         AQPe5S97qHrm/4Fx49zDwVjgC9YUMLm4l5N6XSoPnTsPyYNn5dLGgmtbiHs0oZIsx2j8
         D2qQ==
X-Gm-Message-State: ABy/qLYDWkjdbSNUKAJPhiWApqyl4VClt4Cbx5hUado0SZPJ7QDC5i8Z
	026z0Phpl2Kqqhd4IFXEK9xju3Zip1kZ4G+3
X-Google-Smtp-Source: APBJJlGucFMUwkgT49zJJYTKA+XetmHtHCMMw1YV8DRbgBunp2jmaYGuZc7Ec1h8XcCkNNaQh+NrQQ==
X-Received: by 2002:a17:90a:d392:b0:262:d661:75e4 with SMTP id q18-20020a17090ad39200b00262d66175e4mr1965052pju.0.1689770168957;
        Wed, 19 Jul 2023 05:36:08 -0700 (PDT)
Received: from smtpclient.apple ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b0026309d57724sm1185425pjc.39.2023.07.19.05.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 05:36:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
From: Menglong Dong <menglong8.dong@gmail.com>
In-Reply-To: <CANn89iJMzChaDsB+bPAuCEDUHVApsYs8KtD3oEC+oU_Qvi1KvQ@mail.gmail.com>
Date: Wed, 19 Jul 2023 20:35:39 +0800
Cc: ncardwell@google.com,
 davem@davemloft.net,
 kuba@kernel.org,
 pabeni@redhat.com,
 corbet@lwn.net,
 dsahern@kernel.org,
 kuniyu@amazon.com,
 morleyd@google.com,
 imagedong@tencent.com,
 mfreemon@cloudflare.com,
 mubashirq@google.com,
 netdev@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95B4463B-F57A-46A0-8F04-D52A84058343@gmail.com>
References: <20230713112404.2022373-1-imagedong@tencent.com>
 <CANn89iJMzChaDsB+bPAuCEDUHVApsYs8KtD3oEC+oU_Qvi1KvQ@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 18, 2023, at 00:46, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Thu, Jul 13, 2023 at 1:24=E2=80=AFPM <menglong8.dong@gmail.com> =
wrote:
>>=20
>> From: Menglong Dong <imagedong@tencent.com>
>>=20
>> For now, skb will be dropped directly if rmem schedule fails, which =
means
>> tcp_try_rmem_schedule() returns an error. This can happen on =
following
>> cases:
>>=20
>> 1. The total memory allocated for TCP protocol is up to tcp_mem[2], =
and
>>   the receive queue of the tcp socket is not empty.
>> 2. The receive buffer of the tcp socket is full, which can happen on =
small
>>   packet cases.
>>=20
>> If the user hangs and doesn't take away the packet in the receive =
queue
>> with recv() or read() for a long time, the sender will keep
>> retransmitting until timeout, and the tcp connection will break.
>>=20
>> In order to handle such case, we introduce the tcp protocol OOM =
detection
>> in following steps, as Neal Cardwell suggested:
>>=20
>=20
> For the record, I dislike this patch. I am not sure what Neal had in =
mind.
>=20
> I suggested instead to send an ACK RWIN 0, whenever we were under
> extreme memory pressure,
> and we only could queue one skb in the receive queue.
>=20
> For details, look at the points we call sk_forced_mem_schedule().
> This would be a matter of refactoring code around it, in =
tcp_data_queue()
>=20
> The patch would be much simpler. Nothing changed at the sender side :/

I think you are right. I misunderstood the code in =
tcp_retransmit_timer().
It seems that it already handle the window shrink case properly.

Let me do more testing first.

Thanks!
Menglong Dong


