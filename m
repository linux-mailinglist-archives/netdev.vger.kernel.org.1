Return-Path: <netdev+bounces-238322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAEC57435
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C66B3A1D37
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5463491F9;
	Thu, 13 Nov 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fKSFphfR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B90345CC6
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034531; cv=none; b=q8PPzMZqEZ8TiYWBB0WAMcVUKlWK6PawjcSyWe8hjeivgdRFjcXJr2loYRU76qzb/pTKOsPUL2SU7vOPZnE1PFF3L5BigPC0x2GnH56WhqZ9KxHLJUCwTbnitL/uYg7mDDAR5Fm579XB0ZU6U+3z+SXiiUsApx7+2XXICYB3juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034531; c=relaxed/simple;
	bh=rshe4Y9K3TD4DqVqqxd4CPhZeTlaOd12ylbzuqXsFVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHVGykBCBWWcqgX+I2RmLDbo62GYf70WfwEzn4EwvT6CBFlnbDo/K5SnYlmm+GQO2pCkXn0JyzK2huhBFG3pUizn/3wOY/oqkEogsPPUfinW2GWf8zQNgdZs7Am5RNf2sIh4/MsGd8R+WZb6BSzKq6gU43kc9CeKfmsiXm5d8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fKSFphfR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 44CAC4E41682;
	Thu, 13 Nov 2025 11:48:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB0DF6068C;
	Thu, 13 Nov 2025 11:48:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 364B5102F2351;
	Thu, 13 Nov 2025 12:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763034524; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ctBc4upCgqzKeJAnk9xRDnJ5/kLYkjPG0jykALkFcYg=;
	b=fKSFphfRMoXTQ0hCbm1ZC+zPU9x35KzW0zgQCVqecpiOq6xEYaWdAIZgWBuZF8QPSrH1FX
	3YYtrjz5mnrq3z4tYS1VvV/OGySMGEChlnwlFEyJDXVbq5dwt/nGOKJJiqenF43f3N5PO5
	Cy1n3L8dQS0ygIIffIDzOsJVKq9HUvt1K/wy3r0GZnrfW3/FYlKtDxAkUFz9Vp6ZCMTP4G
	rZ0HqUf7mvbhYlwiqp5DoVAd4zM628y/u/ag8d60VzZf2BJkQLMTwf7geYjfcdWG5YqL1s
	BW5MJffQA8Q0v2iTR+gD7YnJg3fZ6Imtm97MLeP5ezTZaPpEXQw/8EHzYUCcNA==
Message-ID: <98560fc9-ca90-4c64-980a-472e49a77a13@bootlin.com>
Date: Thu, 13 Nov 2025 12:48:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Fix VLAN 0 deletion in
 vlan_del_hw_rx_fltr()
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, boon.khai.ng@altera.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
 <20251113112721.70500-2-ovidiu.panait.rb@renesas.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251113112721.70500-2-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 13/11/2025 12:27, Ovidiu Panait wrote:
> When the "rx-vlan-filter" feature is enabled on a network device, the 8021q
> module automatically adds a VLAN 0 hardware filter when the device is
> brought administratively up.
> 
> For stmmac, this causes vlan_add_hw_rx_fltr() to create a new entry for
> VID 0 in the mac_device_info->vlan_filter array, in the following format:
> 
>     VLAN_TAG_DATA_ETV | VLAN_TAG_DATA_VEN | vid
> 
> Here, VLAN_TAG_DATA_VEN indicates that the hardware filter is enabled for
> that VID.
> 
> However, on the delete path, vlan_del_hw_rx_fltr() searches the vlan_filter
> array by VID only, without verifying whether a VLAN entry is enabled. As a
> result, when the 8021q module attempts to remove VLAN 0, the function may
> mistakenly match a zero-initialized slot rather than the actual VLAN 0
> entry, causing incorrect deletions and leaving stale entries in the
> hardware table.
> 
> Fix this by verifying that the VLAN entry's enable bit (VLAN_TAG_DATA_VEN)
> is set before matching and deleting by VID. This ensures only active VLAN
> entries are removed and avoids leaving stale entries in the VLAN filter
> table, particularly for VLAN ID 0.
> 
> Fixes: ed64639bc1e08 ("net: stmmac: Add support for VLAN Rx filtering")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


