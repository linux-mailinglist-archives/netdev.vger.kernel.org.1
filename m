Return-Path: <netdev+bounces-163909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95330A2BFF7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A793A1CBE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464711DDC20;
	Fri,  7 Feb 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0q7ywoP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079319ABBB;
	Fri,  7 Feb 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922031; cv=none; b=CDhZccQ03eVJ25tsBVzN4vgAS1nmrmpMbsvkp9YRQTLYuaQhVdSH5f3s0bYLht54uJezyZQRrg8srdoaDei51UHfMqgGO8vjZI+lsdtQ2PreZOkOehkgAjdkN4aM7bzhE81Xl0bEnsQsvCxmgKCKRZJ+M0LcPeVzyLTXP2cSxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922031; c=relaxed/simple;
	bh=hlTuVm1xxYrUR9UPnzCM2Z9PktNqKKSfUmGDWh3FPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ios/txeJns5KD6ZSXq8vl2D3gygdEfHicoXC5c+0AWWRO+95iwuxFrJHq9rPoz23dxD9E+u6tSF2mfmP40FNFTw6F7x5Id607WDwGef9rfer7UmxZLw6nre8KEUsIFQA5MrOv77lejwRZVYl/FMpePoRgpAkZq7WlgrTzm417KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0q7ywoP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738922030; x=1770458030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlTuVm1xxYrUR9UPnzCM2Z9PktNqKKSfUmGDWh3FPCs=;
  b=U0q7ywoPl7UkHnU5SHIrNGTuuyjot8QwmEW+P83FLrfgoxmlzDZprbXu
   u6jW+3SKTlcOZcPGk03QXXWgiSEyZNDNOGObrg8j+ybsd2zcMT4ADuC8D
   4jRA60OjONF4EEK03YBOdXw3/BMdMAqV/b9F2ghtQDbh7vOB3Ddvse3T0
   zAYHXtBTPgDt9fzznkzVcir0mB3XwSwbXCH1otgRp1UJ3f+fzBxpt0nSb
   F/vWiNHOufncPZf2Cvnc+SLgnUIig1djT7Oaj/6g7ewLTv4a1br3xL4Gh
   ciTk7W1D9JABZw7Z91e7gfkU4Z/ikr9wQieMx8R7mTE+Rcq13g8GNPi21
   Q==;
X-CSE-ConnectionGUID: QtkVWnLmR/GPFnc1qpU1NA==
X-CSE-MsgGUID: PyWjkGqXSgydnupqnKieVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49800804"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="49800804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 01:53:49 -0800
X-CSE-ConnectionGUID: WwnCJ8nBS7qhQMAwq3M/2g==
X-CSE-MsgGUID: wUf5a5DCSSSsebhSBlTGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112379199"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.39.73]) ([10.247.39.73])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 01:53:40 -0800
Message-ID: <ceb6cee6-9cfb-4363-9d23-dfd21f78d486@linux.intel.com>
Date: Fri, 7 Feb 2025 17:53:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/7] stmmac: intel: configure SerDes according
 to the interface mode
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 David E Box <david.e.box@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-5-yong.liang.choong@linux.intel.com>
 <c15078bf-b6f3-5b4b-82ca-668d47168ce0@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <c15078bf-b6f3-5b4b-82ca-668d47168ce0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/2/2025 9:31 pm, Ilpo Järvinen wrote:
>> +static int intel_tsn_lane_is_available(struct net_device *ndev,
>> +				       struct intel_priv_data *intel_priv)
>> +{
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	struct pmc_ipc_cmd tmp = {};
>> +	u32 rbuf[4] = {};
>> +	int ret = 0, i, j;
>> +	const int max_fia_regs = 5;
>> +
>> +	tmp.cmd = IPC_SOC_REGISTER_ACCESS;
>> +	tmp.sub_cmd = IPC_SOC_SUB_CMD_READ;
>> +
>> +	for (i = 0; i < max_fia_regs; i++) {
> 
> Usually, defines are used for true consts.
> 
Hi Ilpo,
Thank you for your feedback. I used const int max_fia_regs = 5; to leverage 
type safety and scope control in modern C. However, I understand that 
#define is a common practice. Please let me know if you prefer I switch to 
#define for consistency.

>> +static int intel_mac_finish(struct net_device *ndev,
>> +			    void *intel_data,
>> +			    unsigned int mode,
>> +			    phy_interface_t interface)
>> +{
>> +	struct intel_priv_data *intel_priv = intel_data;
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	const struct pmc_serdes_regs *regs;
>> +	int max_regs = 0;
>> +	int ret = 0;
>> +
>> +	ret = intel_tsn_lane_is_available(ndev, intel_priv);
>> +	if (ret < 0) {
>> +		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
>> +		return ret;
>> +	}
>> +
>> +	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
>> +		regs = intel_priv->pid_2p5g.regs;
>> +		max_regs = intel_priv->pid_2p5g.num_regs;
>> +	} else {
>> +		regs = intel_priv->pid_1g.regs;
>> +		max_regs = intel_priv->pid_1g.num_regs;
>> +	}
>> +
>> +	ret = intel_set_reg_access(regs, max_regs);
>> +	if (ret < 0)
>> +		return ret;
> 
> This looks much cleaner now, thanks the update.
> 
> However, the intel_priv fields you introduced are not setup until patch
> 6/7? Will this cause NULL ptr deref issues in between the two changes? By
> introducing the reg arrays in this patch but only use them after patch 6,
> you'll also get unused variable warnings out of them in between the
> changes which is unacceptable.
> 
Thank you for pointing out the potential issues with the intel_priv fields. 
I will move the changes from patch 6 into this patch to avoid NULL pointer 
de-reference issues and unused variable warnings. This will ensure 
everything is properly set up and used within the same patch.

