Return-Path: <netdev+bounces-293042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL53ApJGGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:56:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723F5FEDE4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EBD4300BB8E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FE3A1CEA;
	Fri, 29 May 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G8066M4i"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54830DEA3;
	Fri, 29 May 2026 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041359; cv=none; b=DsKrrSI/q/YS2Cn2In/s0EoeQH+JXg80YfHr7pOeMELemuZcjbWduB9YF5BAfRTXDw5TCE0it830CjxvZ2mZaEDVIsNEMfZwMdlhMsNfoytJn53KmEJnVFycknQBPFxmXe/WQP+AHKSw7h+Hj93EnOQ5WYdelQQaPIebXquEdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041359; c=relaxed/simple;
	bh=s7rBfkPDdKzOOjEwmygW9txy+qDikWsLkUZ1fZeb4bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA+vHiV1gPiOXEi+z0EAtOuTEmpH4ZwL2OTRe5YRIq8KmqM57nKtBuRuaPMLnZnLAmM3grTiB2XaIMVyBbB6Z2BHpUXByCzYb5G7wwrfEYI591z1Sod1YNs9bJfd7FMNWvHC5oIW2bLmcfZPEGIKGlabJQYVfYP0BOurEYqU8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G8066M4i; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ONo6W1WTRgNUMUmWMkWfHOb9s/IIAVVhR7/v7zhnxpA=; b=G8066M4i93lV3l2/6ONawaSFxW
	mrqxMXcmqLMfA7Q96uBq2i1fLXiOL8XnmGErcklUWk1RO8rx6et7nKKJfJ0tvQSjKjIFfNyb4/XN9
	qXY+Gamef4qNcydmVO1MHZtkEJOkg+CKswpbUD9SJxHTcOfJHGGNtKZHxgoh112XAU9Ld6t3iufsk
	o/lWRWxCIE0giWmjV9LM0FH9US+CVDTkrY/Q7uHsaVycUYxbTt8ZQLN874beanZrWhk2JG4RNZiAO
	5Fp3iBKpd+fcapvaQ0QosdX7G9B1uTTqEF/qPYdP3gqHuZGGxJ9bFpjgVagVyCo2uy4RnfaTks1H5
	fSqta0qg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSs4Q-0007Yo-0g;
	Fri, 29 May 2026 09:55:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSs4U-000P0e-2I;
	Fri, 29 May 2026 09:55:58 +0200
Message-ID: <8b91c5f1-f425-488d-8e7c-8dba4fb3187b@iogearbox.net>
Date: Fri, 29 May 2026 09:55:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux: DMA-after-unmap race in ZCRX via
 netif_rxq_cleanup_unlease() ordering inversion (netkit + page_pool)
To: =?UTF-8?Q?Pr=C3=A9nom=3F_Ahmed?= <ahmedabdelmoumen05@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Wei <dw@davidwei.uk>
References: <CAN+TWHTGkGZu4vdbkMY8F-EDe3m8ScBctW-fdtfcpGbj192SyA@mail.gmail.com>
 <20260527163320.407b4af1@kernel.org>
 <14ca7b06-55bd-497d-b1ef-bcb95d1fe2ca@iogearbox.net>
 <CAN+TWHTBQ=e84jN83H14jjVY-7p83Cbb4Tjw6mEd9Zen90E=Gg@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAN+TWHTBQ=e84jN83H14jjVY-7p83Cbb4Tjw6mEd9Zen90E=Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293042-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9723F5FEDE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 2:56 AM, Prénom? Ahmed wrote:
> Hi Jakub,
> 
> The patch looks correct, the reordering and stack copy approach makes sense.
> 
> One thing I forgot to mention in my original report: I did trace the teardown path at runtime via ftrace/kprobes and confirmed the race window opens. I was not able to win it though — no actual DMA write was triggered, so exploitability remains hardware dependent.
> 
> Could you please add a Reported-by tag in the final commit :)?
> 
>    Reported-by: Ahmed Abdelmoemen <ahmedabdelmoumen05@gmail.com <mailto:ahmedabdelmoumen05@gmail.com>>

