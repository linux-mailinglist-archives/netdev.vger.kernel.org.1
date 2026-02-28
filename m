Return-Path: <netdev+bounces-262140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PzvYKsD+omkJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:42:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340831C398F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 423AF3021BB8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035C32D7D9;
	Sat, 28 Feb 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imBsf1r1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392932C92B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289725; cv=pass; b=rXWNEkiZK0W/dfoZMT9uhZWbndez0HPy/JV7AmWYTfMKlNNsBszHp5cbAnkHqq5q/LdujdOuGvdImxz1kLFWd/Bt3yEey1f+BF4eEXuu+I3KJiT4Ww1TqXS6glS8qLUsvmITEbH10M8uB1XJg3xCd+o2z1F6bjS4Xp5h+ZAM0mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289725; c=relaxed/simple;
	bh=l+dRJyA9wshop5oJEXTc/TKIul3cpdtmMsGw+WNXWOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMuy2tNCJdxSTPJvK5bHAn/zOJJxlRgml64/2zI2oudQIb9RSn+4z5w/Xp1yryTkwqcarl+rZM/iz5iVD4TkAUHvYZu/Dex32VlolZSzQnSeT3AJHDwgRfluLz2mYiOSHV6hEdz5CB7WNaWDTazE3ym1hA0zkRcZaanU42tj27Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imBsf1r1; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899ed41208fso1019076d6.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289723; cv=none;
        d=google.com; s=arc-20240605;
        b=iC6JjsGvrhDb82fa4Shqo5qoAKeYdgcobxFw+Y81ilfCD3tKHprbXFYM2gtG0EuGlJ
         LlCqMmPAlsZJ9eCmAAQ8SD9HkSgb7p3etyg1avkea8Bo9ZmpBB0CWBeTo7vD605a4KyM
         YGD4ebC7WYUVS4qTCduvVzjM6xN8OJK9+usEm+8V5k/1sqHFMFEBCbF2udZiExKiCUHi
         vDVamdrlhXNpz8Y1Z4yhqpTmoN7GoLzgiRZunJMZtfMnrKBacVx467txadJvNGlQf8vx
         BBrO+iqUZvqs40sMvV6IuJThJFkoXQ+tknIPquTgCDRgZOxMGDoM9q+WDITBi4TcOtOI
         N52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnNV99AGk1S+M+aaMMuQEB3aIY72FQ1l/2ZMMvOy3Dw=;
        fh=ue2XZDO/iXDajRIInMM7ao+km7g4qhvMhdEuOCHe6T0=;
        b=chp8tLc7EmP6ty9K2k2BKH+r+eXkjcpS3ZbNrPaf/IC13jpAnevB4mWnkpJv376h+b
         JkxlyamdSOVYi04yx3AOIz5y7K/xf72AlYOZOGbir/ixdhLS32n7ng0WLj8cprtuOQCS
         yz8Wsri+4EITglbrT9ZXsESnSMJTDsQ3o6Y5+vME3ayQFeAPyPFJJwZ40NTM4Y9J6eGk
         cO9tsBhalFq9HLaqEZ7LfBWneQZFFr3kh0kOhL0MvQdor1y/5Ln9vJGPS0eK66z+Pb8b
         2kkoNKkoZ5uT3lPovzhmhJGSqQyPePFdZBHsenh4DzAf1PT9jGq/ndElZE8kyzzNTqp1
         1faQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289723; x=1772894523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnNV99AGk1S+M+aaMMuQEB3aIY72FQ1l/2ZMMvOy3Dw=;
        b=imBsf1r1c4nqYh0pvwtR4kVNo34KM+6uiSEpR/hZqrnQhvd/5GS3RIx/YEqAAKAwjS
         E2BI4CmHXcIFY4JnOdtK7QBzsM31S0gOySGsKlKOVpw7H505cmbIekQ0mIwTPMaeIhkn
         ixnTwPZPv417uAQ6PS+IiA/Z5RC9bCBlc7Zlknzugm60QZj6sywMD4YkAhrpju3+Knc8
         IWWoD60dT3mOw1g2m/lZqqVSk9Hch0qnvq7NuSM5N18CSh6MEC+YzJuSuXdeCggMtvBC
         AVD82K3/tO4Ey9KKpWzyJJ6rGFRpSvrKAdWzLAdsgy9ZskIo8fDUGDKUZ8brfdRbXo6O
         U/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289723; x=1772894523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnNV99AGk1S+M+aaMMuQEB3aIY72FQ1l/2ZMMvOy3Dw=;
        b=bDMyMDurqSNkIK9GclUpVIErKeM2WiE8bOR2cxpFSQ82mCSsPxp2VG8GsfWJwG8VGn
         DuDqF7iuCk2/af4OEJr5s6Y8fJ2Ed53UY5kkNnOsd2flRV2f+utrtiryn7EsiXfWD1sR
         V2Jp7/jSaRT5d2cx/EHsZ+2XWir7/P+7SEDbBcZSyGQPXitArqjKhx3kVcv5jhzvWrAf
         sPCKY3yY4wJcKwrweGO/eo74VyThimdA80igXxUDG0dOSGDEPpAVQOgj7ExvO2cieBhq
         Y+vn8bkHs2FQf7QmhCUizPf5gWMX2LxJabkjutCnrlzpN40Khvtvie28bYG0ZDfPpRCP
         qljg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ycp4S7E+snG2aJqtGYKQz89CvICGpMZDXh3y8PB2Xhb26BnU3kzUJuGL12Gl4UzCfScj6ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/St0tc/5zjIPX8Xj3W9EIYNW9eH13hZE0sMyn1QijSSdwwfMM
	GDt+gYHtkV5+zFQANtY8uej5K/PEkAfwUx5COXA5yDdA3+YsAk0thO7LuxzVgjffr4bmFjtGAEj
	B2qI9SVufRGjiQtxQLVyfRppfsJk/tG+7ls/2O7ZA
