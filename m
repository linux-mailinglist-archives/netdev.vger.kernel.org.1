Return-Path: <netdev+bounces-111857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC301933A76
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618C81F21E6E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E6717E8F5;
	Wed, 17 Jul 2024 09:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE917E8F0
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210162; cv=none; b=Nj6Rn2ioZeWW6NShlpaypX3PJ+eoXpMUG+ApVmUxQTX1Kgfh+4A0Ll/4JlVPF1rMg0RRzQDBiQnsf0ZlWUZQQPpuFG1bjE0Q1KURY83FhKHeN6VzE6yhASIdmWvR4crx4Vd+XOA9hyHKU7lpPMm5Ij3BNr05RmzwIV5KDz4jW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210162; c=relaxed/simple;
	bh=6Jl2PVqq+Uw9J4DbyezliVHP5oxVJ+VxUcIZQRdi0Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBIbnepCpXf3RPXz9U0lzNjvY7UKUSfeDNbc8s0Nse7kJnFXrq7r7NHFmY8b5DZizGLmXpXODvcKHTvoeH4M1wUp8mRzq/iYflz56ImcM9jgp4lJzC4/Ocj1WoKjYqcudZIF3p74pRHYzzBCwSQC0BxWK/+UfesglIVoxhpI88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aec2c.dynamic.kabel-deutschland.de [95.90.236.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F317F61E5FE06;
	Wed, 17 Jul 2024 11:55:13 +0200 (CEST)
Message-ID: <b86c8136-56cc-4a88-9ca4-3c0d7e849bd0@molgen.mpg.de>
Date: Wed, 17 Jul 2024 11:55:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 10/13] ice: add method to
 disable FDIR SWAP option
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Junfeng Guo <junfeng.guo@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-11-ahmed.zaki@intel.com>
 <b0a70c97-2a25-4dca-9db1-aca64206a53c@molgen.mpg.de>
 <e829371c-3e19-40a9-8a35-ea903f912294@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e829371c-3e19-40a9-8a35-ea903f912294@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ahmed,


Thank you for your reply.


Am 15.07.24 um 16:23 schrieb Ahmed Zaki:

> On 2024-07-10 10:59 p.m., Paul Menzel wrote:

>> Am 10.07.24 um 22:40 schrieb Ahmed Zaki:
>>> From: Junfeng Guo <junfeng.guo@intel.com>
>>>
>>> The SWAP Flag in the FDIR Programming Descriptor doesn't work properly,
>>> it is always set and cannot be unset (hardware bug).
>>
>> Please document the datasheet/errata.
> 
> Unfortunately, I don't think this is in any docs or errata.

Oh. How did you find out?

>>> Thus, add a method to effectively disable the FDIR SWAP option by
>>> setting the FDSWAP instead of FDINSET registers.
>>
>> Please paste the new debug messages.
> 
> What debug messages? If you mean the ones logged by ice_debug() in this 
> patch, please note fvw_num = 48 for the parser. So that's 96 lines of:
> 
> swap wr(%d, %d): 0x%x = 0x%08x
> inset wr(%d, %d): 0x%x = 0x%08x

Personally, I’d prefer an example line, but I know that it’s not common.

[…]


Kind regards,

Paul

