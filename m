Return-Path: <netdev+bounces-289325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIBLAFweDGqoWgUAu9opvQ
	(envelope-from <netdev+bounces-289325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F220579F4D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A30D3016483
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42C3E0C47;
	Tue, 19 May 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Bu2I5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D33CDBB4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178683; cv=pass; b=jfw8OvgH+uqgF60uZ3ufhv7aeJzQqtaBVSMWPdhbXVEsatr4sbVfw/+D3v8SEECz8uHZ2bG2D64XRD3QuHjemlCGTIplnr7JhdLDHiCpVBpz5qS1g6w3JtEvEYOH5uqR/rjiOSJ6EAIig10pYBzSn3kltwQCZPdBs+j8ZyYtniw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178683; c=relaxed/simple;
	bh=8O8ltV7jl4u0QXwaiPbQAejGc7c5nL6LsAKF+LaerBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl+HqVNZ2KK+EGmycRugzwxCzfFVlgJ3iTqJdwZUmOJyr7Pc0YEIQ0FIsW0YwwXy/P/8We1b+xs8jmrcppveGPOEaRweb3g12U3rgbMd4miHHgOfmwCOhdHjVsL+G2CKqO3jR4dHJmbnPSzTcYdWdD5IvwlrIoGDZ+ir9O3xld8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Bu2I5N; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-3939d2bd739so28197381fa.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779178680; cv=none;
        d=google.com; s=arc-20240605;
        b=Qb0XUvLCC5Iht3slsCBsxg4MdvLDbSPouO7L8yYmpfkmbZvoS1hqpHtBx5pu39Nbxu
         /THI0taDIxDRYtT6mxME9HZN+g50tjSr10wBK5RhUcz5MtAuETmvlcqP7ZD1XnNkchuf
         eZp/c0ZPYISM9IfXti/b9tiJobkdTAvA3oHyougbjYbSMqRoI2rNGoFoUeYpBGNkyPCm
         mRp2FLbnuW1ilFgT7mqQoS3g994bgA7ukxMJpPAycuArHWWr/82hGzy+9Wp7KsWzEHyJ
         Xf9Ft9QcU5TS+chOcNa+RnlLPYTuA2PRiyaCVo6dwEZYZ9n1IDmp4DmuahgyDrk6mjnC
         dp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8O8ltV7jl4u0QXwaiPbQAejGc7c5nL6LsAKF+LaerBU=;
        fh=gcki3JCkc//aD9HpIAl8rrLikX2TNPS+bUIa3CjdEXw=;
        b=UsBGhM1EQ4RoyCj9+eb+7m7q3fE/kccTgxte5afdwMExrDCemNQejmJI//SdCL8rC+
         9emsFeIxuXA0DJUzB6EaA+FtTGkAuTIQjd4SpZA+Xl0odjEcNhOc02eqLb3x/GQ82ObD
         Rrgwe0dblRPDmCh22Vmedhct5BhZZXYxlj9x6srL5l7q/78fuJ7yuyqSHZHuGFNJra9y
         z0kLJIz1/4KpIR8ajDUzcfWQr+OkYmIotdq+7/RZg1TkUn4fNIDK7t3YNld21GQieou+
         uhVr+3goPUGaCDKS01VVWJsXwA+0rhk5WQanGSEUPpAXZsen9hN3W07RYme5wbgGKQ73
         E+DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779178680; x=1779783480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8O8ltV7jl4u0QXwaiPbQAejGc7c5nL6LsAKF+LaerBU=;
        b=E1Bu2I5NkllqM/ge4BCsPVvN+bltFbo+ymuuqunVTvh+stZYnejtw5ipEtC+VbXkr2
         fOWkUKRPqVxxFRQCyKKepXGMG86oqUa4X6wHchtpev1vWitI/6XqbaDOzu7E1InxP/J+
         f8MlAc0y8+1VY/4xWrr9hYByt4o8MCPHvxCMXXa/0gADx4fXPQI15U+XhGMTHEsNNmx1
         f3mXyqKyS00qs0n4uIbXVsv+45dIbRwNL1EeTcxwKFBeDm9Gv/aIx9hf2PWJMPj5YUkL
         tryDA/sJykNt5rIYz1r2/E9PvE0pD6CIRcpkoUZYmOV6YzpAYiWScO0Ia2SzMHazILYs
         RH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178680; x=1779783480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O8ltV7jl4u0QXwaiPbQAejGc7c5nL6LsAKF+LaerBU=;
        b=VJXmpFzGtD9cwE8ug/wjfnBMlCyjFYEEtJZFZnVXK46g2XQIoq8gH+drxjMyuiOPKo
         WcZvgThaai1utvEWaN4A/N2dc2zlZxgAznQJhd32gixgrxLRvUtSMy50EpoBLAX3NN1u
         VWJGgD176jqs6K+7E51eB7iKed5B1CKV5r7gTMjs26TS4as8RPM2r0auMpNgZreTzgop
         fDF+zGR1EwoQfdQDTx8s2GDaE2oUFA2FKcEMkQhR016vIGuVN/0HZWF7o2d8JreenyBc
         vefuech7m2ITpoGdwv9+xP65t+l0c05luJgLRUVIptZqxUYamjrm9V4w7aaD46j4Uc+W
         3OAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f1rV/gAD6poNB3KKCrQcft3cG/j8m6WAF992hFejiLBZU+vzJrETJdC3MmYogsBTHa0e+H3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoG7uHHDYbBrHAQt/+BN0uRcaTpHSRUkk4cqMxOmykPp/vHsG8
	iUaLyCopBvr5wUUj4mQl+1WctbrJABhsNCPV9w+oqDOfpaO329tvGQJTjmt5JZFoYyaXKYH6Twu
	FdPyNXTTwBJocsVk5ax/oWF5mZNEWBgKlksX75tlt0UUx1JY=
X-Gm-Gg: Acq92OFUgM2Q/nk0dsIvmxCWiKI0rkzKTY/emXo+CoZ9MCN8xq61YGwJjyNF4vQD7eI
	uFwiWtwDegY7JeBoy0OltAHEcTzVVD1MGQcmeG2UAi+swszCGBBwJFHLY9fB28fS365xy9unDDV
	S36bdL6avaZJmtf4deIV8bLjyWWA8WRrY1rF6T2PNNg/f+GQUIFxdekWK1RPV5I4NhvvZmJ571m
	YaEOOLt6KVbkx7UgXeV6tK5mD1let11L1YENMKWa0giVmyvDWggCspp4vzm58bUq8SyQdLlZQ5Y
	i7mMqf9DGdweHffZQavbIVgEm1piQfRlPQTrzDLL
X-Received: by 2002:a2e:bc27:0:b0:37f:c5ca:a6d4 with SMTP id
 38308e7fff4ca-39561c832a4mr57096311fa.6.1779178679768; Tue, 19 May 2026
 01:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515050511.106309-1-rollkingzzc@gmail.com> <20260518185409.3e7f638e@kernel.org>
In-Reply-To: <20260518185409.3e7f638e@kernel.org>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 19 May 2026 16:17:48 +0800
X-Gm-Features: AVHnY4IAhXRa7m6G9bZf4mTqWWlFiS_3YmPecVVpQ5mo0o0eKVZoSG9pHTY9V-U
Message-ID: <CAB7XQsEoyhgU-cNDEEMbb3-=bfKjc3278Q6DdvztLBA86gk5kA@mail.gmail.com>
Subject: Re: [PATCH] netpoll: normalize skb->dev to the netpoll device
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6F220579F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

Thanks for the review.

> You trimmed the stack trace too much, the information about
> the object on which the UAF was detected is missing, and
> so is the UAF location.
>
> Please add a Fixes tag (even if it's the first commit in git history).
>
> With that fixed please repost.

Sorry about that. I will include the missing KASAN object information,
the exact UAF location, and a Fixes tag in v2.

Best regards
Zhang Cen

