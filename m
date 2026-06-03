Return-Path: <netdev+bounces-294563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HJxLPLDH2qLpgAAu9opvQ
	(envelope-from <netdev+bounces-294563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:04:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC435634806
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:04:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b=hkfApIKl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294563-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 071A73045289
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B213F5BD8;
	Wed,  3 Jun 2026 06:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC93F54C3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466490; cv=none; b=uf+FTsZtL3GWW8mX9wqFIYmaa2LaYs31nKDaHy6tLETOs49wBtcNdZFPUHPoB8DyPZ8bLm3UVvzOvJW0IVn5bsQQsdn7I2xUZmeNuPg4Nj0y+sLH+hn5+giU2rWLYeiL5PoddDqEixF5rhoDDlfLqpymL+fgsN72uHYE3L3YKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466490; c=relaxed/simple;
	bh=qUVoLwTe4Qv1zxG3l26DEvnd4jLo43w1wQQ2la3Dh/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzerVM77Tk9HUjd4RsjvWuWLuQE1tdKx+F+ltrdFz0mkngPZuyeWeLBeGaYcYIHRx0f0STBIDRD31AB/4V+oDeAhAhcEF9Rny4HOYNLP0suiu/bDN+WeR9sVDXUJiLD6J/W0qyHUvCyM5BFtCNmJnsxA2YbKzFEqFlZZAHxPUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=hkfApIKl reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf55c39e16so1144575ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1780466488; x=1781071288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5nZhGGV5ovxkIytxrfvh/xga75F2Y72Ucu1MFnwu/E=;
        b=hkfApIKlEpfSIv8ljXZXK2XULRU67Q91cxOEZJqxZ8C16Q5Z6d0q+eNtZIt8uOQEu8
         qDhlo13rpBT4f8i+iE2EEkbkKNAsukllHGgxfGDEer6FieoSIdxlln2I/4LVqjdu6LeM
         FYPl3JFl8YnWq7FRf3QjHV7hAvmh5rJuG+MLp9wHXnSCkqJdB0qoMZ9J1SPpI2HTJTPp
         TMWOb+96+ymeJlLaLluvsLwD6t2t+pz06GNjfY1nnrE/3CgQBYL2o4c2ON7wePF8NFQM
         KkRCCRvvGrch0H4v0fuiRboHYRjGd4lw1D0/1tndSJgDOg8lF0yp7ws+Z/0pLFNoB0jb
         fopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780466488; x=1781071288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5nZhGGV5ovxkIytxrfvh/xga75F2Y72Ucu1MFnwu/E=;
        b=iVMosXxcp+8L80PQl78Yx+vUC22qmGLV9rdFCgBCiRm4FSvlg32TWrZA7VP+sr0z3A
         3Dqd2nVGt7qZ2jQdSztSm/b0Rkr86WFyhse8qDRKEfQWdclLGAj2oBGLoQGB1X2DH6UQ
         HrcYBxXr0VsrVg0u+eje2uC/iOIAS/PNvuM/dvD44dLs+Feces7uqb+HYDoOkLa9tkAW
         cwPn8yiOrPcFOHPKvCGgglGoq376O1UEf8QcT8aplzqT+zGRln2n8pMd8eQaGX0thsn/
         /1LaogYijrQN+tE3Hm2b6v8p6BMttomELlWrH7I5z6Li5o4HFSMvK6c+UgZJ2pGFVAaE
         eb5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mbf3E7isgydqJ6xTqq79KjrjR4A7M+ifw3RmjUZxB1rwZxAijsyHefnTJeOAB3+XgJ8SUXlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgH2FrTsc1CL9MZi1fsbFcjhhZSSzj9i77aRMSngN3NkfMAhkJ
	mb7rCF8AEg91D7wW9yZNuoXsOuMGPNpoSaZpnM5gna31DEvUKf30JzZ//1HKL5RsExQ=
X-Gm-Gg: Acq92OGW7Uv3mByJTJ9XOPglulGxWoW193ulP+uRYaLOzTxgcRoUEZBluAU3llrRxEG
	3YkJX/LIHKvBrSfMq/zihsoKYZxEPapsY4e3dgXkZriQu1FqxrFLSc1fqEjh73gzgoSf/PWBdLM
	zqE6bByWvPNVd4d8JehEaW2CkZwz4WEkjXlwHNhTxgqz2YKyNPgI12KMkgNCjCREYeLGsjejrQk
	Fh2nqHVfr+tk/sdHI7u9KZaxPwkHiCMEYfZ8Y4/vil8nUtMvymzBfgKUgZhULmyIOpx1P2fNOLh
	a3sqSWlRCapyHH+Ow7g4VKrUw3juSbWC7QXP8iIipIlzjZFBumm4eU8DTjK3mM8Zjs6/5yMdepI
	8hTzwxD+LIxX3yZQ28SHEKq5cg7ksiOJoANEazx65yB6wUQ0ToKDjPgI06GjD/fLxWAEVc9zy2u
	mu01WM+X4Hd6wabO0XhwKxzI+kaP6BnjPHRbQQMz6HPb/PrEox5IO3HQ2Q5Mr/8YSFztBHd0c=
X-Received: by 2002:a17:903:37ce:b0:2c0:d29b:34ff with SMTP id d9443c01a7336-2c1646eaeacmr16015745ad.10.1780466488253;
        Tue, 02 Jun 2026 23:01:28 -0700 (PDT)
Received: from manjaro ([2406:7400:ff03:ca30:c17:db43:8a08:9d82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649bde7sm12097795ad.72.2026.06.02.23.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:01:27 -0700 (PDT)
From: Sayooj K Karun <sayooj@aerlync.com>
To: pablo@netfilter.org
Cc: aleksander.lobakin@intel.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sayooj@aerlync.com,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] net/ipv6: icmp: fix is_ineligible() to block errors for Redirect packets
Date: Wed,  3 Jun 2026 11:31:12 +0530
Message-ID: <20260603060112.10524-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ah1VoxXLbRAZIEC3@chamomile>
References: <ah1VoxXLbRAZIEC3@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sayooj@aerlync.com,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294563-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aerlync.com:from_mime,aerlync.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC435634806

You are right that netfilter can be configured to make devices behave in
non-RFC-compliant ways, so I will drop the "netfilter policy must obey
the RFC" framing from my earlier reply.

The point I should have made is that is_ineligible() is not a netfilter
function. It is the generic gate that icmpv6_send() uses to decide
whether the kernel, as an ICMPv6 originator, may emit an error for a
given trigger packet, and it is shared by all icmpv6_send() callers. It
already enforces RFC 4443 section 2.4(e.1) at exactly this spot, via
!(*tp & ICMPV6_INFOMSG_MASK), that is "do not originate an error in
response to an ICMPv6 error". My patch adds (e.2) (Redirect) right next
to it, the second rule from the same MUST NOT list. So this is not
about overriding netfilter policy; it is completing the e.1/e.2 pair at
the single point where the kernel decides ICMPv6 error eligibility.

On how it fixes the REJECT case: the two IPv6 reject paths differ in who
actually frames the ICMPv6 error. The bridge/netdev path,
nf_reject_skb_v6_unreach(), builds the packet by hand: it allocates the
skb, writes the IPv6 and ICMPv6 headers, copies in the original packet
and computes the checksum. Because it does all that itself, it has to
carry its own guard, nf_skb_is_icmp6_unreach(), the IPv6 analogue of the
nf_skb_is_icmp_unreach() you mention.

The L3 path, ip6t_REJECT / nft_reject -> nf_send_unreach6(), never frames
a packet of its own. It just calls icmpv6_send() and lets the core
ICMPv6 stack build and send the error. is_ineligible() is the gate that
core builder consults first, before it allocates or assembles anything,
so that is exactly where the e.1 suppression already lives for this path.
There is no netfilter-local guard here, and there does not need to be.

So the scenario in my commit message is the L3 path:

	ip6t_REJECT / nft_reject
	  > nf_send_unreach6()
	    > icmpv6_send() / icmp6_send()
	      > is_ineligible()  // now returns true for NDISC_REDIRECT
	        > goto out, no packet is ever built or transmitted

The patch fixes the REJECT case because the L3 reject hands packet
construction to icmp6_send(), and is_ineligible() runs at the top of
that builder, before any error skb exists. It is the same spot that
already drops e.1 today, so adding e.2 there completes the pair rather
than introducing a new override.

I also agree there is a gap to close on the netfilter side. The
bridge/netdev path never reaches is_ineligible(), and its
nf_skb_is_icmp6_unreach() guard currently checks only
ICMPV6_DEST_UNREACH, not Redirect, so it is not covered by this patch. I
will send a follow-up to netfilter-devel for nf-next extending that
guard to also skip Redirect, so both paths behave consistently.

Does that split sound right? this fix to is_ineligible() for the L3
path, plus a separate nf-next patch for the bridge/netdev reject guard?

Thanks,
Sayooj

