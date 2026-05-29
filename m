Return-Path: <netdev+bounces-292913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EnwAhvlGGrQoggAu9opvQ
	(envelope-from <netdev+bounces-292913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F85FBC95
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 223D9300F5CE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9F34FF5D;
	Fri, 29 May 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4599FCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853073546C6;
	Fri, 29 May 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016408; cv=none; b=Q0aTCDa9nTBOXbMCEy+GmD8q+vU1sOORjpF1j2OLDBCUbh4Nc5vzeQ65mLxhRfcFoOCoNPPbQT4GfNmrkj3tsUeQLSDJR3V+nbYZaoKIUggZ54yddRR85W/iyM1GSm9LF2zopSjami/IPQse9wNOO8tJx7wTKpzx2zZD3pBGjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016408; c=relaxed/simple;
	bh=6/vn9h5N9pnSEvKyvw8MCGgOdz0xrBOgLFC6DFHEZTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie//UuTRfKSp9kyGLBaV60B295sFvzWHxNTgK+u2eG0W7d86zM7625nrbuGa5oJDvyZtmLwBAMpYKIJmi6PSnh3sL/cCKZ3zhROe4UJF5jzONwsO1+4FYIUMkDjdHpARvga9iUgXK+nnf/Uol1Ayrd1jfS6hQ84rrecO+/LnYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4599FCs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594431F000E9;
	Fri, 29 May 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780016405;
	bh=TiGsmComgc6P64m7Sq39dDZIi46WYnD49PsogFxDxIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A4599FCs00Bn8im21CHa9ySIyWcoM0SBK4gZE6TH7lYvMRgTHs20ajXk0dytqlNLE
	 MpKObzsOjK/JHhm9NMlA78zyWounKzKFroztHqrtLR348ES9fFXEbMTAYTcmk6PUso
	 Lw4ETMirJFHENM6nv8yQWUe4YHcCE6AtGiHMiarnbT2IsYuIVYVTt/aqGKthzlcbGc
	 vHP82dDei3xVIJVlUlDxK2b6RakEjSI5iSRlncp/AxUXVv5SDXjmPguBcMbFG2ZbtK
	 WRukbTZpFTykSUjTXUwCGToxDqNqzKJ9iH3D5Jynp4JqmzQnpIoMaxEygk9Bze2/f7
	 4Hxvk38PGm3JQ==
Date: Thu, 28 May 2026 18:00:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v6 1/7] r8169: add support for multi irqs
Message-ID: <20260528180004.58991104@kernel.org>
In-Reply-To: <20260526081117.173-2-javen_xu@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292913-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA4F85FBC95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:11:11 +0800 javen wrote:
> @@ -4820,7 +4838,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);

the caller is the NAPI poll function, you should pass that NAPI
as arg to rtl_rx() already instead of hardcoding [0] in this patch.

>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
> @@ -4844,7 +4862,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->napi, skb);
> +		napi_gro_receive(&tp->rtl8169_napi[0], skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:

> +static int rtl8169_set_real_num_queues(struct rtl8169_private *tp)
> +{
> +	int ret;
> +
> +	ret = netif_set_real_num_tx_queues(tp->dev, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);

netif_set_real_num_queues() exists, just call it directly instead of
adding your own helper.

> +}
> +
>  static int rtl_jumbo_max(struct rtl8169_private *tp)
>  {
>  	/* Non-GBit versions don't support jumbo frames */
> @@ -5599,6 +5669,22 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void r8169_del_napi_action(void *data)
> +{
> +	struct rtl8169_private *tp = data;
> +	int i;
> +
> +	for (i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_del(&tp->rtl8169_napi[i]);
> +}
> +
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	devm_add_action_or_reset(&tp->pci_dev->dev, r8169_del_napi_action, tp);

devm_add_action_or_reset() can fail (as the AI bots point out)
but this whole devm_ dance is entirely unnecessary
networking stack will automatically delete NAPI instances when device
is unregistered.
-- 
pw-bot: cr

