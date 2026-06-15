Return-Path: <netdev+bounces-299575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CgObDGtSMGodRgUAu9opvQ
	(envelope-from <netdev+bounces-299575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:28:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8763D689706
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:28:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cWVQHqa7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299575-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC2813061699
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1CC3B42EF;
	Mon, 15 Jun 2026 19:28:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DCA30BB8A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:28:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551717; cv=pass; b=uqN62gEdnuHy1Teclr36Tw8z8HIvfmzT8A7P+K1HSGh8YbK+lJOIhr+zq/0ZvJmCmR7J2n9cONzNOOxICOsrQs7zoRLiyU0Mib++I5WDqWJ2/gSlCHMOvm+zxncD2syo34jiH28xwbTf5CHHrYUgWeMhdkjeAys0UNTRB3tgJTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551717; c=relaxed/simple;
	bh=QxM2o+oxxRfHFIpPp7v/vof0ha2Od7E+bZPcVI3YQEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCvWuDECDvHpQUZuWYOpxCRhqhuzGhpwKT92TD4/nXgqFOgQ9Kadroy9ImNvHlbHL27d/RvxizlDtkeEWNlvupOWmOdb4ZEU1/3clTcehJ69ty1Y0Bqjt7A1tDPVsVTLUPIresk6/8+8Rxlay6Jt0XhOuEu/qMyiTwnzsdiyWGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWVQHqa7; arc=pass smtp.client-ip=209.85.167.178
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4863ee8474eso2473567b6e.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781551715; cv=none;
        d=google.com; s=arc-20240605;
        b=jyrl6ZBXP3D5Po9T1054fX2QJtxnDzMx/tap0qhBbg3iL25sjqszqXsxbJ3weAWxqx
         d0DjwpkypmsiSuWvNZp/gSRNTzBS8H28KbjiS5L7NNLcsWQaxIqm2cDQFd7bX5QVE8Zm
         Kyeint9tln5vyNNtYqVjHU3kV2HHg8kIVNJk7JXODv84MyHg+9ey6Le6bCw+IJFOF4y2
         5PCi4XE9yEpSlqK8W7wQJGn5w0eICGG8swmyD/29siQZOkc82AXArM1RtQx7X5I9qRp/
         S6Z/jmgxzpOEyt4gLQwGa9KOLlgufWCM0ThmxypUA0iLt2D898PjYeP4yeefvI9IntMD
         D+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QxM2o+oxxRfHFIpPp7v/vof0ha2Od7E+bZPcVI3YQEk=;
        fh=sAYpwydvxS20qzBKxkgWQat7CfhGwSllw5pDLOWQY2M=;
        b=jiGqj98ukGOVPPpUkqYnTBfmXtcTQ+YaPSJx1a3EvTiqmgllZAAl0CC62ftTkkyaBE
         eScxsc0984LREMI8o8gyXQ2EWo/1emncIEaTXjLmXSstWIyD8gqh1FRK7pUlGUqeXcVE
         ImCKeOy8y154HBDsYD1OJEFrXd/f2jXP42gBCfUACsy8nyydKE0M4LE1Gnux6EjnbJ2D
         PvCRMDWJvQ2zsLe/OA54W3sAqACUYTZTEui7ePd0TQwz8FKSM5cFoRbgSYTiCYWbh6JY
         GFebueUd4ERgtCfrNRmxpWSphs/1wInNwrW09B6IfMi/cDqM+NxuHQ7u+TzN23cmB2wC
         ScXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781551715; x=1782156515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxM2o+oxxRfHFIpPp7v/vof0ha2Od7E+bZPcVI3YQEk=;
        b=cWVQHqa7XQbFiYY55ctzxkcHk631e9Av946JKKeN5lKDrmS2EuQyhgjl7nj2O+SDPB
         39irM0F3o80VHeBn3HU4z8C+Un3nUEruGKSpQWsF0n7OhZL+v8i2bnXqqBH4oKvirChe
         /KPhG4ItEI463zNk0MKVgI59Xfx/po9GT1oauzsoKX7ysistBqquzaVXePuRT1nAKG5f
         Srssyvdco2hMuqFb5pShKfANpBJ7X0M4LcCj+AqfqYILTvEwJoDd4uxsVEmGRHvutAtf
         ZmWq25e2OFGu5fXYmw6gIXTbrF+Hx11/8aHj3j6gRjoIc3I1Jkwd03K/9yKdBA9I+wJF
         LJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551715; x=1782156515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxM2o+oxxRfHFIpPp7v/vof0ha2Od7E+bZPcVI3YQEk=;
        b=Bc/bpU4jo3Kx/QmKB1iSmhgxKath6O90p1LHrV7SpxbgEUUG40nMP9BRdgt8l77lw2
         nLqtjzrZibpAGTC+lw1s6IXhLavvS5KYgmz2U8+llZyZklNyTwVRmqi48UnrKbniw3jm
         ujeklzvLQcKfZLGxD4FMvBPj7lJcfQKegBvfMb1EEhypyPcTOIZaMAygUh8Tbq/JtsvC
         D9J00XgE+4kDK+fqOPwhTAQ4i/csWrUK4UHacR74HRk4WqHuLSIqkgQMwpNiBsLh64NV
         umusjDtKnQMcwr7hi3KMmwjsrMyNy0Ku1ibqCk6hUm1M3Cfx/mnSxNOILs46lgoT4uwi
         L/wA==
X-Forwarded-Encrypted: i=1; AFNElJ9GN+3Y6Oc4rUlY3fiodyYS9uG23NWYud/szLzi1aEPW4wf2i+4P+vIXbwMsXl8af55mGuLGmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/iZoElNNwMglz+orzhYBlAhmigK+xUsynIOkCJyaOLUHo4Mcb
	0ytvJqyvokTPjp12qlpowofmZAIlo70d5ZNI1mn8BTlP+rkgGOY6UlXpSaEC8HYsYQyJ65//0Gn
	82/qe6RbMOp2BhsXwwi0RKzKRinDVT7Q=
X-Gm-Gg: Acq92OEsQxE687VeSIWtBwevt4fAR87NTRiW0Z2Yi0oefCzMsbMDRbcCn//3bczO3Yi
	qxKmDy4lkt9v1z5OdgmNFfZOci3P/GEMpQ+iAcsLaZRXZCSZcs/msL6XLBRqzqHcdM4rmK9HRhH
	wjFqgxnUGdCeC2bU67TRYP7+KRZmHs/umcG7UczsBFp7N02F9qaR6+3wHoDuWYH7igequYi+fAC
	6YzlvMXR0qaQ/rj5ncTIE5P7+3HHxDq2XodDwxSU65BvOc26IDNh7vek8YGi/WLZmV45600/isG
	5miuqlaOY4AcOFJEBPnOJVpz6XjpSKHAILNt28Y=
X-Received: by 2002:a05:6808:4f1f:b0:45e:f0af:5148 with SMTP id
 5614622812f47-4884c15409bmr325938b6e.30.1781551715056; Mon, 15 Jun 2026
 12:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com> <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
In-Reply-To: <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 16 Jun 2026 03:27:58 +0800
X-Gm-Features: AVVi8Cehmp8CKRe2OQlszCNtcw-kt4m-YUvrG54WzAR5hO1v2gAOIX-jD7Bk7Hw
Message-ID: <CAAXyoMOy3dQ=--fjQtdvwpV_86kzT3Mdeouyr7WnFj-kqwtD2A@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ming.xu@motor-comm.com, 
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, de.ge@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299575-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8763D689706

On Tue, Jun 16, 2026 at 2:55=E2=80=AFAM David Yang <mmyangfl@gmail.com> wro=
te:
> Please, start with a minimal patch that only marks functions which use
> different registers/procedures and makes them virtual, and implement
> them for yt922x in the future.

Sorry, this should be sketching yt922x_dsa_switch_ops with existing
methods and filling the unimplemented later.

