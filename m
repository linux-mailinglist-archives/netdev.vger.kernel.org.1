Return-Path: <netdev+bounces-99219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E58D425F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D24B22D54
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDE8BEF;
	Thu, 30 May 2024 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uufFWBty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033879F3;
	Thu, 30 May 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028980; cv=none; b=Pp3QHM+w4SLuog+a9rWeO1vsLPlcmqfF/A1GulxQGfJ/4SK80WT2Ho6AOiGOfm5sapWGQxHRFU+TXvvqOK2eV4YGDTa2/W65QwMUdxlX69GRFDX5N00DvFeqFCyHq5V2IInkHYgAICvTB8TMZLzInzxTMCFP2TOtb+RY5GQyzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028980; c=relaxed/simple;
	bh=fEP+M8KbG0s825x+RU/s5AgYR04x7FtEYG8ZhtE3mC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvqYKV+InakIIvw3HSREMvdc6xe8D840MBLkbRR0JEPm0HcgDKy0GpgPswI0teXabCg+4c4/78UctEvRSAhcw8CvFO6KZyhOUuL5Ntusfx9ir102flnE2pQswMKUKx2Po+93RRMmMnbrLLd3zKQj9hmfYX0nbqQdCnnVlCGi39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uufFWBty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE0BC113CC;
	Thu, 30 May 2024 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717028980;
	bh=fEP+M8KbG0s825x+RU/s5AgYR04x7FtEYG8ZhtE3mC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uufFWBty26DjvFtaqYGmWOgTd5LPUK+oABjlrleWSPIf2MIdwPgiT3N7MvFkjh0lM
	 JEMBgrhW7zpEr7Fso/3HG1cgh7R1ZNmbc2W1mBYpAt3COehPuJc0LqDzdZj/d4OJCc
	 GA8Jc0byhbSrE8cgoev7WFUb7XILexTBZY3rybiSzLcPuqkgtPV+H8NPX06Vh0aw8R
	 cV4i1Bi+qmhpjP92Pqz8YpfC55tWa/VkcanyHs5ZLC2wvSXd3qikHAD+bO52g9Xtz7
	 JgafSECxfIXWcTLZ1uIfBvGXtESa6GUcQJqDfUa+lorbO6/2Ks++4NOt3PVvd4bo5n
	 WVZvRdyJ0gfLw==
Date: Wed, 29 May 2024 17:29:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH net-next v5 01/13] mm: page_frag: add a test module for
 page_frag
Message-ID: <20240529172938.3a83784d@kernel.org>
In-Reply-To: <20240528125604.63048-2-linyunsheng@huawei.com>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
	<20240528125604.63048-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 20:55:51 +0800 Yunsheng Lin wrote:
> Basing on the lib/objpool.c, change it to something like a
> ptrpool, so that we can utilize that to test the correctness
> and performance of the page_frag.
> 
> The testing is done by ensuring that the fragments allocated
> from a frag_frag_cache instance is pushed into a ptrpool
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragmemt from the

fragment

> ptrpool and free the fragmemt.
> 
> We may refactor out the common part between objpool and ptrpool
> if this ptrpool thing turns out to be helpful for other place.

Is this test actually meaningfully testing page_frag or rather
the objpool construct and the scheduler? :S

