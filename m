Return-Path: <netdev+bounces-297416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzheOorQKGp8KAMAu9opvQ
	(envelope-from <netdev+bounces-297416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC56657FF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UPnOd6tJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C25C1302CD1D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECEE2D77F7;
	Wed, 10 Jun 2026 02:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9232DF6F6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:48:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059718; cv=none; b=lTKQO9+YiEckZFG0+rjF7TPoE32m1pMTLOQZSHszzOGHWT8WoMR817YOWwEBFIK7uEe3KXkcM56IAhbh/7Sx7Z/2SO2WQ/ZwQNWMdWVSZ7Yh9NQDx+ScUqPeO6DrBNhvB0knk+fk+kOJAKKhQOYdus3fznewPKSfeHWZ0sn7gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059718; c=relaxed/simple;
	bh=nVx1QrEII2UErui3UL0d/DCRa3ODoscMP9o1CsYsw40=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FXi8uEg1kcw8zmXZKHpQf5ii+tI7iiJpQecSA4arJIEgMFc00C1AQpetx6M5M7UN70wIEkjGPniEJ7ZaOsejNvzeijkboWCjqbedU9sa4mPrzgD1ysEEH/hG/eaKbT2FjetpEm2OiNeJmSWmK2RVIuNeXSmVDAaDFYa8B/+khLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPnOd6tJ; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e0b3db3499so45685017b3.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781059716; x=1781664516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhWxi9GnwzmJwBZtT29nZ/I3f2Iwi6chj5Z3iH1UlQQ=;
        b=UPnOd6tJU2uYwRz3moCwdXJs9F3xxI8Nf0DzYOQrQQZyJomxzj6KL487srPYlESelR
         foz+XDl4XlRzpJ2JJmEPjcH0hGPsgPNjLX+qFxB/pM7h2zz97AHZUjkfvBlq2TqX66DS
         GS0Cyb88B6dy61q3e+xHZtpPaX7DL2EC1wMUX+nlmeCBtHnUlaDKqGRnYmwf4mar8luX
         qQbNGP+vjnLMHsglxOLMKmBEUV+FdOK8tCzDPww2MNycgR8Y1RAAV6j6u0BErRhjcVC5
         jUcWbzHpmp2qOzNQruwB5V1ZPl/gVVZfkal9Jy9IcPSB9/U2TbIhYNoK8Tn9ZDyEV7jj
         zRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781059716; x=1781664516;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhWxi9GnwzmJwBZtT29nZ/I3f2Iwi6chj5Z3iH1UlQQ=;
        b=nvTTP6qnKw0j6oN+maswd73KFm2A75BGI4lKTn14ByU30/1IotqWIy8DAW3VQcvK6J
         m9tVuB1LURTw6y7TZkjNx8rsaeUaH7H0V2daHZgv+xw+AqmvTBq3V4H7TAVTQbSdaL4S
         u5DEjQMX3vrQbMY589pHFbB5qtWc2kEeX7SgMT6l9IBke5jE2p1zA+pQ+DTN0BCUEUga
         a2JbCBoSBG28HY71LAYoHejsyxtkpHlNyaeA1Yq6154O7oZ1vOja5n9kdIklrWSSj+iV
         VIVe8nka+cLh6iiBWM7ZG0T73ZaGUKvKKUqPxfvLlpme4nXo+Vw271oJIOVko57u46z0
         zwpw==
X-Gm-Message-State: AOJu0YyKVIBRTDDy6Rn4JgEKyFn85lo/5Jt3ckjKf0Gys99ToTe2pPAp
	OKs8QWsPUm1FFmO80NK2vnZ6u84ft39g6C5ecKbsf4nY+ldg3Qy7eeCI
X-Gm-Gg: Acq92OFL/Uz8Bfxitbs8v+QL+L8MGL7Gwz8Ci7MIHkqYwpHT9ZCR6ouRtnNTsqYWiYV
	TTmEbeo3IK2y4qpxKSceaQWL4OjFO+Q1ThGIOgIKjILF+fb94VAdkbAlkwoiCKOoAALdVteUYjA
	0x9cDhcT98w1RDpbkISeIfXL54iiSfCUeR/Cl/LzRnblXi3j+CKDVlvWWmBYgadM7su8yfF7imX
	NvmK8RwQYbI9VNYrBhsM/c7S4K8FgWaMutDm4SDxoJa6ePQsPlm4FgH1Q3nUmiVDcr1rH1tmbZa
	FIwLn3H+2cngvXSzAZ5AkrcjGcT9jomp5kW7tpf87TibktnzMpVDOzKooPS5KsZaeeoiqgEUdRm
	vMxpcdpsKMLRk0gxNuRqrcQmJOc/lhTjrib8tTF7LrHBWaCu/UuFamL4oCIQGYfVSqWhdx6ug4c
	lKv21Qo+qBpvQBWHdS9Bq2irT0pZudkpwBP5WgK8rhET5AGdgGKiyZuI0kjydki3PcSWU2yJKk3
	aZdO87POoBaRqDVAQ==
X-Received: by 2002:a05:690c:490e:b0:7dc:7764:3e8f with SMTP id 00721157ae682-7ed0c3305a4mr225718837b3.23.1781059716474;
        Tue, 09 Jun 2026 19:48:36 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea1e357109sm105141597b3.0.2026.06.09.19.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:48:34 -0700 (PDT)
Date: Tue, 09 Jun 2026 22:48:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.6915d686a22b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2888ce77104d1@gmail.com>
References: <20260609180803.1093428-1-kuba@kernel.org>
 <willemdebruijn.kernel.2888ce77104d1@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial
 fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EAC56657FF

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > I noticed that so_txtime is only passing on NIPA setups which are
> > looped within a single host. The cross-machine cases just flat out
> > fail. The initial bug is obvious - the test does not deploy the binary.
> > But even with that I think more work would be needed to sync the
> > time / adjust the expectations for a dual-machine test.
> > 
> > Willem promised to follow up on the fundamental issues with 2-host
> > setups :)
> 
> Yep.

With these fixes the tests run fine manually on a non-dbg kernel.

The CI failures are on the netdev-X710-dbg remote only, correct?

https://netdev.bots.linux.dev/flakes.html
https://netdev.bots.linux.dev/contest.html?executor=hwksft-X710-dbg&test=so-txtime-py

Those flakes all have a delivery later than expected, e.g.,

    # # Exception|   STDERR: payload:a delay:30747 expected:0 (us)
    # # Exception|           exceeds variance (4000 us)

Does this remote have KSFT_MACHINE_SLOW set? This should only result in error

From contest/remote/lib/vm.py on nipa.git:

        slowdown = self.config.getfloat('vm', 'slowdown', fallback=0)
        if slowdown:
            self.cmd("export KSFT_MACHINE_SLOW=yes")

But I don't know where (or whether) I can review this config.

