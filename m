Return-Path: <netdev+bounces-234148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0BC1D3D2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA39D4E16A5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198703563E3;
	Wed, 29 Oct 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CC0XWT/g"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789726D4F7;
	Wed, 29 Oct 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770407; cv=none; b=Ep74pMR8ih/rRU+2RPBnRrPvgEFnFxieabQtPfJE5DWwXoAAd9b17T98s8kR3pZ1oErWZoe2QPZQZZs0a8avL2g7irwLPuUREPb26IKouopmkY6Ml4HetXSU9+0MowGXd3/xNiYifyQFtOji9YJJYrwPGpkQMCqamqdQnzgdrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770407; c=relaxed/simple;
	bh=Hldxg5wIX16oQThtCclBJU/YEZZATtqu9a9yX5sNY5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ0fCnPflbTLcpKfZ6DYIrzt3az7f8kzLy/dA6KWjVgEP35boqSDOGJaU1kq9JedA4cJVKbGqy/vAFsOGAQknp6AEj8MnTnARbvCos2hpL1KvK+ojudODfNJ40ztpVF7ae1WwWknIxXBacv+bCHPpouP9yhJ4WnMX/IbIVISjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CC0XWT/g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UV/VmOJCOfLSipmv50W1vAFDC6k/baUxYyh/BQCyEpA=; b=CC0XWT/gfXNtu9Xw5kcAcNJ/7D
	yWbrdA638vB4KAJV8RGlYsc6Ws5RkqqKz45UMdC50XRJ4pnRFP2l49817DC8qVTbMtEebXL3maUOZ
	DRdErQwugmWKqXn/Gf+GxJOzI1obcnkSQ7BdSbmaIRxDsT6Znsn8gnzNg6x3wTuYcC5Z65B/n9PyO
	8M/z8w05VAfLdi1mFm7xbI9OY5a6mtub8h1LeGKLwAOXasLScVh1w1ftwWuoMKKPSqR+13y2saV9w
	Kgju7ioVCuGwVwR+Ym3oXehyVm1F4POmZ5szpJVB8Iy12mekI2xUeEQ/qT8dVY1CpUP/4v40VRmwU
	3MkSU6Gg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vECxY-00000002pOM-05SB;
	Wed, 29 Oct 2025 20:39:56 +0000
Message-ID: <f226af11-adbb-444f-9322-1dd3116321f7@infradead.org>
Date: Wed, 29 Oct 2025 13:39:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Jacob Keller <jacob.e.keller@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
 <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 1:04 PM, Jacob Keller wrote:
> 
> 
> On 10/29/2025 12:45 PM, Randy Dunlap wrote:
>> Hi Jacob,
>>
>> On 10/29/25 11:30 AM, Jacob Keller wrote:
>>> The python version of the kernel-doc parser emits some strange warnings
>>> with just a line number in certain cases:
>>>
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: 174
>>> Warning: 184
>>> Warning: 190
>>> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
>>>
>>> I eventually tracked this down to the lone call of emit_msg() in the
>>> KernelEntry class, which looks like:
>>>
>>>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'\n")
>>>
>>> This looks like all the other emit_msg calls. Unfortunately, the definition
>>> within the KernelEntry class takes only a message parameter and not a line
>>> number. The intended message is passed as the warning!
>>>
>>> Pass the filename to the KernelEntry class, and use this to build the log
>>> message in the same way as the KernelDoc class does.
>>>
>>> To avoid future errors, mark the warning parameter for both emit_msg
>>> definitions as a keyword-only argument. This will prevent accidentally
>>> passing a string as the warning parameter in the future.
>>>
>>> Also fix the call in dump_section to avoid an unnecessary additional
>>> newline.
>>>
>>> Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel entry to a class")
>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>> ---
>>> We recently discovered this while working on some netdev text
>>> infrastructure. All of the duplicate section warnings are not being logged
>>> properly, which was confusing the warning comparison logic we have for
>>> testing patches in NIPA.
>>>
>>> This appears to have been caused by the optimizations in:
>>> https://lore.kernel.org/all/cover.1745564565.git.mchehab+huawei@kernel.org/
>>>
>>> Before this fix:
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: 174
>>> Warning: 184
>>> Warning: 190
>>> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
>>>
>>> After this fix:
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: include/linux/virtio_config.h:174 duplicate section name 'Return'
>>> Warning: include/linux/virtio_config.h:184 duplicate section name 'Return'
>>> Warning: include/linux/virtio_config.h:190 duplicate section name 'Return'
>>> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
>>> ---
>>>  scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++++--------
>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>
>>> ---
>>> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
>>> change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628
>>
>> What is that base-commit? I don't have it.
>> It doesn't apply to linux-next (I didn't check docs-next).
>> It does apply cleanly to kernel v6.18-rc3.
>>
> 
> Hm. Its e53642b87a4f ("Merge tag 'v6.18-rc3-smb-server-fixes' of
> git://git.samba.org/ksmbd") which was the top of
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git as of
> when I made the commit. I wasn't sure which tree to base on since I'm
> not a regular contributor to the docs stuff, so I just based on Linus's
> tree instead of linux-next.
> 
>> and it does fix the Warning messages to be something useful. Thanks.
>>
>> We'll have to see if Mauro already has a fix for this. (I reported
>> it a couple of weeks ago.)
> 
> I searched mail archives but didn't find a report, so hence the patch.
> If this already has a proper fix thats fine.
> 

It was discussed here and Mauro said that he sent a patch but I still
see those warnings in linux-next-20251029.

https://lore.kernel.org/all/jd5uf3ud2khep2oqyos3uhfkuptvcm4zgboelfxjut43bxpr6o@ye24ej7g3p7n/

>> If not, then this will need to apply to docs-next AFAIK.
>>  
> 
> Ok, I can rebase if it is necessary. I'll check that out, and can send a
> v2 if Mauro hasn't already fixed it somehow else.
> 
>> And not a problem with this patch, but those Returns: lines for
>> each callback function shouldn't be there as Returns:. This is a
>> struct declaration, not a function (or macro) declaration/definition.
>>
> 
> Yep, thats an issue with the header. They're doing something weird by
> doing some sort of sub-documentation for each method of an ops struct. I
> don't really know what the best fix is for this doc file, nor do I
> particularly care. I just used it as an example because its the one that
> we ran into while looking at output from the netdev testing infrastructure.

-- 
~Randy


