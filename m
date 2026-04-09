Return-Path: <netdev+bounces-276949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBAyLkOS12k2PwgAu9opvQ
	(envelope-from <netdev+bounces-276949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427D73C9DB4
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70CFD3003D19
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788438836A;
	Thu,  9 Apr 2026 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ABDM4GeW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE41DC1AB
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735361; cv=pass; b=U+hiRYgncNvrfKt1sgs50Ceop2UmpUqXwzabkXciWVMiSwDUk0waChQR9ikgfejbAaUN0zy1prT5hz5EKZOAFCemUKPkK1nRbx0QDNL9YZIutfYgqBrqUBzo07EYqVGGLNIZwzCgvYN9sDrJJRT8l8PT2p52GSzsDiPT8pcBoP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735361; c=relaxed/simple;
	bh=Ptpp/0wloYKW7iYBCMNZnUG+1LKquCCtZPpVeui05So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMzpT6EuLik8PM9Ia6oNlMeUC3AXCpyETGRr6BZN5ELvtH8mvTOZtlIupy44QgUMG1HJpnbH1H+6bbYxPwaUwsBrLNBgtV4G+wQfokCe7rVlWY2fFM1F41acNua8z0QMn3orbl+V6AlTPVRCJotNNSX+UJbTt43fCyu+3aoIl4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ABDM4GeW; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97f9587e6eso110660666b.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 04:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775735358; cv=none;
        d=google.com; s=arc-20240605;
        b=BmpQCYvMywccTuX6K6p9eXJqDMY01dZ7rWffYMeSs5QeO3aaMAFLAnSrobeMhA/rcJ
         8bwBUdkcGOB1u4EVj0zE68Jhimwh4d25SquZj1yopKdr683b5Rt4YHzPXtP3sKXSGT3S
         XvBN+LobCM5aFbhoTTqXz2AM7AgeaTjBPG6Rg6oGeRhd/LXPQ3uErh/ytrPphEWAwetY
         0YqW+3KvBJLlrGZf7Th2vXMoAVZTJqcDzpXYZMAxwq5yhsjg0UBi96/hRHH//mXP9A40
         4EO1Hln18W0UCCfr85kd1ejKukNW2KjYgyaQmxKi9qyjTJ7iHWTO56tB2EbWXHjPI2jf
         hrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cbdwlmk4s3pXiAqIA0/ItmL4vDS7L9MPRtTIT21R3N0=;
        fh=Rx3c90uSMKF3p54t4uop2iwSI1vtt1EgSNJvRWSmc8E=;
        b=ba3a4DZzWRKeBfWsu3NYgSqD8qcc4eD5uNw4vCnxXQ7fdRDGgaicTSnAJw7qDUYV3J
         V0VQrhcX+Z/ukkYpBGDFkB5h/X+JG7bQ2+NiyJRBYcJgAbdCU2YJkfSi8V2LrVPz2kPb
         LYYkn5ifIryyoH+S5bZ3sVfc1E3T80cKRJxnVSRkh8FYjFzKIGsM+1Bdqn0nkEIZI69O
         XnSNpVwK87behchMvp3HkuoxWxuakYvQ61QmqcaIWnu4ObjIiKkMBy2xmYlVSROjvgsf
         ib3AccyBHFq2KlVGbALw/opmbEQf03QEq1PYv5joOdAqAEV8ZKSec318/Nc+ZfqURI8c
         m45A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775735358; x=1776340158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbdwlmk4s3pXiAqIA0/ItmL4vDS7L9MPRtTIT21R3N0=;
        b=ABDM4GeWZGS+ANLQImIKzI9rPUKb8HM7nbqI9eDVrqY2zlf+3ZLB6KE95H/XjYBgDC
         5HrL7FNXbHT7RgowIRn/XJgZHBHAfZb+uQRyrNV6121dIN3w14vDF1rK6OWxrfbyRbg2
         CQ1dJcIS59S9+Ha/K1HYBaBc3izIuac1BVFv2E3/GpB47Lq5NvM0oatPnpA9nT3iVra9
         MNKsAQZJs0tmvbShuDX1ghsx9fX9lyYG6hRRYGqiZkimEC/xXDrcWqu5AESRVer7sRDc
         sp3F5FSb6s/WfRJPyaYtJvguT1Mn5d6Z7Yd6qXKY8GJKQCTL8IvHccRCjAVPono2i3MV
         i/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735358; x=1776340158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cbdwlmk4s3pXiAqIA0/ItmL4vDS7L9MPRtTIT21R3N0=;
        b=BxbS1zRzTpZVvxi/L2A9UfoEHjaja/e2JsGaKRP5rU3gKIqoiUg381xRYbBcMRRgAt
         hiKz4bNq9+Wk4OBqjR/zzcu7UNpfrQK5YPNiAIh53qCOT8kbi7U2cQDFpqL5PVqaBLm5
         UNs0uHUquAGfqDNS/nzfPmOlitlHkdOnv8Niv4nRqrGkqlSI51I21fuSYKDKRPK5EviA
         H6WZRgkltTm3juRYe3GMiNTxpDX3u4vejETOj5DcnuPAG+jHs7VtsZRBbsGsvDC6vOnb
         Oh9TMzUDwIQlHkbAy0LLo6UJ1sJEh8jGKRDQhRjtDGc9pb1FdMQ/7UFBENiF6O90TY7P
         nLgw==
X-Forwarded-Encrypted: i=1; AJvYcCUjEbdVbalrMZ3xGBmWt9ECgOtYvP3L4V/Luoy2Ni+fnd8CSw4WsUMh/0JJlhjOETor5aQrxJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGVPe+kmlBsQNrpS2JWt29JonjwhKnvJcZnw5zwH/Xeii2L/Y
	Z2hPA/LNN/Msr9LpNgB/+sckSIA/DQiEiRFSg+ybnSQA5VZxF1VxBQ9nhgsQw7FOatxBqj3WYet
	zq9UVzvxJPUkTSQInw/jGXeriIBwiG9iOLMm0BXaVYw==
X-Gm-Gg: AeBDievgsfGw02VAYCuPlcVmHJPAp6KTgajbdFkD4YDoehD3pcd+gJcVoqso++cqTFr
	xNS7Lq0bZlANXOhvhWMAEO8LOrYX0CdD3yhHJ2XN2zmjGAHcp/UAK300wA6pqNtC7JR3LTFwm4e
	zCy4vSzziZEoRSSCOW6jPeYoAx/d54/GckwDuGvtyOAPp1tXCQprAw5g3bwhUXMvllxGQB93jdL
	woDL3/10cF7+1XBvHXJK7/geRUnoEkX7E1OHMP2lDV5Mz7GMGyEv5QFQCbvBFgHRtDrHfGg6W4p
	fG0WifdavdBa9RKo
X-Received: by 2002:a17:906:f5a5:b0:b9d:17f1:fff1 with SMTP id
 a640c23a62f3a-b9d17f201d7mr495746566b.42.1775735358008; Thu, 09 Apr 2026
 04:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408201341.68f31247@kernel.org> <6631e1e7-8728-46a4-9999-ea9910a1abfb@gmail.com>
In-Reply-To: <6631e1e7-8728-46a4-9999-ea9910a1abfb@gmail.com>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Thu, 9 Apr 2026 13:49:06 +0200
X-Gm-Features: AQROBzA2lmyNK0i6iFjRiwTWLVB2b9uG2QddTjGFQ-RZ_VbZSSbiwIoAzGniPQc
Message-ID: <CAJ5u_OdU_okwjuEdm5zUBibW0PJsTng5ooZtXRX=wjhHpANdoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no valid slaves
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	jv@jvosburgh.net, edumazet@google.com, pabeni@redhat.com, fbl@redhat.com, 
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276949-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 427D73C9DB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Le jeu. 9 avr. 2026 =C3=A0 08:53, Jonas Gorski <jonas.gorski@gmail.com> a =
=C3=A9crit :
>
> On 09/04/2026 05:13, Jakub Kicinski wrote:
> > On Wed,  8 Apr 2026 17:23:48 +0200 Louis Scalbert wrote:
> >> The current behavior is not compliant with the LACP standard. This
> >> patchset introduces a working behavior that is not strictly
> >> standard-compliant either, but is widely adopted across the industry.
> >> It consists of bringing the bonding master interface down to signal to
> >> upper-layer processes that it is not usable.
> >
> > Is the only problem the compliance? If so I don't think this qualifies
> > as a fix. Please drop the Fixes tags and repost for net-next. Please
> > keep in mind the 24h reposting period (also I need some time tomorrow
> > to queue your patch to the CI so that the selftest passes when v4 is
> > posted :()

The problem is not only about compliance.

In his review of v2, Jay argued that the current behavior is
standard-compliant and pointed out that it enables some use cases, such
as PXE facing an LACP bond.

I replied that the current implementation is not actually compliant
with the standard, and that the PXE case does not truly work in a
reliable way, since success depends on a random link choice.

My goal is not to make the PXE use case work. Rather, this series fixes
other problematic scenarios. To avoid regressing setups that may
benefit from the current behavior, I added a configuration knob that
allows preserving the legacy behavior. The legacy mode should be
deprecated in my opinion.

>
> Signalling link up too early can cause issues for some protocols that
> may change behavior in the absence of PDUs from a link partner.

I agree with your point. I have observed issues with
keepalived VRRP when it is configured on top of a bonding interface.

When the bond reports carrier as up while no slave is actually able to
receive traffic (due to the partner not being ready, as indicated by the
absence of LACP negotiation), the VRRP process interprets the interface
as operational. At the same time, the absence of received VRRP
advertisements is interpreted as if it were the only router on the
segment. As a result, it transitions to the MASTER state.

In reality, another VRRP router may already be MASTER and actively
sending advertisements, but those packets are not received due to the
bonding state. This leads to a split-brain condition with multiple
masters on the network.

Such a situation breaks the assumptions of
VRRP, where a single MASTER is expected to handle traffic,
and can result in traffic inconsistency or loss when upper-layer
processes rely on this behavior.

>
> E.g. AFAIU RSTP may decide the bond is an edge port because no RSTP
> BPDUs received and put the bond in forwarding, which then temporarily
> creates a loop once the bond actually starts forwarding packets (until
> it receives the next RSTP BPDU, which may take up to two seconds).
>

There are also situations where BGP incorrectly assumes that the link is
 usable while it is not.

Please confirm whether it should be a fix or not.

> Best regards,
> Jonas

Best regards,

Louis Scalbert

