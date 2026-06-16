Return-Path: <netdev+bounces-299886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /5WkLThqMWomiwUAu9opvQ
	(envelope-from <netdev+bounces-299886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C262690F85
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mHNEtl8R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299886-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299886-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47A753051DCC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E614418FC;
	Tue, 16 Jun 2026 15:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86444105C;
	Tue, 16 Jun 2026 15:19:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623198; cv=none; b=jUsn77YwIcHVWJTfgXyszttSJk4QkM6+Y0755hEMonU4FBH8wnqRjYlyw+n3HXlQP1KWR8a6VOGKYavT2c2numjtncnIIzYITyp8SrmwbBTiLDHdJdgT4dUOdqVnh1QklCxLoVgMcQbicrpW5Odj/A5vrIoUoEu+/Q/261CHm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623198; c=relaxed/simple;
	bh=JlUmJ5DBcsfUYQX4vTIw4k1KT8v4/azxh62j2Yp9PoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBN/mh++M4M1CL0c7DgKNF+LA5o1yNVf527lC0EnjUYcfh/cTvQObni5qDOLk8BYc/hLWOeAe4tgEBajzbHeivxlGPpXC5mzNR8EB4sMQdNsbSnOcERdmo16miKA1I7TWfvSAM09ROG233/YYeD7kNWnPZvtA10ew3RPJahSDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHNEtl8R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B128D1F000E9;
	Tue, 16 Jun 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623196;
	bh=VfbnHY+aIdC82PGEHGtuLsQPBx8FLWY1rXe+qSv98R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mHNEtl8RbNvTGPTjX3pTBwPHUIhqntugKsjms91Ls7d61c5mmVyuH+GHfghcDdZSf
	 /nj7LafsGUp8ljfbv63H7uY34K5fpgjQh4rjja9+ps6pad72/qnzQs1BiHxiRIk2fo
	 B5Crbz5sDRCq5okwRknKNZImddxeI6GJ2BRpPygnNMrUx4tBM7acfOgOMz9w5YH7kf
	 JlMP/6iVUSX5Qfu17S7v6LuM2+H4nfUo0klMVovuNkWlpkxVm59Rlk8RnS82YjkNMp
	 hBg6JVIezzCk91zmmovFSBIwW1/DbYzebsj0R8QTgJYcYTYqes/yI0/LETGFkutney
	 moeafmV/dqjGw==
Date: Tue, 16 Jun 2026 08:19:54 -0700
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
Message-ID: <20260616081954.0d12aa13@kernel.org>
In-Reply-To: <ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
	<20260611185744.2498070-5-m-malladi@ti.com>
	<20260615162157.3748bcda@kernel.org>
	<ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299886-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C262690F85

On Tue, 16 Jun 2026 16:41:00 +0530 Meghana Malladi wrote:
> On 6/16/26 04:51, Jakub Kicinski wrote:
> > On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:  
> >> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
> >>   
> >>   		num_tx++;
> >>   	}
> >> -
> >> -	xsk_tx_release(tx_chn->xsk_pool);
> >> -	return num_tx;  
> > 
> > Why are you deleting this?
> >   
> 
> xsk_sendmsg() also calls this without an rcu-lock when transmitting the 
> packets if the xmit was successful, so I was assuming it is not required 
> and I removed this.

I think you still need it. Besides, seems like a separate cleanup.

> >>   void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
> >> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> >>   		num_tx++;
> >>   	}
> >>   
> >> -	if (!num_tx)
> >> -		return 0;  
> > 
> > Does something prevent us from running all this code if budget is 0?
> > If budget is 0 we can complete normal Tx with skbs but we must
> > not touch any AF-XDP related state.
> 
> Can you elaborate more, I couldn't interpret your comment here

netpoll may call napi from any context, including from IRQ.
It uses budget of 0 to indicate that it's trying to only reap tx
completions, without doing any Rx or XDP work. XDPs can't be called
from IRQ context.

> >>   	netif_txq = netdev_get_tx_queue(ndev, chn);
> >>   	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
> >>   
> >> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> >>   
> >>   		netif_txq = netdev_get_tx_queue(ndev, chn);
> >>   		txq_trans_cond_update(netif_txq);  
> > 
> > This looks misplaced, now we will hit it even if we didn't complete
> > or submit any Tx.
> 
> This code needs to be hit for packet transmission in zero copy mode.
> emac_xsk_xmit_zc() submits the packets to the DMA in NAPI context,
> when application wakes up the driver and triggers NAPI. Once DMA 
> transfer is done, irq gets triggered NAPI gets called which will handle 
> the tx packet completion + submit next Tx batch packets to the DMA.
> 
> if (tx_chn->xsk_pool) -> check ensure this hits and runs for zero copy 
> only. Also above check (!num_tx) returns early during the application 
> wakeup (where budget is zero), hence it is removed.

I'm commenting on txq_trans_cond_update(), you're calling it
effectively on every NAPI call when XSK is bound, whether
Tx is making progress or not.

