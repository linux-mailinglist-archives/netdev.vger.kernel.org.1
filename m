Return-Path: <netdev+bounces-254827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP2UEkV3e2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F376B1486
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C78300876E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188424EF8C;
	Thu, 29 Jan 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmwlq1ro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FD1E32CF
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699104; cv=none; b=h4mJTOtWtVu2zG/xOkaFAeWYh4yg4GsXZ5zXDBQTwcZ/aDxvjAJCghrG0SfQkEGMqLDSRLTLTxw4FjLQSRdIaN2KLECI0wFOW9PQ9+NOGjvUJ/48JH/VBCrKzC8GiugrxShkWA8rJN5+SCy6KZFdzfwdn4zFOR8n6fNHTP1t5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699104; c=relaxed/simple;
	bh=BA9h5eTaVv02q5LhPZwkeyd1jYqZDKcBpHdhtzcAb+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG6B34Z88n4ZiDkhMx7TY4iiQlYZD6WhmCeABbHhjUofrINSJN0ElBA+XsXU5Z/fCnURHBJqXr+MUNhL05dKpYbQ8bowFbNLjjN58MamdNzvKq4+/5mdhBBYGSxrYRYJN6/jwsOY45o3vdKjSA8njU5YF8+DpPsUMq3Zow4OeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmwlq1ro; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806853efb5so981055e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769699101; x=1770303901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKh0AAvpWs4y7EelSMJArE7ZUvvbVpcQqbH3Hl+K33k=;
        b=Rmwlq1roeqsLJUhS5UDLnb42J7svrfIyOnl9f7ePFwmgLMu/JV0TH9aBv9zNQQgSiW
         qVB9b3j7gl59ts4cXBU5DfwPydeUb7gP96+vYM3cBgdS3uvMM799pKOzxSLLWMXJ5qc3
         Zwyyh1TSGJIt+XXHg28zJ5aGRU1zU4l0Z3VMH4+2ggR5oEoECWf3biyyeiOZFfox/yqd
         o1s1O7i+6ymJoFCWfjbr2Xi0n9IiHrIm+jeCqgoy2G3FFYKfA17yhFzIutiL9BIcDBvi
         F+v/+4gMcfPv+Q06rZzlINC7voYbO+BmUtb8pcH0GARvPF1j5T6rwRN/+Yn//HNH6Gbm
         bqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699101; x=1770303901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKh0AAvpWs4y7EelSMJArE7ZUvvbVpcQqbH3Hl+K33k=;
        b=OieTwSwhyRmOzFk+wsOVCHftjmbtwp2oXL4538x60K0Ztx3M4l8n3NbAbZ8aY/DEx4
         n0VSzXASejPeeA7Hg7GGq+942J0j+0jbxNtn0TsMcGsE0RbdhAOBlepSjIsw9s3P0H2J
         myS+R7Xt0cmVhce2OJZMtRbjB41Wf2k8qeqgsIEwKNIO1ebKAajlK7ytp2gebXRBM8Zg
         igkDnQcZU2uQguEjUHJmF7zKCFmloNc3YEnNyOSztmZg5+D5iaRGoi+745W5fRhOa6LK
         NuWRsc3SuoNH6anHum+A7PoMKEgCXMhl2zr/5ROllUrbKprwvQ7zaulhGGyf7dmNGPHs
         uKDw==
X-Forwarded-Encrypted: i=1; AJvYcCUasJvkiENsD4UIJMjyXdc+BYqC+lRR7nVj71+oRAX21RSsZYfIXSrDEPDEjtrSZ2/gn3eLf3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCqdVg0riy72sBMsS/Z0u7D7o+zWq+IkVKLRSRON34GdMr4hx
	cjBoWLcoA4mA9zsgb4PQRVSD4YB/s17UQZ5zhX+O1HbHtqq3uMHhpey8
X-Gm-Gg: AZuq6aKwLz55gtfQWvQM8Nyi04ia0rFXAG38bMghGMGRZ+i61wcWISERsMw3ZpuOWbN
	rJwTWEsfJpw5ZDCezoLZWU3Z6KoPjitddk2SevfERyLSNz9unIXWp2ZESU6EBkXRNzf6Py39Xcv
	lRPgNc0tFo7YYLtrkOzDOzGpTfZcxZ+AGXGufzh2MY584kXTs5LVmUwXcuWwFD4mvtU9SL9Iby9
	/JBP7SzOugw5BzyDeGWNrihOrv4Em/pLB2uzY1aeQkUzh3JGxWdkjgcx07gJHnlJGgPmr/Efq5h
	/he7KT/qbUmHWwwyg0kEy6Ee63XEX/rjD4aPAJxmPi60NiV6eynaPbIE8zIICSvvcyr8X7r1Xeb
	4i7K5eB3TaSz2OpcL+/vWM0B1fUZ76Kvf5SWEmcplTk9ZbF8KukhcsnU+0xc3IqysIf2jBrioY5
	pSPNp8Ar/f0nJr
X-Received: by 2002:a05:600c:8706:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-48073c5b0fbmr30532905e9.3.1769699100582;
        Thu, 29 Jan 2026 07:05:00 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:290:ffc0:1146:90e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bfb59asm188890405e9.7.2026.01.29.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:04:59 -0800 (PST)
Date: Thu, 29 Jan 2026 17:04:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [BUG dsa] lack of barriers in netdev_uses_dsa()
Message-ID: <20260129150457.ob6le4lb2v6j7mqf@skbuf>
References: <CANn89i+UsejDXBJv-SqPJTCb-jO7p_+28zVLOOxvHoyV2MKwCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+UsejDXBJv-SqPJTCb-jO7p_+28zVLOOxvHoyV2MKwCQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F376B1486
X-Rspamd-Action: no action

Hi Eric,

On Thu, Jan 29, 2026 at 02:16:56PM +0100, Eric Dumazet wrote:
> Hi dsa experts
> 
> It seems netdev_uses_dsa() does not have any barrier.
> 
> A compiler could read dev->dsa_ptr and get a NULL the second time.
> 
> include/net/dsa.h:1336:static inline bool netdev_uses_dsa(const struct
> net_device *dev)
> include/net/dsa.h-1337-{
> include/net/dsa.h-1338-#if IS_ENABLED(CONFIG_NET_DSA)
> include/net/dsa.h-1339- return dev->dsa_ptr && dev->dsa_ptr->rcv;
> include/net/dsa.h-1340-#endif
> include/net/dsa.h-1341- return false;
> include/net/dsa.h-1342-}
> 
> I was looking at this because I wanted to inline eth_type_trans().
> 
> Note the wmb() in dsa_conduit_teardown(), which is not good enough.
> 
> Any suggestions?
> 
> Ideally, it would be nice if netdev_uses_dsa() could test a single bit
> in "struct net_device",
> without a dereference of dsa_ptr.
> 
> Thanks.

It's been like this for a really long time.

Alexander Sverdlin had a patch to convert dev->dsa_ptr to RCU/RTNL
protection, but his problem ended up being solved in a simpler way:
https://lore.kernel.org/netdev/20240910130321.337154-1-alexander.sverdlin@siemens.com/

I also started working a while ago on some patches to gradually replace
netdev_uses_dsa() with one of
netdev_uses_dsa_rcu()
netdev_uses_dsa_rcu_bh()
netdev_uses_dsa_rtnl()
https://github.com/vladimiroltean/linux/blob/dsa-rcu-rtnl-my-try-v1/include/net/dsa.h#L1360

but I didn't submit anything and I almost forgot about that patch set.

How urgent is this?

