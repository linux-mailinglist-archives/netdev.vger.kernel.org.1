Return-Path: <netdev+bounces-254260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPBvDj8QemnH2AEAu9opvQ
	(envelope-from <netdev+bounces-254260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18FA2322
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1CE3300651A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C297359F81;
	Wed, 28 Jan 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HPO7lqVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001B35502D
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607224; cv=pass; b=BgRVLK6w0Q99aEGuiM4VNqlFYk06sVll17PGy26wzQawpALaGHgxpMa5dSbjc4JosR8aInfm5htjfOMSrCvLEBHbYqYKCtoNekTBcURQUcET1AlEKsFqow4zFve69//FhgfzDLioR95CzRfTxKpLqHjgmTqlyZU7sr7IP5qrDsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607224; c=relaxed/simple;
	bh=Tms/8Efk1qgX7+qJzYnVrMSSHmsH1dYEU1+2Vwk/mSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFHsLtWQ0NZrEtc3xnrFHHNz4Zxjv4KXelOprgqimS4GcNJflsQ1diWNQNLuxuDG+ySL+FNDZQLweWAUFqRv40GLTOWdNNqzDn3ZdGga5f75zXvbwiR56kTVX6F6rN+SSqp7AtJ2dqRHFSBp6qzR1WME/tsBHcSntkTct5y5rqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HPO7lqVB; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so7353106eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 05:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769607217; cv=none;
        d=google.com; s=arc-20240605;
        b=QNXxzLNBUI2ciHlbJ6Y4XihE18O7IrEqRA49SYGYfarTSA0I8McNJMtwjd5KO7yuch
         jGqFEh6W6ayGcsmRVbqQhSQ4TRCaPzoF6A00iM6Qef9hM0ODvFWbkFjqYAv8jw1Lstna
         lrpIisxqKXG2xm40dzRXqBImMMyra65Q1N2f2wuiCxo+L/riiSO7CYdXW+taRetiTowH
         Rqr4BX+NI0KVUG7Ia23lviMJrJWQbd8Hqt8O6QMoQT31xCSZDN7RO1WGCoqTDURfnbRe
         92aG8gZBVZrBCuc7IYhr92rjebHhQGanOKschMoFJv75Jla21kpnKyg99tQf2j46eQeC
         M/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RA9TE55EWKKZ97sJJnOMdvR9v+h2t26GBU4KXan8Iws=;
        fh=GiUetlVjt7HLseNVltz8Y3bmH1wq8MAO56IbRgwLyCA=;
        b=cC8u/TmiRCictu3Nt1U2SESEy313I0MEfPhQzMnsMXLgb1VnaUi6BQ1NmTC9TKkRsR
         KBqExun+0pMKrqJlt9dt59WFi1pbD+vmryCKjz30vd9s8S4taQjlHQ0y6i932m24ckQS
         HW+Q3dYsb6wvpDt4fE3etrvhH7RC9elV93ElUJ+54M9009hvgKRf5VUu17Wr+PFPPZyY
         9j3KFTvaa/JzImOnxXuT3Rfe4O9v6Q/nx9ww9sa3/gSeNY/gfOWsXuefJy5XJH3e4yvl
         XmCa9ew/3Jh3Ppk1kqr/YzQTPESUANCv3U/yQFzv6hjAaImNYSuyPAZ1CiUMwsLN1pq6
         R3lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1769607217; x=1770212017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA9TE55EWKKZ97sJJnOMdvR9v+h2t26GBU4KXan8Iws=;
        b=HPO7lqVBMZhoCKORs4r+le4w4MBi7AFCz1rsv3f6yrhYFgW5QH6p0fayRONn1jajdy
         g51oPl4RafUcLe/frRJe2nQD6bUIgKlVe2rlJdxR5eY1dZ9yYmcJLPyO5CumggzQqVBy
         EiDqHiQT13CQqXtbPw0WPIvYQG8XANpzTl+C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769607217; x=1770212017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RA9TE55EWKKZ97sJJnOMdvR9v+h2t26GBU4KXan8Iws=;
        b=IolWnI/b20WWT3sknLD7qPk2WixpZh55uuITMfIB/e7/QBOwD6n8Eg1Rj2mt3jvgoO
         wiENdbphSbV9kCo5tCaAHoiWON6C6lQVNjV6cM7R47d7BcQSx8TnKnoQOT9oU0/CLWhc
         AjBTRdP4Q9pEstNRWuLUD21/ese8uTOwEeJL5qr10uZRQsgcnfZ8eL6XFdcWYsVay1j4
         hhghI4bzioqLCGu4ngOe0yZdeRm1tX7VhHWL45QmVf6FhRfha/OdLNAL5DzD4al3pFfs
         W5HQqPrvLBBEhuGWirfDcQnNWH8MnuUwZTMCNcdQQ1xcalMmI2XymVeJ5aw/NbXm/7U6
         v4bw==
X-Forwarded-Encrypted: i=1; AJvYcCVx8+0VuAfCG5FCYYlKvI0rGvFvuYwOUbfA4NITR6MALKVKsvDfu1ocNidC061tXTyaL6fV9qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sdrZGP/NPXCdjwUF1NDl/1/6UlfvHTphCcMEFHO2Gpf7QX4c
	4PveHo9q+MpVxYtEcpP+hGhVcaYTkBewRHzrr78eUhuRQNguoC+86EpaDJPFwOmkQyDYSeA3lKl
	2U3NkTUpbGq4+ezsya4yoyBAj8M/9OmWDzm6dRrroJQ==
X-Gm-Gg: AZuq6aLz/eeXyvaFp7+BWzBmt2EekJUlnO/zN0LdnGNUeW3MEhXpQyL+G+2fQKHx2Fu
	EjLIblPTOWgT09ac8hc7RzfsKb7EvkNpnAV9QXZ86SEZSUhyJkl1AeMp8Mu2lvHsNGsQVpDhcUD
	SEGTG30+n6g/ILRO4S0Ux5/ztqgkqDhdyWKxvwg41pDya7idORuIdHfsPDcVdfYrjWQqueL5sph
	9/f+YaI/QoYuPlT9cKsLLEAkUUed1cBICvJBvAT42Xto2qdigD0TU5HOq+H6Ez7pvWtm/jHQrXM
	GQbLHTQnBY9NBi7iQIJc70W6Mw==
X-Received: by 2002:a05:7300:2317:b0:2b7:265d:9eb3 with SMTP id
 5a478bee46e88-2b78da6e6ddmr3049145eec.41.1769607217033; Wed, 28 Jan 2026
 05:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128094644.302313-1-michael@amarulasolutions.com> <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
In-Reply-To: <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 Jan 2026 14:33:24 +0100
X-Gm-Features: AZwV_Qjd1qcCWoaexPQigCWo-zva9shEhgNv_ttVzyAO-FctiTwx_WG9daQpEWc
Message-ID: <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amarulasolutions.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,lists.linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid,amarulasolutions.com:email,amarulasolutions.com:url,amarulasolutions.com:dkim]
X-Rspamd-Queue-Id: 9F18FA2322
X-Rspamd-Action: no action

