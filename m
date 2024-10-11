Return-Path: <netdev+bounces-134700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B099AE03
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF371C21C04
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2D1D0E11;
	Fri, 11 Oct 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="KXqU8AW0"
X-Original-To: netdev@vger.kernel.org
Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E110A1F;
	Fri, 11 Oct 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681791; cv=none; b=A0+sTqZf4xt+pylDlhWFHZwZWKBS89Wq0lpyyQmMlsM8n+GP6BnYrxns3oNADiPFpxmEsyvdGlmijWD5fZPJKeaIs5bH3GnvCiCBYEBAs+X3dM1OlKlt43TqXX9r7pa0xbKsVEpqioixXpm+aV1Xp7WFddYWUpV/PW91b3I/1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681791; c=relaxed/simple;
	bh=Kzr+1j2jiRTkuHD2Vy3riLZeOdp3FVIGM8hGxo9knAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfsixW5+oyQeYSUyekjkBnccV7mLySKs41kjZmdacoLgipu9vkGqtvORFMyPAi5OuLyw0jnC5Rl11Ppaxuje1u3Qk4aWFwkl12Pa5GFIa1EsI3wix2j1Z5JEkIYanbsq52j0q86/+vc4GG1HfW2+Bqx5HfTIne07mf1dnqlx2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=KXqU8AW0; arc=none smtp.client-ip=81.19.149.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BlIxkFNt40zV8S1I5DKAHrqkRbnuLWx/s0mHo7zcF1I=; b=KXqU8AW0o1qXPs33iN6nsO8RNt
	3XDC2BJrdwzR52cgMrBKlsXZDXj6ms6QzjDuWEg99D2VdNKbrHWKoII4bSUdzS/RSudLNqdn/Rdq3
	lt7v6M3cfMrpPYgbmrNKm7AwSQSm9ANkqHewjHBeBihAalXbqMzCMzlKiUNxix19Yr8w=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx13lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szMS4-0000000087x-34zQ;
	Fri, 11 Oct 2024 22:41:32 +0200
Message-ID: <3d26ab3e-2a3c-4c36-b165-06a1029bb0b0@engleder-embedded.com>
Date: Fri, 11 Oct 2024 22:41:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: aeroflex: fix potential memory leak in
 greth_start_xmit_gbit()
Content-Language: en-US
To: Wang Hai <wanghai38@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas@gaisler.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, kristoffer@gaisler.com
References: <20241011113908.43966-1-wanghai38@huawei.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241011113908.43966-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 11.10.24 13:39, Wang Hai wrote:
> The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   drivers/net/ethernet/aeroflex/greth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
> index 27af7746d645..8f6835a710b9 100644
> --- a/drivers/net/ethernet/aeroflex/greth.c
> +++ b/drivers/net/ethernet/aeroflex/greth.c
> @@ -484,6 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
>   
>   	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
>   		dev->stats.tx_errors++;
> +		dev_kfree_skb(skb);
>   		goto out;

dev_kfree_skb(skb) is already part of the error handling, one line above
the "out" label. Why don't you just add another label which includes
dev_kfree_skb(skb) and goto that label?

Gerhard

