Return-Path: <netdev+bounces-295415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9kjKLjdIWqcPwEAu9opvQ
	(envelope-from <netdev+bounces-295415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBD64333F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ik7K3Mhc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295415-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295415-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE19930058F3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB13C1981;
	Thu,  4 Jun 2026 20:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657B2472B6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 20:19:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604341; cv=none; b=hPmyq6O3yYiUdCTVUpSAvyZpnUAnFk/8OSF1z+qvwOEpRsMAicAlk1QTsu0aBVt/xdELb9sYl7pHC3/ED5W/1uWdpu6G+SMN+wE+qsiZEN3wrMKxU4aLz+b1gQ62Xgwei3rVzG0OiTBfmqpFyqHl4r77tDOmvkCLty6cetsMQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604341; c=relaxed/simple;
	bh=V5mgaYuiqmd19pVeUJ5dGhbcayqpVw+iFC/75yHxxBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikMPiZDv9+yMQ2w+xGPjH97l0ZDC1CG8wbwRFSZ/NIuwI/bawtjYmpdoO6h0gXkVlO6p1R+9EBKfbp+6e/gDlpOQemymPitq/cH82FgCXkWcmGvcZgHW0tvJP1dxxTpOnlmPKA1eTkODt0c1VO6n2Btch0gUFuDwRcZMR7nx6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik7K3Mhc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646101F00898
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604340;
	bh=V5mgaYuiqmd19pVeUJ5dGhbcayqpVw+iFC/75yHxxBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ik7K3MhchNjzp7oJzyeWYk99BT9TlVXzAWEyDT8EH82JB+UMH/vHBhITSwqbwupG0
	 Tzv58ZEzIrm+JhjvsY7CwbEyagNEWSKp0T9B+24ZRSzADZrE6WJa79fKI/sFvFIKIq
	 l6C4ut98mVF7Kw6wney7K40DD4PLql+Q9Aq9YprJrsQp9DuF/HjHl8gkLxvJheHbX5
	 4jV38iAX38+8axGVZ0SmTsZF4WC8ZvXKhE59Ky+bxYYO4JpRGuRAUgT3vuGxGUUKHI
	 T9UoZ5ldhIYUxEjHHx9MA6/mT0x7mvA5vdgWhzuXdwgzRaUaTSjaT7WsIVsvr+08/+
	 z+sdRHNEcoCvA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so1339679e87.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 13:19:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxd6PdwHlXi8HRtoOskvivjwiDTRNbQSjlTi3YFlQpPPbLuRaZL
	zpblhBrxm+WFyv+Z+n8OITicBFW7uWlhI4kq22Bp6Tli2EiNEMnkMtVPUu+g0Ugo0/KMzOoI59e
	jloCuyMHn83Bjecv4HbJyOctMEEM9RrQ=
X-Received: by 2002:a05:6512:618:10b0:5aa:7129:5d43 with SMTP id
 2adb3069b0e04-5aa87bdd16dmr62668e87.26.1780604338984; Thu, 04 Jun 2026
 13:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 4 Jun 2026 22:18:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLnQ5QcQfFTs1BfcksCxOXEqJytn3vzk_T0EC-_xxfL=NQ@mail.gmail.com>
X-Gm-Features: AVVi8CeSPVpiXKe85C9yVyyXm1naefk2QAZFsVkjRKVNOeDlmCJdQwlc-XPTnpQ
Message-ID: <CAD++jLnQ5QcQfFTs1BfcksCxOXEqJytn3vzk_T0EC-_xxfL=NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format
 specifier for MAC addresses
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-295415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AFBD64333F

On Wed, Jun 3, 2026 at 1:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert to %pM instead of using custom code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

