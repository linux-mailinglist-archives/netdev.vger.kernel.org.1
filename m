Return-Path: <netdev+bounces-227973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30FBBE47A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F004E3B67BB
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184D29B8C2;
	Mon,  6 Oct 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdoOKr1l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66211B5EC8
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759765; cv=none; b=PbDuTC37DCpJDHGk6V1Uh42W0N3QZGOXqXv0ONPy/IjBOov842G+0RaB68Sdsp+KgjthccPFt+RxzeLth45Tj7xSURscP/DAlntpptF+VfNU4UDrlA4Cz+CO5g/vz+MUrOTpKloST4fWGA4NTVCVEAW3r7r+CGJxmtBJHRQFjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759765; c=relaxed/simple;
	bh=Z2sG1ZMUE0N4JZiSEpyBe9xibv11tF9EmXkPsIFrvL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6SQXNTlICqBezRbn4OeCXwtwhtivZf/dbNAntrAfgWwKymgK4FBkXCYKj26zwbBwPJi6xDPtmWZsKIoUjlm/iyEwceGpDlEEp7qzW2cWxci/9UJJlkB0ATJUFkZSclrze4nGydfR5TxOiTY1/R4yBfEOyit5NZvndzUoIUPlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdoOKr1l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759759763; x=1791295763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2sG1ZMUE0N4JZiSEpyBe9xibv11tF9EmXkPsIFrvL8=;
  b=YdoOKr1lDH7y6z36Klg4RpCgj0iw6+eMc/42Tg280b7ZUliwgpgnhl2p
   SXaJmPop/MYr6QzTjjXQCAn4AeS9B6rrbfq8G1GxwjPdzyu3mhSCk3Vgz
   5VJzqdlrkuFauPgb8Q6wzdQTBKVAlqQqMqCSXDM9wFIkuyHBt6pchdBlr
   SWuHNI5LFBFckovPKPmNrBEFtyEagYJIdoANWrZc8nSCKrtWOe5xXFxjx
   r0Oz0gOiBZmRLm5VckSgAjQV4Q5ZB1mr8URfFb5h9DaPjMntLI21/FocM
   MUhsQMTANggSOnxF3zKDW+Iy1UbE/Z/fl4n82kj3zJ4Ub5I0TsiJanFZy
   Q==;
X-CSE-ConnectionGUID: qyukwfwuQiWs0/jF//V/Wg==
X-CSE-MsgGUID: M69H/TZpSrKkt+Va2TUEdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72607823"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="72607823"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:09:20 -0700
X-CSE-ConnectionGUID: rjmKuUTFRG+ePe5bpyMt4g==
X-CSE-MsgGUID: fsifdfJ1RHa7Pk0Bqht0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="183912201"
Received: from hlagrand-mobl1.ger.corp.intel.com (HELO [10.245.102.40]) ([10.245.102.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:09:16 -0700
Message-ID: <0a2efa67-0fb0-458a-970e-8957fffe63a0@linux.intel.com>
Date: Mon, 6 Oct 2025 16:09:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 0/3] igb/igc/ixgbe: use
 EOPNOTSUPP instead of ENOTSUPP
To: Kohei Enju <enjuk@amazon.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Auke Kok <auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>,
 Sasha Neftin <sasha.neftin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, kohei.enju@gmail.com
References: <20251006123741.43462-1-enjuk@amazon.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20251006123741.43462-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-06 2:35 PM, Kohei Enju wrote:
> This series fixes inconsistent errno usage in igb/igc/ixgbe. The drivers
> return -ENOTSUPP instead of -EOPNOTSUPP in specific ethtool and PTP
> functions, therefore userland programs would get "Unknown error 524".
> 
> Use -EOPNOTSUPP instead of -ENOTSUPP to fix the issue.
> 
> This series covers all incorrect usage of ENOTSUPP in Intel ethernet
> drivers except the one in iavf, which should be targeted for iwl-next in
> a separate series since it's just a comment. [1]
> 
> For igb and igc, I used a simple reproducer for testing [2] on I350 and
> I226-V respectively.
> Without this series:
>   # strace -e ioctl ./errno-repro
>   ioctl(3, SIOCETHTOOL, 0x7ffcde13cec0)   = -1 ENOTSUPP (Unknown error 524)
> 
> With this series:
>   # strace -e ioctl ./errno-repro
>   ioctl(3, SIOCETHTOOL, 0x7ffd69a28c40)   = -1 EOPNOTSUPP (Operation not supported)
> 
> For ixgbe, I used the testptp for testing on 82599ES.
> Without this series:
>   # strace -e ioctl ./testptp -d /dev/ptp1 -P 1
>   ioctl(3, PTP_ENABLE_PPS, 0x1)           = -1 ENOTSUPP (Unknown error 524)
> 
> With this series:
>   # strace -e ioctl ./testptp -d /dev/ptp1 -P 1
>   ioctl(3, PTP_ENABLE_PPS, 0x1)           = -1 EOPNOTSUPP (Operation not supported)
> 
> [1]
>   $ grep -nrI ENOTSUPP .
>   ./igc/igc_ethtool.c:813:  return -ENOTSUPP;
>   ./igb/igb_ethtool.c:2284: return -ENOTSUPP;
>   ./ixgbe/ixgbe_ptp.c:644:  return -ENOTSUPP;
>   ./iavf/iavf_main.c:2966:           * if the error isn't -ENOTSUPP
> 
> [2]
>   #include <sys/ioctl.h>
>   #include <net/if.h>
>   #include <string.h>
>   #include <unistd.h>
>   #include <linux/sockios.h>
>   #include <linux/ethtool.h>
>   
>   int main() {
>       int sock = socket(AF_INET, SOCK_DGRAM, 0);
>       struct ethtool_gstrings gstrings = {};
>       struct ifreq ifr;
>       int ret;
>   
>       gstrings.cmd = ETHTOOL_GSTRINGS;
>       gstrings.string_set = ETH_SS_WOL_MODES;
>   
>       ifr.ifr_data = (char*)&gstrings;
>       strcpy(ifr.ifr_name, "enp4s0");
>   
>       ret = ioctl(sock, SIOCETHTOOL, &ifr);
>   
>       close(sock);
>       return ret;
>   }
> 
> Kohei Enju (3):
>    igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
>    igc: use EOPNOTSUPP instead of ENOTSUPP in
>      igc_ethtool_get_sset_count()
>    ixgbe: use EOPNOTSUPP instead of ENOTSUPP in
>      ixgbe_ptp_feature_enable()
> 
>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Nice write-up and reproduction steps!

For the series:

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid


