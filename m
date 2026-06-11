Return-Path: <netdev+bounces-298276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0AkCO+H+Kmpv0wMAu9opvQ
	(envelope-from <netdev+bounces-298276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D76746FB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CtfNN5vE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 265DA3288F4E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBA4C77A1;
	Thu, 11 Jun 2026 18:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDA4C6F08
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:26:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202397; cv=pass; b=sOd+kyf/xeTJTI6jGSa9ujVSxsiAs/FPeOuieA5qV4XnoGiCxPN89HRXvVAuqgLeMXFj5kMDrPcF9aTcoTzu+/yXsggTgP3KiNHeB76vlXoXq2Ogs7LwMQB6OzysYLOvi28DPRuA2IbVNJmch6/CjJuedaz+28dKkkAFICMwZjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202397; c=relaxed/simple;
	bh=itDhPXr2ym6uljZNFH7ztIm2NNS8EYC6wS0LUwCLuIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLH0BSTs2/3IHOPxm12zUxt1sGXm7HKZNGahOmmDdaM5fXsAomUSoqQEbvBHjfmfnkcSLfDzQ3H/EzjLnwHCn9VRGmHkQuYPYqNO7kWcnBDdxx/APPAwcANt6uOpRgG1WMFqcIfmX18o9YQEUQgSmWskUcRd0gDoLz4MgIekfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtfNN5vE; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51765531803so89231cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781202392; cv=none;
        d=google.com; s=arc-20240605;
        b=dwj/JZDvUOZwM1d0BxSr7P8EXve9yuN9L/2SIMrExTZxwfcyNuSmUdZoEnAHEKmZgY
         oK+TfU4blpSS1Td7LUnAydimCmma6S/Pv17io0hEctULNRUf/FxXYy7D92kEbM69hRoD
         lk90OQcDbUzGAHXTkKBCpi39ZCMprqRWsGIQ1gLYP/AAenuBOWql/77BQg78lQDRH9GO
         uL1Ys9r4vRgE25dfu2BFxN1GBCqSiE8E56JG2N1jgYitNERqOz/1TV5A3YmHJ6u+6Ta3
         OV89X3zpyvUPiCDfwceoLI9qH07elueIWyFxOOZe5L1IvL5XjALyzHqmUXBRfRw4OgFP
         41KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        fh=7IOvkaRohe3fLeX8uJcyjLyWHDb8PYH1VZ5MmdEtZGI=;
        b=czorFr9lV76QD4DsqPWARhqD7uFr8WGX3qGcDdNQ/UE3LAFSO6Vy/ikq5YRiG96RL/
         /PUPEzBD3S09uklHrO6Wc2yFk9Ed/9IBh+wFQpgI53kuhv64dNyeAjy/ui5EQsyAkUPI
         uabbwH27gxC7UVKW0GP1HZmyG9BxQxX32vNTVHZJOntBbh+qkiT7EZaLBcygLQbu0QI4
         YX/Lq1MiqCvRtjApeZgUkWCJGcFb4CpeFdwvVs+rO7mBzo3PY06aU8VS7zVY/F9VqMZl
         mvEDMxViVHKlmeskkfwIvBExClPbn0WQLURefkeXrvVPsIyn7W/frvclhajbBn/o7veP
         NZmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781202392; x=1781807192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        b=CtfNN5vEAglz/8F5pdX68J+4E9uhHfYYmwGU1B68Eu9gVtKL6Y0oktf5KbBNyq2XTP
         tjbyCvLWvsx3apKKKDjs4bGRz9Ze5bepSWprMJoa/zDg5FHI9B8FcIw9aXCfaGvopZEr
         Qq9F3PzPI2uBvVia9D+uZXQvmqALavDO1QTte9X3VAJ8u6x46HwE/UrNBTXQGOazrNSx
         Vwmtimj5BTZjJcdc26JLPUfpDWhU/en+kW5xFQIx9LcHNnVqy8ff0n+zg2Nw1ctlsjCx
         dvy4Ab7Lj1W4yrA7EZmvAdiUJ0v2dp53FiNWm9/z5+kFlwYhMkcJf83KpvAbR3sbOf3B
         +19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202392; x=1781807192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        b=gJYmiIO41SPSYOZUlKWyAQp3Z4u7er1h/wIt06RuyD9RpDpj/WsDfA7tNwQD2e3pui
         fFpFHQh6+srMt10RWBM+V69UmbxfIYmvUk6p4q6pGPOKhIFOUUNniv8TeKzzuqtr6FCa
         XiAJPTbFcm9sxwBXiCzRDG0LWgHixVMx6vIeyZwEuf7bQnTfV/IDvzRaXlcxrbIbhc/7
         UqX+7FWGIaZT+a5qqFRfgIvUJmu348ReQvYz2fIYLwbw7VjFb4x4vwfDzpFu1VHM/RH1
         7fIZmgUvTFY6K4JgGqO1IeTxbr1kSW3S7aWAgAvlxwno6xkfHOI8g4JadAUdnFfFoE8j
         gsZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h0ilptv1T5PYKKAWK/5/TNof4EFV0xwQV/bOHFlYWuqWr6RZrZcGKLhCfdEt0bx0ry66heyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGwqQrwJi/gEJwTCL1Nycag1VoivY+f/LgHJUmTpFz5DWVF8s
	UDRT1yRHBnY+ao1R1IB870ou2TkQ5YJc4RQQQpR9GbPFFqrjVBWifdU9RZzkcTX31/V1lppQA8/
	OuURyQh/ZkrxDbuaVLBhRNMXf7bRMgtyf8X1s3I9W
X-Gm-Gg: Acq92OH6NS9yV0LnenK0Tr20BVWlmvt4E96SwO38cJJnFpktukG1ocKlXq7x/SXcZDK
	ZBzJIMDZslbj7FrJGPbBIIqreQGfWmsqR6X6PZS/c+HCTfNLfmnWITty9JNbw9o/38HX2uG2ulT
	l93PDV9E9Y59ewH+w/iC9N3LXN2nnKvlo6TwAi3kmj39rO6tFfgIG4I4pa3QjlOg0hOrIb/NqKu
	p7EB08jjfYoydlDSRRI6BnvXEXDzyQd8evE/OD2ZdVqohb06qDDCvU/0Wqj/GIAuG/oBvWWw/Gp
	3R2mRYIwjQpUJ1zT0qoaQ8cCRm2O6hni3BgHow==
X-Received: by 2002:a05:622a:130e:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-517fb08448bmr937311cf.16.1781202391118; Thu, 11 Jun 2026
 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611002437.1671401-1-digonzal@google.com> <b601d0d4-d472-450d-a966-e18c9642a433@intel.com>
In-Reply-To: <b601d0d4-d472-450d-a966-e18c9642a433@intel.com>
From: Danny Gonzalez <digonzal@google.com>
Date: Thu, 11 Jun 2026 11:26:18 -0700
X-Gm-Features: AVVi8CeVv_8rnqLZqyyC2rJzhiRpf4iydHkPcuGojuZUr1GdzQIsaDm1AuaaoYo
Message-ID: <CAH1CuA-zQveU_pzopVMnDM11Kbz8wTzMP=SvSDBEq8Tk3RaebQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: decrease statistics refresh interval
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:decot@google.com,m:anjali.singhai@intel.com,m:sridhar.samudrala@intel.com,m:brianvv@google.com,m:boolli@google.com,m:emil.s.tantilov@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[digonzal@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-298276-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digonzal@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,uso.py:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 718D76746FB

On Thu, Jun 11, 2026 at 8:57=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Danny Gonzalez <digonzal@google.com>
> Date: Thu, 11 Jun 2026 00:24:37 +0000
>
> > The default 10s statistics refresh interval is too slow for real-time
> > monitoring and causes network selftests (e.g., uso.py) to fail when
> > verifying traffic immediately after transmission.
> >
> > A 10s delay also causes aliasing in telemetry tools polling at shorter
> > intervals (e.g., 5s), leading to inaccurate rate calculations on
> > high-throughput NICs.
> >
> > Decrease the refresh interval to 250ms to ensure fresh stats and fix
> > test failures.
>
> Have you tried a bit more conservate value like 1s? Wouldn't it be
> enough for tests to pass?
>
> 250 ms is also okay, just curious.

Yes, 1s also allows the tests to pass.

We have a preference for 250 ms since High-Freq Telemetry (1s poll)
1s driver refresh rate causes aliasing:

# sar -n DEV 1 | grep eth1
10:52:15         eth1    390.00    339.00     51.92     55.54
0.00      0.00      0.00      0.00
10:52:16         eth1    409.00    360.00     54.72     58.64
0.00      0.00      0.00      0.00
10:52:17         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00

Thanks,
Danny


>
> >
> > Tested: drivers/net/hw:uso.py now passes
> > Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> > Signed-off-by: Danny Gonzalez <digonzal@google.com>
>
> Thanks,
> Olek

