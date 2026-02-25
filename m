Return-Path: <netdev+bounces-260873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIfUKIvTnmnwXQQAu9opvQ
	(envelope-from <netdev+bounces-260873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A108195FFA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C493004C41
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D439280E;
	Wed, 25 Feb 2026 10:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C13101A5
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016316; cv=none; b=qACF0pmADAmGrdvzECmo8LyttQ1jkCMY0aZvczgKvxouPHpOB1aoI/XBZkVXc/kCcH6JTLBkA0RymTwnrzCnJlJUe6DkYjrOTEckNHSzSsvTzgKq38n7Ec+Hywi81ht1L9Ag1fb3AAepbmZBm2pxZ5CUl4hgIMBTDfDR1wkprww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016316; c=relaxed/simple;
	bh=bJHtlGVcMX/Gm7d45WLkay324VwwSafKW+8UEHXEbMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/RPgRLHxAo+EoMawrm5YoEz5lFeC57GVWzX4zmjcLYO/NGHxSRTWO3dKMCnBUQHn9Cl3n0tS9kMHEhm+w5rKaimzOGHb637jpWnlRylWeXf81FVFvRf0XPDsWNE9xuwSSFN2cqWJUx7XEkoUDEw7XzX2pwkvtEvVR38vQquUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.249.96] (ip-185-104-138-144.ptr.icomera.net [185.104.138.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6E8484C2C37D48;
	Wed, 25 Feb 2026 11:44:53 +0100 (CET)
Message-ID: <4720c31a-bf3a-445c-821a-a702fb650a6e@molgen.mpg.de>
Date: Wed, 25 Feb 2026 11:44:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: remove redundant
 checks from PTP init
To: Natalia Wochtman <natalia.wochtman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, aleksandr.loktionov@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com
References: <20260225090236.187255-1-natalia.wochtman@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260225090236.187255-1-natalia.wochtman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0A108195FFA
X-Rspamd-Action: no action

Dear Natalia,


Thank you for the patch.

Am 25.02.26 um 10:02 schrieb Natalia Wochtman:
> Remove unnecessary condition checks in
> ice_ptp_setup_adapter() and ice_ptp_init().
> They are duplicated in ice_pf_src_tmr_owned().

Using 75 characters per line, the above would fit in two lines.

> Change ice_ptp_setup_adapter() to return void.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index d8fd01fa617b..2b26024de888 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3065,14 +3065,9 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>   	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
>   }
>   
> -static int ice_ptp_setup_adapter(struct ice_pf *pf)
> +static void ice_ptp_setup_adapter(struct ice_pf *pf)
>   {
> -	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
> -		return -EPERM;
> -
>   	pf->adapter->ctrl_pf = pf;
> -
> -	return 0;
>   }
>   
>   static int ice_ptp_setup_pf(struct ice_pf *pf)
> @@ -3315,10 +3310,9 @@ void ice_ptp_init(struct ice_pf *pf)
>   	/* If this function owns the clock hardware, it must allocate and
>   	 * configure the PTP clock device to represent it.
>   	 */
> -	if (ice_pf_src_tmr_owned(pf) && ice_is_primary(hw)) {
> -		err = ice_ptp_setup_adapter(pf);
> -		if (err)
> -			goto err_exit;
> +	if (ice_pf_src_tmr_owned(pf)) {
> +		ice_ptp_setup_adapter(pf);

As the checks were duplicated, this branch was never taken, and 
therefore err was never set? Is that your argument?

Did the compiler notice this redundancy, and is different code generated 
now?

> +
>   		err = ice_ptp_init_owner(pf);
>   		if (err)
>   			goto err_exit;


Kind regards,

Paul

