Return-Path: <netdev+bounces-254690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH7fDgo1e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:23:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA63AE95C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB21309B50B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84133D4E9;
	Thu, 29 Jan 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZVu07Tm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC322A7E4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681853; cv=pass; b=lqPCaTlseXVSScTAPmYQskPc3yxZGTDPopw5mtz7WpKtlm/413gpYhQvChlNfn+GuJ0MYzn2Qg0awFgCcV0LE6dsoGPAX2t8b34IJHcWxsxnz8dlu4YOu4xWvQPuT3RmuWELSL+e2+O3/+N4OI5sgmhxN8kHdi7DuvX+ZtFfAjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681853; c=relaxed/simple;
	bh=67FVUEbikh1tWd3SMc0geGTYOpFjct8hhO43NGCirpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUlQDyqSRKItt4rw6QhoVg0OCW6drhynYebsYqiPfM+v5Vvx4FRepp/frZhhQo3ysN3CzVBf/u1QVRNh++sDGZw7zLYtlmdN+BkowsTlxxx84bCLKYREHUoEf7hCLJ/66MPWS/6bjW/h6ANRO3HUXtWe823RXI3sps3kiQ1iTek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZVu07Tm; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894674a4c4aso15163386d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:17:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769681850; cv=none;
        d=google.com; s=arc-20240605;
        b=GCy+mIZuffvqhZnPsV3T5KoMDXcJTxHfi+V3nNTgh6KAs0xP/+AmFfxl1mk6KHdgLs
         uUrXNEkeNMiCvkOlbb822uVud3wJNlTsVYo922J5TYfoEwmrwUWh2vjunCrHie+CS8Dw
         X+bnsFaOp73dQ5S7i+cNapzsbFLYjt78oYmYVYOQKnZh4clMsvx/MdKNHmuxg5eo93CX
         TTY8eZRm2HrhfN+dXVHZfewMB0zWbccuB0zVnAb9goPdOwjIoYK3KODShK2gcCV5pN3u
         DfGtvTW0TivdBhQIk2iXznkzUrerV3ci+UXgDGU5URBmqdS0fxH6Cw0OIH78e1byuAUS
         HRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67FVUEbikh1tWd3SMc0geGTYOpFjct8hhO43NGCirpI=;
        fh=l7hQ0/XWyF1PeHUsW8YL8YxdOXoenKCJoAAmZu/a3kM=;
        b=E1l5ZbL2Fk3vw073BwY2ZCNrgwD161vyRUBKuy7pEwY9HGpYPWdmlC9PlGk1OVG1oh
         AVugikaJBuX06yD+pbQ+ZwkjkK2Wq8OmU7O9ICsrP3qSvSnLF05/DrZD9rbrJNDwFp42
         LGUoZwteo9gC9mHJGIjMCeh9Ql7KTVpG6H+3S0IFTLR3HV92BAUJhE8LsiTVcsi9M7S2
         tsV5Y/heL3O83n/VwLj5GLN9CXkPhfVrALHsohkV7BleUJS6gZcXbmLnTnJwACExGgvH
         xl3UVVZCIosOT44IDk4SdBquXDOQbwjsAxz2ZX/BVIVxtWumXpWaQsrWaSJWySHgF8Dq
         BWOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681850; x=1770286650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67FVUEbikh1tWd3SMc0geGTYOpFjct8hhO43NGCirpI=;
        b=mZVu07Tm1TRlZMjGSOIEb0Cd8yxggnlGYoG+8d32Ia7M+UWkjIQ8G9j5ZtaVAZ/rSa
         8sSh8nqD3D1v07hBxmAYR3ehJvtPzi5lB1A5quKOWoJ5QV065H8x0znl96cjmpkD/7V1
         jXW3Ppy9cTfUwZLHKRDse0qKX676ou4RXyiotJWtuaHpdad9kYqSPMITi+z6FLJkRiEP
         1//4nzFZ2pN+4lpy4fGocAadn54rbwkv2GnxoFHykuIvvxn+2GOU3IERB5/EImvPnqoe
         d5GK2pbgYXmxk4BcCt6FWJBF5fSqOq7+ps3EPnsfdrVWANcmtF/etPvPeeRyXJTIZ7iG
         97VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681850; x=1770286650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67FVUEbikh1tWd3SMc0geGTYOpFjct8hhO43NGCirpI=;
        b=HPR7O/ua59H24zxZOVTnJNfkTstUcyd7KSnsLmzGaDY52arIEEtxelSyvY9EVXFZTE
         RUQY042AMU3HPmOTjb5lOAP8sEVVytv5Gi3+rssWvvN/yGMt2VcjJfIv4hZ61R9fUzTl
         n6SkUqlJVHoz4144G8z4ZtCxL3xUgCeRFBydktKRSJ0voKTggc5d7x50rb4Wkn9VwKFo
         JqqevuqEDfezozO/+A/LC/j+bzIlbeImm/iBpyEts5w8HC0lf9trEzLFMTjMtY1Ui4Cg
         ctZXr+SB/yW+wmojj+o8+btk7QfmZdL8+ufllWmGhgcdapVYxx32AWcoPL8pn7eplnFD
         52Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUWZvRIPmczIGWlmJgFHskoQifcyNV4yByohx9Zm+wNydb9L24gQSOrISa5AZBuxrnv5CIo8hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8YhNpoTbD7Jy8b6fQ/0Yks7YwpY278U2ucVlbMTCW9nYg5gQ
	leofVOdSW1MYSJBdKruhPX2SFafHiYTQgizRB3gja5onjxXIJhW6TJFy2xV1joS9j4TUw7poBy4
	PWxShhqdfYVuoIZ0MsJ7fm7xteESjjGk=
