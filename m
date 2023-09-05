Return-Path: <netdev+bounces-32132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE4792F71
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF20281186
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1472DF4C;
	Tue,  5 Sep 2023 20:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341EDDC5
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:04:18 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96C109
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:04:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-402c1407139so30591255e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1693944256; x=1694549056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAHXFSmpuYMwhbTe94DCn7ImjiGtbOJCwz/57HmnOlE=;
        b=jM/lXP4BRz61PD4Y8IlEAj/GMUfPeiVKwjIyA2CHB7bcONsW8b0x+XuVmi/8kQwSVQ
         ZYSvZ1pS3H2Ug3uAjSwmza4zezY/ZXmYJnnFUjs0ObE3mAV+An/tTsPl2mmALxD8GOKk
         HOIVPNMZz3YbhGHziCLh/mFxAWaoD//65DHU60DrRybHUHLdnp34mwuzWnJa/C878hRT
         Z2yvRYY8nzJQFZIzHZeTf33GLdR4Hb1beVCyDi4vZIEObOLgVEgn7DF2WzSm45Qoul33
         T1pq4t1QvefRulVRgE+hj1nw9m/jTSQbS5Bte0fwccBqdm9wSNa1p6igcKNmfAopZEq3
         gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944256; x=1694549056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAHXFSmpuYMwhbTe94DCn7ImjiGtbOJCwz/57HmnOlE=;
        b=AgJ4YvsFpuOa1NrQ9hl8r8Oq0hBbv7Bie3dL8g5P11HZlLbx1MFzYsLeB+p8Scdtb2
         0JznJ9aJ0ksd1gnYCkaFv3bE88P2+ExMmnCKEi1OQL+EVRZsvbum9lZX7AvSrzfsSI98
         NC+CyirNEle9xcHrSjNoLODZKVd/Ni8hqqBzMm1mah+wkxR5guMEjviqopnXEeKxNjUs
         iPF0EIjMjuLySEyekxcpKu4Q2170nS7W2UqEsLit4W1nbsSnIZ4rwkRHQ4e4lkrFtoMl
         qXyduWehPq2pyi2rP+HEYfcval69cwhfwP22dEL6IVvXNrUvsSFasEOFrf7f3RfrUKKA
         HtZA==
X-Gm-Message-State: AOJu0YxQ0WckrMR4cQ1V5IrLLdxxpkqrRpqPzUdn9Kq59lzsKl8wYwAE
	QipYB0+9/A54lT/Rt38yrFHymA==
X-Google-Smtp-Source: AGHT+IHelAJ8rhTH2NaDH74hFo3y+fgZsyTP3gVU0H1zG3eGW4P05qp7T1e/T0gSXJZN2+HinXwBvQ==
X-Received: by 2002:adf:dec1:0:b0:317:731c:4d80 with SMTP id i1-20020adfdec1000000b00317731c4d80mr638853wrn.24.1693944255699;
        Tue, 05 Sep 2023 13:04:15 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i16-20020adfefd0000000b0031c5d74ecd8sm18401955wrp.84.2023.09.05.13.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:04:15 -0700 (PDT)
Message-ID: <973ddaf6-0725-8bae-f90b-7921e0104e24@arista.com>
Date: Tue, 5 Sep 2023 21:04:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 net-next 08/23] net/tcp: Add AO sign to RST packets
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>,
 Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 "Nassiri, Mohammad" <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>,
 Simon Horman <simon.horman@corigine.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-9-dima@arista.com> <ZNy3+f6ZtDKfsQ5C@vergenet.net>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZNy3+f6ZtDKfsQ5C@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Sorry for the delayed answer, I went on a vacation.

On 8/16/23 12:50, Simon Horman wrote:
> On Tue, Aug 15, 2023 at 08:14:37PM +0100, Dmitry Safonov wrote:
[..]
>> +	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, reply->seq,
>> +				 &key, &traffic_key, &allocated_traffic_key,
>> +				 &keyid, &ao_sne))
> 
> Hi Dmitry,
> 
> The type of the 4th parameter of tcp_ao_prepare_reset() (seq) is u32,
> but here a __be32 value is passed.

Yeah, it gets converted in patch "net/tcp: Add TCP-AO sign to twsk".

> Also, it seems that parameter is unused by tcp_ao_prepare_reset().

And only gets used in "net/tcp: Add TCP-AO SNE support".

Hard times when you keep changing the patch set, eventually some nits
and bits get introduced in earlier patches only to be modified by later.

What's worse, I can see that seq is getting used as ntohl(seq) and
tcp_v6_send_reset() does htonl(seq). So, it's better be u32 argument,
introduced by SNE patch, rather than gets converted to-and-back.

Thanks for noticing!

[..]

-- 
           Dmitry


