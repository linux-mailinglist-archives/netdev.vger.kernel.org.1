Return-Path: <netdev+bounces-295724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2CYzB46KImqnZwEAu9opvQ
	(envelope-from <netdev+bounces-295724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB09646715
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:36:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LjT9b6dW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295724-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE2A30CE3BA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B53CAE6B;
	Fri,  5 Jun 2026 08:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770830F803
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:24:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647873; cv=pass; b=Lg4VjJTVG+x5cWQMdPYLek977nlPRW5F//OJQiqZDKMFiKOYfGoGMsgrEPOYbqWjwGe7WZ3PkGLw6NVi6COUEMPiEmKUVU285zqzCJXVQ6ONL0Yky66fOU6nXwQwLzovlsNGXd/UcDF5AEKfLkf2UjM2BotuudLUhdlgOOoOsD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647873; c=relaxed/simple;
	bh=//piZpS4JqLzDTuCDQ4SM8AQklgNjfVxCndwQALTVT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwrPVMvKnXNdzRC8yF6zY503xiHYAJdbNHF+xWH03eqTnZprmWvoQAwVCDEzOIVOPVgAQwdRJrUhIAMOwKPzadO1LjOOub4TTLNoyr/2hx5WWLW2VwyWKrlkFg2T8gg7jCdGiOLQ5P9G/XNtwOkL6+oDNax94EyGQzn/35lGvB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjT9b6dW; arc=pass smtp.client-ip=209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso1682967e87.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647870; cv=none;
        d=google.com; s=arc-20240605;
        b=TjYpmfz33BUr/WPO7zQuaVlwRI5oSrmPOeFJwoUPnRXqwJkB9k2971kJOBzt2YLtiI
         YslJU2SNsHs1zYDcr3CbPgwXgNabXrKC9k4do470U7IxLcQHM48qV42Y9Xzgt+pk5BPY
         psGEtdDTGoFiSi3F0rFp1Dv5YLHgm/MhXX05WYrWF7b8rsjB5f+LKnhw9qBf69mXJ7Xy
         Ai5LwtHkJ7sYI2EMHmmGLzq/xZK+vA720TmN0mA8Sr3H6bF1K0iQv+3gm6dLeswv6rgX
         OEBnPm0cE7BJR38sLKxz2Wd2Z9hWavfQODvwsROEpfnIWitAVlwpvqDlChbt/H+amDoM
         HP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        fh=F4qiCW50zgRIn4OJ7DdxJcEnaGXRJmeZNlvR5BAVl9I=;
        b=hGWwIkmBwoCQmF44qUD7W92ppgTNkyuBcl+yFUl6zkfKv/EPBzod2SPvNmoLwckfLl
         2EOUJ8n/X5wuu8g+PGfvWSt/NG1kppOYXRkv6jgJ0LoQ4EVhxeA5F0uTj5ZuHLMhoriA
         1Xy9B+JNXW5Q+B2PtcwmyExXCh84Oa+lPVUzR8kqk9vjahZ2ddmqiPVOiTRYSMjTIjCC
         FXlxVBtVPknKCh3Mqw1+1YVjpLPd+TcQ0ol3x8L6HJ8tXgesez7DeIfhf2AvqBlMD4tF
         r0fKDFbQFe66KEFFbyertD6/iz4Q8RtGP/gC/UZkV//tEN6JkA3RvdNsF95yaVIzlMj2
         aY+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780647870; x=1781252670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        b=LjT9b6dWMZcIdjz4oeqKvXL0ItMDCzgUaG4MlGlVlDnidXGf2giPipapvKKmNiFoTR
         IQFPpZe8sKs3nq3KAXbsbHSOoM60N0hbx0Q2XZ8le4F/ACwsRwNFmtIsvoH0ehF6bnxd
         YWW8z19sfRWye2MIj8ApauS2VZtQ/nmpNvthcRyXaxKKPRLOfHDYQ7pETFxbOlKBpUgk
         gApWOeBxfds79t+ATzylPFPVTmzZiI6EPrKiHp07Y/f6nWog6pHJbCM2bEkuz3I/0MJN
         nHKJUkBFj6vAtVMqE5BFhcfuVYnf36fDrnCFwP6eV0JoY+2GNpAaRuTL5sfdsXY/75CA
         pgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647870; x=1781252670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RZhurI/q7oJqN3iUeEhWQQThIPk8thOCCIV1vfD+a8=;
        b=OvwHIoDcCdawUTHZCwLMhqK8i5C2rYgVUOD1hCmfNDi+QjHPsDYJYkoGwozSsPSvat
         lXCMc1xab78G0rp+nlnjZ4kXjIyaHMHLbgFu9yB+Rww1GdE/9Q92grfvgYI7hubRS02g
         uyPBTNh5Owy4uVxHvGYu5j/0RCzh8pF9LKiNM5gzpk2Pko8RR1jZFacVAefshn1zzLTq
         1XpF4ywjCX0xeYVl/ExcPZ6ie2c0vIaubUe/7ITiKhZdfOOG4DPXk/t7HFU1BTDByXB7
         rXcphxQ8HEagaLERL/ob5byRwFer6VxK79FZgWu894yj1hwVfanT4B92oW5+peEGwAJ/
         bWLg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xt1SPfqjS1ovnh1hUEfZIBzgk+c9W2Cnkx1zRIdZnOiNnfyvvicEfBvWEmpJGiuck3ptkDBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsv7zfIWjYO0EzNTB4UYbLh60VG80hB0hvO3yuRTQawYGFeDh2
	5rMe1B61HvnBneehAuVTUeHtA/fBxgZ12PU7gJBAEgmLKw5t2fBEL87VUmK2R2lW9LrHPtNJulr
	ffJd6roqNdDEyZYpLl5fzt5xZSnUHrC+L7bighlBRdg==
X-Gm-Gg: Acq92OH/eqtOgqPxi/7xrsbAlwVnCX/kLqjZdgerZZ6eBAz38hl6WCW0rgXV6QJghuG
	j3Vwk0sblr4F8pu5yspy/IQbWwFQdKV1TTCWsmu+/5fznDnQ7K3pvqEDfiNV68puKb2C1J+pTYW
	BRmch+JLeHQVTrFbI33gj31gp5aTraGuiE+gtL3mJnUHhgBc29HGhwLW10Wve+Zu5/yB/kXvOOF
	vst3/R7VMm7chmZ7ry8aQRL2eE/dQ2yaeXw2czCh0B3DNy3/tEVn0d+NMC++WmiNBVZKM+UiN7W
	CXCdDz74ZLgBOKdTNO2z31Lv6aXlu5kaBtxaZCgw+0bGydpSDx4=
X-Received: by 2002:a05:6512:3b10:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa87b4019cmr757909e87.6.1780647870036; Fri, 05 Jun 2026
 01:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
 <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org> <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
In-Reply-To: <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:24:18 +0200
X-Gm-Features: AVVi8CcX_QIeknkz-xXX_HwyABpbbtsK9sCbzxQSWw8Cjcwh7JYr-iUtJ1QO5Nc
Message-ID: <CAAofZF6uW+tE0p2FK+8S=x1OUObhYqK56g3T0u+4oJF-r0Sqvw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Simon Horman <horms@verge.net.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:horms@verge.net.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:email,suse.com:dkim,suse.com:from_mime,suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DB09646715

On Fri, Jun 5, 2026 at 10:21=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 05/06/2026 11:20, Nikolay Aleksandrov wrote:
> > On 05/06/2026 11:16, Marco Crivellari wrote:
> >> Hi,
> >>
> >> On Thu, May 7, 2026 at 3:48=E2=80=AFPM Marco Crivellari
> >> <marco.crivellari@suse.com> wrote:
> >>> [...]
> >>>   net/bridge/br_fdb.c    | 2 +-
> >>>   net/bridge/br_stp.c    | 2 +-
> >>>   net/bridge/br_stp_if.c | 2 +-
> >>>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> Gentle ping.
> >>
> >> Thanks!
> >>
> >
> > Ping about what? The patch is marked as RFC so it is not
> > going to be considered. It already got a reviewed-by one
>
> err, considered to be applied

I haven't resent it without the RFC prefix because many other
maintainers applied the RFC version.

BTW thanks, I hadn't noticed it was already applied!

--=20

Marco Crivellari

SUSE Labs

