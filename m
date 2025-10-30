Return-Path: <netdev+bounces-234510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0FC226CD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452F14014C5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054852E0922;
	Thu, 30 Oct 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R73CrVQc"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671252D8370;
	Thu, 30 Oct 2025 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860005; cv=none; b=emw0xzpwR+AEfDplyFFggYL7dQ+3wa6nYGZfkg2P6vQWLQaELV7Vxxz8SsZCObHfVDy8AzRI/w0sXffuIXgozPoWADgL2bzM7Pmb/lpsUlInZMKjLzQQTPFjEtHAxuv9pPAudz9BqnjaxCbDYRLsBEDtBxKlxkKpRLQcOpGmctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860005; c=relaxed/simple;
	bh=qL8Bp6akPiS702R8PFiz2HYe41/kvXKllf/LH2OiE+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WkI9eMFiT0z/hxCXMhnAGcIwwV3Govcecf+Ny/NokCvjeKL+HWi43CSMulW6RBF0ehNg61BRbC3Ge1KHREUUL6Yul6H0dzv3k6YtVF34Th/HxEpNSZQtn66lnyZOCrsiFyJHPwImo6RuUatk+AG3QVMdMIPmTQJd5DP1RdXimlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R73CrVQc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7696A40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761860003; bh=xrHvEuPMe2ofdeJRnWawdla26z3fgauhjifsrjuJitw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R73CrVQcCE8QZlYOPKnzeco14oegk2TrCcQYFauAuXjayWw1STOEdetA/q7khlQ1B
	 hjo7vEGsBv+eDgOwl7H0MyVDrCrNHSDPIF+3vs7FTfhfl0C4hU+oxrt01TQkN9lkhr
	 XbSSuokQmXj+dnF7TbWbM3fPQM0RyP6UnDG65SOh1ksyfHn+i7rzHxpzQ63ub1pmat
	 IUfxnCR4Q/jlweJOUorSv9fvLdHFfDiDGnT4VzVaieGxwxNGWjekMv1xHGAZARIaDd
	 aamB+HX7c1yvaxbktH2UWiAtZiWrxZ9I1oFPLSysmbBab1GhD1/No6NEzEFBG7VvyN
	 te7AYWLhxBynQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7696A40AED;
	Thu, 30 Oct 2025 21:33:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jacob Keller <jacob.e.keller@intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2] docs: kdoc: fix duplicate section warning message
In-Reply-To: <20251030-jk-fix-kernel-doc-duplicate-return-warning-v2-1-ec4b5c662881@intel.com>
References: <20251030-jk-fix-kernel-doc-duplicate-return-warning-v2-1-ec4b5c662881@intel.com>
Date: Thu, 30 Oct 2025 15:33:22 -0600
Message-ID: <873470m5wd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

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

This one applies, thanks.

jon

