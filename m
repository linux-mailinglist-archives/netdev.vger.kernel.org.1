Return-Path: <netdev+bounces-25974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A5776595
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A07281CBE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BC1BB3D;
	Wed,  9 Aug 2023 16:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523618AE4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:52:41 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13ED26A9;
	Wed,  9 Aug 2023 09:52:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d4b74a4a6daso4747999276.2;
        Wed, 09 Aug 2023 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691599948; x=1692204748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdMnSyUHANEAGVF0lxxaCMCZD79QCTJpJsgiMRN0RJ8=;
        b=KpnrrsqlXsf/t9v9NY/+2BFR9wgvmmKlAC8d2O3YW4GJXqofNAWhHCaYwqxeexqiMX
         eB/ziVXXDPbxxKpwXle1IAf6xp6O5fJQFDw7ShCx7Wl1iY4RKrQCmba7neRg05rLMm9I
         ZRSR+Y9TzaaqJXkhnpkEolxscM8JDMhTOc8dCjgKoQ18/gfnz2pagajeHk4rd1a97IE5
         SXmTX2EqO3m0qFe1d3OGXc8Lu5IrcJ7DpfCOMzbfT43d055zOnsXpjTTx1SU0vcYpEkw
         CRZZ60ZkeXBhqL6E/dwnxNY2Xc//CwPs8AMfV8CiTuDmuL0u9QZ9a3ZsOi2iKAEowRQS
         8idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599948; x=1692204748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdMnSyUHANEAGVF0lxxaCMCZD79QCTJpJsgiMRN0RJ8=;
        b=ZbKv5BjlBGQLc7lYvr+nA4U9bO6ulCJionz9KW4oDUXlHc9j9kLek/OG7CNGsQHAlx
         HWwahyLn8WCWoBuWjFf7tlqsUftbm2CBsgQsc43Nrv5Cj3VQtieuWcys9bAPIhkd7X1o
         N1p6BQ7Nc/Czm72vl4+LCcw/vcRxQg5o7mnNIw7Tx+xvj4tHr+IPLJC+9BEpS8heZIuS
         PnhqUoH0KvKH6LsVwMMaS2ZPFLOZ1y7q8Romeyzuugdp7bSrSfBmR1drOuxdy+3YmN7/
         L6jY4OTFkiZrw03qvB8/wnBysLXe3XElYp7OE+z/os5yC2ZNt/O+WrXmdQzgFGEzxT0x
         MbsA==
X-Gm-Message-State: AOJu0Yym5CggcHSMh7T+1kdJXMUTO4o0zwrhOWgWDKjfmCrYLqIg5xUW
	fJEoE02Fbx50iimuQTpZbQrdRFTZFlXP3jy7drc=
X-Google-Smtp-Source: AGHT+IHgUrADKpsNMX83yA1MwCfzqeoDrJJ2cuse8T5b6VMtE95ig6fndXaWHRBnMQQoUW87z8xBjtm7xcG17hPNpr0=
X-Received: by 2002:a25:84c5:0:b0:d4d:6366:1fcd with SMTP id
 x5-20020a2584c5000000b00d4d63661fcdmr18656ybm.0.1691599947857; Wed, 09 Aug
 2023 09:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809142323.9428-1-yuehaibing@huawei.com>
In-Reply-To: <20230809142323.9428-1-yuehaibing@huawei.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 9 Aug 2023 12:51:56 -0400
Message-ID: <CADvbK_ea0quFKZe_2Z3OsBVz_UjYDnaD3DCQ+cG107Mm2-jpfA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Remove unused declaration sctp_backlog_migrate()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 10:23=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Commit 61c9fed41638 ("[SCTP]: A better solution to fix the race between s=
ctp_peeloff()
> and sctp_rcv().") removed the implementation but left declaration in plac=
e. Remove it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sctp.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 2a67100b2a17..a2310fa995f6 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -148,8 +148,6 @@ void sctp_icmp_redirect(struct sock *, struct sctp_tr=
ansport *,
>  void sctp_icmp_proto_unreachable(struct sock *sk,
>                                  struct sctp_association *asoc,
>                                  struct sctp_transport *t);
> -void sctp_backlog_migrate(struct sctp_association *assoc,
> -                         struct sock *oldsk, struct sock *newsk);
>  int sctp_transport_hashtable_init(void);
>  void sctp_transport_hashtable_destroy(void);
>  int sctp_hash_transport(struct sctp_transport *t);
> --
> 2.34.1
>
>
Acked-by: Xin Long <lucien.xin@gmail.com>

