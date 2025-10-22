Return-Path: <netdev+bounces-231578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE391BFAD26
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5575319A04AD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E12FD7CE;
	Wed, 22 Oct 2025 08:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E81684B0;
	Wed, 22 Oct 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120649; cv=none; b=gS9Oex501uwWINbKbBdPkG39nb0ABCGgMZPUkX7+R1VP2ehxWZoy/Z8z+lTcOgWTAIvnvwVVrs1fL7tEOyjjFw3zIVSp0pJXOh+awHgLuKwb2KrYRV5Rr3JcZTzLyHO7re3VnToaitIYNfbPeOt1IcK70TsPRnqAF7i+ON3K5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120649; c=relaxed/simple;
	bh=stqOx4m9vFLsGbyVhAdnxZb+Jc7vK7BpKLYzESDs1xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTKoQUwZ6Ud2CnzJgkoNEooxZftShaimwWTIwET22v8pFPZl6Aqg5uBlI5PyDeJOP92Q+hWTA57x15zFokSzPC8YGS6VuviKgaw6WsF9KMRnp9YH25W5aRpo1ZGzqcS7Iv8/sA2lKYt7KAOpd9zzhXirgHtG5rukYqzL5tUNwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.85.109])
	by APP-01 (Coremail) with SMTP id qwCowABHoaNlkfhoW8rMEw--.47485S2;
	Wed, 22 Oct 2025 16:10:14 +0800 (CST)
Message-ID: <d66db3f6-4c6f-4dc3-ae4f-3502d9b81c79@iscas.ac.cn>
Date: Wed, 22 Oct 2025 16:10:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: spacemit: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aPd0YjO-oP60Lgvj@kspp>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aPd0YjO-oP60Lgvj@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowABHoaNlkfhoW8rMEw--.47485S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw17trW3ArWkur1xJr4Dtwb_yoW8tr1kpa
	y8J3s7Ar4kJrWxW3ZrAayxZay5K3y8tFZ8GryFyan5ZFnFyF45CF1FkF4rCryqk3yxGryS
	vrs0yw1UA3Wvq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Gustavo,

Thanks for the patch.

On 10/21/25 19:54, Gustavo A. R. Silva wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Use regular arrays instead of flexible-array members (they're not
> really needed in this case) in a couple of unions, and fix the
> following warnings:
>
>       1 drivers/net/ethernet/spacemit/k1_emac.c:122:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:122:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:121:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>       1 drivers/net/ethernet/spacemit/k1_emac.c:121:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/spacemit/k1_emac.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.h b/drivers/net/ethernet/spacemit/k1_emac.h
> index 5a09e946a276..577efe66573e 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.h
> +++ b/drivers/net/ethernet/spacemit/k1_emac.h
> @@ -363,7 +363,7 @@ struct emac_desc {
>  /* Keep stats in this order, index used for accessing hardware */
>  
>  union emac_hw_tx_stats {
> -	struct {
> +	struct individual_tx_stats {
>  		u64 tx_ok_pkts;
>  		u64 tx_total_pkts;
>  		u64 tx_ok_bytes;
> @@ -378,11 +378,11 @@ union emac_hw_tx_stats {
>  		u64 tx_pause_pkts;
>  	} stats;
>  
> -	DECLARE_FLEX_ARRAY(u64, array);
> +	u64 array[sizeof(struct individual_tx_stats) / sizeof(u64)];

I originally wrote it as DECLARE_FLEX_ARRAY to avoid having to do the
sizeof dance, but I guess that's no good now? Oh well, I guess...

Acked-by: Vivian Wang <wangruikang@iscas.ac.cn>


