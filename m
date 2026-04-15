Return-Path: <netdev+bounces-278827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/MCYqx32lCXwAAu9opvQ
	(envelope-from <netdev+bounces-278827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4740605A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DA4B312DF31
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C53DD52C;
	Wed, 15 Apr 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh3vE5Ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E042F4A0C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267090; cv=pass; b=eoTpW+t0VScXJkVMJYUXHcKs1/qA6JUdKrOLZFc4ketTyQVWmLJ3MQoaTxU9hm/7Y396RnvDrh3CwrbIznZqurCvfxxeGPiSapoSbmUXmK1pRho6O3hnxR0fgu5QfytuQSGR8208lIryhCzdIG9Z4HJ1jzF9RZkxumOby1j8liI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267090; c=relaxed/simple;
	bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6+XO/bymNkJPjPcf3B0iAECYZtO0vgnygkdR4ql0y1c5EK5A10l+4aSjcNYeYHk+XRRtx2YVlQj1/0CKZ+dPYNxn5Ad531sFFBRyNor3xx3YUJi9iYthuoFVs6ZXB9jJ97zZzI83all5qg/JAcQVxqLvlA50hNZB+Qv4s0CRK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh3vE5Ka; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9f316d68so30919505ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776267089; cv=none;
        d=google.com; s=arc-20240605;
        b=kXu281e2GxZ7OntjgNhNKrnu/Zx8EIyt99WpO3846wSX5S0sMOiWNmDXNS+92Hry9a
         ToXZ2jj1N3UwqnC3G4qb2ehZEt8TZTK3UVlhMUw0sVzwQBHvyBRsCMDRmFfq09Rd+CYc
         uoWo8b53QGGu6bLTYa6dow+UXXCcRLgjPYR3NYl6GwMjd30wp39+58ppb3Yu/8wpkEjC
         zPBuh43IzUQ0wCqapqZMlvvKlAWQAV06XO8Jthr4ObSTX78AYC/3Rtd/kd0iV+P4zZBH
         VrQkS7MSWlkKYDgCDdwmeVY8iV0nA7Pi0Aui7ByrZ6ChXDjvUPb4e3LBCi4VlsH7iG4/
         QRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        fh=Vl99Q8+bF9eVYyit8JUsL3bPT+9wA/oBvf6ppogPfN0=;
        b=EfzCo96bG4O2h2o4l7jSeUFzLKlPGHXJWkqmLx6Dur1UAnC5J+tiGrx7ek6MswYgRR
         l+eZTZOeWB/y/Xh4JB5vN+7LN9MaSjDS3BGJzvVQGJlwBV82unV3zZcoq+Z7q1nMd0uS
         6sP9O+HUDBI0lM8Eh7/5gZD1YSTNiyhp/5ITefisDB/TlRXgZhj+xLHgJYInEp4mC1jt
         H0FRKNwliXn4taiMnkhErkph7t6mPBN5Q97LCyJ7+RmEbu+qfqqcTCiPIu3qbLiIZnkP
         MD7hVUPgvy3Jwh9SgQH9wfMsWZLtTbL3kH3ZM2XQRWEs/kE4mR2fgeFz46J0HiG3XA7u
         lggg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776267089; x=1776871889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        b=Xh3vE5Ka+ikHFYhtiWH88Gnvjbdgj77mPsCMci+y12a1lRzUub88MtgbVD5clye780
         QEvQxOc4RVKnxPvwkCtiwD6u6bkS1laWUSg4b+GN4gtAyggysNZeXfyWACq8/oU54zKq
         nv3kVnEpRXgk3nDRnsU/Ljg512hEAlUXA86Qe03v6D6t08238Uc1J7EtoR635Kro3AMl
         PziUR+AAS1X+IIm/lNCI+5cZx5s8kkP8OquVVxX01TZCUYxxQDr8P2eUv9U36nwHLGEC
         TXFW3T8IOx8aSt1GA0GdOClDXHVaZo6HzUuJy+sfPMJhsWPlRE0nI2hGnv95rcoaOcNB
         KpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267089; x=1776871889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        b=lP6mZICWjfDy6aXpnOAEdFXSZjtnWNgvgMbpVgK3UUkNPqntMcAu9atRKVFOsNUHJn
         oFGct2Huu3VFo4ZhzCIngHRP2TD5JP0hvMTPJ7ds9mCPfkXQKfI7UmxJbzm8D2rhVvh1
         wlKMfGV//QInJh06264fuErhekN6DkMueu7+T5ld7gj4fHG5LbKiRpw7+othidA1CbD6
         P/w+8PDi2ZvYVgE5cT8nPO4Xb2b5FLyrONBs5SzsenXt7umWVBMO+dZ8gGTCt/xMaVlR
         dEolDRpyQqPt8mhCWNXaSbvg2w0ncEqvqjKxM7Ci1rAV9VTbvmRLuRdToodIE/YArWYa
         UC1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Y+XKNycsMf67YYdUK9l/6RYlt96SFVzoWbWcun74etQtBtBLcQcSIoDtlCIl3CuEVa2CMrl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQ7DCzdPe9O2VhYU+eLhv9L3SfCTKy8b8cXWK1NixM4tolUht
	LnuKntMOHBWF4YSAKTXKQ7BW7ZEscRPizd4EXiLCS9mIBLeRZEhgYXOBeBMMjcdfumD+TuXMWLe
	IZ/sYTlZCjVDHp9Ch/BpfjTt4DC8SvIo=
X-Gm-Gg: AeBDievxpntutXcKkMo+PyRP92+TKknmJ0CsDpbqAO7gD6ztOvYpWMSx0Erdqf99PBp
	cJa4KbDIhNnH0NiXrhAX3ME4bAAAajp3hgBEBZzHyIZKdwjE4rcQj4QaGx3NSmVAjye79stxTQg
	TU06tPXibg9ABhE9Oiz7/jziwKdkf+ao1YRXuYUgEimCzBOaNEf/+mz96zIvUiU96OV6d9JwrPR
	pDq5VyGIvlbJKmMCqSGXVpQxbnxnX30ZMoh4yzYlHCx+6pqzr347YZPivSY2vorIvGnivXhiEtz
	CL3y8i8T/Iq8lZ86T3jZonLPQd2CZQ==
X-Received: by 2002:a17:903:1211:b0:2b2:4b4e:e4d8 with SMTP id
 d9443c01a7336-2b2d591b8aemr215377705ad.4.1776267088525; Wed, 15 Apr 2026
 08:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
 <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
 <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com> <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
In-Reply-To: <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 15 Apr 2026 17:31:16 +0200
X-Gm-Features: AQROBzD-Fi9TwOA2iNwLMvKH3PB5XbyRvKB5pMzjCowARYCArTwXFPUUzeFibBI
Message-ID: <CAMT+MTSdVnor4+3vXhyfhye2kVp5-UPgg_Fwm4rH0mJHM_FuAg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278827-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fnklkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D4740605A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 at 17:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Ok, then maybe we should decrease the priority, so it can only go up.
> That said, in a multiple connection scenario, we cannot really tell
> what should be prioritized if we cannot momentarily decrease the
> priority.

I believe that the priority is only per-connection and is not designed
to be used per-packet. On Android they change priority when an
A2DP stream starts or stops, by sending the commands from
userspace and are accepting that other things using the same hci
connection will also have high priority.

