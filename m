Return-Path: <netdev+bounces-303524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i2hMNrvFRGoF0woAu9opvQ
	(envelope-from <netdev+bounces-303524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D276EAD19
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UTVTxpzQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303524-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B60983017051
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A93BF699;
	Wed,  1 Jul 2026 07:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A33BED30
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:45:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891921; cv=pass; b=MIejSbYe5BLp6tmkFuDg2AaSV+FJeOEfCS+n14nAoST52GrKaC6b5hOGIH0tgI7SirUYxPNwX5kr84ktP2O4/VHDbI+yS0QpRYI5Dhsgz6X2Wc75hjFprFOzfcAoOgFGGjeIeWPM6430CBKoH342nD4mgYNCimrpe5bvtVgIJuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891921; c=relaxed/simple;
	bh=UjHW8hqg3pwKFjowUwjlaiwzXzlQ+AaPT7yermI76LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlimajP/cjUBkt/8bMIA+RWcNTvRQ02vmS1c3pw104M2oIBNOJX3B9Dkd79WtzuQOSYiUDdMltD8AeSCcbXpbRdqd2guua0DvM7ir/43if1pmxTePanRsD6ZttpgtW8UJRz0mDM/2zCVi7vZevo2OQnPKCdPU4CJP5Sae6F1Igs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTVTxpzQ; arc=pass smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c12788a75abso69459166b.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 00:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782891918; cv=none;
        d=google.com; s=arc-20260327;
        b=D5HZG/rPQQHKd6iyta0Eyh9iwB/NsbD1e8p77l8VncARswlpSQHIRQEGTcNacZw/M9
         vGonW80qHVI17fzqMNBFh/x7C0opgeJakgxBNPPDkoxDfA17crVoR5DKCUU+MRukELGQ
         rZOl6Cr/G6yksUqc8N21Wg42Zw0ewrKtrG7CB6mBX7WmHxvsFWe1ksuojvO+EPUQhFP8
         jNo70T7BcX1862XL6KL9AY5RbwETFVBe14u1P4X/Hd2MuvVvejU3FJMMNezL05DDeUFO
         jqaeAWnKfMuvRng3IHqJIqcs3IgFbRZJfqw+HtcTnBn9RPGXBJgrWgkqZRUgznLjIWlr
         iFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mNbfdeGpySglO1n2A9UDqE8O3DAfIiwtknATq1x2ty8=;
        fh=Rcviljcy5FMlK04eHkup61MDn+NKyPPnEVQlnYPJ1pI=;
        b=F/RqUcSGSa4G5h7Xp6T52AgxiIdwq4gQXR9SdRjYbbI/ki0oQUkxA9Y9FnMFb6dOJi
         Une0qIaIfOBUVmM85qT2X7K6rB6z9tREWnZnIZSlus9JFQYinpJPznpBP4akdiO4hrjm
         7TMa+HKWxP6N2tnbyRverN+F+zR9HY3EH4AuoCxi9Rkb3p2+rPYdB7kJUNyu1ZrJHOyH
         4vccoxyn7aRLFgiXC1ZTBLp1kExOZeMr+mlrNpR05mGS/X5a3y0mZODrcbzkJn8BM/b9
         I1lAJSj1hvLu/ckOwWaC+JB1Bh1lyMF5GibmMoMfG/2Ga8lHVroAk1YA+NMawOgXJ7A1
         q1SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891918; x=1783496718; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNbfdeGpySglO1n2A9UDqE8O3DAfIiwtknATq1x2ty8=;
        b=UTVTxpzQkbqCRlDSO6K/7bVMCWVLIWzSt8hA/1Jqg5KrM82FM3EBZID8xm8QrQGdsF
         YhDuhnR3HSZ0DPSPSnioz8fjmGGtFpbKqi0Wm4mzd7GXP8yUuT92sGgLH7KazTVn1k81
         3Y7i6+vrluKiywy5RP64KIqD19hTz2YxNJoQ+Ehf9+JWz9dxz7bHW55tQ5/XElXmPFqB
         UX23XI5NdtSm1Cj3HSmevZGsSS0Gx8JrRE9nVRbMpMx7NVZ4KxF7g8Mg9IM/E/7Q0g2Q
         FurOw3QEeO/SOm4UKiAInEwldCuYRaYIVlAS1FcfdBh8GPixX2EmB2qS5YkJGBLs8c1/
         QiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891918; x=1783496718;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mNbfdeGpySglO1n2A9UDqE8O3DAfIiwtknATq1x2ty8=;
        b=Vclv5BfOzSCCawqvvfiV53fxLslVnomnBTGijVRU9GDH/ASXTniT3a8q+HFnrWtdoo
         uMMAecu0MNOB00gGQJJRhM+GtnqDNPWtCoPfj/J/LLivuVafj68o9Y9OvBO0OagYGWfh
         TtKIp/HV3DpBslQorxLlXJSuWbDtpZwQPuYy3lyOdWicD45B87HwPzLyyoPVfidvg4fm
         SLH0ja8G2XmU+QfJOXioNAUzjkL9Li3r5ChVbw3h5KoNG0YlJNyem0R+dkbQlDsAit99
         QezzdDLZuT4XwVin+YUR07Qf4afTc/Axj2M2LBRRaXvLdatwk9dbTaIathB5RNiL63gW
         M1HA==
X-Gm-Message-State: AOJu0YwDjcfz/k2zM7e+AUAelsLlLoxmgmLrERNZTriMeBGaDWmTy98O
	KnxekimxSNltazrwICfGZ+4ZKVglsX/4VxNfu3nGwZuC8/JdxfXgpRb/Af2qOhQ19DAyyR/sX2J
	T8+9SGuW5FAG8RqMGA0Ri35VKOnjyz/oCW8Z0LokPrg==
X-Gm-Gg: AfdE7ckhRk+FVNfwEqCVoMyKl60fbpRgjtuOLaVUpe5DUXOkfQIBAG2gfis8MpnX7mn
	Kjcq7+n++09/LSQBxS9wFXp6PVgSBJmG841e+QHKj92qCsqRJcx2NyKW1hUBFKujpWNlVnGOam1
	p69r9pvxcIt81bM9cHwqejsr5u/32URKpMo6k/1UuQlwaVS9WsTGVDqmHqT0hTXjU6GkZIR68ll
	hGAqhK3tn37zHq7y0PohssS9qwaBYijB3iHzhiVIz+NggdKW3NZxieHdXXw1vzRfAS47ve6rew=
X-Received: by 2002:a17:907:9489:b0:c12:9133:cacd with SMTP id
 a640c23a62f3a-c12a9d79d6dmr21890166b.19.1782891917958; Wed, 01 Jul 2026
 00:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630150937.3508222-1-paritosh.potukuchi@amd.com> <2001256.1782860341@famine>
In-Reply-To: <2001256.1782860341@famine>
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Date: Wed, 1 Jul 2026 13:15:04 +0530
X-Gm-Features: AVVi8CcGCDQwemYdFLtn4405l9Au0z3khOhnl1PKn8oRCKfUzzL4UDxsSzuqZng
Message-ID: <CAMfiSeb-oebB69+M9pCiBhs5JxtmSrguNJ8UUR3MtB_V42MdDw@mail.gmail.com>
Subject: Re: [RFC net-next] bonding: Retry updating slave MAC after a failure
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paritosh.potukuchi@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jv@jvosburgh.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303524-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35D276EAD19

> I think the proper thing to do is remove this comment block and
make no other changes.

  > This comment dates to sometime before git, when it was common
for network device drivers to lack the ability to change the MAC while
the interface is up.  To the best of my knowledge, that isn't a issue
today.

Sure Jay. That makes sense. Should I go ahead and post a patch
removing this comment?

-Paritosh


On Wed, 1 Jul 2026 at 04:29, Jay Vosburgh <jv@jvosburgh.net> wrote:
>
> Paritosh Potukuchi <paritoshpotukuchi@gmail.com> wrote:
>
> >I came across this TODO in bond_set_mac_address() :
> >
> >        /* TODO: consider downing the slave
> >         * and retry ?
> >         * User should expect communications
> >         * breakage anyway until ARP finish
> >         * updating, so...
> >         */
> >
> >Currently, if the dev_set_mac_address() fails on a slave, we go
> >ahead and unwind the bond and its slaves.
> >
> >As the TODO suggests, one possible solution is to try setting
> >the MAC again, after putting down the interface. This is because some
> >drivers may reject changing the MAC when the device is UP.
> >
> >The solution I am proposing is as follows:
> >
> >dev_set_mac_address on the slave
> >        - If this fails, temporarily stop the slave - ndo_stop
> >                - If stop fails, unwind
> >        - call dev_set_mac_address() on the slave
> >                - If this fails, unwind
> >        - Bring up the slave by calling ndo_open
> >                - If this fails, unwind
> >If dev_set_mac_address on slave passes, we go to the next slave
> >
> >
> >Before working on a patch, I wanted to get feedback on whether
> >this interpretation of the TODO makes sense and whether there
> >are concerns with temporarily stopping and restarting a slave
> >during bond_set_mac_address().
>
>         I think the proper thing to do is remove this comment block and
> make no other changes.
>
>         This comment dates to sometime before git, when it was common
> for network device drivers to lack the ability to change the MAC while
> the interface is up.  To the best of my knowledge, that isn't a issue
> today.
>
>         -J
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

