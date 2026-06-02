Return-Path: <netdev+bounces-294297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sg9UDlELH2ozeQAAu9opvQ
	(envelope-from <netdev+bounces-294297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:56:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242166306CC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZSWpP9Eg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294297-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2720A3050B7C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B906372685;
	Tue,  2 Jun 2026 16:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CB37204A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:42:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418536; cv=none; b=sKoV4gGRE1yEtR0ua2WPeE5aSQWsgqNKI1/pR7gFLCNierxZKYGzPpjw2H8LCTKp1zKm3NYZJVFFmYFdnFntIwE0l3U9IJ2lBndt8nmgX/VisfTKfEr+sreEdd9ZCafM/MniJCnotEuQq/KBlFuVavJ+f4vHVEakr95qP5clks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418536; c=relaxed/simple;
	bh=zw13GpuhaUhHnzla5NkhOa2S6NSXmxNPcGTkicXh7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYXS7sxcpcSHvWIWSJf7RxDtm5WtxQ3KjrhK2w27x9prqA63WcXgHg0P8I9F9OMy7KowZnex3X0Byu9dy2XeImd4BoXl1C8HdfuUY6BN3yNARiXnUzZwjsz1qPQ3zo0y6b6EV8NqWoj+Dh3Y01AOTlthIDQDJwFrgjy3RYsMq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSWpP9Eg; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec449d0af2so341951766b.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418533; x=1781023333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JSQ6cgHRkKyWZQQ9xIiK3LJg+wJd+v3wFSnZuWje0A=;
        b=ZSWpP9EgmB8jp1r8u4WG0jbxmbaEWg4Z3RZ7nN1Y3Q82RU5YcyUfdnefdQNOEV67Lc
         xchQhnMy7q5FhVhJjyJOi9D6FyqAdNwSm6dK0btIZg7Kp5lXHE39UWiNVHGe6uBgTKzf
         xiAorbjjJpsc5lLGVh99e+rAlZzxco5t873a/57dLr/0ykNxHgE60Q1xYWoxpCfOuRKY
         e5ycdBu7jnxI4YAEyEqMvI6jFtH7kuOsn8HVgK1fYiT/n7A1+CftrxZM/YwomgPRP8N0
         Tf1olp/Y/KW9Z/K0t7njv0fJB2XyN2LhkXtIQF7tJMG7bkiXAaD6M5zVp1m9uOaJ8j3y
         y6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418533; x=1781023333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JSQ6cgHRkKyWZQQ9xIiK3LJg+wJd+v3wFSnZuWje0A=;
        b=YeN5Ab/SuwERHwZoRSLpb1eWabdc0Yg6v9QobsIxI0UUwAuNUw/nNxiX4WH5ygIdls
         ZrfwcR48xxR8YpuMHftBD+SRMb7vnCwtH5CIZOsZ9PwBOrJxhQaDQ+fp5fnh4H4hct9B
         Q4UDq4+P69S1o7grfv8QNhl2e0eR8DxU0YGt2p6cZThA8K4fsfvjsd8y4CfYJOPDm+hC
         Xl6nlCv4SCm2NDMA+AFi6Tycb9mQISFUm0hin2E8+DMowtmDbJx1iVFAQGOCUl5W9NJ0
         Gf1hlaouy4lpt9KBKso5zz72kiR5qXpH1h3SqFzCqGGVp7sSeANUHmFJ0VlwLeswOowj
         dJcg==
X-Gm-Message-State: AOJu0Yz4xygKJaWfE85S42uCSvvJTWzhn3qPpY9vgm2qg+2GEQPRmR5t
	LNbJl6G60myztgSRp9yYncWvxX6lUm5mvVHA4PDH+4JM9UxzrPuoy5kg
X-Gm-Gg: Acq92OHT3ICdZ4M/F1UWCR96/utGjx8L/1+wvSPTUnco53RMYaxygWw466OpMLJPglG
	Y70kHyOygn1COshuItJNF2mGbrDiYOSW3wPZUYRP6K0xQVXqpuOibw+10r0NZdNosGI/NmJxYhJ
	5N1wOJxbNdkjp9yTgmmVxl6wKmW1bQRUPy9nn8LE68ut9KUvIZwSRnf2psBZAux7jwSLrZJpYdR
	81SN+YtGuW++phb2+ZcCzK+CNF3ewV1Xq+4WVYRGzpn5reJolcNXGQFA92/VsuFY/Hd6baNJ3F8
	yWq/ROMK6oPHtx0dcWnt4Is17N8N8hv/9i8UNOZ4P6HQAUApTkNaNtJgOeVoixQ5YrnD8E09b3C
	AQ7YiYtFBF1lZmxm7EaRdx/za3mMrSNx21N5Tw+itT58UL3+4MwyIEE279knSHOkFm36dFvkET0
	yZ5p46urb5wBqzHszJSt7N26w6ly7hzroIKENDoIM6acYJiQ==
X-Received: by 2002:a17:907:3e86:b0:bec:d077:c4e1 with SMTP id a640c23a62f3a-bf06332ef0dmr16598966b.47.1780418532750;
        Tue, 02 Jun 2026 09:42:12 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm14490766b.38.2026.06.02.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:42:11 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:41:58 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew@lunn.ch
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
Message-ID: <20260602164158-oscmaes92@gmail.com>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
 <20260602024428.1664921-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602024428.1664921-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294297-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 242166306CC

On Mon, Jun 01, 2026 at 07:44:28PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> pcnet32: stop holding device spin lock during napi_complete_done
> 
> This commit removes the lp->lock spinlock hold around napi_complete_done()
> to avoid a potential deadlock with pcnet32_start_xmit() if a GRO flush
> were to occur.
> 
> > diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> > index 911808ab13a79..4f3076d4ea34e 100644
> > --- a/drivers/net/ethernet/amd/pcnet32.c
> > +++ b/drivers/net/ethernet/amd/pcnet32.c
> > @@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
> >  		pcnet32_restart(dev, CSR0_START);
> >  		netif_wake_queue(dev);
> >  	}
> > +	spin_unlock_irqrestore(&lp->lock, flags);
> >  
> >  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> > +		spin_lock_irqsave(&lp->lock, flags);
> 
> [Severity: High]
> Does dropping the spinlock before napi_complete_done() introduce a race
> condition with shared IRQs that breaks NAPI interrupt mitigation?
> 
> If napi_complete_done() clears the NAPIF_STATE_SCHED bit, marking the
> NAPI poll as complete, a shared IRQ could fire on another CPU.
> 
> If pcnet32_interrupt() then acquires lp->lock and checks csr0 without
> checking the INTR bit, could it process pending events and successfully
> call napi_schedule_prep()?
> 
> If pcnet32_interrupt() schedules NAPI and releases the lock, this code
> would then resume, re-acquire lp->lock, and unconditionally unmask
> device interrupts.
> 
> This could leave the system in a state where NAPI is scheduled but
> hardware interrupts are enabled, resulting in an interrupt storm on
> every subsequent packet.
> 
> >  		/* clear interrupt masks */
> >  		val = lp->a->read_csr(ioaddr, CSR3);
> >  		val &= 0x00ff;
> > @@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
> >  
> >  		/* Set interrupt enable. */
> >  		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
> > +		spin_unlock_irqrestore(&lp->lock, flags);
> >  	}
> >  
> > -	spin_unlock_irqrestore(&lp->lock, flags);
> >  	return work_done;
> >  }
> -- 
> pw-bot: cr

The suggested race condition is impossible, even after
calling napi_complete_done all pcnet32 interrupts are masked via CSR3.
pcnet32_interrupt would never be called until the second locked
section in pcnet32_poll, which unmasks the interrupts.


