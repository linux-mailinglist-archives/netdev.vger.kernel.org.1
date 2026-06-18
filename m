Return-Path: <netdev+bounces-300524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id od1hJnhANGrXSwYAu9opvQ
	(envelope-from <netdev+bounces-300524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136506A2459
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=lcsiSxE7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300524-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A3330237CC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7343321C2;
	Thu, 18 Jun 2026 19:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798072DFA25
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 19:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809268; cv=none; b=Uc65rXx8TWrjg+Z6qqpPOXw1Q7mSgXrZtuGwxea23eurcP9b66zbn2Wycd8DxhpzyrEtXgi4nqLifihUvsSHaCsrvBHjbUGmxsMkSbaC7361umbLkkz8Kf5bG6Ex7o9jqAvgOb2rBV76R0+xugav9DJFCm1jMXd+9BH2nzEy4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809268; c=relaxed/simple;
	bh=4IP45nhII7Q6U/N69JdgKt9ewfSkbDGTXCnD2UnYJD4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kb60l84HfBrPv5ES1GJ0BVwUnexKFubzgzl/iDbWLzLjdVbVB59oWA/9dMYrzzLwicxdYLdyhtQWyEXVe9MXwnnct5tBzUX9rDSUwbFaq7GKpj52x33oMjBjrxwhLia+/OEsz8Ab11x3Ou4iirrx+r17XUKlrA+0QHmiUKl+fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lcsiSxE7; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A6C6A017D;
	Thu, 18 Jun 2026 21:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781809255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X7RIMxF7kllViLgHajMn0jicwvzwIm5k4nYYqE744K8=;
	b=lcsiSxE7MQIbiFUIXmAnxPduSZWy1T7hfKN76rLsgi6U8QSCbkbpbH8GxVVMEp3a5Sb4KM
	RoDB8aV9MLsd7bUDwQmBXcboCP4lPYhnsO9NkETonXe6gBMoye6N2L/kI5CYYjwLnaGoNb
	SiiFxyD774masWt0z7l17b/x/078hKTCx+qv8iVCT3TMEWCM4AkFwE58vZ9dMSA9LomsA2
	21vigXBL/1c/HiKJuoD21KYf5M/8Yt0faF3JDKWYJvdhfLxRs2Wto1XfTCD+KYJpB3zTrC
	Qq/K6Y0hNmiARh2Q8LfdG7KRmcf9yZeAOT4pVN9EuwiBF25XuTr4W2VLba9IBQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 21:00:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: netdev@vger.kernel.org
Subject: Re: lan7801 looses VLAN Filter Table
In-Reply-To: <BEZP281MB224501E38B30BFDC4BD3D364D9E32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <BEZP281MB224501E38B30BFDC4BD3D364D9E32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <24f3b25001984dce928f564e26bb35d2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:schuchmann@schleissheimer.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300524-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 136506A2459

Hi Sven

On 18.6.2026 17:18, Sven Schuchmann wrote:
> Hi,
> I have a problem with a lan7801 chip in Kernel 6.18. I configure 
> VLAN-ID (2) and an IP address.
> But if I disconnect and connect the network-cable several times at some 
> point no packets are
> received anymore. Without using VLAN this does not happen.
> 
> I tracked this down that sometimes the VLAN Filter table seems
> to get cleared. I hooked into the lan78xx.c driver to dump the vlan 
> table:
> 
> static void lan78xx_get_stats(struct net_device *netdev,
> 			      struct ethtool_stats *stats, u64 *data)
> {
> 	struct lan78xx_net *dev = netdev_priv(netdev);
> 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
> 
> 	lan78xx_update_stats(dev);
> 
> 	for (int i = 0; i < 3; i++) {
> 		u32 buf;
> 		lan78xx_dataport_read(dev, DP_SEL_RSEL_VLAN_DA_, i, 1, &buf);
> 		if (pdata->vlan_table[i] != buf)
> 			netdev_err(dev->net, "VLAN TABLE %d: 0x%08x 0x%08x", i, 
> pdata->vlan_table[i], buf);
> 		else
> 			netdev_info(dev->net, "VLAN TABLE %d: 0x%08x 0x%08x", i, 
> pdata->vlan_table[i], buf);
> 	}
> 
> So I can "read out" the table if I do "ethtool -S" and see it in the 
> kernel log.
> Normally the output looks like this:
> VLAN TABLE 0: 0x00000005 0x00000005
> So the table looks as expected. The Local Filter table from pdata is 
> the same as in the chip itself.
> 
> But after some cable disconnects and connects I see this:
> VLAN TABLE 0: 0x00000005 0x00000000
> So the table got cleared or deleted and no paketes on VLAN-ID 2 go 
> through.
> I even can do this after I read out the table in lan78xx_get_stats():
> 
> 	lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,
> 				DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);
> 
> ...and with this I can "fix" the table again from the ethtool and it 
> starts working again.
> 
> Has someone seen something like this or can point me to a direction 
> where
> I could reinit this table (I already tried at the end of 
> lan78xx_mac_link_up() without success...)

I was able to reproduce your issue on my hardware. AFAIU the vlan table 
is not restored after USB suspend.
I will send a patch shortly. Would be great if you can test it too.

> 
> Thanks!
> 
> Regards, Sven

Thanks
Nicolai

