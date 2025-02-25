Return-Path: <netdev+bounces-169332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDAA437DB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974953AA748
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D225EFB5;
	Tue, 25 Feb 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="awJjbPIc"
X-Original-To: netdev@vger.kernel.org
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9B25EF99;
	Tue, 25 Feb 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.113.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472979; cv=none; b=KXPVv0FCaBZd7ALr2nHl11B+mKdfz//ErtifBdIJ81/QmpgHDs5brEY0iQxeSJMyimmPUcXbQj9kpxQaBJxyNQfcQcpEFcMI/bEygSg0xHUkfII3LRARKd/6dzNXWPnHJ0aeqJ7CcL6KflXrXMTXLGz5uT/hwyMlqDWDL0cSjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472979; c=relaxed/simple;
	bh=SvTIxBmHI5DMIMShUe39OEwtK1e9wQc7BfeYlCDczcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIoqi4WdLsQGwc2tN28MPZLqK/baL0xN3KY8IMinUKzQBtXJDUwrXqjIVYoYxgj9km8IK78x8+m9jSiSko3czDQRWug5fEI9rBTlNth53RI84I6gTRhWH24zRwjPMUeO+0cg2UFNuam69Pi8XTRa+1giABFS+FG1FFmOsI7YTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=awJjbPIc; arc=none smtp.client-ip=217.182.113.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 5C7473E8A5;
	Tue, 25 Feb 2025 08:42:49 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 069F24023E;
	Tue, 25 Feb 2025 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740472968; bh=SvTIxBmHI5DMIMShUe39OEwtK1e9wQc7BfeYlCDczcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=awJjbPIc/rkyrlun2vipC5Sk2sl9Qfm18DpZMffn1Ja9t1lZMgGlo5thyI8KQtaCk
	 2ZH1oG80paVWzwbcPELQbWVSn5+qL7hfA4L7YxyCeiO6Ql5MFtPHwR3V53JhOuDiGo
	 619uleMYufnJE5Vu1ACeTul7J5BjSYoiACP9t/Rc=
Received: from [50.50.1.183] (unknown [58.246.137.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id A5ADF40284;
	Tue, 25 Feb 2025 08:42:41 +0000 (UTC)
Message-ID: <4881179a-aab1-4d10-8917-665fffa66721@aosc.io>
Date: Tue, 25 Feb 2025 16:42:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] stmmac: Several PCI-related improvements
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
 Yinggang Gu <guyinggang@loongson.cn>, Feiyang Chen
 <chenfeiyang@loongson.cn>, Philipp Stanner <pstanner@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>
References: <20250224135321.36603-2-phasta@kernel.org>
Content-Language: en-US
From: Henry Chen <chenx97@aosc.io>
In-Reply-To: <20250224135321.36603-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 069F24023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,linux.dev,loongson.cn,flygoat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[chenx97.aosc.io:server fail];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]

On 2/24/25 21:53, Philipp Stanner wrote:
> Changes in v3:
>    - Several formatting nits (Paolo)
>    - Split up patch into a patch series (Yanteng)
> 
> Philipp Stanner (4):
>    stmmac: loongson: Pass correct arg to PCI function
>    stmmac: loongson: Remove surplus loop
>    stmmac: Remove pcim_* functions for driver detach
>    stmmac: Replace deprecated PCI functions
> 
>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 31 ++++++-------------
>   .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 24 ++++----------
>   2 files changed, 15 insertions(+), 40 deletions(-)
> 

I have tested This patch series on my Loongson-3A5000-HV-7A2000-1w-V0.1-
EVB. The onboard STMMAC ethernet works as expected.

Tested-by: Henry Chen <chenx97@aosc.io>

     Henry


