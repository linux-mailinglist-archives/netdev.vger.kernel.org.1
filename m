Return-Path: <netdev+bounces-268766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFdNOUTduWlHOgIAu9opvQ
	(envelope-from <netdev+bounces-268766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:01:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCC2B35FD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA20C309DDB2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561E37646A;
	Tue, 17 Mar 2026 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3PgCmGxe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2138C2BB
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788309; cv=none; b=af/jXdqMwdciYHa2L5Z5UoHAa61Ce6Tr5Fx5vSx0eCINXWcgqNHHkPu6B/FpZK8wYkylecF1r1AKvs3sPcAJt1Ffd+ch1ZhYj7HIhm7Zn9SDgddgiOD5Qe4ORI7yKeL0u9DghclTlpNFrxq8C98xrsuICkl/z46Y+Ao9xrsHqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788309; c=relaxed/simple;
	bh=dQiA8yBuCziHNh7cIQW8c1FhhQEnHv4RonK179dhnRo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r144vRiwelm96J8bubxooKC9Q+8/bgANgBsT4iKHKLZwweBlF14IX+DXH0xjArkLGuFRKoZUmJZjIH3GDoo8PHIeqC3o5BRRDj9JUxBUL07ZmkVw4tXlp+qTW1lwFtwGoe7qznQNKVjnKJhlmvAbydBQhrPzwzCg5Ulc/xu/0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3PgCmGxe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8827DA56FA;
	Tue, 17 Mar 2026 23:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773788303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kmxYBn6bxsLkWhzNsQ/p/LJYhDXO2Os4fU/hWSIaf60=;
	b=3PgCmGxezv4a6dTBEzowIFSMKA1UH1IbseQUbmBBObSE1hj733PwSmqBRP6uM9IEDfdB8w
	kh3fscIoXul+BZ2yy/jRVYCajrWYW5dF7QDxBZunSYxH9zgwOP3W7ZWXJ30J/ffWY3ZUJO
	oskPk1NmOv6hrHXsUWmbTQp7T63PQD70Hq4HkpSPqxB6d+kUJ8j5eYowll79d6F5bEGB7N
	qqm3xd4+BJ5i+1eWy7NBvOm4ULF+ZyQrQNrVbwvMVRfcf9SYKWW5xAOQtnGopKbyVIGKps
	4hDuYqbPlT4CTmIFHNDPhWeG47jiUdM+xs7tZdUu+foYPApM+YgVNREFj1Qujg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 23:58:21 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the interface
 is running
In-Reply-To: <20260317152330.32998fdd@kernel.org>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com> <20260317152330.32998fdd@kernel.org>
Message-ID: <1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268766-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 83BCC2B35FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.3.2026 23:23, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 18:00:02 +0100 Théo Lebrun wrote:
>> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> I told you recently that open / close is not allowed.
> So why are you putting a rb tag on a patch which does exactly that?
> 
> https://lore.kernel.org/all/20260306190948.44d23f8f@kernel.org/

Just checking if I got the idea before submitting another approach.
Something like:


static int macb_change_mtu(struct net_device *dev, int new_mtu)
{
	// declarations
	// ...

	if (!netif_running(dev)) {
		WRITE_ONCE(dev->mtu, new_mtu);
		return 0;
	}

	// stop TX + NAPI
	// ...

	// stop MAC (macb_reset_hw), no phylink/PHY/PM touch
	// ...

	macb_free_consistent(bp);

	WRITE_ONCE(dev->mtu, new_mtu);
	macb_init_rx_buffer_size(bp, bufsz);

	err = macb_alloc_consistent(bp);
	if (err) {
		// device is down, no DMA buffers - same as igb
		return err;
	}

	// init rings, init HW, re-enable NAPI + TX
	// ...

	return 0;
}


On alloc failure the device would be left stopped, same as 
igb_change_mtu() does it. Or would you prefer stmmac-style 
pre-allocation?
That would mean refactoring macb_alloc_consistent() to return a separate 
resource set.

Thanks
Nicolai

