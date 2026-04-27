Return-Path: <netdev+bounces-281474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A+uAybD72mLFQEAu9opvQ
	(envelope-from <netdev+bounces-281474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749F479BD5
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172F13003ECB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B62FE05B;
	Mon, 27 Apr 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss5KDVKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E322E0925
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320690; cv=none; b=XdNR36coKCZfujuPVGn9+loKTp689r51esvSLvL1aCq3ARUwZtiOeLwmAVTxAw1uJSBxFSl2Sbo5Mf0mucphAM9Mu8CUbk3JeTI6dwdZ+HlY76aQ3WMJQPmCQlqBOp/GhsUUVvQ1LTVZg96F9ld3+xjVplnlYM8i4Up1jj70EJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320690; c=relaxed/simple;
	bh=DMlc/+ER7oS8mgkVdg1Qcug/MHciw1009zr/t5MmpGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdo6QH+yqhpGPRubxFkon8f3IMToCTQH8VFZ954g0Xy4jWoZSd5SMkPq52DMiZVVzrMZ6gpG1oaMlITxd/DAnJCjhVX9fqSpSE3+uMh2X9Cxv/zs0BkMJ1M1IZVvIYzRnfzOheTBSy1DM8W8Jv9AjbrHwDkkFp4xJ9tp5pKHzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss5KDVKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C643C2BCC4
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320689;
	bh=DMlc/+ER7oS8mgkVdg1Qcug/MHciw1009zr/t5MmpGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ss5KDVKHWXkde1Ua7pOiEb55emJJL33h8i9eeLvLNzvYOSw1L5SggbwOY5okb/ex1
	 hrUuacUPcM08aAS+OQhL4rHdLBRzO6JwsFVPhVZ3Iv6LlZJzVGgftAcVGFcD/QdHx5
	 voUx9c/HEW93r9EFDCgIG5K1u9U7piuxyf62UofBFBXn/zZto3g3Q9Wl3VBlzQCl2n
	 fcyAG7+NSGDaGjNZLELnUdOztnO1umhftMEiSr8HUI4LalSYYo/YWR4hVkYGk9eowx
	 PJpeQKZPst7c1oMFsMGqtnWQt5bbjiIjPvmrFI87NVVhkDs5diqmp39iErBnHFcYw5
	 8khedzNKaQ8GA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so13183049e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Pw/LEFcwHOCZSbcwf3xRA0PrcjrGL2rnoAnW4LQ8iTw9Dp2+wgC8SBGEoF/8fQKyV2fUOGWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEdllNCwwsGD1zHTnO6HlqDBJc7Z2mCc9iie8zSvj3bNSXvC4
	LdwtpHqjQhzNLGInu0j4G7Oy/WLyuS8PuvH7cKW6SBDCHFXcR14tniuBqHxzROvOV+IUNs78Q/u
	lgfGfDdilJxdVov3fw3dPJ09kRWQfxHY=
X-Received: by 2002:a05:6512:3b29:b0:5a4:6dd:87 with SMTP id
 2adb3069b0e04-5a74641187emr102023e87.2.1777320688259; Mon, 27 Apr 2026
 13:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
 <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
 <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com> <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com>
In-Reply-To: <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 27 Apr 2026 22:11:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLkdS2+-GRrnZ3_EHgwiO7UCPBtybFDNrTT+YZ718NYK7A@mail.gmail.com>
X-Gm-Features: AVHnY4JMnxlR8xgcgoGJWoy5krn32jndHwsJb7eI_zxQEqZzL8M8-5qNn9fcCys
Message-ID: <CAD++jLkdS2+-GRrnZ3_EHgwiO7UCPBtybFDNrTT+YZ718NYK7A@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6749F479BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281474-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 8:07=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

>I=E2=80=99ve successfully reverse-engineered the table access
> functions and format, which are similar to the rtl8367b, to the point
> where I have the rtl8365mb driver running on an RTL8367R. I also
> managed to enable CPU tagging, and it is currently functional using
> the rtl8_4 tag. The code still needs some cleanup, support for
> additional features (like LEDs) and a lot of tests, but it=E2=80=99s look=
ing
> promising. Adding support for the RTL8367 variant should make adding
> RTL8367B or RTL8367D support much easier in the future.

Wow that was an unexpected development from a stray question
from my side!

Your attention to detail is much appreciated, as this will help migration
away from swconfig in OpenWrt.

I had the same issue: all code I've written for the RTL8366RB family
is based on code dumps and no public documentation. Sometimes
I wonder if Realtek even documented it or just made the proprietary
driver and shipped without any documentation.

Yours,
Linus Walleij

