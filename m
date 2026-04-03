Return-Path: <netdev+bounces-275116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID70OQfhz2kq1gYAu9opvQ
	(envelope-from <netdev+bounces-275116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C07395F00
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DAC93035A78
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6BB3CBE67;
	Fri,  3 Apr 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouL7o2e9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA03C4551;
	Fri,  3 Apr 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231143; cv=none; b=kYfQ07NHCeTlfBQNOMXRqI65l9BbjSy7HpZ3CxW8T4wP2TEYF/LZYM/dLLfR8J9kxhPi1jxXZK1VVDH4NV2Y3rN43X99gcIYvtXPt2DFxalVijwfHfjRE+cbt8sCDDstK9D9MHVFonWaMpAzI7q/Dp7Cd6MLnNk46knpOmcUA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231143; c=relaxed/simple;
	bh=NZj7VjgqUp6cwcOCaBgbYLSqs5x6mx6RUuqvvZfQ5eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMUgb/bQjsF1IBflqAl55vjzb0x5Qr572OS+B2GJzChdLV2Vw2Wyj5TtqrbMFnbS+Gx1SduLsFVnvFdExehpVvwwNv1/XSiUuUNZEpWvVln6Bn3gWEj0XdKl/zHrDnfzRrTeooFdlzDQ3K4S5b4rciAZwWB+PQaAmmg1/zle7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouL7o2e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F64C4CEF7;
	Fri,  3 Apr 2026 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231143;
	bh=NZj7VjgqUp6cwcOCaBgbYLSqs5x6mx6RUuqvvZfQ5eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouL7o2e9ppBbdgx9VH1BAKfvWKvXFntBZis2nOXzYUcIpDTjI9LM8w7g6HA/plDc7
	 gCF+SdwbmUoXSuq/y0CYS6WgXz8Ksma7DVxS0xEpNWBJ1o41RAUCWihN1b8l7aXky0
	 96VYJtP/Gsk0fH/tt6HMECaua9lC+rF+bJ3YXMDFEB0JeXD/U1km9tNYnSdXH2B65D
	 +0hr3uTtsAo2BM7OEBLSvbtMiakI1OYawPbW2vX3nVVMH3LqV/bNsFy9S04afz18dj
	 hitTOqz6HRywXlccXCmRGl6IcAEHlRaLtCAOrXnQpQtu/PVXSTQVh+rcFfC9m46LWC
	 QqC9aL5zOD7mw==
Date: Fri, 3 Apr 2026 16:45:38 +0100
From: Simon Horman <horms@kernel.org>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Message-ID: <20260403154538.GA187715@horms.kernel.org>
References: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275116-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,uniontech.com:email,syzkaller.appspot.com:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 59C07395F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:07:43PM +0800, Morduan Zang wrote:
> Check get_registers() when reading CSCR in set_carrier().
> If the control transfer fails, don't use the stack value.
> 
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> ---
>  drivers/net/usb/rtl8150.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 4cda0643afb6..7e32726d3e6f 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -722,7 +722,11 @@ static void set_carrier(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	short tmp;
>  
> -	get_registers(dev, CSCR, 2, &tmp);
> +	if (get_registers(dev, CSCR, 2, &tmp) < 0) {
> +		netif_carrier_off(netdev);
> +		return;
> +	}
> +
>  	if (tmp & CSCR_LINK_STATUS)
>  		netif_carrier_on(netdev);
>  	else

I wonder if we can handle this a bit more succinctly,
while still making it clear that the error is handled.
Something like this:

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 4cda0643afb6..816759ced56c 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -722,7 +722,8 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp) < 0)
+		tmp = 0;
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else

