Return-Path: <netdev+bounces-106702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E179B917521
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DE4283E7E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8BECF;
	Wed, 26 Jun 2024 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDqwc2fp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A31A48;
	Wed, 26 Jun 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360207; cv=none; b=Uno+4B07+czf6k3Yg7Wq2sQiSFeez7wT/STacaCoBWPp9ZtLyS+XEC4ZCIan5jT+bcweoXMf+m+LxSL7Nz0OVY6kAY82q/v3mOMkEbwOnNhHIhK8IM7r8MHQYoYyEvMXkTQvSaJsuhNDyR+huKeLLuLN6Dn+EU157+98KaxWI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360207; c=relaxed/simple;
	bh=NK6Sy1+gBkH7/RMREnYLk2uoeiro6r5YHifzBo96RhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7USQdTpbTTadmcc/43v3+dbrAqWBRAloXiQ1YuupGvEwkGoIzRExKwcJdm/mqGrfwN/mQCWv5eqgsjcI1OEDGXK0pInOq0DoXIseUxs2tfcZ6O9P439ARAbeSXK7lqaAWZ6o5dfgpBNVD3+o1aTePqu2t8KRmu5TuIWmaR7q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDqwc2fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFA6C32781;
	Wed, 26 Jun 2024 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719360206;
	bh=NK6Sy1+gBkH7/RMREnYLk2uoeiro6r5YHifzBo96RhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDqwc2fpaWnUv6j1A2W4z8eWsSFLzv+o4ZfeKKreKTbNRClZiPt/mb7LBCxS6DDbn
	 50tBHAVf7dTfojebtVf/d1Wxr4eZ34Ay45GuB7nvbCpsVdTIyUpmsFD9b1xsO0eFtB
	 uywfknZU0/AP/CR6aLfiTBoDgK+ZavBt5oWjOdSEdDCyFlQd3cK4IFUqrH9g8Pwbzu
	 XB96KH7Q/MIV9OF6Au907oNa3ZxRW1YEGSQsmvCl2z9DrQctaOJxhSX7IcgdcSE6P0
	 1rJeJsS+xzypRKSx5sc90xnT1GbU+VLN/7eizQ7GwFLwwJgbmiEx5zbU9Rf3vI5A9y
	 pDTIuKLuIExWg==
Date: Tue, 25 Jun 2024 17:03:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Christian Benvenuti <benve@cisco.com>, Satish Kharat
 <satishkh@cisco.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] enic: add ethtool get_channel support
Message-ID: <20240625170325.77b9ddd5@kernel.org>
In-Reply-To: <20240624184900.3998084-1-jon@nutanix.com>
References: <20240624184900.3998084-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 11:49:00 -0700 Jon Kohler wrote:
> +	switch (vnic_dev_get_intr_mode(enic->vdev)) {
> +	case VNIC_DEV_INTR_MODE_MSIX:
> +		channels->max_rx = ENIC_RQ_MAX;
> +		channels->max_tx = ENIC_WQ_MAX;
> +		channels->rx_count = enic->rq_count;
> +		channels->tx_count = enic->wq_count;
> +		break;
> +	case VNIC_DEV_INTR_MODE_MSI:
> +		channels->max_rx = 1;
> +		channels->max_tx = 1;
> +		channels->rx_count = 1;
> +		channels->tx_count = 1;
> +		break;
> +	case VNIC_DEV_INTR_MODE_INTX:
> +		channels->max_combined = 1;
> +		channels->combined_count = 1;
> +	default:
> +		break;
> +	}

sorry for not responding properly to your earlier email, but I think
MSI should also be combined. What matters is whether the IRQ serves
just one of {Rx, Tx} or both.

For MSI, I see:

1 . enic_dev_init() does:
	netif_napi_add(netdev, &enic->napi[0], enic_poll);
                                               ^^^^^^^^^

2. enic_request_intr() does
	request_irq(enic->pdev->irq, enic_isr_msi, ...
                                     ^^^^^^^^^^^^

3. enic_isr_msi() does 
	napi_schedule_irqoff(&enic->napi[0]); 
thus matching the NAPI from step #1.

4. enic_poll() calls both enic_wq_service, and enic_rq_service

So it's combined, AFAICT, similar to INTX in the relevant parts.
-- 
pw-bot: cr

