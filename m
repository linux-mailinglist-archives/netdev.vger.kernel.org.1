Return-Path: <netdev+bounces-292417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NTBHDosF2rd7wcAu9opvQ
	(envelope-from <netdev+bounces-292417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 705695E8620
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1752302608C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8744CF52;
	Wed, 27 May 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="brcUSuok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563B364EB7
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903536; cv=none; b=dnxTQeQAe/fdhlOdcgPgTlAYS5AmtuwMF+5DPvfLmO+OstyaoE6euQwKQ8PJy7SvE6VTHuqY+6Cqsum85KLotgX5Qfuuze1Hwa7JGsswyyQNTD5QduG7qDjaMO5jgyR0ASxRsM1U1F9rs2JQbGtxBl2sCkIXLegvPv+b+6KF8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903536; c=relaxed/simple;
	bh=9sBovYNOPoDOq7s4sZP2IsRza7iSK++mMdMeA8dhfYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHGTB4+PT8qDowvxljpdrp+kYuk5ar5AY0LacixJc9f0TBoyUtdFlzVlS95BYMRupMP249YIFkKQC6dA1aV6fImKMGukToH7AMVlBcdF/UHpwCXT/y4xZdDx2oQbb0sl5CMB43eyaeYnPUQadjO+Juxuzb7Rg9PpCQChL2nZdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=brcUSuok; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so1446152241.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779903532; x=1780508332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+ZMotmKA69XktY7YZVd+0HlOa08ng6yma1cuEVxEak=;
        b=brcUSuokjsCkY3sOIWXocVz5TaCZ8hZAwxgDaBsoGm3CQBfCWbGv/3p9r+EL/ooCMK
         Oc19/eU38MECRe6wDgZAbsQA2VD2EoljvzZ2086kq0gx+fBa4QsaaiZv0GEG45AQjpju
         7zX6N+B1d6X3/ikE6D1OaPKkzZvd94HZAmOyQnTS2Wl/5rjFEijq8YLRFBge4Ue51ejZ
         UkcbZuapXiQlziOFpCfV/oybGQ8SGf8BEGE1KGtXex1orIcRfb7aMdY5SxJIEsWMqW8u
         E/sQcwFW+l1b9MmXJUSYJkrTt4UfQMzOSKhhE9+kR5aW80u3nRW+EMVV4qOB46X1xMa8
         X0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903532; x=1780508332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+ZMotmKA69XktY7YZVd+0HlOa08ng6yma1cuEVxEak=;
        b=O6I3ScWNfrNfShdkTug3yLdH5OJuvzGhFMgMLRm9rkZ2A742BhSBR5A1QZX74CK8b7
         7F3D2YwOThZKe2lVK2VrC4s7vHTi4PsGIbm5D+JGLWaEoZ7ahzDh4/LK1gLQHsckIKsG
         2kf8S8HIaEL8/DeBCdtZxmykFuQDC/0e8StEvf0hvni34x2ZbizWUVYuG8yXLj7BPiSt
         Jx00HsKBTBNBDEbKaoeV2eNCzmw2Ig7407O7986C6NuNBq0kgpPCFL96mDbmMwpevDgE
         6LT+JrdzXekTKdUg1KGunyB92/J29Y+66o1Vb3puylSLxxBZiehrLMAmdSfUF6VtVTvO
         qHCA==
X-Forwarded-Encrypted: i=1; AFNElJ+XzVdDJDKHJCeaWcnzCVVfgiKC38hsi713lExuMpqE3/bHmxel1m+OxafURWmML7NYWDhaX5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcoVwV0ICfJjFKT39gQa2JMQj9DqtB75K3BtM6Egz+7nm60JO
	NXTHJVzSi3WJ7ojSneZI4cUzOaz1oZ6EcsDZJVlhQA5DFvwVuF+zjQ43jpfD0xGCMQ==
X-Gm-Gg: Acq92OFe62+z585R1Z7thGYSRqHxbcGKvHvixEDbbHGWPRZvFpSTmtDxnBp/GfwHsjT
	HEofcTJhhsjFgyTj0iRrtzWqRfET1mE83kAk1DV5cv+3BNMddWPFm7YSb0tQ7MmgQ4vaS8Zia86
	uoCB+7+FdeTAspQAVtaRS63+vXlytZaytjUKY2mg046dNJkcas7etq5LCGnwxdDSIiTN1otGEtm
	w79iEh5IlIzLMaN58nrAve4nQdyd8UGs38ZRdk355g65Gcuc7BvleGVOnBzpzHuATnwmI8EdBhH
	gbmupczVFNM9tu2OR43DL1d+Lo2k4TGTfFq1P2DmI23LWPJdP49mH+dvmu9mN7f6bK13eClh/uS
	KizukPrF82ftuOObubBiNv2HC0f1pXdmSPhx88sDGjUjvV15/DBmrnJSg2m+yYSrK4X6IAB0pg7
	TOeugby4gXMeJQv+KMiphw1IwLH6z6biQNT9eScFCTew==
X-Received: by 2002:a05:6102:441d:b0:5f7:240f:bbee with SMTP id ada2fe7eead31-67c7490bbe1mr10683274137.1.1779903532192;
        Wed, 27 May 2026 10:38:52 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-67ff5f0820csm17925711137.11.2026.05.27.10.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 10:38:51 -0700 (PDT)
Message-ID: <d1484ff7-2d81-4df4-87bf-ce9f9726eff8@mojatatu.com>
Date: Wed, 27 May 2026 14:38:46 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Kyle Zeng <kylebot@openai.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vlad Buslov <vladbu@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526220847.28365-1-kylebot@openai.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260526220847.28365-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-292417-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 705695E8620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/2026 19:08, Kyle Zeng wrote:
> Currently, the NEWTFILTER path uses RCU to guard action idr accesses while
> the DELTFILTER path uses mutex to guard action accesses. This
> inconsistency leads to a race condition scenario, which can lead to
> erroneous operations on refcount, eventually leading to use-after-free
> situation.
> In this patch, we revert the introduction of RCU back to mutex in the
> NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> the race condition.
> 
> Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in tcf_idr_check_alloc")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/act_api.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 332fd9695e54..63841c3e4310 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -874,36 +874,34 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>   	u32 max;
>   
>   	if (*index) {
> -		rcu_read_lock();
> +		mutex_lock(&idrinfo->lock);
>   		p = idr_find(&idrinfo->action_idr, *index);
>   
>   		if (IS_ERR(p)) {
>   			/* This means that another process allocated
>   			 * index but did not assign the pointer yet.
>   			 */
> -			rcu_read_unlock();
> +			mutex_unlock(&idrinfo->lock);
>   			return -EAGAIN;
>   		}
>   
>   		if (!p) {
>   			/* Empty slot, try to allocate it */
>   			max = *index;
> -			rcu_read_unlock();
> +			mutex_unlock(&idrinfo->lock);
>   			goto new;
>   		}
>   
>   		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
>   			/* Action was deleted in parallel */
> -			rcu_read_unlock();
> +			mutex_unlock(&idrinfo->lock);
>   			return -EAGAIN;
>   		}
>   
>   		if (bind)
>   			atomic_inc(&p->tcfa_bindcnt);
>   		*a = p;
> -
> -		rcu_read_unlock();
> -
> +		mutex_unlock(&idrinfo->lock);
>   		return 1;
>   	} else {
>   		/* Find a slot */


