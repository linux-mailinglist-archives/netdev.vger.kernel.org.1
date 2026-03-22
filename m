Return-Path: <netdev+bounces-270311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FN3CEgAwGn6CwQAu9opvQ
	(envelope-from <netdev+bounces-270311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:44:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B012E9B5E
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0027430054CA
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766B335555;
	Sun, 22 Mar 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Yt9ErjT3"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6B2DF3FD
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774190660; cv=none; b=XupPVy2uhg46BJD+lMGFJksBIiiOq27dnnS9R/uMgqzi0ZitM5IWvomL1A6wrD6jAgcuiGKKMnXnLk4QYaaWrgRhV48+d+DpIfvxOtdr7NEm4izGK9nHsoqanIiymPnsPiyQkq9ccjtgcUKpCF78wzlGULq4s++dF9tvnyE6+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774190660; c=relaxed/simple;
	bh=5Jt1rnHOMqG1f8vHbcA3vhKR47sABang7qKxA/rn5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCxHWNEpoM/e6sCeMIkaKcL87w56v7dlcYmuS2pGCD5BCfM6I6gX0yJkyWG0sRFcv1jyBGbdLVbHRDSRTgUyu5cbeGzBL4c0Q7itLOcm+tCEG5WSAALdWGJv6X1lPtPUATtimhlHRjLjMqEY7wONosRNO8iy+PJ+JkNSDJAZF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Yt9ErjT3; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62MEhVto072710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Mar 2026 23:43:33 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=dUlWew9E1q9hlzhap0e/bAbiNUoE0YWXu61ximcBGWM=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774190613; v=1;
        b=Yt9ErjT32pgQJiKtmiCESDXlUZ7q4pImDr8XMRG1w1lRwT76Z+VMq2H4gPO9pVPg
         N9xW6jzY5cl1GcA+f60WJ4VuGkiLpF1NugkH0uECG97a0SDbxPCmn91XKmwljMW5
         cKi1y1BV6I4+sDV8cglU1TE0+0+YZudIJZmy27kd2Tel7tYuHtNLx0AspTqYQapp
         0jVqhLRbeMKkJtgNVynHAZRtSSB4YVcP8PnqEROgo4JgnpruAKjcZLMLgtO2RFFi
         97/8am0dT4aaLoOrseLhrwGhdSdQGVVWurG6t8vrwivWpaLUPlXoz/tv327eLhYz
         YTWh8WSOFj7pEYYrPfpHHA==
Date: Sun, 22 Mar 2026 23:43:31 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: Fix spelling mistake
Message-ID: <ab_-yfl9M5YOCX0O@x1>
References: <20260322121640.34113-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322121640.34113-1-med08elkadiri@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,amd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A6B012E9B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/22 13:16, Mohammed EL Kadiri wrote:
> In the Solarflare MCDI protocol header, the word 'address' was
> misspelled as 'adress' in a comment. Correcting this improves code
> readability and documentation consistency within the networking
> subsystem.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index b9866e389e6d..a9a7076c00e4 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -21387,7 +21387,7 @@
>  #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_ALL_MULTICAST 0x200 /* enum */
>  #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_PROMISCUOUS 0x400 /* enum */
>  /* enum: Allows to set the TX packets' source MAC address to any arbitrary MAC
> - * adress.
> + * address.
>   */

FWIW, I believe the same comment and typo exist in the siena variant as
well:
  drivers/net/ethernet/sfc/siena/mcdi_pcol.h
Maybe worth fixing there as well?

