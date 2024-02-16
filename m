Return-Path: <netdev+bounces-72327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A78578F7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F576283861
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73F1BC23;
	Fri, 16 Feb 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIsXTfAA"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FD182DD
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076262; cv=none; b=cYFjCf6yt99O6sEL+cakBiX4sQz5vii86Sgp7g+/J/SPnEFvJpe1VFoL0Dd4jpR71Os1ZvMfZSpV0j9ohxtRP7wq20bTGeZ11sRG2REyQiVPDjgBFmsmuQh7p6xIC/P8deLlEd7BgzeRtsCMthU4+yxZ2ndsXKL7hku/fGyRwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076262; c=relaxed/simple;
	bh=9SBN+tmhJbdnLC6ALRYHJAmObtnFdZgsOKMfi82TZV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NGkTFeEwqB4E45aHH8TW+Gkv+sSnCCRs7sY9f3TbB3Mju3PFZd+x1ka6fZGZX432ePlOBYGrb+Z+zbQosGi/0LHDpQ5tuU1jA6nlbk8B5TDf4LEgp4hcJUOJxic/TS2Ezu7PJvJqN0NW9qcQUmd9rFtqDvFgIm1hY/HSPNgRah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gIsXTfAA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=XcqCJ9o8t6ds27Dg2ztzmjXbJJ3wDtb0xZPnKcvd6PE=; b=gIsXTfAAfRgJfAyvzhp5TXTsUO
	GtNCNsjr9jNxnkLtzsJ9GifUEHdhL0+QRYlhGc2Qktz2ppsqLDs82P5G+3rFcClkgauKp0FGLH/ux
	CKVg5NpIphcF55JU+F9LN3sGHJXdF2N1zWkpL2Fgc0rPziI97o3mPu7SndbD7bQXoMRpFBeUZuFst
	L6I9TBeHt+zsWZBWScVz4nZIex6aPNreSPUVbK1pAkSIbIIKhJucGL31D2Z22zaYvcviOpabkEPpi
	fZ/FR72K9R1gLqINI+M1PaW1ti8cwn8gC0vZiIRvkqktWFb4WLNGyWtgjOOUXzAFZWmBuC5CNyFie
	6AcFG+yA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauev-0000000HQ4T-1N9Y;
	Fri, 16 Feb 2024 09:37:30 +0000
Message-ID: <0b649004-4465-404f-b873-1013bb03a42d@infradead.org>
Date: Fri, 16 Feb 2024 18:37:21 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
To: Paolo Abeni <pabeni@redhat.com>, sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 21:07, Paolo Abeni wrote:
> On Sat, 2024-02-10 at 17:15 +0900, Geoff Levand wrote:
>> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
>> 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in a
>> kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.
>>
>> This fix changes the way the napi buffer and corresponding SKB are
>> allocated and managed.
> 
> I think this is not what Jakub asked on v3.
> 
> Isn't something alike the following enough to fix the NULL ptr deref?
> 
> Thanks,
> 
> Paolo
> ---
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index d5b75af163d3..51ee6075653f 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -395,7 +395,6 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
>         descr->hw_regs.data_error = 0;
>         descr->hw_regs.payload.dev_addr = 0;
>         descr->hw_regs.payload.size = 0;
> -       descr->skb = NULL;

The reason we set the SKB pointer to NULL here is so we can
detect if an SKB has been allocated or not.  If the SKB pointer
is not NULL, then we delete it.

If we just let the SKB pointer be some random value then later
we will try to delete some random address.

-Geoff

