Return-Path: <netdev+bounces-281942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DGLCPzd8Gn3aQEAu9opvQ
	(envelope-from <netdev+bounces-281942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA8488B47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B46A30A9DF2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4E3C661A;
	Tue, 28 Apr 2026 15:07:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979037CD3D;
	Tue, 28 Apr 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388862; cv=none; b=foAxyOjAzIoR4lmDpOlyw1WKXWYl7ViuO9+bAy5P7AY+6eszuMdALSWGC340z1EeB50UxEIpy7obtH+cconTE/a5uyaMm1bDF22pmuWtQ8ZzVmqqeTouYhKXrwaUjqSVs/kjnOSCVZl88tYQORlw/uyf+Cox2n8XRzUzohYcI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388862; c=relaxed/simple;
	bh=FWcTVjds0C9y5CpVpjxBQ30dXbhQ4u1EVVvXJBuYBAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0yGf7Oe9KCK8lK5AbQCQy4MuAYNSC0jUi4e8V73ju8LHPUELEhfmVzX4HVQmzB0UqCo0rkvR4gp8n5sIDjsRlGbl0sVFIYdkMal/F107evVJqHlOGw1dukX3gchYoY49DXvWJqcK3e/CRYsMxCbFqYUVtJnAhWDvlmf7goQu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 524524C4431132;
	Tue, 28 Apr 2026 17:06:26 +0200 (CEST)
Message-ID: <d3d4915c-1bc5-4e04-bfc4-9d9787849c6f@molgen.mpg.de>
Date: Tue, 28 Apr 2026 17:06:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
 autoneg_failed field
To: Faizal Abdul Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: khai.wen.tan@linux.intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
 <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
 <84b4f8bb-3c8c-4098-bc7f-7e9fd248c5ca@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <84b4f8bb-3c8c-4098-bc7f-7e9fd248c5ca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24AA8488B47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281942-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.556];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,molgen.mpg.de:mid]

Dear Faizal,


Am 28.04.26 um 12:39 schrieb Abdul Rahim, Faizal:

> On 28/4/2026 2:56 pm, Paul Menzel wrote:

>> Am 28.04.26 um 08:00 schrieb KhaiWenTan:
>>
>> (Should spaces be added in your name?)
>>
>>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>
>>> autoneg_failed in struct igc_mac_info is never set in the igc driver.
>>> Remove the field and the dead code checking it in
>>> igc_config_fc_after_link_up().
>>
>> Could you please elaborate. Why is removal the correct fix, and it’s 
>> not an incomplete feature? Does auto-negotiation always succeed?
> 
> Auto-negotiation does not always succeed, but igc does not use
> autoneg_failed to handle that case, the field was never set anywhere
> in the igc driver.
> 
> Before this patch, the only igc references to autoneg_failed were
> the struct member declaration and the read in
> igc_config_fc_after_link_up(). No igc code ever assigned it to true,
> and git history shows no commit that added a setter since the code
> creation in 2018.
> 
> The field originates from the e1000/e1000e fiber/serdes forced-link
> path: when MAC-level auto-negotiation on fiber times out, the driver
> forces link up and sets autoneg_failed so the flow-control code knows
> pause was not negotiated and must be forced. igc has no fiber or
> serdes media, it only supports copper (igc_media_type_copper), so
> the code that sets autoneg_failed was never ported.
> 
> On copper, PHY auto-negotiation failure is handled differently:
> - No link at all: igc_check_for_copper_link() returns before reaching
>    flow-control configuration, there's nothing to configure FC on.
> - Link present but autoneg not yet complete:
>    igc_config_fc_after_link_up() checks MII_SR_AUTONEG_COMPLETE and
>    returns early without resolving pause. The next link-status event
>    re-triggers the check.
> - Autoneg completes (including via parallel detection fallback when
>    the link partner doesn't autoneg): the PHY still sets
>    AUTONEG_COMPLETE but LP_ABILITY won't have PAUSE bits since the
>    partner never sent autoneg pages. The existing flow-control logic
>    in igc_config_fc_after_link_up() handles that correctly, it falls
>    through to igc_fc_none or igc_fc_rx_pause based on requested_mode.
> 
> None of these paths need autoneg_failed. Keeping the field would be 
> misleading to reader.

Thank you. For me the information about just supporting copper would be 
great to have in the commit message.

>>> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
>>
>> Please order it to not use the comma: Hong Aun Looi
> 
> Will do, thanks.
> 
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
>>>   drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>>>   2 files changed, 1 insertion(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ 
>>> ethernet/intel/igc/igc_hw.h
>>> index be8a49a86d09..86ab8f566f44 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
>>> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
>>> @@ -92,7 +92,6 @@ struct igc_mac_info {
>>>       bool asf_firmware_present;
>>>       bool arc_subsystem_valid;
>>>
>>> -    bool autoneg_failed;
>>>       bool get_link_status;
>>>   };
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ 
>>> ethernet/intel/igc/igc_mac.c
>>> index 7ac6637f8db7..142beb9ae557 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>>> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
>>>    * Checks the status of auto-negotiation after link up to ensure 
>>> that the

Just for your information, that your mailer wraps the lines of the quotes.

[…]

>>>    * speed and duplex were not forced.  If the link needed to be 
>>> forced, then
>>>    * flow control needs to be forced also.  If auto-negotiation is 
>>> enabled
>>> - * and did not fail, then we configure flow control based on our link
>>> - * partner.
>>> + * then we configure flow control based on our link partner.
>>>    */
>>>   s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>>   {
>>>       u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
>>> -    struct igc_mac_info *mac = &hw->mac;
>>>       u16 speed, duplex;
>>>       s32 ret_val = 0;
>>>
>>> -    /* Check for the case where we have fiber media and auto-neg failed
>>> -     * so we had to force link.  In this case, we need to force the
>>> -     * configuration of the MAC to match the "fc" parameter.
>>> -     */
>>> -    if (mac->autoneg_failed)
>>> -        ret_val = igc_force_mac_fc(hw);
>>> -
>>> -    if (ret_val) {
>>> -        hw_dbg("Error forcing flow control settings\n");
>>> -        goto out;
>>> -    }
>>> -
>>>       /* In auto-neg, we need to check and see if Auto-Neg has 
>>> completed,
>>>        * and if so, how the PHY and link partner has flow control
>>>        * configured.

Kind regards,

Paul

