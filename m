Return-Path: <netdev+bounces-282960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBkNDJiP82ky5AEAu9opvQ
	(envelope-from <netdev+bounces-282960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09354A6497
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3891300130C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931C47277D;
	Thu, 30 Apr 2026 17:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80833F59E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569676; cv=none; b=JLGehyFdsRh+14wICkjVrw8tVTFoeIOLna2iBj9LsCWvrbEOz1w5P6AkJLCwm79QEULdB0511hMtQDkeePfItVrH8Jz5zQco1auzLW9ePZ8Ab8mqq22FQ9fEl+ljg9pnmPagydRV7rE6SCungK/C5g5MZUWbiQ+XxhCwGAu1wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569676; c=relaxed/simple;
	bh=dDk/opa2+T2emR/G8A+f4v+AuEOKkTGYYeN87SteDLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUf3GS8rWezrngrbsCZCot9pNiPXrqy8sU8Y7W+STHJMMs9fcNaJushVn7b2pJ5tbFvVFdmo+6IsGjTLbhz1i7yTr1eKxQS3lIxjsogF/7uo6XRYufO09LMbv0ZQGj+fUuSaABY9g9XeiZ0wk2ZgpTWoDEHc1W0fIO3bmPuktt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.251] (unknown [185.238.219.95])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 611884C2C37F04;
	Thu, 30 Apr 2026 19:20:58 +0200 (CEST)
Message-ID: <1737f22d-1eca-4dee-95cc-6bd397e655dc@molgen.mpg.de>
Date: Thu, 30 Apr 2026 19:20:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C09354A6497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,molgen.mpg.de:mid,intel.com:email]

Dear Aleksandr,


Thank you for your patch.

Am 30.04.26 um 16:21 schrieb Aleksandr Loktionov:
> set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
> ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
> providing ptype >= 1024 through VIRTCHNL, resulting in a write past
> the end of the bitmap and a kernel page fault.
> 
> Reproduced with a custom kernel module injecting a crafted
> VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
> FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
> kernel 7.1.0-rc1.

7.1-rc1 (no need to resend)

> crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
> crash_parser: setting ptype=0xffff (max valid=1023)
> crash_parser: calling ice_parser_profile_init -- expect OOB crash!
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> Oops: Oops: 0002 [#1] SMP NOPTI
> CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
> Hardware name: Intel Corporation S2600BPB/S2600BPB
> RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
> Call Trace:
>   <TASK>
>   ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
>   crash_init+0x127/0xff0 [crash_parser]
>   do_one_initcall+0x45/0x310
>   do_init_module+0x64/0x270
>   init_module_from_file+0xcc/0xf0
>   idempotent_init_module+0x17b/0x280
>   __x64_sys_finit_module+0x6e/0xe0
> 
> Bail out early with -EINVAL when ptype is out of range.

Is a warning logged now?

> Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index f8e6963..3ede4c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
>   	u16 proto_off = 0;
>   	u16 off;
>   
> +	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
> +		return -EINVAL;
> +
>   	memset(prof, 0, sizeof(*prof));
>   	set_bit(rslt->ptype, prof->ptypes);
>   	if (blk == ICE_BLK_SW) {


Kind regards,

Paul

