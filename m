Return-Path: <netdev+bounces-282612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEgTD5vC8mkjuAEAu9opvQ
	(envelope-from <netdev+bounces-282612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:46:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0949C714
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E6C030151E7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34332D0EE;
	Thu, 30 Apr 2026 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4MUZKEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9F3002A0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517199; cv=pass; b=F9If2D/IgsnoQgpIh5gDXEx8QGHrT5fl9o/OkrLJIDA1/G9Qh5e5lhdaOE95TxTyPPkNKB3DBO75C63vE+9/biJPR+3m9hzXRCtjBtqnUAElLH6LvtiBZc9cf9G39Wt1u7+DbdpRtEFiZJy94H6oFWjYtSw8oomczY+741qpXmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517199; c=relaxed/simple;
	bh=aT11hkKef07wVt5TZXMpjctyPu05lHXAD49tSMD9BFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu6Fq8ZKg18HEp2bTFV3Zfye4tH7AvcBK/O5ZhaTuQphoaeHGuRWPwuFHyjqjBazJFCcHx66Mpj2m92fNbyxrxk304JLUIzTDo3AzO5v9iaeITEFGVMGn+88LNpWnyn1GM/m7zkYrOv0Mhs7MV7KSOy9mrWe0ZXHJCxV2RmDges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4MUZKEu; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ee7ffd738dso147625585a.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777517195; cv=none;
        d=google.com; s=arc-20240605;
        b=CMH7kuhnCuyS/9S9qL2x9dtGQR9UKqX2ejaItV3/DWfsQUhNC6ruQP2G31LqNngGIG
         UUVcJuiB+dliXOC6pylHlxB+AVqo1770ctVyvJTge0mJERq+kqxFvbKaA6FDQXxEpd6y
         vtCwtwfvV6RQY0dpLN5TBlMGvRNJwa+khsfzn6rYZrQIryl5xVnjvGMjX6zjbn0thXHr
         Pt9zjayDNqVh1b/D8M+mBBBeRaQavlR2yegMPmyb/iNoMXu4UCFcSI8TNmN8gkYl+8Uj
         AYXP6M6m/JzTOl86sZIJI+RnGanrBwXwMl4KP/PPpsWmTgPY9GefdbUWq+ElpYa2LPwK
         ASEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eSsA+Kw8J1H0AN7uzgMjjhL2cMAl5C4DIDhT6f092dg=;
        fh=g1WZQvXdr6C6NhCXS5xCN7jDF/l7Ye+0nF9MI3SMpF4=;
        b=RghWKC8GRapuhtPBph3KLJrUZt17EkauRgWJxVmMbHScBrwFqfGm86zRktF+hB7P4n
         KGhVwfac06zl6sODUPGtEdCVLp+ke4VZwhcq/QRI7z9t30uslZaQd38XyfmLVe4nhkiO
         DX0ZfDouN1+Pg7X3Evff7SB+TkrYlov2J2SAHoAhT/C6iKZG4mIU3llxFLif+x9mk3zc
         6xlTkgH6d0zJg+AvvYdr5NLtxFQQJecnQezo/Pp9fwZQPj3DbBwwigmOvE7ppMhwRipu
         k7/9QnkjOLpT6hd8F8VPY9XIALtnDIUDfnqriw1XOgSPAmBcU6F+hIGiICSHf+tEq6WW
         X5Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777517195; x=1778121995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSsA+Kw8J1H0AN7uzgMjjhL2cMAl5C4DIDhT6f092dg=;
        b=d4MUZKEuWVjYak/nY3toeGapT3AruxjY+iP/uu7qUs1RkzF1bv2Rt27gf9zam/UL1g
         ayUO85u1QcT6WuMn0QNzLuuJyEhBbJbaxOYdrdnKmyyjVeDl/hiL87N3NKnb/nlcp2H6
         9b2nGgcOlQGz/UFblbuq28mOZBPWPIwtWfj8t3D5kdZB1I3S7h8seCERZzkOwzyTVptc
         exkj6A2Neeew4DQ36/UBO+Ore0tYRvpiIhYSgca+Wfwgv/OYXzBZzj8vvJiNxoNYuWf5
         OmPbl0zO9hh6gHpRyUjtIKJwtYLpbUHcnvl3NdrhhaHns/9dc06BaIADqJ5vvoZSIF2n
         iaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777517195; x=1778121995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSsA+Kw8J1H0AN7uzgMjjhL2cMAl5C4DIDhT6f092dg=;
        b=Wlq5PH3n6QEpCPWg45XYAsPc68oXY3yLNYctqjWUzdCX5+FDtWrk+0KLdYsEkeHTyn
         Nmcx/WEvTzkB0uQzWCzWW8MLLx/r5gG23rrvFGZd45aNQeViITvuW2ZZI1ydBKVCYbXg
         lXJ/DgGy4TSvEjf422yV7Vlr2rQTlQaEETp5IT2MUT3ku72pG4ysBUgjkZh3dfeLxGUX
         q0KGlrTlF3PUY1eHCHtBCMETzLB0U8d2h8N8psabRpQLFgc5OWFrUMbbKaGlJUIyKnLM
         Z4y8h0754FTfCrSzX7peGXOlcb6I29MZASRSlDZj4m6EQ/4SnSUIMmdl1OEs1p1mFwTr
         oxoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JGPtbIbRVUDSsrOlELyDhVgYVlu/mykBR8+EtnAT+EaIGk7AsIj7GcPTpmqIg7C/Hg6aQmd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpydoVUpxOwntlZs+fjIX2jqTbp19V/EtkXC8HVCqJg+Mn8sD
	DhkvwGvqevswTEkO9fueu9ptw9glJKscnOxgXROJOzM4qdWZUuTfx2n9m4OVHn9tLwAEjBBzEXn
	wZsAU5hN8zq2Ph19jfRTcV2uzM+wHEgE52qD+HEqS
X-Gm-Gg: AeBDietr1G7lqODmWZpf61jMoWTCaLaud4bf52gjCBiNctN3Ai4VXOZUYFlZABlccXh
	YJlgEqvEq+osZg7HE5cbSdPgi8ELK1c89byMNVM5z7iWIyfYubfPoFr+NJqxjPAtHb7BDmV627z
	FXc7335IyQHZ9PSOK/1bqL0wR+5Kx2JARADjGRYv9IYrWABfqnf9dm55uDJeKZjZr2moybdT8Vu
	L0l652/Wa8H23uWdHch0kgpCeMAIL6SrHL7O+L0e+2XUBiH4uopmXZ3rY0qEktSuxgcRQiVbm0t
	++oqesC6R90I1yu0OgnQO8FWc0Hdq/Fh4aTDlObpacw965y1kECJWyfJFYbCVk5FIA+Z2v0a7qu
	K0oAiigY=
X-Received: by 2002:a05:622a:514:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-5102d0d3e87mr7791921cf.11.1777517195076; Wed, 29 Apr 2026
 19:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 19:46:23 -0700
X-Gm-Features: AVHnY4Lwl01Xyj2g07tpoheIVw1AqnWlO4eliacZgKmPEOyIUAmGUIaTS9ZoNBs
Message-ID: <CANn89iJHUEio=hZPkKuh7MZLxQuU1h4RLyB4c6nkWGNifevexg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] netns: optionally inherit IPv4 TCP
 sysctls from old net
