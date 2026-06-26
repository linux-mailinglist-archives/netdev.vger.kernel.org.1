Return-Path: <netdev+bounces-302191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x0QAAOeNPmpiHwkAu9opvQ
	(envelope-from <netdev+bounces-302191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:34:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5FC6CDF51
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=FdHPeELh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302191-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302191-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6336303B665
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BE3F822B;
	Fri, 26 Jun 2026 14:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA33F8ECD
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:33:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484441; cv=none; b=X0WJNbonD0yFhanwbCd64YTVkn7R2zQ0O8vn/2Q7pieY4D6dnHQMSi+1aOFB3XX1cpaw2rXe4HMZiAXPZavcm+wuik6P8+SSpmRRaZbVe8TV/Kj1ldk+gWME1Hh84oaGdUxIDVPcRYqdODraelaepfc6JG9QOkhc8G8RyT+ztjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484441; c=relaxed/simple;
	bh=kzB2+Gijiaob8V3C6+WkJPdhk4/j4sbym6OVPCbBVFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr3LxtybmpU65rGrkczD2jd7hiEc3Hb3SJLFvHVPHH94964+na02kxNQQWMtowFypGZXLA/8A5OKEFB8xiyeIuJiq+nHZZ1nXpY5z4G510f4jJK5XKVh1U7CtG/62YuPdR17Co3vwSYx1JEkvG6fUj7rGdVFrpC+I0j3hwxXuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FdHPeELh; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E5B031A0967;
	Fri, 26 Jun 2026 14:33:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B912460232;
	Fri, 26 Jun 2026 14:33:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71DB6104C94B9;
	Fri, 26 Jun 2026 16:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782484437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rIxDQbEtjVkGtvbsZE8M3fdbMoJLc5/90NMlrDZdll0=;
	b=FdHPeELhc5tacNXLYU0Mh0zMEpBZN3HP3SJK0DJmziSGIvYzy9FJi5ZCdvI+uCSbvOkOek
	EuwxGjVB9N6hBopxMpDXOHGGKolP3I1vG1WpW9hIuHalCQI9usnBh9k8RzewQqdYQmpANA
	9+GnHy2l9z9jlIGohOZiwV8TvLBjRlUOEmxMORIU5reLpGA4FK48PdkiDvA+ppFs325Nz2
	r1K+RCHHDZEu0EX2/CEUzPcFSzIykFgJk97P4uZEP1/F8N/h1XUxw3ECk9TbVDiWfoUedx
	DEjVJQMg5O+8Qzn1eOw86V4gXfhHSezqK92sxQYbF/u1Zclyw7327pOlT80bkA==
Message-ID: <9527a821-114a-4696-925c-1529da2bf5b8@bootlin.com>
Date: Fri, 26 Jun 2026 16:33:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
To: "D H, Siddaraju" <siddaraju.dh@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Das, Shubham" <shubham.das@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302191-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,bootlin.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F5FC6CDF51

Hi,

On 6/26/26 16:15, D H, Siddaraju wrote:
> Hi Linux Ethernet Team,
> 
> We explored Ethtool's "10000base_CR" PMD PHY type
> and we think it might be just a wrong name.
> 
> Why we called 10000Base_CR, a confusing name?
> Because it fails all below 4 major highlights of a "typical base-CR"
>     1. Every other Base-CR is an IEEE defined PMD specs
>     2. All Base-CR have AN LT (Auto-Negotiation & Link Training)
>     3. Almost all CR have FEC mandatory
>     4. IEEE CR is a very close sibling of IEEE KR, the complex ones
> 
> There is NO IEEE 802.3 or ANY other standard spec to
> support 10000base-CR and the industry fully adopted
> SFF-8431 Appendix-E Direct Attach cable as 10G-SFI-DA.
> 
> We feel 10000Base_CR must be renamed to 10000_SFI_DA.
>     SFI: SFP+ high speed serial electrical interface
>     DA: Direct Attach cable media

Well it's too late for a rename, this is part of the userspace API
so this name is here to stay :

https://elixir.bootlin.com/linux/v7.1.1/source/include/uapi/linux/ethtool.h#L2013

This was introduced in 2016, I think we won't gain much by adding
another linkmode that's equivalent. Even if this isn't strictly
speaking the correct mode, even some vendors sell their DA cable
as 10GBaseCR cables now :/

Maxime


