Return-Path: <netdev+bounces-172645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C72A559BF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94263B1691
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838F27C850;
	Thu,  6 Mar 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXrYt4Jr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B6208990;
	Thu,  6 Mar 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300124; cv=none; b=KcsDMAzlolJo4GiAEzFUabtYo/weVrKxv3JrLskxo8dzBOnkgaETv5YwZf5vsEB2jVf+9iJ+qd2gSnolZW4Uvsj9IgtJSxOwFMk7HYSkn1/WrUBt0lHEDaCma+VhyQlPCqvd56oRfFTXmY46aJWSr7sQcPae5qmiSO4m5dkVEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300124; c=relaxed/simple;
	bh=2ABLlxIoMSQNDKV1phjvCwSi0BkSICv6/GcMMhHQews=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+J9Q6KHZ8IbdKTBt0ZS1BcxXzR45KOn8GLPOYmLXvOS98q6PeG/PeAyMz2WXQ3XypyvBEA7ezQxHM4SD7eWH9tBmbvGqfkseSmDPkMRo+FeVwWIwSspB8YMEblwaSmZjaRPGMmutGWtR+O7fhFZ0ljgyr5mp+Eqs5ewqonhyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXrYt4Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC2C4CEE0;
	Thu,  6 Mar 2025 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300123;
	bh=2ABLlxIoMSQNDKV1phjvCwSi0BkSICv6/GcMMhHQews=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HXrYt4Jr8Ujw+I6ULk6lGN2aJq67C6kOW7bkoi+HYdokVxAaUNiqBmlKFwKMIrUzV
	 /r+awFkHB42epS4kjHahTJMSz8SCh5iVUfVp7FUF05c4R3e9WFYlvMcQd6pvb/PIRG
	 RPh6M60eNx8EDbdYyajwTtECC9oIg1VLkSS2sAtzN1NhfrH6nFqXSNLOwz3GkCZA6+
	 KBsYqC6pbbEcQeaiauNhnDRWjLY/616Ldj2jYEknJuPovaqTvDRBAhnxlU1dt3Clii
	 EjJjm2Sm/NmPQXdT+3s2pzy3QpcISUN6EqKKfSGJqwg5Ac6K0ooKjpz/lAeLt3vPaX
	 XCTRScQhSUdUA==
Date: Thu, 6 Mar 2025 14:28:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 01/13] net: enetc: add initial netc-lib
 driver to support NTMP
Message-ID: <20250306142842.476db52c@kernel.org>
In-Reply-To: <20250304072201.1332603-2-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 15:21:49 +0800 Wei Fang wrote:
> +config NXP_NETC_LIB
> +	tristate "NETC Library"

Remove the string after "tristate", the user should not be prompted
to make a choice for this, since the consumers "select" this config
directly.

> +	help
> +	  This module provides common functionalities for both ENETC and NETC
> +	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
> +	  flower and debugfs interfaces and so on.
> +
> +	  If compiled as module (M), the module name is nxp-netc-lib.

Not sure if the help makes sense for an invisible symbol either.

>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -40,6 +50,7 @@ config NXP_ENETC4
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
>  	select NXP_ENETC_PF_COMMON
> +	select NXP_NETC_LIB
>  	select PHYLINK
>  	select DIMLIB
>  	help

> +#pragma pack(1)

please don't blindly pack all structs, only if they are misaligned 
or will otherwise have holes.

> +#if IS_ENABLED(CONFIG_NXP_NETC_LIB)

why the ifdef, all callers select the config option


