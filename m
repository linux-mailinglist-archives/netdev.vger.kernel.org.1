Return-Path: <netdev+bounces-290088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM2dMPASDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:00:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB859902F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72C5530F8791
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683573624BC;
	Wed, 20 May 2026 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWJX3o4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3335F61F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307173; cv=none; b=bEMeNGZ4aZoZo/Gv1oYaIGvsJTWLuEP+S6KgjXaUqE86d6l3PrsZCev5z5E+PBE3UchxEOr/dMRQvJRIgbFri9VaAwTOkKOPaQfFdm/HpKCZmhOzIVVDUDvm5Zoxpf635SKLplFngeZm9kuXJPaTCFAIP8nHCISsUVj1NOWZKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307173; c=relaxed/simple;
	bh=MRmQ1iSmQtrxEOe6qrbfT4Od4upA5Lzv945qF12PYNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fa6iKtivqNBPa/2agCdhs01onpKf3w1tSy8R7B+S0FeAQUIRTPNaR6nS6MYaOr3XtZh7BhcWSbZ5p7GJvh5EwrC3KtP+qBr/twNY/COy4DnpJ0LogYWo9uvJSDJSHi9YkRKuRnGNwVoOlLaMp3gqkEaZuSjSrCV785780jpicJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWJX3o4t; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83945063f70so3023637b3a.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307169; x=1779911969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VWvyBk6QerGzJy4Wnf433/QgHFYbGwPbSdseO5TT7EE=;
        b=OWJX3o4t35fe8jY3gynmCbxoX1KOwQrJbUEB/b7ABu7yUxysexGXxkX7OFHjvYiz7X
         nbYT+v9B+nlnZrxvuo085YoS1KsUHenDrnvvLEylWMlWnJrN+dyM1mG8EkePljDtCaom
         NTawTotCdQ+NuuVvU8XM3JEq8mhlPuT9F+x46cK73/eK86vrJWcxmbC2Dw2iRmSD+H1R
         sbom2EW/FZk/DcUb9X8bKB1y11MY/Xi/foOhPq5NiURnR2vue9QCwfv+epdCGlLryly0
         deCCRsTUA/SKC1zMzuonpD8hw5BzQCGlMjK8u1laGVOfqTAT0PuBmBmQGbe2v6n2m50O
         snww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307169; x=1779911969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWvyBk6QerGzJy4Wnf433/QgHFYbGwPbSdseO5TT7EE=;
        b=hAn2do2L2LOa+GrXZqFWi/xBfUjMRuekIFIoWWCj3lhazy2QvW6vxUf2hXSN/axYWk
         DuaHTPtDVs1ZhL7BGW3Z9iNRuyckAyXBcLVRWVE7/fogSD1SZwO49HHBs5vnLzKZNhuZ
         uxJZlknK6bcibhhNpf3Swp49Pu7g4Bs6o6hh+5IaSvYG8ghrASNMJ+q1zNwg/9bAcph9
         70mj2vs+jQ9elerkP4NFy6ehamrbpNBnYH8fAy57967dJquWu9vw4+uPbrKW/q7sQ4mf
         tyhCdmGK5aIjgYss2NnVbG9NUm4dAUYdbK/dP0ekYwJG0iqJ3zyMQWE6ZVka5ctu0nPx
         cM4Q==
X-Gm-Message-State: AOJu0YzNKwo1Q9UsNZd0n4hWhyaeLU4ylLqRoyZ24pxOGpE7yIQo9YaH
	X/UbyjYqE0gJzqnXoDwdIezI2eUaUy5nR3ms8nZDtdV8np95+2kAqxOH
X-Gm-Gg: Acq92OElNkwBoOEKn2nCLuxRnIfqU86TSREC7BEQNaXZGQD8CJ6aIk2rC2qZy6Q/KCW
	xGhLWd7Qx+qM65fv3nDP1ts2ZdODCH4Pk6QaiUcj/A4HKgdevporOUIaJIt8AiNl78f5R3H5GPB
	i7vUsmDAPL5AjwVBQcLqURm3bRYAJHKz/V2LU1d6Je21u/OTS9kFG5ikkGFgkZtzg8cLZ3eYNoy
	d7Vr44Hg65QU8zQ9XqVckh214z/3B1JAIqwd0SKf6T/rabGVF4f5R+lJYjDZjRF8gv/Avp5GMYd
	2XsBkr0jfUxUC5/lkoxLp5Ql1VtXghsfvAqbrIJPNNT/G/r3HM1mRJvJjWhlOdjhi3hrYFWadwV
	nDOnNR+ZrAJxk6dFbF6UB5/hO6eeykbsxHOSLpePJ8RdRVsruhmhFZq5q1CcDNxz0AX7MQcwU7R
	MPvCvO1IkTqsaT9MIWMl/gVsX4NRKHn0CKQ10AC4g0Qw17GJdIM+1M
X-Received: by 2002:a05:6a00:3d55:b0:829:8083:472b with SMTP id d2e1a72fcca58-841486618c9mr633785b3a.4.1779307169295;
        Wed, 20 May 2026 12:59:29 -0700 (PDT)
Received: from [192.168.0.161] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm21503813b3a.11.2026.05.20.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:59:28 -0700 (PDT)
Message-ID: <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 20 May 2026 12:59:26 -0700
In-Reply-To: <20260519181314.2731658-11-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-11-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290088-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40FB859902F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> When checking whether a referenced dynptr can be overwritten,
> destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
> current call frame. If a clone sharing the same virtual ref parent
> existed in a different frame (e.g., passed to a subprog), it would
> not be counted, causing the verifier to incorrectly reject the
> overwrite with "cannot overwrite referenced dynptr".
>=20
> Fix by extracting the counting into dynptr_ref_cnt() which uses
> bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
> all call frames.
>=20
> Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when refcn=
t > 1")
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/too=
ls/testing/selftests/bpf/progs/wakeup_source_fail.c
> index b8bbb61d4d4e..d4d0f1610853 100644
> --- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> +++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> @@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
> =C2=A0}
> =C2=A0
> =C2=A0SEC("syscall")
> -__failure __msg("type=3Dscalar expected=3Dfp")
> +__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects re=
ferenced PTR_TO_BTF_ID passed to R1")

Nit: this change seem unrelated.

> =C2=A0int wakeup_source_unlock_no_lock(void *ctx)
> =C2=A0{
> =C2=A0	struct bpf_ws_lock *lock =3D (void *)0x1;

