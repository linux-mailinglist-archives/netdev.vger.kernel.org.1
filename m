Return-Path: <netdev+bounces-32137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983D792FEA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FBA1C20996
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DDDF5A;
	Tue,  5 Sep 2023 20:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C3DF57
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:24:42 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977A137
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:24:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so29559755e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1693945479; x=1694550279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgbF9uOxTZjSH/uNRsPozuzPS7Kjt3TnMWh+9q/pH2w=;
        b=X519hhwlLKj7fJEZvhwaIDgcSxcBE87XglBs+/xfqimOPY2N+HdoDFQjCsUDoBKk6R
         JmD/8zGmlqVplDdPFILYkivf9EGoovrHQI4aGszngNbcJkgVOhc6gUsVhWcUYCMJAiU2
         OaKb5cGSm3ufAbUANXcp6q7fiLOyKjU8OujOu/U3U/JLL1+7kRbZ3S/LmSaR48iROt5U
         hviOtvFyzV1HAKRvCZbdAwSMMCxeYEKUexMHy/iO5zeAGhK3NdrvTALNqA5XdOtVCaXM
         cYWB5YVUGffg5w1axdbpk7SNVYPlC1BumqxZaZRam7LgOcWiO51Y/649euZelgGfePoK
         AcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945479; x=1694550279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgbF9uOxTZjSH/uNRsPozuzPS7Kjt3TnMWh+9q/pH2w=;
        b=HnGkMbkmaSU0T8+lI5dEtFJXvi45/g4Sp1+Wzr/YWWG7m0igjekb3UZH2qlAqmuAay
         6Io2FvRCxN2asul3sPU8GzPs7+xOn2/jMzLcYR1Gkq4QKA/3vlIj3Qxn5Sh6roe3qFK7
         f7re5Aas0cw7W3jEZudi1KSOBeVfIgRkDx2Q8NPc2TpaIzypzquQUUlBh1ly91tSUixH
         3GQu0bpAAt03M9En7rq6lCgTs6BdjrDFBZP10n0sH9KyHtdFkYoZs7+7NfWG38i4MNow
         UTWWYl8tmuFLJ1Sp0a1qvK3s9gRTMiHPCfiXEF/I5c6r+cCaKtCgSyaD8+GcfRVls1Rc
         4WTQ==
X-Gm-Message-State: AOJu0Yw6cOzmG5d7CI3Aem5a9whYOVkpgGT9dxNxmpTbenf9ZmwZwsyX
	LlxA88ckhfm7F2fFchc20s2Idg==
X-Google-Smtp-Source: AGHT+IH53IUU3JFOTw9CAL5+eP3zFCWyMGbbYGxItDGp2qv+H6hwIqnHfRh4YPGocX979pKSeTexfA==
X-Received: by 2002:adf:e648:0:b0:317:50b7:2ce3 with SMTP id b8-20020adfe648000000b0031750b72ce3mr680842wrn.51.1693945479151;
        Tue, 05 Sep 2023 13:24:39 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm18121138wro.43.2023.09.05.13.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:24:38 -0700 (PDT)
Message-ID: <ed11d178-0762-4f87-804d-034b9715727c@arista.com>
Date: Tue, 5 Sep 2023 21:24:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 net-next 10/23] net/tcp: Wire TCP-AO to request
 sockets
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
 <20230815191455.1872316-11-dima@arista.com> <ZN0nQqIwXp5cQJTR@vergenet.net>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZN0nQqIwXp5cQJTR@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 20:45, Simon Horman wrote:
> On Tue, Aug 15, 2023 at 08:14:39PM +0100, Dmitry Safonov wrote:
[..]
>> @@ -1194,9 +1198,51 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
>>  static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>>  				  struct request_sock *req)
>>  {
>> +	struct tcp_md5sig_key *md5_key = NULL;
>> +	const struct in6_addr *addr;
>> +	u8 *traffic_key = NULL;
>>  	int l3index;
>>  
>>  	l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
>> +	addr = &ipv6_hdr(skb)->saddr;
>> +
>> +	if (tcp_rsk_used_ao(req)) {
>> +#ifdef CONFIG_TCP_AO
>> +		struct tcp_ao_key *ao_key = NULL;
>> +		const struct tcp_ao_hdr *aoh;
>> +		u8 keyid = 0;
> 
> Hi Dmitry,
> 
> keyid is declared and initialised here.
> 
>> +
>> +		/* Invalid TCP option size or twice included auth */
>> +		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
>> +			return;
>> +		if (!aoh)
>> +			return;
>> +		ao_key = tcp_v6_ao_do_lookup(sk, addr, aoh->rnext_keyid, -1);
>> +		if (unlikely(!ao_key)) {
>> +			/* Send ACK with any matching MKT for the peer */
>> +			ao_key = tcp_v6_ao_do_lookup(sk, addr, -1, -1);
>> +			/* Matching key disappeared (user removed the key?)
>> +			 * let the handshake timeout.
>> +			 */
>> +			if (!ao_key) {
>> +				net_info_ratelimited("TCP-AO key for (%pI6, %d)->(%pI6, %d) suddenly disappeared, won't ACK new connection\n",
>> +						     addr,
>> +						     ntohs(tcp_hdr(skb)->source),
>> +						     &ipv6_hdr(skb)->daddr,
>> +						     ntohs(tcp_hdr(skb)->dest));
>> +				return;
>> +			}
>> +		}
>> +		traffic_key = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
>> +		if (!traffic_key)
>> +			return;
>> +
>> +		keyid = aoh->keyid;
> 
> And reinitialised here.
> But is otherwise unused.
> 
> Flagged in a W=1 build with both clang-16 and gcc-13.

Thanks, will be fixed in v11.

Seems to be another rebase-artifact.
I'll also take a look how didn't I notice this on tests, they probably
need a new selftest for this.

-- 
          Dmitry


