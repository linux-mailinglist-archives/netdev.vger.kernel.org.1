Return-Path: <netdev+bounces-287706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEk0MDXFBGqbNwIAu9opvQ
	(envelope-from <netdev+bounces-287706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:38:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8577F53917D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A476310C5B7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C93A48F0;
	Wed, 13 May 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp4pp6uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170334F24A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697057; cv=none; b=eZHak5ZegzaxfFCdkSGtCUAuHxnNxg0KiVOS8GB0Qi7/6Wd0cTLuIjRIKddfmSNMMVDxnRg5H+U5xG+g2PR1S0Vzfxj+LrsIhZc9Fh85y0u0byJuDYnykIxeNYNi+wJ/bmkU9l7c4e+8mv3Qj5C06Q5y/NAGPqFckyVdUGPPjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697057; c=relaxed/simple;
	bh=MM5n0eINXFRMBIyPEWK0pUG2mSn+T2VQWZTmKU1E1aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp2QPPxQHuE6gvWGsHjocBBZELjV52WR1ZcWmChqHozIzbIYimdhpuCyY7xM7mybP3oOonsMczv6jaeemtOfN3eQUV0mhp2a3wQNSyJDDhWyB5idS1qDmyOYxc1zjFa3DT/VzbegOpK5k1/wltFGkVWr7laWj+cfKslA8cM2/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp4pp6uq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3680540a6efso2893446a91.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778697056; x=1779301856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7yINQxL1u4J/CFwyU7LnHzU+2n2gvC+s1F5nvo1dTc=;
        b=Cp4pp6uqjIaw++c9eYJpUakd4egCR6CtX+vkqCENFjUv8dXvHqUGirtAC0DrhYqOSX
         jujGEVaR32zCVDdBlArCKbH4Zxj5t+GlJlyKn6g8PY1ML/fXD1yzKJdlBpdp7sJA6eEa
         ZB80tV5OwzEqJ37jghATCv+sSTBL8xxAgT9yk2avBNuoeI6N2yinY5yZMr9aMbnU8i9x
         7TQksguJxCbpK/e7i5qYZ2hmEdRDpSkho958hYeU/vQDxIIcWHmOtq7U850PMNf0uQco
         40saMTgSOs2/0DS27FmKsW4NVIznA/8jLvHTJ+eVwCNMZ0p5pL6CMw9olNfCOJjDVdTX
         Picw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697056; x=1779301856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7yINQxL1u4J/CFwyU7LnHzU+2n2gvC+s1F5nvo1dTc=;
        b=dB4amU7IEXRRJK3eQ15OGORG+zO5fJOSJoIjEHCwoES5iokEKXsAimlEmBmWkL4gDE
         /x1fS5yj0uAk1ylrNaIrMoSSxHyg/VjhjvkkKVdQyOc1NLIVnS8AxpxCCThvFuFMs//f
         hvQunMMhafSphVQu4BhXt+nKhoBXfbrTbZ8924m5BJRITMHoYkDi9R9vbZsE2HpnQ8vS
         hFsKRrq9roDh5yppVCMc/NYQIyMPvJjz4Yvt0yOBfBrgdglpMEyXkRmC9GYfcTuScmsP
         w383xHJf7JKsP/OjOi04ju3UxTfUQWTAn4295ilcEOnkwSE0eTEmjbAqe5F1lDZsSttM
         qsRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yfMbVYzFLlzzRfUVjfCLvC12+5kK/RVMVYFZkf6zgBZMuCeo2v5CoVytxhtRGNbBjpy1VchQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGmIrXB7FZofRQXQpOYk5Y1wdE35v71VxI7qtwnMlH6fUOuGB
	nLe+AcbHmLaS7/iYh1ufdC41CBZBCkwuyfjRXMny5DxRnQ/bKrblZnaE
X-Gm-Gg: Acq92OEhSzf9ot7wfwZygVUZadshVKK48oeJqeOKroH8ZFuIaahQpIKdNEXkV06t/DF
	eAay3GhMlL+OEvjuH+wtluqU04g6ifI1YxXjgVDgd4ZRWcMuoeRd4GFPO7BxB3Nyy17CctvepP5
	wVT49QKbxfEtfBKj9pU+jSwvb95aYIUpUIrxiBPUSuRE7EmRL+YzJKxIMQ4sb1Lt3LjwKDOUfUX
	4PyAvKuZYLeTOP1AfGHfXGQgueGUxiq8yykZHrHLdxs0DdCA9L54Dlpimq5Nmbz3nMKGVG0+/kX
	mpoWWUtuIbLR7GINiNmy3Ktsw4nNJTMlhJ/jdw8PpoPkmNMDYIk8eIBT3kQQ3ocQseZVJZBR+V1
	98ni8ApizwkeLXe+mQsCx4XigcCVW/yYgC4Xifgrbv4F9oooxZ/SZkDsVhM0d7QTXc+Vlu47INm
	nrtYLnCRX7NmnzEJ4OqW4klH3SoARf4TPeP0yW868hsmA=
X-Received: by 2002:a17:90b:3cc5:b0:368:763a:17b8 with SMTP id 98e67ed59e1d1-368f77f69a4mr4388675a91.2.1778697055604;
        Wed, 13 May 2026 11:30:55 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf4d940sm3564241a91.7.2026.05.13.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:30:55 -0700 (PDT)
Date: Thu, 14 May 2026 03:30:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, vakzz@zellic.io,
	stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
Message-ID: <agTDW-mJqKCSEE17@v4bel>
References: <agRfuVOeMI5pbHhY@v4bel>
 <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
 <agSx78pXBFCdn08p@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agSx78pXBFCdn08p@v4bel>
X-Rspamd-Queue-Id: 8577F53917D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287706-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,zellic.io,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 02:16:31AM +0900, Hyunwoo Kim wrote:
> On Wed, May 13, 2026 at 06:21:45PM +0200, Ben Hutchings wrote:
> > On Wed, 2026-05-13 at 20:25 +0900, Hyunwoo Kim wrote:
> > > __pskb_copy_fclone() shallow-copies the source's frag descriptors and
> > > bumps each page's refcount via skb_frag_ref(), then defers the rest
> > > of the shinfo metadata to skb_copy_header().  That helper only carries
> > > over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
> > > the destination skb keeps a reference to the same externally-owned or
> > > page-cache-backed pages while reporting skb_has_shared_frag() as
> > > false.
> > >
> > > The mismatch is harmful in any in-place writer that uses
> > > skb_has_shared_frag() to decide whether shared pages must be detoured
> > > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > > skb in esp_input() with the marker stripped, letting an unprivileged
> > > user write into the page cache of a root-owned read-only file via
> > > authencesn-ESN stray writes.
> > > 
> > > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > > share skb_copy_header() too but linearize all paged data into freshly
> > > allocated head storage and emerge with nr_frags == 0, so
> > > skb_has_shared_frag() returns false on its own; they need no change.
> > 
> > What about skb_shift()?  It seems like that should also propagate this
> > flag.  But I could be missing some reason why it's not necessary.
> 
> Yes, since skb_shift() is also a function that moves frag descriptors, 
> I think SHARED_FRAG should be propagated as well. The actual trigger 
> conditions are tricky (not deterministic) due to TCP write-queue skb 
> merging, but I believe the fix is the right thing to do. 
> 
> I'm planning to submit a v2 patch. What do you think?

And skb_gro_receive() also appears to need work. Further testing is 
in progress...

> 
> 
> Best regards,
> Hyunwoo Kim

