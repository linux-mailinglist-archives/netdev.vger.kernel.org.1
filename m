Return-Path: <netdev+bounces-255712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB0mBUpAgGlJ5QIAu9opvQ
	(envelope-from <netdev+bounces-255712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:12:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799DC88BA
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE693013257
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FD2EC55D;
	Mon,  2 Feb 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ElddkWlA";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ElddkWlA"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA872F39C2;
	Mon,  2 Feb 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012521; cv=none; b=HzhxnafLi6ctLnJse+d+C7y3NgATm9mt3kLYJS6GcG7PsJo88MB9ygW6cV66F70oyZ+blm7j3YOhQnrD9l4WLGCbr5pk6gwZx4WwnybUoQ9PTEOUZISHFudmzolUbL8Bn+SAszKNb23JrNFp65Frf/1bvH5ElcMmXdFEEkcKXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012521; c=relaxed/simple;
	bh=NP83Mrx8rYcsBCY8LlCywG/yUYtq6xzxTDwrSpDCBoY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HfD2CL3EAMu3Xq5d7V4zDSQ618XR3Kx5ieMl5o5XWTtopAojAZxvbldiUa40vAHl7tZKRaFo+xoGqzL05MwwGGZ0PcS/Sz2/YULHIp7j9Epcs7Gmt8d+QXCJkkTN4cIzNBN8dcqGV3vw2yihqHPwWhLTEbfQ8fxpSXsmhcIXnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ElddkWlA; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ElddkWlA; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/iryNe5hnuOUFOYtYd8KoNt809qBXVrbUTYPorRWmDU=;
	b=ElddkWlAZcPEr4B3GK5sGPsPp6N7nGHSzwok3ozJjgdR2TvcNnM7kG+cDVmjwHYCyAQ/FazzW
	Pz99O2PkO1q9jyaGTCI+dtucVgrDNj7QIw57u+0oz1pbeNgytIge7OhIcdOrkMffdRE7EDs0+fy
	NlmBs9ANZU5x2HNu/YbhVaE=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f4GPJ47b3z1BG6b;
	Mon,  2 Feb 2026 14:07:48 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/iryNe5hnuOUFOYtYd8KoNt809qBXVrbUTYPorRWmDU=;
	b=ElddkWlAZcPEr4B3GK5sGPsPp6N7nGHSzwok3ozJjgdR2TvcNnM7kG+cDVmjwHYCyAQ/FazzW
	Pz99O2PkO1q9jyaGTCI+dtucVgrDNj7QIw57u+0oz1pbeNgytIge7OhIcdOrkMffdRE7EDs0+fy
	NlmBs9ANZU5x2HNu/YbhVaE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f4GJv0RLwz1T4JN;
	Mon,  2 Feb 2026 14:03:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AAE5201EE;
	Mon,  2 Feb 2026 14:08:18 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Feb 2026 14:08:17 +0800
Message-ID: <4e6e11ef-842b-4e09-a46e-3d3017fff9ac@huawei.com>
Date: Mon, 2 Feb 2026 14:08:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Check return value
 of devm_gpiod_get_optional() in adin1110_check_spi()
To: Chen Ni <nichen@iscas.ac.cn>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kuniyu@google.com>, <nicolas.dichtel@6wind.com>,
	<alexandru.tachici@analog.com>
References: <20260202040228.4129097-1-nichen@iscas.ac.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260202040228.4129097-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255712-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6799DC88BA
X-Rspamd-Action: no action


on 2026/2/2 12:02, Chen Ni wrote:
> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
>
> Add an IS_ERR() check after the call in adin1110_check_spi(). On error,
> return the error code to ensure proper failure handling rather than
> proceeding with invalid pointers.
>
> Fixes: 36934cac7aaf ("net: ethernet: adi: adin1110: add reset GPIO")

This patch is a bugfix, so it should be sent to net, not net-next.

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/net/ethernet/adi/adin1110.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 30f9d271e595..71a2397edf2b 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -1089,6 +1089,9 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
>   
>   	reset_gpio = devm_gpiod_get_optional(&priv->spidev->dev, "reset",
>   					     GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(&priv->spidev->dev, PTR_ERR(reset_gpio),
> +				     "failed to get reset gpio\n");
>   	if (reset_gpio) {
>   		/* MISO pin is used for internal configuration, can't have
>   		 * anyone else disturbing the SDO line.

