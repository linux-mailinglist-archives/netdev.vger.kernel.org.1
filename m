Return-Path: <netdev+bounces-35437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363E7A9840
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB51C2106C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EC18AE0;
	Thu, 21 Sep 2023 17:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1C182DC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:10:31 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D06EAD
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:10:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4051fea48a8so14109875e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695316201; x=1695921001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCpRQy5aFVcZAnovNBYBG32aGoqs2l5V062iaInDme4=;
        b=ZViFqG/exH7BFOu+Uy1bm9zfm70HFq4q5PdYjIdSBCNrK7xmD8fE/QMUUrQ07pGx0i
         w5dE2l2OszGq/TiJuoQB/8zKepRrBOzCcM3VrYQ/VYDQTLmn/Em9N0/znEC23gKzg/05
         fZ03wiodIvLwXhkOmhsv8gW3mIhFOVFV70wlqNBBx1X6iTOGkrMvkevYPJGBdkFbZZuU
         2P6yyZWpZi/z0EkGnUKkV3HErS4yXnAziHLYm3pyDAl6dZ4YCjNm/uU6iMEQO1501lgh
         lFhuDJxCnjpGg2/8IguRQ2GgTG5cUoBGUmZtNlstLXif0RsxrDFKkC5gw9piq2Nru0mN
         FV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316201; x=1695921001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCpRQy5aFVcZAnovNBYBG32aGoqs2l5V062iaInDme4=;
        b=nrWzIOFiEb2dbwQ6T+DTQnVr2/HeFDBnmvWi0uq4lI7VLeYdLSkOYD6VBjnOVMmNPP
         HkFHhuHVcf3kXCxulx6HcR0uo10sT5omCUwyGkSJWpDzNuHrmWXkEIUNwgmBeG1rd6sO
         5uA3JR9a9fjsT5vfH9KCFBDklAllle12y4MbnyUJMg1rxt9Y3aMlb5inSltxsvqK8MDI
         R1cHJpUI/EHKTrGedbZQcEZ7ZmWuHcXKNZRMaui3wnooCfsunGYN8UVAYKgLvWazXUyr
         dClGOwYaS6NNqWr9kOh90DV8mZ0tt+ux3G987ucvF1JI7F9DIpzpo1BYxE17/K+H3e0J
         oSYQ==
X-Gm-Message-State: AOJu0YxkL4XUbSkC05o+MNzpu9nkPe96v4/7E5SX4sE4W09Hg4dAyvuw
	kqSUIjYqYGj3y30uMnnGvvg5YgBT7cYLI9k5DjQ=
X-Google-Smtp-Source: AGHT+IEEGHtTkBEuwYW4pmvslrb0EckxI5A8QgaFbGs8wI47y6FHoHEO87io8T2rbmf1lRpQLmBnnw==
X-Received: by 2002:a5d:410a:0:b0:319:6d91:28bf with SMTP id l10-20020a5d410a000000b003196d9128bfmr5395098wrp.60.1695312081381;
        Thu, 21 Sep 2023 09:01:21 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z16-20020a056000111000b003176eab8868sm2105482wrw.82.2023.09.21.09.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:01:20 -0700 (PDT)
Message-ID: <65981909-e330-dc91-a977-032d427cdd6a@arista.com>
Date: Thu, 21 Sep 2023 17:01:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
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
References: <20230918190027.613430-1-dima@arista.com>
 <20230918190027.613430-7-dima@arista.com>
 <d0e332b4326eec032b77c7492f501f3c1fbe8242.camel@redhat.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <d0e332b4326eec032b77c7492f501f3c1fbe8242.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 12:20, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
>> @@ -615,19 +616,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>>   * (but it may well be that other scenarios fail similarly).
>>   */
>>  static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> -			      struct tcp_out_options *opts)
>> +			      struct tcp_out_options *opts,
>> +			      struct tcp_key *key)
>>  {
>>  	__be32 *ptr = (__be32 *)(th + 1);
>>  	u16 options = opts->options;	/* mungable copy */
>>  
>> -	if (unlikely(OPTION_MD5 & options)) {
>> +	if (tcp_key_is_md5(key)) {
>>  		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
>>  			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
>>  		/* overload cookie hash location */
>>  		opts->hash_location = (__u8 *)ptr;
>>  		ptr += 4;
>> -	}
>> +	} else if (tcp_key_is_ao(key)) {
>> +#ifdef CONFIG_TCP_AO
>>
>> +		struct tcp_ao_key *rnext_key;
>> +		struct tcp_ao_info *ao_info;
>> +		u8 maclen;
>>  
>> +		ao_info = rcu_dereference_check(tp->ao_info,
>> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
>> +		rnext_key = READ_ONCE(ao_info->rnext_key);
>> +		if (WARN_ON_ONCE(!rnext_key))
>> +			goto out_ao;
>> +		maclen = tcp_ao_maclen(key->ao_key);
> 
> It looks like only TCP_AO really accesses 'key', and TCP_AO can easily
> fetch it from ao_info. Can the AO key change in between
> tcp_get_current_key() and here?

Yes, you read it right: current_key can be changed at any moment, when
the peer asks to start a rotation (tcp_inbound_ao_hash() on RX does
that). So, here we have to provide the fetched key as ao_key->maclen
(the length of MAC, the authentication/hash may be different between
different keys).

> Otherwise I think it would be better omitting the 'key' argument here
> and use the 'options' flag to pick TCP_AO vs MD5.
> 
> And:
> 
> 	if (unlikely(OPTION_MD5 & options)) {
> 
> could possibly be moved under a CONFIG_MD5 compiler conditional.

Thanks,
          Dmitry


