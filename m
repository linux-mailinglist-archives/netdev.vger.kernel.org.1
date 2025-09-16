Return-Path: <netdev+bounces-223690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A0B5A0ED
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625FA52309B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2EB2DC329;
	Tue, 16 Sep 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDPqfNa/"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B12773F4
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049565; cv=none; b=rvfjvgvxE5fYNhAZCAkkQP1PvTQYnqsqeCXpTQg2FVwImbFof4E74XAPcZL9ihx+G8yF5EqIkxudLBb7BCT6MJHFjVKwLPUMIYKgYJjZB58Qo8h15RI8fbf/lanp2dhMGwk1a3HSmYTtLCYqoBPzLGrRF9QXx+TN2Mj/qyXQukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049565; c=relaxed/simple;
	bh=gcyYajVaphCyXS1AX8V1zDKVH5zuBU1zTUDF+2a4UUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usxdD0JRu6dGDK/Z3jE3HAd9tO2GvYiuzkq9tkSDTJzlOXXhxtz0SU/+ZOavBdGtCUgig0wyZC+coeLLhooqp2+N2/lHjFc/TayMiTnbGCZ8WZ9FSuM2zO0cxykEM0sJt+RHo2FacCEcHXWfQPq9/QNvCOgfpZ+xrlTwgpyizn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDPqfNa/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49682000-cb30-42a5-b3ef-16d5cc1174c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758049560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YrcpOyPI6JKSVXBHg3UOjlmHj9HiZPB4pSI8VNsMwk=;
	b=hDPqfNa/kPEOcNyWYG4Bzvxos/sBuaRko6CUMa2bxgzzYGVorGCSdkO2hRHmR9qFyVAmMC
	9q8C1Jlk3wyLZuyx7CbB99Q0dJs2zTBYmkxQRXl7pLwShfsvT14xeT36hSLojFXV/j8wdG
	JLh2p2XEyf5KwoLFDipciI6XVWgKJBE=
Date: Tue, 16 Sep 2025 20:05:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] tools: ynl-gen: support uint in multi-attr
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 jacob.e.keller@intel.com
References: <20250916170431.1526726-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250916170431.1526726-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 18:04, Jakub Kicinski wrote:
> The ethtool FEC histogram series run into a build issue with
> type: uint + multi-attr: True. Auto scalars use 64b types,
> we need to convert them explicitly when rendering the types.
> 
> No current spec needs this, and the ethtool FEC histogram
> doesn't need this either any more, so not posting as a fix.
> 
> Link: https://lore.kernel.org/8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> ---
>   tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 56c63022d702..58086b101057 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -720,7 +720,11 @@ from lib import SpecSubMessage
>               return 'struct ynl_string *'
>           elif self.attr['type'] in scalars:
>               scalar_pfx = '__' if ri.ku_space == 'user' else ''
> -            return scalar_pfx + self.attr['type']
> +            if self.is_auto_scalar:
> +                name = self.type[0] + '64'
> +            else:
> +                name = self.attr['type']
> +            return scalar_pfx + name
>           else:
>               raise Exception(f"Sub-type {self.attr['type']} not supported yet")
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

