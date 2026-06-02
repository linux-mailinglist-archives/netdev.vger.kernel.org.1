Return-Path: <netdev+bounces-294461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wXEfJL5jH2r9lQAAu9opvQ
	(envelope-from <netdev+bounces-294461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:14:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DB632C9B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:14:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=BzxVFRz5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294461-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320DF3007C88
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50883CF665;
	Tue,  2 Jun 2026 23:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C043CD8C5;
	Tue,  2 Jun 2026 23:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441892; cv=none; b=lhHpXzpH1JYRg0sifQPOQ1fLwADUY4ynSY0rZ1Ce8PTq4DUOt2dj8rzXJW9D3HQojTBlBs60YbY6YSN/3D8qJIHQzIT8pUNK3TVzqtivGy/EIg0fLnR8l3MMczWnkZ3jh9+vIthXkWECGJ0+jF4kQy27jR/oeiaV6rbwN9ISJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441892; c=relaxed/simple;
	bh=wNxQLyr86kdfMlwDkf+HMvpVy9oVxQtDzqrOXbvBLLw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A51id2flhJV1osIywP9d5Q1SxZUAA4q5iwJJig4z8Y0TmAM38Oa53RhPVAM3uD2cputd4h20j7izdDX83aNTHqHir0X07RAtl0HdGpCK2Rl1oFsy3q1QDIb4FRTfqf/HM1Er6uc3tr16Ex2j1l7Xp0uRH1izqmwbVewLYGSzBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=BzxVFRz5; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652NAi19003927
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 00:10:49 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652NAi19003927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780441854; bh=wNxQLyr86kdfMlwDkf+HMvpVy9oVxQtDzqrOXbvBLLw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=BzxVFRz5S8QUAoOolpOI50Hvs88fChvAJcEan6FTsXGQoPh2EyVe6xz9Og020MNA6
	 dg4hdXc4krjrPchZzqD2G6tVVHJUrB65H8ajF65ndA6PF+mAf3ROqvcswrK/cmhn5S
	 TYZB/fS3GtiSPKBv2+Nm/Z8GUEaacZULQRZYb4QDJhTLolUdDf9JKhcQB4gOFxtDvQ
	 B0EnFvGECtTnCGSMiXEObG1K9ZrGH6x2AtFskS0/3amDSOp0iPEscuHYq3avThyRze
	 89lwkjsJT+Db+ao+fqvGdhl1Oc85bGhn+jgKumRCZBviwipI+Qcm+qXZNrXGfjmikD
	 +ENdkNcxhx8aA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260602-net-next-mv88e6xxx-cbs-v5-2-1969758d1fa3@luminex.be>
Date: Wed, 3 Jun 2026 09:10:33 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <430D20CF-A14A-4692-AE27-D996E90BBF66@padl.com>
References: <20260602-net-next-mv88e6xxx-cbs-v5-0-1969758d1fa3@luminex.be>
 <20260602-net-next-mv88e6xxx-cbs-v5-2-1969758d1fa3@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294461-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:mid,padl.com:dkim,padl.com:from_mime,padl.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D81DB632C9B



> On 2 Jun 2026, at 7:10=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> + int hilimit_reg;
> + int rate_reg;
> + u8 queue_bit;
> + u16 hi_limit;

One nitpick is that it might be nice to consistently spell hilimit (vs =
hi_limit).

Reviewed-by: Luke Howard <lukeh@padl.com>=

