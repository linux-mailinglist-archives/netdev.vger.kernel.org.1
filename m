Return-Path: <netdev+bounces-269551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO20H4wnvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:42:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F62CEFEB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C8D43004D18
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6C3E9F62;
	Thu, 19 Mar 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zs1fHFfc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEA3ECBF9;
	Thu, 19 Mar 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938568; cv=none; b=ClJSzefZiRp1LM/1HdEbd4kiV4cESru3F3/B2BHN+pYDqkVZ8KCImqkBqjRDRcTURjgrxvOr2nmKbg8aGULNvPLTKnMQgK99fSFZQ6JPNqNqcwTDkDZP03QGPocXhGWpNchYKy4CRGkNRiCHFLX5PQIUBGsMNwf3oVsEo2Muo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938568; c=relaxed/simple;
	bh=cj67TKFpR/HHrMVHO3a8Uu76PNcocMvnVi/OXCsO5yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA0iNA5zjFQGNydMJmQBKFX/FBg2MyAvAHMAfKdrWvxomN/1KOSjYClBEIC/8LT1vs4fn3ZCu4SszM/rl8eQEeSCp26tS5cQUDiGU6UKeht0beljwvFTLkR6pFxKcZbkcUr+L4F7/C5er1fTjUEECflsiGN2aXybcUIXUQtlqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zs1fHFfc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1EnbXWo5X4zRe8vzeZDERST6bzmD034FtkrkipipB6Q=; b=Zs1fHFfcU2+U7pZybwtDGppe6T
	Aqm2yiDmvKDy+JGhACcR+yTxT9ZABHgUSNcJgnfGL8dAjtkQGeOGGWlfUe8Y/Z9Y4nubiPj62Kb7K
	NYatGqd/jUU6aKLgLh5ddI3QME1QNN1O+CBIv3JMYcS7iYrQd6VR/MuVuCGtFQX1UTU0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3GSB-00CPsP-32; Thu, 19 Mar 2026 17:42:35 +0100
Date: Thu, 19 Mar 2026 17:42:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] r8152: Add support for the RTL8157
 hardware
Message-ID: <4522d3e9-217f-4fd1-962b-1f009ee6d9f7@lunn.ch>
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-269551-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 270F62CEFEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < 10; i++) {
> +		u16 ocp_data = ocp_read_word(tp, MCU_TYPE_USB, cmd);
> +
> +		if (!(ocp_data & ADV_CMD_BUSY))
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +
> +	if (i == 10)
> +		ret = -ETIMEDOUT;
> +
> +	return ret;

It is better practice to use one of the helpers from linux/iopoll.h.

> -static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
> +static int r8152_tx_csum(struct r8152 *tp, void *d,
>  			 struct sk_buff *skb, u32 len)
>  {
> +	struct rx_desc *desc = d;
>  	u32 mss = skb_shinfo(skb)->gso_size;
>  	u32 opts1, opts2 = 0;
>  	int ret = TX_CSUM_SUCCESS;

Reversed Christmas tree is already messed up here, but please don't
make it worse. Add desc after mss.

> +static void r8157_rx_vlan_tag(void *desc, struct sk_buff *skb)
> +{
> +	struct rx_desc_v2 *d = desc;
> +	u32 opts1 = le32_to_cpu(d->opts1);

And here you need to move the assignment into the body in order to
keep to reverse Christmas tree.

	Andrew

