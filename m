Return-Path: <netdev+bounces-271852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILtDGBvNxGnb3wQAu9opvQ
	(envelope-from <netdev+bounces-271852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:07:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B632F939
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24EFC3015C81
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55403AD51C;
	Thu, 26 Mar 2026 06:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FC3ACA42
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505196; cv=none; b=MwUcHoynuh75WxOJpfz9G1nKrP/vAomsLCBPZ0mco9U2dYtSDzUYkwVkWd3IRgKfea8dGBFp2huW+0A63/F1CkFaHIJfrXHUWcHh71F98alV+30zWCQHhH+iB6LPkdVYz2oOgQlO9FyK3RrG3uB5mKs8DVq60SjuondiOJEW5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505196; c=relaxed/simple;
	bh=jKQN0iBrcScq5eR49A7LfWAR0cZADZ8Nys0z/YcPWTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbxfb27kOYTpN6NzFpj6P611jomgklfSIod+PHuDrMsPbUK0HgsVh88pHbCIcU3MuXDvMMeqKYlbvy0MHCCdpfMWeRj6E9U6KRg7++GWysxTTldMESEBgJehkXjGSdHAYQadCTuMVAVc0Kj8Y5FhMjHLs/vWrgFBsPxRmLl0uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9c29.dip0.t-ipconnect.de [87.189.156.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 788C54C2C37D70;
	Thu, 26 Mar 2026 07:05:21 +0100 (CET)
Message-ID: <d59fc665-3400-4513-844e-a9529b7498ce@molgen.mpg.de>
Date: Thu, 26 Mar 2026 07:05:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shannon Nelson <sln@onemain.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, kohei.enju@gmail.com
References: <20260325205054.109822-1-kohei@enjuk.jp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260325205054.109822-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271852-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,onemain.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,molgen.mpg.de:mid,enjuk.jp:email]
X-Rspamd-Queue-Id: AF3B632F939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Kohei,


Thank you for your patch.

Am 25.03.26 um 21:50 schrieb Kohei Enju:
> i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
> socket option. However, this option is silently ignored, as the driver
> does not check skb->no_fcs, and always enables FCS insertion offload.
> 
> Fix this by removing the advertisement of IFF_SUPP_NOFCS.
> 
> This behavior can be reproduced with a simple AF_PACKET socket:
> 
>    import socket
>    s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
>    s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
>    s.bind(("eth0", 0))
>    s.send(b'\xff' * 64)
> 
> Previously, send() succeeds but the driver ignores SO_NOFCS.

Would I check that with tcpdump?

> With this change, send() fails with -EPROTONOSUPPORT, as expected.

Great commit message! Thank you.

One question, did you look into, what is needed to implement working 
SO_NOFC support?

> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 3749f32ef95a..a3c52aa6255b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13831,7 +13831,6 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>   	netdev->neigh_priv_len = sizeof(u32) * 4;
>   
>   	netdev->priv_flags |= IFF_UNICAST_FLT;
> -	netdev->priv_flags |= IFF_SUPP_NOFCS;
>   	/* Setup netdev TC information */
>   	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);

Nice catch.


Kind regards,

Paul

