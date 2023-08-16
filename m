Return-Path: <netdev+bounces-28033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E277E105
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E411C21005
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B710795;
	Wed, 16 Aug 2023 12:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1FFBFA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F2CC433C7;
	Wed, 16 Aug 2023 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692187401;
	bh=JZBhRJ852Cf42i6bqJCHNHsh4gGjICNxRBlUT5z4QLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzkgzl6TyVoaezGH66hU7AyLY9HsEZRhPd5MGlezFUNKjSvydx9mpc2l6CdglZ321
	 ZrBA5fHfWhPEiBbeSuwH1KOwgA9vhbRGS9Y8AfY2urZ97TKNSg1qU8gO1DZayte/MZ
	 vx5KTBw+btXwDTMPuHxR0Yn/fe2KZ6eBei6Bc1uzaoj0qVkQUokYoapTLwE+4e8+EH
	 J/jIEdmaAcsUizsMFEibRhCp6AzsKBIxgo0+oe2sJRna0nVMFxBM2TEwa1PnQXbC0v
	 B/EcjrUztd0SoH9ytHzBcWSeIpa41xE8HCK8z6CL9icAMhbNhEEO6ekY0jXrUMpBQ5
	 tWohHYfYinbyA==
Date: Wed, 16 Aug 2023 14:03:15 +0200
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v10 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Message-ID: <ZNy7A17n3BrMuh1b@vergenet.net>
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-10-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815191455.1872316-10-dima@arista.com>

On Tue, Aug 15, 2023 at 08:14:38PM +0100, Dmitry Safonov wrote:

...

> @@ -1183,6 +1216,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
>  			READ_ONCE(sk->sk_priority),
>  			READ_ONCE(tcp_rsk(req)->txhash));
> +			NULL, NULL, 0, 0);

Hi Dmitry,

This seems to add a syntax error.

...

