Return-Path: <netdev+bounces-298465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 12DkFLygK2qnAgQAu9opvQ
	(envelope-from <netdev+bounces-298465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:01:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28819676D64
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:01:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BoQZKsEm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298465-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1112930118ED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73938F25C;
	Fri, 12 Jun 2026 06:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296482BE051
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:01:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244086; cv=pass; b=Fll5W8BNZPvRRGWXZhJbJh/N6d4BcvlnbJdSVo4kMsz7Hk6PFSr7yF6RuG9OzlZsFsx1BWTB7Jg5kKOvbTEg0BPpwBtVCNc8hnslVB6HWJtMth5wJXSfimms9E/PEI09KGgsa3HSf2d+4jlgnZLMVOinjbUQR+L18E/lN23P2qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244086; c=relaxed/simple;
	bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jrdua1X0zM6Gu0qjXxC2UI9rENaR7FqgHTU1d7QbTUq2qHAx3QgFtwz0FA/kqrIApDYJzqkiW1rmFLj31Mdg6gvk8DzDx+QM/TFkBTfE7ku/op/pODLIESxZXTiz2fcl4g7QXkMNZewpMuoO5/zGDASYqJdMmDFSnyfLOY2kMVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoQZKsEm; arc=pass smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9158fbaa4bbso70847385a.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781244084; cv=none;
        d=google.com; s=arc-20240605;
        b=KcOHXU545cAcq6oQg7k/G3ZT9oBXLoFTX8U63VydjqOcLlKZYs5vI2MIXJkwLo+PsG
         KwQMom+EXkGZT3y5MRkoJmt5bxYjlxdkHlZqT2ajv55iJSj35wCWsung7UDAeJdFipR2
         sQsTRV6AwYuI8JnxBihbG+Vy7SmIgr/iIR+QVtWy3brFf2Nd9+9P1avgbgREUQP4DxYL
         qedS2XJuobOV1uqoy32qcP5XNpHtOESymII/cIZ6w3oRNpdqBiEbWzcRry+GqymN59f+
         p3rlW9Ig1rdvQH2ixURqwqQG1pQCLvshlaIVCG+jD/XAYNEVXDcojcUvuRUG/6FetyNx
         Ce/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        fh=lvfF0e4R7DcOeqR9GAtV3ofq7yWtHIhBGllUrd/rJl0=;
        b=cZ70FXhYxbgo9UVxE9QEWs1MBB66C/VHCwmX7Zop3V298oTny01kT+KCih7vpLRa/t
         LtqZKe+DU43KG8gv66o3zE8LAis1nYc3NyilLhYO6YWb9gQa0neJztgpEbf0OcQEq6ad
         ZZ4geVDcpCvvMO+e0f9TIMii2WjfnMNG4AiJJtz1zOF4kBz/V/Gu5+LnzaKupiFPG+ID
         9wLWcsJcqC2T/enL4bpPYX4A1Vvxj5nslm+8ikdRCo0jfELjgVx7aIcesNjghMpvu07e
         k34clSDQlVEohG0Kz1RUCvWo5MGjKcv6d04jFzIAerdaBUb+B0mW18kIbhKuqfBcbKiv
         oQzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781244084; x=1781848884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        b=BoQZKsEmRec3Sq9Zi1oxj/1yvRRGBiy0+DqCtPQIDCcDDiFVYlLejJcTNdV2fboVGs
         Zz3Hrw+Ss3ge5HiR3mSpSSueQfgtrWUJz4a0Jj4zxM7cDLQ2gBLbWogQ+a90lqnruINT
         /zEW3Nz5tIzGY/Gajwy0Uoehvb2e9rhLP3VfcrnkwKkNu5vEgmbtQlmdeumSYfCr/F94
         mzPhWh8eOdDy7WqwEv0ZpcrJ4DAWpSIFU2gfl3QR3qWW9skVpzx5cNCt8hjyeqxuTQuC
         2M0eienb8IaaYTXDZT7uYyPWdLX/ztsnNe8a4LAjqSJ6dCoDOZcpx2mEF5m2ynVFn4sO
         gGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781244084; x=1781848884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        b=pDp4FpZEIh65p7wGfJLOfzSz7rPhj8+3Gjx5yGpCr7c5TLMKXFK3fX9GYUmFAhuEnZ
         eiEWrI+VtIxLp2wcpM8UW5s/3t/bbsAjNBK+ETP3WPOU6EO2f4rXSguDPDEccbQDU93f
         bAx7d9MTuDr1gJiz9bFR1OrAoAF61C9vjBuOgNVDzF8mZA90zsrWd/6LRoA5eqx9COmi
         AhK7H4+8IDkMYSLsLUGrSDNKEC6eGQJbKGWjXf9QWNITFZXSxxXo/344QpfG53wjY/Uo
         aGS6omOG3cX0wJ2jIdVNTLDZWYJ6L6y02IqF++AzRvSNZT/MSqwxFBvo2Pt+16aTT5Ys
         Q58A==
X-Forwarded-Encrypted: i=1; AFNElJ9tmCGSN4h1980PnaLFM8ko06OSJMm3QlPCU/8egPNfFSPbI351HV7Ryh7ODz+LUFPu05I5PN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduQ+epC1LYbrJQIkXddCAsM9zEiwaVNv5T8K6G+/RT3YjfLEp
	o3JQFuzzUCQGU59jy63BakLAGfgeb/PwEynJV39ieZxs+ZtvcvF/59XYCxTJWCU8nXnQlyJnwsg
	9BE0s2031VaoBCNKVIAna5tWsFuHMzXrW53b24lBf
X-Gm-Gg: Acq92OEmHn+zP0dSI869WlpidHla6wYTQNTenfLraruV4bTjDO6k99uxHjlukleZ2mi
	CmdJlItq+x0btYkMGoqj8Trgn0O9rdUt0jZnWqdsdSdQgb5InF2m1v1BHgM3ypZCqgSMSkdK8jz
	f5dm40uy3UvIrdVY8EfCz7K9CEPWXzWLwH9Vi1OvMzzja9rbgLw+t1OMDZ7iTwIMZNB0XYjMSEi
	x6uaj6wO/CvbzwhY4MqcToS9EJNJxk3h9Z25sZi7TEE7730yXLnAkrkc1UJ9I7qgKxYJAcUQGqt
	uW19Q3e4UN3dK5HwbPLdHrura1Ka7VCd6aJH6W29hm3V+g5ABS1xELt8Qip9HUe1kCBc60L8aHK
	tSs3joSfcb/EeHfctkSQ=
X-Received: by 2002:a05:620a:6601:b0:915:8988:4e55 with SMTP id
 af79cd13be357-9161bd1718emr174397885a.40.1781244083480; Thu, 11 Jun 2026
 23:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612020941.12694-1-vulab@iscas.ac.cn> <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
In-Reply-To: <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 23:01:12 -0700
X-Gm-Features: AVVi8CcSmE3YLxkjVaOY6nOT2yd_vAl5QPJY-MbMPUVjjUTYmrdKCJTvHqAA76M
Message-ID: <CANn89i+bQHftM4-36j6+8Hn6iQgTi6Z8r5+YOFDju2KXCU-Jmw@mail.gmail.com>
Subject: Re: [PATCH] net/xfrm: fix refcount leak in clone_policy()
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28819676D64

On Thu, Jun 11, 2026 at 10:53=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 11, 2026 at 7:09=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> =
wrote:
> >
> > In clone_policy(), xfrm_policy_alloc() initializes the refcount to 1
> > and sets up the timer. If security_xfrm_policy_clone() fails, the error
> > path uses kfree(newp) directly, bypassing the proper release through
> > xfrm_pol_put(). This leaves the refcount unbalanced, triggering
> > warnings if refcount debugging is enabled, and also skips
> > xfrm_policy_destroy() which would clean up the timer.
>
> Can you show us the warning?

Having to clear a refcount before kfree() is a new thing for me.

Just curious of why this is needed on a private object (not visible yet)

