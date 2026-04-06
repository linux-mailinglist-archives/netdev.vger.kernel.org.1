Return-Path: <netdev+bounces-275768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDtUDQ401GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1313A7DFD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92825304BCB3
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093D39FCDF;
	Mon,  6 Apr 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHozyCK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62539FCC5
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514568; cv=none; b=qehij+cPmDKxPQ/wMU1UIb24AfQWmhx5oByt3Nu+ZjvxxosR6i7QLuh6bzmwu4BjGEl2exk70a3i3Q24ogClHHcb5oZAhnNNYCGPVQEk7c5ODw7C7xKVrPCRr8tF2u68khedts7YxiL2ozbKJLWw2cSXC8Ks3q7XgGzGjXDKUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514568; c=relaxed/simple;
	bh=g6Nb3O5KLm5n5qaQv1TpwRlsk2YtumGtIV6GLZgsqsI=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=LZqaDh50cXYvXyj7ZhQsn4LQYxZ7WVPEogJK2q2eTkTVMgnABWHfsWnizobqlZ5O1/5XWnoUpriUTCTOEeSMs7MLAYvrEtXMXb19Q4NXTXGxaIJfWUvFopC2ZG54Tg1FBlAjp0xlezx6Z8leSYdCToOSI7FhfbXHhpZ61Ds2LRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHozyCK7; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so2968406fac.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514566; x=1776119366; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QEJ5kVDkvKjtqlyDljOYUSyDM3n50uRGvqar0eU0crE=;
        b=FHozyCK7wKu/jwHbF8Uejn5j/sfTrMWdgk8KcOy6B4eroAXiH344EWu1oXi7XXGr/b
         12I6sziNRZ/LCLAqqmMFkbHkz9o1e3GwItCzcL2Qg6nEDTltRxsbCK0n1NIAcA6Cjj7j
         umAbFoM5rCOLBNSf54l0OBEwhdvS3vW/Z7owpGS4STgpAubX/RZtBIznf6IKD0ZgZqnF
         q+hWnHxUFwQLQnXYf26epE9Dr+4K1qayh8qnKXrrqWp7lR2WZFFVLRHACinAyDb6p/Go
         HAsH7cHJnSxBi5XyQw4/hoe1oKDaPdGi1B1Vh+83QFc3VjNfXZ3mQDt1IOHk+Ax1oSRt
         FHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514566; x=1776119366;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEJ5kVDkvKjtqlyDljOYUSyDM3n50uRGvqar0eU0crE=;
        b=EA2S1kvTX33Scjus1i9qGk1Mo0o3vbBLI8HrzhNFIXkhHEafgmOTI4X60fC6OB+Md9
         8Z2AvRShjj4yqgKDA7CtG64+LJnsbzgx+BWaOD8R+uD0546Ec6F776TG4tjPyelUEaiN
         w6QQbuU9YjTyB1oQbIVKnEQwDlmvbYxtpdUSaPQA2Ny1rAdWGIspXa+p4m1TvfmU20a2
         QNrausPOTxUIHYOjSEKEdnj3Kace6kRXQTC1XZqB5qtrSta7g1FC26P17RuM5xwWnEgV
         uON89jsV1RY2nLzkvEn5fbvG3TdZES20j3HIBjnMGZhwKcyG76cZ3wPnH/mXZXYTJbeK
         5QSA==
X-Forwarded-Encrypted: i=1; AJvYcCVtcvQExwKScDdbKvUQf5dVx3cMxjslrAe1Y+2g+3ZXj2Q/043ZbfyipGjCJQxUqn5SJLLpQ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1W1EvGB/ao+HLh79wpTJ0w3NErLM5W0SjJcMO9r0rF7Odi8rl
	zXruPn5mAAIYRub1GMqO8ptrKKvLhaFJVTve4PwuRxUPZkx16UOfB1TJ
X-Gm-Gg: AeBDiesvrR6ffWHn5gz1vwYEVI7NvAoYVh6oFEB0k9rU76KUde5sJkrTNd8pTBjvj8z
	hWOMtpJ4xMQhHmn+l2/5gK/IB2tf1iJdgpDdg1qpFcn1B+h9xP3hG97AE9m+yDo8cHZm4lbkabp
	GRJ3urApMGlIBzhGT6q9uqIhRmwHjdfnQ9hfPpiecEDdtCEsdwTc/Gs2k/MIMPYbqWv1xkKKH1v
	urkfvtL5yipDFRlDR2PBhF1aOMvlrYQy30A48oa/RjJpaimtnTSUv+OhZ32pcRUOoH214Qmvahh
	L/WRAZe3Dka6yaEvjIkAWxSzkD4XjY2WF1Ia8Q2P7O0G3+unyqGPkXeVsiqanDTJEYub9/StZZp
	PPPPU5nkquACi0Wz7J8kmnulVVQfc8Oi8bpfs+I3brJo7s0sB0JcF4TX3q6+7kDKbfhxjCDlE1k
	/1IT0DVWsCIYQX3en+
X-Received: by 2002:a05:6870:f203:b0:41c:954d:6ef7 with SMTP id 586e51a60fabf-4230ffc21eamr8262881fac.25.1775514566600;
        Mon, 06 Apr 2026 15:29:26 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42324017960sm8000086fac.7.2026.04.06.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:26 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:25 -0700
Message-ID: <174cb3dced8a40e0536f6fa1dea471b4.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000609.2414051-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 06/14] mlx5: convert to ndo_set_rx_mode_async
 (3691f90f6593)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275768-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 9F1313A7DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> mlx5: convert to ndo_set_rx_mode_async
> 
> This commit converts the mlx5 driver to use ndo_set_rx_mode_async. It passes
> the uc and mc snapshots directly to the internal work handlers instead of
> queueing work and manually iterating the address lists.
> 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > @@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
> >  }
> >  
> >  static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				   struct net_device *netdev)
> > +				   struct net_device *netdev,
> > +				   struct netdev_hw_addr_list *uc,
> > +				   struct netdev_hw_addr_list *mc)
> >  {
> >  	struct netdev_hw_addr *ha;
> >  
> > -	netif_addr_lock_bh(netdev);
> > +	if (!uc || !mc) {
> > +		netif_addr_lock_bh(netdev);
> > +		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
> > +		netif_addr_unlock_bh(netdev);
> > +		return;
> > +	}
> >  
> >  	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
> 
> Can this lead to a torn read of the MAC address?
>
> When uc and mc are provided, this path now reads netdev->dev_addr without
> holding netif_addr_lock_bh().
>
> Because ndo_set_rx_mode_async runs asynchronously in a workqueue, this read
> could happen concurrently with a MAC address change in mlx5e_set_mac().
> Since mlx5e_set_mac() updates the address using eth_hw_addr_set() under
> netif_addr_lock_bh(), a concurrent read here might be torn and program a
> corrupted MAC address into the hardware filters.

All existing netif_set_mac_address paths (and, hence, mlx5e_set_mac) run under
rtnl/ops lock.

