Return-Path: <netdev+bounces-286937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJz+G66nAmpSvQEAu9opvQ
	(envelope-from <netdev+bounces-286937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:08:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F310851977F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132873014C27
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C02D7814;
	Tue, 12 May 2026 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="T33C+TeP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CB383328;
	Tue, 12 May 2026 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558887; cv=none; b=dJM93apARNdj1d3eyP1acoUMV/CRie5VbSrz2Qy+QfIYZBZUTUbIllUITyGi2VpGWQ2fLoXjsaUIPcRFXPJ1ie9J6b0I02/PzHLdBrc08+uWWkEAo1f4MhKM6nGbxVkWnY9yrcmBZ1KNeS+4Fz9+w/rCWaZopi0jPhgi1zHH4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558887; c=relaxed/simple;
	bh=Ofnxgb3ZkYisGIafeUb6xiktQaSDnjEGx/Gk/1v47To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7HbA1qtEo1uR6C8yATfW8gnTRnVu0vR9DSX3D1Wra5VwzKxvcwHv+8uDiZXU8a47+K7kGHYeRDvGCZBX8fBAcZewl45ivExAG+YMJzK56gG19bhpYHcX9ImGqZ5mBTOe8bTNrgU4Kj+5IK8ujJC1VfAPmg3rqoHh88BxD3s4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=T33C+TeP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1778558877;
	bh=Ofnxgb3ZkYisGIafeUb6xiktQaSDnjEGx/Gk/1v47To=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T33C+TePBPWSqhcbe2bLdceXbubUI2UT/9DzjOQTkfRSrqvRkTePN7+v/hP3GF2cd
	 aHhhym0XTwbToVeXxm8lrSO+VKvYmkAdKnTWqRterf5HoPHRbBBlTSeZIWWPZGrD8I
	 DO1dlNlbILmSOH4VYsKR/SiMch0t6CykzTFSFUtvbfgJdk7bx86PVi9bIb7t1dUafi
	 pOMqinJjWNFtTKmAkWMqb2yd3DHQXpN9hNeW6MxC2NYOF91+dSTOu4T3XJkWLoAAK9
	 mgAKXknSYOUkWcuW0U2XD/mQCDQwMfDU4xqjfX1CKEutyzk+0qzOJE1ftn0cr77uuV
	 9VzyWvjkDPGIQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A71F86008B;
	Tue, 12 May 2026 12:07:55 +0800 (AWST)
Message-ID: <71b7c8f40efc25fadb0aede6be888986364f2d53.camel@codeconstruct.com.au>
Subject: Re: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young	
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Huisong Li <lihuisong@huawei.com>
Date: Tue, 12 May 2026 12:07:55 +0800
In-Reply-To: <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
References: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
	 <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
	 <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: F310851977F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286937-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,checkstyle.sh:url,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Action: no action

Hi Adam,

> Sorry, I should have been more explicit here.=C2=A0 I am not certain what=
 is=20
> going to happen with fragmentation, so I want to be protected against
> future changes.

Nothing is going to happen with fragmentation. Your driver will only see
linear skbs in the ndo_start_xmit callback.

Adding the skb_linearize() there is unnecessary, and creates ambiguity
about the structure of the skbs that we're dealing with in that path.

> The check in validate_xmit_skb() is good, as it protects against the=20
> current set up. So my option was to put a comment in here and hope both=
=20
> changes happened together, or to just try and get this portion of the
> driver solid against the change.

I'm not clear on what changes you're referring to here?

> And I thought that was what you were suggesting in the comment. The=20
> original comment sounded more like an "here is an optimization" instead=
=20
> of "this is important enough to kick back"

It's less of an optimisation, and more removing something that is
unneeded, and potentially confusing ("why is the driver doing this?")?

> As for spacing, I get that there is a style, but it really should be=20
> encoded in checkstyle.sh or something and automated.=C2=A0 My own tendenc=
y is=20
> to put way too many spaces in to chunk things together, and I end up=20
> going over-draconian on stripping them out to try and meet the expected=
=20
> layout.

I'm not too fussed about the style at the level you have here, these are
suggestions to clean up if you're already re-rolling. My confusion is
that you had applied my feedback to one part of the code, but not to the
area I had commented on (which has the same style structure).

You also had some sashiko feedback on v40. I'm not sure whether all
items are relevant (I *think* you're OK for the first, for example), but
worth confirming:

https://sashiko.dev/#/patchset/20260508032953.337036-1-admiyo%40os.ampereco=
mputing.com

Cheers,


Jeremy

