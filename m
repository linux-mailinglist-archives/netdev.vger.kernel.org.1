Return-Path: <netdev+bounces-284389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF6MG/7s+WkLFQMAu9opvQ
	(envelope-from <netdev+bounces-284389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8334CE3B6
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E85643004617
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C3423A62;
	Tue,  5 May 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AVY3s7ey"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBC15E5DC
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986811; cv=none; b=oX4eosxVkA7+uEXmxhQO4Lhnh0YsNAWwgNMb5gwe/v9MaCR7jK76L+8dMzXADGSUleMD7sUQ7RB09rzGOpOQaPFRfkn6J24lKEUXfhzARSTwUYiqNeUtiWnSEG9LWImebimeU3nwKWxALTkJc/AZsN1ccSAIIMUZ6u5knEiMqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986811; c=relaxed/simple;
	bh=WBl/qqeiCSia/oO2gq4hPG0MXfPgrwgRpfbf0/pzGWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5J8SboikynzaRy8vvIF8m583qEbkbKp757tnljXBGKfLIyDnOhRKfDYtIe6dX9PKhBHWgZsxtosvUU4Z+9Ozyxi12WgR7gjDOUjfiPklboEMqLwCb4yZkE+VM87UzTBhxHxIwO7+ox5KYOw0PxQtwKYBoa4jfuqb0NNG2fXOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AVY3s7ey; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LKeJ2t7XUT0kHt+EQXhtyTutnBFAOtq3Tig0LjnGud0=; b=AV
	Y3s7eyt6QpSSPjaqcICsBZSdCbPkjs37EQO7kep9vYlposu4QeJmn942s37EauAQTRr8ZHUV11fk8
	MY8B8yMrKQI4LmIDzDo41k8c3bv1Pep5EoM+LWmXbCFVBSCdgGYYanD3aWnUaBrMZrZjlzYnon64C
	JymPn0NoJbVdlEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKFaa-001Sjz-RQ; Tue, 05 May 2026 15:13:28 +0200
Date: Tue, 5 May 2026 15:13:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 0D8334CE3B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284389-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Tue, May 05, 2026 at 09:53:06AM +0000, Sven Schuchmann wrote:
> Hello,
> I have a raspberrypi and switched from kernel 6.12 to 6.18 and now I have a crash in phylink.c.

Please could you try 7.0.3, or better still, 7.1-rcX. We need to
determine if the problem has already been fixed and just needs
backporting, or is it a new problem.


> I am using a MAC:lan7801 and PHY:dp83tc811 and now it crashes like this:
> 
> [    3.019174] usb 1-1.3: New USB device found, idVendor=0424, idProduct=7801, bcdDevice= 3.00
> [    3.021152] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.023192] usb 1-1.3: Product: LAN7801
> [    3.025019] usb 1-1.3: Manufacturer: Microchip
> [    3.026772] usb 1-1.3: SerialNumber: 00800F780100
> [    3.078542] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): int urb period 64
> [    3.091434] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): validation of rgmii-id with support 0000000,00000000,00000000,00006280 and advertis                                      ement 0000000,00000000,00000000,00006280 failed: -EINVAL

This appears to be the real problem.

> [    3.098928] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): can't attach PHY to usb-001:004, error -EINVAL
> [    3.101094] ------------[ cut here ]------------
> [    3.103163] RTNL: assertion failed at drivers/net/phy/phylink.c (2337)

and this is a knock on problem, which normally you don't see.

Please could you make line 1 of drivers/net/phy/phylink.c.

#define DEBUG 1

That will give us additional debug info.

     Andrew

