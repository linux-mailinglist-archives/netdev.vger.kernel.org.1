Return-Path: <netdev+bounces-114611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4E94318C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA021C216C1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99BC1B29CF;
	Wed, 31 Jul 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="XfOOvz9e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC61B3722
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434306; cv=none; b=QvFDgbNmRpxFLkdPiuodkhCJxPbv8C+7kWg1gM2XlXm/p8a41ydSoxnLe2ETDGz5jvovKnzj+RPsARMuHnpB/1ojm3TdY9b/abNWMaMELcCJzDBGyVzyuqUd6rx1P5WjqrE/nmLi4qXeYQR1b1FFnONTwkvQUA2//wJ2+T9WqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434306; c=relaxed/simple;
	bh=SFHDiXbJmmEdBAn1941CUhLA3q6xQPQOxYlXvjswBpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXjPkMynKraHhxRr/RDYwY653P87hUtYHc/ikpu8R+9hXKfpTEh7pg8L14bCTKmNuiET66IVH8OLYCP6mBe6SCgr0oIZZMLc7mB1BhzhLVXtchiqLeFJoYjiUSH80LDxOwv+AtcM/UjXFS/7+zsWM4TeXkyGSQKKxu+r9y2MAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=XfOOvz9e; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 46VDw9Gf018871
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 31 Jul 2024 15:58:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1722434292; bh=4cJOSAZ2AijY8MZdagUzZF2bXQwxsHEZZX8WutHgKWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XfOOvz9ea/mipdcC0wV+mlDCZb7UaerEaby/INu66SI0GfWhLgVRpvBFNtY7gO2Mz
	 p2KG3qx3IV48LMV/JCfSmhTyBlvC4K6LxR5GxusL4p6tlOa3ubOMClP4s7rIQVTxgh
	 JOi1VKz3PrRaD7tfmOCPxHWo49qt2FPPeMQ42oZQ=
Message-ID: <d232ddce-ec6a-4131-bf47-04ffe5a74557@ans.pl>
Date: Wed, 31 Jul 2024 06:58:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ethtool] qsfp: Better handling of Page 03h netlink read
 failure
To: Ido Schimmel <idosch@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
        Dan Merillat <git@dan.merillat.org>
References: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
 <Zqnz1bn2rx5Jtw09@shredder.mtl.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <Zqnz1bn2rx5Jtw09@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31.07.2024 at 01:20, Ido Schimmel wrote:
> On Tue, Jul 30, 2024 at 05:49:33PM -0700, Krzysztof Olędzki wrote:
>> When dumping the EEPROM contents of a QSFP transceiver module, ethtool
>> will only ask the kernel to retrieve Upper Page 03h if the module
>> advertised it as supported.
>>
>> However, some kernel drivers like mlx4 are currently unable to provide
>> the page, resulting in the kernel returning an error. Since Upper Page
>> 03h is optional, do not treat the error as fatal. Instead, print an
>> error message and allow ethtool to continue and parse / print the
>> contents of the other pages.
>>
>> Also, clarify potentially cryptic "netlink error: Invalid argument" message.
>>
>> Before:
>>  # ethtool -m eth3
>>  netlink error: Invalid argument
>>
>> After:
>>  # ethtool -m eth3
>>  netlink error: Invalid argument
>>  Failed to read Upper Page 03h, driver error?
>>          Identifier                                : 0x0d (QSFP+)
>>          Extended identifier                       : 0x00
>>  (...)
>>
>> Fixes: 25b64c66f58d ("ethtool: Add netlink handler for getmodule (-m)")
>>
> 
> Nit: No blank line between Fixes and SoB, but maybe Michal can fix it up
> when applying

Ah... thanks. :/

Michal, please let me know if I should send a v3 or if you can correct this issue.

Krzysztof


