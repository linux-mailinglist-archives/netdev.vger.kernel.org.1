Return-Path: <netdev+bounces-279714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Hp7+FEYJ5mluqwEAu9opvQ
	(envelope-from <netdev+bounces-279714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:08:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB719429C70
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 998E83038797
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE20389453;
	Mon, 20 Apr 2026 11:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2F3815D6
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683198; cv=none; b=YIePoPQ7hbZ4RkPLF+QtEHVfREfZb+C/GmQY+ONZ/BYP5AjtDaWcMhGDKWzk8gJ0pilvifPMBnLmeWKEfId6a0i8S8U2K7vum7lseOWAYeCkKERgEOJCFyV+cv/KUtzVF5xYhTj0GF+fclcTFuy58yCNU1FBW9dWPyCBw9PBzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683198; c=relaxed/simple;
	bh=89xYmaXYt54tONc+OPOCcPYXFx7Vh5odHwv7v2erGZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih531Sbn0/M3EiIqhV88JVWChwCl9Nn1MibdGPvrfO9ww/PnzoBXt/m0dqMzDiZLYo4kzqq1wM2/Hia+LpRHMx7e6pEGV6UWrIhNu8n9Hz0ygbwEcL0hsPv+clt38xaHII4ffCHYOA0s/FHwmtBENjmaXsrFvpXnBNtoV3eyy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz15t1776683179t1882687e
X-QQ-Originating-IP: lBnI0r0z5UO3nWnYZprl58R168gjJuMCcluZI13ZSsg=
Received: from [192.168.254.128] ( [106.150.157.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Apr 2026 19:06:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4082574932268126283
Message-ID: <0A5279953D81BB9C+f50c9b49-3e5d-467f-b69a-7e49ed223383@radxa.com>
Date: Mon, 20 Apr 2026 20:06:15 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 0/9] r8169: add RSS support for RTL8127
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: ND3CPZxVFFQcRd7WNkj049S4TcbgolNRguJYRHExv1AAJujqtztbJWuM
	zO03n+qVyNjpgjtubv+I0dS7OZ/9fU5ixNvoww2byRCVMV0n+B8GnDB17ZeygytUhn4IX5Y
	WON5hjPFuPBzuHAFKZOmj35wQAnN1p1COQp4b8btgQWAR+X3B0Y+iIfdvCRye+5SmhqrW1a
	xXUsKZ/+4UTeBAUY6twicthsWCHhQOATvtSfoXCDLfm2LKysxaZWN9Z18Iq/Jl93YeepHs+
	dWAvITdSX7xOVtvIo4TPXztmRXHtI4SIbsMuFKSkHuooslI2Du/U+JOCn3PPWZXW2lgLisl
	QL0jI43nUoScdjfAuqsSOtyY3y6R/7cHYhkapOXSQ5BQCd29tmXzCF3jQPq1CkVGcP3jnCl
	11VSopbv5i+cI8Q0gdPsJnDCSmWrhzgVpL9Lpjx0VlQPwusUvjDCEF7Z7Zgsz+4goUNECBm
	3/xnqg78hUlONvNJwswS1EXzm8pJqXH2SuYsp0p/a4fw7HMKiHqGycv7eutdnpbPkfgAd96
	Pkfvwo1AW8jz5mxB6nqtmZkn+MJjCL0KiL6zTcsQ/XQoCQILh0NNY2ObYAw7tTpZMeJPSv5
	WSKeYM2dI+2rBqdh6lbalUtgf8CXLw+9N8Ut/L+cKDyNXbmYz4Wupi8TSUo0eu1H4NWLbva
	AGblU9ceKbPuKStb2n3WGErvPpZTOJMrjgCBFHP0kmyrFe3O+/l7YOJdtnDGyULQ2QigmLc
	wylshF1B0YtdwvJkKyeOYaM4cn8lKSzmtAqw42ij96BNf3ds+b35PC5PCg9uZwfQvuRVdXq
	iMisIohimk+iWnhltIYxxmup7B8L2zEgSVVmm5NTfmfP05vdE3ckNjC7xrHu7RsoxdnA/FX
	wRwVW+Ckrq6ppM/0t6hqkGiPGXFYpEDtWa0SV2QlDyBYud2ICGqUVCmhape/m/bS
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279714-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naoki@radxa.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.891];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BB719429C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Javen,

Thank you very much for your nice work!

On 4/20/26 11:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds RSS support for RTL8127 in the r8169 driver.
> 
> Currently, without RSS support, a single CPU core handles all incoming
> traffic. Under heavy loads, this single core becomes a bottleneck, causing
> high softirq usage and leading to unstable and degraded network throughput.
> 
> As a result, we add rss support for RTL8127. This RFC patch is just for
> discussing. And we do some experiments on AMD platform. Below is the
> result.
> 
> Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8 Threads)
> Arch: x86_64
> Test command:
>    Server: iperf3 -s
>    Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
> Monitor: mpstat -P ALL 1
> 
> Before this patch (Without RSS):
>    Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
>    8.2 Gbits/sec.
>    CPU Usage: A single CPU core is fully occupied with softirq reaching
>    up to 96%.
> 
> After this patch (With RSS enabled):
>    Throughput: Stable at 9.42 Gbits/sec.
>    CPU Usage: The traffic load is evenly distributed across multiple CPU
>    cores. The maximum softirq on a single core dropped to 63%.

Platform: Radxa ROCK 5T (RK3588: 4x Cortex-A76, 4x Cortex-A55)
Arch: aarch64
Configuration: smp_affinity is set to use only the big cores.

Vanilla Linux v7.0:
Throughput: 5.5 Gbps (4.3 Gbps with -P 20)
CPU Usage: ~100% on a single A76 core.

Linux v7.0 + this patch series:
Throughput: 9.4 Gbps with -P 20
CPU Usage: distributed across all four A76 cores.

Looks good to me!

Feel free to use:
Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Patch summary:
>    Patch 1: Adds necessary macro and register definitions for RSS.
>    Patch 2-4: Support NAPI and multi RX/TX queues.
>    Patch 5-6: Support MSI-X and enables it specifically for RTL8127.
>    Patch 7: Enables RSS for RTL8127.
>    Patch 8-9: Adds ethtool support to configure the number of RX queues.
>    
> Javen Xu (9):
>    r8169: add some register definitions
>    r8169: add napi and irq support
>    r8169: add support for multi tx queues
>    r8169: add support for multi rx queues
>    r8169: add support for msix
>    r8169: enable msix for RTL8127
>    r8169: add support and enable rss
>    r8169: move struct ethtool_ops
>    r8169: add support for ethtool
> 
>   drivers/net/ethernet/realtek/r8169_main.c | 1437 ++++++++++++++++++---
>   1 file changed, 1238 insertions(+), 199 deletions(-)