X-Gm-Gg: ATEYQzyQ7unDWVsxHWcdm8ton/wr16nH0Pr1dv1L5u826hQ3+ZMgmZARdDjnDT2WuDo
	v3zCC5y0g6wIFLYdiZWr5DiefgafHr+p3EWPHFQOKToKFt34QJ7G9CmTbeqnxzC2yzWlxNAPrk4
	gNZuLLiITY9mVSxhRaj1gH8+ujUl0RiphD6HAPsjnrmSezj+T+zgbICcYyOpszndriIX/r50rXq
	48/Y0o+A1x3wvgz3sIqiFq15siki1a5evnkEkfdbYY2uF55hfDkunp+3G56HII6xm/CXB7ni/zW
	GwNxXiwQ
X-Received: by 2002:a05:620a:c4a:b0:8b6:1877:3689 with SMTP id
 af79cd13be357-8cbc8d9f7f5mr783074385a.35.1772289722864; Sat, 28 Feb 2026
 06:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-3-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:41:51 +0100
X-Gm-Features: AaiRm50K330ElP4gZhapLzm6kwikQqvB1-osJRWV9k0q5J_HEAqP-fLXzniUvR8
Message-ID: <CANn89iJ5EMpSBEoStHRXgQuBph=HUZwL8Lisr70HhjfGH8=r6w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 340831C398F
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> These fields in struct mr_table are updated in ip_mroute_setsockopt()
> under RTNL:
>
>   * mroute_do_pim
>   * mroute_do_assert
>   * mroute_do_wrvifwhole
>
> However, ip_mroute_getsockopt() does not hold RTNL and read the first
> two fields locklessly, and ip_mr_forward() reads the latter two under
> RCU.
>
> Let's use WRITE_ONCE() and READ_ONCE() for them.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

