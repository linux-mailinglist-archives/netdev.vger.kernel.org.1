Return-Path: <netdev+bounces-223205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C3B584E7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04877188CFCB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195341DF27D;
	Mon, 15 Sep 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjvWzMGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27CBA3D;
	Mon, 15 Sep 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961978; cv=none; b=JOiXq7K1lh7PoNLqvWHfU2cI8JAXA6c6AE5X7BIv7SeRqXLu6U14ABMap+QNHQrfrOjveLlg+fRLaRLKyVVTcadaDDvaA1fMqB7joB0D8UK2hdeA/sIongxScsb8irO1+ROJFuzp2kbMs+9MJCBl8WdNptzY4m8XU0dAUf0W5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961978; c=relaxed/simple;
	bh=8Enwaklff3+aUmPFsL3nn4XqsbHDAjOcWjUIDZckYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKq/jYKKKXLmU0XA/CtGhDT8iv3/82sWTl3zUoMES400Y+0itInX0D+BkHsUjQKvgGhtLObpR7GlKjnlE4EpiTJ2dtZ2/neJJJfQnfbyucO0HxPg36ZCLavEVvAhEKumapfwlht1A7598NxqVXnNg4khZxn1uXrj3l/zzt2vkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjvWzMGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F93C4CEF1;
	Mon, 15 Sep 2025 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961977;
	bh=8Enwaklff3+aUmPFsL3nn4XqsbHDAjOcWjUIDZckYCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjvWzMGtBST0f/WqsXods2LLkel+oCCoIVpLrmtKva4ZoT+crErAhzFrWzpWTaAvb
	 PDJX3RnvLx8qGE4eVNgqf0QA8/UXlJt7Pu9/wfYt+JCFVg14Xl6NEJ0QDFSu/HqWXI
	 w32oWO1LRjDMRZYGsbxweRNEUwQ7uR1N61IqPdXa7yMzCCopXgGhft3TvO/6jrBf5A
	 y2C1gSctvhHG7NPKi245M0I1QLCEnoGlKkTVs4wNJ92997us6DHN66JHMLMVRexfxy
	 U814hK2EIPkBAZnrtr/C162TSgj8TZt2UNqGBFN+XcWnwAItALw5eskYZZSrhh+NoM
	 iTnDlWJ7WixPA==
Date: Mon, 15 Sep 2025 19:46:12 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: wan: framer: Add version sysfs attribute
 for the Lantiq PEF2256 framer
Message-ID: <20250915184612.GU224143@horms.kernel.org>
References: <f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu>

On Sat, Sep 13, 2025 at 11:13:26AM +0200, Christophe Leroy wrote:
> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

...

> @@ -114,6 +115,14 @@ enum pef2256_version pef2256_get_version(struct pef2256 *pef2256)
>  }
>  EXPORT_SYMBOL_GPL(pef2256_get_version);
>  
> +static ssize_t version_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct pef2256 *pef2256 = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", pef2256->version_txt);
> +}
> +DEVICE_ATTR_RO(version);

Hi Christophe,

I think this can be: static DEVICE_ATTR_RO(version);

Flagged by Sparse.

> +
>  enum pef2256_gcm_config_item {
>  	PEF2256_GCM_CONFIG_1544000 = 0,
>  	PEF2256_GCM_CONFIG_2048000,

...

