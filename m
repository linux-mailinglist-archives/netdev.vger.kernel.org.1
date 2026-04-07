Return-Path: <netdev+bounces-275802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGHxCTVb1GlhtQcAu9opvQ
	(envelope-from <netdev+bounces-275802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:17:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C63A8A2B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BD23006B56
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764E1F5825;
	Tue,  7 Apr 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqj47eiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A65175A99;
	Tue,  7 Apr 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524600; cv=none; b=rScjKfFnAyVGhcQdlxyZrCF7gTWcGscOA+hUzAtXAw/ap3dqZdMdjWz5n42H/pRv08cj7WHTG37bUPCSwnMNqfVYixGupbG5/7+4E34p+8VDE3WtTfdKWVBWcJkjFLvQUEs0ZHRbs+ywNmZswOnprcwCFuoNGtE7yhFY+vfnE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524600; c=relaxed/simple;
	bh=AzMdVP7/G5bzjm8meiWvJMo6wfO6fiV/JQEr7jX2DIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p82MSLCGcLBLkWvLNtLWNuYyah24IrY297TdylJKXo5JmrFj568Dq0RQCgGm2i7RCxNqw87dxDpUvd1bP+NXOjHgH8unbzg7hCqsPp0VuOF7l4Jhz6XxM5nEgdDVsKsrqCgTS0c7jNmSMU7lH8h4fAYGYiDo9fXJAr1slv2rosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqj47eiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DEBC4CEF7;
	Tue,  7 Apr 2026 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524600;
	bh=AzMdVP7/G5bzjm8meiWvJMo6wfO6fiV/JQEr7jX2DIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jqj47eiPNXoS3bJyMW1Or/sURAnTnaVg0DAx6C3xA09198+gcymwJc21+CqyhpAV5
	 pKhUmPf1b781U4woM8ZYDjUH2isaqBKda3ZdyhXG1iBG0q1hqkAb2vu0Se2zIsJnxa
	 Rd1Kr4Upc47JOcncjLRi7+Q7WtOuLr4Z5QdKaf+EPe/R94S4Ylr2mkUgezMYTjfJW+
	 I/Z6hbbuDKsCLY8bzTImCDebFRvAg6tQK9f/D5YBPI9lM4Fn30T4xSXbYqufrhNepd
	 rsWdDBc6FQdxMRwazUZwFhaYF4qu/ZUalLIrRt8JVKAQjsR8PTrIr1ZfNU7doOTAd6
	 Ytcv4sXPSSi3A==
Date: Mon, 6 Apr 2026 18:16:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v8 01/10] net: tso: Introduce tso_dma_map and helpers
Message-ID: <20260406181638.0c302c41@kernel.org>
In-Reply-To: <20260403003524.2564973-2-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
	<20260403003524.2564973-2-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275802-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 968C63A8A2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 17:35:08 -0700 Joe Damato wrote:
> +/**
> + * tso_dma_map_complete - tear down mapping at completion time
> + * @dev: the device that owns the mapping
> + * @cstate: state saved by tso_dma_map_completion_save()
> + *
> + * Returns true if the IOVA path was used and the mapping has been
> + * destroyed. Returns false if the fallback per-region path was used
> + * and the driver must unmap via its normal completion path.
> + */
> +static inline bool
> +tso_dma_map_complete(struct device *dev,
> +		     struct tso_dma_map_completion_state *cstate)
> +{
> +	if (dma_use_iova(&cstate->iova_state)) {
> +		dma_iova_destroy(dev, &cstate->iova_state, cstate->total_len,
> +				 DMA_TO_DEVICE, 0);
> +		return true;
> +	}
> +
> +	return false;
> +}

kdoc says:

Warning: include/net/tso.h:120 No description found for return value of 'tso_dma_map_complete'

missing the crucial : character..
-- 
pw-bot: cr

