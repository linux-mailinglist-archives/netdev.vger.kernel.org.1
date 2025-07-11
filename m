Return-Path: <netdev+bounces-206133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB0B01B27
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85913A6B54
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7F28A41E;
	Fri, 11 Jul 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjMvsd5p"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BE230BE1
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234354; cv=none; b=YfJ2EbUgwJVFzS2/xTUaCF8qaaY6RKcJGPQBvgOfkoz4d2dDqD7gOF0j/gn3HI7/aK174MkOnEJOE8ECEowLYc1fAb45NHvsHcHVl/UItYQqU2XmTBbz+KFN+hKEN0+Q5j9Ipa6xMm8f7SeKF1ExgqqSDnlcs31MR0x3y3BrccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234354; c=relaxed/simple;
	bh=XHheDxPdzE/NJEGsbPcyVNbfVHS4B1K+I4eGE6HOa+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVjEKIc9S1b83/WNMIE+T1q8H55qxBkrpYtOtKJyjGl4N+sn1MMrjMCAx0Eg3SkPob5OV9SqrGKEaLSpfjl47xadQD2nvopYTFfJAoKzhCkrZANrOK3VXlQDCZ3B9wasaNmiCtS+pQC7U3a/ZjyOzVDL44OnFND2T6DbwSa1T0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XjMvsd5p; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc023486-5491-4795-8b07-4808e44c8ebb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752234349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dP9rqKLiGiZntdJQkX4TyBuHFuSn+tzdIeB2/uFcYE=;
	b=XjMvsd5puLKsCpHgClimdEfBr5zl4lr+RgFVzCxLgugef7Lg/ncvUeg24Q8N9VMD9brri/
	JC+QoglBJqKw/iejOr9mUYKvpADyEaQmqDmzZqKdi3YQx9aJfqda/3uRarYhnff5wEWzzd
	HTacpR45P6Pw4anRTZEUJ+AbWzh77aU=
Date: Fri, 11 Jul 2025 12:45:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexander Duyck <alexanderduyck@fb.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/07/2025 12:28, Xuan Zhuo wrote:
> +/* notify */
> +bool ering_kick(struct ering *ering)
> +{
> +	union {
> +		u64 data;
> +		struct db db;
> +	} val;
> +
> +	val.db.kick_flags = EEA_IDX_PRESENT;
> +	val.db.idx = cpu_to_le16(ering->sq.hw_idx);
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +
> +	return true;
> +}
> +

[...]

> +static inline bool ering_irq_unactive(struct ering *ering)
> +{
> +	union {
> +		u64 data;
> +		struct db db;
> +	} val;
> +
> +	if (ering->mask == EEA_IRQ_MASK)
> +		return true;
> +
> +	ering->mask = EEA_IRQ_MASK;
> +
> +	val.db.kick_flags = EEA_IRQ_MASK;
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +
> +	return true;
> +}
> +
> +static inline bool ering_irq_active(struct ering *ering, struct ering *tx_ering)
> +{
> +	union {
> +		u64 data;
> +		struct db db;
> +	} val;
> +
> +	if (ering->mask == EEA_IRQ_UNMASK)
> +		return true;
> +
> +	ering->mask = EEA_IRQ_UNMASK;
> +
> +	val.db.kick_flags = EEA_IRQ_UNMASK;
> +
> +	val.db.tx_cq_head = cpu_to_le16(tx_ering->cq.hw_idx);
> +	val.db.rx_cq_head = cpu_to_le16(ering->cq.hw_idx);
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +
> +	return true;
> +}

in addition to Andrew's comments, these union { ... } val will have
partial garbage values, which will later be directly sent to FW. I
believe it may cause some troubles and it's better to initialize val
before actually use it.



