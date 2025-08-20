Return-Path: <netdev+bounces-215397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52254B2E69A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBFE5C4D48
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0EA286402;
	Wed, 20 Aug 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="47i0tBrA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01527284670;
	Wed, 20 Aug 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721850; cv=none; b=o2NROUyRsQkKjL2N6PxXl5ii5KLpIcvmFV9h3x9hXPS5nfzYV+wfJuI40zjXWJkMR8L976rbDuLdCRQtHXV3eUHLdLCf6O7NIlbOEw5GXJgADNiVAuNpjWjCh1JEqQN9sy4BwPyYwcHQq7fSAWbcJ3b8I/xrCXd8H11esuI/+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721850; c=relaxed/simple;
	bh=+rER9/1AsBG0BZElfTi6bfvzsdtE9QyG2LEN6eLMips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWlTnUdgKbXD/ixN6xgx/l1IEUtZE5vV96DamguSS2k4xXLOUmZD2dHAB0HbzZnwLTJQCLyPtJdfvlVcw6GEh0AgTXYJ2DDqL8c3ff6xB/OlFDBOULxKdVl+VPStxKqKvsT0hwv2iMHtwG6jSqJqz/e3gfS1CIXWE+9sWczZ+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=47i0tBrA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L4dObC7bK0uM6jRn2ku/4P9Xp7/Krl5DFUuNxzB1NvY=; b=47i0tBrA9n8YYdUNuYHdPVXGpx
	ykdqEXklK3ZzIX0hto3k/20efD5M5Z5zy7roPMAS7fMeVgzCe2h8PHEXbLA+ssiMAwRWdkrZQx75W
	SUqi9rNwGz25xgmkJeK/yn80zzMfCbz8kSJme7KuPv7SnriiX5JJLOd/foQX50LAsYss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uopRp-005MeP-0u; Wed, 20 Aug 2025 22:30:17 +0200
Date: Wed, 20 Aug 2025 22:30:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <399be32e-5e11-479d-bd2a-bd75de0c2ff5@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-5-dong100@mucse.com>

> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> +{
> +	struct hw_abilities ability = {};
> +	int try_cnt = 3;
> +	int err = -EIO;
> +
> +	while (try_cnt--) {
> +		err = mucse_fw_get_capability(hw, &ability);
> +		if (err)
> +			continue;
> +		hw->pfvfnum = le16_to_cpu(ability.pfnum);
> +		hw->fw_version = le32_to_cpu(ability.fw_version);
> +		hw->usecstocount = le32_to_cpu(ability.axi_mhz);

If you can get it from the hardware, why do you need to initialise it
in the earlier patch?

I guess you have a bootstrap problem, you need it to get it. But
cannot you just initialise it to a single pessimistic value which will
work well enough for all hardware variants until you can actually ask
the hardware?

    Andrew

