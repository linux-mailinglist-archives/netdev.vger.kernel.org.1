Return-Path: <netdev+bounces-30010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E021785971
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E9528117A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE148C128;
	Wed, 23 Aug 2023 13:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF2BE7D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:35:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECACDE7F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692797747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e81i7+rqpkC/zX4ymrp3HPYgAeBHOldKterDX4M7y/A=;
	b=VagbL3JwVL7Ado8wZquEPS/6bFgDOuU2HEK+kccms1E3fay/VcGDUL6apz1oOZOL6SB45k
	5ZHq/J/XtYituyd1mUA8Bt1a3jydVifbXCv+TR8NWLTXyd8nVMkG/mB9oxDZLOHDv/RFGQ
	Hb7YwKo06YW+Of5b4wCx6R+lgnrmbTo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Rejj5gbXM9W5u89VPO57Fw-1; Wed, 23 Aug 2023 09:35:45 -0400
X-MC-Unique: Rejj5gbXM9W5u89VPO57Fw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe19dc13a0so676378e87.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797743; x=1693402543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e81i7+rqpkC/zX4ymrp3HPYgAeBHOldKterDX4M7y/A=;
        b=jmtMjNhIqpyN6UD9puW9IS3W6h5UCdurKaA7Re8zZ4fXq7HdwuHrk5N4xDbiiU49OC
         DST6sZ1vhl6W1yci+SP5xKGEj5erzKTq4CI0a4PrAX/yIcY94+saiRVg4BQgvBc36+56
         FlHoK/AD/ZxNPP938qb9/+vhHYo/ZAwRUPuMPA88kCvMWrqSNXuo+l9VWh+TTemO6pii
         XcnPluA2Mc8Hq38JPEuzJRqGflw07fs+Ih+Qv9vslxUyOHEN0rbv6N4wTeCBV9MI8UT5
         RZme0ua7CFZ3BtXaIOacEPg906/ZvAhmFQE3j+zQiGrhLnOsa9PkneOF94Bv4snDDkap
         rHHw==
X-Gm-Message-State: AOJu0Yyqg9Gd9kKtmEQo5c6+obNUxCCKYyIuWtJIx4zPlPUkBCoHcx8I
	Gr0VuIzmAks6OxMNpj0B2DccoCvdrB9ZfPHkw38LIVeU/XaI6tnzvnkSuAsqGYnjmoBLjXrUm3W
	d1p4q+sX4zXqMB+yh
X-Received: by 2002:a19:7601:0:b0:500:8b4d:4cb5 with SMTP id c1-20020a197601000000b005008b4d4cb5mr3980803lff.3.1692797743674;
        Wed, 23 Aug 2023 06:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuhAiNrehaQQO98CGyKE6j/MfqLyPXBjiPxs+5vglJdyw+4A/bbnYK6/ewAxZMijt61Ww0AQ==
X-Received: by 2002:a19:7601:0:b0:500:8b4d:4cb5 with SMTP id c1-20020a197601000000b005008b4d4cb5mr3980794lff.3.1692797743358;
        Wed, 23 Aug 2023 06:35:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id mh9-20020a170906eb8900b009934855d8f1sm9789905ejb.34.2023.08.23.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:35:42 -0700 (PDT)
Message-ID: <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Wander
 Lairson Costa <wander@redhat.com>
Date: Wed, 23 Aug 2023 15:35:41 +0200
In-Reply-To: <20230814093528.117342-2-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
	 <20230814093528.117342-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-14 at 11:35 +0200, Sebastian Andrzej Siewior wrote:
> @@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, =
int cpu,
>  		 * We can use non atomic operation since we own the queue lock
>  		 */
>  		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> -			napi_schedule_rps(sd);
> +			__napi_schedule_irqoff(&sd->backlog);
>  		goto enqueue;
>  	}
>  	reason =3D SKB_DROP_REASON_CPU_BACKLOG;

I *think* that the above could be quite dangerous when cpu =3D=3D
smp_processor_id() - that is, with plain veth usage.

Currently, each packet runs into the rx path just after
enqueue_to_backlog()/tx completes.

With this patch there will be a burst effect, where the backlog thread
will run after a few (several) packets will be enqueued, when the
process scheduler will decide - note that the current CPU is already
hosting a running process, the tx thread.

The above can cause packet drops (due to limited buffering) or very
high latency (due to long burst), even in non overload situation, quite
hard to debug.

I think the above needs to be an opt-in, but I guess that even RT
deployments doing some packet forwarding will not be happy with this
on.

Cheers,

Paolo


