Return-Path: <netdev+bounces-280276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPqOBF4K6Gn2EQIAu9opvQ
	(envelope-from <netdev+bounces-280276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:38:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FB4409D9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06577300F9D8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1231E85A;
	Tue, 21 Apr 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="eoF/eeA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530F2BB17
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814683; cv=none; b=VEZZDNu1bozNhn+wUuPdtRDMO0m1s5HRTHhFAftFifFwa/7+T0KuIF2yUuNuCINnVQBZjdWD6v3Ja2JOskfBhwqYWW/qA3glEPmgfS3mDWswYmMitVh5bH/aLvnvPREvhJKH01la/9JLwYsQ4zoI3nVTz69j4yPakwWLqGjuanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814683; c=relaxed/simple;
	bh=pRPgjLvtbOAdAHM+3vHi39XTL/23sJQjTgz9Wwlt4rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBQ2NqITZh1Iz/oBDyUNzG1e+PR/sDAWEWlgRaW42qDsx1Ef07hnm8nbn6bKDOPrgvXAKsOcVN3GwtEwhGEyHhjam2YE8HFpl4nhdhZllknxNzY7yQif+QwLqqDDWrcBgtfk3CkuP8s7+6lONd5G0Ub8xkmKU5LhTB/WWfDxk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=eoF/eeA1; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12d4bed3384so2437135c88.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776814681; x=1777419481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNODwWeBbC+8XlX9fYrpMq0AJqANsIaBG9uIN94XHE0=;
        b=eoF/eeA1GfrMcU6ibeI7sCuK+NooBcl6d1JCaghl24Uz1jtCKm/1q/Xo96LA6T0dK7
         twEY0C5ZnKmkAvaz/6ODuBxDbZU+Q/LezJ+uHI+HEU2S70+gDLpFmHZ78AVwU6FKOcOt
         oc/8fEvThO5KGa6fDWb80gjHgy6Cx68R0pQToql2yw+J/IS43W8rdFqHusBnohDCDSF0
         EeYLNkAf5c5/6/K6sVRbDChzNH9+/PLNAI++OB3ic/x+qpXASd8yaH8Wf+QLnkuR20s0
         w+ClLIewlXAU7ePKwYrrOll3LC/80tCCkS+CnR0h+tMMj+9LboDKfI/8c9Y+A0vByXb5
         UXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814681; x=1777419481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNODwWeBbC+8XlX9fYrpMq0AJqANsIaBG9uIN94XHE0=;
        b=frttz9O+Jb41hjJdwakUSB4Vd00dmnTBT9391ZJxiNkKKSz1gXLeuIfrqAyyyxMFhi
         mrMmV9UvSGZqQzasmu4sYSxgpHz3LMqYlzLsY2ecsCV//uAI6BbkuKJLOv7ZSHbhEK9+
         LYtSAeUvNvSjhtyTJz95lTMvqiHfepBDEdIdf4mSaAFZeDSSfwf5jukbQkWL5RTo/PyG
         7I71JRzhdGQsTKtVsLKbncvnYRhErZpbL7qxgDjZjKjEHviKIRxmu05twXJXkN7DaoXZ
         DUipuUcIl8Z+xu07FPwzXKtK39CTep3n+bhLCZzSq7Gr7++jroOlUIHZ3wtj/aqsaWKX
         AE8g==
X-Forwarded-Encrypted: i=1; AFNElJ/jcx+yMMx+9ptrtnyjfNgwuNmpJGS24laee4tLiQ/0g+VgJVwdxL4S8BqEm5Souuys1l7kDms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn5ZmEZnN8wabA1YnWgfCOSb6q/Hhza7AmlubnWZ8eGPqD9aG
	QtdrLd+PcKJZ5e4iXisA9Qber8lazGRS+1GAFkYMwhTU8usDO8EWcZWuUCXGT7ydcPU=
X-Gm-Gg: AeBDieuBj3mQV1ORJJY/4pp6yK/B4KkLt1M8Sq1JsJrdKwHX1Gpt7FYBPr0oeprZiFf
	Ddh6NU503FRFDItIyx4yZtxVYDUpWpQ71+Mo5wYb4ETJxLD/NVdlgLu9vfpF8fxOgTlxwCSSkSn
	KyxWsuOzKULH/v53ozlKw2J+cUOaAKvxM04zTKGrJoFIfkRbSVs916Uq/ZGH5ALwfjGqNRYM9J0
	dgEzQfX9cjJ1CGlFS39MRQXzaG9I2jCOMn0LCnsjH5yj9Gd64rE6dIq9w8Zfk9bwrVw4vKM490T
	Ga7qR4et10EoPqXKAcHqSFnju/3Fn5cuVenmvtbZcYpRRnLgDnq5FqVJGKP8RnCwF1kH6aD7YeR
	XmI6V4ZnuVF2/jlCjPopY3Jzrlqs0uqSb7rKMKHQdlphk5iIs+uVOjlw1Vj319eczTWxMIPii3t
	gIbjgooHUvQuejwJCqP2chIBLRd3sMoVITPlNu6pyK4R4dZw==
X-Received: by 2002:a05:7022:23a5:b0:128:d752:e076 with SMTP id a92af1059eb24-12c73f6c3dcmr12229023c88.3.1776814680727;
        Tue, 21 Apr 2026 16:38:00 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c8caecebfsm11156826c88.5.2026.04.21.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:38:00 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <20260421163757.31da8751@phoenix.local>
In-Reply-To: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-280276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 508FB4409D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 14:35:12 +0200
Luigi Leonardi <leonardi@redhat.com> wrote:

> parse_hostcond() uses get_u32() to parse the vsock port into the
> aafilter.port field, which is a long. On 64-bit systems, get_u32()
> only writes the lower 32 bits, leaving the upper 32 bits set from
> the -1 initialization. This causes the port comparison
> "a->port != s->rport" in run_ssfilter() to always fail, since the
> corrupted long value never matches the int rport.
> 
> Fix by using get_long() instead, consistent with how AF_PACKET and
> AF_NETLINK handle the same field.
> 
> Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  misc/ss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index 14e9f27a..6e3321ac 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
>  		port = find_port(addr, is_port);
>  
>  		if (port && strcmp(port, "*") &&
> -		    get_u32((__u32 *)&a.port, port, 0))
> +		    get_long(&a.port, port, 0))
>  			return NULL;

If you use get_long() then the code could get negative values.
Actually have port in ss as signed value seems like a mistake in original design.

The port in unix domain socket is inode number.
Originally it was int, but got changed to long back in 6.6

The port in ss cache is int.

The ss code is one of those legacy dog piles that needs a major
overhaul and refactoring.

