Return-Path: <netdev+bounces-35482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC97A9AB2
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617AC1C211C7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0418C17;
	Thu, 21 Sep 2023 17:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396081803C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18848D227
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695318192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMhh8PRmEtAlmjPWgFR3PPxAtVWm2OxIboSGWoi2aEc=;
	b=NWCKOiF6pzauLeMv6NEAika+2/vajGtjFMb2qMxjuerB/ujhqeXVEJDagZ4twJ/GgFcO/y
	Qqbu9/8q5E1t+1fAQOG2IXhAK6nmjoWlPw3ucN0/UNu2lmIEhwK6fO4PgWpa2tSLwSB+je
	TRrI96u9lpYpWO9V8kE4dz2CxitmO1c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-viQLLLmBN8WAvWPMoPMeGg-1; Thu, 21 Sep 2023 07:20:39 -0400
X-MC-Unique: viQLLLmBN8WAvWPMoPMeGg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso16220666b.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 04:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695295238; x=1695900038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMhh8PRmEtAlmjPWgFR3PPxAtVWm2OxIboSGWoi2aEc=;
        b=a8Txe6Uc8ZEONDwZiWb/ZaXuhHrGwqdDtg18HGxgZHxAiKaKoYHnziI16JtiS7I0Vl
         i55GNZkIAyD2narIGd6RlB3kmcpxuVs81cmElqzopS/uRBOlP79d94p2dR8bSe0aTw9t
         pMCYfhFw+VAg3xdvWqb+gLFN+nCqJmrOqh2uzsRDg+0Qd4tEZkgx5GKCB0Q0H36L3KFU
         BzRCSP9DAolnOG9AAAld7TKLw8IfY2pTJQVNzIcgnq39siDBUWdBPt/IQ77aXvb4gMds
         Zet4oqxg0gTOrmeBBweomliBtBfHUtqYeoCy2NPf1vRbfMTSR4Rjf/rAzBvQxVH10wne
         aFog==
X-Gm-Message-State: AOJu0YwbUMZOY15iP7gvLM+L6up0rV+BCZ1XnhAzEWmQKLvvu/mWJz0x
	U9vYkCL/vLllnnWaKtdlaMQdp6ghudo8nW2GP/Gs88UZW0GkKSwc5LUNC2qLNimBRqHlKMRlUuq
	zh3FqO3da49Ktm3iP
X-Received: by 2002:a17:906:10d6:b0:9a6:5453:2013 with SMTP id v22-20020a17090610d600b009a654532013mr4683156ejv.3.1695295237878;
        Thu, 21 Sep 2023 04:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlTK3itNOtV3q4iREAV8lTBnwdyDQC39pWvcFE3kr7prpeJPxBjScVsaifEKl/zr9F6VwQsQ==
X-Received: by 2002:a17:906:10d6:b0:9a6:5453:2013 with SMTP id v22-20020a17090610d600b009a654532013mr4683138ejv.3.1695295237529;
        Thu, 21 Sep 2023 04:20:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906558900b009ad854daea6sm877778ejp.132.2023.09.21.04.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 04:20:36 -0700 (PDT)
Message-ID: <d0e332b4326eec032b77c7492f501f3c1fbe8242.camel@redhat.com>
Subject: Re: [PATCH v12 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
From: Paolo Abeni <pabeni@redhat.com>
To: Dmitry Safonov <dima@arista.com>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ard
 Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>, Dan
 Carpenter <error27@gmail.com>,  David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy
 <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Francesco Ruggeri
 <fruggeri05@gmail.com>,  "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, Leonard
 Crestez <cdleonard@gmail.com>, "Nassiri, Mohammad" <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman
 <simon.horman@corigine.com>, "Tetreault, Francois" <ftetreau@ciena.com>,
 netdev@vger.kernel.org
Date: Thu, 21 Sep 2023 13:20:34 +0200
In-Reply-To: <20230918190027.613430-7-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
	 <20230918190027.613430-7-dima@arista.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
> @@ -615,19 +616,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk=
, struct sk_buff *skb,
>   * (but it may well be that other scenarios fail similarly).
>   */
>  static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> -			      struct tcp_out_options *opts)
> +			      struct tcp_out_options *opts,
> +			      struct tcp_key *key)
>  {
>  	__be32 *ptr =3D (__be32 *)(th + 1);
>  	u16 options =3D opts->options;	/* mungable copy */
> =20
> -	if (unlikely(OPTION_MD5 & options)) {
> +	if (tcp_key_is_md5(key)) {
>  		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
>  			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
>  		/* overload cookie hash location */
>  		opts->hash_location =3D (__u8 *)ptr;
>  		ptr +=3D 4;
> -	}
> +	} else if (tcp_key_is_ao(key)) {
> +#ifdef CONFIG_TCP_AO
>
> +		struct tcp_ao_key *rnext_key;
> +		struct tcp_ao_info *ao_info;
> +		u8 maclen;
> =20
> +		ao_info =3D rcu_dereference_check(tp->ao_info,
> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
> +		rnext_key =3D READ_ONCE(ao_info->rnext_key);
> +		if (WARN_ON_ONCE(!rnext_key))
> +			goto out_ao;
> +		maclen =3D tcp_ao_maclen(key->ao_key);

It looks like only TCP_AO really accesses 'key', and TCP_AO can easily
fetch it from ao_info.=C2=A0Can the AO key change in between
tcp_get_current_key() and here?

Otherwise I think it would be better omitting the 'key' argument here
and use the 'options' flag to pick TCP_AO vs MD5.

And:

	if (unlikely(OPTION_MD5 & options)) {

could possibly be moved under a CONFIG_MD5 compiler conditional.

Cheers,

Paolo


