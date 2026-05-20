Return-Path: <netdev+bounces-289683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G0TEaYKDWrysQUAu9opvQ
	(envelope-from <netdev+bounces-289683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:13:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D38985867AA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A88C304CF74
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744182C21FE;
	Wed, 20 May 2026 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fIpeKsBT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DB3438A4;
	Wed, 20 May 2026 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239587; cv=none; b=TzKAKK7QFpPPv0D8NxseM7DMm9fUvj1JEIOZAWOGrJz87mUP6DxzxLSP87mZ1ZLTQNGcrhbluLMyAvULFKXU9LlSlZpRSC9KkrW3vIQWw0XQLboOsxv3T8KOSeuwPWCWRpjbl5pkfAjC0N9qUyX0c/jE8wuXx4Xei5qSnSlncAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239587; c=relaxed/simple;
	bh=TFTfZ3XF6CqzODpasTiqIHoiDxbzAG2FkT+K1h47on4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltH29xF8WKV2fajXIYg2ssrkXCO6DK/kddj3q5ZzBZISnaTR8MRIBO3PVdORE8Y3728coUnaHikCaftu0aZRDVDuTtw5p93KsmKspZgjIsk56mqt106qi5khY0XNP5EGYJ674OMyOGVa/44KCwr3FqkWoAIWFgktTzL5kEXxB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fIpeKsBT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bXG0Wva1nU+HyoMbFpuo7P4RMd7L4v0ROGwriQ9bGXE=; b=fIpeKsBTB9Omqg6NFrbQDClLVP
	EXo7ROfXBkpESbbBCiY3VN61eZfg263w6NRki0ijLDPhdgRYWmqyWNqK9aVjLVK98q7JOdUvIClaC
	JBu1Dz5/WLRnFGoKK+znQ7tSZmWnM15idZKh+LmMBNgGcMmdIJbOZ/fhSBt0FjXOXV4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPVUW-003ktG-JG; Wed, 20 May 2026 03:12:56 +0200
Date: Wed, 20 May 2026 03:12:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: dsa: mxl862xx: add SerDes ethtool
 statistics
Message-ID: <8fe2cc9d-2a22-4a19-b313-8e570cdc975e@lunn.ch>
References: <cover.1779203863.git.daniel@makrotopia.org>
 <5e8391488f4dbf23133d16ceaf1b168b39304c97.1779203863.git.daniel@makrotopia.org>
 <20260519184005.cx32dtj6v6wosb3s@skbuf>
 <agzqLhlZsSQnWjP-@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agzqLhlZsSQnWjP-@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289683-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D38985867AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The firmware also exposes self-test via PRBS and BERT, which also
> doesn't fit the ethtool self-test model very well (which currently
> supports only MAC-level and PHY-level loopback tests, with no way to
> represent the PCS/SerDes-level)...

Where was a presentation about this at last years netdev conference
and a long discussion with Alex at Meta about how to expose PRBS the
fbnic has. It is probably the same PCS or similar PCS, since they
licensed it as well.

   Andrew

