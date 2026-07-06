Return-Path: <netdev+bounces-305030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tnhTJ7K0S2ppYwEAu9opvQ
	(envelope-from <netdev+bounces-305030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF99711990
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KXM+DUnL;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305030-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305030-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EEC3311B161
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8913ECBE8;
	Mon,  6 Jul 2026 13:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FD3EFFC6;
	Mon,  6 Jul 2026 13:14:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343649; cv=none; b=RwvxwR7WKLYTs4vx0V49HpRmEoh9An1U/rHErujHmTmLfZpD6bEleKV2dAl0gV/TwjrfUu/CmEKm7l7oW7hvJqLOEa1Ck5uAiga1q/DRzg6REH2059pDMVxoPES5BUYF+gjPwGNnlGm1zQMqenbO4FCRW56jrv1hA5kIwE5KH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343649; c=relaxed/simple;
	bh=/gzse8Hbg6PtoujjX4AgsuIwqG3oGT1yLJT6Vw3slKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrnC+HOWuqopjLlnAePqVdtVrpe2SrUmsJ8PQJyYru2uTw9u+4q36Qpw7y/A00a1OlVa5kPt7p82w775Luyhue5BASNicY9iiuy6Twr8l7Pk2Xg2MZdjucGlXudBOVyB936wi0ZUo8fHUlvkzRJc2UIaxFFj/OIgUxOQcx+gSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXM+DUnL; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783343647; x=1814879647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/gzse8Hbg6PtoujjX4AgsuIwqG3oGT1yLJT6Vw3slKo=;
  b=KXM+DUnL4MWuXk55ExkiTexIV8SC5R148UzYA34x6vtz1x7g05sQS3ZT
   vg7c1h0aySfK2FxPsJN75kgSyzfCKjK0YtdGEJyMaEhTvVZ3U13/PRlX4
   hCkJYzWDaXZcbC4PyeBhbqCUynxRx9hi+d8VLfCZuZAv4A2FwlVFmNLlg
   v1QCTaSGUEwPwIPtwmpF8rcXL/AbTy4cDQH54OOTgNto9z/djnN+Xr4eO
   znt/aN9T6xUPTtQPKQkOocCProdKlTHQrxnjCjLyvhD42kYq/C712uB/t
   Bw/IzjH9QceLuB+z8i/J/ON1YilIu8pV8Yrg+wRZityVXX6UAPsnrShzj
   A==;
X-CSE-ConnectionGUID: cfN2VTWGRL6t1FzRO3DvSQ==
X-CSE-MsgGUID: cyPHtlpTTG27Eb2BovGHgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101521527"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="101521527"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:14:06 -0700
X-CSE-ConnectionGUID: WQzG8MpsTY6n1o1gH5Jpzg==
X-CSE-MsgGUID: wJjsyAA6R2qcUYQWgyxI8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="251963225"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:14:06 -0700
Received: from [10.102.88.191] (soc-5CG4396XFD.clients.intel.com [10.102.88.191])
	by linux.intel.com (Postfix) with ESMTP id 8E28720C5DC7;
	Mon,  6 Jul 2026 06:14:03 -0700 (PDT)
Message-ID: <80a56d5b-da01-4ece-a7f4-56b357e654a7@linux.intel.com>
Date: Mon, 6 Jul 2026 15:14:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: validate E610 PFA TLV bounds
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
 <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305030-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[tomasz.lichwala@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:marcin.szycik@linux.intel.com,m:pengpeng@iscas.ac.cn,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.lichwala@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AF99711990



W dniu 6.07.2026 o 12:02, Marcin Szycik pisze:
> 
> 
> On 06/07/2026 11:25, Pengpeng Hou wrote:
>> ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
>> EEPROM.
>>
>> Stop parsing malformed TLVs whose header or declared value length would
>> exceed the PFA boundary.
>>
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> index 4d8ae5b56145..03e88bdf5a43 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> @@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>>  	while (next_tlv < pfa_end_ptr) {
>>  		u16 tlv_sub_module_type, tlv_len;
>>  
>> +		if (pfa_end_ptr - next_tlv < 2)
>> +			break;
> 
> This check could go in the while condition above.
> 
>> +
>>  		/* Read TLV type */
>>  		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
>>  					     &tlv_sub_module_type);
>> @@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>>  		/* Check next TLV, i.e. current TLV pointer + length + 2 words
>>  		 * (for current TLV's type and length).
>>  		 */
>> +		if (tlv_len > pfa_end_ptr - next_tlv - 2)
>> +			break;
>> +
>>  		next_tlv = next_tlv + tlv_len + 2;
> 
> Would be nice to define the magic number (2), since we're reusing it now.

There is a pending patch in review that defines IXGBE_E610_SR_PFA_TLV_HDR_SIZE, which fits perfectly here.

> 
>>  	}
>>  	/* Module does not exist */
> 
> Thanks,
> Marcin

Thanks,
Tomasz

