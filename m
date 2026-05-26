Return-Path: <netdev+bounces-291680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDm5L32OFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:13:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEAE5D55D9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E20B5300D746
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90D3F86F4;
	Tue, 26 May 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p6Li9L07"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F173DB99C;
	Tue, 26 May 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797626; cv=none; b=iX6iuS6veS17Fvdggx+XlTjogm2eiPKDGnJeYsO4bbgB9tIV1V1ZKA8BBp06hh1td8Ifbv+p0WVbEMCsLV3iuRI8unahkQYbjDMSOrS5N9hheQTmKWRuS3DZFoqIym8bpgl20u4kbaprTLgTQhJxeKove6wgewhBOi7TZyVX1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797626; c=relaxed/simple;
	bh=iEhIEnSk6UKFm3ozBVTJR/Yf2JUtQDkw4yyvRIRwNZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma0N9j5O4+qf4HRg63dIPOgchtJ3U4+lCuIRoqAxOgSuwj+oyz4kHLF+2ZIbyGdo+5Z7X3OOMAndCVzFn+H7Qt5gsVC62ER33QuBJJPqeCYXYa9yl7oERna+KFiBdY2icIzbGJEEO+6Gb/XLPq5c8+p0MJilvVUye7wIOpcbxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p6Li9L07; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BmquLz8SH4S/O41FMOdrOTSrQClOSQGlMMUVPHsqsKI=; b=p6
	Li9L07w2kH3SY6CR4+CUpx05paXYPS6TpmLEs/PkT3W0j58u3avFyjFQTOO7Bsf/P/bYDXTO0WOop
	lIVSeDjwv0pTFvMWZSKUj0bI8j7qYZFKmxy5h37qx6p25IbprpvMUR0sL3cQUAQCbx8+G48ogK+E5
	6P830BsVLJmb2Cc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRqf3-004a1w-Nb; Tue, 26 May 2026 14:13:29 +0200
Date: Tue, 26 May 2026 14:13:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: cedric.jehasse@luminex.be, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <910a2122-dcee-4a3a-ba97-c3d0e8409624@lunn.ch>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
 <nrymrthvic2co6g726qm2lb4hbsepjw3xmoh33eznmlumdcpb2@pwxvmsq5y67v>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nrymrthvic2co6g726qm2lb4hbsepjw3xmoh33eznmlumdcpb2@pwxvmsq5y67v>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[luminex.be,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291680-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 7CEAE5D55D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:26:10AM +0200, Marek Behún wrote:
> Num tx queues for all devices:
> 
> 88E6020		4
> 88E6071		4
> 88E6085		4
> 88E6095		4
> 88E6097		4
> 88E6123		4
> 88E6131		4
> 88E6141		4
> 88E6161		4
> 88E6165		4
> 88E6171		4
> 88E6172		4
> 88E6175		4
> 88E6176		4
> 88E6185		4
> 88E6190		8 from you
> 88E6190X	8 from you
> 88E6191		n/a can't find datasheet, does this even exist?

I'm not sure it does. The version of UMSD i have does not list it. If
it does exist, it will have 8 queues, given the family it belongs to.

	Andrew

