Return-Path: <netdev+bounces-101546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D48FF554
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654A41C251C4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206061FCD;
	Thu,  6 Jun 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="xsioIHNI"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E240BF2;
	Thu,  6 Jun 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702557; cv=none; b=j6Boera3KVOAe3XJCeo5QJOF/HLaSrVrQNArCfABCoPsctshdw6LHIf0muV8syg4/B790sYwseYfR5H2VR7pP0ZZa4qrkgGHjnm+CcbDhqAWNrSeyxHXOQAYtfP3nodYv6Z9ZvR43GIWouJXpyBdLBjkJeq3XDwnS7G1LUX9QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702557; c=relaxed/simple;
	bh=H27hoj1nfn9GzggmVmGwqXbjeJ4fcxrxqUBO0i0JXQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxZBmTxjsNFsLmRyQhHgyoDZ6YNBsR3otPV1l6LShncmkxSNrQy80ewmKpxvAU6SJbAJyz3BOksNykV8qinVO32Xz6Iv8FY/UL60Ash/AYSXe1QtpUVS3MuYJbBrfSaydMK9kmnIVKECRbDw1o8m2208KtONpqKR5VCZ+xm1D6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=xsioIHNI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VwF1F1F3Rz9sm2;
	Thu,  6 Jun 2024 21:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1717702545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ti/gtAOsi7bk/Co8d96IivmCKwGH4Pyj8tKfTA/ydc=;
	b=xsioIHNILiHEtEtsQrA7zTiRxRF6QESvmnAswAjyrczLA1q1Ap9w5naa2yl+prZ+/TLcWi
	PIDSS42BUxStAHMjBFOoExJ1iUzrweLb6VJjN0l5S+C6ko+3u0Jl4/z+EJvipTbkd/Eq/7
	jWaJzf1OL2AK9q46oVpYSSiecq+u6fMC/KxEOEpQ9u+SMriV6sOAa8wf1jMEXOlW7zgxRn
	ntG3gKYlNbiTqeoP9j4Lr1L6uuYyFzUhbpwv1iAYjHnpHDchZjA0EucqgUCUp63ryElIkk
	AgTMMgk16ryFApwjF7e3L0Bs9FP7FvQHxhMEEjXLnESK8vaTgGFrIXdHwaMIlg==
Message-ID: <90e5cb5e-6f3b-4a8d-825f-baa6bb1815d1@hauke-m.de>
Date: Thu, 6 Jun 2024 21:35:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 00/13] net: dsa: lantiq_gswip: code improvements
To: Martin Schiller <ms@dev.tdt.de>, martin.blumenstingl@googlemail.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606085234.565551-1-ms@dev.tdt.de>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VwF1F1F3Rz9sm2

On 6/6/24 10:52, Martin Schiller wrote:
> This patchset for the lantiq_gswip driver is a collection of minor fixes
> and coding improvements by Martin Blumenstingl without any real changes
> in the actual functionality.
> 
> Martin Blumenstingl (12):
>    dt-bindings: net: dsa: lantiq_gswip: Add missing phy-mode and
>      fixed-link
>    net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU
>      port
>    net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
>    net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
>    net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in
>      gswip_port_change_mtu()
>    net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
>    net: dsa: lantiq_gswip: Consistently use macros for the mac bridge
>      table
>    net: dsa: lantiq_gswip: Forbid gswip_add_single_port_br on the CPU
>      port
>    net: dsa: lantiq_gswip: Fix error message in
>      gswip_add_single_port_br()
>    net: dsa: lantiq_gswip: Fix comments in gswip_port_vlan_filtering()
>    net: dsa: lantiq_gswip: Add and use a GSWIP_TABLE_MAC_BRIDGE_FID macro
>    net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
> 
> Martin Schiller (1):
>    net: dsa: lantiq_gswip: do also enable or disable cpu port
> 
>   .../bindings/net/dsa/lantiq-gswip.txt         |   6 +
>   drivers/net/dsa/lantiq_gswip.c                | 110 +++++++++---------
>   2 files changed, 58 insertions(+), 58 deletions(-)
> 
Thanks for sending this upstream. I had this on my list for a long time 
but never started it.

For all patches:
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Hauke

