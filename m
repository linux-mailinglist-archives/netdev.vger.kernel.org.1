Return-Path: <netdev+bounces-301927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N6bFCQQEPWo2vwgAu9opvQ
	(envelope-from <netdev+bounces-301927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622536C4AE0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=tGJizTwj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301927-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F1A3034B19
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD33CC310;
	Thu, 25 Jun 2026 10:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D4373BE7
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:33:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383616; cv=none; b=X0JZ5nqV2X/asVZkZQb7Xx7Q6Z4/dav5ejDH49VqGQehogTjSbkcjD5vN6NIUlaPufv+rtwlbhefYuS1ugL6i+la0uZanmXQp+vHoK7yFXq2Y+NNHyF7I8jRnRQ/OzJ99dppJOlZNbFG4+fRFcKEucC7gwdlxzvpFXbFIpQrgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383616; c=relaxed/simple;
	bh=OQFcZG9mWR4m4AcJJ1kpIjFnswXPritMasjmR+UTr1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVo8/Kx+uu2lKtdqd04hJfHMI5tiKEZRiyHnDG+2LK8h/imDEfLwzT1z3VseZvVC53dVQ8rdfEKGXRADR9pV2rcxnmyMFiTt/CbOfHYbpDPrUdJ7n9xSmoUnWViDtWIjdXCicsL5chpNNKTHO21R6w9k+69AwpcHuKc+HJwbTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=meng.ding@siemens.com header.b=tGJizTwj; arc=none smtp.client-ip=185.136.64.225
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026062510332265121b3cfb0002070e
        for <netdev@vger.kernel.org>;
        Thu, 25 Jun 2026 12:33:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=TEQzGGFrxNtB6gMa9EEbVW6dodrdivVnbfUJXkNVajM=;
 b=tGJizTwjajXkLUyXQ7+sSEQj7hAdSllHPHz0LNjsFt/xqf+XDKzvaivZAIL3QBrg09Qyxk
 1XaxIWfsEjYnZEffaZ5dL3vjZfxWzyIFco75yVhOb5q7AzDOdvu4dvxzgXTIGX5YnQ5z885c
 YZ/9SYuHoz5/tadqXwXzVzYxLnP7HcfkJ+pX6ZEUvyKDGvc3hPMAonSdqo2HmQd55SvscbeR
 ddr/3qBtf22rxnrCeKn2wb16Rvg4WFe2x/BGFV4Rt/sFQr9kSGuZhTwqwh0SMCCXa/LPs9iP
 940TJzzziXEIXKdPgqQb6FAcm6WUE2oyo6MU6rLTGVm6Yi/kiiuguzMw==;
Date: Thu, 25 Jun 2026 18:33:14 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jan.kiszka@siemens.com, intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, wq.wang@siemens.com
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting
 when NET_RX_BUSY_POLL is disabled
Message-ID: <guqc6o3b7hfl66qiuglb46apqdlufiuyhxeuhme66jvjkb67a7@owd45vcy7uv6>
References: <20260622041718.6106-1-meng.ding@siemens.com>
 <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301927-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pmenzel@molgen.mpg.de,m:florian.bezdeka@siemens.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jan.kiszka@siemens.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:wq.wang@siemens.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[meng.ding@siemens.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meng.ding@siemens.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,siemens.com:dkim,siemens.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 622536C4AE0

Dear Paul,

Thanks for your comments.

On Mon, Jun 22, 2026 at 05:59:53PM +0200, Paul Menzel wrote: 
> Am 22.06.26 um 06:13 schrieb Ding Meng via Intel-wired-lan:
> > When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> > from the NIC no longer works as expected.
> 
> Maybe paste some logs/errors, so it can be easier found by people with the
> same issue.

Will do.
 
> > This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> > SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> > fails to perform its driver lookup, and the igc driver's struct
> > net_device_ops::ndo_get_tstamp is never invoked.
> > 
> > Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> > a field that the driver has not populated.
> > 
> > Fix this by populating the hwtstamp field with the correct timestamp
> > in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> 
> Maybe detail, why the adapter needs to be passed now.
> 
> Also, please describe a test case to check the change.

Will do.

> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 8ac16808023..1da8d7aa76d 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
> >   	return skb;
> >   }
> > -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> > +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> > +					 struct sk_buff *skb,
> > +					 struct igc_xdp_buff *ctx)
> > +{
> > +	if (!ctx->rx_ts)
> > +		return;
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> 
> Is there a way to do this in C instead of the pre-processor. That way all
> the code gets build tested. (Is there a config with disabled
> NET_RX_BUSY_POLL?)
> 
 
How about defining a function to replace the pre-processor:

static inline bool is_net_rx_busy_poll()
{
#ifdef CONFIG_NET_RX_BUSY_POLL
        return true;
#else
        return false;
#endif
}

CONFIG_PREEMPT_RT=y && CONFIG_NETCONSOLE=y will cause NET_RX_BUSY_POLL
disabled.


Kind regards,
 
Ding Meng

