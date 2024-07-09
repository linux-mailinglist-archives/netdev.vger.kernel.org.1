Return-Path: <netdev+bounces-110224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A092B6ED
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B71F22FFD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A9158861;
	Tue,  9 Jul 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b="Rnu5JwJ+"
X-Original-To: netdev@vger.kernel.org
Received: from penfold.furryhost.com (penfold.furryhost.com [199.168.187.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55515884A
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.168.187.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523889; cv=none; b=UEzc7iiRcZQytGsomduHFTvMIta3CkLO8T2hORRo2wtjwhLKlbmtjgung/M2J1TW5HS6VLG5/q1RPxbneEvWrdUZbyE7qaobbmVIetO1Db9tpKQha3ljiWuvfFUmrrEGqqORBmztNu77Vn5OxzNy41hwyjBNtBchhEaOsmxkX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523889; c=relaxed/simple;
	bh=ZyrdfkBelmSGpV1s5iJKc4yJ7UkmpZPuKspcOgDDXXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuTuZ3m5+mTongSBjTdKRGh/ubdJIi0QuHEY/arYh+yXwwcqT4bC2q1zE8fqBHYkt6dk7E1i39EdkEkvCs9LZDV9+NM+cRzi8y4rZPE3Ietefh0p1TZkbpnA1U9KD1B4gE3IY3PeNZ99TT8rN/bpzTJMuB22M5wqwfo+215vJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org; spf=pass smtp.mailfrom=dan.merillat.org; dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b=Rnu5JwJ+; arc=none smtp.client-ip=199.168.187.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dan.merillat.org
Received: from [192.168.0.10] (syn-050-088-096-145.res.spectrum.com [50.88.96.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dan@merillat.org)
	by penfold.furryhost.com (Postfix) with ESMTPSA id 85AC421C54;
	Tue,  9 Jul 2024 07:17:56 -0400 (EDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at penfold
DKIM-Filter: OpenDKIM Filter v2.11.0 penfold.furryhost.com 85AC421C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dan.merillat.org;
	s=default; t=1720523878;
	bh=dCVqrMzF8ZvrH5dutD/nLqO8dXLOayH+lCxP7xyIijI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rnu5JwJ+8TF98STeWJFQsl8QwyhR4/I/yMmbAc05LB2wqo1gGgv5GVmM6MQ6nHsKM
	 Dfje3x6DavokJkzkiEGEPV9kLQlzfWFkF5/dTPEgFOj6UupvD/vTx9qpkh3rzvXpV7
	 pjdv5fpG10Hy8CWQTRl4BvGUTEPTtI9w4qTnmyDk=
Message-ID: <ebb67ccd-b3a1-4ffa-abec-585ee5acad84@dan.merillat.org>
Date: Tue, 9 Jul 2024 07:17:55 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4: Add support for EEPROM high pages query for
 QSFP/QSFP+/QSFP28
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Michal Kubecek <mkubecek@suse.cz>
Cc: Moshe Shemesh <moshe@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
 Dan Merillat <git@dan.merillat.org>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl> <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
 <c11f42c6-7d65-4292-840b-64f13740379c@ans.pl>
Content-Language: en-US
From: Dan Merillat <git@dan.merillat.org>
In-Reply-To: <c11f42c6-7d65-4292-840b-64f13740379c@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/24 11:41 PM, Krzysztof Olędzki wrote:
> Enable reading additional EEPROM information from high pages such as
> thresholds and alarms on QSFP/QSFP+/QSFP28 modules.
> 
> The fix is similar to a708fb7b1f8dcc7a8ed949839958cd5d812dd939 but given
> all the required logic already exists in mlx4_qsfp_eeprom_params_set()
> only s/_LEN/MAX_LEN/ is needed.
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index 619e1c3ef7f9..aca968b4dc15 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -2055,20 +2055,20 @@ static int mlx4_en_get_module_info(struct net_device *dev,
>  	switch (data[0] /* identifier */) {
>  	case MLX4_MODULE_ID_QSFP:
>  		modinfo->type = ETH_MODULE_SFF_8436;
> -		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>  		break;
>  	case MLX4_MODULE_ID_QSFP_PLUS:
>  		if (data[1] >= 0x3) { /* revision id */
>  			modinfo->type = ETH_MODULE_SFF_8636;
> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
> +			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>  		} else {
>  			modinfo->type = ETH_MODULE_SFF_8436;
> -			modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
> +			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>  		}
>  		break;
>  	case MLX4_MODULE_ID_QSFP28:
>  		modinfo->type = ETH_MODULE_SFF_8636;
> -		modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>  		break;
>  	case MLX4_MODULE_ID_SFP:
>  		modinfo->type = ETH_MODULE_SFF_8472;

Patched this into kernel 6.9.8 and I now get the alarm/warning data from this module as expected when reverting to stock ethtool 6.9.  I tested on a ConnectX3-Pro.
Thanks for the fast turnaround!

Tested-By: Dan Merillat <git@dan.merillat.org>

