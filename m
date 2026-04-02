Return-Path: <netdev+bounces-274618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD2QE2KSzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:59:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C178338B937
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBCB43018C01
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8884C3DB62E;
	Thu,  2 Apr 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="czM/ntii"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6B33A6EB;
	Thu,  2 Apr 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145497; cv=none; b=ifZC6Q/yB6s9PYp8+niZI+ny5V+kpSbV1vK6SJYfMdv/bupmcxAHTqbRKIu48dVW3/aIslZQ7Zf1BCtaaIbMCaxfkkAmTaitjLxYAwDHmNQswQ3WglrKImY2S/Qr/gwxBqFLlhHLJVPZXHY0qez+ayViqwTbaWCvIWqn0sJO6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145497; c=relaxed/simple;
	bh=aokw40XKNWcYgPDqQfP5TzZmoWtrXdYP9BHZGYGnKtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYfwFaW2iFX/S4TYpwcmGRIproCJy9JpjcVgLP6UClK/m4egcbO6GHZ1yE2acYoJjWXkE3rHOmWiEDsCyf8VIdy+HGVdsdWrklryI2OmI5EowRFzzD1NNavraBnRxIJttzjwLR7jPzW7A8ZVlAr9GNcw30pNWuOahNOFG21CODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=czM/ntii; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1775145081; bh=aokw40XKNWcYgPDqQfP5TzZmoWtrXdYP9BHZGYGnKtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czM/ntiiEM5tTGOzCR6wNYRu1wIqfcLoEWb/LSrRwLUYTogRd1xMRIxXkId4QhrGA
	 cp5kc3fVlv1Q3QECMVYI+w3BNCfvcgAVvFlb/5sYOUbyZXZFGknqkcZ3Zy8Jf9YXJW
	 MryTS203IBQoQNdBO+sjwDm2QgPGBebx06Pbuh/TjgCf45Ul5cA/NURVSUUQvV3rYI
	 ZhnyHgJCvfR1JoKSI/qMw4UAL9qfjUIaqvA/iTuXMEvJx0pXgzEce6kUaYINw+e0Ez
	 TJRuOQbIscVdMPsYSWafvONcNH4qphVel0+9mWWZZxxRlCc4SnEz7cg53xMfbckPMU
	 1v0uZjt0jg0dQ==
Received: from cabron.k.g (88-124-139-221.subs.proxad.net [88.124.139.221])
	by lan.nucleusys.com (Postfix) with ESMTPSA id 668523FBC8;
	Thu, 02 Apr 2026 18:51:20 +0300 (EEST)
Date: Thu, 2 Apr 2026 17:51:18 +0200
From: Petko Manolov <petkan@nucleusys.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Message-ID: <20260402155118.GA27927@cabron.k.g>
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
	DMARC_POLICY_ALLOW(-0.50)[nucleusys.com,reject];
	R_DKIM_ALLOW(-0.20)[nucleusys.com:s=xyz];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274618-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nucleusys.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petkan@nucleusys.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,nucleusys.com:dkim,uniontech.com:email,appspotmail.com:email,cabron.k.g:mid]
X-Rspamd-Queue-Id: C178338B937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-02 15:07:43, Morduan Zang wrote:
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
> -- 

Nice catch.  You can add my Acked-by.


cheers,
Petko

