Return-Path: <netdev+bounces-282408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AaDAKkQ8mmPngEAu9opvQ
	(envelope-from <netdev+bounces-282408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:07:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF84955A1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 970803012B7B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35773FD156;
	Wed, 29 Apr 2026 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F9cBAumq"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5B2C0F6C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471596; cv=none; b=Vlmy23O/bWuvlnq87BqYSWhVY/nj4fJcB4F/sX/4ndG/nfyTK8Ymd/S4FmHI83sdrazJq1Hwfk1wsTP+lkBxQJAPDQijve+dc/iScVFkVE+aNqtweR4Cz9SQdbxoXAAL/N+uOb13Uo2QYhxGKU74Ov2lTE2wa9aPvs6s0BWRf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471596; c=relaxed/simple;
	bh=g4dtEnTn0w/uJVBOgmevsbtgS2MVvr19usk0nivCslg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj19ZiLSA9xKlpWFODkB9mtQC8udMpGjsg86QWX0KzKW5dizreYj+SpIdgTq+1G6BVloVEjdCc8CLGkdEOOzDQIQjPXuVtY9fcNiT2bxqBrN6toovnWzydSF3f8OYJKqwOSvEEoopu47l657KDzJEoiwSmzM5gpAdrP7vFZLtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F9cBAumq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c79d5d31-0760-41a0-9c41-d352a89130d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777471591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75cz/Kctrd6xesfAys7gou8LwEaswlPyIeM4/Jo2ySI=;
	b=F9cBAumqm2IihbtJ5WL9DZzDD4KTQXbw4GXq4T3ZLU9LDT2GS/TZDWc5Zz/xmIHv8qFKBd
	5o+6ptoPsFf7XkApgsV7ZeTbs1KD6gdMzCzVIDQmmXvNC24dE5WRqxN+zdu1MbQCnBFMNY
	12ajiWLwp7ycy3thgMB6zWG3RQeDBUQ=
Date: Wed, 29 Apr 2026 15:06:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch net-next v2 1/8] r8169: add some register definitions
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
 <20260429070750.1477-2-javen_xu@realsil.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260429070750.1477-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AFDF84955A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282408-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

On 29/04/2026 08:07, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support rss, this patch adds some macro definitions and register
> definitions.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> changes in v2:
>   - modify the name, avoid using camel names
>   - change the name more reasonable, global
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 58 +++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..4f56f8b420fe 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,21 @@
>   #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>   #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>   #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_RX_QUEUES	8
> +#define R8127_MAX_IRQ		32
> +#define R8127_MIN_IRQ		30
> +#define RTL_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_OFFSET	16
> +#define RSS_MASK_BITS_OFFSET	8
> +#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_RSS_UDP BIT(27)
> +#define RXS_RSS_IPV4 BIT(28)
> +#define RXS_RSS_IPV6 BIT(29)
> +#define RXS_RSS_TCP BIT(30)
> +#define RXS_RSS_L3_TYPE_MASK (RXS_RSS_IPV4 | RXS_RSS_IPV6)
> +#define RXS_RSS_L4_TYPE_MASK (RXS_RSS_TCP | RXS_RSS_UDP)

You introduce these defines without actual user in patch, all users are
in subsequent patches. It's a bit harder to review, easier way would be
to introduce defines together with users.



