Return-Path: <netdev+bounces-304615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PpckK33oR2q+hQAAu9opvQ
	(envelope-from <netdev+bounces-304615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2B7046B8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=RiXl7Zd6;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304615-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304615-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55306300574D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F372BF3E2;
	Fri,  3 Jul 2026 16:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF2220687;
	Fri,  3 Jul 2026 16:46:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097182; cv=none; b=t/jM8/Y60NTzSYbkgF/J55/w9lSzrWXSUeoMyYmP2fRUVEmsBlX0eiqmFDYwFohIH7ZZQqeCdYYwpUo/oQ+GoSarzuFJipVzzZU1ZYQfFQB1UAYsquz61e7Lbisl8P+nVW9XsNLcpiuPQJ3tG5zkSNU11OK1lC2zS0Yq7gu+cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097182; c=relaxed/simple;
	bh=Xx/AJXxYPYdMvfbc9uMV7pZ0Ruy1B+NaGJFWqCwhDjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBY4YGnjwZThIxsdS0wXASuPKaC4/SnxjAv2cqGamzN2uouNuHEFxpPx3lChmyJwYKE4tdMI/gvIa2kiosn0l4d0DZ4dZDnM/WFtmo+o/lZkoZ5zN5VMcC3FKDkGx4f8M584sURaCW3w9bfVsi3macbalgsjofDrX20zQqhkP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RiXl7Zd6; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OaYuKQygyMpMiERKDul0ExGBtJ0ROe+TDzmtRkadt+o=; b=RiXl7Zd6rJypQW8MMYpkXwLua+
	C9MzO2Wq2Ki0yArakfh240q76DhTPThnEhfI761d2kQ6spO2dSKKSMzTJtj5MgXLv0YZa09u/vVok
	fknszntth3ryKCoycIr7HK4EtKUB4aXsp7ir0ZNFYnfYlYqfin7XeNxlwERs5KJ42s5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfh1s-00AZsQ-7Z; Fri, 03 Jul 2026 18:46:16 +0200
Date: Fri, 3 Jul 2026 18:46:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com
Subject: Re: [PATCH 1/1] net: usb: aqc111: fix set_mac_address return value
 for bonding
Message-ID: <43a0904c-de59-4b40-b186-edd130f6c0cb@lunn.ch>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703073936.462231-1-hanson.wang@ugreen.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304615-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hanson.wang@ugreen.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:oneukum@suse.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0D2B7046B8

On Fri, Jul 03, 2026 at 03:39:36PM +0800, Hanson Wang wrote:
> aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
> success. That function wraps usb_control_msg(), which returns the
> number of bytes transferred (6 for ETH_ALEN) rather than zero.
> 
> Bonding calls ndo_set_mac_address() when enslaving an interface and
> treats any non-zero return value as failure.

It is not just bonding which has problems:

int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
			  struct netlink_ext_ack *extack)
{
	const struct net_device_ops *ops = dev->netdev_ops;
	int err;

	if (!ops->ndo_set_mac_address)
		return -EOPNOTSUPP;
	if (ss->ss_family != dev->type)
		return -EINVAL;
	if (!netif_device_present(dev))
		return -ENODEV;
	err = netif_pre_changeaddr_notify(dev, ss->__data, extack);
	if (err)
		return err;
	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
		err = ops->ndo_set_mac_address(dev, ss);
		if (err)
			return err;

Could you take a quick look at all USB ethernet drivers, and see if
this bug exists in other drivers. If one driver has it wrong, it could
well be more have it wrong.

     Andrew

