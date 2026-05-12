Return-Path: <netdev+bounces-287269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPK9EYF6A2oR6QEAu9opvQ
	(envelope-from <netdev+bounces-287269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:07:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AFB5286BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECDA3007341
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BD3655FF;
	Tue, 12 May 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHex4lU5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C32E0901
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612646; cv=none; b=eyIjFUJQC7DRVt/NV249CgsLx4YjdmO5Kk359np/JS3RKg6lS4ZNiKccLxutG1QnyliQ2VvKG3ynaeijeYvMbS33AOB2CTlmFX8KVmihZo6mZxgTJ3exRvpFkhXSlUfdXNZXV6YmUpz86W0lXffa9pEy60DjILi+lCnORBZRENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612646; c=relaxed/simple;
	bh=mTY+R3VxQExeKt46CYiR65Ep6AB1M3Cgr5Vft7aQvRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwKJxDQFwrbb6yqdQ9qAfWZmu4ha8n9gDnvto/UqdrLnHdVZttpZljiY17lH0s37pHZWiC8ukNiK2GtLiyKDIsJZviZlOHAt0JaV1idMZrDlUp6sAmqKcCbErvNJZLgTeL98IQAqykCP5VURml0LKJ9mAs9TFM7ak2okDAogvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHex4lU5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367dd53815fso2127071a91.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778612644; x=1779217444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLrOPfSWJbKfvY5t7b50lNIFV8G5y1Vr3EZ68WeaQHU=;
        b=SHex4lU5H4sS7VZUOkKVOT2/Lzjd/PhaUJ/Ka7dZBiwHWaycGKRiVijvWaePb4XKov
         Q5rwG/LOdBMU23YQj2hGatl/sRBpC2UaYzKK6FM3k02sJZGJdlDQUSmAFoNMLiUxXk1L
         RO+27Ne1LKJGlM20u2xIeUE+0NVHPImH1JCDYrr96TX9h3xaBc1UVMVsXyiiYnDCps90
         BLfsBBNcQRb7ZKQIENPtYmKzO45n54pA/saC90KQjdb+wTXu+zQmZEz/Ohj0pIDFSfjt
         vKT+GkCQ8ei+nL2pbMKFPrnGa4de1+nMK0ERKn1PnJWa4Yn7z58QnJcqW3xdv3zGvJjC
         hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778612644; x=1779217444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLrOPfSWJbKfvY5t7b50lNIFV8G5y1Vr3EZ68WeaQHU=;
        b=mdYWJ4BnvjrxUm4MzPyZZIUrbCL/ZxRfpu2/Q6JEhwHMv/9gtodlsWs6j44aoSX3m9
         urxDYlo1WPqJhIRUzf92HAkjp4nME5agPFG8lO6tGbj8HpOaQ1vZP1NJCPvfnYiPBnt5
         7GpgdH3ZGDRtc9/rJDdwVFyluksmcnUDSDQZkIhdjIxqvstLlvkPeiIlZmDWhGTWrfPf
         r4wU4DpREe5udrJxbrr7tiM20U4n0mZBCIkH3WTe4uRfem7wUb1fx7mgqQr1CAJwA6HR
         X+PpmJ69Bda2C+WKVCyyyXpVyFqwg4mkKaTn6urBbhDDX3IHVLTmXQ/EQPSNfgMWH8RR
         R+/w==
X-Gm-Message-State: AOJu0YxUDRqNNArrvBjQpm0VeNWK3uSdguooLXXbPpA19FAtldQ4ltzl
	llqE4zKyJ1N9wbeGVQ2kps4kYnmK5Z3qYj/Ssdj6h7GMJKmY2DokScyaJZhDK2ze
X-Gm-Gg: Acq92OEWrQ82QISP05hZTdIfT2hDgU3XC3M7E5Zivm5PvfBGqyKpyNQtL2hSORf9mMG
	m9tfrQHi/tpNs1t940tSu0JQHuA34S++I5HQB7o350YDi+eN874eFbD2o0PUeXMPOh6vorcsR52
	W8RATnQwS1/YqF9U39GTiMhhGLwZI7zedfvTD0xyFxPYXhjVgwV7HhGtbLkvWKK3QplasjfwCHd
	K9hFX/CZdAtJdOf4eAJ/CuNmb3Z0/deiC6AxEy/WP4tJXv5N1MALpzv7d5T6Lf5Xe6wQ7I6mYbr
	7qd0a7IsyVNNafklW93pAIsXO86t1ftNqJNLd86AnSdN3vOD0YWqWNgGe2ClmEmaFNZ2rIx1TqU
	hEROHNvei4Q6lTVTTLCIvKVkr69UPDhQeGbwk1PRcLOZ/Vzj6Vw6DbO5/Qjd3sWxPtiaxiP8Vsr
	M/VAb9pE/BMZML4d9qXmLLih38h/DxRW0iS3OrWkwkwk053XfohAYF
X-Received: by 2002:a17:90b:5625:b0:368:4a6f:28f8 with SMTP id 98e67ed59e1d1-368f3a97ce1mr223838a91.1.1778612644560;
        Tue, 12 May 2026 12:04:04 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ed962120sm601698a91.0.2026.05.12.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:04:04 -0700 (PDT)
Message-ID: <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Tue, 12 May 2026 12:03:29 -0700
In-Reply-To: <20260506142709.2298255-8-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A9AFB5286BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-287269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:

LGTM, a nit below.

[...]

> @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  	}
> =20
>  	if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DEST) {
> -		if (meta->ref_obj_id) {
> -			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
> -				regno, reg->ref_obj_id,
> -				meta->ref_obj_id);
> +		if (meta->release_regno && meta->ref_obj.cnt) {
> +			verbose(env, "more than one arg with ref_obj_id %s %u %u",
> +				reg_arg_name(env, argno), reg->ref_obj_id,
> +				meta->ref_obj.ref_obj_id);

I think this should be reported from update_ref_obj() itself,
it is more consistent logically and also avoids reporting code
duplication in check_kfunc_args() and check_kfunc_call().
Also, technically the reg_arg_name() is an independent fix.

> Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: Neg=
ative
> test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> complains about ambiguous ref_obj if it is not used.

On the other hand, if you think that this property is worth having,
then maybe wrap the check with in some utility function?

>  			return -EACCES;
>  		}
> -		meta->ref_obj_id =3D reg->ref_obj_id;
> -		meta->id =3D reg->id;
> +		update_ref_obj(&meta->ref_obj, reg);
>  	}
> =20
>  	switch (base_type(arg_type)) {

[...]

