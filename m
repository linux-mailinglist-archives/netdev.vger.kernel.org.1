Return-Path: <netdev+bounces-304024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KpbtKUEZRmrmJwsAu9opvQ
	(envelope-from <netdev+bounces-304024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC416F475E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:54:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eZF9r5ov;
	dkim=pass header.d=redhat.com header.s=google header.b=rS9nSt3F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304024-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304024-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B76DA301587C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF63D4128;
	Thu,  2 Jul 2026 07:54:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290C3CF976
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:54:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978850; cv=none; b=ae5bqdE6oCPKJEAUKEQvE9yL6SiievpMUrdfUAeYCHFcrQybbIy/xVQWK0MW18Ioeitk2y/KGjQiuWKwfjVPUyzFubNQxij4oxt0ffV8392XrACEmdVyTfNXV/nzL3nBOYhTNS+fMG9rdr0+uHsGz7/qSG7cT4YAJzZrrNCaxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978850; c=relaxed/simple;
	bh=csQNDu7FEA6fjdp9ZJGs7e1q0bkeaYb3aCJUyNmsgag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv7lPw5jMj8KV/kv2dXjL3c0/mM4+vlpfJQh1B+wckHHuhDVc4PzhuXpP9DaINKz/Wkwdmumusl3Qjjj3w4+f21kWGhUNjgbkM+w5+yO/l3UrpNCuy842g8v5rV4aPsf+N/SaKSDkLTb9Zhd+eEJJUfHlAfvgTfCH3jyW4kBZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZF9r5ov; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rS9nSt3F; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782978839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=liR0YEI1HUp4bBUmuEDMFbNO/nTQwv1ud3Cc6UCpWRA=;
	b=eZF9r5ovBr+CJZ36Nde8OPX08pdjiPpgyOTu6T7ilv+YETCbZp6sXAoIH0S1Lw3rE5wvRw
	Xi5fYpD0Mcq48WusyTNu45rJoKWWxRTnVxaoTXSavyHXl9uML1KF4DHgjR0Ys/o5kivIS3
	lmTXAhNAA8gSJ9nwdOO7W9U2m3pSBnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Ij1xSnRZND6FIG3saqPo-Q-1; Thu, 02 Jul 2026 03:53:58 -0400
X-MC-Unique: Ij1xSnRZND6FIG3saqPo-Q-1
X-Mimecast-MFC-AGG-ID: Ij1xSnRZND6FIG3saqPo-Q_1782978837
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4925bf70f5bso13428125e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782978837; x=1783583637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=liR0YEI1HUp4bBUmuEDMFbNO/nTQwv1ud3Cc6UCpWRA=;
        b=rS9nSt3FbVEIKLLPyCz4HKprUae4dlsL4Y3HlyrcsE8KqzN0hwbQhVVtsO3c1zEfw0
         Xatn7Kz2ke96ii2fVd1UYkk7Z7vml0iMbreaiHFA6nlYDtvZiM2W3Crxnwf+IjWURocm
         obKMjLAaTiYtIWVCedwGTKCiaE5iyi3gWBrYYUNJ2aNQyRiUGoYnR8FO9WQM1Cx2Wy0k
         eu+vyeWs1rbt1gJaM4aRHpal472IoHB9GVf3yNnRhraODc/aNEz/GKEne9vdK643Hfvt
         fuJqDFrChtP6XyVrFAlk6TAHQi+Rc8jxCAMnUbTDKH81+JEsXw+a+whQj45vYE+H0Yl8
         FmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978837; x=1783583637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liR0YEI1HUp4bBUmuEDMFbNO/nTQwv1ud3Cc6UCpWRA=;
        b=TQvAd8/6I9ikr3YcVZ7JxABHFcmUWzAIlWOB/QNMBmAN3uuUrm2sHthoGRQN+c0NBW
         hl3xWOLUt/AUA1qbs7e/+Z6qG8QZkt0JTJX2qWNyM6XRkHgZFlgFrCsAatBIKVpJ42CF
         TdCVenPbW5n7Jweg5UKEwcgB+56FvWPk8UCnAXJD7fVuR0Hz9bjr4NNSiWOU2j0gMmvg
         JH4ftTnnyd2/Dxd+o6TIwJB4xCseiE2n3uvT95il34OT+0f+nbcj7hHSSB9VMGU3fBeV
         RVu6PrInQVIMmO38pJEoocBwfkHjywGaKAaPKQUD30Aq78vFS2Kj+xbzqJUglYSgQdDg
         83mQ==
X-Gm-Message-State: AOJu0Yw+MMPU0JrRa5d5/4BhP4DiABMkBZii7ms8UjEVBwIxcYCyB4+g
	UjZKFeAhIVw7vHGmvCnsZHyZaoENTu3KT0litfOkZ2MVodVhYniddhwyPTer9sf6ZXAzR1tkMN7
	y9viXao2cwirfgQmxeLm6rRquQn97q3tVkjBULLZnWXcrRXjFM8pqQsMyiQ==
X-Gm-Gg: AfdE7cnUBTC+anNiQitBkKI7YNgFy3dLRIgo30eNGQW7vob5uil7tiJxVhMd75C8Q82
	MpdGMmy1vbv+tQqN2CptqrVg/7QxcdFuvYLgPPBc9DSqZXPB1J//UsyuWsT+/WxAzcKCMvO+2GF
	rwmJ0lJzuoZHPROnVOY1Ui4kgHB+pcFVrSYjJtvqXPjPaKUJD4E3WHsjPiYpTzUCj/Z3L5Vj2GJ
	8mcqAIqr1fgkr5VOztahk1J11XgL8xrpn3KqElaFJr5LNHv8eLBB/hpEbla29erMrcAOB8umfp5
	YWc3nEmswoUSCpSuR80F0qaOD3hVXW0x/LxaIiXyUA9k1pvzWeKwmpgAlh4a3TOqoLrZsVD3eUp
	VqoNx3Z9XQriINUZtBsY9QJ+WA7XCevoMv5Z73eaUJwu8yJlBTAfKNjz9XcEbXiVoqMRbbe2a4v
	KRs+uflIp2Cg==
X-Received: by 2002:a05:600d:8654:10b0:493:bdcb:9292 with SMTP id 5b1f17b1804b1-493c3cd48f9mr43397095e9.6.1782978836853;
        Thu, 02 Jul 2026 00:53:56 -0700 (PDT)
X-Received: by 2002:a05:600d:8654:10b0:493:bdcb:9292 with SMTP id 5b1f17b1804b1-493c3cd48f9mr43396785e9.6.1782978836470;
        Thu, 02 Jul 2026 00:53:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c635c365sm25413355e9.4.2026.07.02.00.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 00:53:55 -0700 (PDT)
Message-ID: <3cce00d1-fdeb-4280-ab4c-077779bb82d6@redhat.com>
Date: Thu, 2 Jul 2026 09:53:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/15] bnxt_en: Add infrastructure for crypto
 key context IDs
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
 <20260629184921.3496727-10-michael.chan@broadcom.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629184921.3496727-10-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CC416F475E

