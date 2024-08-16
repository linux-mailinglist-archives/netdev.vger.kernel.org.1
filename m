Return-Path: <netdev+bounces-119244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68E954F59
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291901F22027
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58971BF315;
	Fri, 16 Aug 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlsKB8xy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708711BC076;
	Fri, 16 Aug 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827322; cv=none; b=PzIkDTJy2JsgcyJIDPkPkMFU1ejwRw44venu7VF4m6A6v0udGf75r6XuaqEhMvQIbRKfMeZ7DCvZ//9Yu4ryfJlkqSd+b4wNB4p3fNhh6/zHTh8u0QeTzCTEnrX//pFXEfb9lPPflqjR5L7/PwbcwlDC6STP1enM3e2+UXmlxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827322; c=relaxed/simple;
	bh=Yb/O3MOPE9ojAF1Gl5T6YhhJ0ucgUOcXE+p5BdAw+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXLGzpnarOh1mRKXE/A3/HMLtcl6t5VQQdmgbgajXzssiLqdMlEwF1Cq4vFFyElkfyVIq/Dy4Pfk2XNLLFfe2QVPIrYwAgoWyibmtxrKa0JwtdQQqDnFumETLgRsXVlcAMiJUIT5lsIwjp+4GrxAlWoiabEt4BFudKPwGZio0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlsKB8xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EDFC32782;
	Fri, 16 Aug 2024 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827322;
	bh=Yb/O3MOPE9ojAF1Gl5T6YhhJ0ucgUOcXE+p5BdAw+xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qlsKB8xyLffLmr6BPD7RGxcOkGMICfwkXiY8d1EYYxwDPV6Wbm4mbjEkHP0ezpAq0
	 YXHkjtA+qYJ4V5Epa8j52On1Ahp5YJqeXXBQokZf5ilnlGbSW9/s8evdLyMA8s/kpk
	 hfKActDjx8p6ymyPWxp+uTsfwHrBp0LGwRpPftHYi2NlkFgLR6UlAlKZPxtyNLzQ4o
	 jDMJP+I4RgnMByAtoxE8oibjrM5AIQufLlDNpBGizCORP0cgTPTNgqGCsvj3x0LTM3
	 93bxCWgjapyQCoEhW+gkJ0Z2ms6KMm/OZE16pnPM9zS0GWn3O/iIVMdaO/3iiD2HoV
	 Bx1eO0a5cmAIA==
Date: Fri, 16 Aug 2024 09:55:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
 <ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
 <vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
 <krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
 <Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
 <Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
 <linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 09/14] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Message-ID: <20240816095519.57b470b8@kernel.org>
In-Reply-To: <20240812102611.489550-10-Parthiban.Veerasooran@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
	<20240812102611.489550-10-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 15:56:06 +0530 Parthiban Veerasooran wrote:
> +		if (skb_queue_len(&tc6->tx_skb_q) < OA_TC6_TX_SKB_QUEUE_SIZE &&
> +		    netif_queue_stopped(tc6->netdev))
> +			netif_wake_queue(tc6->netdev);

FWIW I'm not sure you actually need a queue in the driver.
"A queue of 1" may be enough, IIUC calling netif_wake_queue()
will cause something like an interrupt to fire immediately,
and start_xmit for the next frame should get called before
netif_wake_queue() returns. I could be wrong :)

