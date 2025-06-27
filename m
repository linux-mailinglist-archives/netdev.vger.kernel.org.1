Return-Path: <netdev+bounces-201782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0012AEB06C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC24E1F9E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F4212B28;
	Fri, 27 Jun 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RnclplwY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFC18A6DB;
	Fri, 27 Jun 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010397; cv=none; b=sz7FIPjjfMHpaQU9cU7jzvkaaQQFkLZtIWHfwCR9ataQES1QLIvWKwg7ObLvY+bbZdzVaFG3p7BGVnTn8gkfWBs7rdlM6/6f4W0kWn9cN1X2FfzBIt/qoQKEIvtD1JjnZQhGSt43QNDuEGz5nd2Y9KC3p+p9OMaqOTejT5e692o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010397; c=relaxed/simple;
	bh=MjnuYsr9mMsW2TxJ7qqc2j1p+0Vn25jzjwjGDbMIb1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1iLBJFc+iN8TcYykJe6E6PKGU5vtSF1ykwi7PNpCDzDQ+ROtwU0r/WV/l3xAJ3ETESk46B4hVcNYgHjW1Ddm2lE7LkfQtH6OeMSCsxzQ0RnDh1uTxTl1IAVmBn1Qxy1934x7QqB8ITeeadowA4oSD8873MRuAakHo9ugugO9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RnclplwY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sW+Hs3IzTA2qyhfGPDj9o95ND8i+/JEitbctsHCJl1o=; b=RnclplwY03mQ/Ay/NxJ/7P8Aro
	Ik6w6leKGbJnlwUEsLFdXi5OfvEyl/Mo1J2fgMj9CsPbPAi8+x6aKIwejF/kyIZUrI2lgwqkf+VS+
	0kdsn2sd3wbirOYxaURPw9Cx4kUIfEZUkLzrqd27SOEoSJOR6s+gjrjoMcv5NpynDgFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uV3n0-00H7Pq-TD; Fri, 27 Jun 2025 09:46:26 +0200
Date: Fri, 27 Jun 2025 09:46:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <69ee8a60-3134-4b7a-8217-be9bbc79a8fa@lunn.ch>
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627072921.52754-1-guwen@linux.alibaba.com>

> +#define DRV_VER_MAJOR		1
> +#define DRV_VER_MINOR		3
> +#define DRV_VER_SUBMINOR	0

> +#define LINUX_UPSTREAM		0x1F

> +static int ptp_cipu_set_drv_version(struct ptp_cipu_ctx *ptp_ctx)
> +{
> +	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
> +	int version, patchlevel, sublevel;
> +	u32 env_ver, drv_ver;
> +	int rc;
> +
> +	if (sscanf(utsname()->release, "%u.%u.%u",
> +		   &version, &patchlevel, &sublevel) != 3)
> +		return -EINVAL;
> +	sublevel = sublevel < 0xFF ? sublevel : 0xFF;
> +
> +	env_ver = (LINUX_UPSTREAM << 27) | (version << 16) |
> +		  (patchlevel << 8) | sublevel;
> +
> +	rc = cipu_iowrite32_and_check(ptp_ctx->reg_addr +
> +				      PTP_CIPU_REG(env_ver),
> +				      env_ver, &regs->env_ver);
> +	if (rc)
> +		return rc;
> +
> +	drv_ver = (DRV_TYPE << 24) | (DRV_VER_MAJOR << 16) |
> +		  (DRV_VER_MINOR << 8) | DRV_VER_SUBMINOR;
> +
> +	return cipu_iowrite32_and_check(ptp_ctx->reg_addr +
> +					PTP_CIPU_REG(drv_ver), drv_ver,
> +					&regs->drv_ver);
> +}

Please could you explain what this is doing.

	Andrew