Yeap, will add the Reported-by, thanks!

> On Thu, May 28, 2026, 23:28 Daniel Borkmann <daniel@iogearbox.net <mailto:daniel@iogearbox.net>> wrote:
> 
>     Hi Ahmed,
> 
>     On 5/28/26 1:33 AM, Jakub Kicinski wrote:
>      > Dropping security lists, security lists are for private discussions,
>      > it's utterly pointless to CC both them and LKML. Not to mention
>      > that this bug only exists in -rc kernels.
>      >
>      > Adding relevant developers. Moving security@ to Bcc
> 
>     Thanks for the report! I think a fix could look as below. Before submitting,
>     I would prefer though if David could check this against real HW supporting
>     mem providers e.g. BCM NIC:
> 
>     diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>     index de4dac4c88b3..00a7011eb4d5 100644
>     --- a/net/core/netdev_rx_queue.c
>     +++ b/net/core/netdev_rx_queue.c
>     @@ -338,12 +338,12 @@ void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
>        void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
>                                     struct netdev_rx_queue *virt_rxq)
>        {
>     -       struct pp_memory_provider_params *p = &phys_rxq->mp_params;
>              unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
>     +       struct pp_memory_provider_params p = phys_rxq->mp_params;
> 
>     -       if (!p->mp_ops)
>     +       if (!p.mp_ops)
>                      return;
> 
>     -       __netif_mp_uninstall_rxq(virt_rxq, p);
>     -       __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
>     +       __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
>     +       __netif_mp_uninstall_rxq(virt_rxq, &p);
>        }
> 
>      > On Wed, 27 May 2026 23:53:45 +0100 Prénom? Ahmed wrote:
>      >> Hello,
>      >>
>      >> I would like to report a source-proven teardown ordering bug in the Linux
>      >> kernel that can lead to a DMA-after-unmap race condition involving ZCRX
>      >> (io_uring zero-copy receive), page_pool, and netkit queue leasing.
>      >>
>      >> ***Reporter:** Ahmed Abdelmoemen **Discovery Date:** 2026-05-26 **Kernel
>      >> Version:** Linux 7.1.0-rc3*
>      >>
>      >> Executive Summary
>      >>
>      >> *A logic error in `netif_rxq_cleanup_unlease()` causes DMA mappings for the
>      >> ZCRX memory provider to be revoked **before** the physical NIC RX queue is
>      >> stopped. This creates a race window during netkit queue lease teardown
>      >> where the physical device's NAPI can consume stale `net_iov` entries from
>      >> the page_pool alloc cache containing `dma_addr = 0`.*
>      >>
>      >> The ordering inversion is fully proven at the source level. However, I have
>      >> **not** performed runtime verification, so actual memory corruption or
>      >> successful DMA to address 0 has **not** been proven — it remains hardware
>      >> and driver dependent.
>      >>
>      >> The bug is reachable with `CAP_NET_ADMIN` (common in container
>      >> environments) when using netkit with ZCRX.
>      >>
>      >> Root Cause
>      >>
>      >> In `net/core/netdev_rx_queue.c:347-348`:
>      >>
>      >> ```c __netif_mp_uninstall_rxq(virt_rxq, p); // DMA unmap + dma_addr=0
>      >> __netif_mp_close_rxq(...); // queue stop + NAPI disable (TOO LATE)
>      >>
>      >> This inverts the correct ordering used in normal device unregistration and
>      >> io_uring close paths (stop first, then unmap).
>      >> Impact
>      >>
>      >>     - *Potential:* NIC DMA write to physical address 0 (or stale mappings
>      >>     with lazy IOMMU) leading to memory corruption.
>      >>     - *Requirements:* CAP_NET_ADMIN + netkit queue leasing + ZCRX installed
>      >>     on the leased queue.
>      >>     - *Current Status:* No runtime PoC or crash reproduction yet. The race
>      >>     window exists in theory but its practical exploitability needs confirmation.
>      >>
>      >> I am attaching the full detailed analysis.
>      >> Proposed Fix[image: image.png]
>      >>
>      >> I am happy to provide more details or assist with testing.
> 


