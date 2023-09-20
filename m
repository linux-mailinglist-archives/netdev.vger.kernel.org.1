Return-Path: <netdev+bounces-35327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D490F7A8E34
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31FD1C20AB0
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A683CD01;
	Wed, 20 Sep 2023 21:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113B15AF6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 21:05:44 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA59BB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:05:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c1c66876aso21356066b.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695243941; x=1695848741; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2h0XAsLzr2wqEnoGZx05JoF4JAu/PEZ3flmzio8kzA=;
        b=MZIxuL/KSjsLG4q3zh4MQ8Xoxy49mbonBmckFllS2+z+Qrojq2/sT71Fr1oM4CWlfc
         KS58XBvrPgRIL/kqul5WYBzOO4R/IFO3HRL2UaQGr1zYJ8uhIrsM3hYPBppz8ogmzMPy
         NYQGqYtFO4K/Vp8Nzs286PAXYLJM+p3rx255mTIplY3UtQM9dDUWoSttcCeX3qHQKlgd
         NIizHlgNXMnk8I8rOl66eZVYon8ZyplS1t0NB4LVXRtpL1aGAgk4nmvwpShSU2k8dAGY
         rhFuIZUfel8KkJ9w5tMayTlkx/He8Vg4UIAvIwOjwMLLCs+vChvi9dqNlvgWQ/J79Lzk
         ljhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695243941; x=1695848741;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2h0XAsLzr2wqEnoGZx05JoF4JAu/PEZ3flmzio8kzA=;
        b=XRJW50u8NyAd7FS11D7bFBlpiBLZwiIBRhZRorDRGNbc499MTLIH0xhDZkFWW3c18U
         NLsgycRY75xjHhFwUhPlLYUZImr60cwdq/buKU1Btoxkp2gU30KtEtDarjFmZCoHpqss
         sE2YShBuONL0O6lMgNiMQdIKq9muOVyeFkpeMp5ekd+NqAE0Q2zU4jIyp+UU7UcfQtrX
         P66pKFS8+uHP1kPxj8Hv7AdGAkP3zDefXPj2seg1pEvZOw7ih2dRBYsWG44kdLB1fw8R
         4YyK+Z30POBi35nbmp2bIfQcFSFXHPeIbYOSixM0ZjEPM4uqf4G4TdgZuIRT6LFMDd3N
         qi4g==
X-Gm-Message-State: AOJu0Yx6dQYZoSVcM8DPpReLsG6uzd9fVC/Q/sbv7dwBmvlRfhiKIBHv
	J5Wy7/36VlFE/iWryRLFP0Vc8w==
X-Google-Smtp-Source: AGHT+IEVvRyUJg52CDeDxzeSVrEoaIAB8erBvTvpJvrK5cEpX80CfldRWY0InV6uQwuk+RBnoCyN1w==
X-Received: by 2002:a17:906:23f2:b0:9a9:ef41:e5c7 with SMTP id j18-20020a17090623f200b009a9ef41e5c7mr3348375ejg.8.1695243940906;
        Wed, 20 Sep 2023 14:05:40 -0700 (PDT)
Received: from cloudflare.com (79.184.124.164.ipv4.supernova.orange.pl. [79.184.124.164])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b009929ab17be0sm9875598ejb.162.2023.09.20.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 14:05:40 -0700 (PDT)
References: <20230920102055.42662-1-jakub@cloudflare.com>
 <1224b3f1-4b2a-3c49-5f29-cfce0652ba94@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Reject sk_msg egress redirects to
 non-TCP sockets
Date: Wed, 20 Sep 2023 22:59:58 +0200
In-reply-to: <1224b3f1-4b2a-3c49-5f29-cfce0652ba94@gmail.com>
Message-ID: <87wmwk7dy5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 11:19 AM -07, Kui-Feng Lee wrote:
> On 9/20/23 03:20, Jakub Sitnicki wrote:
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index cb11750b1df5..4292c2ed1828 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -668,6 +668,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>>   	sk = __sock_map_lookup_elem(map, key);
>>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>>   		return SK_DROP;
>> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>> +		return SK_DROP;
>>     	msg->flags = flags;
>>   	msg->sk_redir = sk;
>> @@ -1267,6 +1269,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>>   	sk = __sock_hash_lookup_elem(map, key);
>>   	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>>   		return SK_DROP;
>> +	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>> +		return SK_DROP;
>>     	msg->flags = flags;
>>   	msg->sk_redir = sk;
>
> Just be curious! Can it happen to other socket types?
> I mean to redirect a msg from a sk of any type to one of another type.

Today sk_msg redirects are implemented only for tcp4 and tcp6.

Here's a full matrix of what redirects are supported [1].

[1] https://gist.github.com/jsitnicki/578fdd614d181bed2b02922b17972b4e

