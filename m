Return-Path: <netdev+bounces-291005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C2XLLYoKEWoVgwYAu9opvQ
	(envelope-from <netdev+bounces-291005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2A5BC6D2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A2CF3018AC4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4A1CBEB9;
	Sat, 23 May 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu8qzSzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AAA125A0;
	Sat, 23 May 2026 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501689; cv=none; b=PocgkvSzFeGsVJtw41ss5vh+f+h3WDGeAApiLbDio+ywD4PT0Fcajm2WjA6YrovfIZ8ytdQMlXlabiy3e0QDNy3GjCyUnWdH5bD6rScHHYcTjxM8Go3FTJ46dP/DVgfAOIKDAAcpOaCBpPbQvzF/a217sgDdeFSfQ5Brzm4C5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501689; c=relaxed/simple;
	bh=/4SnisBJqI87+3yh6zWcGwHLgL1Dm055h35FLjLD39E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjmN5C25+IlHLuM05/foOeIzg7DHXKpXrUP5z9CuhkWIKxhVSETxpX5DvcsMQag1X5OpIc2WS/tkhizOEyFxYk3MzgSatzNmrJ5wUWRnIbjX1XULwX7BFjgk7Wsr9NzpxvN7TxM/2u787cT/Ujkw8CMrmw/ukjqjPT4vbGamIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu8qzSzU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4121F000E9;
	Sat, 23 May 2026 02:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779501687;
	bh=6WKrz7vc9STJ7Mp+8h8Ot/78gKtBGE55ZCaRuTUygMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lu8qzSzUR56qKtBo5J5tVbOBq2fLHEbGuJvGbwBYT7tma9sadRmPhQLEQLdia87v3
	 Bc2kr0+HlGhfMIdGrUcPDem8YTZTZUcNi+q0hrcxFNA0E3aW6KvhCNgwDr4xu8cp1w
	 j6meQHhvKD9l1sReRcGE1ZFiaRlRIznR+XML7oZHwPQj89+0MuWxYSkhvRm6T7B492
	 Ed+kM7H9ritAuVwKmFMZwnAi54HaH+1MYEUSPIK0R26n+3sSRXfehqcRv/lz4bdQfE
	 dKli06o6ymyCJR9BA5Pho/QY1PLMDRodszvdZYDdUuyI5cUygwjcYycC94JvaBE1g7
	 aun38acPBJhFA==
Date: Fri, 22 May 2026 19:01:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Steen
 Hegelund <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
 "Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Herve Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 11/13] net: lan966x: add PCIe FDMA XDP
 support
Message-ID: <20260522190126.0f2d6587@kernel.org>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-11-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
	<20260520-lan966x-pci-fdma-v5-11-ca56197ae05b@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2EF2A5BC6D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 10:12:23 +0200 Daniel Machon wrote:
>  #if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
>  extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
> +
> +static inline bool lan966x_is_pci(struct lan966x *lan966x)
> +{
> +	return lan966x->ops == &lan966x_fdma_pci_ops;

	return IS_ENABLED(CONFIG_MCHP_LAN966X_PCI) && 
		lan966x->ops == &lan966x_fdma_pci_ops;

compiler will eliminate the reference to the ops as dead code
and linker will not complain that its object is missing.

> +}
> +#else
> +static inline bool lan966x_is_pci(struct lan966x *lan966x)
> +{
> +	return false;
> +}
>  #endif
>  
>  int lan966x_lag_port_join(struct lan966x_port *port,
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> index 9ee61db8690b..b470f731e25c 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> @@ -24,6 +24,16 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
>  	old_prog = xchg(&port->xdp_prog, xdp->prog);
>  	new_xdp = lan966x_xdp_present(lan966x);
>  
> +	/* PCIe FDMA uses contiguous buffers, so no page_pool reload
> +	 * is needed. Drain NAPI before freeing the old program so
> +	 * no in-flight poll holds a stale pointer.
> +	 */

Not sure what this does. BPF programs are under RCU, they are not
immediately freed (if that's that you mean..)

> +	if (lan966x_is_pci(lan966x)) {
> +		if (old_prog)
> +			napi_synchronize(&lan966x->napi);
> +		goto out;
> +	}

