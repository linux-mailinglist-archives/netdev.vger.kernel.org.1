Return-Path: <netdev+bounces-283813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K14GJOP+GkVwgIAu9opvQ
	(envelope-from <netdev+bounces-283813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:22:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D29644BCD86
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C637E301681D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7803CF05C;
	Mon,  4 May 2026 12:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE23AB284;
	Mon,  4 May 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897360; cv=none; b=RrDUq1KVg9BuL/d6MgC8l1KVtWCd9eZIz7LJ0lh4Rr/bEw3T8WyeISUNYrI5aDFx62EVQJL+KMMuwT9OZCxnw7d2Cnp3Cz7AcJOlg1vGIw/CC7w8n7z0tgS5lLBGkpvHl3pVj/6tB2Oktjfxxzr0ZF5VFreoiuzj+UP7Zl5ufCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897360; c=relaxed/simple;
	bh=j6HyHu5PgrqGBemOZM6Om556BVywJBM7+EXLgRM8N1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKQoCYWDDOrWIy3hIb7Q4+p/i3Z4vY3OJ+PPBkpvoqPFalS/RX8kIRgD0ZO0FOBxrXaWwVi0zG8e5EKFcU+GEKI3tStVO9V2fKKV5BD40A4OIytcfUBTkH/Kj3tXgZCSPdRSNOxMRz0hQlSZUlkQOhiEtlc2XARkMoUItarjYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C14AD4C443115E;
	Mon, 04 May 2026 14:21:37 +0200 (CEST)
Message-ID: <f55d1782-a416-4746-8a76-67cab063ecd3@molgen.mpg.de>
Date: Mon, 4 May 2026 14:21:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing priority
 callbacks for U.FL DPLL pins
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <20260504121603.1702674-1-poros@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260504121603.1702674-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D29644BCD86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283813-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mpg.de:email,molgen.mpg.de:mid]

Dear Petr,


Thank you for your patch.

Am 04.05.26 um 14:16 schrieb Petr Oros:
> The U.FL2 input pin advertises DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
> in its capability mask, but ice_dpll_pin_ufl_ops does not provide
> .prio_get and .prio_set callbacks. As a result the DPLL subsystem
> cannot report or accept priority for U.FL pins: pin-get omits the prio
> field on U.FL2 and pin-set with prio is rejected as invalid, even
> though the capability is present. This prevents user space from using
> priority to select or disable U.FL2 as a DPLL input source.
> 
> Add the missing .prio_get and .prio_set callbacks to
> ice_dpll_pin_ufl_ops, reusing ice_dpll_sw_input_prio_{get,set}. The
> same ops struct is shared by U.FL1 and U.FL2: U.FL2 (input) delegates
> to the backing hardware input pin, while U.FL1 (output) does not
> advertise DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE so the dpll core
> capability gate never invokes the callback for it. The reused helpers
> also guard on p->direction != DPLL_PIN_DIRECTION_INPUT and !p->input
> as defense in depth.

Should you resend, it’d be great if you listed the user space commands 
to reproduce this.

> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 27b460926baced..be72a076f7a15c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2628,6 +2628,8 @@ static const struct dpll_pin_ops ice_dpll_pin_ufl_ops = {
>   	.state_on_dpll_set = ice_dpll_ufl_pin_state_set,
>   	.state_on_dpll_get = ice_dpll_sw_pin_state_get,
>   	.direction_get = ice_dpll_pin_sw_direction_get,
> +	.prio_get = ice_dpll_sw_input_prio_get,
> +	.prio_set = ice_dpll_sw_input_prio_set,
>   	.frequency_get = ice_dpll_sw_pin_frequency_get,
>   	.frequency_set = ice_dpll_sw_pin_frequency_set,
>   	.esync_set = ice_dpll_sw_esync_set,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