To: nmreadelf <kong414@outlook.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, horms@kernel.org, chia-yu.chang@nokia-bell-labs.com, 
	idosch@nvidia.com, ij@kernel.org, brauner@kernel.org, jack@suse.cz, 
	kuniyu@google.com, jlayton@kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lance.yang@linux.dev, 
	leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 96E0949C714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-282612-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 6:30=E2=80=AFPM nmreadelf <kong414@outlook.com> wro=
te:
>
> a new network namespace starts with built-in TCP defaults.
> In container-heavy setups, operators often tune TCP sysctls in init_net a=
nd then
> need to re-apply the same values for each new netns.
>

There is a mistake here.  init_net is not the same as parent_net (or
old_net in your patches)

unshare -n  # Parent netns might be init_net
unshare -n  # Parent netns is not init_net
...


> This series adds an opt-in mechanism to initialize per-netns IPv4 TCP sys=
ctl
> settings from init_net at netns creation time.
>
> Behavior:
>
> Default is unchanged.
> When net.ipv4.netns_inherit_tcp_sysctls=3D1, new netns inherit
> TCP sysctl from old_net.
>
> nmreadelf (3):
>   ipv4: netns: group copyable TCP sysctls in netns_ipv4
>   net: ipv4: add netns_inherit_tcp_sysctls sysctl
>   tcp: netns: optionally inherit IPv4 TCP sysctls from parent netns
>
>  .../net_cachelines/netns_ipv4_sysctl.rst      | 25 +++----
>  include/net/netns/ipv4.h                      | 33 +++++----
>  net/core/net_namespace.c                      | 72 +++++++++++++++++++
>  net/ipv4/sysctl_net_ipv4.c                    |  9 +++
>  4 files changed, 114 insertions(+), 25 deletions(-)
>
> --
> 2.47.3
>