X-Gm-Gg: AZuq6aJs4OA0tVaJyeODamFuKrtapGZbgOvEyUrByubJzSfQp5RSHn/xFA9knGkhYTB
	zshGhieRgHDcbVW09LZay99dtT7+4DhAVOAr6wVlUSlhmOaD9bOsX3IVItqTddssxZYDQjMWdAk
	V2f6WzEXzyvrbFNIgkmdfkB7ppNz+DTPNBvT3b5SP2SuAnxc7e1ECZ3IiUALIxTUo7Yo5RuRlOR
	aRnU4iQXoguzeH0ZQLn6Ck7MOfyEocMbo0734K1jYADm6XOfOTHn3xpD0ypqrUh+zgPubMwwPyW
	jt6qMV8MoOT6k80SqYhBfjmS3z7F5yyIpKDOAA==
X-Received: by 2002:a05:6214:1244:b0:890:6331:7e88 with SMTP id
 6a1803df08f44-894cc8c78edmr115125256d6.44.1769681850480; Thu, 29 Jan 2026
 02:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125200259.2903271-1-dam.dejean@gmail.com> <20260128190213.57f89092@kernel.org>
In-Reply-To: <20260128190213.57f89092@kernel.org>
From: Damien Dejean <dam.dejean@gmail.com>
Date: Thu, 29 Jan 2026 11:17:14 +0100
X-Gm-Features: AZwV_QhKtwbRbhZkhP_1x-krxME0HXC7u9WmW_2XB22Jhr1HtclcbA1zizWEIcI
Message-ID: <CAErgN1AB+XsBRWaEf+s9=EffMkdigyJ8+2cL-Ze=QjBAVcVS+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-order
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	pabeni@redhat.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CA63AE95C
X-Rspamd-Action: no action

Le jeu. 29 janv. 2026 =C3=A0 04:02, Jakub Kicinski <kuba@kernel.org> a =C3=
=A9crit :
> There are net/phy patches in here but the series does not apply
> to netdev/net-next/main. Please rebase and repost.

Rebased on netdev/net-next/main and reposted. Thanks :)

> --
> pw-bot: cr

