Return-Path: <netdev+bounces-32972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1DF79C134
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AF1C20A38
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A880E;
	Tue, 12 Sep 2023 00:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1D10F7
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:43:17 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225715CEEA;
	Mon, 11 Sep 2023 17:10:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34df008b0cbso17587125ab.1;
        Mon, 11 Sep 2023 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694477348; x=1695082148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5WMUEGKJ7eIap0nhI1fqJpW2DseHZBErJML2IMf20M=;
        b=jHxZDvblhuLXWgQB38gT+E1F6P48gteYrlGk18j7NhkSYgyBSxdLivljMExbZB0ooy
         Ue2KUC1wYvDqNDzuMIrhXG0Q0pPt9zxHYRr98xIVBgnnIAGCeaGxdpFNVkLlofGZAPLZ
         MiN9UOFv8EPvPztantxk50DPWoED/1R3r5DIs6/lgelKR3edCTnl/ekKJCL5q4VqVrVw
         zzA7s2Kar5bN8lXj5+AryS388BSokXDvamqfX0iIouaBcTywUfgIYQiWiNDMi+b59tWk
         8hTjDsyFUgZbTzlUfBtsgUS0GzwXrjeGVUmd8cFIKgX7ex5+SRzzQbsGjxGMvoVKasdU
         xImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477348; x=1695082148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5WMUEGKJ7eIap0nhI1fqJpW2DseHZBErJML2IMf20M=;
        b=vdlbdjWys/nJ0EX5KeHWx+bNVFhHEWMj+Cep4XMehO1R8Ji8IbUqeNfB+WY6ctYiuD
         Ng60/MgI71Ps4bhb6oRibBcpFIuPsl72QAkklAiOCf1ybkJ7vsx/VTZtNi9fX3Jjk7rN
         +qtRdCNhF3rH+q84/NEYuuY8JT7WRImLXuBCrmiSN6xQubwPvbOPsaJRC1ni97M7cVfP
         3EblP1wgD6DWbAZARFRqxS1hIcDSeIfR9DigFBmU92e2rRcPKT+Q0yPAJp1ayxKXriWj
         S1X7nm5vNgYXuZntduDjevL0i+DYyLY6erZgLsp0JxDJELTiRLcpBV1V6ljRh5loQamk
         BY4Q==
X-Gm-Message-State: AOJu0YwgYggSI4lGm6x9vp+fSdaWdB4BKrJfn5E9RkbvAZL8mRTsK1yT
	Ibi08BRufknPWhaVO5Ne501LQb10yk0=
X-Google-Smtp-Source: AGHT+IHU/Lewuz4gtERa76E4z8kKO9LkcNu8fUKblIxiCWNuAsOictGAM5s8oQqXaM1AEcqC+moxSw==
X-Received: by 2002:a17:902:6b08:b0:1bc:1189:17f with SMTP id o8-20020a1709026b0800b001bc1189017fmr8282406plk.42.1694475418376;
        Mon, 11 Sep 2023 16:36:58 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:5b6e:44b:2440:c142])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b001bd41b70b65sm6941628plv.49.2023.09.11.16.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:36:57 -0700 (PDT)
Date: Mon, 11 Sep 2023 16:36:55 -0700
From: Andrei Vagin <avagin@gmail.com>
To: Joanne Koong <joannelkoong@gmail.com>, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, edumazet@google.com, kafai@fb.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dccp@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v4 1/3] net: Add a bhash2 table hashed by
 port and address
Message-ID: <ZP+kl4/UuTaQTGPT@google.com>
References: <20220822181023.3979645-1-joannelkoong@gmail.com>
 <20220822181023.3979645-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822181023.3979645-2-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 22, 2022 at 11:10:21AM -0700, Joanne Koong wrote:
>  
> +static bool inet_use_bhash2_on_bind(const struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family == AF_INET6) {
> +		int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
> +
> +		return addr_type != IPV6_ADDR_ANY &&
> +			addr_type != IPV6_ADDR_MAPPED;
>

Why do we return false to all mapped addresses? Should it be

(addr_type != IPV6_ADDR_MAPPED || sk->sk_rcv_saddr != htonl(INADDR_ANY))

>
> +	}
> +#endif
> +	return sk->sk_rcv_saddr != htonl(INADDR_ANY);
> +}
> +
>
Thanks,
Andrei

