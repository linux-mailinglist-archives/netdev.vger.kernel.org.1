Return-Path: <netdev+bounces-175055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3890A62DC4
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0057A5B7C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C58202C48;
	Sat, 15 Mar 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PuvGPAju"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E005201268
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047116; cv=none; b=Jw7SwpHcqUm1xV72Orn5MF9RcR/1LV+fKfdhShwEthQIOFUmh5/m7+uIAAes72shIv4XTWVUzfiXxaDiFWFUQK87TD2q3CpjorHQhv09b6CD6r+NP7+vV2L4cJ9g57FnhOPWkNc4ouexfT4Y21L3rFY/sKKeolDl4lIBxMbsUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047116; c=relaxed/simple;
	bh=yyBQtcKYy/1bTxdJ9q+EYdxJcu+glfA4/v4eU4hPqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfYrPKW2r/GR4dNKcs0Pq37HrMEPhXn/O/hdQq0gGut45bpu7m1ypTJFq/9eJj0caOOv0to0cTDyxyNur6H6tcPedwP5zw4QtZTBjm0PMp4Jc/gvUKk/JcHPdRaH7U/b+2638c59jED1XIHBf9jA9GJ29O5jhhuAjQHaVTP5TYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PuvGPAju; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Op9cD1U0KRYqHmW8EnMYGo3fVWW5K4SEiP+kI5MweBQ=; b=PuvGPAjucn1pH/T3gmp8kVswvv
	vz/GySD7QeVeaaijo9DnWkJEu3lF2h9Xec16pwWR3tZVgy7u2K3gK1vUXDIe9wQXpuJEOFbzmSW1E
	TZ6OFz+nAdiK6WE6bTZ9K2AIcjNJrZatWNfRxWDa79Ft8e8QUDDu6X+5I8X6lrYYCJfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ttS1q-005avu-TO; Sat, 15 Mar 2025 14:58:18 +0100
Date: Sat, 15 Mar 2025 14:58:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <b647d3c2-171e-43ea-9329-ea37093f5dec@lunn.ch>
References: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>

> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> routine.

A more interesting question is, why do you see an invalid port? Is the
hardware broken? Something not correctly configured? Are you just
papering over the crack?

> -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> +					struct airoha_foe_entry *hwe,
>  					struct net_device *dev, int type,
>  					struct airoha_flow_data *data,
>  					int l4proto)
> @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
>  	if (dev) {
>  		struct airoha_gdm_port *port = netdev_priv(dev);

If port is invalid, is dev also invalid? And if dev is invalid, could
dereferencing it to get priv cause an opps?

	Andrew

