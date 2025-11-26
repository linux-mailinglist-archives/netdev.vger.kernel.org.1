Return-Path: <netdev+bounces-241946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7971C8AF41
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C189342D0E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1CC334C17;
	Wed, 26 Nov 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ocimodRH"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE511CA0;
	Wed, 26 Nov 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174316; cv=none; b=jfPCr9qwUZMsD0RPeE4GqqS/hwIty8URIdhd+C/N22UDTptz92/qdw8p6qDFrAS+CNY5vZxdjqM9K3BYe956NeGjnyJc2BeBtiYaPkJfTMeJni1rVVosU76rNzUvkzPjUW/dUySz2rQ6kjg//ek8ObMtAUySmmkkkGinPoft3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174316; c=relaxed/simple;
	bh=6k7MnpvhjMy0j2w++nTmQoLb1I+56/qQVTSIy42f29M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po1zhsMD4AIxLNxTbjpitlFTJ38OGGaTqDd/fs4Owxw9uLUvk7Z+J42DQcZDAOnqHe8goFCdvxtRyS8I8knkBN6NoEyhrM6KKJpuL3LqtS4eNAV8Iwa3Fr46drCBMGIVbNmFabS5uGt50WLK737FFMvb9HinWT4pRA31sPWKA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ocimodRH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764174310;
	bh=6k7MnpvhjMy0j2w++nTmQoLb1I+56/qQVTSIy42f29M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocimodRHm+nR5qWCMQk/b1Pgc+lkIPuZUQSjHdCVIoxOJWTxAicBKFO4BLe4/R7Z1
	 uLxhs3XcSh//sq5B32CZSyV39ohB6fAkbz7QkJXUgCR1qL++SuxtS3i6APq+VMaz5m
	 uKG3uZbdbuqXfT+qQYapDFuvxO96c0zULgsqZHcqGwN9wlrWCKVe61gdi9KNyFSnda
	 uhc6rxlnvJMPfNHvsTyKuHkQwPTIig4slaR1c+FMKAydDGM2v/WxiXEANfgIShOg2V
	 Xo2J/IEBULFXM755VMibFvrDPVtZjUgjOJYbfSI8INGszq+FAdk0ZTSMoJFqXbePKC
	 xGjx+h6qST7sQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8923E600FF;
	Wed, 26 Nov 2025 16:25:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id A12042010CE;
	Wed, 26 Nov 2025 16:24:43 +0000 (UTC)
Message-ID: <66b74e25-dfbf-4542-9067-cc38b56dbf6e@fiberby.net>
Date: Wed, 26 Nov 2025 16:24:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/11] wireguard: netlink: enable strict
 genetlink validation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-4-ast@fiberby.net>
 <CAHmME9pYvUZ8b9dzWi-XBk9N6A04MzSLELgnBezHUF7FHz-maA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAHmME9pYvUZ8b9dzWi-XBk9N6A04MzSLELgnBezHUF7FHz-maA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 5:10 PM, Jason A. Donenfeld wrote:
> On Wed, Nov 5, 2025 at 7:32 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>>   static struct genl_family genl_family __ro_after_init = {
>>          .ops = genl_ops,
>>          .n_ops = ARRAY_SIZE(genl_ops),
>> -       .resv_start_op = WG_CMD_SET_DEVICE + 1,
>>          .name = WG_GENL_NAME,
>>          .version = WG_GENL_VERSION,
>>          .maxattr = WGDEVICE_A_MAX,
> 
> This patch is fine and standalone enough, that I merged it into my
> wireguard.git devel branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?h=devel&id=fbd8c752a8e3d00341fa7754d6e45e60d6b45490
> 
> If you wind up rerolling the rest of these, you can do it against that branch.

If you update it, so it includes the 2 new net-next commits, then
I can send v4 based on your tree.

- [net-next,1/2] tools: ynl-gen: add function prefix argument
   https://git.kernel.org/netdev/net-next/c/17fa6ee35bd4
- [net-next,2/2] tools: ynl-gen: add regeneration comment
   https://git.kernel.org/netdev/net-next/c/68e83f347266

Thanks.

