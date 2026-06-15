Return-Path: <netdev+bounces-299653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xQplEh6JMGriUAUAu9opvQ
	(envelope-from <netdev+bounces-299653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE7E68A912
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:22:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M5u3AMZs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299653-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299653-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BBD3045391
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74130C16B;
	Mon, 15 Jun 2026 23:22:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B12FFFB5;
	Mon, 15 Jun 2026 23:21:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565721; cv=none; b=sD/OIEPHc/soEIQvcUD1BtqU0JA64CUQztpQhSx+boCHEB+Mh3TMBRHSKEuib46YtIO1rVL3D8KFGJSBbGqy81mJ5T1teIB+N2Kr0fSNoYoWKhxdnNELpejRwNEtVS2eGHL25TKbMMHAJfG5p72ivYh0G4Dfn/o/nzGBrySbKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565721; c=relaxed/simple;
	bh=anIGmxFrM6IOXYEJWhizU+cURCoxzWoYfP6Nf1Aav+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEsf5NsB0es5SvBFgR8uN4y5/cP3SU0/NPApbDF5gYtah3RjOu0wB1TlR4VmdETlt69h9kFhz33ezmrOpi5dvgxecAm7KpoYdhf1XoYZkJ2oShRMarjk/0maRr6WShGBJDcFEbRaVFjZS0K1znOk45xSite+eiFkLU+FvAeytTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5u3AMZs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DB1F000E9;
	Mon, 15 Jun 2026 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565719;
	bh=12xCYe4ieqhwExskYGWu30pRBE8o996AZrPppTl9ixc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M5u3AMZs/zrNeptcKR/L1LwbH8tGYHQ7LuESwqK2Zr+LXrbIfZvIJUwqYeFNiebGX
	 iFfbLnHb1CUU+oOQIcC08SZRM3Y9YxTPje6vwwuFrMJJNkKBiIyiLJxjVbg3IS2Wl6
	 Y2hBNkowlbIneF8BmmkzejNkJFiKFRNkm0lKT9Mjihmk404AWG6/vrrowxXUwhmI94
	 ERma0k0Hlt8qKKgxQ6hrBQJ8UxAR7pJQ+BlqTaa269l1+oKyzsMRD3IKen+Gr8k4Tu
	 tX43ewxQ533ID9F63RyPZJCJ/nykt11otHxSU1mOFk2tQgga7r/3O9JAA1nYxeQpZ+
	 XU7M8epez5D/A==
Date: Mon, 15 Jun 2026 16:21:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
 <vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
 <jacob.e.keller@intel.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
Message-ID: <20260615162157.3748bcda@kernel.org>
In-Reply-To: <20260611185744.2498070-5-m-malladi@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
	<20260611185744.2498070-5-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299653-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.infradead.org,ti.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFE7E68A912

On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:
> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>  
>  		num_tx++;
>  	}
> -
> -	xsk_tx_release(tx_chn->xsk_pool);
> -	return num_tx;

Why are you deleting this?

>  }
>  
>  void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  		num_tx++;
>  	}
>  
> -	if (!num_tx)
> -		return 0;

Does something prevent us from running all this code if budget is 0?
If budget is 0 we can complete normal Tx with skbs but we must
not touch any AF-XDP related state.

>  	netif_txq = netdev_get_tx_queue(ndev, chn);
>  	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
>  
> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  
>  		netif_txq = netdev_get_tx_queue(ndev, chn);
>  		txq_trans_cond_update(netif_txq);

This looks misplaced, now we will hit it even if we didn't complete 
or submit any Tx.

> +		__netif_tx_lock(netif_txq, smp_processor_id());
>  		emac_xsk_xmit_zc(emac, chn);
> +		__netif_tx_unlock(netif_txq);
>  	}

