Return-Path: <netdev+bounces-278866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H/lOjDv32kCagAAu9opvQ
	(envelope-from <netdev+bounces-278866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A8407887
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D663090879
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F4351C39;
	Wed, 15 Apr 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAzV9Qyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703224336D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283437; cv=none; b=i9+TGabIeYAkH5pJzPpxHoJswHVBS+0l9ywnCRABhTp2cJGxORKCMeEVIliR4Dgx9hX7b7irjCwyKtWDl/pqvtzhS9RbDZG4Xb8o4uYOYDqZRTNNXQtaTvjlDHO3EawQYLZCggVo/emSnbiwysrhYYE8LrTxvVPNA+kNViTrq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283437; c=relaxed/simple;
	bh=KQenSS06UI0vM7XFdK2qzRJBRz0Xq3xF5U0opsvFN30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQgukLkEVMzaP94xVuDPzNCh5ZAnAy5G/g6ySksmFVLyAYM/P1NIdPKDr9d9rXxOiwpK+d9VNb5EaLKe/z4jdpvRnCjxX2VjvpbzOFYD/93bzBUAqKqMZhu8+RQ8APTM+JZ0mDeUPAXbsxM7tMJSeshC/Qq7cNl7TIWF5n5F0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAzV9Qyb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f4c3619b0so1547560b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776283435; x=1776888235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlMENzfakNiPO7LM+FY1mYrQXCXRqFwcNBlDbO4HDZQ=;
        b=nAzV9Qyb9c3psraV1WCa/vYicZ3WgyLeKgKKDLUt5SawXxe0IWN1PpQ5es02D7HTB1
         EICBiTfY599S9tiV7NFta2TSmxPWqI9xFvBj8aTkUlGWtdPM1u+QiJ6tWQbXp5RJUPQU
         ImibjSDhslQhtNVQn2HKjDhIiTUgqVjD6HqWvwPN8DBHS31wCjyM41eTmKcp3Ctf7/jT
         g67k9Ri/XavzmSwAwePNHVvRFCxQdbdn3KT6U5EjSS2dcpbmDv2H7G96QPcRnTXd7kmu
         J3u1kzNakBiksYchuwhiGwikVCbco++hwlu77IxS43EJTzfVn2Q8HvaJJ2dQkGtErDEZ
         XTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283435; x=1776888235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlMENzfakNiPO7LM+FY1mYrQXCXRqFwcNBlDbO4HDZQ=;
        b=gWQa6xqYWTl2QD4vpMa3pSl/CQ4msoxqDl06uk43sJlwOrCLfmbK7Tm+bT205um5jR
         vRJFuAgSmeDDfbbAy3Kgi9CDwi191W4WM+/BZuL7Ikn7RWuZLAGZBXqFEVI7EMe2R+sX
         zPfyr6m5WRAoo1ByRNl5YhaDUUxmqSM7boKxccUScutD6yPPU5grLbeg/uhv7HdcobJC
         R8eRPuZhcjAaWlcmr/J/vHVpVJ2KUgIvpD8QaXBaDXb3AG8oOMtC4RII7lAX1yOlAEfZ
         H3j73B5vA/ZI9taXfcgN4KGaUiF939AC3bIOavo5OtEcQF6uJNUc4xOczUpZSCZ1ejYt
         cvNw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZVrAP9idBnNtjKbc9axN6GrKfqU+2h8AAknkJqkUXA3CY0eUAtHfxB7O7JokK1Z/393ra6FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oTju4SI5Neaf4NkfWXMKc9S4OcLR+ZfDXKTmGbsXuBqxzkfS
	GAYbgFWr4Gdqlkp557KlLTWqFESudO7lSXM6EEMUTIozLpNbGvrR04CS
X-Gm-Gg: AeBDiesg3dMvOF9tdiiyzXe0f1zaa+GB4VHr+kD+SowV4KPYMjeAL6lvRbNndW4/rcI
	L2+/R/Ay5mJmVrjXQzrZ2d9N8msgF+C4uzBcOqNX3nBT6+FQIMR9h8+9sumzoNIUZG3+o+vsbO0
	k3kvsoSIL0wE3kkRWVInuLz049x8DA9ZFYLBoGcsFo0nGcpGliNz2XXL2k7lsrjEx0NEr+Vq1bl
	Si32vHJaOOzSWyM904zaEdF7un5IevCml53Ml76z/uPkmSuiGaa4A58537VM7I8C8Nkbs+GRt8a
	tGGHAlj+cYSJjweJQT1mcQ/6VysV8agrJmAXeRWrg1s1nE9ZbRHeJoBm9fDN83IYLLsEbzZ6eWR
	dAZMQGD7bmQlIog+qmmQg68YlGQZrPRDZGI9DV0sy+BL9gh0j7W5xWfeIshBnv//JomYZ13rekO
	s0dsnDnezs9WVOwyY5vfOPaYIMNeRrukERXSqg0BXvfbNOUIDp/G2s6Sjo8mbj
X-Received: by 2002:aa7:9a84:0:b0:82c:8c6a:682b with SMTP id d2e1a72fcca58-82f0c169cb8mr22947916b3a.19.1776283435414;
        Wed, 15 Apr 2026 13:03:55 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6707b717sm2668877b3a.21.2026.04.15.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:03:54 -0700 (PDT)
Date: Thu, 16 Apr 2026 04:03:50 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
	netdev@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] slip: reject VJ frames when no receive slots are
 allocated
