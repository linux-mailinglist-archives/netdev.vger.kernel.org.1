Return-Path: <netdev+bounces-277196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L7AASpU2GmqbwgAu9opvQ
	(envelope-from <netdev+bounces-277196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:36:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE43D124F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5523C3022F89
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F732ABCD;
	Fri, 10 Apr 2026 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpMy8Ojv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C2225417
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784983; cv=none; b=KCKOOqvu4AhFrFHxxEkOaNexsXvO6eyyODEP72bPwN1poxPWJPiOqZ9cQ/8X5CXiZwxS5xSN1bN/0tbr7Uy5rHcc3XyIASTJ4FbW2Mle1q+TbZgpAAvmViITrYsQJmtmqzu078Ldb7aiWhM+CGeEN6AnSMjXEZFzFrJt9V1YDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784983; c=relaxed/simple;
	bh=4f1uV1/D2NMKkySZxEoC8c4upNX8NdJCGj53j64irYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijMHqd7E4sSLkry/o4PgfC9+xVQMFEHtZeSu46IXfErkvx50D87Z37J8+hLSr5Seo6E99ZRY5uVCj6CZxKp8odsdW71hD5eD8Mq6vYoLtuwX3HxqXUIBvogurYSeUmfSeJ2GwThUnzji8/W1ij9I0ZFDOJKosFGUgVXLvkfuf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpMy8Ojv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso7688135ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775784980; x=1776389780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exy9c+Pc6XoRk2nfa9LmtWLNBniIdYcQRFjHjMsl1oA=;
        b=FpMy8OjvGzFUEkOH9XgSnRsHgzzzScgVHDNijh/p9XcnRJdTnMGkTey6qYBZ0oTEYA
         QYfktJdXWiot5uDC0Zb5pl8yncME2t8tv2WMHZgMky1Eo+xKAk7U2iCz4NUpLBCU8R2n
         6y0EThM7isE7zuAVNtrPS0/JUib063mp9x6tIKuJ+BpIFJvik3v85FeE95QREvONSHuf
         +AmksOqL8wWd+lq95GQotm6hpImg7Xoq1kPxD0lk1M7H0IRFjsHixOXAgc/nT215Toso
         VKZjxAxvhdvhf9I9tC7kOZ77CAq8K7HEa50lBwQYJm9vZ4EkzqJEpIL4s9UwBij09W18
         XakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775784980; x=1776389780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exy9c+Pc6XoRk2nfa9LmtWLNBniIdYcQRFjHjMsl1oA=;
        b=Du4r63tyS7e65g33YeQPQEkhRrOgVgTlpPu8kgNC2nbnU7dU2ccpc1eWjK80uIMZB+
         WzToCLbblTUP6DsRA71bdnVLWnSjBbyHhHfMXurAZX52dw95BblchMaN6sr2wohn7P/j
         +YRo2Ri0DE3AN6/QXFmfTLm9aPnyPyZZ7T6VsjQZbm1POrxbRcViFSsIzA6omzOr4WKD
         llUa7EG/ZycG2S9uJVZ4743M59DN8dV+qMqNapRsQiM++uVk3191hwV/2jfXabE/LM6i
         8u32M8FfaJterAzBRrdBjcpB1E1C6l7uN4cjSk0MzF8gs7NFKy20BCYzRsDNFtuZeFzt
         lMUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJMGcs7Q5dFPQC6cdzz+7zaq+k1ur1cUpy8kUNOqM1caHDVo5O5ear0jGxI+uExPLZefbWuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTyWTT79BfSgeB/mdAO8ozzT3+R2uYqwVDmyK4nQPsKW5gA3z
	WA0GqBSLg6Vu0pqPMBf6Wm493Kf5fvlzEQLutYp0fdyGTvRRffDfFxfV
X-Gm-Gg: AeBDiesHwm3PJDK2prU2ii56SUi7dNM3RjY4v1AqsVB7Y6J2Ci5q3p1vAqtEQnVgLWP
	PFsQLJ4eYPn+6kPvGKSVybXvVvoP4N2OYZ+grhVwQYXkHeojNcKz1pYRaNvwwtlSmy3y9HMVqwI
	N9Bx2+vRCBK8KNnvKKg2mUp1ufcDWvmzgE44sR/fDBqODaSzNbcFkjjYuH7mLjAqU5Ek7tm0vUl
	jZehi4XGBi9xF6Rx2XxuMjuHCL5VDW9cZn0VcwfuOn6uuTXm17epcNikBNUcJIKVcB1qA2FMuxC
	n/So1/+/dQiIu6kkF7XVqx/Cl6NSw6Y2PjwVSp6VxpWB3dmzr3YAvdJc1qllkEhzj4tSJ0wvrLE
	fuFNr/48ED2Ejxo/0DutFF93uJiMLg0RI1rRyZMDiBGHuNC9wDshwRyuQxITQ5YwArrbmTFgqPj
	dEl7fJQdC0bJPTUMHEB+Ua9gxf1ARUQRVUKFiF/voTPtM20ugIPY+JCI2MlDGX
X-Received: by 2002:a17:903:b0b:b0:2b0:6d56:8d29 with SMTP id d9443c01a7336-2b2d5a40027mr12672945ad.32.1775784980479;
        Thu, 09 Apr 2026 18:36:20 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4df9bb8sm8810605ad.30.2026.04.09.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:36:19 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:36:14 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: nf_conntrack_sip: fix OOB read in
 epaddr_len and ct_sip_parse_header_uri
Message-ID: <adhUDoTTSK_N5cU2@SLSGDTSWING002>
References: <20260409095056.706441-2-bestswngs@gmail.com>
 <adfEUtiiLzjtKd8m@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfEUtiiLzjtKd8m@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 97FE43D124F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-09 17:22, Florian Westphal wrote:
> Weiming Shi <bestswngs@gmail.com> wrote:
> > In epaddr_len() and ct_sip_parse_header_uri(), after sip_parse_addr()
> > successfully parses an IP address, the code checks whether the next
> > character is ':' to determine if a port number follows. However,
> > neither function verifies that the pointer is still within bounds
> > before dereferencing it.
> 
> I already queued up:
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260313195256.2783257-1-qguanni@gmail.com/
> 
> for nf-next (I already sent the 'last' PR for 7.0).
> 
> Could you check if that resolves the problem you're reporting?
> 
> >  		p = simple_strtoul(c, (char **)&c, 10);
> 
> All of these functions require a c-string, which we usually
> don't have with network packet parsing.
> 
> IOW, sip helper needs to be audited for these problems
> but I don't know when I can get to it.

Tested-by: Weiming Shi <bestswngs@gmail.com>


