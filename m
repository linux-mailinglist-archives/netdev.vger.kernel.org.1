Return-Path: <netdev+bounces-287345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGUbKCm0A2oR9QEAu9opvQ
	(envelope-from <netdev+bounces-287345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:13:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1077C52B393
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4E53064675
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984E3A640B;
	Tue, 12 May 2026 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8ix4T7L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1723A4510;
	Tue, 12 May 2026 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627598; cv=none; b=nU9bNd+vaNFFkT1G4O/k+8JbJ/HEAvWxbzub0pYjETnLVmrDUgdUPcMEo/SayuJSIh57MEExJQc/giVQYkw6H+PlbWxBb8rbMf7+YS0t8IiWmqoMn6nDZXLqBxgADWVc7Gqf0gwNDfAqqky0rvC128zcsXZ2bDK/qJpaqtjpFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627598; c=relaxed/simple;
	bh=7y5ERZ+46G5TuZ6kypctntsWjjmLUBio5KVlVFgY9Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0tSxDSUQqFlKx/SYGMJ7XEOZ447qxgDHu+7p9YGOIFVjXB8TeU7hpgO/pylOvNS+ak9mD1TYyv+ipVLblfXJr9ZsWLsT2ZnEkOQuWM9QQugRNXqpeM2khDr2J6zdkbQIWFeZqAw91prGxR28i1amo/KDiwqDLO/4suVOLluY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8ix4T7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E9CC2BCB0;
	Tue, 12 May 2026 23:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778627597;
	bh=7y5ERZ+46G5TuZ6kypctntsWjjmLUBio5KVlVFgY9Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8ix4T7LumVzKwTGAmGHMrwUukpsAmAzFvnrLz0XdT9IECAVpIFPzI8JAdwAjELFb
	 eEOXvwRJm5nKwiHf/5bwAazCxNLpjjYIURLL8u5VLa2jLpFYeCMrf0TzKNrnZcgJ3k
	 b1lCRWWmuNb7/GLTRAnrSQXC0w+Xf2ly6Yt7jub737/bcoKACKWpPLlF+VCL8d8bld
	 +ASIw4J2jCQZw86XzI2rfrgQWBcvoQF4p6LyjzYRgVlHTseYTsHE0RaF3T6I2k9mJZ
	 OwdU7ctOnJp0Ts89wGEA+Md1HUBm4TJwDahotDhq1bYxG1AgaLLYqPhajGxV8kGAQ9
	 YJQWeT5Ho3mBg==
Date: Tue, 12 May 2026 16:13:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: andrew+netdev@lunn.ch, devicetree@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
Message-ID: <20260512161315.141aba88@kernel.org>
In-Reply-To: <446f69bd.7fe4.19e1ab248fb.Coremail.lizhi2@eswincomputing.com>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
	<20260427072508.1151-1-lizhi2@eswincomputing.com>
	<20260428180625.738223cf@kernel.org>
	<2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
	<20260430163551.7491407a@kernel.org>
	<38d052b7.7a70.19dfb0d782b.Coremail.lizhi2@eswincomputing.com>
	<446f69bd.7fe4.19e1ab248fb.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1077C52B393
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 13:39:12 +0800 (GMT+08:00) =E6=9D=8E=E5=BF=97 wrote:
> For the eth1 enablement part, my current understanding is that it
> should be treated as a new independent v1 series for net-next,
> since the scope and target tree have changed after the split.
>=20
> Would you prefer this eth1 series to start as v1, or should it
> continue as v8 for continuity with the original series?

v8 is better, but is the fix in net-next already?

If this is the posting you're referring to:
https://lore.kernel.org/all/20260507083214.192-1-lizhi2@eswincomputing.com/
it has been dropped based on feedback from Maxime and I don't see a v2.