Message-ID: <ad_vJpYqp1gX1PTc@SLSGDTSWING002>
References: <20260412154252.2060940-2-bestswngs@gmail.com>
 <20260414134126.758795-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414134126.758795-2-horms@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278866-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 513A8407887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-14 14:41, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> slip: reject VJ frames when no receive slots are allocated
> 
> This commit prevents a null pointer dereference by adding checks for
> a NULL comp->rstate in slhc_uncompress() and slhc_remember(). It ensures
> frames are rejected when no receive slots are allocated.
> 
> > diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
> > index e3c785da3eef3..e67052bcab57b 100644
> > --- a/drivers/net/slip/slhc.c
> > +++ b/drivers/net/slip/slhc.c
> > @@ -502,6 +502,10 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
> >  
> >  	/* We've got a compressed packet; read the change byte */
> >  	comp->sls_i_compressed++;
> > +	if (!comp->rstate) {
> > +		comp->sls_i_error++;
> > +		return 0;
> > +	}
> 
> While reviewing this code, a few pre-existing issues were noticed in and
> around slhc_uncompress().
> 
> Can slhc_uncompress() cause a heap buffer overflow?
> 
> It expands compressed packets by prepending reconstructed IP and TCP
> headers, which can total up to 120 bytes if options are maximized. The
> caller in slip.c assumes a maximum expansion of 80 bytes:
> 
>     if (count + 80 > sl->buffsize)
> 
> If a compressed packet is sized at sl->buffsize - 80, slhc_uncompress()
> shifts the payload and copies the 120-byte headers, writing up to 37 bytes
> past the dynamically allocated sl->rbuff chunk. Does this corrupt memory?
> 
> Also, does the decode() function read variable-length deltas without
> bounds checking against the packet length isize?
> 
> A malformed packet with multiple change flags set could cause decode()
> to read up to 15 bytes past the end of the packet data. Because the packet
> buffer sl->rbuff is allocated via kmalloc without zero-initialization,
> could this read uninitialized kernel heap memory and inject it into the
> reconstructed TCP/IP headers, leaking it back to the network?
> 
> Finally, do slhc_compress() and slhc_uncompress() read and write the
> 16-bit TCP checksum using direct pointer casts?
> 
> drivers/net/slip/slhc.c:slhc_uncompress() {
>     ...
>     thp->check = *(__sum16 *)cp;
>     ...
> }
> 
> Since the compressed header varies dynamically in size, the cp pointer
> frequently lands on odd byte boundaries. On architectures with strict
> alignment requirements, could this direct dereference trigger an alignment
> fault and kernel panic? Should the code use get_unaligned() and
> put_unaligned() instead?
> 
> [ ... ]
> 
> > @@ -651,8 +655,9 @@ slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
> >  
> >  	/* The packet is shorter than a legal IP header.
> >  	 * Also make sure isize is positive.
> > +	 * Reject if no receive slots are configured (rstate is NULL).
> >  	 */
> > -	if (isize < (int)sizeof(struct iphdr)) {
> > +	if (!comp->rstate || isize < (int)sizeof(struct iphdr)) {
> >  runt:
> >  		comp->sls_i_runt++;
> >  		return slhc_toss(comp);
> 
> When dropping a packet due to a lack of configured receive slots
> (rslots == 0), should this increment comp->sls_i_error instead of
> comp->sls_i_runt?
> 
> Dropping a packet because rstate is missing is an internal configuration
> state, not a runt packet.

Thanks, Simon. I will send v2 patch.

I also reproduced the three pre-existing issues you pointed out
(one via KASAN, the other two under GDB) and will send patches for
them separately.

Best regards,
Weiming Shi

