Return-Path: <netdev+bounces-270436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPKJEJcDwWlUPgQAu9opvQ
	(envelope-from <netdev+bounces-270436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:10:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4792EEBFB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4685C3004D05
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E043859F2;
	Mon, 23 Mar 2026 09:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652533195F5
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257045; cv=none; b=i256VKMWS8Mc5I16EOW2w6rBPBY2pebr7thLj4/eX4xIdfLoSxga6zBjNMjeEf7qdl31RjB0AF9ytBPIVF4QlTg5dsSsWwVuQcpk7s+voujtQzbC0HTT+5J3mmXANKIVUDk7qGfm8a7UjQHhb38Ok/5PYeRC1Gs36uLU+vvNc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257045; c=relaxed/simple;
	bh=+2yqBgPOqWKRKy8POtbak7yqq9ptpc85S46Tl/qDWxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Brwv45Ms3gHmrGws2t4DWlQZ0hFmQt4xcdvQFOasiH8Lylng69Lk9tEqiZcIeHmlTEqK4zabuXv7LmxYvFolTnbqNx+1i4yIFiXyoAbSzpzRzEOHvQcHMKv+aQi6nbu6wUHwwWs/txOsfC38p6OPscZesdoyi2mf3y4comsyj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9b5e.dip0.t-ipconnect.de [87.189.155.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 65D034C2C37F07;
	Mon, 23 Mar 2026 10:10:30 +0100 (CET)
Message-ID: <447cbe7b-49b0-41dd-9a96-40a2dc40b198@molgen.mpg.de>
Date: Mon, 23 Mar 2026 10:10:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: update
 ice_link_mode_str_high() with 200G
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
References: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270436-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: DD4792EEBFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Aleksandr, dear Paul,


Thank you for your patch. Some minor comments, should you resend.

Am 23.03.26 um 09:58 schrieb Aleksandr Loktionov:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Update ice_link_mode_str_high() with strings for 200G PHY types.
> Without these entries the ice_dump_phy_type() debug helper prints
> nothing for phy_type_high bits [5..15], covering all 200G and
> 400GBASE-FR8 PHY types supported by E825C hardware.

How does the system need to be configured to get `ice_dump_phy_type()` 
called?

Also, the commit message title just mentions 200G, but here you mention 
400G too.

> Also add the corresponding ICE_PHY_TYPE_HIGH_* bit definitions for
> indices 13-15 (200G_AUI8_AOC_ACC, 200G_AUI8, 400GBASE_FR8) that were
> missing from ice_adminq_cmd.h, and update ICE_PHY_TYPE_HIGH_MAX_INDEX
> from 12 to 15.  Without these definitions ice_get_phy_type_high() would
> stop iterating at index 12, leaving the new PHY types invisible to all
> code that bounds-checks against MAX_INDEX.

Maybe this should have been a separate commit, but it’s not important.

> Fixes: none (new hardware support)
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 update ICE_PHY_TYPE_HIGH_MAX_INDEX
> ---
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 ++++-
>   drivers/net/ethernet/intel/ice/ice_common.c     | 11 +++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 859e9c6..f64d2ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1044,7 +1044,10 @@ struct ice_aqc_get_phy_caps {
>   #define ICE_PHY_TYPE_HIGH_200G_KR4_PAM4		BIT_ULL(10)
>   #define ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC	BIT_ULL(11)
>   #define ICE_PHY_TYPE_HIGH_200G_AUI4		BIT_ULL(12)
> -#define ICE_PHY_TYPE_HIGH_MAX_INDEX		12
> +#define ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC	BIT_ULL(13)
> +#define ICE_PHY_TYPE_HIGH_200G_AUI8		BIT_ULL(14)
> +#define ICE_PHY_TYPE_HIGH_400GBASE_FR8		BIT_ULL(15)
> +#define ICE_PHY_TYPE_HIGH_MAX_INDEX		15
>   
>   struct ice_aqc_get_phy_caps_data {
>   	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 2cebe4e..c6727c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -84,6 +84,17 @@ static const char * const ice_link_mode_str_high[] = {
>   	[2] = "100G_CAUI2",
>   	[3] = "100G_AUI2_AOC_ACC",
>   	[4] = "100G_AUI2",
> +	[5] = "200G_CR4_PAM4",
> +	[6] = "200G_SR4",
> +	[7] = "200G_FR4",
> +	[8] = "200G_LR4",
> +	[9] = "200G_DR4",
> +	[10] = "200G_KR4_PAM4",
> +	[11] = "200G_AUI4_AOC_ACC",
> +	[12] = "200G_AUI4",
> +	[13] = "200G_AUI8_AOC_ACC",
> +	[14] = "200G_AUI8",
> +	[15] = "400GBASE_FR8",
>   };
>   
>   /**

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

