Return-Path: <netdev+bounces-197032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD484AD767B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF207B57E7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886082C325A;
	Thu, 12 Jun 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B2qosYu+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657C2BF3F9;
	Thu, 12 Jun 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742331; cv=none; b=otj8bUlStZ5tCYBup/eF4Jxlh5hGtgf3OGOH5pOXq3SqRJu8FuXqYtXw/FHOXHI33vfvBzzLKJwKJM/sFqCGTZZ1CNEaPAzAHADbFs2wDjOrEBQIncQUPVZBHcFKtLf/zGJDIL7jAiqJ/omjw3ywdJNbya1QU2EYW3nGPKpGLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742331; c=relaxed/simple;
	bh=5PV+jOeEc6M5rMfrO2WVc1PW2rGtHnpqpCCs2fKhF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa9Hqm+L5M7X+ygGg3m0/hTiDb4ixvpX3RS8IpAyRDDbibwnAbM02uCMJAb/dCj55EAgpP0kXZ7qNGJfsLuWZwS6/arpUXQyrML+XKeZjF/AHFEVxZ4Mnh4Kr+HOrNYkn3TFyF3UwjWU3iP7IDA815HwT5P06qD+Rtxe3WsUvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B2qosYu+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=STSk0/Pp53STkxsJ2uC08Ifb3MPW7vNpEjKmTxWJIX8=; b=B2qosYu+6KqYewsmy/RV+3y2TH
	ZOd7C053W7apTgLKzCe3JOoKjw01irsa6bti8pJNU3c1NlVJWSEfH8X+wgAomC3AUrq8TuBZA8WFU
	CY8E7Z38v8FNwpKjj8eLvCarMWGmQqUCMQ5BM/TUip1zoPnfvI9fNY/V4ULTbJ+lS5LM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPju6-00FYla-CO; Thu, 12 Jun 2025 17:31:46 +0200
Date: Thu, 12 Jun 2025 17:31:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v2] net: phy: Add c45_phy_ids sysfs
 directory entry
Message-ID: <737294c1-258f-4780-80f8-e7a72e887f8b@lunn.ch>
References: <20250612143532.4689-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612143532.4689-1-yajun.deng@linux.dev>

> +#define MMD_INDICES \
> +	_(1) _(2) _(3) _(4) _(5) _(6) _(7) _(8) \
> +	_(9) _(10) _(11) _(12) _(13) _(14) _(15) _(16) \
> +	_(17) _(18) _(19) _(20) _(21) _(22) _(23) _(24) \
> +	_(25) _(26) _(27) _(28) _(29) _(30) _(31)

Is 0 not valid?

> +#define MMD_DEVICE_ID_ATTR(n) \
> +static ssize_t mmd##n##_device_id_show(struct device *dev, \
> +				struct device_attribute *attr, char *buf) \
> +{ \
> +	struct phy_device *phydev = to_phy_device(dev); \
> +	return sysfs_emit(buf, "0x%.8lx\n", \
> +			 (unsigned long)phydev->c45_ids.device_ids[n]); \
> +} \
> +static DEVICE_ATTR_RO(mmd##n##_device_id)

This macro magic i can follow, you see this quite a bit in the kernel.

> +
> +#define _(x) MMD_DEVICE_ID_ATTR(x);
> +MMD_INDICES
> +#undef _
> +
> +static struct attribute *phy_mmd_attrs[] = {
> +	#define _(x) &dev_attr_mmd##x##_device_id.attr,
> +	MMD_INDICES
> +	#undef _
> +	NULL
> +};

If i squint at this enough, i can work it out, but generally a much
more readable KISS approach is taken, of just invoking a macro 32
times. See mdio_bus.c as an example.

    Andrew

---
pw-bot: cr

