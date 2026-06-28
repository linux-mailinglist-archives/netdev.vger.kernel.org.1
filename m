Return-Path: <netdev+bounces-302395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nT/3BUckQWp5lQkAu9opvQ
	(envelope-from <netdev+bounces-302395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:40:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFC6D3E9D
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=LeZUp2Xm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302395-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302395-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4FFC3002526
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911883A545B;
	Sun, 28 Jun 2026 13:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669219539F
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 13:40:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654017; cv=pass; b=nc+yCAc0l+0HGFVgedup85uMqGwGMeEYW3MjH9ORudJ2sqx9MOJQsvWoG4mvYApTTX0iNWK/U01/baQaAH0tjsps82cVsKRDLx9mde3JANgn0FLbD4v6TR7oUHp3Rp1nICtsfJLCz2lSWXjbDwg/NpAIun9hD3nTr8xXISvsK+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654017; c=relaxed/simple;
	bh=FzuZZpRujvRSspChgEDWfWQ8jZAjZZk8qpSgMxhUXPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMgYc6QAuj9XwamqU9RVMewuTkuXrZ8pwLHa6zxgQxY6uSjRbFh7cG5Bam4qN80pptF941EzaYEn0gUUFXS4pDLHvPK0oFHckCDDPTC0/XCFlfDmRRU3/pmJ/V1+x5q2l7gP79PNTA6xo7+5MTuhdau77sNMnkMxV0nTt4ecq/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LeZUp2Xm; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb78090edso224874e87.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782654014; cv=none;
        d=google.com; s=arc-20260327;
        b=roy9qJkP126L5/IJkTf5/OwrzETq/BC71sRslDh3TaJUyz8ZGSzSC4mXQe5HxURWEd
         fAdMqmOMLlFKf7KP/X0EMkKw4akoPT/hPhsN8hS9C4+feBgMpgEWOR4ZTzmNXd+5iBpi
         JpQex/a6IpaSYJbh97MKhSA+TJ/SyW2IzKzrNMUXFEU65XtVi2dEv/yGycqi2h1XoeYz
         oRMSY6XURvbda/NzRfHLSJKu+hDjVBr0qHhKAJI/Y5pTbNJml7YmjaYS1hA2LWMTVJWy
         o7BGXS7zcQ0xR9Q21RWaxaZvRZfmB8Je15eKmK+DcGL8wPTJySyhOZ0qI11OGZ5xOmSa
         gsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+U6D74s1OM9v4B5uHrJIifu6G+02KUQ/7JmehaJHT1A=;
        fh=DcxxMnCPW4bU6zjRffkBW4zr0sdVXPPh3Gyy++LnQW0=;
        b=R2Zdo6kHhb7BIFlk4huuPiuGv8U84R+21f/3cuLHomG6EJ3y4Mk3NHw2I6zd3s/t6d
         1pQLlY81G7NXapqfGpEXeIx5zku+w/rYWFetaUHoX366uXpw2w2sQ/ZOv42fcan1N2ve
         Owz7A5KxfvkWmu1LXddkoN7QhQuYpaIaehatejlJJTJqjIEfB7skScnul108NG9Tc5VC
         hCEAxkKzyeJymj784dsQw1yhsmXOwkSby4YObr3rK9xNGTFLzdW0Qa8p1t6PcWP1TsM6
         fpj3OJjSR5itbb12VARHiPmcU+JY219+nnMkPIMaKPeEklG0Z8MJecUuEcbJSp7dbFsh
         /y1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782654014; x=1783258814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U6D74s1OM9v4B5uHrJIifu6G+02KUQ/7JmehaJHT1A=;
        b=LeZUp2XmlGi/mKcXd1tNbqSzWq/y4Gr0lD3P3c/CqqRoCrx3D9vaBjJnrOIduXZtF5
         IMxvU+K/wo/twfmAXahgFHlhdXY+oI3SoZ4QeM7sX9rfeWpKysvUWQIF3nI9pYiI2lZl
         rBoXQ1rXW/Pn7xBuFPikKurz/LHXZgRjp/QtIKPYwJP1ZWuAvyP3daVY2Vb91V6vcAPZ
         EdvR2J8QZ92AWk96MoCsVP4zodz/jCjiYOKeNJ4GjyU/Fg+ZfZO1dQ5Y90d9dOtyi2FL
         ZiXpjm0nFuJb6cZbuZB3f+ctitnwJ77oh8HxVtlckeqtKnASKhljFZ630vU8fZ3Sooin
         LTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782654014; x=1783258814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+U6D74s1OM9v4B5uHrJIifu6G+02KUQ/7JmehaJHT1A=;
        b=AKcqCt50gWw6MKxBn0A8eZcvvm3mqszOo/MTcuYeAE7FAS1SvkHy5ov51jn9nWLkJH
         8JAdI8Vr2bnLHd5xTokYMkyp0m4c+xcXyERRy1C3FzbERUNpmCBYC8kOzYFN/JqTzF+Y
         yhapDmKO/0rdV/kCJmuLgTV1UHyANiZ4Mhjedkx0IB8P5t3R1nQrc4H2JorYv7VI2/l7
         yeOHhqD/nCxcXR6LGh8+4Q7NmeqI66TAyBseZj8se+oV6vHxfhwVHG9hdIbwU/zpeYvj
         106UNhPndRAFdlW1fYG3Gkt87uJfNOMVMsFvyN0pY0SOjoycEN+xUOi8vTGsXheYFHHJ
         c+mg==
X-Forwarded-Encrypted: i=1; AHgh+RqwJFrA9kxNpb5SY+frKfioK2yVDi2RJEzh1UKuaQIy9K11DDltG5I20259F2+rJ7nGG0xPIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6mqo+NiPIhDs8OLjcvO2GVkFSYoS3n010imSoZiiPa19E/9D
	0VrDGU8l1ot+RXmRP5u0geOflliD8nOhFr5Riy9tJR6pl1gB1y5kbiFaLGFKFsoPOCTh77NcVdM
	pbm/cmNksvQAXezMF5T0dzfefw6m2VDtTT8MB4DQXjg==
X-Gm-Gg: AfdE7cknJU3ugoKJDybJVn9ZkEWzdpo/U6ROO7l2Y7v7+4xYILmsWljDI0UHBmeB4SI
	0pBNiVfSjqpBbZkXRJjbJud19yxiIiX5dVTpp7Lu1iDegqQ8iRkcYx7CjHDqyjNqTtnX71rLnv5
	eLJRbLo2bxVzoOfTDFd2ZvFH3nQj4Hzk/K++aFjP7E2xLWVX+sM4LDQsrJlpzv/pEjytopfd569
	Wj+JugBxTjymUN1mgpvr5O+r3lVBtZ2cMMwxBI0NgRsxep4RyycKZRXou6iy+AJ3zcnLto=
X-Received: by 2002:a05:6512:2251:b0:5ae:b91d:b2ec with SMTP id
 2adb3069b0e04-5aeb91db406mr27884e87.3.1782654013791; Sun, 28 Jun 2026
 06:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
 <20260609185625.6e4bb757@kernel.org>
In-Reply-To: <20260609185625.6e4bb757@kernel.org>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Sun, 28 Jun 2026 09:40:02 -0400
X-Gm-Features: AVVi8CcNdyL4Y5NRBNdhaW1cbAp-e1dhUBR2BYubCS3fIjlgvTFcDhMvU86l29g
Message-ID: <CAE+C+DYnLBQP7+kAM1m8E1yTAJomgtjp00xN4nMLqugch3QMag@mail.gmail.com>
Subject: Re: [PATCH] net/sched: drr: reseed active class deficit after quantum changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302395-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7AFC6D3E9D

On Tue, Jun 9, 2026 at 9:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  9 Jun 2026 00:36:18 +0000 Samuel Moelius wrote:
> > Subject: [PATCH] net/sched: drr: reseed active class deficit after quan=
tum changes
>
> If the change is not for a serious bug it needs to be generated against
> net-next. This was generated against Linus's tree I guess and doesn't
> apply to -next.
>
> > Changing the quantum of an active DRR class leaves the old deficit in
> > place.  The next scheduling round can therefore use credit accumulated
> > under a different quantum.
> >
> > This can be observed by making a class active, changing its quantum, an=
d
> > then dequeuing with the old deficit still present.
> >
> > When an active class quantum changes, reseed its deficit from the new
> > quantum so the changed class weight is reflected immediately.
>
> TBH the current implementation is how I would expect DRR to work.
> quantum is the "refill" value, it should not reset the state of
> the current round? It wouldn't in an ASIC.

Your point is well taken. Thank you for the feedback.

I withdraw the patch.

