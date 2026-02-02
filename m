Return-Path: <netdev+bounces-255862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMFqEYCfgGl2/wIAu9opvQ
	(envelope-from <netdev+bounces-255862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:58:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46DCC897
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A434E300AB05
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62495364037;
	Mon,  2 Feb 2026 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xwznYkPw"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9861367;
	Mon,  2 Feb 2026 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037117; cv=none; b=BQpAacDkye5+V1+tB5G/YF0krm5hfhEXUxXEgigauAssnacPAakELqbev1XaQZpZSBmutDsHkvSE7qkfP8VD9IFSH8Cw+JbBkPW9q5j43evXNxP4vR9jG8VgsMjyG8iVurD/EedoeZXlUz71yQgbiUwYm+vbF1L1Gw9/Dgry56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037117; c=relaxed/simple;
	bh=EQYgeFMRnAra6VD3mRXRAYPSuobvY0vgyn4p7L6o7Wk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8pK65+IqgBThzyiOpqy3NHf3eyXiRjcsZKMngXqqThFRI1uIHtzNo6sn9/VYC/33CQbMGemcpBOZB6g7RcZ61r3C6/M4vAoIqZzUATcQQfI9gD1Lk6uAuv+uR6dW9OSx9PVBCP3YDcRWWasr22YRq2ld2+fvzq/pPyREMwoKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xwznYkPw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CEDE0207B2;
	Mon,  2 Feb 2026 13:58:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgW3CbLfYYHm; Mon,  2 Feb 2026 13:58:31 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4210520704;
	Mon,  2 Feb 2026 13:58:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4210520704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770037111;
	bh=j1sWmd7dduqlWa8sGRzIIEoYszWoZKE2Z6bA0k5T654=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=xwznYkPwCLpxFORZf5xNq5lQM/IUxJMsFYsFeeJzJOP2PLikoBzJN9og2IqLQsH/e
	 H5MVyTkBfnBO8BK9s64dAr82GWLdYxpkol7QZI8BB+B9SU189pbvy+x+9WeMMDh8kP
	 ToA2N+xEqe6MGA4kowBp93YQl8bsikcvQaUsiwt9piXMridzvvTrw54N4DKOhYxPDm
	 BkqwjmoS+1+l/r3cch0Z4xwHab55AIil2Ixdh9Aj1SZWMglVnnVw6j4j28SJ7eaDvk
	 a6mbYeSUz2QKXHG9dXIStx2sSTtJ79RnjlZtIKlazMjCBfgXW188fSU6KWBqCEfoTm
	 JGBy1fZ9qtl3Q==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 13:58:30 +0100
Date: Mon, 2 Feb 2026 13:57:56 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v5 3/8] xfrm: allow migration from UDP
 encapsulated to non-encapsulated ESP
Message-ID: <aYCfVAeKGqF7MIRq@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
 <aXyV028imsUPWSyq@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXyV028imsUPWSyq@krikkit>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255862-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CC46DCC897
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:28:19 +0100, Sabrina Dubroca wrote:
> 2026-01-27, 11:42:40 +0100, Antony Antony wrote:
> > The current code prevents migrating an SA from UDP encapsulation to
> > plain ESP. This is needed when moving from a NATed path to a non-NATed
> > one, for example when switching from IPv4+NAT to IPv6.
> > 
> > Only copy the existing encapsulation during migration if the encap
> > attribute is explicitly provided.
> 
> Are we sure nobody out there relies on this behavior (silently copying
> the existing UDP encap without having to explicitly request it in the
> MIGRATE request)? If there are, this patch would break their setup by
> clearing the encap that they expect to still be present.

Libreswan and Android are the main users of migrate method. Libreswan sets the
value in every call. I am guessing Android does that too.

Yan, would this patch cause regression in Android?

Without this fix migrating from v4 nat to v6 and no v4 nat won't  work.

Also the ENCAP migrate with UDP port was broken before, 2017,
the commit 4ab47d47af20 ("xfrm: extend MIGRATE with UDP encapsulation port") ?
So likely it was never used by older code and PF_KEY.

For the new methed strongSwan wants to support migrating from UDP encap
to no UDP encap.

regards
-antony

PS : Steffen advised not to Fixes tag.

