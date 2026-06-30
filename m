Return-Path: <netdev+bounces-303297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sQ+DN8TuQ2oFlwoAu9opvQ
	(envelope-from <netdev+bounces-303297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD96E672C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=P7mTi9Zy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303297-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B3C301DCCC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AC478875;
	Tue, 30 Jun 2026 16:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94703E3D96
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:24:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836648; cv=pass; b=dJ6GqkC7cLLfHBgibXOhlO8d5ZY0ydM8qMNy2RNaRIoDnfYyxJhfg/be/rGx5tuPE4eWSK08v7hOWc2wvVFzNUq5C/hAuNEi4T2MlkdjSjCwtaDTp6lPPi48wVobZHZU5eVmLLJqSk1YHkGl4NDlA4O5Vwb258ZKloWksfdGHT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836648; c=relaxed/simple;
	bh=FSGgdSi0nGmUA5A3/9tv+BeLzD127JNG30JyrlcNsT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQNdA/NPEVWTB18diROHrta97nlASn4qL9v/pknyrUPAT5B7vaBlA4ytfgbOxYhoibbRwI3SRBtGw24F97yj6VwlzzD/25RG/f4oVVl3jEqn9Wfgfoh/mtqMmFXwKcmX21XX+JLG0yZ1tGSrB3BJB63zkC4ETO+30v+8XL8J9xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7mTi9Zy; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13b2d7dc8d1so1376306c88.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782836646; cv=none;
        d=google.com; s=arc-20260327;
        b=Of+EchtSS7hFjJSRf1MS5xTQqWLMVIzID58pbV8jwO2W0cSUVogKnBw7oUTjqQKEwc
         LII1cnFTlCv38ANFrmhf96lvZGimrMihCNo1qkmtg3pHOsGcYGQdO5jlUyhDoI+WV0f5
         W6xEC9vyfLToxcBkuutpB/WlBHTgxlISWF5fd1LtdOakirvOkHsdXisEziqWsE5959JG
         +giOfXeaYAjregjQ2/pMaJQrk+lE8hfbyy/+8lV4+PLf964T6dJBZeLs7G4ZhTwfpyd8
         UDa3APatDYaZ6HVilMP9IzJt20rTXNYmfQ22TcxMxD+KMtVtg3oq9POLrQEbhmOK3CFN
         l3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        fh=Lx2H2EHojw9lTznErkIPSGBNy9CezoCRrwzj2+zqx3M=;
        b=GkuG1Wf3M3Lhd98XrpdI2e6I3pb3a4mWni7DXoxMfidhPxZmyv/0cpcWPzIpF3Kn8v
         jV2/HERNytFNj9ujTjdQPde0i4xZswk5KHyWWl1RjhhqpFT2VWrA43O5J8QvoXPviVm+
         dfVtszNJ7bUGABuiaPkoBcOPtiMnekSk7oTn3n4miJ6CLpPrgvrVCi8YfHz7OuFhSGhM
         hSOV7RK+vIGZVMcdWxcTNBqXpIrPAw2pwSjom9w8WPYg3CNFW+MuLWiTgf6ozbUFeI2u
         M0iLh2mRkuSvgOl2jWXc+PH6iCvpIL1NKsXHsAgJwdB0X/HybcyjtZVlLrkdidrSiED9
         wvgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782836646; x=1783441446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        b=P7mTi9Zyl6+yfYPFMlvsYAZjMuvx+EJkMWAQI6WrSAI3P44/zTjCbszVGAEF3hzc9e
         lPh4WU3j05VhpEi3kbDmDI5g5raFRVxRPiMBm67mWFIQvR9KxrTx2IkQyIE1cgP6txzD
         TTda/VYdeN+FgyRPMzJdsSSMKKY1xavKX8zQxP6pWG2gXhfOKYnOsf1siIsxIQokWcPR
         j6PHRXJcCT816VwWch/VAsbgT2t2q2LDmshdgw78yRVXS+2MhwM5D87dikVxxxHrs3VY
         Uuq9DcVzneucQV4O0IKraj1sAP5VjlG6OmhF5JWaj9se3ny4hbTITwQIaziqJ8F+ndTk
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836646; x=1783441446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GM+dTTSKLoTXlWRUSA7edb0GWK7rzbACYvRC3T4yKNk=;
        b=Y0HPvJdsI2ZNguC/Ti4f1pfHWO+vEha6rLzBvdhJrg2/f7jz3KVFkMSPikOe4bAMXp
         iQnjaMkEs6tiTlO3EE6g0ENyH7BG1V8gQN1SsO1DyRH6JfZPsMuEjcaUDQH3sf1outW7
         qg49eRgEVuDCs3svQpdlPVDFDTr2V08WXz1UfqJ446WRbyUCAIMp/kXxImV+Jw0OTKlL
         JYrKJGXJO37EA7IDfh3+5Nnrb8SQpo+0Z+a9hLKDQx8iE7tYa4cKZFuZUd7qoZE2LtY2
         5pgz2GPpqywLwSO64mgvGAhSlXgqVVup9LEPC15y/QXSEUxJRcdzQOBuOZt0RGEbNMOm
         gn1g==
X-Forwarded-Encrypted: i=1; AFNElJ96jWS0q4tAVY3jPHopdMs5f8vh0WriYgErH3U6pSErY8iwFNtdqZ2pu9u6q8HTYVvcxgModzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/hx6LHuqKBG48h8q5+Cs237Q58UwZdWE2ByByIZrfGa78DDP
	uCVc7aa0z1P7rcYAe9u9lWhpSSK8AyrfR0/TWU1aSPnzw6i4xOt1bJ3c/+GxPNZc9a0yB0SyD0v
	b/0gujqN3XiZNf17OgG1IoB7YuaAD8ucyT1v1/SWn
X-Gm-Gg: AfdE7cnmg8TI6V7F93dtlJvFousdY0M5Vv4trEsBU5TosSq9YiscADJ3Zs7/fwfhHoz
	NLL9+ZGzOvOwAMuXojO/1rpss/wg73NGtgKsduI8JJZQUYnji5aV1i4I2t6988RAjb1ZOboqTgx
	s3i+Qd4aPXiNcaqy9s0WxwMnhaxL8uET3r/OadaBjq+KkpbhjKpYemSviLV8UP05thqPkxPaaML
	V5EMUzLVpmUKP8/yrdV7UQXg3HERjwf1ZLvzqCqLtDayluM/P0GlGWfumQFxeNK2poX8G6ZnyKL
	oCOKirkZDS4pvsxQCuGv0oZu1uA70YVNxGat+5VrAJskiTv2dMtJaqA0YotP6nNmbSjgIP+cYwM
	wozqatylJaBFrzgbAdYOM36fBjBT/hLEMsq2Oxw==
X-Received: by 2002:a05:7022:6192:b0:138:4f8f:e2f3 with SMTP id
 a92af1059eb24-13b2a1ac4f7mr3103245c88.32.1782836645150; Tue, 30 Jun 2026
 09:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org> <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
In-Reply-To: <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:23:53 -0700
X-Gm-Features: AVVi8CcZ9CVHSUJiGG-FPzfXUKqW9ybqtqzrGjbGkhBXBvz6rHYirwPIu6CdUNI
Message-ID: <CAAVpQUDn5Pt1TwfEs=-Uy4Khr=+r43AMCzTw2si_49e0oDAb5g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jakub Kicinski <kuba@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:kuba@kernel.org,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303297-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,xs4all.nl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39AD96E672C

On Tue, Jun 30, 2026 at 7:35=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 30-06-2026 16:17 CEST schreef Jakub Kicinski <kuba@kernel.org>:
> >
> >
> > On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> > > The test uses the following Smack labels:
> > >
> > >    "Sender"   - label for the sending process
> > >    "Receiver" - label for the receiving process
> > >    "SecretX"   - labels for the files being passed
> >
> > Not sure this test belongs in net/
> > 99.9% of people running this test do not use Smack.
> > At the very least you need to use XFAIL instead of SKIP
> > we use skip for problems with the env which are fixable,
> > like a command missing.
>
> Ah, right, because you can only use one of these LSMs at a time?
> I mean one of AppArmour, SELinux, Smack, TOMOYO.
>
> I just need some LSM to trigger the reject of security_file_receive()
> and Smack was the easiest to get going. The series is totally agnostic
> to the used LSM. I am fine with moving the tests elsewhere or porting
> them to SELinux if that is really necessary. We could also drop them
> altogether.
>
> What do you propose?

Maybe tools/testing/selftests/lsm ?

