Return-Path: <netdev+bounces-290562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNu6Bcw+D2pNIQYAu9opvQ
	(envelope-from <netdev+bounces-290562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82C45AA17E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3672332463CF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBD13803F0;
	Thu, 21 May 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPxSTx4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41D258EC1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381873; cv=none; b=ErAmSvVhrOM5Yb5Hcv5aVf1lVBH1vYn+8rRWZ1tp9LN+OvZRtX5qHKnhitnWO6O002ai3BiUPNO6Cj3+xaEoP3pCUuK+wUoEeFLfGtzIItkdBIArEOxLwUawH36lQOLoauIN6YqVCBXJfMU/ihpIltdx3l2SnYoogXciJm1UQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381873; c=relaxed/simple;
	bh=zomzvRPqpQzpEAFkpK9iD+aeG9+HBlK0vVs/Ca2oYgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlO+Cjw4u1VQMTk9RWyXh1f4QeyqWiyZUEqwV8KGi7satLlPVJ2d795dVDvvMtUVyqJAvIg6oLCll12X5qLVjaj8PVAKhOj97dsxGDAfzZTP5azr4JcCmUX3PhcsAde5THGvKXVEmhiLpCcbIBiTxJVZDSrFixag3hRWNY4w7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPxSTx4N; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82faf871346so4975170b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381872; x=1779986672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8veCPiGDlZowD3Da4oK/Z+j6/rAC4Vbzq6QrBkrY8YE=;
        b=QPxSTx4NleblJAF7MXvAPVrbz+3thL13vDqVCAdvGawtS7P2WNIYbQkORZEx063+6j
         fU6IGt7L7rpAjn8wtRp5NiNfbV72s6QfkmnBHEhf1ziDBQK2QhaFWvgkpW9+IMeCF4hu
         z+EqP8a30nP+L7RtkaGgaGca4CrL+w/A1gQxvFxtpqvWpT9z8JGubONFe6VV7f//XWKU
         UpbURjpEGDiIfkun/Mi8jNaRDItWykQXtF4Xn9IiiNTAIhL0yFbcQjG2dY3IXDgQh68O
         1dTdpxvj4X/KIDrhigPUXujBvqsohLckwThoymzHGDIMzUxnr0wZ++EbQ/qt7aYXhcml
         Xa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381872; x=1779986672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8veCPiGDlZowD3Da4oK/Z+j6/rAC4Vbzq6QrBkrY8YE=;
        b=lsM9BHWU+U0AJquo+4hy1f/s2BgPiCYbpExnhDT+oQel2D7AF1Z4MCBqz7nn3658mt
         /Q4a0KqAu8nzihcFdoiGv2SsLh+jVzF8x/AjHW+Uk8LwbWVVuWeulLyXJu4kfVhuQBYO
         RbKA6lMLOS3NEgVZ5Q2wWEZjLHFRzTaBArdqNV4rRWM42BEcPq+eAdoPVpqh4eAFqIgK
         BnhqEGfs9m04kB5GtCOohNMnrVIW+iqnx71D8vU01JCWIjeH3jv3ytCFDP8lyhVrB2IR
         /7WD7YGBWEvKw2Btwgzd+o3h0bhoU8CODtxb2Ac+qoU4EfqlBYpm4yKcimzgJDuyU3D6
         RJLg==
X-Forwarded-Encrypted: i=1; AFNElJ8o3OmcbDjSZhdHsIYIetTLkFhvNcMKXF1NeAQvYn28E0ygGQyoHwKsAAvzGDl5jnVR8W9dgKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MFhtSn5oL5OgUo9/ifhdekPnxuQdPl6Ho2ZLS9LzabG0vRzm
	L9hhEjapPyUDtORM7ochNfEePXmYz2xcHLD6nUJMDrg3mF/+Zfm0YJtR
X-Gm-Gg: Acq92OH6yfRT7wUBwfEe6WH8sgaXUk3gOVHrrsKnC+CpOB2gxjMrs/ioUwLNVGJIgzQ
	Sv2srDYhwAW22lSK9KYqQrbY5Bxgq+3aw+do+Z81xtkJU7RQuL9jfkjIpaD4nIGKwA/OAWl607G
	wknZnY4vZAQqad0ddIdQNWzUR6z7w7jrg3MaXcGWZqlzpIWKAdML+0xwEgriCpsizkFpU6k6/yj
	w60S2JFWaD55+kD52aBLt9SMPOR/5DAz6KFMqp4tZiCkwLMmlOjgwURUrkCGgM7iZMJ2CcisV7X
	uIaEoTHry9FvLGK1QZUOOSeHaZvK+1FJ45fL1U0/mmdkQ/9dHD7Ntyttovvg8J//Iu5fM5yKIYh
	5QyDRIMBmv+VxDgcKT4vB+yiRFRjcML9Q2KQ9D9lMg/TMh3/nUrw5xhYDTuF69I0oQaRokF43+h
	dNGtNrbPdWAMLt3Z4kpHTu91JzCHYIL5qh6Od/h5ngd7L7CFbDGxQ=
X-Received: by 2002:a05:6a00:8c04:b0:838:af72:fb2f with SMTP id d2e1a72fcca58-8415f3af2d2mr53770b3a.6.1779381871857;
        Thu, 21 May 2026 09:44:31 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154dff74bsm1620073b3a.28.2026.05.21.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:44:31 -0700 (PDT)
Date: Fri, 22 May 2026 00:44:24 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	xmei5@asu.edu, linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
Message-ID: <ag80f7ENWAHsK-fw@Air.local>
References: <20260520160020.375349-2-bestswngs@gmail.com>
 <willemdebruijn.kernel.28580e8a2708a@gmail.com>
 <3f4460b0-fd07-40f6-a9c6-827dd0ce2ff8@oracle.com>
 <willemdebruijn.kernel.7526a484e05@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.7526a484e05@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290562-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email,Air.local:mid]
