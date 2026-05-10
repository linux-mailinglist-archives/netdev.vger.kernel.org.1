Return-Path: <netdev+bounces-286347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAxpLOa6AGoAMAEAu9opvQ
	(envelope-from <netdev+bounces-286347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:05:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B0505473
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64B073001F8D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7703AEF24;
	Sun, 10 May 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCKSS2ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308073B2FFC
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432725; cv=none; b=De9WJwWNfT3nXajP1yAu1/w1DiF3LV9yjRTao3wklL3X791LOj0BUbdBpr5IGmhXbMNZMQ/bnsxANav4q2YaWyYbDkMHTmkGKf5eRAiLdSUgLbgg+NHsSwbJ4XuAo1C2cExJyQr59KwW5KJCGj3iBIfl7QTeOAvAaJVeuZeZd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432725; c=relaxed/simple;
	bh=njvUjJYapm4Evggff9XsbWKk1pd6mVJCB4SLimX+gPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4fRgzdAKaQzWVo2IjdVMUBxuo1giNXDGaXIrL2vPcu+vnF/I3nH7VKp05oRnngPXATMLj0I9HwvHkSpSJi4lX71hLr1qSdOE66AJEalze23kQtDJ3t/Ks+ffaHbu03k/SU+VME6CakLTYTlTDrrSsOS3CH0U2Vi6/ynMa2hc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCKSS2ss; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso2215322a91.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778432723; x=1779037523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt7DZxBgxaqgF3EaEv3GbAdygrDAfwMu6OaO3VKjDZM=;
        b=DCKSS2ssq6fExUr1i4GUtPTyD5DDOv3gAVHNaLOShmpx2cL8briDTWV+qvgv/0c4yl
         GPVKxkwT71oA8uJ2eBLNCHNsTUjNefcMZVvow2q5SB8VLq5LU90LCqvW02mTfFp1W6ha
         GT1yNdX6dLVubE0Aj9KzaClK9afbKYlgdmZuLsE9ItVKaWD6cmFaEncPhUuSJhMwx8Y9
         CW+Xvn6MWVlK/7sr/FzkrUoxzITcsVnwts6UNOxgD8xQ62ComAXn34WZZVc2poNLNAxT
         KaEVuNyH1sAAugF/H7EbGPUQXVXMHm4pr6Ka3P4jCZE+SwU7B06e3MaKqGYnppCE61Eo
         ikJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778432723; x=1779037523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt7DZxBgxaqgF3EaEv3GbAdygrDAfwMu6OaO3VKjDZM=;
        b=DPNZ3GAlIMGQgY+x0NIba/GL46PLi2iesr6ZAGHbgT31xfuIc9U78k3Sp9xembTWTi
         h59YMqzILqlF6/eZmr6h8RE8CS6kk52uXGQx3ADsP09hup0xXnGrO2F0MQqykAxOye1n
         WJNzGQYWJ1Mf7mJUcmvVMH+Ghe/GAf0GjiCJVMnLsX20ZMWKMjGMLBhlEVERabzeUcxB
         WmGmZ/UaJ9zeEtZW1WCcKaSJen4W1DHQ2UKItnf/6U5XqZeDYYd8L2kKBmO2XhIlJ5IO
         muqINNpdn8ex8Gp1g7QYhFyqzZiIvoKnteKfjBe4fzIXNJrTg6ndhFArMn+ZhBJlSuHz
         waAg==
X-Forwarded-Encrypted: i=1; AFNElJ+zu1QRnrEBYl8jaDTku54rKsuNjmXxX000kL+cxjAsY9Zn2b+S1qG3q9Is/DugXvqE8p8cyao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxebVYgZtqIPVMjdt6nc6Z75+0WCyrLNsqRhwaISJzMmRz56pRB
	qSiaDVAAqgg6mU1JjXEBkprQa51GsU0TVqYB2WwnDco/KpKz1/eTDu5p
X-Gm-Gg: Acq92OFMjtrfyGdr5VQuh3jLlVHy62aV21l+9rjvwtga7LuoS8N5+BRlKwdBvyLqg8v
	GZ3ZzqrxpmI4XDT+sD/b3RU1cA0HeQcE5qDTwdxdRQiyj1MRVnpIP2Net8EveqMEiIR8ZFtLUPg
	3BHVWwNPIzN692tUNAAFtZF4crlOxjlPA/ow6fgtZjEAOSgB/7SIXitEYa0HCAwQY6a+XSMcvUy
	E083bgCAKgun26jHBuaFDXjEy1JVlwcl/B2vmgMp0HFRVlDiPZ4+eU+Hi+ku8/zZPyn00RsDdkz
	F48uNZ4FQVJEZCm2HoWcymtWY9Mjt6gztpEVyLZLYa11mXyCnS2ZWOzABw8wgBpK+HxFcRrbM1C
	c6kPuulyjAbiW46Z1uNOKP04xHHA5MqoyRzlkSIm7YYMxiW4RUfH6KoApyxHRfINOdVSTVJ8JjI
	44JS2qTEeh3DDEcjY3PLN8oR97P4mS9enQu89iuBOPiw0O3rk53YuFwQ==
X-Received: by 2002:a17:90b:3bc8:b0:35f:b3fe:18dc with SMTP id 98e67ed59e1d1-365ac47ab2fmr21925302a91.19.1778432723423;
        Sun, 10 May 2026 10:05:23 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d625f126sm5653554a91.3.2026.05.10.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:05:23 -0700 (PDT)
Date: Mon, 11 May 2026 02:05:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <agC6z1FeEN6jMjyk@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
 <20260510084520.476745b5@kernel.org>
 <agC256wVYa4Gnvy1@v4bel>
 <20260510100310.230b15ed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510100310.230b15ed@kernel.org>
X-Rspamd-Queue-Id: AE0B0505473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286347-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:03:10AM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:
> > On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
> > > On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:  
> > > >  			    sp->hdr.securityIndex != 0 &&
> > > > -			    skb_cloned(skb)) {
> > > > +			    (skb_cloned(skb) ||
> > > > +			     skb_has_frag_list(skb) ||
> > > > +			     skb_has_shared_frag(skb))) {  
> > > 
> > > We seem to be getting a lot of fixes for this issue, and this one is
> > > incorrect :| Writing to _any_ frags is incorrect. You have to copy
> > > if skb is not linear. skb_ensure_writable()  
> > 
> > I was testing a patch based on skb_ensure_writable() but it seems v3
> > has just been merged to mainline...
> > 
> > What would be the best way to proceed?
> 
> Depends on the tree. Where was it merged?

That's the torvalds tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71

