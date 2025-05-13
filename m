Return-Path: <netdev+bounces-190160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E06AB55DD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B91C1B466CF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1528E57B;
	Tue, 13 May 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiDYDaun"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F51F151D;
	Tue, 13 May 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142493; cv=none; b=NQzXFLoR1egESL9MwWGQohGXdH8gIb1mAkF39CqWKyYgwfybcpzaDCn7lA9bCDNDYjEiPDmYWv2VOwuJ3K6IQ4Bs8JNGjcAah468vW+W0ZzRX7awJXOMDRqVJTS6JyTADKUhLymy38K8hbmPVoogkDN2tZNZo2ZJD97bqZUM+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142493; c=relaxed/simple;
	bh=5dffDf9PmzYG0Regdsf+hGkrpIjHmeqazNk/TmzOfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaaaceQmgEZvSF5q0TXNdIPHHpgBha2XKgBZamUEh78KZwXk1+U6hfp7jeMarTCaS8ZOPLUhxqGWrKfh6sDmx/w/MFZcc4/E2hbkU7jRYN4wO6vc9q/opb7akTFOxrvbVLCrEq+sx2mZQAwKq3+tBe28ASFDjozBKOHpcvqtvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiDYDaun; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747142492; x=1778678492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5dffDf9PmzYG0Regdsf+hGkrpIjHmeqazNk/TmzOfCA=;
  b=KiDYDaunmT2lqF8jJe4dbqQ71mhB8wsla5pujIBxrLnap862R+F80aKB
   iU5zniezs/qYRTo0VttIRxV83kggI7LNVvhuXZRX21s/aOVT0+l3bzpRJ
   8n6GWGfjoXBeO5gmUFu/RFHdnjC+ezi9Awx5p355Nv7tYNzRtlVuPRACz
   zZfS2VxMrBO5c/S+xInHGtbLTBl8Q5I9hOEtEGA7xGnfhBzhKwmcq6UFF
   YnICU0B6qhLmwdZD8nuLL/7HKD4dPJWK+M2Yw7HaGeWKXmQ0gG9O6UdUk
   aULBT9iDDHZPllU+bu7e9Z7ia/u3vASRLZx6hntGedGnynf6LA0WbpqQa
   A==;
X-CSE-ConnectionGUID: X+Cqe41XSKmagkzmfuTJGA==
X-CSE-MsgGUID: a7nbc20xTUKCBGHPU/mQbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66537730"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="66537730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:21:31 -0700
X-CSE-ConnectionGUID: Qd7J/lAsQY+9a3S9ZfTPEQ==
X-CSE-MsgGUID: HMxCdOBPQY+FmIGVVUcbdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="141756581"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.78]) ([172.28.180.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:21:28 -0700
Message-ID: <dbc58b6f-b15e-42d9-b4d7-344b9ab53f74@linux.intel.com>
Date: Tue, 13 May 2025 15:21:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
To: Zilin Guan <zilin@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com
References: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
 <20250513122441.4065314-1-zilin@seu.edu.cn>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250513122441.4065314-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-13 2:24 PM, Zilin Guan wrote:
> OK, I will resend the patch to the iwl-net branch and include the Fixes
> tag. Before I do that, I noticed that in ixgbe_ipsec_add_sa() we clear
> the Tx SA struct with memset 0 on key-parsing failure but do not clear
> the Rx SA struct in the corresponding error path:
> 
> 617     /* get the key and salt */
> 618     ret = ixgbe_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
> 619     if (ret) {
> 620         NL_SET_ERR_MSG_MOD(extack,
>                                "Failed to get key data for Rx SA table");
> 621         return ret;      /* <- no memzero_explicit() here */
> 622     }
> ...
> 728     if (ret) {
> 729         NL_SET_ERR_MSG_MOD(extack,
>                                "Failed to get key data for Tx SA table");
> 730         memset(&tsa, 0, sizeof(tsa));
> 731         return ret;      /* <- clears tsa on error */
> 732     }
> 
> Both paths return immediately on key-parsing failure, should I add a
> memzero_explicit(&rsa, sizeof(rsa)) before Rx-SA's return or remove the
> memset(&tsa, ...) in the Tx-SA path to keep them consistent?

 From the code in ixgbe_ipsec_parse_proto_keys() it seems that copying 
of the salt and key values occurs at the end of the function and only in 
case of success, see below.

---
if (key_len == IXGBE_IPSEC_KEY_BITS) {
	*mysalt = ((u32 *)key_data)[4];
} else if (key_len != (IXGBE_IPSEC_KEY_BITS - (sizeof(*mysalt) * 8))) {
	netdev_err(dev, "IPsec hw offload only supports keys up to 128 bits 
with a 32 bit salt\n");
	return -EINVAL;
} else {
	netdev_info(dev, "IPsec hw offload parameters missing 32 bit salt 
value\n");
	*mysalt = 0;
}
memcpy(mykey, key_data, 16);

return 0;
---

In my (limited) understanding the memset(&tsa, 0, ...) call in case of 
error after the ixgbe_ipsec_parse_proto_keys() is redundant, as there is 
nothing to clear in the tsa.key and tsa.salt. The rsa and tsa also 
contain the pointer to the xfrm_state and I am unsure whether we should 
clear that as well.

Please note that I do not have much experience with ipsec so take my 
opinion with a grain of salt. Best for someone more experienced to assess.

Thanks,
Dawid

> 
> Best Regards,
> Zilin Guan


