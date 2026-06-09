Return-Path: <netdev+bounces-297085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MdmELxIpKGoy/QIAu9opvQ
	(envelope-from <netdev+bounces-297085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93866161F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E5lg8k8A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297085-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297085-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69B330DBE66
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB7352021;
	Tue,  9 Jun 2026 14:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089C34DB6D;
	Tue,  9 Jun 2026 14:33:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015604; cv=none; b=ha7mPUmNVvRW5Jfz6rRS1OUwIff2bE5N9dkdCukc33+HPpRKfKPLuHWGbCE6D/zDgwmRv2xoT93C8Y1k3zhXuGoXWJasMZuBN2vgORpzZAtFFuUiTMk7kxOTkDAvrn6112oglGHMo3LeEsxTztVhBsBAXl7TBSFgkcif85FGaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015604; c=relaxed/simple;
	bh=wAEZvY4eQAWxxVcgqKI4rAuKhJ2qJoTvHcpl34PSwd4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bsOEt+F3vPovMwlnQhfId1UrHCMWsyKmf2lXRKD8EFkuSOSUTrSbRC09MnqQfCHvaIy2nNZYhMpjkAiqZfUeizmsT7Zl/N3ssY7835uoIK+FzXKl60l/8JKkwoTE8s3mZeR4X/S8nitmJdpL9sV2YAPMtglykCaqlFTkdQ3KlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5lg8k8A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5931F00893;
	Tue,  9 Jun 2026 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015603;
	bh=w2pedy2PeBTO1HpSLjrjo1G5zMth/Dov/6XcmtDzrSs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=E5lg8k8AaFA8NeiSOLbdPOJxEPOHzmm7aDV9XCPtvYYpK0heQWohZivcTCFgPHLjQ
	 anMLGjv9xWozc80btl59+p0OIspWFUpAsrq3VyZ84EiU7mlPKeKUP39BkCGgmn8rAs
	 xGTCI+rAjfrS8sKKH1lOvGWoMubRbLfO4ermwxmlAczjmyqSMYMcojO5unCe+B/Ze6
	 gNH0NNJ2jJuKenu/q+Kzpi/5wMsNnVcz2xQXBuQcu0+h63/qG1M9mxBTYwAKXI4ZPQ
	 i2ki5HJUcDe38YvHeABPC85/TiKWcfhMdocsRc4Bt9MbYFT2vsWXaaiOda9ZCuOBO+
	 AOZszKK/REhsQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4559F40071;
	Tue,  9 Jun 2026 10:33:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 10:33:22 -0400
X-ME-Sender: <xms:MiQoagl5cbauXEi_fyLuoKzqAocfCJaj5Tz-BSnIaaI4bmtdQgcIJA>
    <xme:MiQoaqpy6d6G9coIz65gLdF3sAON25ZrwIHuSmI0mUHKF7qiUFDLs2ipxnH2L_0EQ
    2XMrxNhJL5QLh6eyIKJ7ZMEVCTZsBguug_4nWFo2bQQc4OnWUqn_Gs>
X-ME-Proxy-Cause: dmFkZTENpxwfzRxzHq+74KNN2xz1y+E3R9SUWWrJKflaTircoPAjE5Y6yVsfO8HNmb9TMC
    6zbu+0tScgE4tt2wcnvJ9S7Y8GOZmGZHgY6z1vT/3Hb3MZZl9IYOWjmK1ZVX+XFZRnwmhp
    jLgh9h8w34oQik3Tkerg0m9bxoVkPFc+/Djo+g+PKGCwP/xcFGLw7DTa6UAB8M4hCqY1YG
    T46FqJGxqQAc3vuXJH4YPKn3uMshvIcb9WCn0twsFIdi5I6wZ4qu69JjFVwhnX3yalXH3/
    i91/kXAHrmP76FWrJu7SMV1w3ajy4GLrJ3oEMgP5/VTSMtTSYUl9SMsemHbCWkxwBkodFo
    ARbTDBuFsYRY0PejF3nCRzPYvPIoEsPSHYy2vz0PAbc5pu6RTT5TNQQvFnGF9J2kLuOh4O
    /01qEKJJgVilgwXclN2KZzA9winO9k5u36hk/O4TFUBSiC2DajyDCZRou4VYFM/uvoYnx9
    kAeLlL+2NX6P2PECpupaxUvdR9JjYqWtSeFMH59REwxui/mux0zjk0mizKokV4+WOgukdN
    8pqeHCx1K2hmdW68HMQzMuwojGUB+6OzxmMHOGXUVtYvvKgQDqStlCXq7imucBEOQ4ssgk
    EZvvfW0O8mVCnfUl9uN2H9NmqeUI/Ysymwa759hUskk2+ZMIYr8K4hFxq2lQ
X-ME-Proxy: <xmx:MiQoagzPtHB9Za9oYRNT6AIXPfb1sYTQxxRn3k4oJNN2eMPduloFpA>
    <xmx:MiQoaqRnE4_jXuR2ypjsxpPeUD3fQ1XtDV5KOjC9N_qg6_zVEiaNbA>
    <xmx:MiQoatLhULEQrPGcc_RsmxPVIzR-vPxrr6LlhA-aZSp1cMlJTCR0gg>
    <xmx:MiQoahXjXDYFTuXlZWOpfN3kApt3cI0cqv2Exu0Yj6s55chb-Ga9Bg>
    <xmx:MiQoahRQaLAac3d9HiG9epz-cgZ-8AwihUIT6EBZxn4lK_-HzvuqXZ7_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B5289780070; Tue,  9 Jun 2026 10:33:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A45RuLSWa92Z
Date: Tue, 09 Jun 2026 10:33:02 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Eric Dumazet" <edumazet@google.com>,
 "Simon Horman" <horms@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Message-Id: <b1956bcd-19e9-4d9e-92b1-3f3522047d61@app.fastmail.com>
In-Reply-To: <aiXsa5zx3u0DUn0l@krikkit>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
 <20260604-tls-read-sock-v12-6-b114efa6e3e2@oracle.com>
 <aiXsa5zx3u0DUn0l@krikkit>
Subject: Re: [PATCH net-next v12 6/6] tls: Flush backlog before waiting for a new
 record
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297085-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@suse.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E93866161F



On Sun, Jun 7, 2026, at 6:10 PM, Sabrina Dubroca wrote:
> Thanks for your patience with this series, Chuck.

The netdev patch submission process is significantly more
complex than when I did the original handshake work. I
think I'm mostly up-to-speed on that now.


-- 
Chuck Lever

