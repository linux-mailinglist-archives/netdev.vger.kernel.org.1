Return-Path: <netdev+bounces-256162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cwNjFM6bgWlwHwMAu9opvQ
	(envelope-from <netdev+bounces-256162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:55:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AD7D57BB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3AC6300E3E9
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632338F22A;
	Tue,  3 Feb 2026 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPEump0q"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A938E5EF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101704; cv=none; b=nVMq5KCGHDm55XwO0Lv+7znPpVYlGo9TnO44QjotPDPMI9+XvgTB95/n79yiLXV8FjuveZuKeRkXaovFvdyj7UzfDYH3t/YOJBTaFXg4k9S//Cv0Gurzl5pc/MsEOeNNgze7phOoelU7whAUGKIuN9IAYZLWYHCwl65GsYE9dPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101704; c=relaxed/simple;
	bh=rt4J2HSJOQac4JL9n12/LB/EK4Cgv84ZVmxnuT4P/bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQa59XX41Nj8J9bJovJSVrCIb5g48vnPxw795s5hThYk0dS/PrZ1mFnZMJNG8KiSWfBJGQbhm58MQcQSeb0PiJb/fcTCtrTtnbqpJ9g7vrfN+/wnWH8prt3j1WaaxaDlJ5JEsj3Ug/3V7Eso5RycGsYKWgN7qzigJ2F78gm90Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPEump0q; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f8af642-c4cc-4cfc-8da4-f84b3de1bfb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770101698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE4TICDbhXZ2WMzS4B0oQXtwTQVeobPeJAfv1TDr1rY=;
	b=lPEump0qgAqNN+FjRnuxWQ/VSgrWbQJKXHrFP2YV4WREZD9+mUUZX6if9IsAbpEAKvUADo
	hJgilba+4woPGbjRG52R/Tl6F6XbHgtzlw4R6NrjdYx9ayl6FemWOyfmIKduVzP9giOL3u
	q/WNCBzNRn34o+T6Rvq4ai9DAmuXe1o=
Date: Tue, 3 Feb 2026 14:54:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 net-next] net: stmmac: Fix typo from clk_scr_i to
 clk_csr_i
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260203062658.2156653-1-chenhuacai@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20260203062658.2156653-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256162-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[si.yanteng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: B1AD7D57BB
X-Rspamd-Action: no action


在 2026/2/3 14:26, Huacai Chen 写道:
> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> so correct the typo.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>


Thanks,

Yanteng

> ---
> V2: Update subject line and remove "Cc stable".
>
>   include/linux/stmmac.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index f1054b9c2d8a..1ba583ef6e03 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -28,14 +28,14 @@
>    * This could also be configured at run time using CPU freq framework. */
>   
>   /* MDC Clock Selection define*/
> -#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_scr_i/42 */
> -#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_scr_i/62 */
> -#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_scr_i/16 */
> -#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
> -#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
> -#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/124 */
> -#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_scr_i/204 */
> -#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_scr_i/324 */
> +#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_csr_i/42 */
> +#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_csr_i/62 */
> +#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_csr_i/16 */
> +#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_csr_i/26 */
> +#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_csr_i/102 */
> +#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_csr_i/124 */
> +#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_csr_i/204 */
> +#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_csr_i/324 */
>   
>   /* MTL algorithms identifiers */
>   #define MTL_TX_ALGORITHM_WRR	0x0

