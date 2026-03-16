Return-Path: <netdev+bounces-267992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKQ8LclWt2lsQAEAu9opvQ
	(envelope-from <netdev+bounces-267992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:03:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA02933AF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0698D300599B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777B2264D9;
	Mon, 16 Mar 2026 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ78TELj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20F263C9F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622935; cv=none; b=PsiC4DC30aflR01ZKBHqkfrluCmFq5rEhsjf2Dibm6QwYybWp0R+/euveHv89VeWW55aFvIgnp4LX5ID1K97TshYTYM2npWMOsH7A7j9166kOKdxfc+WdCed7dNV4Xx3HbA/JPpwthZrcrnLYkNAqg5YpMmB7l4aLa2BGvWl0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622935; c=relaxed/simple;
	bh=Eky1nMoAs0udEY/YyYt5887/RWDwMv3LBHaMdNwTh0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek5Q5e5OHHtKUrTtbODsKDMpayGcdMgQs467hIaw8fuFQL8AGh5DNy2Uxu6cHXodo0QXeFL/NPs2QAOuGDFMyLBesEkinqJkl64Xu0jFS4LnBX/av3RgoyM9nYG4pgE1Ao9YxOANDryrDdbZOLvYhgq9LInm4h/HExDta/D0mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ78TELj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1507583a12.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773622931; x=1774227731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLOS+CBHAqth4oLgPzOQhkefjgoFRG3KFqew2fphAF8=;
        b=jQ78TELjF288JW/RtJknI1X8/y8fKQhIGJuJe04ZvBM0ZudTwE/OWs46b5ptm2ipdC
         SOE+sjsMRK+BAzgaSzulO0/SZ98eMwJbT9dlJ+OQh46UbzNiBFIqM0UmzLJwAcYzuI25
         /STGqVeQlSJhC3ZaUb7HmvV9xEWft94Y9mO7gZax2I2KCZOiijhgyJC88kBQ5283/f+q
         f2bmNPS5JspfMtpdf8Q0ikrluxykkZsZ9byg07DvE0GKQBk/paXe9BmAFYm3JXA8c807
         Nps/aUqrBy39tGdlur3D3etiIukfd+9RhR+QnTA014vfxcbLwQD3hlFYpHoMeHH+zarS
         PGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622931; x=1774227731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLOS+CBHAqth4oLgPzOQhkefjgoFRG3KFqew2fphAF8=;
        b=N4/6AmIw0oRPggj9IgOjwp8LO587Bir4MW7GS03A9uhOXVQLRwQ6Iqop8mMZ/9Cquw
         8erzYsV3DyVgj4zDZXiF4wRM1lzw3zDWecSd4NjxZZ/1rHMeHWHxMuwWzFlL65xR97ra
         ExENVyjKmUzmxHqFL+RDIVDIDOfwcLs1x4Btr9xWOgHMKCHdq7gDu5FTxLRqfPI02LXa
         Z6O3yt14XosdKLhmyp3s2U21ckWBL2KMvnZ858NHjmfc4jMsPWmEvjelCxlB2lZK4ksd
         spQy2g6ji9Hj3QNNtgVMNKrdSVEGkvUgtaZ0OfVovAIkiWqjBUueptZfv12mKZaekkZR
         1X0g==
X-Forwarded-Encrypted: i=1; AJvYcCW92buqp+LAt5EMHHSQMsNok+Qw2y9VMI9UJ7XW1tUcz2R9FhDdg/Z+eDQik+4UdS7M7GZ485Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJz1LjYpL6wpR1Agzt1vWtgOZRd2/+veNFKZMB4XbvGIF5au8
	2PXq0h7arb7QLQKnscBhZfiNSDpP0dfjwbHbIoFnBE04CuIDjgQ9UgOa
X-Gm-Gg: ATEYQzzW2zsvhVpdO6n9nD2Y8Fn24/3Wo2lg+Gc51ER4FVzJPTHmJsawess46o+No+E
	gDbvlQBRiR3eQifCYb7rgabXN9tbgHPVaTCrCxlEPZt5A/AsBQ1OXoG3Ve/CE4tBnmx6auquRhJ
	oOIAcz/ANY9VNe7okHPZL+Jt2HUPPfWFZG//3qTn0hSUmIrpMc/155hjPwnkxE9ziBcSqWs/H6l
	QAxXbXS9ejAOucGCzV/KR8F1c0B/S+oGRUVP9Ff6ZREG22AZ4MpATnY8zHqmySh+wPOxx4R2M6X
	CjmlAs/AP5Tdb9MTBPUWbr1cLz+TZaOTSLb2hDy5vES2pj+w9NNfgxtlBWP4CgvDKoZR0GSjsIb
	1pOtHoAGYb9io3iSkOtmhYWFE3mUM/DHCsH936vXOjfSfWaHq9NQRZZSEvmqnrQPOqi9WxET14c
	I9Zs3KeL+Xm/0CCCWcZKope1zwtE291sDrD/gcGQ==
X-Received: by 2002:a05:6300:6713:b0:35d:6b4e:91f1 with SMTP id adf61e73a8af0-398ecca4e41mr10054657637.34.1773622931501;
        Sun, 15 Mar 2026 18:02:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74029fa6eesm1891891a12.20.2026.03.15.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:02:10 -0700 (PDT)
Date: Mon, 16 Mar 2026 01:02:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, sd@queasysnail.net, andrew+netdev@lunn.ch,
	pabeni@redhat.com, sridhar.samudrala@intel.com, jiri@resnulli.us,
	bridge@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	razor@blackwall.org, idosch@nvidia.com
Subject: Re: [net-next,v2,1/4] net: use ndo_set_features to set offload
 features for bonding/bridge/team
Message-ID: <abdWiYhu4IOldqtE@fedora>
References: <20260313-offload_compute-v2-1-ffbc8ce5d50c@gmail.com>
 <20260315161943.1419237-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315161943.1419237-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267992-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95DA02933AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 04:19:43PM +0000, Simon Horman wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f48dc299e4b2..16b3fc620807 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -8920,6 +8920,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
> >  	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
> >  				    priv);
> >
> > +	/* re-compute all features after adding link */
> > +	netdev_change_features(upper_dev);
> > +
> >  	return 0;
> >
> >  rollback:
> 
> Can the feature computation skip updating ancillary fields when features
> don't change?
> 
> The new architecture routes computation through netdev_change_features() ->
> __netdev_update_features() -> ndo_set_features(). However,
> __netdev_update_features() has this check:
> 
> net/core/dev.c:__netdev_update_features() {
>     ...
>     if (dev->features == features)
>         goto sync_lower;
> 

Ah, yes. In the RFC patch set[1], I wanted to use a new ndo_update_offloads
callback to handle offload updates. But in the formal patch, I thought we
could avoid introducing a new callback and use ndo_set_features directly.
However, it looks like we need to fall back to ndo_update_offloads now.

[1] https://lore.kernel.org/netdev/20260226114208.27774-1-liuhangbin@gmail.com/

Thanks
Hangbin

