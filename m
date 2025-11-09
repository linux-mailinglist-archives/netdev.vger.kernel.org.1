Return-Path: <netdev+bounces-237054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC5C44100
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBB18869B3
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48252FDC20;
	Sun,  9 Nov 2025 14:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8202FB0B9
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699333; cv=none; b=BHWI/GeGLK/JOGVhXHlGrgbQbMOVF8NT6etmfDub0gHe9M2nnmmZV/gAv1iymP/MYtgmXLB5Vw22dbCc5tOZRmv8+YeHX03ZTdatryR+ZxsBCm0rOK/4xZ5AoTiUaoO0Iv8ZOos/GV32Cta5WVZFzq4hQ+laZk+dKI25bh86dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699333; c=relaxed/simple;
	bh=KgtQ6mPcxSP9ejLaBiAt4TjTLtzlmJZhK1UtmAOFm5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8IEIQEM3tffJqzx5rA7lS1NEBIX0rrW5beDBPmE73qkhMc8bqrDbbAF2mq/RdKUNps3wscP7qwtzGGMtJMF1Pri8UMqgSyca+OZhQrd+NGakyKoPXGivEACTwNfDv5/X6Mona2ORknt31+wGpXHgA69IK/XHZq3lfU4kcPwdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.40.22] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B540F61CC3FDB;
	Sun, 09 Nov 2025 15:41:12 +0100 (CET)
Message-ID: <5a9fa920-105b-4707-9e5a-c92e9d7fe49b@molgen.mpg.de>
Date: Sun, 9 Nov 2025 15:41:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: fix comment typo and
 correct module format string
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
References: <20251107123956.1125342-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251107123956.1125342-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alok,


Thank you for your patch.

Am 07.11.25 um 13:39 schrieb Alok Tiwari:
> - Fix a typo in the ice_fdir_has_frag() kernel-doc comment ("is" -> "if")
> 
> - Correct the NVM erase error message format string from "0x02%x" to
>    "0x%02x" so the module value is printed correctly.

Listing changes in a commit message is a good indicator to split it up, 
even it’s formal changes.

> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_fdir.c      | 2 +-
>   drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
> index 26b357c0ae15..ec73088ef37b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
> @@ -1121,7 +1121,7 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
>    * ice_fdir_has_frag - does flow type have 2 ptypes
>    * @flow: flow ptype
>    *
> - * returns true is there is a fragment packet for this ptype
> + * returns true if there is a fragment packet for this ptype
>    */
>   bool ice_fdir_has_frag(enum ice_fltr_ptype flow)
>   {
> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> index d86db081579f..973a13d3d92a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> @@ -534,7 +534,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
>   	}
>   
>   	if (completion_retval) {
> -		dev_err(dev, "Firmware failed to erase %s (module 0x02%x), aq_err %s\n",
> +		dev_err(dev, "Firmware failed to erase %s (module 0x%02x), aq_err %s\n",
>   			component, module,
>   			libie_aq_str((enum libie_aq_err)completion_retval));
>   		NL_SET_ERR_MSG_MOD(extack, "Firmware failed to erase flash");

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

