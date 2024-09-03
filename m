Return-Path: <netdev+bounces-124678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E596A6E1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E09284510
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84F01917D0;
	Tue,  3 Sep 2024 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HVFY71wc"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC3188902
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389322; cv=none; b=CS8GJnHmh2CHRuX3fzUtUwQ/AbxQMq/DCdDwKvohUBF8hg/90Cw7X6BZC7z/LB8I04VlXqy04bCiQvbOKOlXSWEOYhPRlOu9J4D13ISX0fXcnqw2Ev6AJZdMlwC6xhrActOrfaNoTFmpri51Q+mruTY5flo9qyJCcwlz4Q8J1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389322; c=relaxed/simple;
	bh=Vz0i0nmvoxTTaTcZ3N5EpsBT1ALX2DScY26hAkGYbHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5wInI1o26caDR7V2zi7tWMw0l5aHFUXJv5tjDUaCh9Jufn6PsNqwqvko0v1pCpr5hOEfDXjAu/cTgaCVceu6+yyc0uDlwpkS8/E8xG8H6h1IS73OaESH2Ng2kuEa1onAnLAi0O+SfKfMjCwJxHNbs3tqCiXtExStLKSPrnfULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HVFY71wc; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <494872db-6cd4-4cce-b35c-cd767c162c4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fES1ERLGRMZf8VPMNQDV4nqHUUyYR1CV/nFk+Eg7qqk=;
	b=HVFY71wcDMnkmxSLKyVC/SkD1Qs6LEIDLJcKsDnhDB+UnQ/6ZSDgotx5rW+GOCSX9sV6xO
	+AMY7mvyjRUxoz1se3MTAQ5a3J91h7ZPJykW7U8xpfCPr1+CToliY7Y45d2P/XmNG+N3B4
	Or1ctGLq9zx1MpDK+AAXOT9BS3nlyjI=
Date: Tue, 3 Sep 2024 14:48:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] net: xilinx: axienet: Partial checksum offload
 improvements
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/3/24 14:43, Sean Anderson wrote:
> Partial checksum offload is not always used when it could be. Enable it
> in more cases.
> 
> 
> Sean Anderson (3):
>   net: xilinx: axienet: Remove unused checksum variables
>   net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx
>     checksumming
>   net: xilinx: axienet: Relax partial rx checksum checks
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  5 -----
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++----------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 

Sorry I forgot to add this to the subject, but it should be for net-next.
I can resend if necessary.

--Sean

