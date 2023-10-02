Return-Path: <netdev+bounces-37418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8F7B5459
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19AC4282343
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC5199D1;
	Mon,  2 Oct 2023 13:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AA199CE
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:53:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC8AD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696254783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Mrj5d145WqbtENreBONn0seQxwuGWLqhegF/9hzJAQ=;
	b=VrAfYBPRWF+8pJKWGXEBAl2v/A+ifABI/Gyi/Ps1JI+kbBLTIeTrB+Kfa92NSG/vrKXg7Z
	bQ7hWqjAV+zIlxB3MrgAamgRfsNfv8ZqCd1xLRn36c1e5rIR9fHxQwi536dgB0OnD435FN
	ue8I/BEBMaSTFyQnS638bzRTpYWOoaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-9FaUMBHkMjWGbgwB7cT4Xw-1; Mon, 02 Oct 2023 09:53:01 -0400
X-MC-Unique: 9FaUMBHkMjWGbgwB7cT4Xw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2e030e4caso303555866b.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696254781; x=1696859581;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Mrj5d145WqbtENreBONn0seQxwuGWLqhegF/9hzJAQ=;
        b=orgHEnsfKfG//CDR0PCHd6RTwdrbn8ZVe+Ayq9+BpWIlhAuJ/Bcw/FdbkUj7MuaDNN
         zEKlF2vM+idX2R7bk7EXuTrKavoACGM0yglTM86JonoJ5HMBS1kQRyM9NTfaTekVG91c
         mskeABvwXpCB6swGK/eI8KB1p6BjZoIVayQQQQ6Tn81iopBDuTGqxHZNzgUUflw4GdKD
         8oksfQWP19OAQS0r/ALLwIPaa9qe+AUzLbZ3l/1k4iVRpRFIz01gxAlHK/88qMF7pa5T
         6ZbaOCH7arZ7lVt38OD7z2jN4I4CFfoH0EFekuvNrTOmB7+h1iHvl2z3IEBJLRh9Z97p
         56jA==
X-Gm-Message-State: AOJu0YwphvLAxZ7Fa/kRlH9I+IAhc5LR/+SEBXZDV7j7z/UniP33K6yE
	Ka8uDJQXgYLOXdC90ZFCMKvvEKb2ivnkCCgYcGZjIEBwcsHYImNSE4ZGdraJRMszlfxGuETcKsy
	UOCrEgNkbHYLpSwe5
X-Received: by 2002:a17:906:225c:b0:9a1:f1b2:9f2e with SMTP id 28-20020a170906225c00b009a1f1b29f2emr10683080ejr.2.1696254780889;
        Mon, 02 Oct 2023 06:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvmg2L4GwygG+NnIWBQO9RWotyvFWD3eorxKExRmBbrcYT8Xt+oy99jHeQI7PckzsEqrFwrg==
X-Received: by 2002:a17:906:225c:b0:9a1:f1b2:9f2e with SMTP id 28-20020a170906225c00b009a1f1b29f2emr10683060ejr.2.1696254780587;
        Mon, 02 Oct 2023 06:53:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906090d00b0099cbfee34e3sm17047432ejd.196.2023.10.02.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:53:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A0B94E573FD; Mon,  2 Oct 2023 15:52:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 0/4] net_sched: sch_fq: add WRR scheduling
 and 3 bands
In-Reply-To: <20231002131738.1868703-1-edumazet@google.com>
References: <20231002131738.1868703-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Oct 2023 15:52:59 +0200
Message-ID: <875y3pgmh0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> writes:

> As discussed in Netconf 2023 in Paris last week, this series adds
> to FQ the possibility of replacing pfifo_fast for most setups.
>
> FQ provides fairness among flows, but malicious applications
> can cause problems by using thousands of sockets.
>
> Having 3 bands like pfifo_fast can make sure that applications
> using high prio packets (eg AF4) can get guaranteed throughput
> even if thousands of low priority flows are competing.
>
> Added complexity in FQ does not matter in many cases when/if
> fastpath added in the prior series is used.
>
> v2: augmented two extack messages (Toke)

Thanks!
For the series:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


