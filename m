Return-Path: <netdev+bounces-254829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GRAEmF5e2nWEwIAu9opvQ
	(envelope-from <netdev+bounces-254829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED4B1568
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9712E3007E13
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524F3002A5;
	Thu, 29 Jan 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9DH9WV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D31BBBFC
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699608; cv=pass; b=fVfbh3T/pGW5dGWL+wkd6WNMc//5ZQtAQw9Mkc9gzlNlEGdTobhWtn9E9xiK+ZbpjrKPCNVMd2LiSJjYSXJpl550JBGRCsVgv4ZfOuiQIgn+puDBPCB5T9faBW4lXS/TFeKshbMedZZs2eiItwOVNJ6o35/fVjspAWq7y43E5uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699608; c=relaxed/simple;
	bh=6nI/4cno/Ox5Kf2rYuxNEhwElQwT1lpHaQpPDRP3xEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb9AeK0SXnNvGWNT6k7SderOMRrvkDrI6NHQku878ROHvHVAhwQ+E33DSTeyRcWxm9MAZpECI3CkX0S1yJzcAv4yD3cwTkov/qIqPUUPfxE+NCKGe/RKYT/KwRL48TuHnPNjqAdEMtJ4ehTGgsXQr61IlnxGh1RUbsz2qo2W4Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9DH9WV1; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79088484065so9691647b3.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:13:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699606; cv=none;
        d=google.com; s=arc-20240605;
        b=Akp4Jz59BjXpjfKrEvt209rMith+pJQ49GL+Zoeiuy4J1x7vFh4FvM0F5QkhQP0Zth
         QqcWDTvn8SRoo72+3kvHUP7ftaLnGhYq/w/LfO4ULKYzuNDA/tn9CvbDyHQGbK90HI7b
         EgqpxdpQJBbQg016hq6yL4xtM8MiUFN76vFg2USwnzk2EiAeoWCoLPAY3sw6GWZKL8nl
         MtiyYj527OOFtK0N1Rzv7Vq79eTqyYdHrIOiQGX/46ggQQsoa/jbpoh7WygzSUtG8dtW
         yhx8tOOlrfcxV23pmfB+OYN1QOSqtjUGMQoRy0WIEVd7Gjd0xOza6WQcQY4DGh5KfmLQ
         cY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RLQERTdb05wedLUFRRmJ/cz5RnX6lW0lIzp3k35GCk=;
        fh=uiaNYJ4YKPOb2lFWip463nNNKY1RayT76tZO6yZQt2k=;
        b=UD9+iRxWmmbuyRbdFdFicqzY27GNteFqRpQnaTFtF5A2Mgjb0vZTG8SdaOFR1X6DlQ
         9ECrsi41dGQNsY/e+G5PJzi7JgKXvL4OnHkYv5fQJ+j80Vt5TCaIzj9BeWMQnJbskNls
         bma0c46oKVZUkE4NV862XJYtQTLB2oyx9S8m44iq7j19522IBBQonjZZHouuAF3rU3Hr
         9/oLs7DqYoF8aBbPO5pwQiDcnL5ErGXiSi4QwdeFJ1crR7LnUXAWYsYhT26NTE/DHDcK
         1f8v7UuzDyTOYd+MA9aoQENee8uxldbwUsxLZanStZOF4wNTs25+IZZT5Gj73JLSYoyr
         LauQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769699606; x=1770304406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RLQERTdb05wedLUFRRmJ/cz5RnX6lW0lIzp3k35GCk=;
        b=G9DH9WV1EjALtvujPh8STWEGGnZxNRCmGIPnBv/wuoDwUsCn1DKurdh5pvf8VN1Jv0
         VBEunxaVHdIz8fK+TfblBlRdqmU3wGFlIIa+ZRUTc8ssfLuKg7t07OEtdsPULrAfK1WN
         sGxL9KvxIX1DMKQZXXKeaD5fA2wYWPTvn67s4/Qsjhw+I0DQ0JLdI7taEStc9bytcc+d
         h+GgqKwCpdygDExVd5KWcGCdODAjDDnPVHhj0pnf58wAUn+Lu6i4w6yWvqoRcRbfnP//
         R91mGR6eV6QLWXrma24gyba41KZOYwG+M4fSvJMwYMl7O0qYkpCGyF1fhGyqG9U2FtJi
         zgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699606; x=1770304406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RLQERTdb05wedLUFRRmJ/cz5RnX6lW0lIzp3k35GCk=;
        b=WDfPe6TVtZG+AFYvzgPvzQuG7OSDzwVfrvzKZ2Y0XmfjSXmxubPxu99a/xzlM09Lye
         Kt1uY4Jmc9xTs4mitDoBKpFzMXUhOab7KkIcHEP7bDL4ZVn6Ufh9Rl+0e4BVI9iAmR/I
         hUNJbvWWFZYXTHVQ4RWtxq+0F5xQrR+gcAu8Bypkply2bO//hxfVVXkKcLq3TpWsxkWU
         Xo1xzMvx8D5OpN6TzWerLO1BB5vs67NfmEzWrCcAD2PQM+ns1Id6AE+LNpaAW6sbE+PJ
         Lyt3VpKS+NO0xIJU1SQkHvc0Z/nbtf4dpkVJeJK8dWDLkIf6P82uPlxfHe+7Z0dd6ER8
         sG+A==
X-Forwarded-Encrypted: i=1; AJvYcCVwGqYCBH+DOL2aPI34CnGcUFwgvp/CbLfqwOCiY1xX3/bzqQgNQtpyDrO2JHbgzVGhDXh5/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIvQ76D8/n67I6yKgJwbPyPx98nYHIFf0xFvfv73ZKdcmLRCE
	3h5O6zAKtgOxeQG+BfYJGlLy9MhMXf5DqHj+ME6RVmBXAmsVfv0dPCXmtD+59iLsc3jVcMEKbE8
	4qeewPSUk7LImAAaQPB7DK8dkyo4sAimTnae+352P
X-Gm-Gg: AZuq6aJRtAyDtXo1/SxrgpSA5eeaMR1NtZrqdaL/TdbAEnwLrqBFvl2kFcXiItAS4YX
	UmBOVTzijRZgwkO64QqHxNyNDsW5l+UkIVUsyaKHiqDrl/vA9vB+8GTt9DcjLBIR2ixaL80rHKS
	bDwVv8CG2Su4pVdjZHsxkm7+jUyQUlEYHAaMqrpcHJPIkMimwq7gMoIPXiw1UClqG9j+F6ABubP
	xw26nz1MAmmiHVCnYpt1zqB6QA3E/HgnWWX0eYExqXKr1xgju87cigRI+fyU6iXO7sjw9Y/XI7+
	R0yxaeQ=
X-Received: by 2002:a05:690c:312:b0:794:647:6719 with SMTP id
 00721157ae682-7947ac4b97dmr163532397b3.50.1769699605380; Thu, 29 Jan 2026
 07:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+UsejDXBJv-SqPJTCb-jO7p_+28zVLOOxvHoyV2MKwCQ@mail.gmail.com>
 <20260129150457.ob6le4lb2v6j7mqf@skbuf>
In-Reply-To: <20260129150457.ob6le4lb2v6j7mqf@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Jan 2026 16:13:14 +0100
X-Gm-Features: AZwV_QgL1erQXX1syyECIMq7gpsMdrhuCD6WEK4fumn5DTXFkf-9xxU3wQt9gOE
Message-ID: <CANn89iLQeLPegmtqJ09vFs0QVAqFaf5Hy3P7agfqU0tvCXBsOw@mail.gmail.com>
Subject: Re: [BUG dsa] lack of barriers in netdev_uses_dsa()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254829-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ABED4B1568
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 4:05=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hi Eric,
>
> On Thu, Jan 29, 2026 at 02:16:56PM +0100, Eric Dumazet wrote:
> > Hi dsa experts
> >
> > It seems netdev_uses_dsa() does not have any barrier.
> >
> > A compiler could read dev->dsa_ptr and get a NULL the second time.
> >
> > include/net/dsa.h:1336:static inline bool netdev_uses_dsa(const struct
> > net_device *dev)
> > include/net/dsa.h-1337-{
> > include/net/dsa.h-1338-#if IS_ENABLED(CONFIG_NET_DSA)
> > include/net/dsa.h-1339- return dev->dsa_ptr && dev->dsa_ptr->rcv;
> > include/net/dsa.h-1340-#endif
> > include/net/dsa.h-1341- return false;
> > include/net/dsa.h-1342-}
> >
> > I was looking at this because I wanted to inline eth_type_trans().
> >
> > Note the wmb() in dsa_conduit_teardown(), which is not good enough.
> >
> > Any suggestions?
> >
> > Ideally, it would be nice if netdev_uses_dsa() could test a single bit
> > in "struct net_device",
> > without a dereference of dsa_ptr.
> >
> > Thanks.
>
> It's been like this for a really long time.
>
> Alexander Sverdlin had a patch to convert dev->dsa_ptr to RCU/RTNL
> protection, but his problem ended up being solved in a simpler way:
> https://lore.kernel.org/netdev/20240910130321.337154-1-alexander.sverdlin=
@siemens.com/
>
> I also started working a while ago on some patches to gradually replace
> netdev_uses_dsa() with one of
> netdev_uses_dsa_rcu()
> netdev_uses_dsa_rcu_bh()
> netdev_uses_dsa_rtnl()
> https://github.com/vladimiroltean/linux/blob/dsa-rcu-rtnl-my-try-v1/inclu=
de/net/dsa.h#L1360
>
> but I didn't submit anything and I almost forgot about that patch set.
>
> How urgent is this?

This is not urgent, thank you for the quick answer.

Although using rcu from  eth_type_trans() seems overkill (on builds
where rcu_read_lock() and rcu_read_unlock() are not NOP)

If ETH_P_XDSA is returned from eth_type_trans(), another rcu and
rcu_dereference() will be needed later.

