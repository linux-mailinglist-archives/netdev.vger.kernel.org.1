Return-Path: <netdev+bounces-112428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78D9390BF
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2297C1F21CA6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FDB166308;
	Mon, 22 Jul 2024 14:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF884D512
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658958; cv=none; b=OuC0chxlc1iLxNgABahuG6tU27XeJVl77CC6BPo0Pm+d0lSrCij+B5n8IstMG21N3PKsWpvaXcYdjj/lRk4fZjdTzxK4JE6G9DkOrk4oFwEjvFY5w0OtEmxAlzxY47df7Ix2eRFDS0gz1Ywca0hKiFHbitO7O4Gqo326SWr8nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658958; c=relaxed/simple;
	bh=DZw9jpV9/A9EGqJ6erATlMmjQxMSuXH0MTa2pDBCcz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bua9XxtZLqFEFmCCTTx/q7UnTdK6alZcFLhYkCdQ8iYKOGuSAB/47CJFAGlYfa/QhHM2QXI56uJUqYPnEEAyFxZB7KETa78UXCOj8rBAMFUGLi2Yc/GPbzrDv6MTl070Vlrpma5Z1Whzi7ZiccYNFVs+awo9r2/IOZc7WH7VYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5CAD961E5FE05;
	Mon, 22 Jul 2024 16:35:16 +0200 (CEST)
Message-ID: <232df828-baa3-4c87-b5f3-c0dae9d98356@molgen.mpg.de>
Date: Mon, 22 Jul 2024 16:35:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
 <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dawid,


Thank you for your quick reply.


Am 22.07.24 um 14:55 schrieb Dawid Osuchowski:
> On 22.07.2024 14:37, Paul Menzel wrote:

>> Introduce … into
>>
>> sounds a little strange to me. Maybe:
>>
>>  > Attach to device in reset flow
>>
>> or just
>>
>>  > Add netif_device_attach/detach
>>
>>  > Serialize …
> 
> Maybe "Add netif_device_attach/detach" would be the best for this, as 
> the attaching and detaching doesn't happen only during reset.

I’d consider it too generic and would mention the place. But if it’s not 
possible, then it’s not. Maybe:

> Attach/detach device before starting/stopping queues

>> Am 22.07.24 um 14:28 schrieb Dawid Osuchowski:
>>> Ethtool callbacks can be executed while reset is in progress and try to
>>> access deleted resources, e.g. getting coalesce settings can result in a
>>> NULL pointer dereference seen below.
>>
>> What command did you execute?
> 
> Once the driver is fully initialized:
> # echo 1 > /sys/class/net/ens1f0np0/device/reset
> and then once that is in progress, from another terminal:
> # ethtool -c ens1f0np0
> 
> Would you like me to include those in the commit message as well?

I’d find it helpful, but I am no maintainer.


Kind regards,

Paul

