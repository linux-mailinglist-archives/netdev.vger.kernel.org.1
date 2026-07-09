Return-Path: <netdev+bounces-306264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lM3yBiKqT2ppmQIAu9opvQ
	(envelope-from <netdev+bounces-306264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:03:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B1731EDF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=FsTDzJUP;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306264-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306264-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18001304BBD7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97E32ABC0;
	Thu,  9 Jul 2026 13:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E93126BF;
	Thu,  9 Jul 2026 13:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605496; cv=none; b=t/gMqW9nxfltwYjPl3jvQyoOur4X/foO3hero7N7bYoswLGjfq5wieSRiYRMc865WqrXRUvTkX8SnvVbzZE4sMVJr3Ovsuvr/HNASyn7uLemewKbWErNDyEA3cGDp3hSmOGL958qxQcOCXyddcNcjWphbcbecDMRHp4fksI8BDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605496; c=relaxed/simple;
	bh=3hwXFOzv/YTq/Wpo0kEOWr1fqx4v+yPB06CDQGibXQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDkUoF7UuRFHMWvOA1ynPH5yobTJJvy/4kxiHk+7o2R+y31aPTyWMOi0O1vEzJ6sZnX4sfDliMgxDKdY0/H9Dn5ZrkgvHL8cfXV69ddrUGWW4+bM9oDsp1ElA0Yn0iQZ0Mh7uCByzxdEystvxpGSXJcjqu/R09jfgzLj/H7W4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FsTDzJUP; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3j5wUOy81jE85IQW1jkfY+qaRlufRS4VpmYySwqNofk=; b=FsTDzJUPGt8N4nYpc8afLFPlRq
	6M/4HGyszaGPq1I2VBGgct5CSRElAYMq2jKF2NlK7XRldUwQw9HOfyWvfo9n7XNw/G0qK9Pt9iWFv
	3A7mAIyFw7MQVKzbTsPIgbFggtRqTwbxFmHeP2khEkhdUaqJsRPCZLjfVHMiBP3BJFCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpGS-00BVJu-UW; Thu, 09 Jul 2026 15:58:08 +0200
Date: Thu, 9 Jul 2026 15:58:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: packing: fix brackets
Message-ID: <c7a53f96-b5b5-4e41-b134-afb0b1518c33@lunn.ch>
References: <20260709121427.391749-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709121427.391749-2-manuelebner@mailbox.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:olteanv@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 876B1731EDF

On Thu, Jul 09, 2026 at 02:14:27PM +0200, Manuel Ebner wrote:
> Add two ')' to nested functions in code block.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Please add a Fixes tag.

With that: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

