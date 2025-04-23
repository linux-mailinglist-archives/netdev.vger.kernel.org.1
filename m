Return-Path: <netdev+bounces-184984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB5A97F64
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290AC189A790
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C506266B55;
	Wed, 23 Apr 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="g8wNaRfc"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB81EF38E
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390366; cv=none; b=Rs0JmuvEH+NqNkHGoa3bY/qU+FIEx2U4Ybx1gSTt3lq4bcnijRDj0wVvVDg3k1dL+RiTS79MEmyS1FpQwnFTx7exwN6h1EYosubjQLJEXgw0GC8islqEiIY2SiMHLgcKah57laU6/6d3p2+w8MckHfrQjsXfIla5IVwLjETXpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390366; c=relaxed/simple;
	bh=Cr1h5rbLJ8qV7Vf++T+SdTHJVkx4HoIoWpukUt2WFQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIlVqTKj3yk4NgjYgjuBh5Ad+27bQQfg0TdiS3WElwTqFNOouvYlvGQQAlrzWTmBoSAtQU4ZpG7SolHUAel5QETW/+4zek5WgZroTBlFPV/RZk5VZ2hTBVWRHngW3/0wFyzhA9FYImPlmbSIAxNSLGuqbqybHr4XuoRCMWQZXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g8wNaRfc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=aE/bfOgnUy7S/NJlZ54EY7E0OtFBouF9DxmozZpy7xU=; t=1745390364;
	x=1745822364; b=g8wNaRfcR+tMsoTC5QLNG5SnIiUl66WudTcRn3/dPE93uGQvKWniuv7fWHPen
	Yc/2h+IEiL4VfIFgz+459+3t4ReziyeXK8w5tPO23Pju8O88W3YPC19YxmfA2eKznT4YmFcOvYrQz
	JkAL4iXYzYlixuqFowSWyxb3RuXTQjBHA8Gci3w1/3iHLWAbHKtiOt6lLx04hx5jH52hOQFwFXaxE
	Fs/9J1MiT/ZMJ4AJW2inTjPt9snzHm3qAoIsyssK3ZKqzNr4Mtt+WszB8xIARh2EO1kw54ogCEKbs
	HzqAuurW7NSxrhBqv7+ZxXv/5Iy0eayKZ3SPmV0g3lHs6kFX0g==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1u7TKL-00137N-2u;
	Wed, 23 Apr 2025 08:11:22 +0200
Message-ID: <e903cf91-6e88-45e7-a388-8b40c11ed45a@leemhuis.info>
Date: Wed, 23 Apr 2025 08:11:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: Change FW message timeout
 warning
To: Louis Peens <louis.peens@corigine.com>,
 Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
 <20250417172448.1206107-2-michael.chan@broadcom.com>
 <aAeosU3V02vWxD7Z@LouisNoVo>
Content-Language: de-DE, en-US
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <aAeosU3V02vWxD7Z@LouisNoVo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1745390364;e571c1cf;
X-HE-SMSGID: 1u7TKL-00137N-2u

On 22.04.25 16:33, Louis Peens wrote:
> On Thu, Apr 17, 2025 at 10:24:45AM -0700, Michael Chan wrote:
>> The firmware advertises a "hwrm_cmd_max_timeout" value to the driver
>> for NVRAM and coredump related functions that can take tens of seconds
>> to complete.  The driver polls for the operation to complete under
>> mutex and may trigger hung task watchdog warning if the wait is too long.
>> To warn the user about this, the driver currently prints a warning if
>> this advertised value exceeds 40 seconds:
> 
> Hi. Sorry if this is noise - but I have not seen this reported yet. I
> think this change introduced a config dependency on 'DEBUG_KERNEL'. As far as I
> track the dependency chain:
> 
>     DEFAULT_HUNG_TASK_TIMEOUT -> DETECT_HUNG_TASK -> DEBUG_KERNEL.
> 
> I have a 'local_defconfig' file which I'm regularly using for compiles,
> and I had to add all three these CONFIG settings to it to be able to
> compile again, otherwise I encounter this issue:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: \
> error: 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT' undeclared (first use in this function)
>       max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Perhaps this was on purpose, but from what I can tell on a quick scan I don't
> think it was.

TWIMC, I yesterday ran into this myself with my daily -next builds for
Fedora, too. Log from the build can be found here:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-42-x86_64/08951548-next-next-all/builder-live.log.gz
Enabling DETECT_HUNG_TASK and DEFAULT_HUNG_TASK_TIMEOUT fixed it.

Randy (now CCed) reported the problem as well:
https://lore.kernel.org/all/8ba27b19-6259-49d3-a77f-84bfa39aa694@infradead.org/

Ciao, Thorsten


