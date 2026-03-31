Return-Path: <netdev+bounces-273766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQaG9BGzGm+RgYAu9opvQ
	(envelope-from <netdev+bounces-273766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:12:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C299D372569
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E5130177A4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBF45BD6B;
	Tue, 31 Mar 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXgi70GF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD543CECA
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995004; cv=pass; b=B6lu1+DaOmVYJwqtLKalXiU5G0s3bCVOWk3GA+TvVttLqdiALvRh03X9B9yu4Lh42JK03XUHNSC/TC+R8IFhg2rxtJE26lSu5LbU5iKD2SiCMH2CYh2g1vlBbebnzYcS2/ZWrGuCFeu6DIWEjrr9KmNwKE0UBqpKG+tPu4hJ55Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995004; c=relaxed/simple;
	bh=dd/z6ajyuojBoe6LH5YiHMam4R726TRDidQH5DNOycM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6a0XHT19a1V4yls7IzpzFll5UZ6R0PMYY0925xgKLGb7M5Ujy2oDTCiRn5XtzApEOf/n+L8POvp5lkXM4TKUEwaoRFzOSQXAsNpPe0iKwvl0mskHiXkcRv0ruHbs0Gz925E5GBvvGDJpO5I3402EhtMuhlwxaTZcK9RuaAo+6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXgi70GF; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d743d94d5eso952316a34.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 15:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774995002; cv=none;
        d=google.com; s=arc-20240605;
        b=QfdRyUjUyOQv05Nre43yP9rnkYa7kH6MWNcNM159p0WdUE6s/6jQwhO92TBs8BdaVe
         qpZYGhvs//72gHe+29Y7UXPXJrTkRVQEXJtgD9lZXsgLE0yO88sT2fXCXbhPUoTc+AGP
         RWyShE2BShMh+nuZ4uZ5gTQn0cQyQqWTGJgK0I78EsXckqEBe2ubOad0Sl9RVv7o78qN
         ZSB6Bnh8urK4zdHfwF+qCQ6aX4BdbpBVdCmqi1/xCkCpnHXzz0xsrKw7hwBfFd2pcdlI
         3i8zbqSz+HlK027+QWPgjZ7jQ+VACOOH8yrhEQxNCWzqxtS1oAvTpYgmvb+m71P8VjnQ
         8oCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fOyr4lApH+Yi8FAn9EuB2zfM+rDRkdgUXNhTN76lUJ0=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=XAJuS04hhCt53hqmk0SOJawK7LryYyzRgCKxzLzdlKUXMVd57pVuAXoeWHZ45aVW6L
         mJjiB6OR3knrGeGLMr+vFvEefkwJ5KEzebhfX/8KgeI6FM47OBdckkArJ73IRtBOu4uq
         Sx9FgmlZWEug2LF3hqMdMx0P4uuDb+BBT3nCfKtk6j3TyRqW65D4HHZtFvi72Fk+Ih7u
         1EQEVQVqqydClZ/UynYNNW8+adtvN+MKA77CWdXBiHjwDKFq51vOh+y+UDQDGzW9WPiW
         2hYnkoH57I1BINjkhnGYvi9owt9nn+rIb30xJg2Mphe9p7hDfufbeRnsTMyV9e9e4XvK
         Loaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774995002; x=1775599802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOyr4lApH+Yi8FAn9EuB2zfM+rDRkdgUXNhTN76lUJ0=;
        b=mXgi70GFBnq+BLIoW9sxocpgBA6Oj3sO8T+wimc2PiKmqIs8kz1F2l9+mw/j70OEX5
         fk0ZOH5c6cHsRFuKmOWF/h9kdEp1dmJMZ1e13iz1dwUwUiKvQ8fsBJAAE7r9oXhUpI+y
         FVZCQjGwSOA0ocsOQWSkN5r/VYNXQZkgp2n53KMzdl2NKzdSveZbArTNbnuJhN81npDr
         TlbR76/JGd/I/bxwZrIr/pl+EFXf/apYNm0X7LWFNr7iMM9KBJ2WBHcLuNPzkBjuIf7E
         j/WJuWq9HQKkBT0Ex0Yv1B17DhLiR6NF0RXfceVQDfvEMz7Nz2C9UzRcsNK83RbPhyDE
         GKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774995002; x=1775599802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOyr4lApH+Yi8FAn9EuB2zfM+rDRkdgUXNhTN76lUJ0=;
        b=MG1lN9lTiSHGDFibnaMrAIdI7aUDOA5FbVWzZmRM7wixf25hvcJNFfCYYtBwRy2MKf
         bmAxrvn9pPuZUv1oEuB9gBecnEynTuJwZJOJApbaENcGdfsu22SUn0bvRI/EetouOOL9
         p4rImBHFaCJQIKKd5xN31WL5rgH1T1iA0w3be+y85t+6FRccqDx6EmGmhm36TxL1ddcT
         GJ+INp+P5ouAjb1KODAvmIREURaJuWPavrGg68yNXW587QZFD2aafT4/iQGHGfzVgggh
         bXIRs0MbpuFFA8TES48oj/f45zyJpmDJdub5l+oAg/DgGS8HEdRUmrT7P4xpROALJzvI
         Q22Q==
X-Gm-Message-State: AOJu0Yx2NgcU9toMxVgc0+UmcALuwgjvjqQl4+VD5Z3reR0MTMwfd71h
	gssC0ZE1Lh4y5isGTKWJeqwfJSeGAZqN7s4vSI79/ICosNlg5EHcgazDmmZ+wZznBPWjYdOBDAH
	DVFpf9XB+zOSz174vRYhMzCPiYXEY8vw=
X-Gm-Gg: ATEYQzyVBG6qXASKn9V18Lr++4fnaUAO48T7eEEll/CHRomIxX8LpO8oQV5MzSH/Hr4
	rpH2CFJg1YKk5xiis3dn09EseSbHRseivzo0WzG4S1Rw/EBWSbfrOvJFrXr//AsFqXup/DUa+3B
	QKRh+IB1fAvQQUY7Eiccr+q/xcmy7cB8wp9egNRR7W7lZ9/U3m6QuV8MdCx5MF+5k+xQZJ+3ZMa
	alzmKODJ3eVq2nwSZQHH4LvE8b3ZWg6BvhNi/eGB5HppMRXWzRdF8FiEHKEATfZrMBTzR2yXK+U
	x0NLxS8ss2TWC2/p
X-Received: by 2002:a05:6808:2448:b0:467:de9:3ea3 with SMTP id
 5614622812f47-46ae01b8491mr482463b6e.7.1774995002405; Tue, 31 Mar 2026
 15:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-6-weibunny.kernel@gmail.com> <956aefbd-b795-48be-ab73-58f489b1b535@gmail.com>
In-Reply-To: <956aefbd-b795-48be-ab73-58f489b1b535@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 31 Mar 2026 15:09:50 -0700
X-Gm-Features: AQROBzD-pcr6I4oueJdIykQbQ_hihCIb18zd_FL2t3AdqQr3A2Mk5s7ILzbLhpQ
Message-ID: <CAGqc4nUx8et5Snydii=HqRNru8YqWC4XSJxmvLRMdmYGjF=BFw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 5/5] selftest/net: psp: Add test for dev-assoc/disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273766-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C299D372569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 7:04=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
> On 3/30/26 6:31 PM, Wei Wang wrote:
> > +
> > +def _dev_assoc_no_nsid(cfg):
> > +    """ Test dev-assoc and dev-disassoc without nsid attribute """
> > +    _init_psp_dev(cfg, True)
> > +    psp_dev_id =3D cfg.psp_dev_id
> > +
> > +    # Get nk_host's ifindex (in host namespace, same as caller)
> > +    nk_host_dev =3D ip(f"link show dev {cfg._nk_host_ifname}", json=3D=
True)[0]
> > +    nk_host_ifindex =3D nk_host_dev['ifindex']
> > +
> > +    # Associate without nsid - should look up ifindex in caller's netn=
s
> > +    cfg.pspnl.dev_assoc({'id': psp_dev_id, 'ifindex': nk_host_ifindex}=
)
> > +
> > +    # Verify assoc-list contains the device
> > +    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id})
> > +    ksft_true('assoc-list' in dev_info, "No assoc-list after associati=
on")
> > +    found =3D False
> > +    for assoc in dev_info['assoc-list']:
> > +        if assoc['ifindex'] =3D=3D nk_host_ifindex:
> > +            found =3D True
> > +            break
> > +    ksft_true(found, "Associated device not found in assoc-list")
> > +
> > +    # Disassociate without nsid - should also use caller's netns
> > +    cfg.pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_host_ifind=
ex})
> > +
> > +    # Verify assoc-list no longer contains the device
> > +    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id})
> > +    found =3D False
> > +    if 'assoc-list' in dev_info:
> > +        for assoc in dev_info['assoc-list']:
> > +            if assoc['ifindex'] =3D=3D nk_host_ifindex:
> > +                found =3D True
> > +                break
> > +    ksft_true(not found, "Device should not be in assoc-list after dis=
association")
> > +
> > +    del cfg.psp_dev_id
> > +    del cfg.psp_info
> > +
> ...
> > +
> > +@ksft_variants([
> > +    KsftNamedVariant(f"v{v}_ip6", v, "6")
> > +    for v in range(4)
> > +])
> > +def dev_assoc_no_nsid(cfg, version, ipver):
> > +    cfg.require_ipver(ipver)
> > +    _dev_assoc_no_nsid(cfg)
> > +
>
>
> Why do we need ip connectivity for this test? Why are you parameterizing
> over PSP version?

Yea. This test does not need ip connectivity. And no need to test over
multiple PSP versions. Will remove the variants.

>
>

