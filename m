Return-Path: <netdev+bounces-281755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPd9NvuC8GlwUQEAu9opvQ
	(envelope-from <netdev+bounces-281755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6361E481DC2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD9F13034A34
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28D3D9DB8;
	Tue, 28 Apr 2026 09:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F82C08DC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369527; cv=none; b=XQlfnErLMAzMK3ndjAuCvmw1+ljWVBxHD2aDzg+qfci95pSs1JeakvHAl7q8bdwvGpH3KWB23gVAQCRKZHe9Lw3D7OF4gcCuXxq40WM8sXkEqcVX1cFyVSt8KrFRPiMreErAK9rLolN+28yxSylxmb9QMpZq6g0ChRiD1M9pgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369527; c=relaxed/simple;
	bh=+SczXxPMicIegRdCfLiY2TJdrXgCKfIYJ4G3kiIco7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiiNVb2AkxjmBRTK4KYaUxLtzTMP5ruCxNkU7pyb11ubuNndSTtwKQFaUXic9pQUZc7oaQjf6QbWxjdoU4axRe2U1Tf5QQwxE0s57S9GLc2NhrkwzUi0ABr/IMIHbqCK9Zhya9k9IgUh19p40CMgfRYla/FPHrz6mRrRq4zaSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0A9F34C288718F;
	Tue, 28 Apr 2026 11:44:51 +0200 (CEST)
Message-ID: <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
Date: Tue, 28 Apr 2026 11:44:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [RFC PATCH] ice: allow creating VFs when
 !CONFIG_ICE_SWITCHDEV
To: Vincent Chen <vincent.chen@sifive.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20260427031158.2665916-1-vincent.chen@sifive.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260427031158.2665916-1-vincent.chen@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6361E481DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281755-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sifive.com:email]

Dear Vincent,


Thank you for your patch.

Am 27.04.26 um 05:11 schrieb Vincent Chen via Intel-wired-lan:
> Currently ice_eswitch_attach_vf() is called unconditionally in
> ice_start_vfs() and ice_reset_all_vfs(), which causes VF creation
> to fail when CONFIG_ICE_SWITCHDEV is not defined or switchdev mode
> is not enabled at runtime.

I’d add a blank line between paragraphs.

> Fix this by adding switchdev mode checks at the call sites before
> calling ice_eswitch_attach_vf(), consistent with how
> ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
> Also remove the redundant check inside ice_eswitch_attach_vf() itself.

*Also* is a good indicator to make it a separate patch. I’d favor this 
in this case.

> This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
> !CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
> ice_eswitch_configure() API.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
>   drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f..c709decb26d5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
>   	struct ice_repr *repr;
>   	int err;
>   
> -	if (!ice_is_eswitch_mode_switchdev(pf))
> -		return 0;
> -
>   	repr = ice_repr_create_vf(vf);
>   	if (IS_ERR(repr))
>   		return PTR_ERR(repr);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 843e82fd3bf9..6a0b724e46f9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
>   			goto teardown;
>   		}
>   
> -		retval = ice_eswitch_attach_vf(pf, vf);
> -		if (retval) {
> -			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
> -				vf->vf_id, retval);
> -			ice_vf_vsi_release(vf);
> -			goto teardown;
> +		if (ice_is_eswitch_mode_switchdev(pf)) {
> +			retval = ice_eswitch_attach_vf(pf, vf);
> +			if (retval) {
> +				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
> +					vf->vf_id, retval);
> +				ice_vf_vsi_release(vf);
> +				goto teardown;
> +			}
>   		}
>   
>   		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index de9e81ccee66..71595410174c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
>   		ice_vf_rebuild_vsi(vf);
>   		ice_vf_post_vsi_rebuild(vf);
>   
> -		ice_eswitch_attach_vf(pf, vf);
> +		if (ice_is_eswitch_mode_switchdev(pf))
> +			ice_eswitch_attach_vf(pf, vf);
>   
>   		mutex_unlock(&vf->cfg_lock);
>   	}

The diff looks good.


Kind regards,

Paul

