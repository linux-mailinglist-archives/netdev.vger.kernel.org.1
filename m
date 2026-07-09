Return-Path: <netdev+bounces-306176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCvIHT2AT2omiQIAu9opvQ
	(envelope-from <netdev+bounces-306176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5AC730070
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BnCOQY7x;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306176-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306176-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B171B302C5E3
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321333FADE8;
	Thu,  9 Jul 2026 10:38:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F543ED101;
	Thu,  9 Jul 2026 10:38:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593492; cv=none; b=q8P22JWcKhJ9uVTOpHgph0k7IAYp5185N3Nmdyw4jSWNwdgPQx8NLnya5d9Rc91WijuIZtecb8gHdMRvNl/dGWPBjDrKvY9diBmN7zM4sYUoTC378R0GzYvahqVI80o3EnZ9tI8jlPyOhPS5WCVRvl74fvpSUVIxjKPPUvFrnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593492; c=relaxed/simple;
	bh=uN27BS4ewStwCklQr2DuM5gP4rGJ1wPSO/4y1Hf/bo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqG23F2NPRWkodzOybf5cp1qwPjyFw9IkPt4FhvkZDMJzpE65aJiKpE0NXm+xjyzjU56j6PC61vASjiV2lu6Ja0E7Hfv97THu1xt6qNX4AmPypMJuaUNAzp9bJ4wIggm8JNtCOPn6q9/FUdIJfkT7IEB25/0lE1TN9zp3WXvZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnCOQY7x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9CD1F000E9;
	Thu,  9 Jul 2026 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593491;
	bh=Y6VGOlkpgo4arCW+nyarOcCI4IwHdmRhLsRejOptB8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnCOQY7xP6QHREHgMjc6e7PDRpKXWvc2mHPQ5W1aMPsERACfOO5K6l32UUrp0e2K/
	 r34STa9E8zqjpZjU1xYa7Dr0Uu/wa3HiWVfq/pTUWrk81hSMW4+gkSLmV0AlEFKy0b
	 bJ+TJ0qX1EbVkvCOFYhP1l+9RHBH3yr7MJhQEtr4YrapD0LpAnMrlnx6Ae/gDm3WYI
	 W1vIRRoE2JRxeepbcUE1pr7jFfVoanpUKBOMOF4oYRd3DkCCvBlc9Rywa2fkrOhnj4
	 6sAa4Jb7ZpFmOBIZSdHshNzt4WlkB+F6LEChx61GNDnIiUAhPStCUbIIqKMYLsuUs3
	 WnuMwHhSm50TQ==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jaltman@auristor.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net 4/4] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Date: Thu,  9 Jul 2026 11:37:53 +0100
Message-ID: <20260709103753.1543915-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702144919.172295-5-dhowells@redhat.com>
References: <20260702144919.172295-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306176-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:jarkko@kernel.org,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C5AC730070

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation

This commit removes the out-of-band queueing mechanism for CHALLENGE
packets. It transitions the connection event processor to handle
CHALLENGE parsing and RESPONSE generation directly, while allowing
application data to be passed via a user-type key.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index 103168c70dd4d..db2a3b30f0209 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c
> @@ -295,13 +295,22 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
>  	if (ret < 0)
>  		goto out_aead;
>  
> -	server->cm_rxgk_appdata.len  = adatasize;
> -	server->cm_rxgk_appdata.data = appdata;
> -	appdata = NULL;
> +	appdata_key = key_alloc(&key_type_user, "rxrpc: afs rxgk appdata",
> +				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
> +				KEY_POS_VIEW | KEY_POS_SEARCH | KEY_USR_VIEW,
> +				KEY_ALLOC_NOT_IN_QUOTA, NULL);
> +	if (IS_ERR(appdata_key)) {
> +		ret = PTR_ERR(appdata_key);
> +		goto out_aead;
> +	}
> +
> +	ret = key_instantiate_and_link(appdata_key, appdata, adatasize, NULL, NULL);
> +	if (ret < 0) {
> +		key_put(appdata_key);
> +		goto out_aead;
> +	}
> +
> +	server->cm_rxgk_appdata = appdata_key;

