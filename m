Return-Path: <netdev+bounces-304953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ILrJ6SKS2qJVAEAu9opvQ
	(envelope-from <netdev+bounces-304953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FBD70F932
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:59:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=U4VpjV0G;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304953-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304953-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E356332EED0
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45A35AC09;
	Mon,  6 Jul 2026 10:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903D30C637;
	Mon,  6 Jul 2026 10:02:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332155; cv=none; b=SXUmS3QnEQOSB53CSrTFgHZQg9xZ/MuAg6ivmwUtisL4T7P1qKZVH3zHOHyV8hWGv8ZS3giOrGMa69JJRCUbEq/vICl7DImqeQlqXnRqb26vxov+24ZMcFSJljvAg6NL+euYm3q7NyZoxHHIHIpHtNUb+b49QRFrjf4YkQXShLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332155; c=relaxed/simple;
	bh=9qm6US3OrG2rDjRIGBpWm7uNjbIkQkBQoEZAQyT/jcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5Pfdh+6JGxzTmOpITGmtiZrWzrQTJuL51+J96NozadzutD6xgp1pAksLV5/rwXd/qE6JG1rYO2hFzXb3HvXMTY60KmyK6yHrod2NvZMrnb6P98Ofh1j6ZRyP92+Evk5IXfdF8uY7ZgsCs/h38U0Dtbkr9s6mdW5f6uZ7sjXeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4VpjV0G; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783332154; x=1814868154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9qm6US3OrG2rDjRIGBpWm7uNjbIkQkBQoEZAQyT/jcA=;
  b=U4VpjV0GpCF8NS1Day4UD7qsex6P5MY7p4yUBr2wr5UJ8u6+emtafqyO
   P9Ikr+X/p/HFgL0FTuFhUInOxuDxfrDICHwuBoZ6yZkDdvWLztrGTgbVl
   Y2YHnSv18i7zBW6z+Du5juuCEzjJaLE3JgAs6g0BwO2Igv9Ex9pV1PR1H
   GYD7uZ+Nf2z7HY7shUNnLPiRsGRzQEjMOFZzOWcoxuHjAi82oLtsX1e4V
   iUOpLonyCwAaWMwxNR16POmzIFc4tnGxu24pmoAp8ZEjKN3/1o+a3Jkrq
   p4Cmy2QbV32zhFtUnypOrKzz+P4e8KWT2VMxGhrECvTpfsANv5RWF+Tb6
   g==;
X-CSE-ConnectionGUID: gVi1njmlSVOIHf7311Wfmg==
X-CSE-MsgGUID: g9uZWoM2REmZYndl2bIc1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84055363"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="84055363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 03:02:34 -0700
X-CSE-ConnectionGUID: Afkzqs84QcGnajqTOJ2OWQ==
X-CSE-MsgGUID: GcR4ICQ3T3eN2tYPofjV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283768848"
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 03:02:31 -0700
Message-ID: <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Date: Mon, 6 Jul 2026 12:02:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: validate E610 PFA TLV bounds
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3FBD70F932



On 06/07/2026 11:25, Pengpeng Hou wrote:
> ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
> EEPROM.
> 
> Stop parsing malformed TLVs whose header or declared value length would
> exceed the PFA boundary.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 4d8ae5b56145..03e88bdf5a43 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>  	while (next_tlv < pfa_end_ptr) {
>  		u16 tlv_sub_module_type, tlv_len;
>  
> +		if (pfa_end_ptr - next_tlv < 2)
> +			break;

This check could go in the while condition above.

> +
>  		/* Read TLV type */
>  		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
>  					     &tlv_sub_module_type);
> @@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>  		/* Check next TLV, i.e. current TLV pointer + length + 2 words
>  		 * (for current TLV's type and length).
>  		 */
> +		if (tlv_len > pfa_end_ptr - next_tlv - 2)
> +			break;
> +
>  		next_tlv = next_tlv + tlv_len + 2;

Would be nice to define the magic number (2), since we're reusing it now.

>  	}
>  	/* Module does not exist */

Thanks,
Marcin

