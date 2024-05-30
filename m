Return-Path: <netdev+bounces-99447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F48D4EE4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35441F25D0F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E8187549;
	Thu, 30 May 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqM9B8lg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F32187540;
	Thu, 30 May 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082215; cv=none; b=aKfPl5jdNpEXl9tojErftjSBNQn6VQz2cjSaanLaYIkAGERLn42hIuBS9xjdGyS3G+UxMKkZ+09LhEfkMD6viaC8AGmp5a/yfP+QRpWVCbJ6pKIOVeBHzVDYu+1imUDYSEziwHU318gsrWPPfyzk7Wtms+9yzxZyEitoKiJy/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082215; c=relaxed/simple;
	bh=fa0yMmxC2QPbMThwYz+/xLlUrjogilIctWdLDj2RcM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQQIP/SX9hj7Ayuwfctm0ZEBhpE3wWv05lPlbN70eLOpa7IX/aX6U3M4sr9vZV8AGqqw0QWPZkUGDUSiVWBWmxCRJkUe8oSGuTBiyMm84Rbvqmbw9A/vKlayo7fOs0e0E6UyuXDO9edgpYkovDscOnjkuEG7LBY/FxdYlPBtqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqM9B8lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0DFC32781;
	Thu, 30 May 2024 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717082215;
	bh=fa0yMmxC2QPbMThwYz+/xLlUrjogilIctWdLDj2RcM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JqM9B8lgLMEU14G4JMKkVxyi0rQSZ0GgNxBmdZ31ubamsPc3dAsXAPpNIsH/KHkIg
	 mKhYPU5eqT0XEfOdVIfwx3e1xJ/9bslazZjlL6GJRYiLyzFI5/FHsgY5alz4vsg+Yl
	 uxYZhauXnZkjj18On86xNKMvuypSdlN9XZ341erSw5lylEkj7AtuXzWoOTsLAA+uAH
	 7cpnm2s5ZS9XFX+TsFyPGXV0a2VoFX87MeUHrFZVnrfpcZvwi7/vMGjOioJSAemWNm
	 n8Cx1Mty3Qw/sNkVaN07nYH353czFcdFcGpoJvTruWwqicqmEXb6+4VLuvZiMVxAbv
	 lNJWpwXOdPpJw==
Date: Thu, 30 May 2024 08:16:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH net-next v5 01/13] mm: page_frag: add a test module for
 page_frag
Message-ID: <20240530081653.769e4377@kernel.org>
In-Reply-To: <1cba403b-a2c7-5706-78b7-91ccc6caa53b@huawei.com>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
	<20240528125604.63048-2-linyunsheng@huawei.com>
	<20240529172938.3a83784d@kernel.org>
	<1cba403b-a2c7-5706-78b7-91ccc6caa53b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 17:17:17 +0800 Yunsheng Lin wrote:
> > Is this test actually meaningfully testing page_frag or rather
> > the objpool construct and the scheduler? :S  
> 
> For the objpool part, I guess it is ok to say that it is a
> meaningfully testing for both page_frag and objpool if there is
> changing to either of them.

Why guess when you can measure it. 
Slow one down and see if it impacts the benchmark.

> For the scheduler part, this test provides the below module param
> to avoid the the noise from scheduler.
> 
> +static int test_push_cpu;
> +module_param(test_push_cpu, int, 0600);
> +MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
> +
> +static int test_pop_cpu;
> +module_param(test_pop_cpu, int, 0600);
> +MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
> 
> Or is there any better idea for testing page_frag?

