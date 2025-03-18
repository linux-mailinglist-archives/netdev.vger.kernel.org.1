Return-Path: <netdev+bounces-175631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2BA66F6F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F7F19A2CA2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FDA2066EA;
	Tue, 18 Mar 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoihKZMy"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A23205AD6
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289184; cv=none; b=hb3CGzS97hTsA7P6BJsUkTLgXPvwkYLLZVN/zU12DcMEJLeQEhv3ZiPQvO1NLHODwmVKhY/eYk+Xi/W+N/hBmVVs9w6tyaOfb0DZ0HXEpkC/JHTijjk/T/i5a1Hx3ksOcwZzaaHvBbHZtw08VOQA2CRv9CkHzKAXlZdEANXdwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289184; c=relaxed/simple;
	bh=Z4YTOTSA36iqz3MbQCDjz+JhOm+L6THDvTHVC6nFP5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqIcICyZq+TnlRy4DIv7pxQVyd+xF4HW3/EiAjfNvL8s7u8nQ/PRyoj1Njqay5m2a9669BUkqs3Upb2NDyRyM2C89G9A+ba7xk7fC87vTaYGHResi0ImZk+/2xQABPkRizcjl36JotH5Cul5WxXGvMkBSI5UURj5Y/cQBRt68I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoihKZMy; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b152abf-f294-4707-9f3f-4b533eff15e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742289164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgB9M7yoKw825VEzOEsUDhDnmsaFYXbAr/vYWMtcHDM=;
	b=DoihKZMyRn4ejD2fwl2+QXZfNNyZy2BV+/VHsJZ4DYCvhSOBxpSLZeyR5sf0DTkk4n5v3L
	j0CCVe1dgtBxvhrO3WbfAXmDiFt1Og3lJNjjG8HPaxcAiEoyzW2G7eCChh4IWd85p2cqel
	aTIo2L5LeYny/fhCpzOT/sp3lclvXQs=
Date: Tue, 18 Mar 2025 17:12:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs: networking: strparser: Fix a typo
To: WangYuli <wangyuli@uniontech.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tom@herbertland.com, zhanjun@uniontech.com,
 niecheng1@uniontech.com, guanwentao@uniontech.com,
 Sourcery AI <hello@sourcery.ai>
References: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 3/18/25 3:46 PM, WangYuli 写道:
> The context indicates that 'than' is the correct word instead of 'then',
> as a comparison is being performed.
>
> Given that 'then' is also a valid English word, checkpatch.pl wouldn't
> have picked up on this spelling error.
>
> This typo was caught by AI during code review.
>
> Fixes: adcce4d5dd46 ("strparser: Documentation")
> Reported-by: Sourcery AI <hello@sourcery.ai>
> Suggested-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
>   Documentation/networking/strparser.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
> index 7f623d1db72a..8dc6bb04c710 100644
> --- a/Documentation/networking/strparser.rst
> +++ b/Documentation/networking/strparser.rst
> @@ -180,7 +180,7 @@ There are seven callbacks:
>       struct contains two fields: offset and full_len. Offset is
>       where the message starts in the skb, and full_len is the
>       the length of the message. skb->len - offset may be greater
> -    then full_len since strparser does not trim the skb.
> +    than full_len since strparser does not trim the skb.
>   
>       ::
>   