X-Rspamd-Queue-Id: E82C45AA17E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-05-20 20:58, Willem de Bruijn wrote:
> Dongli Zhang wrote:
> > 
> > 
> > On 2026-05-20 5:05 PM, Willem de Bruijn wrote:
> > > Weiming Shi wrote:
> > >> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
> > >> freeing the page that vhost_net_build_xdp() allocated for it.
> > >> tun_sendmsg() discards that -EINVAL and still returns total_len, so
> > >> vhost_tx_batch() takes the success path and never frees the page; each
> > >> short frame in a batch leaks one page-frag chunk.
> > >>
> > >> A local process that can open /dev/net/tun and /dev/vhost-net can hit
> > >> this path: it attaches a tun/tap device as the vhost-net backend and
> > >> feeds TX descriptors whose length minus the virtio-net header is below
> > >> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
> > >> tight submission loop exhausts host memory and triggers an OOM panic.
> > >> Free the page before returning -EINVAL, matching the XDP-program error
> > >> path in the same function.
> > >>
> > >> Fixes: 049584807f1d ("tun: add missing verification for short frame")
> > >> Reported-by: Xiang Mei <xmei5@asu.edu>
> > >> Assisted-by: Claude:claude-opus-4-7
> > >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > >> ---
> > >>  drivers/net/tun.c | 4 +++-
> > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > >> index b183189f1853..f594360d66d6 100644
> > >> --- a/drivers/net/tun.c
> > >> +++ b/drivers/net/tun.c
> > >> @@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
> > >>  	bool skb_xdp = false;
> > >>  	struct page *page;
> > >>  
> > >> -	if (unlikely(datasize < ETH_HLEN))
> > >> +	if (unlikely(datasize < ETH_HLEN)) {
> > >> +		put_page(virt_to_head_page(xdp->data));
> > >>  		return -EINVAL;
> > >> +	}
> > > 
> > > Make sense, thanks.
> > > 
> > > The error path from tun_xdp_act does the same. And the default: label
> > > used to too, before a batching optimization was introduced.
> > > 
> > > Is the same then also missing if build_skb fails?
> > > 
> > 
> > I also agree that we may need to handle build_skb() failure.
> 
> Thanks. Fine to defer to a separate patch btw. Either way.
>  
> > In addition, I think we may need this fix for tap_get_user_xdp() as well.
> >
> > Thank you very much!
> > 
> > Dongli Zhang
> 
> 
Hi,

I have sent a patch to fix the same issue  and the patch is under review now. 
Please take a look if you have time, thanks!

https://lore.kernel.org/all/20260521163230.1478627-2-bestswngs@gmail.com/
https://lore.kernel.org/all/20260521163312.1479805-2-bestswngs@gmail.com/


