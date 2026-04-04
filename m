Return-Path: <netdev+bounces-275360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bbn8M5740GnqCwcAu9opvQ
	(envelope-from <netdev+bounces-275360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2139AF3E
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD573009F96
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77031A7E3;
	Sat,  4 Apr 2026 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="wXtFIZZb"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E22777FC
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775302810; cv=none; b=VXVjKiX7CqhEgqrQ/4Z5cPFs2vwZWukY7SgCOR/yuDgtbZw7COqAG2JniycJaSBMS/85C3YbeTEEYdrvlIkrBzQDhB5ZNFag2wnpmkCdB/wdtxGkwhnTcmkNBJl8/xJzskr82+C16nttE44roc9j3Qvxe60SX08uOhCBkRHYlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775302810; c=relaxed/simple;
	bh=B93AwwnUvwpazkIH6zs1/m82X0nNZfK/6xzJBQOyX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYRmRmIpQI7Hs5sPy+1lpCqSPci3e/u93jiqcVK6jZLaWoxeDNQkCFhoeoO4ZlQTHrEWC052YrPdwkLr2NrTFotXFksOcSA0wz1Vy/TI4khWkVOvU6FYumdxlC01EstMRrWg16j3UHT8+9WrFdfB8U7wfR3WA6/dy2Ck0tnFu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=wXtFIZZb; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 634Be5DL006352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 4 Apr 2026 20:40:07 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=MPq1pUu+fEtcun1am5TUsNjkCUb+pzJqigWwnFIwT9k=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775302807; v=1;
        b=wXtFIZZbgl4ot7WXuTlRU3TXuzrvI3TCoP1fqHCYSb9boNphY3YAKwyTHL0FCQfu
         rUuAOc1utxk3FEnoucXkJSXpB2HImHIQQ15ZX5v+e1GfGT1iZg2oQ5A3Dq/gJr/+
         R2LYHQ143M+G+gr6M/W7csN1uUCUu5/NeMYSFownviPJf5v2ZaH7TRCjiLjrAiN6
         /2w4gTk/NWCyLWG6QRe97RIXA5HtIz7uRkS/jX2f0ny+QZBLBmBaWfW7AuTrdicx
         aYR2emSgoZKdR/80vMn5haM2tlmk/xn2MZzvTVybpx+ljTc1mrOTBaIBSv9MhRZ+
         oixu0m9JlRv7EPJ4AM5RTg==
Date: Sat, 4 Apr 2026 20:40:05 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-net v1] igc: fix potential skb leak in
 igc_fpe_xmit_smd_frame()
Message-ID: <adD4AUcEWQ4lEh1g@x1>
References: <20260329145122.126040-1-kohei@enjuk.jp>
 <20260403140555.GH113102@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403140555.GH113102@horms.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: 23E2139AF3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/03 15:05, Simon Horman wrote:
> On Sun, Mar 29, 2026 at 02:50:49PM +0000, Kohei Enju wrote:
> > When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> > allocated skb, leaking it. [1]
> > 
> > Use dev_kfree_skb_any() on failure.
> > Also call igc_flush_tx_descriptors() only on success.
> > 
> > [1]
> > unreferenced object 0xffff88813aee1b40 (size 224):
> >   comm "softirq", pid 0, jiffies 4294709256
> > [...]
> >   backtrace (crc dee31384):
> >     kmem_cache_alloc_node_noprof+0x54f/0x640
> >     __alloc_skb+0xd9/0x5b0
> >     igc_fpe_xmit_smd_frame.isra.0+0xad/0x510
> >     igc_fpe_send_mpacket+0x32/0x80
> > [...]
> > 
> > Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> 
> I am wondering if we can achieve this while sticking to the idiom
> that the main thread of execution is for the non-error flow,
> while conditions handle errors.

Hi Simon-san, thank you for the suggestion.
I agree. It seems cleaner for me. I'll work on v2.

> Something like this (completely untested!):
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 8a110145bfee..02dd9f0290a3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
>  	__netif_tx_lock(nq, cpu);
>  
>  	err = igc_fpe_init_tx_descriptor(ring, skb, type);
> -	igc_flush_tx_descriptors(ring);
> +	if (err)
> +		goto err_free_skb_any;
>  
> +	igc_flush_tx_descriptors(ring);
>  	__netif_tx_unlock(nq);
> +	return 0;
>  
> +err_free_skb_any:
> +	__netif_tx_unlock(nq);
> +	dev_kfree_skb_any(skb);
>  	return err;
>  }
>  

