Return-Path: <netdev+bounces-193862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEFAC6132
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C3A4A1338
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009E1FDA9E;
	Wed, 28 May 2025 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzUgQz4U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E41FBCB2;
	Wed, 28 May 2025 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409898; cv=none; b=Cr7sbIwNQuq7oyPMPa/bv/9OkN9zI3MBFZWUSUbm8gDi+TvcR/qO4w8QcHrh6S/4z7rB8pwVPh5lAv6MxmZtiSZh2tpywI5nMR+M2VuojtCoakCEWGrqficIRVajz4qOwqnWOsMibkaLmSjXgS5u0AT0/cmfSEV1I9G7P/Hor1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409898; c=relaxed/simple;
	bh=17rSp5U/xGeglZ8H7tF6/G2owk/7blSgg3sqoGfP+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlquwTCY5x6EnSwJF9Z9NJzzepLQZqgx+VUbaM+mc9016YhUyKQn1xD11Ww5Y8Lujp0Lhxjs5u+mSNI7JCuzwrp13esC43pN+i+VSfX+jlzoEAwGqOrqvefDgGiJz3sNo7VK1heYC7y2dPY2pVf6IZQW2Vk86r5n30YoGVAFGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzUgQz4U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748409897; x=1779945897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17rSp5U/xGeglZ8H7tF6/G2owk/7blSgg3sqoGfP+0U=;
  b=PzUgQz4UDGxfMrdLkkgOuYKNRqSJ6qEdO3IbvPgfhLQJCivJtnHGhset
   AxScILfjThtgkX3c1/7bp/WGYQa4qUJtwfFu9Wtmco8auhNsAvz7JRYWE
   FhP6KVf0MLJxh6iqKd12HmEmIP5P49HQgPW8oCnqHSUJktvAWdyWUMVrm
   /yPwq2M4pCFHU36CZm+V+wh2Wh8u0R6ifX5e0lHGShL9mLcBzIqZBjd4e
   LhQAR4OBL04A5ulH7424RjNgwzBB5n01WYp5oQ+2O/6YQsfWYk2M7BbKV
   b9vMmPZ2boet4xVXqIlQQRdoTmHpAI895DzfkMPSFyE4IjEbCpBwcB2tg
   A==;
X-CSE-ConnectionGUID: V+9exAmDTUmSLGT8exmKRw==
X-CSE-MsgGUID: smPf+JPhT9+E6vtb/OubsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50576507"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50576507"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:24:56 -0700
X-CSE-ConnectionGUID: 43PRHqaxS/iGGHO6XHx9aA==
X-CSE-MsgGUID: 9VBCuzvETsG4GSy2PbL5cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="142947801"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:24:50 -0700
Date: Wed, 28 May 2025 07:24:11 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v2 0/2] Add driver support for Eswin eic7700 SoC ethernet
 controller
Message-ID: <aDad+8YHEFdOIs38@mev-dev.igk.intel.com>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528041455.878-1-weishangjuan@eswincomputing.com>

On Wed, May 28, 2025 at 12:14:42PM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Updates:
> 
>   dt-bindings: ethernet: eswin: Document for EIC7700 SoC
>   v1 -> v2:
>     1. Remove the code related to PHY LED configuration from the MAC driver.
>     2. Use phylib instead of the GPIO API in the driver to implement the PHY reset function.
>     3. Align with the latest stmmac API, use the API provided by stmmac helper to refactor the driver,
>        and replace or remove duplicate code.
>     4. Adjust the code format and driver interfaces, such as replacing kzalloc with devm_kzalloc, etc.
> 
>   ethernet: eswin: Add eic7700 ethernet driver
>   v1 -> v2:
>     1. Significant errors have been corrected in the email reply for version v1.
>     2. Add snps,dwmac.
>     3. Chang the names of reset-names and phy-mode.
>     4. Add descriptions of eswin, hsp_sp_csr, eswin, syscrg.csr, eswin, dly_hsp.reg.
> 
>   Regarding the question about delay parameters in the previous email reply, the explanation is as follows:
>     Dly_hsp_reg: Configure the delay compensation register between MAC/PHY;
>     Dly_param_ *: The value written to the dly_hsp_reg register at a rate of 1000/100/10, which varies due 
>                   to the routing of the board;
> 
>   In addition, your bot found errors running 'make dt_binding_check' on our patch about yamllint warnings/errors,
>   it looks like the validation failure is because missing eswin entry in vendor-prefixes.yaml. 
>   When we run "make dt_binding_check", we get the same error. We have already added 'eswin' in the vendor-prefixes.yaml 
>   file before, and the code has mentioned the community, but you have not yet integrated it.

Usualy description is above the changelog. Please try to follow 72 line
length rule.

net-next is closed, you should resend it when open (after June 9th) [1]

[1] https://lore.kernel.org/netdev/20250527191710.7d94a61c@kernel.org/T/#m0bc90575288f5f1bcf5e50ecff59fb904b79505c

> 
> Shangjuan Wei (2):
>   dt-bindings: ethernet: eswin: Document for EIC7700 SoC
>   ethernet: eswin: Add eic7700 ethernet driver
> 
>  .../bindings/net/eswin,eic7700-eth.yaml       | 200 +++++++++
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 410 ++++++++++++++++++
>  4 files changed, 622 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> 
> -- 
> 2.17.1

