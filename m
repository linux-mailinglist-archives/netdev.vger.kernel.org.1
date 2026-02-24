Return-Path: <netdev+bounces-260622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NqtD7nmnWlDSgQAu9opvQ
	(envelope-from <netdev+bounces-260622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:58:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166018AD7A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B7531669ED
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635943A9DA4;
	Tue, 24 Feb 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJObRucU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC33A9D8D;
	Tue, 24 Feb 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955700; cv=none; b=cACrawviZAMH/Yavd4MSLfli67tp4L0AG8H/1wqKlhGl5eZkq0xJPkiA+CAAk+GVIAYL3HxL6ceuvQTl1rgTT7mFvPfhpayaxq2u0fLlYKx2Q9xXW4nQrlEtlOIfosED12c6NvjJsG+8KTR+P+O7+Ecw5gMenfO6STyga8Vc5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955700; c=relaxed/simple;
	bh=8VrcD46dycy0DmTlHRXutqJ3iyRT/XCLxmuZYonmw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEnminw0JutM3AKXmmuHwL/xhspKXjYbqhA+VmAy+dmfhZvprVG26Wu5e43wn2FTjUreWGpm4M9aGR17FQtQ591h9jEkJ3efYO+Om8/TIs2b7YQLXbShRBkmkLsskQr4xBPyG1zJ7isYSHhD3qjcPWGvvfagVvg2kKd3egCfXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJObRucU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B90C116D0;
	Tue, 24 Feb 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955700;
	bh=8VrcD46dycy0DmTlHRXutqJ3iyRT/XCLxmuZYonmw+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJObRucUqbih7KkJPWJZwIp6ChpzPJMBFVAfVkOFpiFv7k73CVjDP5LQImwP1kQze
	 ZJvYCfiaUywKjhFQGmIjBKstSyBKa6IzWOtX8D3miyxSrQjBOqiZpGuSUk7LcBJxwg
	 QDfKE5mtlAc1XNk56axpFGOdKWwaVT6+wTI9YXFeqyBHBMpHL8OXzYxEGINmUFC4S0
	 gFBx31dknflFgj/OxegwmafHV6iZMOwROmWt/YkAr+Z2Lcrt3YG7zPaln+naa/+5XI
	 25UcZGIzHSz2Cu6BAfrHLNm+ZSw5wLZ1yiLgZaNKMWYFB7a5y8UZTgBVaIGVjM7Bv8
	 mrf/VP6SCXvOQ==
Date: Tue, 24 Feb 2026 17:54:54 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 06/10] ixgbevf: XDP_TX in multi-buffer through
 libeth
Message-ID: <aZ3l7sqKmz6fvmRp@horms.kernel.org>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
 <20260223095222.3205363-7-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223095222.3205363-7-larysa.zaremba@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7166018AD7A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:52:13AM +0100, Larysa Zaremba wrote:

...

> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index eada53c57fcf..67d10e6e9910 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -82,20 +82,22 @@ struct ixgbevf_ring {
>  	struct net_device *netdev;
>  	struct bpf_prog *xdp_prog;

...

> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c

...

> @@ -784,11 +865,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>  	struct ixgbevf_adapter *adapter = q_vector->adapter;
>  	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
> +	LIBETH_XDP_ONSTACK_BULK(xdp_tx_bulk);
>  	LIBETH_XDP_ONSTACK_BUFF(xdp);
> +	u32 cached_ntu;
>  	bool xdp_xmit = false;
>  	int xdp_res = 0;
>  
>  	libeth_xdp_init_buff(xdp, &rx_ring->xdp_stash, &rx_ring->xdp_rxq);
> +	libeth_xdp_tx_init_bulk(&xdp_tx_bulk, rx_ring->xdp_prog,
> +				adapter->netdev, adapter->xdp_ring,
> +				adapter->num_xdp_queues);

Hi Larysa,

Sparse flags that libeth_xdp_tx_init_bulk() expects xdp_prog to be managed
using __rcu, but that is not the case for rx_ring->xdp_prog.

  .../ixgbevf_main.c:875:9: error: incompatible types in comparison expression (different address spaces):
  .../ixgbevf_main.c:875:9:    struct bpf_prog [noderef] __rcu *
  .../ixgbevf_main.c:875:9:    struct bpf_prog *

...

