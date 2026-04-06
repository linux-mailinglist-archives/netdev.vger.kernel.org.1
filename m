Return-Path: <netdev+bounces-275767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFIHGN4z1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF43A7DDF
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9101F301AAA9
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08839FCD6;
	Mon,  6 Apr 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQMcyb6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292539FCA0
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514568; cv=none; b=SHVpPEZ6mtVS07uUftPUdyPPliZ/VNqqQm6sHrTTQMRFgB5z6nHdOfo7yXykW+PRq0L0JcVuoYOKzDc5ZbEuSZfCfdNRKbEOoOh9mmt2Ata3KcOYEPdwA0bf3/Mpp2pCpK5vAsRomrphyQUmjUblG8sxw4jDpffZveWPjSOcW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514568; c=relaxed/simple;
	bh=kXDSGF0F8rVBu416WMwBhmMjZ7ZQL2luYHiIxwtRGpI=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=QuifIBhlbr4fG9yC9mjL/XaS2pDa6YtaspjH9kIsHwi85CEJEVjp51gRkyV68YRkr5f7YP+HYzaclLRltG8c00CWPcq+XUPtW/KINdkMCyUFFDjRhiGZaO6DVKjntRIjAMK15ZmMvbLMU/bdynIuqKYlUPiLLKxm0GzoN30oIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQMcyb6c; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbcd61429cso1011660a34.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514566; x=1776119366; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYNnHdXi3xjmheUln4I6VmG6L0pt85J9Fa0AQugeFMg=;
        b=YQMcyb6c2LO5IHmvx4T/Ql/UpJf+n3oremoDTUozW30/7vqTfD3dF5raMEhlq4wTLz
         lWSU8894fayDpIninwYQohj+/6nB+l7uAjMgxcM5v2hemQZE44rXtmpMsZeBhel7e8Id
         /3LjmSiLGchtuEE0Tj4DqaAgmpTsRgHB5piGvz2Wh1uAn2O25lWs2/2Dndye6ZmNU4RX
         4AVAL12pUGziBmh3fr0+qw8xn8lyVeNEkmeIk23c2DiptrRht7K1teJuWCewxmKRIyH+
         cZ7hpQTVW6tlB3Z57UiWajYAMFKicSDMblrJ6QJys+7BnlpsghWJA6bH/0txGDEbZdBZ
         1sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514566; x=1776119366;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYNnHdXi3xjmheUln4I6VmG6L0pt85J9Fa0AQugeFMg=;
        b=VMtFDiviggrprHxZELc/0wZtNR6ovtt+gJu2s8R+brQrXgcOfoNJmkuG65ZKBabsWv
         vtqhXKnH9ueGarNNDM+5YV5GCzWnF+QY3sI6zLZcS5zbM+lrOX0HGSpb9EnozdTBJLxm
         a6CG9LbBXl3H+juzbNMRuzpM4NiGqWTWcdd6neVrlhPb/Rcd7UzBBdHhd0nw4KEdBsEq
         WioqP0MSIgl0DpbG9Ir3Ct/ZXADhm4G6MpJ3VvhzMMx/xh6lwfHUUsWnMDc/Xp/z45Uj
         Punl7EYYt+Rjp4bNhfpBzUCNRMjZge0IjAK7bgZwPUwM0wLE5gsyDBbsbr1NAfJo1A4y
         cdBw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7MvBfQT3QktuVTCK1/NaNle7mOL3iScrgLBeC4kZOdFVwHBxA8y+2+EQTeB4vXhbkw6aRhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGoTTkIl3XjnZTf2ZQlAHaivFVpc+1epIqbonBU/StPyisfWj
	Y6fOAf1mL3BDfIOYu+3Sbp1LGY5lpgSSg3LBPWOiTftCx07hQFBFlY4s
X-Gm-Gg: AeBDietMObcf5IqV5GffdA2WvJMzowGMiIv275FcNj8tSUi+2zq+BEdHnPAWc31aWyi
	INq8AJHA/UEdW+X+Usy1j6oPC0CIv4gkgqIXssUBKdQuwY9wJV5YwB7Hca5cE0v7eemXbS3qv/X
	vMucZZs9cL2pr6l7WBMaP59xIEEOm9YIfhzzkRjsWbGAoS3X2YrY5tcbjkxMiw/EnbN3hmjro4p
	1N1NGxO5axvnEYULSfeHFCN8NnvGXxSt5Nfl0q9uoiBrAHAK+VqiqtqMng4OJ/X4wU48NyGMN3x
	Gs4Ob8C4mRJqlFGFfA3hoUxsVpyRvkpw+5e6oiN/4mpgtBFmPsDCSjuxwc1zzuwDpG0ZftIHPno
	qXdWVPB5Xf5hEF1iOHdClLB78JVUuK79wFyWn2dfxpMPpWOeaB2eEFLyGwdgBjXGWiJf1vg213g
	25L9Ghh9csbWJtS89r
