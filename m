Return-Path: <netdev+bounces-122520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA396192C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929A71C22CD4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451B158218;
	Tue, 27 Aug 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJFzkgpH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C751F943
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793944; cv=none; b=IZOgJ/Vnav0LmUdy2/127L20f2ddoIUoE9cY/YwuLvzBF4wn3AVUfnZ9oe+ZEE+TgTnUozje0ZCvhcQl/BFTFm+CrkBsx87AlqsU4BTDJBhfYbPSGxPJPLODCsKbxcsO5jJ2HRWdZaqSBNFYz3BlXAf5ux/TV3H6K4a7FJhboKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793944; c=relaxed/simple;
	bh=JwyxuAxdJh5gqpmW+vRHYckqtkQopENYgeI53pC4zbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT7A8vd3JnW4XEv3H8gcQ+3jyhHnpuSrWGnU8ogjYlF31i03SIpT/I4qbQTZfn1+5ZTy6snPexbEOqYCVaSOQTQ05Cg+LMKBEJ1Xay5cJoDMbYl3UlREZnCipSODUb5fksjzRlnEbQTlyOJTgxeAKeQgNnV+P+rwEEMhQV10AeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJFzkgpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330E0C32786;
	Tue, 27 Aug 2024 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793944;
	bh=JwyxuAxdJh5gqpmW+vRHYckqtkQopENYgeI53pC4zbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CJFzkgpHhBE9/toSrPkWXdcyexCo9IxZxj3fvZ5jDuCaQeRZ0dW9NQkca5ny7RUOC
	 2JmhvXW56AZqTTGgAo788U8iKuckST4LZyES5Lac3+5qbc7KhrzNKHszaJlmRoPqJ3
	 xu8/n+asSttbKf0hpDiXyu4F+rgokYGG3VLrKRlTbTDgza1hnlQRn0E8I1hjCxijjq
	 jIiCLi4glMnn5g2SmtQNJGRXUTZRSYnj7NW0K5yrlXw2H2SfUwRZPQY5Fe0uBigGWL
	 Q9d+pVSy30DCOGJnc+rrlJCjPA2wKtjN/YlLXCJsfS6D4It6Mz9ESqPezE4oRdW20E
	 C9j04phPsHeJA==
Date: Tue, 27 Aug 2024 14:25:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: <sebastian.hesselbarth@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH -next] MIPS: Remove obsoleted declaration for
 mv64340_irq_init
Message-ID: <20240827142543.277b1bad@kernel.org>
In-Reply-To: <20240826032344.4012452-1-cuigaosheng1@huawei.com>
References: <20240826032344.4012452-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 11:23:44 +0800 Gaosheng Cui wrote:
> The mv64340_irq_init() have been removed since
> commit 688b3d720820 ("[MIPS] Delete Ocelot 3 support."), and now
> it is useless, so remove it.

Most of the drivers which used this header have been deleted.
Please move the only 3(?) defines that are actually used into
arch/powerpc/platforms/chrp/pegasos_eth.c
and delete the file completely.
-- 
pw-bot: cr

