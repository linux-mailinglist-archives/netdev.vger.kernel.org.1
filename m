Return-Path: <netdev+bounces-297147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iupSJJE3KGpgAQMAu9opvQ
	(envelope-from <netdev+bounces-297147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:56:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308B6620BE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:56:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rzfC7pO4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E1423041265
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACE3FF1AE;
	Tue,  9 Jun 2026 15:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD136F420
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:46:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019975; cv=pass; b=pC7h75ALS2L739tv2BNx2zZeY8VTM73smVz9RgFSewAlFtO0r+C/nvBWbGBZ8FMt9w+9z0vLSCLw8TzNAb6KgwW4OM6rT+nuEusjjEEzLwGq/8Vx2m+GrlOTOmFVeHURkInxdirrPEIUibrK7hqnSqxtmvK4gpDe20U9ihPQ2nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019975; c=relaxed/simple;
	bh=9a4r17jEbIRw/LDL+7sSNEtluPEIAB8XAMCNXAoH8b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb/SFB3PqQLISF785lUh/BB0xXqBFUqKXbCDUXL3b3BmDXRB1SDCIkwLY5jXSqLv4svQNMI6VLvztLqCtjhtY5kSRQ/cpDUUofnGVhvtg7rLTPHoPkT6S8JJvwCYy+ya+dqkcWQdN7mDItwJhCozyAIsknf6qlTusPVOOsW/ZNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzfC7pO4; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51790c0a692so58065311cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019973; cv=none;
        d=google.com; s=arc-20240605;
        b=eFDIHBB0kDJyNw1wEak4iZ7BI9FapecfFQhbIj+XZ6xJExU+QXNbghIvJfCpYBo8zp
         Mm1+6f03XQiK/2IosV+3hIpf4x3zEejZaDBUX+JI4CZQQfeHkqkM8M/EMVdXLPZwdQBk
         Hqoy9G8qw4P5E8eKara0TzDYUnxH4f9IcGXENVZ0JCO8uxpzRs8nNOogmlvRJ+y/bmWV
         HaP78+VpEimC3p5O+vSb0BFE/vnL6stoX2LhRPE0F+m1X+2FTOrYOJOvhhxoow9UWlp+
         EvbtuF0H0IUxRjBqdSKD/NSv6UdhVH/OwX8y5S3F3A9QguyYffpv2qxh50PcsXo4xmtN
         /qpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9a4r17jEbIRw/LDL+7sSNEtluPEIAB8XAMCNXAoH8b0=;
        fh=9mOCe57fRHiz+ptIyK5Uo+ncwLjV56OH4vabrKcnVyE=;
        b=Ib7Qkm1zvL5qyO9ZBP5bn1SMFwMnBUNMVYHFJbFQYR9BglupSR+pbpbo6HawT9GvJC
         N9BqWvZ1tBjzhdAfTf5kkq3mjTgTImqCqjaTwK2VCXaZp75tDxRgK5rnydx3Tv9D0Pb2
         hWyRMubYLLLBdVRFEShK0pvqH6thAXdQ1bRNexN1HZrn1X8H/tq2E4R0midWi2aa6cnO
         PLZYkYWxnWwcDmOB0nitpocqsGSL33XrP0dxWpWSpFYH+FQxHvGRgbscMaH+EG/9g0oO
         /R2Ye5bWVlPmcjZXkFm89PvpmyqEhWrGlfm0xmKU9NuEEYPhp5bZQ7qDucKc7Yx08q3T
         Aqcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019973; x=1781624773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a4r17jEbIRw/LDL+7sSNEtluPEIAB8XAMCNXAoH8b0=;
        b=rzfC7pO4hHdr8txugmmkeRo7+qvg9dFQ23MLu4Jrw0Z+wqjhQ6fkih6buV5DsHssqb
         9ZYB89DokAxrhyQ/N9m5AvEUqOUmCNK07tTxQZx+/5G1Ak2Y2x04obGOJ0wifA4PgrUk
         oPwVAcXTNsXX2xB1bALds7FzArVrA1wpfXMwTozT1hkTGvChEH80Jrm3yk+707huVCnQ
         RlOKbdaII2QywKYIjXygDCC/ex5QHWlGgDmZQstALt0zHeC/S0S3X6n+nxtBuSW8NQ+4
         ZZ7kSMhzMW97QCVdIq/RY93Sm6PVo6SLHHmX50V/bBu0L0ZMF3Urq7iRlZVhXpjDP04Q
         2fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019973; x=1781624773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9a4r17jEbIRw/LDL+7sSNEtluPEIAB8XAMCNXAoH8b0=;
        b=GtufsGilk+ozVgSMgK5l3QPQ6f/GPBC+GNSeeKfJFIV17A+owSs/eKy7U8MQuKTr6k
         fQ41v5iSxtLOoqXXA4A1UY+J9aag1JbFSgbQ9Ea/cu2QMbJgNYu8Gil5hvQyK4qOr3R8
         l2oHt6a0vZr1fztfCPMVcynjdcAM9Jmzv9DMvUqGG7o3/IIW5hJqPzHBWNmsK9XD3BBi
         lhvAGNpRS2UVoINEwfM4xwkYpSxc7na/1afZctqI1Thu7MXmna8t+1tvv/9m6+2FZo7B
         qEobb0LTgJF93zdJYoanOxAupaYuUXydTEbQGvTwst/9p+Z37OnMHtC2i1vJPiKAyHJH
         yw3A==
X-Forwarded-Encrypted: i=1; AFNElJ+hP/lihaE5KNHjOZ8gUB+vpNrBq8J7PiU2+6XWYCUzU67BQL2JQSLCfKG7ydGAGPUGWcgKRDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkK/iCDv4sTymwMLZa3vmo3y1hJLpQ97iqJXx4UAe/D1RntblM
	9tMKc+4jnob3CQ2tMF+m6641oCZtWtnR5qVMNaZrlblOZIgCkx2Ir6vmfSYJ4cnE8KHbAmojRke
	MW2VsaCxQtuyRvbu0oGxgLNDULifJ2zA3ZaO3S09G
X-Gm-Gg: Acq92OEGV61l9uPhIk9hDOsLr0SEAy3IylWwXcddcq84FKxn7CiTrgZ5ASUP7nZ+C8q
	MOxLS4ub3tjsjI2OgUiHs5Wq7EtOTFb5xRQejY3SepN34AjM2UbQhiDsIamEz+02/SaLsA2qePp
	5A0rGK55wcrIVdGcjKVzH3e5+w7T33GzJ0xLruL1k5a11ufzff37nje6BpPlr/nFNN6wPFLJDuz
	cUolZjccOUJyzp3h/VQhpKEjPAiln7EjGm2IVUo+wQsRdehY5hY2fSNDkM0xDHebjox49Rnm0yZ
	+luhc3LZM/+882Kf6N1Us7Zsp9S0bAUp1r7+/WTzderlJGchCV6H5ZOG618BaMpNqUkGyA/eqiO
	euNxOspwsrySh7R91SBMyMURWYUIOBg==
X-Received: by 2002:ac8:7c48:0:b0:517:6d95:ef42 with SMTP id
 d75a77b69052e-51795b9f2c1mr288070531cf.55.1781019972820; Tue, 09 Jun 2026
 08:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-11-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-11-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:46:01 -0700
X-Gm-Features: AVVi8Cd7GQheZHql-uLiA8LAmZBOTt8Qv8-CIevzoknamRlr7DmmZgslAuoa8-0
Message-ID: <CANn89i+5=3i0y4BGr7K2sPFHKJY9qMjz+__8Uf17kC+EkknUUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/12] net: ethtool: ioctl: concentrate the locking
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297147-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2308B6620BE

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Add another layer of helper functions to make upcoming locking
> changes easier. Otherwise we'd need a pretty complex goto
> structure. netdev instance lock is now taken slightly sooner
> but that should not be an issue since rtnl_lock is already held,
> anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

