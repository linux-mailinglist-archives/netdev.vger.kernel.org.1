Return-Path: <netdev+bounces-293324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMWMLHC5GmqC7wgAu9opvQ
	(envelope-from <netdev+bounces-293324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B851B60C0DD
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14B3D300FC98
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5E34DCEB;
	Sat, 30 May 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="HgrCvIbj"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D234A76E;
	Sat, 30 May 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136297; cv=none; b=f06O1BFS5oSFCXlVwtTxxzPNIkpYgmKXiBL1jZ+xACSetR+IaoKsqfsOhowklQeJDOtIpRTLZ4vyMxiMjGS+xs2X+nvoAzLXn3NwAIo5rPjVZ2bG69kq4HBizfZ6aSFw6w9R+nMNVEvOggTuG3iH9dTb132zBgo/wemix9hcEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136297; c=relaxed/simple;
	bh=1hYTjWBFRag0C4bXoiIt78MlBrGGx37tUyyo/Ts8uK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu0AXp1E69CIiTvBmMooMxbi2+B0wb3WdIsRZFtNAEwW9q9SDtXAcQhYOpeZxQlnbR2Maa2HqUACu02hKRlNXu6Ey7CMyHDBaSoZbAHqP05Hxjh9f4frZrz6qU2Kyp9SXUj+zuWKb55jMo612kVPlnHs2l2kWZu18T5qFW+AhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=HgrCvIbj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1780136294; x=1780741094; i=len.bao@gmx.us;
	bh=1hYTjWBFRag0C4bXoiIt78MlBrGGx37tUyyo/Ts8uK4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HgrCvIbjWwV5lo7vCDfpl901+lYctmEWVHOLFvkbV1u5FtJbXI0TUCwE/yhUqB2q
	 vXKDSttrmLrc6/A0ucFluDcA4nVqJ5klEuPRFpZciNLu8vh3LpSKv6CLtqabX7oUd
	 LjrI76RbN68VVm9bChNRkb/2a3Iqzax38N151Y/nZ3tMQhCMijFO7mvkXTLRT5MZW
	 Pi+ngdNZjPLwDUVIeh7UT5kvZh3JzdS+eQtAirmt0DoxUumRSFtxbW8wXafxCduIt
	 1Wno4EllV6dDetoxzhPLJ11nnFy9v7Vfgr/wpLIeMjjLBNXjO1vF+hiFprYR1UraN
	 kNF1yXDcjL67n292Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1xD6AJ357j-00rSKL; Sat, 30
 May 2026 12:18:13 +0200
Date: Sat, 30 May 2026 10:18:05 +0000
From: Len Bao <len.bao@gmx.us>
To: Simon Horman <horms@kernel.org>
Cc: Len Bao <len.bao@gmx.us>, m.grzeschik@pengutronix.de,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com90xx: Mark cards and numcards variables as
 __ro_after_init
Message-ID: <ahq5XVyTGh1ffgYa@ubuntu>
References: <20260516134628.30672-1-len.bao@gmx.us>
 <20260520201644.1528107-3-horms@kernel.org>
 <ahCNnuSAr2QpLl37@ubuntu>
 <20260528100452.GP2256768@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528100452.GP2256768@horms.kernel.org>
X-Provags-ID: V03:K1:z1gpV66GPLFBG0zg2eW23KXqChGCW2hN/DlcR3A47xW35O3dwZI
 3ZVdQN6qaPR1FweNJU3oChZphh24q3fuZ0HL4Eza6aa1MfLEygjeEOFHpRUiWV/5O7a+JNc
 MhCYYdIj1dK93GYvlJqIAceOFhxgktC0Sy38fNISh81uItksPlp8Jpk/ck5TJq3eNguCUOg
 16TwPObk1ZgRPQiMHD94w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ReMRm05kvqE=;DDrZxTeTr8+eLXVnLIfgw0i/l6C
 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
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.us,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.us];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.us:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.us:dkim]
X-Rspamd-Queue-Id: B851B60C0DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On Thu, May 28, 2026 at 11:04:52AM +0100, Simon Horman wrote:
> On Fri, May 22, 2026 at 05:08:46PM +0000, Len Bao wrote:
> > On Wed, May 20, 2026 at 09:16:46PM +0100, Simon Horman wrote:
>=20
> ...
>=20
> > Hi Simon,
> >=20
> > I'm a newbie in the linux kernel development and I believe I don't hav=
e the
> > experience to fix all the issues showed in this review by myself.
> >=20
> > Also, you tell me to leave it be as is because it has no real attentio=
n.
> > So, my question is:
> >=20
> > Is it worth that I try to solve the issues mentioned or not?
> > I am totally confused.
>=20
> Hi Len,
>=20
> Sorry for the confusion.
> My suggestion is to leave it be.

Ok, thanks for the clarification.
Anyway, thanks for the review.

Regards,
Len

