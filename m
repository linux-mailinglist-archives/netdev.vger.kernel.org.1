Return-Path: <netdev+bounces-290171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LFGLrFSDmqm9wUAu9opvQ
	(envelope-from <netdev+bounces-290171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6859D4F9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A20E300517B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968E2417D1;
	Thu, 21 May 2026 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzSjS7pX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309B2248A0
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323561; cv=pass; b=SJCy6X5d88tyuOhKfo0rm4z/uMrPm5Iwk40iBWSJsKx9FciA75jdvF8Lfnsoby4827JXVXmG2P9mirKwZcqCN2tRQw+J0xeNC6E5zBiwr702/gLdfN8hwqN3FfI14EcFXXMi/KKbRDZZ3Z+Q7jHNvn+Povpz9qsMWRcnD3fs2bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323561; c=relaxed/simple;
	bh=OP0rzISuFZMersn24fxgds7E6SVOSrMeIz6B2yS4+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEkOUJJe67dewOiJgB2T4ot97f1rPfz5Wo9OZRdKAd1aj3Zn7UA+7d/aGdAkG2baYjVeqihW33Dmf/P6CBDYHqNJBrcylk1Lr10DcAknKsuky1Y9u0ZnzhJV3C71PU+Iz/LbI817ruMDTWt8xtVOHifFnETkwRaeBGbzfsDgCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzSjS7pX; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bde9d73678so55751337b3.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323559; cv=none;
        d=google.com; s=arc-20240605;
        b=JqxiIjNVmmNIkIYrUvB/rTeSlK3tuYor9VdOucgQG4Z3R1AY1YkG5iOGz7fTRJl7rk
         MpQmayBsiwWlscfie4fDQCrotK7iclYhLgDF/sgF6VaiEUbXmrAJkS5Lw4lBmZ6+V+Qr
         jZKY82P9ZDr6KMnchVb8LD2XLVAivsxDZZzUzFntTH5C8WkybswyMmAKp8YYSvhbXA6F
         Zec6chqcrhrPqsgKkqtzhwdMhGDyTv410exlYWOn9KavR20957JCsGdxU9Qv7c8gTZuK
         yt7+PM+VP3GrwHvs6zW6Tc5QD2E20YAWYl+z/5njnAwsvtC+AXU19UP7JfuC+rYDuI9D
         S3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        fh=zNx3f87d27eYEwDYSjeYjNVyoA7HB4l2MyDR9L+MH+U=;
        b=MPbQEMhIl23FjP6OSVgO+0rQctCgdnsPorkSwVezo6Z86D+PgfsnggK1zXZ4B1JSHH
         jO88e0z6fbuqelkw/psqarElrv1K0gm0q46oCxxabYyGh/zQ1X9wmpY0d2QM4rmgYto9
         qY0OcdfAzbMMVsnnSMko90mij1pdxw9tLJQh7/7jbv+ktGS88Kd8oO1M4Cx4hOYUYvqW
         HUm9mE1clnKc9Y6jaUcG4P//euvPiFpTM6A9r2sH+HPACV1xejK9j/sk5rwHC6rwaE6T
         SLOO7KC2pHsvRCRjLhAOwuujXkWKorBOXKzoc39isUszAYA7RoH3JDl2XHAMjh/tU4mR
         qz2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779323559; x=1779928359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=GzSjS7pXFONvmIVxUl6Pi7we9+L+uSqnJMptkrS2ayj9l5xwIprKGk0tGuwSt5Nd7S
         jyeSDWJqSVxPkAe+bI09V5MG1+d1UMWR5dj0ppsbn6UHWfZI3PMMsFD6LK78E74ttyoN
         qL2Z2J1vzDs/BDh7ylbDigCbnYdaaOJOinLGU0KFwonifB1kXp+Im3iuMdj35l7IqbSE
         nb5nMujH0Rprof/9IyIlvoq/b5PDuxXCTa0uAd+6aAvAuJ8kT9WAIVjLWVSNeYiD3BzP
         WEERrk+GHQYOMMLxD9CBCaL+u6+n07VidQYjvwvWR1nKg5WbjalxIu16qOfXAurzieyt
         ninQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323559; x=1779928359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhajUCYXfqOok+MfrNpNJxWiiWQYgUj5KKgMHSaw5Ig=;
        b=GoeA47JEz/ttZViaCHg2QaQsqX1+SGJrnenWPWSIVS6rJWX9Akx2z8x3awyVdtl6u1
         dRezj2qhL+EsprobZnO5GTKFMPa2EOxvA848AXbCx77J1rmimcKypxrKTX4fA4FM3Raj
         T7T2txKBMLt9lvsqoyH8C+Uv2pzNNWYy/mjb7Tc/k/BH+Ezr36ctWDlAwv3e40SmeAiN
         naHf+3x1yD9kEElF1dq03uTtVsiPatfbrI6gLuoLoxv7niGQRtc1jJGJ65MRLCASD/u+
         nDUx3FSmLDdAGcncSI7HWF2D0kWH6rDMW5EGykESR5CsmgKJSxKdhOWgVP0uxy09BR1R
         BZGA==
X-Forwarded-Encrypted: i=1; AFNElJ9kaPukyBq5q9JMB06SyOO1qo2oAT/1iKsWJY7T3ROD0yCfHw+yO2NXSUAfxP2Nx3MmznUVKnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NW1P9XhkfrcZ412SHXL9Mbt89vD0OJEVpcxLcz86v2BzbVEa
	RiEOWtjA6+rUAWXMQxOGYjORrKcpIvjl8dCfyXfpBmpukACvAGVwea3kqJHOhKkGtR36QHfenpd
	c5bncIW6zkaQXBLo5VBa0IGdaZG+QjiI=
X-Gm-Gg: Acq92OE4S1pOkY+B0PyI+0YeeDW9SRXudcdzBRpoqPxOLlARSh8HMhgnZdE6kXw8kjJ
	iyI5bjdGULVnokRHkFLlql2Eds59Xgzkfhq+z+FNur7MIf23vyBgB4DF4WvwXT60gm0W45WL5V3
	SSOsj0cln/+gYXFf6gFAPPmeiVvfl3Y50H1mZ2mUztG+0M5bRctNiG/HviDE4oGx+B1OT4vwHlf
	vc1fG0FlJ2AZ0kUkyU/2Mp2V6y7/ZMBfhqbrp9FbJaUle4c4rXYo2xTMOq8KEfafOLapMDGlfFX
	Fz+RxprvXmx8C5yq3rTgRvx27Y1WJUPErtwvZL6Oxrow2Ck=
X-Received: by 2002:a05:690c:9c0c:b0:7b8:567e:d536 with SMTP id
 00721157ae682-7d2121b6483mr5682507b3.2.1779323559343; Wed, 20 May 2026
 17:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521001327.3729880-1-michael.bommarito@gmail.com> <20260520172609.3034337f@kernel.org>
In-Reply-To: <20260520172609.3034337f@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 20:32:28 -0400
X-Gm-Features: AVHnY4JjnwDy-U1Kl80IaCEyqbkQHgbt1kHT_KAMJQzF4mArDJ7BYqgCfg1ZDGQ
Message-ID: <CAJJ9bXy1xQsfRd_DBiFjTj6GjkDDVFU3w_5xjXvZmp8CXnkz5g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,davemloft.net:email]
X-Rspamd-Queue-Id: B1C6859D4F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Please (tell your bot to) use the get_maintainer script.

It (and I) did, but I think this is because net/bluetooth/ matches net/, ri=
ght?

Here's what I see when I run it.  Is there a different set of args
that I should be using for netdev or net/bluetooth/ in particular?

Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH SUBSYSTEM)
Luiz Augusto von Dentz <luiz.dentz@gmail.com> (maintainer:BLUETOOTH SUBSYST=
EM)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)


Or did you mean because of Fixes:?  This dates back to original git
import commit, so I thought the practice is to skip a Fixes: tag

Thanks,
Mike

