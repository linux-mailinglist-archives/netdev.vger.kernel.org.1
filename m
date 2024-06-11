Return-Path: <netdev+bounces-102457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75221903176
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A951F22928
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D420017085B;
	Tue, 11 Jun 2024 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eCnFnn+q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBC170858
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084650; cv=none; b=e3z2vt3MNon2fF7Ie4coQt4YKCmY6+uaWwVvVcbURgwFjQq6ZDSc8EjtAFkODiIgJDLfwCmVYgtROQDhc6zbKA/cQPf7kT6RS+8cIb7pnL+OYRaWZSvGBNUJOnqX7zKAJn9DwGD5gjKCtM0rmvksDG0jWhkMJbNq0yvOEVZDfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084650; c=relaxed/simple;
	bh=RKWdFEkwtdBWG/4PLlln8Q8+w5FSArPcDPDYAln1RuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haneXVMRlTRrnq5BLsKo7X6+iChPymq60Zo0de6yJX5lDKRzQZLpbafmL7P1UXl2TX2o/b24mzHxXLO0ppca0Jna6emoCOFjAJb6Q+pj2Dv8hKYnw1DIxecsqC9V01EuiqNiAdSlhoYaHO3LLoo+gMi7CwVOiT/M64WJo+0HwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eCnFnn+q; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.1.1.110] (unknown [103.229.218.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 17DCA3F1C6;
	Tue, 11 Jun 2024 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718084640;
	bh=Ni5EiqfE19GgJAagzEeA/URDCb51teDUC50fLcGZEHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=eCnFnn+qcyykwuC15o5VHAyS1VoCHpwuBJJEcxxGFxiyeqmKaijkTszUIbfG5Lt5+
	 3owboPlzBnRiVDSYGQ4hazu2gMvtO19zDYcd0ckXIfRu9/UTnmf3BYH+y1V+J8j+Lc
	 FXw3A2n/LjUbRG0UZULbnPaNB15TrNDo5L3Zf7NlBtaaRiNTMbzqb4bmEQv8/NcYYP
	 RT5b6Vwnfmg8YX8oWtWydG85m2OYQAmbjxuhZzsnOt5zd+BMyOLORz8Ncmq8cOKl99
	 pMOag0iyeVbeIXS2jTt1zqiMDXHsIZWhcWAeJiqaHmBbtdqX8GOq4mZTep0qOEwxaZ
	 wPyWlV1vMXWlw==
Message-ID: <3359c6cb-cd2a-4738-8907-5018fa3e9606@canonical.com>
Date: Tue, 11 Jun 2024 13:43:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of
 enable_ulp function"
To: Paul Menzel <pmenzel@molgen.mpg.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, sasha.neftin@intel.com,
 naamax.meir@linux.intel.com
Cc: todd.e.brandt@intel.com, dmummenschanz@web.de, rui.zhang@intel.com,
 jacob.e.keller@intel.com, horms@kernel.org, regressions@lists.linux.dev
References: <20240610013222.12082-1-hui.wang@canonical.com>
 <6ec4337f-7bf4-442d-8eca-128e528fde2a@molgen.mpg.de>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <6ec4337f-7bf4-442d-8eca-128e528fde2a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/24 14:36, Paul Menzel wrote:
> Dear Hui,
>
>
> Thank you for your patch.
>
>
> Am 10.06.24 um 03:32 schrieb Hui Wang:
>> This reverts commit bfd546a552e140b0a4c8a21527c39d6d21addb28
>>
>> Commit bfd546a552e1 ("e1000e: move force SMBUS near the end of
>> enable_ulp function") introduces system suspend failure on some
>> ethernet cards, at the moment, the pciid of the affected ethernet
>> cards include [8086:15b8] and [8086:15bc].
>>
>> About the regression the commit bfd546a552e1 ("e1000e: move force
>
> … regression introduced by commit …
Got it.
>
>> SMBUS near the end of enable_ulp function") tried to fix, looks like
>> it is not trivial to fix, we need to find a better way to resolve it.
>
> Please send a revert for commit 861e8086029e (e1000e: move force SMBUS 
> from enable ulp function to avoid PHY loss issue), present since Linux 
> v6.9-rc3 and not containing enough information in the commit messsage, 
> so we have a proper baseline. (That’s also why I originally suggested 
> to split it into two commits (revert + your change).)

In regards to reverting the commit 861e8086029e (e1000e: move force 
SMBUS from enable ulp function to avoid PHY loss issue), the author is 
Vitaly, let him evaluate how to act.

Thanks.

>

