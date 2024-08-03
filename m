Return-Path: <netdev+bounces-115486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F62946909
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDC21F216F2
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E131136320;
	Sat,  3 Aug 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UY9Mfeka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A14A2F;
	Sat,  3 Aug 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722680606; cv=none; b=eaLp8lhK0zxBfz1Z3FzddW+/wNRxKWVzTI62yfNv/fWmCGDgedqiaUX6NyZH+FJ/P2cKzcm2zZJuMnqsiK4KZDv2D6+VDbrfuPWjp8akPkRvfYiJFCmytR5hELAbGovToTXbJzpB/NkqIJL0sz1jbfF9H9H2T3M1uvMd46C79jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722680606; c=relaxed/simple;
	bh=F+Kwu+SL10Y+c1ALb7LvkbBlS65JjCffGIIlE1iRefY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9Z9jgW/kDvlSfrppu/gu1rER/Bvev3xloVsbIc6RGj6kg+nMvzafVEjfmvcNayo1OvlsumcohMDTwOtykkOtWlE/VtDkvGBBeS6zz1UvKaVbnC7t1Ds+gXL3I9sNwYb8KQUEv/ctwc2WlJxbTTXbuq2yWVe1LmeeKNXG3aWp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UY9Mfeka; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id aBthsTd1khajuaBthsjhx3; Sat, 03 Aug 2024 12:22:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722680526;
	bh=4MAfltrielFugt99roLwuy2ODnKgMwhqZafIG9rnCs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UY9Mfeka4XdaFLIk3XMaNqBrVaBs2WUcuCgU5wWXCWHFlfubaF1syagdIgGg6JvUu
	 TD8lZxEU6THuz8wC2B+B+1nrubiUdzSWvwy1lTVlPUTbdgC2GQ7x1yh/qMxeofsiYZ
	 2fu8cSwXoKf2k9kSLwRn0eU6wcGoHQsEgB3rCF9umrf692/WCq7iSutXVVxOON/I7i
	 /1vHFY6mHDgWO17Iu7qnGEDYMWUBqIBtUl//aHYiHhBH/+uBfsx0HOh1/KA36UFQgH
	 X7QubtPnRHH/oLFgu/QJXg75NnZHiX5eobUDwjVd4gQaa1TvPUaKYeqtsjNN6CRDo3
	 dnl+3RL1vt8dA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 03 Aug 2024 12:22:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <d00b1a28-24ae-4487-8a8a-b08a84a4ce4a@wanadoo.fr>
Date: Sat, 3 Aug 2024 12:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ethernet: remove unnecessary parentheses
To: Moon Yeounsu <yyyynoom@gmail.com>, cooldavid@cooldavid.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
References: <20240802054421.5428-1-yyyynoom@gmail.com>
 <20240803022949.28229-1-yyyynoom@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240803022949.28229-1-yyyynoom@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

this is not how things work.
This v2 depends on the previous v1. It shouldn't.

v2 should be a standalone patch which includes v1 and all modifications 
done afterward.


When you send a new patch you should:
   - give an history of changes, below the ---. See [1]
   - eventually give links to previous version
   - your new version should not be threaded with the previous mails. It 
should start a new thread.


Le 03/08/2024 à 04:29, Moon Yeounsu a écrit :
> remove unnecessary parentheses surrounding `ip_hdrlen()`,
> And keep it under 80 columns long to follow the kernel coding style.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---

[1]: here.

*As an example*, I would have done as follow, but there is no rule 
(AFAIK) for this section.


Changes in v2:
   - Remove extra ()   [Christophe Jaillet, Simon Horman]
   - Break long lines   [Simon Horman]

v1: https://lore.kernel.org/all/20240802054421.5428-1-yyyynoom@gmail.com/

>   drivers/net/ethernet/jme.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index 83b185c995df..d8be0e4dcb07 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -947,12 +947,12 @@ jme_udpsum(struct sk_buff *skb)
>   		return csum;
>   	skb_set_network_header(skb, ETH_HLEN);
>   
> -	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
> -	    (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udphdr)))) {
> +	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
> +	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
>   		skb_reset_network_header(skb);
>   		return csum;
>   	}
> -	skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));
> +	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
>   	csum = udp_hdr(skb)->check;
>   	skb_reset_transport_header(skb);
>   	skb_reset_network_header(skb);



