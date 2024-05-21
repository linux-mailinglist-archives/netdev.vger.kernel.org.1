Return-Path: <netdev+bounces-97291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06C8CA8AD
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFEA282182
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEC41A94;
	Tue, 21 May 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="C2pAZj5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBE179BD
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275830; cv=none; b=naQP3ipWWfLPPNoNY8PvJDv/2tVKNgekRXNSOVjck635kb0W8a8TBzCyqKyAVMWfGGllmrenquvUGadJ4Ea0QGiBKxkEhnMy9U6fyLaVbnH2gwS7wF2SpwqHPdbzb1lcQhgmm3d9Hj0JJPlIJEIKagFrlnuMWAc8NAq2w7An5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275830; c=relaxed/simple;
	bh=l7enup/cm2PIF/ABdE4cX357KBqHaHJn+NJPuIBwaSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ktjqlDjEX99Mwvaz3Z+RqTfAKy8SC/8+flmdjVuR+AKGMbbugpLZN83ygJp5YcHHYcqS6wG+nWzN5so+e0WX6OX8VdZ5hu0tMOfh+w8lFv9Hhqh9TzaHcbtJoNPrZI+hRtnNa/PECgBEqJPpLDexciP9Zi3dklKQhzK9FtBKRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=C2pAZj5G; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44L7GvA1001752
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 21 May 2024 09:16:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716275820; bh=1sZ8H9AdmPLHPXG6qkzlCzivooSwKukcmEfEXaTBGws=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=C2pAZj5G9rXyCP/EAc4UsOttqEoOGh7pysYBfBIlOnTTHvnPf9uB+qZMVDbzDWcNs
	 NP5Uzpf0o94rruOr1FrbkHgB0B1eZxB7JhLwGRLKf7CTgpoAj38A8ZCx4H8s7xRLl+
	 7UEcuNgY/fzs0P1T83DyAZsy5FIqLpk78k+hmNcY=
Message-ID: <43f55709-4234-41e3-b6c4-8a069ea7ac6a@ans.pl>
Date: Tue, 21 May 2024 00:16:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
Content-Language: en-US
In-Reply-To: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.05.2024 at 00:02, Krzysztof Olędzki wrote:
> -vladyslavt@nvidia.com (User unknown).
> 
> Hi Michal,
> 
> On 20.05.2024 at 23:55, Michal Kubecek wrote:
>> On Mon, May 20, 2024 at 11:26:56PM -0700, Krzysztof Olędzki wrote:
>>> Hi,
>>>
>>> After upgrading from 5.4-stable to 6.6-stable I noticed that modern ethtool -m stopped working with ports where I have QSFP modules installed in my CX3 / CX3-Pro cards.
>>>
>>> Git bisect identified the following patch as being responsible for the issue:
>>> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=25b64c66f58d3df0ad7272dda91c3ab06fe7a303
>>
>> Sounds like the issue that was fixed by commit 1a1dcfca4d67 ("ethtool:
>> Fix SFF-8472 transceiver module identification"). Can you try ethtool
>> version 6.7?
> 
> Yes, forgot to mention - this problem also exists in ethtool-6.7:
> 
> # ./ethtool  --version
> ethtool version 6.7
> 
> # ./ethtool --debug 3 -m eth3
> sending genetlink packet (32 bytes):
>     msg length 32 genl-ctrl
> received genetlink packet (956 bytes):
>     msg length 956 genl-ctrl
> received genetlink packet (36 bytes):
>     msg length 36 error errno=0
> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> received genetlink packet (52 bytes):
>     msg length 52 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
> received genetlink packet (36 bytes):
>     msg length 36 error errno=0
> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> received genetlink packet (176 bytes):
>     msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
> received genetlink packet (36 bytes):
>     msg length 36 error errno=0
> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> received genetlink packet (176 bytes):
>     msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
> received genetlink packet (36 bytes):
>     msg length 36 error errno=0
> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> received genetlink packet (96 bytes):
>     msg length 96 error errno=-22
> netlink error: Invalid argument

That said, DOM seems to work since 5.19 because it includes:
 https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/sfpid.c?id=fb92de62eeb1cfbb21f57d60491798df762556d3

Sorry, got confused with my git bisect.

So, we are down to the main issue - Invalid argument for QSFP.

Thanks,
 Krzysztof

