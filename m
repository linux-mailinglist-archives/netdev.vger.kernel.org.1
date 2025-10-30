Return-Path: <netdev+bounces-234519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A1C22998
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 23:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5744EC4CF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA62F9C2D;
	Thu, 30 Oct 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nn3zP5yO"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768F34D395;
	Thu, 30 Oct 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864570; cv=none; b=Ff8PigWkYlU2dYp4cI6R27gi2rv1SXXRh64HA3Hv+BfbxxpV5iN4MkBojXN76FTlyWT7nYq+HwaXWKRcWVFePbrw/a4I5aM0Onuhpio/29ElAC4QR4xJ0yoiKpzGDxMM0zl0LFXI1SXt62TQpzDkY6DgUelX7jDME7y187RYH90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864570; c=relaxed/simple;
	bh=UgGB97gFfkBMFKeQUH3mcQQ+pc+E2qEDyTSQDbCoFik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNVB0OA660f+yRnM+2/7J8BItAuknrcfvRnV8OKv/fayPauGqFtwmCJC+hwVOi0nSzvBDQB9GcoLlvGjR0AV2G+u8C+yReWJBQdHokonkkM95tr6bsY4jKcrQmrWLrESr57CseafZEV9lKSH3FCaycPjSD8LXQuqAQUyDVXxHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nn3zP5yO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=W39D1CHVnz5ftoUtLOXhSfT0d9vFvzHtYZUvOQ5CQgk=; b=nn3zP5yOZotkrkB2k4BgnxAfmk
	UlFWyoo4RmBgRnjD5M62q2lTBaT5DK0CwAbfVauIadDlI/jg/HV2vOCQoqTFnWoc82uzLJ/AjuK6/
	2E6ZbTDnC9/LFOkmo8JDQ1nI5HLB5PQROT66Z+x3se5Ui/n/mCJ0w8Rvc0tnpRllW/QVi3++gqBm3
	gyhgh3zE+HjqFiXrnQGuxSW7r50+2FibVfnAXDNnbi5i9tQ+vkq2KaFGVXZouvxkVRb4iX7+9aDpn
	C2qcj6QzMoNl9OsTovabmdxa/SzOx/sGuWCM1FJ+P0EqsfGU1YRHXEGjWromyJ2OlNM8jHCy6Ecre
	telx9loQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEbSQ-000000055Ov-28yJ;
	Thu, 30 Oct 2025 22:49:26 +0000
Message-ID: <574473a2-e86a-4a4c-875a-cb3013acf4d0@infradead.org>
Date: Thu, 30 Oct 2025 15:49:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: kdoc: fix duplicate section warning message
To: Jonathan Corbet <corbet@lwn.net>, Jacob Keller
 <jacob.e.keller@intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030-jk-fix-kernel-doc-duplicate-return-warning-v2-1-ec4b5c662881@intel.com>
 <873470m5wd.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <873470m5wd.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 2:33 PM, Jonathan Corbet wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> The python version of the kernel-doc parser emits some strange warnings
>> with just a line number in certain cases:
>>
>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>> Warning: 174
>> Warning: 184
>> Warning: 190
>> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
>> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
>> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
>> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
>>
>> I eventually tracked this down to the lone call of emit_msg() in the
>> KernelEntry class, which looks like:
>>
>>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'\n")
>>
>> This looks like all the other emit_msg calls. Unfortunately, the definition
>> within the KernelEntry class takes only a message parameter and not a line
>> number. The intended message is passed as the warning!
>>
>> Pass the filename to the KernelEntry class, and use this to build the log
>> message in the same way as the KernelDoc class does.
>>
>> To avoid future errors, mark the warning parameter for both emit_msg
>> definitions as a keyword-only argument. This will prevent accidentally
>> passing a string as the warning parameter in the future.
>>
>> Also fix the call in dump_section to avoid an unnecessary additional
>> newline.
>>
>> Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel entry to a class")
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> This one applies, thanks.
> 
> jon
> 

-- 
~Randy

