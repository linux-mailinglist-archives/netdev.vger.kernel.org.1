Return-Path: <netdev+bounces-160396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E361DA1988B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5043A63BC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549C215F77;
	Wed, 22 Jan 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="X0KjH2Q4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD2215F54;
	Wed, 22 Jan 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570990; cv=none; b=LEIIO8fOyRzszPHuIJJDYusrEFsdOeRbA2WshSvvT8uKUWtF69Yts/U1Z4f9po3pxWlTM8Zx5cQeDwpESJuTHAppsccN0/NEmTwfLvQHbO9D0+6d+8bBl06QZwb2a/tEaiN7m0lQQfIIdxkn5am17+okGHh+jDC7/UpUJcyvD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570990; c=relaxed/simple;
	bh=H3UAP0tMdC6eROvU6lzY+/rLYoXoebyATFhYnjsNMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsQhJRbg1Dv8bVAIu/w7HX/oD2cvf3n8tBqqHZOfmn/Y8eZ2gLYVuuC93NmKVQbUFNf5GXvD4jYEkz44gyFP71UfI4UR2eyIZ6FphKfj6s9rOJY4hX7Hb5t6956h+gZis8ccR9X9USBJfG0OQe8yKaY6MEVe2YyEqjcZJTdeCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=X0KjH2Q4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2AF9040B1E9F;
	Wed, 22 Jan 2025 18:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2AF9040B1E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1737570983;
	bh=/GmMe8EYcpgH3ug1uYbeUXLif8BHZqAVQnK7Lh/NinA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0KjH2Q42sM/yX/mTxTOsNTJ4OEewcyYsYc3c+zFYQpmWmf2pYa461o0StKp+VP26
	 OHls0ucL3DMPGcCYsTcnuIpKlw+ytvwL4QRKIDBvVchVXFIHhyHbQLUkpjz7stDeZU
	 gTrLphgDcgCJ1w214xJby5jamlbLuCFRDAK68jP0=
Date: Wed, 22 Jan 2025 21:36:23 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Petko Manolov <petkan@nucleusys.com>, lvc-project@linuxtesting.org, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH net] net: usb: rtl8150: enable basic endpoint checking
Message-ID: <sf5u53uyu7wjm5g67ecsqctqis3lq6hrjhzzwbfj7pzss2nsbn@bwljug5xrvx6>
References: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122104246.29172-1-n.zhandarovich@fintech.ru>

On Wed, 22. Jan 02:42, Nikita Zhandarovich wrote:
> @@ -880,6 +888,20 @@ static int rtl8150_probe(struct usb_interface *intf,
>  		return -ENOMEM;
>  	}
>  
> +	/* Verify that all required endpoints are present */
> +	static const u8 bulk_ep_addr[] = {
> +		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
> +		RTL8150_USB_EP_BULK_OUT | USB_DIR_OUT,
> +		0};
> +	static const u8 int_ep_addr[] = {
> +		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
> +		0};

nit: It's better to avoid using mixed declarations and code, especially
if the patch is considered to be a material for stable branches.

When building old kernels which lack b5ec6fd286df ("kbuild: Drop
-Wdeclaration-after-statement"), the following unnecessary warning
occurs:

  drivers/net/usb/rtl8150.c: In function ‘rtl8150_probe’:
  drivers/net/usb/rtl8150.c:892:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    892 |         static const u8 bulk_ep_addr[] = {
        |         ^~~~~~


> +	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +	    !usb_check_int_endpoints(intf, int_ep_addr)) {
> +		dev_err(&intf->dev, "couldn't find required endpoints\n");
> +		goto out;
> +	}
> +
>  	tasklet_setup(&dev->tl, rx_fixup);
>  	spin_lock_init(&dev->rx_pool_lock);
>  