X-Received: by 2002:a05:6830:71a2:b0:7d7:d097:96dc with SMTP id 46e09a7af769-7dbb6f1c62amr9285732a34.5.1775514565808;
        Mon, 06 Apr 2026 15:29:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fcb47sm11172893a34.15.2026.04.06.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:25 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:25 -0700
Message-ID: <0ce79f77f534e1635d53d673d0e909f9.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000608.2414015-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 05/14] fbnic: convert to ndo_set_rx_mode_async
 (1d5e76c60ed0)
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 06AF43A7DDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> fbnic: convert to ndo_set_rx_mode_async
> 
> Convert fbnic from ndo_set_rx_mode to ndo_set_rx_mode_async, updating
> the driver to take explicit uc/mc lists and using __hw_addr_sync_dev()
> on the snapshots instead of __dev_uc_sync() on the netdev directly.
> 
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > index b4b396ca9bce3..c406a3b56b37f 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> [ ... ]
> > @@ -213,10 +215,10 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
> >  	}
> >  
> >  	/* Synchronize unicast and multicast address lists */
> > -	err = __dev_uc_sync(netdev, fbnic_uc_sync, fbnic_uc_unsync);
> > +	err = __hw_addr_sync_dev(uc, netdev, fbnic_uc_sync, fbnic_uc_unsync);
> >  	if (err == -ENOSPC)
> >  		uc_promisc = true;
> > -	err = __dev_mc_sync(netdev, fbnic_mc_sync, fbnic_mc_unsync);
> > +	err = __hw_addr_sync_dev(mc, netdev, fbnic_mc_sync, fbnic_mc_unsync);
> 
> Since __fbnic_set_rx_mode() performs read-modify-write operations on the
> internal fbd->mac_addr array and updates the device TCAM, is there a need
> for internal synchronization?
>
> It appears that concurrent out-of-band callers like fbnic_bmc_rpc_check()
> (from an unlocked workqueue), RTNL paths like fbnic_set_mac(), and the async
> RX mode workqueue can race on the internal fbd->mac_addr array and interleave
> writes to the hardware, potentially breaking the RX filtering rules.

This is bogus, both paths are rntl/ops protested.

> 
> >  	if (err == -ENOSPC)
> >  		mc_promisc = true;
> [ ... ]
> > @@ -257,7 +262,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
> >  
> >  	eth_hw_addr_set(netdev, addr->sa_data);
> >  
> > -	fbnic_set_rx_mode(netdev);
> > +	if (netif_running(netdev))
> > +		__fbnic_set_rx_mode(fbn->fbd, &netdev->uc, &netdev->mc);
> 
> Is it safe to pass the live &netdev->uc and &netdev->mc address lists to
> __hw_addr_sync_dev() without holding netif_addr_lock_bh() or rtnl_lock()?
>
> This bypasses the core network stack's lock, which could lead to list
> corruption and use-after-free if the network stack concurrently modifies
> the address lists (e.g., via dev_mc_add()).
>
> Additionally, doesn't manually mutating sync_cnt on the live lists bypass
> the core's snapshot reconciliation state machine?

This is the same as before, nothing new added here (and, again, under
rtnl/ops lock).

> 
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > index e3aebbe3656d5..6b139cf542567 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> [ ... ]
> > @@ -180,7 +180,7 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
> >  	}
> >  
> >  	fbnic_rpc_reset_valid_entries(fbd);
> > -	__fbnic_set_rx_mode(fbd);
> > +	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
> 
> Similarly here, fbnic_fw_config_after_crash() appears to be executed from the
> unlocked fbnic_service_task workqueue. Could this cause lockless data races on
> the live network stack lists?

Nothing is lockless here, everything is under rtnl at least.

> 
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> > index 42a186db43ea9..fe95b6f696463 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> [ ... ]
> > @@ -244,7 +244,7 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
> >  
> >  	if (fbd->fw_cap.need_bmc_tcam_reinit) {
> >  		fbnic_bmc_rpc_init(fbd);
> > -		__fbnic_set_rx_mode(fbd);
> > +		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
> 
> And here as well, passing live address lists without synchronization.

Same here, nothing technically changed and this runs under rtnl.