[Severity: Medium]
Does this plain store require memory barriers? afs_make_call() appears to
read call->server->cm_rxgk_appdata concurrently without holding the
cm_token_lock. Without smp_store_release() here and a corresponding
smp_load_acquire() or READ_ONCE() on the read side, could the reader
observe the pointer before the key object's initialization is completely
visible to other CPUs?

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index 05fcb9b6adde7..ae48c15b3db94 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -373,8 +373,25 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  		call->drop_ref = true;
>  	}
>  
> +	if (call->key && call->server) {
> +		u32 krb5_enctype = 0;
> +		u8 security_index = 0;
> +
> +		rxrpc_kernel_query_key(call->key, &security_index, &krb5_enctype);
> +		switch (security_index) {
> +#ifdef CONFIG_RXGK
> +		case RXRPC_SECURITY_YFS_RXGK:
> +			app_data = call->server->cm_rxgk_appdata;
> +			break;

[Severity: Medium]
Following up on the previous observation, is it safe to perform a plain
read of the cm_rxgk_appdata pointer here in afs_make_call() without
READ_ONCE() or a lock?

> diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
> index 77a67ace1d248..9ab766d5f0b6c 100644
> --- a/net/rxrpc/rxgk.c
> +++ b/net/rxrpc/rxgk.c
> @@ -981,36 +981,36 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
> [ ... ]
> +	if (conn->bundle->app_data) {
> +		rcu_read_lock();
> +		appdata = (struct user_key_payload *)
> +			user_key_payload_rcu(conn->bundle->app_data);

[Severity: High]
If an attacker passes the ID of a non-user key (like an asymmetric key
or keyring) during sendmsg(), could casting that key's payload to struct
user_key_payload and modifying its refcount cause memory corruption?

> +		if (!refcount_inc_not_zero(&appdata->ref))

[Severity: High]
Can user_key_payload_rcu() return NULL here if the user key has been
revoked by userspace via keyctl(KEYCTL_REVOKE)? If appdata evaluates to
NULL, would calling refcount_inc_not_zero(&appdata->ref) attempt to
dereference a low offset address and trigger a kernel panic?

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 4c754f78ece9a..225eec410bedc 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -590,6 +592,18 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
> [ ... ]
> +		case RXRPC_RESPONSE_APPDATA:
> +			if (len != sizeof(key_serial_t))
> +				return -EINVAL;
> +			if (p->call.app_data)
> +				return -EINVAL;
> +			key_id = *(key_serial_t *)CMSG_DATA(cmsg);
> +			key = lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
> +			if (IS_ERR(key))
> +				return PTR_ERR(key);
> +			p->call.app_data = key_ref_to_ptr(key);
> +			break;

[Severity: High]
Should there be a check here in rxrpc_sendmsg_cmsg() to verify that the
fetched key is actually a user-type key (e.g., key->type == &key_type_user)?
Without validation, any key type could be assigned to p->call.app_data,
leading to the invalid cast mentioned previously in
rxgk_respond_to_challenge().

> @@ -677 +716 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
> [ ... ]
>  	call = rxrpc_find_call_by_user_ID(rx, p.call.user_call_ID);
>  	if (!call) {
> [ ... ]
> +		call = rxrpc_new_client_call_for_sendmsg(rx, msg, &p);
> +		/* The socket is now unlocked... */
> +		if (IS_ERR(call))
> +			return PTR_ERR(call);

[Severity: High]
Does this direct return leak the key reference acquired by lookup_user_key()
and stored in p.call.app_data when rxrpc_new_client_call_for_sendmsg()
fails?

> @@ -803,6 +803,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
>  out_put_unlock:
>  	if (!dropped_lock)
>  		mutex_unlock(&call->user_mutex);
>  error_put:
>  	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
>  	_leave(" = %d", ret);
>  	return ret;
>  
>  error_release_sock:
>  	release_sock(&rx->sk);
> +	key_put(p.call.app_data);
>  	return ret;
>  }

[Severity: High]
Do the out_put_unlock and error_put paths in rxrpc_do_sendmsg() also need
to call key_put(p.call.app_data)? It appears rxrpc_alloc_client_call()
takes its own reference on the key via key_get(), which means the original
reference acquired during rxrpc_sendmsg_cmsg() will be leaked on successful
operations or when failing after the socket lock is released.

