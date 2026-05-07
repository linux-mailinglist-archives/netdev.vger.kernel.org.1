Return-Path: <netdev+bounces-285309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJInKDCG/GkaRAAAu9opvQ
	(envelope-from <netdev+bounces-285309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:31:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8D4E8380
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6479B30074FD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF183E958D;
	Thu,  7 May 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/iP/65X"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7D3EF0CF
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157097; cv=none; b=jst7pUPOvKMhmbuMq31YLEGL3i2Quywv8CH241M7FwHk17CsU4CGT6zSUMSAmUomYeOZReZ41rPK1pR2ZDJqdNEFIGPtKoeTb2zZI7UZAOsX9o21i1xmKOoElqars49ntOlNWL/rMddsfSrGblo1RkNv6ZVkit7998WH1wQfb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157097; c=relaxed/simple;
	bh=abR33LWqDOSHmYqXKopX4dV7qJgCLnKBEHLiDWopmKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUP+2Q5HhkpirtIlOlhY0lb9UBuUtkGp9AcJfTUZaTZR9HlamLfIL179jofhgn32YDx5tlhQ2wQ7wbrVQUMm2v8JpV/U9ylZaqrIIK4qaykAvHycIU42PY50Ax1UPuUujItFa4bz+bv7EJDhQT6FHpSflaugzPBecrZKDzJxIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/iP/65X; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e9b15c7-5db4-408e-a5bc-75fe5752ed74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778157090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVcapITppFjdbgWyCIsD7Di3H3M7df4fmIK75pLRWfs=;
	b=M/iP/65XiomV/0Vr3DDPkszg7lw61MMKsk0KljW6BdM85buVlKRed8fdzcUtbfUkpvMdkg
	Wne3gpPVMexad+izAogv8xzH/34Ik/w8n72PvHFK1T2PyQaN3HBvIj8n0BmTKeVqoRrl4c
	VzIT85gl9FPSaSGvhY8yk75NX/VATdo=
Date: Thu, 7 May 2026 13:30:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] net: rnpgbe: Add interrupt handling
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, horms@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yaojun@mucse.com
References: <20260507081539.171844-1-dong100@mucse.com>
 <20260507081539.171844-2-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260507081539.171844-2-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 38D8D4E8380
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-285309-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 07/05/2026 09:15, Dong Yibo wrote:
> Add comprehensive interrupt handling for the RNPGBE driver:
> - Implement msi-x/msi interrupt configuration and management
> - Create library functions for interrupt registration and cleanup
> 
> This infrastructure enables proper interrupt handling for the
> RNPGBE driver.
> 

[...]

> +/**
> + * rnpgbe_set_interrupt_capability - Set MSI-X or MSI if supported
> + * @mucse: pointer to private structure
> + *
> + * Attempt to configure the interrupts using the best available
> + * capabilities of the hardware.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> +{
> +	int v_budget;
> +
> +	v_budget = min_t(int, mucse->num_tx_queues, mucse->num_rx_queues);
> +	v_budget = min_t(int, v_budget, MAX_Q_VECTORS);

these 2 lines can be simplified to

min3(mucse->num_tx_queues, mucse->num_rx_queues, MAX_Q_VECTORS);

> +	v_budget = min_t(int, v_budget, num_online_cpus());
 > +	/* add one vector for mbx */> +	v_budget += 1;
> +	v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
> +					 PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (v_budget < 0)
> +		return v_budget;
> +
> +	if (mucse->pdev->msix_enabled) {
> +		/* q_vector not include mbx */
> +		if (v_budget > 1) {
> +			mucse->flags |= M_FLAG_MSIX_EN;
> +			mucse->num_q_vectors = v_budget - 1;
> +		} else {
> +			mucse->flags |= M_FLAG_MSIX_SINGLE_EN;
> +			mucse->num_q_vectors = 1;
> +		}
> +	} else {
> +		/* msi use only 1 irq */
> +		mucse->num_q_vectors = 1;
> +		mucse->flags |= M_FLAG_MSI_EN;
> +	}

How will it work in case it's only 1 vector allocated? AFAIU, you need 
at least 2 irq vectors - 1 for queue processing, another one for mbx.

> +
> +	return 0;
> +}

