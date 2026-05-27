Return-Path: <netdev+bounces-292403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D/eKNMiF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:58:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA395E816D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A75302FB52
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28083EEAF4;
	Wed, 27 May 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EaBEhXYB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF0370D49;
	Wed, 27 May 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900981; cv=none; b=rliqCjUIFiYUOtVvc2PWkfMYOWLYhH6FP99cdf4L43IqgGyF95RkuA/j+DhlHgH3t1jKmYpmtlYdmMgSqNAxFXrJmYEMoFPrcvJ5Z0HBm20LcmDpMkBwWbm6D0jWczuqooiLnCZGBAulm37onEEfheyiRI1HZ6IztCHUwvoFHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900981; c=relaxed/simple;
	bh=1Lfrv7NO3xFevnSV0IKfPfCZuULtZvv5gvK7dQHxRsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g35a/Gem8sH6EypNEsZOdRpvPZ+cmCZYa0WXiPb1lgXvgpPH/w6EeZ7PEUZlisadnzr0MXCLSztYOsK49yRHUtnQBv8G+8KyWOsVTw/fqJjd0Fa/rdDqlss0Jq7UO4JWlAt7jbdQlwF0h4r6lyYZci3Sgsb4tJvydnirGzZCq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EaBEhXYB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/7GoJSQ+WBtG+BHWhAo2c8+SrLX7RJNlVRbny+DRY3w=; b=EaBEhXYBgNrRNVDYo8FUR6Yvlf
	So+Q/OKgNQmErvr8a9usSHd1d75c02YI2QqwLI64JMIiLYinwSU5nnX6ZjRa/bzJw5GIJqemiex1Y
	E7UpiGGgDbv9+6IhbD8V0gSPbdFC7CusdQdGsYgrwjWwkGNepv+njM4Wy68FQXKHa81I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSHYD-004mWI-5h; Wed, 27 May 2026 18:56:13 +0200
Date: Wed, 27 May 2026 18:56:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ftgmac100: assign interface name from
 device tree alias
Message-ID: <bcb13356-9ae1-40e7-914f-7a65e31ca9ba@lunn.ch>
References: <20260527-addethalias-v1-1-24f5bd2d03cd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-addethalias-v1-1-24f5bd2d03cd@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292403-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 8DA395E816D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:31:51PM +0800, Kyle Hsieh wrote:
> Currently, the ftgmac100 driver relies on the probe order to assign network
> interface names (e.g., eth0, eth1).
> 
> This patch allows the driver to fetch the "ethernet" alias ID from the
> device tree via of_alias_get_id() and assign it to netdev->name before
> registering the netdev.

Such functionally has generally been NACKed in the past.

> 
> This provides a standard and robust way to achieve deterministic interface
> naming (e.g., ethernet0 -> eth0) directly from the device tree, preventing
> potential userspace race conditions during network setup.

You need to explain the race conditions here, in the main part of the
commit message. And you need to include how you tried to solve the
race conditions, failed, and decided on this workaround, rather than
fix the real problem.

> Currently, ftgmac100 assigns interface names strictly based on probe order. 
> On platforms like the ASPEED AST2600, this often leads to naming collisions 
> (e.g., mac2 and mac3 defaulting to eth0 and eth1). 

That is intended behaviour. They have always been
non-deterministic. Which is why systemd renames them.

> While userspace tools like systemd-udevd are typically responsible for 
> renaming, we encounter a severe race condition on BMC systems: the NCSI 
> driver frequently brings the management interface UP before udev can rename 
> it, resulting in the kernel locking the name and rejecting the rename 
> request.

So i would say this is actually an NCSI issue. And it is not
specifically a ftgmac100 issue, it will apply to other BMC SoCs, there
appear to be some RISC-V devices in the pipeline, etc.

What exactly is blocking the rename? 

# ip link show eth16
10: eth16: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:26:55:d2:32:56 brd ff:ff:ff:ff:ff:ff
    altname enx002655d23256
    altname enp10s0f1

# ip link set name eth42 dev eth16

# ip link show eth42
10: eth42: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:26:55:d2:32:56 brd ff:ff:ff:ff:ff:ff
    altname enx002655d23256
    altname enp10s0f1

So it should not be the fact the interface is up.

   Andrew