On 6/29/26 8:49 PM, Michael Chan wrote:
> +/**
> + * bnxt_clear_crypto - Clear all crypto key contexts
> + * @bp: pointer to bnxt device
> + *
> + * Clears all key context allocations during shutdown or firmware reset.
> + * Frees all key info structures and bitmaps, and increments the epoch
> + * counter to invalidate any outstanding key references.
> + *
> + * This function assumes serialization (called during shutdown) and does
> + * not use locking.
> + *
> + * Context: Process context during shutdown/reset
> + */
> +void bnxt_clear_crypto(struct bnxt *bp)
> +{
> +	struct bnxt_crypto_info *crypto = bp->crypto_info;
> +	struct bnxt_kid_info *kid, *tmp;
> +	struct bnxt_kctx *kctx;
> +	int i;
> +
> +	if (!crypto)
> +		return;
> +
> +	/* Only called when shutting down or FW reset with BNXT_STATE_OPEN
> +	 * cleared, so no concurrent access.  No protection needed.
> +	 */
> +	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
> +		kctx = &crypto->kctx[i];
> +		list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
> +			list_del(&kid->list);
> +			kfree(kid);

Sashiko still complains about RCU rules violation here, and the complain
looks legit to me.

Note that to streamline patch processing you are expected to reply to
sashiko comments outline why they are (not) legit.

/P


