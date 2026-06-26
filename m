Return-Path: <netdev+bounces-302139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AroEJrVRPmr5DQkAu9opvQ
	(envelope-from <netdev+bounces-302139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CEE6CBFA8
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:17:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=PFif3UjD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C7453025BF4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D263ED138;
	Fri, 26 Jun 2026 10:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BF3ED3B9
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:16:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469017; cv=pass; b=WYbmVqPhRVq4MWl3tzy9XosP0bHIKv4PNTpmt6rflBvNWb8vEcQlKZSETmD+vRJyAeeX6vdkY+6lBbF3eha1JqkaBeRlpYpCCQBuFpExBiZvNaOpJyjTK1oEqOs7yNbPXu8bcXgGEyL9CeOocpJbvVjaTUKfdBjrkeSeCoJ0oW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469017; c=relaxed/simple;
	bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCmqf75epb4/IlpjazGJXvOyl7VvLhTxnFWlcAc4jDAL010SyN2EvkmG/eZIEjp1F7sm/Nuu2aNAoRiAfj3VlcfCCR+V8iGTY4ZnKzehp0hoLC2S263wscS7/cY0LJvLE3J0eRFqo4Z9Fu0wLjcrtqDKy8+MMapamTd/ctPWA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PFif3UjD; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso613619b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 03:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782469015; cv=none;
        d=google.com; s=arc-20260327;
        b=JvRTG/umNI7MzOI2WgBmjAdnp1nO6V0eHJO1Hm7mpbcGYjZeaVEzJ9Pvhr5Lg29esU
         p3WHiX5WhiJz6jNxoLLSMl88RPcoX2Jhe50WJE0czECUps9JauWP7CE0DrhJA7hGiciS
         EoeJ9CVtcSqjFFUZ+aJi3+X3QTQMTE/EsXOOvEHycSytxVMhFvhZQH7hYfFKfb4ZC3AW
         EMF7087OOpNEZ4QLChUxYcjVBFCUWAGVCf8fL3hoLfEDfU9GE1xn6LKDNJxFyIj2BUWo
         1bF2qoZcXXiYyiXnADzqKzm0lZgq0hLUIFxFD8thclfSXKetZh+VUe6L2dpGLUZ+eEo/
         eZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        fh=KRv1BJQB9N+Hx6F3XJrmjsu6+e+VwIymwxj2UtUwR0E=;
        b=CJ7Ct4d/UWuNR8rYSh8WgIV8vKJc3ku14FNsGHRq1nRfjEXFTB1U4WD/kOcAXsrGE2
         xnrFiDJklPk6XvYuVd9EnT3HbD2wxXY7HHSjeMvhLK+DyFAiJUo5+qeL14UbglT9c1ci
         Ai1+luz5Ud8RShUE7Pd+V/l00FWkDcdmJUopJreELdcGzCWqHZfLZLe2a4vjrXnm5iHg
         fPnUH77ntzWFqDinbdtzVrU+yv6mf8uAzlae9pECuuLo0k9jwj6Jsg6daDtXLxWk+++m
         fO3e8IKxWB0idOnazAgTZJj1s2RxKPBaF7XFsTh5HeT1Trxrw0AZrmpFYqjzyLP1YfBg
         Yu/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782469015; x=1783073815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        b=PFif3UjDTqdX/mCLhIAN/C9cyGlL9i0cierzz341tur+BTBYQ524X2t8djIlEZWWSf
         NhddQgXRaxqKG5r0hnFR50m6RR6AQZMulEmghsQKoWEpyJVi2EvpYJpAuYmdR8ENoV7x
         4y5zwm45kQX0Mgksgw+5494nqoKhqGcL3NqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782469015; x=1783073815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        b=RRQ4KdvDTqzQcxk6HcbXSBh7I4LbXCPr+ca0v3ILl3FvD1oMmrTWpskP7qZoe3C6LN
         WPu2buBQ/cbG3s+SUIqv6RqJ1iHMZBLy8JpWaunLn6nK0Y0n9YusC+P33Id/20I7asLo
         P8pEH48a3O24mJWrmJhvOWRmr02xvKMzXzvPTpQvDyJHWOXfywEh4/x0h89Fd+Z+8z65
         nx4FDrUy5dIGRjd6HwO3NqCeyWX8NkmoW3PWV0bFaA5g+87+mEuOGY/x9ifjmTE5vvTg
         CVUMkASqwabcTGzssPunI6KSSHt8XZOI+nJrbdFZH44U7hnMOQJUmoQSzpcKbVaHQ7MR
         cpZg==
X-Gm-Message-State: AOJu0YxSr1rMLgYZl2wxcrN1x8Bg1so/rwR0UOCGUsXqy6PM6kuWCka/
	1rNXVgQubm/S2BDKcLcNirUeh5WOf/fbwnVzJW8djpVtE7wVOIeW33pRrfFA52r8q3GnDNXCXdQ
	Bau8tUJaxyT7mdgvPMFOY8J+1Gt2LVCtzxERXLDPMoNYXoqodF1ogLA==
X-Gm-Gg: AfdE7clL3SX3KAqeF6oX50Kzw0tAE3bq6CvpfW5hF7lL6ALLCiIHVyslFloaKni5Aei
	lzgQlYvAzbmZHoZBGcv+ggvyAjqddHvQ634v9B/IpDTGWypHqVx9tVLOI+gIqLxjb0vuA0BHQ2n
	BqghobQpnF3jibPP7UzCPGfgH7pXflH/BN8gd2CTqNvNTRtGNSm0zYzz+UAAkPm8QXpoYK0wNiu
	/m5FhnkmNV7m2+pqyhTG+44ETFQEri1nkQdSnEsn1sPVuBDNik4a4+MSc+jxVeODBqL0j4/2g==
X-Received: by 2002:a05:6a00:2389:b0:845:d0d6:b9 with SMTP id
 d2e1a72fcca58-845d0d601bbmr147884b3a.4.1782469015279; Fri, 26 Jun 2026
 03:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624224016.24018-1-jhs@mojatatu.com>
In-Reply-To: <20260624224016.24018-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 06:16:43 -0400
X-Gm-Features: AVVi8Cf2P7f9br_adTOBaN-EcnhYa4YwGzb1Nua8DRNE1VC5vPu11kXmT85D-_I
Message-ID: <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,m:lkp@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302139-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94CEE6CBFA8

"

On Wed, Jun 24, 2026 at 6:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The teql master->slaves singly linked list is not protected against
> multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> teql_dequeue(), teql_init() and teql_destroy() without holding any list
> lock or RCU protection.
>
> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> after an RCU grace period, but teql_master_xmit() running on another
> CPU can still hold a stale pointer into the list, resulting in a
> slab-use-after-free:
>
> BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sch=
ed/sch_teql.c:142
> Read of size 8 at addr ffff88802923aa80 by task ip/10024
>
> The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
> senders on a teql device against a thread that repeatedly adds/deletes th=
e
> slave qdisc, together with a SLUB spray that reclaims the freed slot; the
> resulting UAF is controllable enough to be turned into a read/write
> primitive against the freed qdisc object.
>
> The fix?
> Add a per-master slaves_lock spinlock that serializes all mutations of
> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> around those updates.
> Annotate master->slaves and the per-slave ->next pointer with __rcu and
> use the appropriate RCU accessors everywhere they are touched:
> rcu_assign_pointer() on the writer side (under slaves_lock),
> rcu_dereference_protected() for the writer-side loads (also under
> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() an=
d
> rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
> which run under RTNL.
> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> traversal in teql_master_xmit(), so that readers either observe a fully
> linked list or are deferred until the in-flight mutation completes. The t=
wo
> early-return paths in teql_master_xmit() are updated to release the RCU-b=
h
> read-side critical section before returning, since leaving it held would
> disable BH on that CPU for good.
>

sashiko-gemini's complaints:
https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatatu.com
seem bogus to me (someone correct me if i am wrong). I am only going
to address the first claim of "TOCTOU / "resurrection" race in
teql_master_xmit()"
teql_master_xmit() holds rcu_read_lock_bh() across the entire
traversal. teql_destroy() freeing can only proceed once the qdisc's
RCU grace period has elapsed - so where is this TOCTOU? Let's say this
were true: both calls hold the slaves_lock.
The other issues are of similar nature.

OTOH, sashiko-claude
(https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016.24018-1=
-jhs%40mojatatu.com)
does make some valid claims which are low value, so not sure a resend
is worth it.
For example in claim 1 it says "Should the changelog mention this
teql_dequeue() site too?" Sure I can - but just because I provided
extra information in the commit log, which I could have omitted, now I
have to add more info? ;-> The second claim is "rcu_dereference_bh()
should be rcu_dereference_protected() on writer side". Sparse didnt
complain and i dont see this as breakage rather a consistency measure.

Unless I am missing something ..

cheers,
jamal

