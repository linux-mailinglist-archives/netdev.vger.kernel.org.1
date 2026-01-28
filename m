Return-Path: <netdev+bounces-254148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFIcDSvMeWmOzgEAu9opvQ
	(envelope-from <netdev+bounces-254148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:43:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1659E4EB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A6C3008D08
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C332D0D3;
	Wed, 28 Jan 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdTROMJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A12BB13
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589800; cv=pass; b=q3u5gXcexDfFaP6zJg45awHxmjXICs9CtUEdVv6sURFPIe2iJwA3RBveYDIk+j5+arEpnxSRFi0DMh3tfS/O9vKOrcKxJ09QiBKNdw8v7aVPMTNszyxySPKBNy5D9C7TX8nBJkSk4j31f6CkpHsaWxzxygZgKXuao5DkD2WzVNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589800; c=relaxed/simple;
	bh=qpPYMb16VdCUv92aapQrddLwsi0jTlbxU1hx8criwPM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OYFZ4YsjpKB1bL5CPYhAgmffjec+e/kNHcSrMrRi0AAQWYQKEfFqRQm2z8gAWgwPpZ0LnZM+fRQ7jlkCiG4/15vixFPm6T0qkEJ+oktpsgHvqdhmqilM/8hFgf4XgsxmDXnktc0aPPBsu1qPacoa62gGdIfDeW0+DhXKCjCte38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdTROMJ4; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50299648ae9so288111cf.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 00:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769589798; cv=none;
        d=google.com; s=arc-20240605;
        b=YQV1M0TGVZ9GP+piysYK0kx+ahNcJUMahAmCGpJcMWtWa+2sJQtYBDBrr0tvANCNCP
         82hdPHiZr6ESnWoDbDN7qnBpbbMCIH+3TFI1abooFYMd3R8YyuHyrzt2OFeRl+Z4zund
         XUA2IsBx2U64mzu4bRXMLEzC0G/b8EBzIczQng6757VRa5YKfLEEGMo/APTDOjXJoFP0
         TDh6wETnJ1wZNL0o4BoTiApqet3bi9VLJTHEUZQgauPX6KxsFz0l47dNh/+Y4YPuCpew
         3jiMY4a8jFg2ZKFUF8MlES7yzXbQbHgFXfh3NPa6UWxK533XPhL+vYJomnMlVpnkzOS5
         67tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=LFoeBbAgdVTZxH8eTqVhKR5q6RrTMpobaw0FVj77xqA=;
        fh=gC5ce42drpgO9R62PgECEBhoTAJZVLQhFz5WcV0oH6U=;
        b=BFVWCqlopP6dEo5jYr+8wgp0xAfiiAqGYvpUQBDArGKg5CEygM1YwW2JtVskm5W6nV
         eABC7Dz15VOoMU7tMER9dO1CGSaALS/bPzOvyY2YqN2ruye0UnSg/NX+hxDmuRRHBk1w
         lrWlnIR0evYCETZdDIjeuka8nvqhpRzVu0V6b6EzxamdeDFSgbkcE81Q6DXWDQRaKoVv
         0otmV/2j+2iq3c6vzuL8zd18mWe+10aWteugZr0y3QOHpEFVyJYRm8SFEs+XZhSDkxa4
         bo+nxxOCtZs/iSGrNx2LF3YLN2Xgi5fVRemeDRxwmReflOgD3T1DbQdPJw7505Nv7Km9
         IsNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769589798; x=1770194598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFoeBbAgdVTZxH8eTqVhKR5q6RrTMpobaw0FVj77xqA=;
        b=NdTROMJ448U6OvcPnvEUEJW6G0g0X4v7HOtjZz03HDUY+GSFootkKvjraBfalbXIyz
         g0b65UPGcEPiL8WYyGP7ooRW9bldEF3pmmxDYNc80CXHR0i43hftXePyraNfN6550fN8
         SeyNd/xz25zxiHiO7qcDfdFMe7Ukq6XuRB+iMz96g3L2/c9zI04arrmO76jTvhAtn26C
         XFzQQhUcpFHMGCvTxjnZFYjxkuN4mMTvdZ+xzJmCUNPxZn0tPe8V6ZGfNZJwWOS+x+7X
         QSx64RXfUmfzXrD8SgNhLKUz/79AKk5At1fURY5Mh7W3+XYTPjcMuhJCS7+mGhYEDvD/
         877w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589798; x=1770194598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFoeBbAgdVTZxH8eTqVhKR5q6RrTMpobaw0FVj77xqA=;
        b=ZnRRkGGRM9WLAu8R/zt+eeIYypyvSZfAseN4YsGrSSCMDnLCcX2O2m9JS206mF2o/w
         XLqbw9uS7n3GO3ciR+kGyb1zCPYHAzy531ERirVoNNz9P2+KHg4spbKoW/+EPSwJXh7T
         mdu2/6+NreL1mJJR+wLqeH8oq6CwWANAAF6s4fM4ukqoenFJpFJDh8qdn6Z7XMZNbNL3
         hRAnqPPfhLQzj3vSrDO8IkzLw5OpoGoVli6aI3aPYaCSYIJ1OVicWRv/kkzc9xXDGoMg
         JsnmGlueuCv+iEbspkSLxcL7R0zt35UTVkXgxNwDD4s8lBuhaN2I+gN5HYIRnZ71gLqU
         33pg==
X-Gm-Message-State: AOJu0YxOo9tvy6wgoGQhCUnnD/stI9/f97SBeTclUI5fCh2AIM63W7lD
	43Zv7J3no1xcue59YEa4xkUV+dT22M9H8u3dPEo/GxielnGXzZPy5dFUvuvMspTI8N/RoEB8SOJ
	BDvuUAZLYZRX8yjPtLae+oK7iVHq8rvkLvWmX0hObE63idmvc87HOeBoU60nNACmm
X-Gm-Gg: AZuq6aLkOkqI27757WCaFFpY1hz57uI9oAjh99PRxmv59adOiCQaMboTlBpzoVkZV00
	VJNB4X7/5liRlOVVWjLgj6KUOvoA5GXs/xOXpOrSIR3s6iqy6ELwzvsWnStFWlnC3vUw6TCO3+a
	FCQTeTBE6McOFHXqJkEkxqywED6DuoKBkgt179RDTcYKSFjsv6X7q/ecs3e0qTVCYZ4W7TO09e7
	Tc4JqqVU4gel58pbXEApd0AeCeIQCF1yB15lbiL52u6oOdkZlq0zSaeoO7fnVxFkBT1mRYdbMpv
	NGHDoYD4/+vwK0MolA==
X-Received: by 2002:ac8:5e52:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-5032f44cd01mr4496291cf.3.1769589798070; Wed, 28 Jan 2026
 00:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yan Yan <evitayan@google.com>
Date: Wed, 28 Jan 2026 16:43:06 +0800
X-Gm-Features: AZwV_Qh4qrYofudHvr0LtebolcUCHL3GrShnYCNvJvSkQDsgLSNXvemKifzvjtA
Message-ID: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
Subject: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	antony.antony@secunet.com, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	horms@kernel.org, saakashkumar@marvell.com, akamluddin@marvell.com, 
	Nathan Harold <nharold@google.com>, greg@kroah.com
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254148-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC1659E4EB
X-Rspamd-Action: no action

Hi all,

I am writing because unfortunately commit: 94f39804d891 ("xfrm:
Duplicate SPI Handling") has caused a regression in the Android OS, so
we would like to gain some context to help determine next steps. The
issue is caused by the new requirement for global SPI uniqueness
during allocation. Based on our review of RFC 4301 and the previous
review history, we would like to highlight a few concerns:

1. Regression on Android:
This change breaks production behavior in Android, which uses
XFRM_MSG_ALLOCSPI to create larval SAs for both directions. Since RFC
4301 allows duplicate outbound SPIs, and larval SAs are often created
before direction or selectors are finalized, the allocator must remain
permissive (at least in our current design).
This also aligns with a concern Herbert Xu raised during the initial
review regarding compatibility:
>    "It's also dangerous to unilaterally do this since existing deployment=
s
>    could rely on the old behaviour. You'd need to add a toggle for
>    compatibility."

2. Inbound SPI uniqueness should not be a hard requirement:
The justification for enforcing global SPI uniqueness often cites the
statement in RFC 4301, Section 4.1, that for unicast traffic, the SPI
"by itself suffices to specify an SA." However, we don=E2=80=99t think this
means inbound SPI uniqueness is a hard requirement because of the two
following reasons:

=E2=80=93 Another statement implies that SPI uniqueness is just an
implementation choice:
>    "Each entry in the SA Database (SAD) MUST
>    indicate whether the SA lookup makes use of the destination IP address=
, or the
>    destination and source IP addresses, in addition to the SPI."

=E2=80=93 There is a "Longest Match" mandate which makes SPI uniqueness unn=
ecessary:
>    "For each inbound, IPsec-protected packet, an implementation MUST
>    conduct its search of the SAD such that it finds the entry that
>    matches the 'longest' SA identifier. In this context, if two or more
>    SAD entries match based on the SPI value, then the entry that also
>    matches based on destination address... is the 'longest' match."

3. Further clarification on the specific problem being addressed would
be helpful. The "real-world" problem this commit intends to fix
remains unclear. The patch mentions:
>    "This behavior causes inconsistencies during SPI lookups for inbound p=
ackets.
>    Since the lookup may return an arbitrary SA among those with the same =
SPI,
>    packet processing can fail, resulting in packet drops."

However, Linux kernel lookups using the triplet (SPI, Protocol, Daddr)
are deterministic. The lookup will not return an "arbitrary" SA
because the destination address is used to disambiguate the state.

As Antony suggested, this change may cater to SPI-only hardware
indexing. If that is the case, we are concerned about applying such
hardware-specific limits to the software stack, especially if the
behavior is not opt-in, as it appears to require an overly-narrow
reading of the RFC 4301.

Given these concerns, would it be possible to discuss a revert or,
alternatively, could further context be provided regarding the
specific real-world problem this commit was intended to address? Once
the underlying issue is clearly defined, we can work together to find
a backward-compatible solution that satisfies all requirements.

Review threads are attached for easy reference:
https://lore.kernel.org/netdev/aDQhZ_ikHEt_pLn_@gondor.apana.org.au/T/#r45c=
1786651ce5af730f757aca7438474d494a323
https://lore.kernel.org/netdev/20250616100621.837472-1-saakashkumar@marvell=
.com/T/#u

Best regards,

Yan (on behalf of the Android IPsec team)

