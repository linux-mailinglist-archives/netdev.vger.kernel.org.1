Return-Path: <netdev+bounces-102458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E559490317A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA581F20628
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C317085B;
	Tue, 11 Jun 2024 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iULaIfvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37C25745
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084745; cv=none; b=skD4zWYianii0Ft1pLWGNYwgLkD0VEWpKESA3XiK5BL0MHVmLHSgBPX0tUdIf5zZ1nreI5NknfbarQvZEOxzVwCXxfL20t1eVzUcVksw/29A511FinOuZ+OPi3uIzhdQRLWGNMFNXTLHoiPFjr5tWQhOlNDQq5lckERhzy7lVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084745; c=relaxed/simple;
	bh=qNZ+/nRgL1qOziLTAxYNczXHVP0BwbIrCE3nKu4qc4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+t3h2EM4w67vPeD88O6GVTdaXDIaZmG3WuHmqh/wbTsvphDVvkvaoc/GAuqMqGHdUfQzxQmdJJTB0sBSec60Tk2Xt4nM0arv4ARDHCYNyxpww7WWuZ7LcoHA01zlmjMpZsNYW+rO3QU9PAgUfhVB8ngLYNS7S/Q80Ven3NEOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iULaIfvR; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.1.1.110] (unknown [103.229.218.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5352A3F1C6;
	Tue, 11 Jun 2024 05:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718084741;
	bh=1uQHXhtS+FSETeH2hqizhIc/c/smCB4G/AydYNkP0wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=iULaIfvRVc3jFrI3242MAXXKclEeiHSfcQruSnS5M0Izuor8FRo/kkS6N0HrTVDj2
	 LPjqfE0cuNz1ZpBa8alBxIEUIMT249UC+YNmyW5rBzz2DPNaGbTfUns/1i9VHFvVV6
	 x1gof4Y0XOw6aXQbY0lP2VfFx+C15jP/9qKtaO5Y5czJS9q6B6oKi7SNGR8914m5vH
	 2p91G6RknJz8PkAh/eM30E4WxOYv5svrLJpZtVbbi2LPkTag6HMtmUGZtPB6InHZ6D
	 E8G0hMuOBViC5fSCFVATHHQHG+KVVyDr7wQCb5kg3IU8NZECb5gmbvCf9CHx3KrRDq
	 95L8n3MziKSPA==
Message-ID: <ccca7897-ac53-4056-8617-a3ace57bf7b6@canonical.com>
Date: Tue, 11 Jun 2024 13:45:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of
 enable_ulp function"
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "naamax.meir@linux.intel.com" <naamax.meir@linux.intel.com>,
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Neftin, Sasha" <sasha.neftin@intel.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "Brandt, Todd E" <todd.e.brandt@intel.com>,
 "dmummenschanz@web.de" <dmummenschanz@web.de>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20240610013222.12082-1-hui.wang@canonical.com>
 <6ec4337f-7bf4-442d-8eca-128e528fde2a@molgen.mpg.de>
 <98ccb75d7ef48c182425f130e0b2ececeec630ec.camel@intel.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <98ccb75d7ef48c182425f130e0b2ececeec630ec.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/24 22:14, Zhang, Rui wrote:
> On Mon, 2024-06-10 at 08:36 +0200, Paul Menzel wrote:
>> Dear Hui,
>>
>>
>>
>> Naama also added Tested-by lines two both commits in question. Could
>> Intel’s test coverage please extended to the problem at hand?
>>
>> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Plus that,
> 1. Todd and I can test with upstream + this patch to confirm that
>     a. the regression for Todd is gone.
>     b. the s2idle failure for me is back
> 2. I can test with upstream + this patch + revert of commit
> 861e8086029e (e1000e: move force SMBUS from enable ulp function to
> avoid PHY loss issue) to confirm s2idle is working again.
>
> thanks,
> rui
Thanks.
>
>>
>> Kind regards,
>>
>> Paul

