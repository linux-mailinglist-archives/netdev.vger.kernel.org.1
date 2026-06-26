Return-Path: <netdev+bounces-302190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gvDdEcaNPmpbHwkAu9opvQ
	(envelope-from <netdev+bounces-302190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC196CDF33
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=pPlLYSEl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302190-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302190-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8DC30247D0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69E3F6C3C;
	Fri, 26 Jun 2026 14:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AA3F4DC0
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484348; cv=none; b=Ou3WoA9T9wnNkqGnHmxm/FY4L4DXCMMbwvoKxlazA/uf+8yfCV8C1hJYNE5dLBrmY2KHtHM7hLg9llUrSt/m5O7FjhLmojjFmqMzXdyyImZZo+TIKgcDlW0xmBVFRMt0ZfyC4BOWazRS0QDzIxx1mzqp5Ycqh6OcnUkIXQLE/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484348; c=relaxed/simple;
	bh=F36sVb0uhsA8Dj2h4dZa+5KdjUe9/H+qIrfW3tfRADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUiYhqN3tIga5bDF2WDoTwH7dHgN8A77OQjhs2Nt0til3Q8ifKU9fNnDeD9J0bElqFE+sTenC3Sf9o3rPxYWhr46lWR1Cm8vZQSSnnF1tysJyGT+MEPlMAVZ8B1BFyOxg2Q66RznivmavbBQTKBORmfa4M5BnKr6xakY+/R2kuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pPlLYSEl; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8+f4g3FkcW5AlmqHvS55wx6YptrRYjtILQ7u1414NTY=; b=pPlLYSElIWd1XzNpqKshRUdsoM
	jwIPBoE9+5T2zIFyic2EHXUkS3pwZ29xPaWpMNe0PmNY/qW9X1146lCFc5I2ZA89hW1tmp5ppveaK
	36C1Rqsbav92YKp3sbHmTy0DqtODrQtNs0GmMipP94oyLhGrA4/ZXyLUrxcLhrmUF10s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd7bT-009NdS-FN; Fri, 26 Jun 2026 16:32:23 +0200
Date: Fri, 26 Jun 2026 16:32:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Message-ID: <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302190-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DC196CDF33

On Fri, Jun 26, 2026 at 02:15:27PM +0000, D H, Siddaraju wrote:
> Hi Linux Ethernet Team,
> 
> We explored Ethtool's "10000base_CR" PMD PHY type
> and we think it might be just a wrong name.

~/linux$ grep -r 10000Base_CR
~/linux$ 

~/ethtool$ grep -r 10000Base_CR
~/ethtool$ 

What exactly do you mean by 10000Base_CR?

     Andrew