Hi Andrew

On Wed, Jan 28, 2026 at 2:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jan 28, 2026 at 10:46:41AM +0100, Michael Trimarchi wrote:
> > The current implementation of phy_reset_after_clk_enable requires MAC d=
rivers
> > (like fec_main.c) to manually track PHY probing states and trigger rese=
ts
> > at specific points in their clock management flow and was created just =
for a SoC
> > vendor.
>
> We try to keep workarounds for specific SoC vendors out of the core,
> when possible. It just makes the core more complex for an edge case
> which most people don't care about. It is better to hide the
> complexity away in the driver which needs it.

We should not merge things in the core that are for one Soc and
after d65af21842f8a7821fc3b28dc043c2f92b2b312c, I need to anyway to do:

net: phy: smsc: Fix functionality of lan8710 in combination with NXP fec

Revert "net: phy: smsc: LAN8710/20: remove PHY_RST_AFTER_CLK_EN flag"
d65af21842

The way the reset is sent using phy library is not compatible with
the phy reset logic. For now we need to revert this patch to all
the phy to go back working

Change-Id: Ic1b0fde04188c7cbfd8c94f9fa1a26d058e07d1d
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

>
> > This leads to fragile code in the Ethernet driver, involving complex
> > checks to see if the PHY device is bound.
>
> Have you found an actual issue with the code in the driver?

Yes, and I think that the flag should be used properly in the state
machine of the phy and not
in the fec. Is possible that is the only one SoC has this problem?

Michael

>
>      Andrew



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

