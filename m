Return-Path: <netdev+bounces-155337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C964A02009
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7BF1885077
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D407194A54;
	Mon,  6 Jan 2025 07:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28761E511
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149377; cv=none; b=Ylp//rLSsXBcECGPQNIt/o5Zo8qDAmi9QQ2YMFLWaCYHwUdLhihTEk6qHgBJcrx0xBSPGXQbLzbRojGGZZErnl9FKS6OPf8whSLMriSgI++C0lWYXQQO2FW37sYPI04siwJpGwN+1+DbJGcZH24NXuDGvnSiUe8fTK4J8QOGoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149377; c=relaxed/simple;
	bh=xolavlOIeBm4x+UHjoyzETDFEg3zj0MVb7HVVVkNiSI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJiv+hqjtIfZd8lLoam8VmdRsHfOR6Bh0pHbPsJVMuzJRCWWPToPgFDBHKCZ7gBLMOu7IaXBH58zQsgF0H+MsgRBrX/S9ZyByp/IrXMRmiT/ctt1Z0t0C+noH24AjVWaz3kS6T0QG8rYMgYa3R16vG4ERFBxLeVW4NuyoDuFfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1736149356t666t30354
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.30.165])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2943653864027222232
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com> <20250102103026.1982137-2-jiawenwu@trustnetic.com> <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
In-Reply-To: <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
Subject: RE: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Date: Mon, 6 Jan 2025 15:42:35 +0800
Message-ID: <032b01db600e$8d845430$a88cfc90$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEgJ35Ybs4gTOBDiJnQm6cX+eEXEQKNhMgNAhs0hhm0WoJCoA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N+B8S2AmgbnC4w/F2TBXR8FVF6/I3R1REr9rWFA5u9ve+QOMxDIcaVac
	jn2DCaVC94WS1A/U+IMai+isy8OxNxrAA97nX7mszQiajND1IBA8ITdpEvfEUjwihubdXJ9
	SspXpCPoOOzb3csV3K0WPjjSvkmjs6EkfJWDnVbXt4tc86qIQUbPVOiN6y195yh8gJXfmyi
	CIC2R/IpYaK7kYxYIcGuhWicXPKD0KwcqmOwH0D8mSBYoGxFPdpB+YjJ2LZOSav5asj6ob7
	fn4OJizXZkGXRHKpCWfLIKDYESxowIfPVy//hy9bZj7OzCKKb81OhXB4GI3Q6UOScKJvRdS
	rwg59qgstgXBSHqdbfNFQeReZfswAKPWBWgBAgUjBTOjFhoiP+1GjF/5Nf0L50I1eHhG2ex
	IUi09EFSG/DwJpyV+xj+WvBXG0ppW1IOvF37WblKp9A7OEkCwtuoWaKla5QQU9w6AJAC/DQ
	xuOB2Fdgc3+f9PLsRj53n6hfKL6DvohUMeTDj3sgzgHuPclce3ojevXKjwKNOv/zkam931Z
	z6uqTmagOc3XbZBhkTiTW97rZQKoHl2UJt6FVrLBbk0zpGfzmMrfTSelSmM9uZ6tp3kVbSb
	ppy8/cYj6yDQdngxREQxhuw+smk9UFV2RciPtpMLNmo2llfqbKD8NDOUkqU48Vjn80eSEcl
	2sgjtio1niwpRQvg5iOwdSMUumSfhza0UmSaNthWToH0iCXfTK8K/SyYulpZY5ZnI1QVpjW
	MBdgpM6M8PpAUzhUzXylR0CglKg8jVwsDQ09xAdvV77SVBk20Fm75K09K6Gul61I3wKK+jo
	VImhP3Z9U+eF0dRkUs00cSakrDUI+6UhP7euoPlDJU9tGsR+uRnhpEs5byD1yHBhzcGhIwF
	6/GTOdKw0MozvT+ejLDwyY44zsUf/lA0dQrRu5E5lyBvXLLffUIclXpCTFn+Ge3cRIlQIJl
	u1UzT7MXVzivlV9tN45l9hRasG9veno58ULFC549Y4SjGuWdOLfbo4l/cGEudiuImT+V9BJ
	rIii9P1g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, Jan 2, 2025 10:13 PM, Andrew Lunn wrote:
> > +static int wx_tx_map(struct wx_ring *tx_ring,
> > +		     struct wx_tx_buffer *first,
> > +		     const u8 hdr_len)
> >  {
> >  	struct sk_buff *skb = first->skb;
> >  	struct wx_tx_buffer *tx_buffer;
> > @@ -1013,6 +1023,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
> >
> >  	netdev_tx_sent_queue(wx_txring_txq(tx_ring), first->bytecount);
> >
> > +	/* set the timestamp */
> > +	first->time_stamp = jiffies;
> >  	skb_tx_timestamp(skb);
> >
> >  	/* Force memory writes to complete before letting h/w know there
> > @@ -1038,7 +1050,7 @@ static void wx_tx_map(struct wx_ring *tx_ring,
> >  	if (netif_xmit_stopped(wx_txring_txq(tx_ring)) || !netdev_xmit_more())
> >  		writel(i, tx_ring->tail);
> >
> > -	return;
> > +	return 0;
> >  dma_error:
> >  	dev_err(tx_ring->dev, "TX DMA map failed\n");
> >
> > @@ -1062,6 +1074,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
> >  	first->skb = NULL;
> >
> >  	tx_ring->next_to_use = i;
> > +
> > +	return -EPERM;
> 
>        EPERM           Operation not permitted (POSIX.1-2001).
> 
> This is normally about restricted access because of security
> settings. So i don't think this is the correct error code here. What
> is the reason the function is exiting with an error? Once we
> understand that, maybe we can suggest a better error code.

I'll change it to -ENOMEM.

> 
> > +static int wx_ptp_adjfine(struct ptp_clock_info *ptp, long ppb)
> > +{
> > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > +	u64 incval, mask;
> > +
> > +	smp_mb(); /* Force any pending update before accessing. */
> > +	incval = READ_ONCE(wx->base_incval);
> > +	incval = adjust_by_scaled_ppm(incval, ppb);
> > +
> > +	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
> > +	if (incval > mask)
> > +		dev_warn(&wx->pdev->dev,
> > +			 "PTP ppb adjusted SYSTIME rate overflowed!\n");
> 
> There is no return here, you just keep going. What happens if there is
> an overflow?

If there is an overflow, the calibration value of this second will be
inaccurate. But it does not affect the calibration value of the next
second. And this rarely happens.

> 
> > +/**
> > + * wx_ptp_tx_hwtstamp_work
> > + * @work: pointer to the work struct
> > + *
> > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx hardware
> > + * timestamp has been taken for the current skb. It is necessary, because the
> > + * descriptor's "done" bit does not correlate with the timestamp event.
> > + */
> 
> Are you saying the "done" bit can be set, but the timestamp is not yet
> in place? I've not read the whole patch, but do you start polling once
> "done" is set, or as soon at the skbuff is queues for transmission?

The descriptor's "done" bit cannot be used as a basis for Tx hardware
timestamp. So we should poll the valid bit in the register.

> 
> >  static void ngbe_mac_link_down(struct phylink_config *config,
> >  			       unsigned int mode, phy_interface_t interface)
> >  {
> > +	struct wx *wx = phylink_to_wx(config);
> > +
> > +	wx->speed = SPEED_UNKNOWN;
> > +	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
> > +		wx_ptp_start_cyclecounter(wx);
> 
> This is probably a naming issue, but it seems odd to call a _start_
> function on link down.

I think this function could be named wx_ptp_reset_cyclecounter().



