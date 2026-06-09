Return-Path: <netdev+bounces-296826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cyrzBBVoJ2o/wQIAu9opvQ
	(envelope-from <netdev+bounces-296826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131E65B8DE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NgvGDEPE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296826-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296826-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD0A830D57FD
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3715308F39;
	Tue,  9 Jun 2026 01:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103982F6596
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:05:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967145; cv=pass; b=XM4CbF7G8IrNTpTm8eqQ6TBw19HzF+iv2sB5wKEQJb/S1AEIeIjODD2Jc+uOEdz0XSTS7aRF37u8uFIqdi7XTGsRp5f8C5OQ2HZFTmqahDvY/5o6s4vuoxq1Ou5rt8rSP0sXDS1IYnfpmKKvzpTAWC0lZZF2FTjlDYXdoO68MHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967145; c=relaxed/simple;
	bh=z3WJ5gLhFpOZm9dlt+GxEre2WDZUQcGCoyytqwuOnYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP3qX5R7dtQy1sM7cal8eyMwNfavUwt2IVPvvhwZG+/6E4RgHEI9lmToADW3nx2BlLZzuLEehbT2Gbn7O2kPjVRI96eJoh2GEE0CYLLJcNmrhrZ8tD4U3ffzU02bZ8KL1kn8+uReJ0Z0cqvdfoU1z6vZz7fSIVq91+OmDTfXdWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgvGDEPE; arc=pass smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so57996406d6.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967141; cv=none;
        d=google.com; s=arc-20240605;
        b=E9PJFHRxOqKiwMxzW6kGybpspS32zdEIw/F/KeqHzmAoEK+ngJ5xVodQmtXKb4LEKq
         6t5rbb4yaPavCP4+kQX/R2Q3z4zJTWbf47sgeuITQj4GJmYRC6GK54nOJtdx615Uehci
         VRXmDCyN/QVTSLuEVyamKE3avMVJEbwidqvHvDHAvgegMqjL+U5MhQEP03HU9IjAmW5q
         /5rsBwqHIDuqXT+EHvEVuHoO4MiXuR13fUKss7MJLUu5wtIpLwHC4j/R5BIW9qSoXS0u
         6gKAyXiAXC1PvBD+Qv3Ca9Eiz8wk+dzERjVqgSvjKm8G+aU+hRcg+4DaDSRxv+PCocGc
         x0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzdUT0vDMNSxYYgi6RMMdcz8Ca5qhWuUrZEHJG7gZ9s=;
        fh=xtTK8CDhO0TTW2qGoBWHLNfVsag6D62nMHrwQIFt48g=;
        b=c0e6NzNV3E6xxeyE7RjQYb8A0/itSohPDYd3ilYAN+T99fKXW9AhSofdSujm63+k+S
         vzQLwFHRWFJHDvcMsH+XGIoSE1LiQ9XayoRMmaejEolQqr7W8KOHzWu9y4pOg1J/phnO
         UrLCSGO8FLOdAeuGDsJSerFM4r1WQ73tI23e6dFRUfPOJ748G6gmsfADZwH5ltin/FEX
         QRwH5V/yg5LN0kx7Oq/6fHjFPU11cOSngkL50Z/SxTyMVc7d2rIlZdn04RU6jzd4KUMg
         JD2gZ2TwIO68G1vXukwLtw+FxtYRnp0aAiOPk5XG390YbMwZyizIRiCjXCpY6yjLpu7y
         /SyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967141; x=1781571941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzdUT0vDMNSxYYgi6RMMdcz8Ca5qhWuUrZEHJG7gZ9s=;
        b=NgvGDEPEVwJHC9w44dNxzyiBYXQBliylYnVdEH6JFMa0N0UomaBFvkvg0z8bGUmdSz
         WQ1PiIzhq6i1nJJ7DB/ljt5YcdOrn3B28Ac0CD0umxLm8K7rPeDYyigSDjfG04yQLs8H
         05RYbygmP0sEq1RUd6CVyo1a9N3UDhNUZO4MQcxEDxPhm+gr/ZtMVO+jmHhrkMtWbATH
         rfFTx1u7/Z1cwo2te6i3Gaokre7KoW5yHeF4zkjDbv7jVnM1hiXWUUlUpDHEADfmA2l0
         81P2J0Yzb6I/00sBSVQtEaofg3p1iaR0JcdZ2WDRkHsyjHQoI2xj+f5tMom7Dfwm68rQ
         ZJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967141; x=1781571941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzdUT0vDMNSxYYgi6RMMdcz8Ca5qhWuUrZEHJG7gZ9s=;
        b=JXw5zhPv6CveRaF+6LuJz8rSwzGa2Wjhm1SDJ2k+GCBwLqo8MjU+V/k4x0rBZ7pyl/
         c1Xq6CcNee+J8OFCLFluGJzVmVp/kw76W7RPqWn6uMMiIDcaizFCsTUYIWCWHzBaQ855
         k2hmWK0pKz1zfHYD3DiLH6IPDG7E+JeIAboQ9mrwdEul6/SFY4Dz4Yx0XeItkgzK3G7T
         jX/EIRjyfE3LfofZxeNp9J+/M4euzHH0P6xOyJO+rpBQbTQWe4mTu9MYKRgt8FHLVicL
         PnZisQ011bmQFWWAIKSthNk8JSBmG4gCgC1r5oLtZ7TYlQhvK7y5+9Gj5nDwrpFxKLgf
         uSzw==
X-Forwarded-Encrypted: i=1; AFNElJ+mb6+9jbCIq3gIq7nEUf77tXshLmeux599q+UIw1YmevQ2P3ptEzwtURqLgHL0+/j/ptd7EI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY6taMKizkMZZXTyAm9ydzMqQOraCyWeqBKJSWfWgYSZMjXIa
	bv2fm80DbYJEhK8B/hei/NCu9Adtk5OpATZ+ePmXQ/kUCRo50QrXYyp2V4zRRdf9dI2I8ohs7QJ
	2yo7LiXkA6qygOy+XTqqOIH9IZoywotU5Kl/o/SFe
X-Gm-Gg: Acq92OEGZ2mh7/4uPBoF0d5SmqNOQBcMTtfafdgTQWd3bvZZJprvWD29z8YZLenFNJZ
	qcp+Rvu9ZZldV7fQgvJdFF1NaCFmKh0n0IKCpvdR7O1csjYoug7bbFkwLaGKsyk0C4zIaj7Tok1
	Ld+zMbJZhkpuSh6diGt8VyEY5nWPbk/mVTxdCcn9k9jpVdm3UUhpDuq0f0hQ4oNh+nxhiNk0fg+
	5hoVpgitzxEWvxKHrrV/vG5p2MMN7bDNoz73SY6WYE04CNQnNzP7jAVeWI5VzsRZ4v8MmzUmxN6
	sUodDO/LJ4Z64ZXbly7spbtlt3EHXfSZds4W8o4LoPtdBBxEMg4Ifz1/h9nq1T9Qo5CLgVeyI6Z
	6oaVjmJDo6YLR5m1zNS31OQCswxzE
X-Received: by 2002:a05:622a:5a10:b0:517:8529:6f29 with SMTP id
 d75a77b69052e-51795a72806mr243720191cf.27.1780967140438; Mon, 08 Jun 2026
 18:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004026.1238860.be23a168aecb.fq-pie-memory-limit@trailofbits.com>
In-Reply-To: <20260609004026.1238860.be23a168aecb.fq-pie-memory-limit@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:05:29 -0700
X-Gm-Features: AVVi8CcMY5Wyn4TBHRB8Gs3RMKif0DWbc__eZM1KddI4SQZWsLelEMpG1Gzi5NM
Message-ID: <CANn89iKfb-75vtphcK4_juLBHN9+ZPxEDZi-XsBenv31Mm0=ZQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fq_pie: enforce memory_limit without wrapped accounting
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296826-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8131E65B8DE

On Mon, Jun 8, 2026 at 5:41=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> fq_pie checks memory usage by adding the next packet size to the current
> usage before comparing against memory_limit.  That addition can wrap and
> make an over-limit enqueue look acceptable.
>
> The scheduler can also fail to enforce memory_limit consistently across
> enqueue paths.
>
> Use overflow-safe accounting and reject packets that would exceed
> memory_limit.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

NACK

