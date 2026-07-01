Return-Path: <netdev+bounces-303717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LpdXGKItRWoJ8QoAu9opvQ
	(envelope-from <netdev+bounces-303717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:09:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E362D6EF1F5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:09:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NvQyJvd+;
	dkim=pass header.d=redhat.com header.s=google header.b=iUjmDA9E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303717-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 028FE3072D82
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E4481FC6;
	Wed,  1 Jul 2026 15:07:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253A3E2ACC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:07:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918428; cv=none; b=O6QxUsQck0eoEZy/sL6pWa2TyHQYIAeankJkeD0/jZnuGwkLdwTLJZ1zNaspcfHaF53JMxlTgSGDSnBpbW8hRXd9YdpTE4dA7Rxly1OeY3gohPRlGYmFttYGadkljw6GVKHS2PnWJPZZeB04RYIgX33m7WYdrfERztYvg/2EFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918428; c=relaxed/simple;
	bh=MlAL4YFJQb5WgJokZCXKg2SDJZI5irVDi2XwniEutjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/iJaAVF6DYDcxD5G7tUBeWNBUPx7yj6C8sjueM+ICJu0qinNgLDyBqPpSXS3o0qEQrmvK584TxW/BU63K9TjRJFBJUmJL/HKRDH0U0VBjoUmqSXgKDKHYxdt3dFV2+pTDUCxTqHQjSnHBstZeniAqXo6Hitpw7B/25GEsy3CgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvQyJvd+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUjmDA9E; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782918421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvN/HWu6feZiSqpgq6zatsR6VU+a8BcYwNOqKxB1Zk0=;
	b=NvQyJvd+/m5LMCuekWFzwtSoiRq+lX7i2Q0oCR3fNkbWLd/hoE2+7ptdg0Pk8sdwuCnn8J
	rdKmGJ3K9ep1AwkBMOrHgIGIDe/Cn/14WrekprTXKOuwDW/hmxcgjGgK3iZKRV+8JsNSkg
	QHYbME1prVGM7mar6FUTd7VuhAP53UU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-n5Ts9BpEMuWAEnvuJ4seVw-1; Wed, 01 Jul 2026 11:07:00 -0400
X-MC-Unique: n5Ts9BpEMuWAEnvuJ4seVw-1
X-Mimecast-MFC-AGG-ID: n5Ts9BpEMuWAEnvuJ4seVw_1782918419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so14581385e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782918419; x=1783523219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvN/HWu6feZiSqpgq6zatsR6VU+a8BcYwNOqKxB1Zk0=;
        b=iUjmDA9EfVDEqM8cnP2E/cCaN3w0yMshWPUoHmniXmOx+AJIj/MriziV+76uD43GXm
         rprJf2w3uJeY+ZG1QDPCD0J/BvOUmlkoyvNN0AtZyZnpViLEDDepFFWBrSz11MANl+gt
         bygsXtRVQFtoP2VxifRfDNbCLHYszeAX+VOGGTxudpQPdtkHxPS0pYn3/A2WgwX+M7Se
         3z9PcMwK/fBkzcoYlOHcp+Hou9UvlMvBZumpbqZiMvHkn9sbZfOLMtN//SEaWNsuqduJ
         ddPHiQpoy0RwZrvgz7WmHh1a1nNoNbsdUu1cj4NDOdL62+O38mGhzbKzfvek4SmzQCMs
         C6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918419; x=1783523219;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvN/HWu6feZiSqpgq6zatsR6VU+a8BcYwNOqKxB1Zk0=;
        b=olYvRzApODesfDRlRAfZPP4fKkMGM7DadCiYOuomVfuj4I5HRHK9AxvkYQ7KMAmtqK
         Ywz4O/Sa53/7BIUeifZUagq7uN3/iPn20QvzV7AsMkvRwEmmBX9F7S6wX7Q65fCS7QSq
         WGqmkkP+ES0BHWcNPl3EsX0qzEcPWLqXxTMo33sIrPDVk8HqvxlC7GsPoFAQ/+4P+Ed8
         XWdck60ojrAzLHKs+bdRFsizFz/D7ntbOwgdZmAtN/giMMQO+SNkWEJIa7NaWDY3uoqG
         E9od964kAPOpqlRdSO1CTLVxBAcAAjJY6GHpJqKkKYQKuRYnNmOZC+gR4K22AjQQ/w8C
         KZUA==
X-Forwarded-Encrypted: i=1; AFNElJ9iq5Z8Aw1B0/Ti0xeejX0IZW5Bo0bHzuf0WFq82xFSA6PPgNfQiq7Vw9jgWuYHsQt9XtcjJw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eIhYs3rhlYzjOZ5VvrtIGIYUruCf5hkMGI6XQCi7n2kOlIXH
	F65IKFxiGUWmMkCIRs1mP3PUkVF2MM/YtWTwGLF5niIU84JazXMuuLptPv5L7iX0ojKRyup3MIG
	anKfunrVg9yEeQ4ZQfZtrL3oDrCbpxyWapQF0fFQbPim+o1oNQXzOsREC1Q==
X-Gm-Gg: AfdE7cksT28dUfCYurDTLenRAvo6mgdX17VGk/IHoX/TjazReHoLWlLXmtKdqVzwoUl
	lQZwpF6nP4qrDLYrOGlHq3DkCbmoEwJcKlkmVsvCkgAlPfAnXaWPnFKGiY3NqQSh7VldS2b/rJj
	rvXubVBqHbpLCxhcKldo62Tzdx3lR5uA79IfEtaU16rzv+MT+pQIYoJ0+n2fODgByFkHE0gwPCx
	eWRjknmtB2b5Ig+0JCZxIwFJeur04QIrHuuDz2q4PdAQzrlIjAAnFBiLdHSeoWirCCEiWZ30PnR
	qVzhqnnoV4NzvIKRUA7IjZUKaGg7Hx7fMAEXLNr235VZgS5pcVDArd1tBIe6Xkcj2YOq7bZUB/N
	3v4bcpy/SicMXpY3DZJu9TiT+qcF+N6tUOtjZ6bN2X/0usdDy/gqhZdHNu/+kW3lNdH9MkfzIc1
	HRJS2r9ypnhg==
X-Received: by 2002:a05:600c:4eca:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-493c231e27dmr28474555e9.5.1782918418753;
        Wed, 01 Jul 2026 08:06:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4eca:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-493c231e27dmr28473915e9.5.1782918418306;
        Wed, 01 Jul 2026 08:06:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm159515325e9.12.2026.07.01.08.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:06:57 -0700 (PDT)
Message-ID: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>
Date: Wed, 1 Jul 2026 17:06:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fman: guard IRQ handlers against pre-init interrupt
To: ZhaoJinming <zhaojinming@uniontech.com>, horms@kernel.org,
 andrew@lunn.ch, madalin.bucur@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sean.anderson@linux.dev
References: <20260629084529.3709393-1-zhaojinming@uniontech.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629084529.3709393-1-zhaojinming@uniontech.com>
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
	TAGGED_FROM(0.00)[bounces-303717-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:horms@kernel.org,m:andrew@lunn.ch,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sean.anderson@linux.dev,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E362D6EF1F5

On 6/29/26 10:45 AM, ZhaoJinming wrote:
> read_dts_node() registers shared interrupt handlers via
> devm_request_irq() with fman as the dev_id, passing it to fman_irq()
> and fman_err_irq(). At registration time, fman is only partially
> initialized -- kzalloc_obj() zero-initializes all fields, so
> fman->cfg and fman->fpm_regs are NULL.
> 
> The handlers guard against incomplete initialization via:
> 
>     if (!is_init_done(fman->cfg))
>         return IRQ_NONE;
> 
> However, is_init_done(NULL) returns true (intended to indicate that
> fman_init() has completed and cfg has been freed). This means when
> cfg is NULL before fman_config() allocates it, the guard does not
> take effect:
> 
>     is_init_done(NULL)  -> returns true
>     !true            -> false
>     guard skipped     -> proceeds to dereference NULL fpm_regs
> 
> If another device on the same shared IRQ line fires during the window
> between devm_request_irq() and fman_init(), the handler accesses
> NULL fman->fpm_regs via ioread32be(), causing a crash. The window
> includes of_platform_populate() which can be slow.
> 
> Add an irq_ready flag to struct fman that is set to true only after
> fman_init() completes in fman_probe(). Check this flag at the start
> of fman_irq() and fman_err_irq() before any register access.
> 
> Use READ_ONCE()/WRITE_ONCE() for the flag accesses since it is a
> cross-context shared variable written in process context and read
> in interrupt context.
> 
> This issue was identified in code review during the discussion of a
> separate IRQF_SHARED UAF fix patch:
> https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/
> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/ethernet/freescale/fman/fman.c | 5 +++++
>  drivers/net/ethernet/freescale/fman/fman.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 013273a2de32..f14cb02d85a4 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2510,6 +2510,8 @@ static irqreturn_t fman_err_irq(int irq, void *handle)
>  	struct fman_fpm_regs __iomem *fpm_rg;
>  	irqreturn_t single_ret, ret = IRQ_NONE;
>  
> +	if (!READ_ONCE(fman->irq_ready))
> +		return IRQ_NONE;

Sashiko noted that on weakly ordered arch this could not be enough:

https://sashiko.dev/#/patchset/20260629084529.3709393-1-zhaojinming%40uniontech.com

Also I have the feeling this is papering over the real issue. Why
initializing the irq when the driver is not yet ready? Why don't move
IRQ initialization later?

/P


