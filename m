Return-Path: <netdev+bounces-295955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H+VcBqAjI2pVjQEAu9opvQ
	(envelope-from <netdev+bounces-295955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:29:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F264AF22
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IF7MZXHx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295955-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A56E530494C5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41229AB05;
	Fri,  5 Jun 2026 19:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF94071E9;
	Fri,  5 Jun 2026 19:27:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687648; cv=none; b=C5J2y9Eotyh1E2EHM5KliJNA1aAeSxqWhtGOxGzef/grnC2I4MLMb7qxuUlXDeC5XbD0cVgKH+2alYM6SPtCGDjT/kCeY7mP8ozYuhhFlYKnO6NPD4HTU6sqh8byAA7V3LXhUC/pIHOyMf+EXOy8whdXwXHVbCl+zjJ94K3Ywpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687648; c=relaxed/simple;
	bh=IvGenw8+9tG2pXs8Y8fp5jM2NxBvxtNoxk43ouUV/eE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dphHDd48hxiWspPHNddZTH3JLQppIPwfQDHmlVGmt+JuAoQbQMocprhWpmPwsQm0zlRvjRKDzCZncSNr7kTcPy8jCzofUSa78FKFk+f2VFfNZ8jxUBDT7gK2TWrpHaEBqBCeYHl3eA6KUyw/WImVdQghzR1a3JpNIWsgX4A9IRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF7MZXHx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E734B1F00893;
	Fri,  5 Jun 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687647;
	bh=YVxfaQUo2ZxvCw1xps5ZaGM1JvLua8ipsEdyVpCGSaU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IF7MZXHxOQ090WCaWK3Wq8lP/sQiVJSfcuo7qTYXUKIfSY9rdXf7vN2Wrb7yy++Q0
	 /ewMYv+fW/Uj6KR7n6gFv11kuNqp4uIbE5rGcv1UhgRfWDPnMF1pi2Q/UjV+a4H+yI
	 xRE6VT2WrVqSZCUTxUgLY2LZUtQi105Y5iFDjtXs+nkURp1lVGeoqmCpic3G85QdTu
	 ocKRugtovOskPKMXu5LZwHMOcMMUNQlN8BoSdWxhk/P8NdjkC5eZpfuhZBWN8J7Q0h
	 Ov6gBGG6fjuUeCXFip359eHs0h/MP6OiejwV2aBEIXX4lzuZ6v1HCQCFXScld31GoY
	 2ltK0ZR7aqgbA==
Content-Type: multipart/mixed; boundary="===============5467158372919134965=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e267e030d9e626dd07af109d4bb866bcd31e034c2041fcf324033591b582bb81@mail.kernel.org>
In-Reply-To: <20260605183551.969144-3-ameryhung@gmail.com>
References: <20260605183551.969144-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 19:27:26 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295955-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB4F264AF22

--===============5467158372919134965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a741bf447931..5a69af569089 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18363,9 +18363,15 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>
>  	/* Acquire references for struct_ops program arguments tagged with "__ref" */
>  	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> -		for (i = 0; i < aux->ctx_arg_info_size; i++)
> -			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
> -						      acquire_reference(env, 0, 0) : 0;
> +		for (i = 0; i < aux->ctx_arg_info_size; i++) {
> +			int id;
> +
> +			id = aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0) : 0;
> +			if (id < 0)
> +				return id;

Does this direct return bypass the cleanup path and leak env->cur_state?

Earlier in do_check_common(), env->cur_state is allocated via kzalloc_obj().
Other error paths in this function set the return variable and jump to the
out label to call free_states(env) for proper cleanup.

Should this be updated to set ret = id and goto out instead of returning
directly?

> +
> +			aux->ctx_arg_info[i].ref_id = id;
> +		}
>  	}
>
>  	ret = do_check(env);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27034008594
--===============5467158372919134965==--

