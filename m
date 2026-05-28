Return-Path: <netdev+bounces-292725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP9/LORSGGqwiwgAu9opvQ
	(envelope-from <netdev+bounces-292725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:36:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538835F3C7C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF4B73035E68
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C103B6C0A;
	Thu, 28 May 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Kg0VCHM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179892E5B29;
	Thu, 28 May 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978850; cv=none; b=W7kYEqEIRG8RuwSfIV7Ni1T5MKfiF6ZWGuey3LJHvbCEMIazfW1I/p1PloRpWR5bjSywxfHFQmx5KTUk4k76NksaU0PT4m0/JuyHxn85W1CusqYxchT5Oylf7vog/uKOGk/eH8C7r6TAot5LMI4WbXS4GNHu9CPm7dehVilsr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978850; c=relaxed/simple;
	bh=vN9YvOIRYVymQcGwoIANG51IQqZh9wFIR8SsEv4Z1Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky8LEeVYuKnk9OKmjmFGLsojFRy2kEfFRw6YGmVbScEnwOPtNvcmih+fgM5FihokSvYgg9HfSET19ZFZ8QBmAstvZfaFiAyM6s/RRaedbZAVnCM24pfEdWG81YYcdge05nRIUfhG8tcvCqagSeCXD+xyHKUxVNLWn5Pc13bU1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6Kg0VCHM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5W4/4URtIQxALeEsJRz4EUTYEyNh1fhpXB+fqY+dyYM=; b=6Kg0VCHMtvNMBIVserk6JqN0JY
	o8siIFZ/yyT+c7Ax6T8UeFVxAA1BFGFS3FK6UACjh+xiGUjuqEopEquN1f2UXXnuIvld6hbEbNt2w
	VRHhWa5JA/7vLVURIzn5AQPqoxA6S8/FF+OKI8f7a86doTw1WY5jEVms3BxLvvqHCC+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSboA-004uXK-Pd; Thu, 28 May 2026 16:34:02 +0200
Date: Thu, 28 May 2026 16:34:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Gibson <david@gibson.dropbear.id.au>, ihuguet@redhat.com,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <178a1a95-65bd-475b-a035-c4ebdc5ec325@lunn.ch>
References: <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org>
 <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528153202.14900687@elisabeth>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-292725-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 538835F3C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Actually, an eventually fixed version of NetworkManager doesn't need to
> know the behaviour of the kernel: it can just order addresses by
> timestamps instead, as Fernando mentioned.

Can pasta also use this scheme to order the addresses? Is there a way
pasta can be independent of the order?

Maybe we should just make the order random, so equally breaking
everybody, and pushing user space to not assume any order :-)

	Andrew

