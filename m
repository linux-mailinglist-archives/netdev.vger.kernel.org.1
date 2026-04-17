Return-Path: <netdev+bounces-279407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNKsEqh/4mnk6gAAu9opvQ
	(envelope-from <netdev+bounces-279407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB341E0A1
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B53E301A71C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC0346FAE;
	Fri, 17 Apr 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpGYdrG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4B3C342B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451487; cv=none; b=qqdrqciFWYYMmHMR5B18SLzXJMHP5Ad6db/SiO3ewwOijXMbk92g/myo1PeOT/xBWuhFeXroS5fqLtJ/sXhytmpKAOmLnHWJ4UROqyqQS3ord7yxGPyHkVbJrB9/hNe6x/VsZL9njsglZzy6YlYzKvRh9Aruktx3vSljDwauWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451487; c=relaxed/simple;
	bh=uMNRUcAzGa3Dn6Pf9Y1ETwb0/aoBoC9J5m4EPsShFI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJvvdXg7iA0Uwr8ueh1ka1y+zw362EBG5vBAR61YIV9XWtxQ6gIBt3f9R5yzv1D19hJHOsTLj4x+SuOchWPl+ItsChy6rmoypv2iVp78d6UU/IPJP9D9PWDE0t/kqRxVQJZJZw/de6NDVGaz20jcQFntYDi5r1kBeeWmpAF4y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpGYdrG1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso723713a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776451485; x=1777056285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DT7fdVqZUAYAczSw2WqxaK24i5PGhUvRyVZzI9/Rkg=;
        b=ZpGYdrG1o3IvJR+jhBoD2DXv2av+wXy45qIiOEDO1uA+1AtVMOHY5WVnGPW9l66UNh
         GJv5jrQVqQzLs1/37gwcgyQkC+NewRPqK2vJaP6Xh+Szno1CzFcJWeS+SZnFy6uaA1hj
         zw3HE2D2KyJb5ZwVmE6wxr/+fndxnUrCvDkTKCRUPee1Dm9DdsvZbJHEKTq2PnvGx+gT
         GLl5XwGEyXGQF1G1cqAtyY66m/d8gT8qlAQ7EafML2Y/EeBdN7T+CnF5IqapciRpGDbz
         S9WFjGVPs2bzgB0mYj1ngAig5DqLV6NBFGPUxbXCvI0ZMSGFnvroymFfTPyIWlqzjjTi
         4R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451485; x=1777056285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DT7fdVqZUAYAczSw2WqxaK24i5PGhUvRyVZzI9/Rkg=;
        b=AvbOZMAirGxDQguN8a6oHet4QsxxhOoId3EnSoE+mS2fIg5Gu4PDz0vBkT/ln5TOXB
         SjRh/QWTp6zfQBMUG0MYvCfki04EuN+Catr7+ZyD+EVBG9QVGAW6sNEjUh7e84h/bIO1
         kj2vawMEYTpJD6uZfZabkepgWzZMY/LtCM1cwJ5HxP+6pc3OvM2/5RkhvmGfD99MFefI
         mm93n9h/tNcockwiiB1zMoy/+1la35xRF16zxtYUJLcmsjyTDb+1IDkAmxm7xxvLBbTL
         5X5TDR59a6VeLMMfa8zj5I+qlpbjtT7xX6yGw1xjWf3W6naro+oEfi6pJ2QPbAocEeqh
         i8Qw==
X-Forwarded-Encrypted: i=1; AFNElJ/QartiA/iVBHt3q6xSupSJFV3dheCa9tCc+x3kHI/xI6bfCnKi9ofkHBJNgLmC2t16OwDpIXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTB55JJVbN5tKXyQxXRWdUMJMeEn7IEJjqVzkiZ73Jr+JEWcNJ
	SNRR0SLqst/ULkvghiv5jBSOVX/J/qOr9SSm5QIvxjvBnH/nwQxG2msv
X-Gm-Gg: AeBDieslk9p8S8ykJ9AqQVEei5qOn+0i3SGkbqMDZKjqrdAqaIsk03YawxJfYDtscaD
	CK2cncd3P8J4GEsjhaAAkp2NZ8TRA+Yie0MG2Hsc882doli1Rt0FqRM6Afh+mYYSktoBRwwOR3W
	tlVfAGeHUsjlxaIODwsAIhR2VgFZchN7cK656zPwmksFB21iC3f+RGSmY+IqMuBuwQNF8RVwsND
	MM9nuxqay7cI6HrJ4gg6lwBcXvchVBGU0LXn74TnJy/71OxaTkMz+kI00lGuD4smo5kBT2nmC+B
	oWCuNHEPaz2b6aPrdq7BNdOnU2i/SywCDV/BC5HBu9hV5vwjvw947ox6z9ECMkBcfCfW91bUxa8
	yX1DJeBNBkE9lhW+RRiPW1w7nLypuv5lZhpXqFB0h9+p1H4JUjHBf+DfftEC4aTy6uiMps5ZKcp
	fT2pygTP1YO1bVkOx3Tn+8TuOBhj3mjiIacYpfseStoXO87/L2DTQdZA==
X-Received: by 2002:a05:6a00:3397:b0:82f:288:e572 with SMTP id d2e1a72fcca58-82f8c821d22mr4077238b3a.11.1776451485314;
        Fri, 17 Apr 2026 11:44:45 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec003dcsm2707382b3a.52.2026.04.17.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:44:44 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:44:43 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <aeJ/m6pLXduYA8SP@devvm29614.prn0.facebook.com>
References: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
 <1873b5ba-419f-4247-ab92-1b5e899458e8@lunn.ch>
 <aeFam/KxhZSMl6xq@devvm29614.prn0.facebook.com>
 <49138791-0726-4065-a772-56fea43070b7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49138791-0726-4065-a772-56fea43070b7@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8DB341E0A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 01:48:38AM +0200, Andrew Lunn wrote:
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > index e3ca5fcfabef..2a6a73393732 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > @@ -818,7 +818,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
> >  	netif_tx_stop_all_queues(netdev);
> >  
> >  	if (fbnic_phylink_create(netdev)) {
> > -		fbnic_netdev_free(fbd);
> > +		free_netdev(netdev);
> > +		fbd->netdev = NULL;
> 
> Why set it to NULL? Setting pointers to NULL like this often suggests
> you are not confident the code is correct and you are being
> defensive. It is better to review the code and be sure it does the
> correct thing.
> 
> >  		return NULL;
> >  	}
> >  
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> > index 09c5225111be..50240e6c2ee9 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> > @@ -237,6 +237,7 @@ int fbnic_phylink_create(struct net_device *netdev)
> >  		dev_err(netdev->dev.parent,
> >  			"Failed to create Phylink interface, err: %d\n", err);
> >  		xpcs_destroy_pcs(pcs);
> > +		fbn->pcs = NULL;
> 
> Why set it to NULL? If it failed, you are unwinding and about to fail
> the probe. Nothing should be using it.
> 
> I would also say fbnic_phylink_destroy() is wrong or at least whoever
> wrote it is not confident in there own code. It should only be called
> if fbnic_phylink_create() was successful, so you know fbn->pcs is
> valid, so there is no need to test it. The same for fbn->phylink.
> 
>        Andrew

Fair points. I think it looks sound without resetting to NULL, but I'll
double check and remove if confident.

I'll look at the checks in _destroy() too.

Thanks,
Bobby

