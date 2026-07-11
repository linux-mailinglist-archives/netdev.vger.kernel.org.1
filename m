Return-Path: <netdev+bounces-306895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZKKDaCCUmoPQgMAu9opvQ
	(envelope-from <netdev+bounces-306895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 19:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC2742690
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 19:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QP+7VmGK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306895-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306895-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F4E301A91F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D972F0C48;
	Sat, 11 Jul 2026 17:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E771EEE6;
	Sat, 11 Jul 2026 17:51:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783792284; cv=none; b=oFeZ3AlYOn3hIrVlYoDRcvYH3VNzsshv0e+g7smzruESNV3ASz4HcvhhZPcu4mL0gL7gIu+cQKTig8nhU2Iuuclca6WE0t7kNtVOlc/TokGU4RfexqxK5XmYs3m3eu5ESEMDXqVUqim/1/fvNOk2Qf3mOFMmc90CCGdNPiiL36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783792284; c=relaxed/simple;
	bh=zaKpWoHaCf4pF+Yu0sfRk8Zn8BkHZ8NLoQ4atNFHbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWLy6mkAlLE9mrCgwifK3cschL3lNnUoRN9w3tpirh2tA6CYYxYH1nxhzgcR/3OivK0lInISjsxW3+qUcDm/c85KVajxEfaimE0z+nYoZM7hL8e0dyPapFzd9cc777R+jv1LdKaQzBnO5C+t7pRVOzp2a+ORkZsgVnmonWA39C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP+7VmGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6C9921F000E9;
	Sat, 11 Jul 2026 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783792283;
	bh=XQRZEWXvNsb0JpMQf3ZcxvFfvyQw4c/6LvW/dLlfKXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QP+7VmGKLbE6e8x7/DQrajjLKlSe0ODihAjNcqiqJxL0ho7cnuejEePIamw99n1u0
	 cJqF3OgXJStAckZT1MqNmmNeGrZ4EMzB/PEYifUIxRKq35UMZ9XBKdBRdHuAYAkV4D
	 wtGy4cFwMaWxvQKeyf/9zdxApetZ9D6rDXLkg64IlGeJsSBC73yPeu46TQVyqf5PNY
	 MUG8rgZobjATkhpahlJF4745ZOOClva5awtFLJU+bClczl5D7VCqpmoV5OLgDcKqlQ
	 sL/t9RWNkI7z6gEkieR/qWkqa1GFuK349eqTGr7AwGkLHH11W2SO4kxCOCS+u0ejNO
	 vJy7IlIDu2m2w==
Date: Sat, 11 Jul 2026 20:51:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
	keyrings@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v2 12/16] keys: Add refcounting to user-defined key
 type payload
Message-ID: <alKCl7ZxPIeTyHHD@kernel.org>
References: <20260710192220.1922433-1-dhowells@redhat.com>
 <20260710192220.1922433-13-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710192220.1922433-13-dhowells@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-306895-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56BC2742690

On Fri, Jul 10, 2026 at 08:22:14PM +0100, David Howells wrote:
> Add refcounting to user-defined key type payload so that a kernel service
> wanting to use such a key can hold onto the payload without the RCU read
> lock held in order that it can do an allocation without having to be
> concerned with the key getting updated.
> 
> This is the first part of the fix for the AF_RXRPC challenge response
> generation code.
> 
> Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")

I get the relaxing part when it comes to RCU read lock but why does it
carry fixes tag? The commit message does not do a great job on
explaining this part.

> Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: keyrings@vger.kernel.org
> cc: stable@kernel.org
> ---
>  include/keys/user-type.h     |  2 ++
>  net/dns_resolver/dns_key.c   |  1 +
>  security/keys/user_defined.c | 23 ++++++++++++++++-------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index 386c31432789..7002a993a472 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -26,6 +26,7 @@
>   */
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
> +	refcount_t	ref;
>  	unsigned short	datalen;	/* length of this data */
>  	char		data[] __aligned(__alignof__(u64)); /* actual data */
>  };
> @@ -37,6 +38,7 @@ struct key_preparsed_payload;
>  
>  extern int user_preparse(struct key_preparsed_payload *prep);
>  extern void user_free_preparse(struct key_preparsed_payload *prep);
> +void put_user_key_payload(struct user_key_payload *payload);
>  extern int user_update(struct key *key, struct key_preparsed_payload *prep);
>  extern void user_revoke(struct key *key);
>  extern void user_destroy(struct key *key);
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index c3c8c3240ef9..aa3c058f4095 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -208,6 +208,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  		kleave(" = -ENOMEM");
>  		return -ENOMEM;
>  	}
> +	refcount_set(&upayload->ref, 1);
>  
>  	upayload->datalen = result_len;
>  	memcpy(upayload->data, data, result_len);
> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> index 6f88b507f927..90c1bd5d7dfe 100644
> --- a/security/keys/user_defined.c
> +++ b/security/keys/user_defined.c
> @@ -67,6 +67,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>  	upayload = kmalloc_flex(*upayload, data, datalen);
>  	if (!upayload)
>  		return -ENOMEM;
> +	refcount_set(&upayload->ref, 1);
>  
>  	/* attach the data */
>  	prep->quotalen = datalen;
> @@ -88,12 +89,22 @@ EXPORT_SYMBOL_GPL(user_free_preparse);
>  
>  static void user_free_payload_rcu(struct rcu_head *head)
>  {
> -	struct user_key_payload *payload;
> +	struct user_key_payload *payload =
> +		container_of(head, struct user_key_payload, rcu);
>  
> -	payload = container_of(head, struct user_key_payload, rcu);
>  	kfree_sensitive(payload);
>  }
>  
> +/*
> + * Free a user defined key payload.
> + */
> +void put_user_key_payload(struct user_key_payload *payload)
> +{
> +	if (payload && refcount_dec_and_test(&payload->ref))
> +		call_rcu(&payload->rcu, user_free_payload_rcu);
> +}
> +EXPORT_SYMBOL_GPL(put_user_key_payload);
> +
>  /*
>   * update a user defined key
>   * - the key's semaphore is write-locked
> @@ -115,8 +126,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
>  	rcu_assign_keypointer(key, prep->payload.data[0]);
>  	prep->payload.data[0] = NULL;
>  
> -	if (zap)
> -		call_rcu(&zap->rcu, user_free_payload_rcu);
> +	put_user_key_payload(zap);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(user_update);
> @@ -134,7 +144,7 @@ void user_revoke(struct key *key)
>  
>  	if (upayload) {
>  		rcu_assign_keypointer(key, NULL);
> -		call_rcu(&upayload->rcu, user_free_payload_rcu);
> +		put_user_key_payload(upayload);
>  	}
>  }
>  
> @@ -147,9 +157,8 @@ void user_destroy(struct key *key)
>  {
>  	struct user_key_payload *upayload = key->payload.data[0];
>  
> -	kfree_sensitive(upayload);
> +	put_user_key_payload(upayload);
>  }
> -
>  EXPORT_SYMBOL_GPL(user_destroy);
>  
>  /*
> 

BR, Jarkko

