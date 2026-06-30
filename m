Return-Path: <netdev+bounces-303129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YUfmJsOyQ2p+fQoAu9opvQ
	(envelope-from <netdev+bounces-303129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:12:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0576E4094
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:12:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b="EuGK6/VL";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE73F3077DCC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E8406822;
	Tue, 30 Jun 2026 11:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55133FFACC
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:50:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820205; cv=pass; b=FyvKGqRsIvWa0d+uiyg6Ypb49aPUxFElHDpPbUpbl990sNEDTgO1nSofXm68UduwqJ95H5AK4DythnnTrbmz0wtIasJNVu0QUAemYlgKrFrf8M2lsOJXazd+NbpIlLSXnVmz7B6vIFk7t7vegDhBppK42hPLZigHYxohDT0KRkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820205; c=relaxed/simple;
	bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWeNADwKzoNuGFWLBKwPwsIwzgTSaoq34w938VnesRiGq5IYCdLddqKNcQ3LrczNyoxDqZNoybWGYz3w5Upjx+7UYzRHdt0sd/7SwRPvmnL2c2jBWdYrWIRC/rZrDK8AjAKxOLVfZ1ga6vBORj9fLmC3Si0Z57HaOmIUYDMj638=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EuGK6/VL; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84794e800f4so756189b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782820203; cv=none;
        d=google.com; s=arc-20260327;
        b=kNkujhwvTcnhCtO1MNrnvz1EgpdlODNo9h6mEsiUay18GTGA+7FxqRtiBabYKWVRdw
         YgA7nssl02oq7uIgbTxhlgSS7nLNbwExX90D8WV4AJF5H3k5UTKL6BE3kdLKkAWZqxmu
         8yxwT/QMADkkOeApcUubJ8+SONegy2XJ3+Fyo13xFFu1phBydWuVz5JkwTaEbj6MRhhq
         HqGrIa/tsNTR7P/EIE2VUOLX1G59HZngVqf/I6vGvKZ+XRXFLuN0rgSpl8uN79MOE8ZB
         XKL3eRlVJkvKyiJ/hVWHs3JQuaTNsmkITWBDioXcxZDRVC9yZJNa1X7VEiSBOhHCuhiU
         O97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        fh=z2Ww3/ONHYFhHH/rtkEWWeVeD8bqw808Qvyz5K9Fozo=;
        b=WodS4FWoLsIUZLM+wXg8ou0W6svRZNJDudmxszGYBz7lQzz/Vh4pFqjT1i/CmXyxHL
         409X4XfLR5DJSvLncj6Zc6w9fsYz330ykCFr6yFN641WMOJjlBguOKFhV1G4CJ8tioQ3
         +nEY/xFdTiIKhAaM6ShVqxTQlWkFZggzWmjC5HGU448XTd25x+lnaId4Xc7gGC/MpRKU
         0qI+oKzVkVAyA5oBxxEkQ5sUHgqOn+7Ca1hI7Dfuic09Va4KZtk/PKu3jpn3mDWF4bjA
         T8vJwj3uQ2478SuChYs9MPkT+teIpdDo6pd+D0LXCnLaKD98rcJHNfl/pl4EZdCVkFgF
         cKgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782820203; x=1783425003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        b=EuGK6/VL52hgI5WdOzdbe0U4f2KyXWqkmzJowf69FFieDfbOb/a9u2Uz1npJ+uhNXY
         aGJK1ZRaW51BJtmkJqK2dNNcJH+WFeax1wC6XweXDsgus0Ep4wonP/7tHIZ34pucbQ9r
         yJEnweRTqNtjHps/7vOAaXaL9vu+dAVikhNT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820203; x=1783425003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        b=f7JrdpxMiyf83N9oFZcLrbq6yTMD3hUKikzLEpL4UGNVM3vdmVYFWEotI4p+4dHfEh
         GItgLcfkHvvSRHrmPIxw/h5nscz4oAZ0OUgt4+7nMix1N9Gvq57xd2u6R6PtQOsAdWJ2
         MaXDGTzBuYQqqweWG3p6q0xAahJ7LiEd2rOPdw75l4xkGXM590OdkQRYJEaN1+YUvek5
         t6tSSN9nRJiB2KaVRT6b3vqiR4U+XfYnzlVUd23Z03VdO7K2zcG3sogIpnVjXoz7WLOc
         CG0aogLhfvS3vi8/AJDeSUwhMKNENvrA3meRb6MoMM9omWBgVEPATTV1pgcUBZ4d6wfM
         cSow==
X-Gm-Message-State: AOJu0YyJZZJNkyGG63TZdT1NygWf+GYtyoM21KrxuY6PLaYPRSzrC/sF
	aA/9QntLUGuN2A9RE1ctF8J+8NTgfBfe59vFluvKa3qigsn8++ykIsRYIZ+Mb2z/jlIQh/Bfjpm
	WseVUBuPHWiQE8WMWHR6Kg8v1cNEmapXNBMrcG5dS
X-Gm-Gg: AfdE7cnErJ9m83pk8tehhLWQ4wy+DY88LVvy7H7vnuojYRfMagRbAVKPCxxxBzvgDDh
	jA6sQPL2c++gsURARw6U93znzGPCZqgv1z6d0eB57DvjnzpBsHvVB19q54qk4xceR/vN0QWCOQo
	n9/XphxdPVtxxdVvez3zkdePMPBGPArgIxOh6wJeGgxKAf8AVug0Dnp6mjsl2EBX1YBhYC49Zzg
	D1MkLUEdAXeb/DO+xrdA455dLU+NK5mNjJr7SVpDeN/UihPxAXh4CT7wGcEcd3XrYJvKt+FZQ==
X-Received: by 2002:a05:6a00:14c1:b0:847:968d:b0ff with SMTP id
 d2e1a72fcca58-8479f2a49b9mr2599684b3a.55.1782820202911; Tue, 30 Jun 2026
 04:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628111229.669751-1-jhs@mojatatu.com> <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
In-Reply-To: <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Jun 2026 07:49:50 -0400
X-Gm-Features: AVVi8CdpQSTjeXB-bnfvF1mLqAtHVPEptxCPY-KPz-SG2z_eFlsvaBUP5s4cQzw
Message-ID: <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303129-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trendmicro.com:email,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB0576E4094

On Tue, Jun 30, 2026 at 7:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
> > The teql master->slaves singly linked list is not protected against
> > multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> > teql_dequeue(), teql_init() and teql_destroy() without holding any list
> > lock or RCU protection.
> >
> > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> > after an RCU grace period, but teql_master_xmit() running on another
> > CPU can still hold a stale pointer into the list, resulting in a
> > slab-use-after-free:
> >
> > BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
> > Read of size 8 at addr ffff888013fb0440 by task poc/332
> > Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512=
)
> >
> > The fix?
> > Add a per-master slaves_lock spinlock that serializes all mutations of
> > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> > around those updates.
> > Annotate master->slaves and the per-slave ->next pointer with __rcu and
> > use the appropriate RCU accessors everywhere they are touched:
> > rcu_assign_pointer() on the writer side (under slaves_lock),
> > rcu_dereference_protected() for the writer-side loads (also under
> > slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() =
and
> > rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(=
),
> > which run under RTNL.
> > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> > traversal in teql_master_xmit(), so that readers either observe a fully
> > linked list or are deferred until the in-flight mutation completes. The=
 two
> > early-return paths in teql_master_xmit() are updated to release the RCU=
-bh
> > read-side critical section before returning, since leaving it held woul=
d
> > disable BH on that CPU for good.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: zdi-disclosures@trendmicro.com
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Looks good, thanks!
>
> Please note that sashiko/gemini found a pre-existing issues which may
> require a follow-up/separate fix:
>
> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com
>
> (the 2nd one in the above link, IDK how to generate a direct link to a
> specific comment)

I just sent v4 which covered that but i will send a followup instead
if you already applied.

BTW: What is the ruling on when Sashiko finds a pre-existing issue?
Should we address that as a separate follow-up patch? It is unclear
what the policy is.

This teql patch was one of the hardest to deal with in terms of
reproduciability and the fact sashiko kept coming up with pre-existing
issues - including the one Simon and I were discussing. Note: None of
the pre-existing issues affected reproducibility at all although i am
sure one of the AI-kiddies reading the sashiko reports will find a way
to create a poc (this is why i entertain fixing them when they look
simple enough)

cheers,
jamal

