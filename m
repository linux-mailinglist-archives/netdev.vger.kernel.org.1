Return-Path: <netdev+bounces-234137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D1C1D0BA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDC2B4E14B8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EB359FB2;
	Wed, 29 Oct 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GJGexf90"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9537264F96;
	Wed, 29 Oct 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767163; cv=none; b=JWDzJJEycwRavx0srq0Ii5KOpp9K8bUhpi1wdAottE/rhaDzN6dlW1ihKD7UmQL+xUh3m02tgAdjaFBXVy6/QAK3RVyR7ikZ0G5Y9aZo4RsPViHZwZiid344HiKdbezUxm/Ik3Tkp3qrxSO9i+usXSOFFPI+bRlds1PE4Y3JFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767163; c=relaxed/simple;
	bh=8ZESPlQtZcsBAgAmsnbAeE+zEGnT9bl/r8Ew2Z2G2v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Onrsa2ghxxN1SQmzI74dy7h2SfcXV3vm5Jf2p7p+9bdc4xS8Mt2FkAxqHL6m18n6I5BQvk2C+iu36tM0dD6JXRrMiroQrep1aDI3l6CdPsMK7lbHyzj0EIofXD7+qPdZYMJjdsvWYkxkmOQBMJQ/9x+Iw1L/nqoRKt53B+INNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GJGexf90; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WlTdzwiNGenyxsQZTkiMPfopzh3sq++Vf+suBydGokU=; b=GJGexf90/W6Y2IqG/dx6WHeJEc
	b9etHmb08lbn6zIVvLkvF1YVg5g6httyzqpn+Cz6IgM5UyYKTqetymqLQoIjPtLg3AEYejFsxqN1F
	5sOD97DiFZLtcq7g0YqwJwg0K71+j/OOk3td1fWlo6uBXGODe2LxbRmADW6dkhaqRNaSGgxvDKuIY
	M4/eHf/H/JWpyunn7Xzw0Oupqc7ge0FtInmzQNb5LVQxYHwM7hwgJdHtYSMtQUxcNvwqQcbp08F4v
	Ksd/uu3+FaLto/i9sF17YytaApQSUP9BTDk6BG+6zgqIBHf4W8cIcs4W486HpWKE1/hwv+0zNNW/s
	LbdNRhCA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEC7K-00000002eQm-3dWp;
	Wed, 29 Oct 2025 19:45:58 +0000
Message-ID: <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
Date: Wed, 29 Oct 2025 12:45:57 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jacob,

On 10/29/25 11:30 AM, Jacob Keller wrote:
> The python version of the kernel-doc parser emits some strange warnings
> with just a line number in certain cases:
> 
> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
> Warning: 174
> Warning: 184
> Warning: 190
> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
> 
> I eventually tracked this down to the lone call of emit_msg() in the
> KernelEntry class, which looks like:
> 
>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'\n")
> 
> This looks like all the other emit_msg calls. Unfortunately, the definition
> within the KernelEntry class takes only a message parameter and not a line
> number. The intended message is passed as the warning!
> 
> Pass the filename to the KernelEntry class, and use this to build the log
> message in the same way as the KernelDoc class does.
> 
> To avoid future errors, mark the warning parameter for both emit_msg
> definitions as a keyword-only argument. This will prevent accidentally
> passing a string as the warning parameter in the future.
> 
> Also fix the call in dump_section to avoid an unnecessary additional
> newline.
> 
> Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel entry to a class")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> We recently discovered this while working on some netdev text
> infrastructure. All of the duplicate section warnings are not being logged
> properly, which was confusing the warning comparison logic we have for
> testing patches in NIPA.
> 
> This appears to have been caused by the optimizations in:
> https://lore.kernel.org/all/cover.1745564565.git.mchehab+huawei@kernel.org/
> 
> Before this fix:
> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
> Warning: 174
> Warning: 184
> Warning: 190
> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
> 
> After this fix:
> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
> Warning: include/linux/virtio_config.h:174 duplicate section name 'Return'
> Warning: include/linux/virtio_config.h:184 duplicate section name 'Return'
> Warning: include/linux/virtio_config.h:190 duplicate section name 'Return'
> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea39c628

What is that base-commit? I don't have it.
It doesn't apply to linux-next (I didn't check docs-next).
It does apply cleanly to kernel v6.18-rc3.

and it does fix the Warning messages to be something useful. Thanks.

We'll have to see if Mauro already has a fix for this. (I reported
it a couple of weeks ago.)
If not, then this will need to apply to docs-next AFAIK.

And not a problem with this patch, but those Returns: lines for
each callback function shouldn't be there as Returns:. This is a
struct declaration, not a function (or macro) declaration/definition.

Thanks.
-- 
~Randy


