Return-Path: <netdev+bounces-45883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647107E0039
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954091C20A48
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B214299;
	Fri,  3 Nov 2023 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWBrQ7AA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A414293
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:28:14 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B00D51
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 03:28:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so7304a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699007280; x=1699612080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY9ezNRbe4wkzwuD5NMN5rWnuziwTCNcV0CHKcJFCbk=;
        b=bWBrQ7AABRSQQ2xbLHc6622KDWIbW2ktuRhzurWBqXvj4+geCB8wS+j4TCdr11E6QM
         qzKgGIgPAoJqw6ehDRCe6GjmqPDJWcJm5WCrcK0chmg8t7iz2dr6qinJ/Zbn6/pqLliB
         uIZHsxwqUKa+h2jbgjyX5b2y+Z8/GtGyKYT2deOUY8an730dxa+N5IVsbmdOfGhzMIFB
         rdVYId9Ps9/CJlxCp3o8/KGZLlLlBUj0C/XGfxasGi/c+xwMytd3EpHXQ3+1oLLlGY9Y
         0Efl+W6WoBMselS8AoHMVfpKmN9Ek5+xzUe49X3ELE18ALHERdHJ5lskWrnn8PwxWU4k
         xTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699007280; x=1699612080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY9ezNRbe4wkzwuD5NMN5rWnuziwTCNcV0CHKcJFCbk=;
        b=p6kb2pvCRb/07y1zi1+oDBH3u8SxqboHKxtuMwsQXnky79Iviy/nncF7ruwLOe8/oa
         4htchUAcIVNlQsbkSGPiqsTdwWSpjQEEpmuiU82kEmMYjJg8GOSqErrTKX2sfWKF0gmK
         qLSRH4rqnays43yISEzTJ61I0dXxNwAmnw+CJuyupprCAlVmKqXo+WcSPnuwoNoFWXs1
         wqecGeMeowiKf1p9lXSqfYjau8EDq6DBIQb2UIwKDUp+S+RPzjh5tV5ntcx/B/Tg71Ga
         oz9n9Foy8en+ekfPVq2T++xnATfk67Y0BpgJZv92e5adPhFXTUKvyDcZS1fHKPnZ/AYz
         EEFw==
X-Gm-Message-State: AOJu0Yyc0XU97FOQmeFku1G9TzxVtux0qfj1n5MIsbphofYv9TWoVfMU
	ufhGmZwy76vk5TznVN9D8G+drlA5E20zrPVtQ9o0PQ==
X-Google-Smtp-Source: AGHT+IGyd5/INhnDJmxO2VKxxBkT1b90VPPlsG+jzqJsD8y/lUM6DQMfh//zGTQaC6ShjvMOlA/wzS+VDXbFfdQVdqE=
X-Received: by 2002:a05:6402:26c6:b0:543:fb17:1a8 with SMTP id
 x6-20020a05640226c600b00543fb1701a8mr184035edd.3.1699007280370; Fri, 03 Nov
 2023 03:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
 <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org> <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
 <CANn89iJOwQUwAVcofW+X_8srFcPnaWKyqOoM005L6Zgh8=OvpA@mail.gmail.com> <28e2bd4a-3233-471c-a1ae-57a445173401@kernel.org>
In-Reply-To: <28e2bd4a-3233-471c-a1ae-57a445173401@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Nov 2023 11:27:46 +0100
Message-ID: <CANn89i+7FWCX6+-puMj7L9f+=Ji6mV-Oca63k-c7OsEikmFPHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 11:14=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 03. 11. 23, 9:17, Eric Dumazet wrote:
> > What happens if you double /proc/sys/net/ipv4/tcp_wmem  and/or
> > /proc/sys/net/ipv4/tcp_rmem first value ?
> > (4096 -> 8192)
>
> No change:
> # cat /proc/sys/net/ipv4/tcp_wmem
> 8192    16384   4194304
>
>
> But this:
> # cat /proc/sys/net/ipv4/tcp_rmem
> 8192    16384   4194304
>
> results in test to run 4.7 s, so even 3 more times slower!


You might try setting tcp_shrink_window sysctl to one, with some side
effects for normal TCP flows.

