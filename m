Return-Path: <netdev+bounces-287992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyCNqzbBWokcgIAu9opvQ
	(envelope-from <netdev+bounces-287992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:26:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39233543120
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27C230F5173
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199D426D06;
	Thu, 14 May 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a6KM8IvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C53FFAD4
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768054; cv=none; b=Ce+uq/pYmMSM1bQQvyuCc7QQmNb68wQy7L81emywffXm+wfw0fikEyIkT7qyDp+9JBd8gc8mM00Q4On5pCVQ9lOo/bNiDpR27/+Jud5juOpMnVMN8SpS59krH/wF7ZCiUcQKWBl6HFMVP1UwPJPnt+9Zq3G35BAoWXfA5b7ISZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768054; c=relaxed/simple;
	bh=Kqg+qi/qS8PQZDwpSK2/Nn4RujBX+uGaiY86RCL1oEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzVai8uItw/md+MsgcpvQd9ni8DUJahG5skCt2j05Xnj6Xd6dDhYUm+21WyDaSyspMhXfB1UTCJAwbHQBiEhI1BxY1d5inOUT6RMQ8TRLR8IDAYJGqF+I33SQ401nCinGrNyN6sNmv+Ba56eEHIbVnI3Pi+YMr7wAD9ML/8JHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a6KM8IvW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb40149037so740135185a.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778768051; x=1779372851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Alpar3D/8GmvuTgAkB3djm9K1RWaiLneRgLcQa5uWGc=;
        b=a6KM8IvWKyLDB9+fn2IYyx2l7JaTZ4CNchSM26RtSNimDTTmFqcBxL9HGULnGOnXXA
         GAYKKXhlg7ofn7tQT+G1zbd2kpuZoc/hnstntEzPGq4nd70WrsJ5v5kyb4NfmVLnC647
         J/rPe/I+R2eqHVrbQLulvDjkDqnfxuP5SMUBrovI9/NMHfwI+Sf/nLJB9WFOcz0mj/WN
         l9qKVJ1Bwox38JqjJwdm1rQHJjjNA1mAA16DnCT76TetfZeNsiSCK2GmIQ3k7HX1Aj3c
         kjfdHdutuOn7O81aNxoJasnRr9tCQCzWyBfyG/NcWC3Wwt0SNz68tO9rVwvsuceOXfEK
         cRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768051; x=1779372851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alpar3D/8GmvuTgAkB3djm9K1RWaiLneRgLcQa5uWGc=;
        b=Tv3d9ki+Ad9RAuTdSVB0oOud0i41lwHNn4bs8AHluGvk/UOoFoi0iYAKfTcPNWI8zQ
         mCUPAlcGTepzDqnkOY1v+8Ry/E5hDozdjo8/gxx4WWQVZyLPyX00CLYwdPIwDU3EcJqT
         Ij4gpZi+drPa619kzxc0CGYbJLxKXkbZkOESL+ZajihDpM0W8vaaM9Bzk/yfA+/N1SHV
         E6Mhs0k8EPX6TRVY4ks18PTDLz1pZVjL3Q/0E/9YgUp2QvEu6J3B260WpKyC6aCSS4cJ
         p+Ql26W707UwgXMGcpVOcnyJ/abgaikIY+865cjyc/oMvZ7VxCb3k7ypx9ZaselLgZF4
         6COQ==
X-Forwarded-Encrypted: i=1; AFNElJ/P2jaZGQdlpcymt5OvCnPRdR9LFqvdhIZDtk0XlZOwwnFM1r7jLXmpfcsk+WYOtKoTbJKj6fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqvB7STZig8kd7nLGGVgpGIOB4pbA9Oj86oAUPl4f65obxTap
	yxeqzomkI/Yn/XTo8kiWdMhDUaHu+O5ZwDW8Pks70AL8qaNeAtpKDSZJ/yeZMblV29M=
X-Gm-Gg: Acq92OHqVHZW8qGFw9WGI/CFZegjZppkGZ0R2FJCV5oNEmTJ61amOLkUTcT6pZ/VNI2
	p17lFMqezKM6utPRUE30Ky56SJfaKYHKGAISP/+7rjGLxYCtgXGgb3YDl6+yzbJ+BJt+9Olnrif
	0VWKqR/j/x8hYu7z0m7VsHw+s31mX0yrJahgCNneydAFauHYcAFS5vhTBwJTqsqeWJWvNjIfqjZ
	Gux4fCmIU90kSMbTvr190eO2+GqAMZkZagpaJDw1lQRCsX8QP+xuwZJ4viXKHsrUvNcA33FgQlc
	sigey3LEB9x0AR0nFdkYCZVqx2GFA5grQxBC245hhZaWGqRszWJiw4kNmN5GssS2ZDWUEooGlJ0
	cVk5TtLRshyTCaM8ts6IKnlwWeIxjsFReSPrWaVj4aaG99ew2IMKGRDNxwKObERDbAVGma7SlAt
	afdtwk85OUBvcZTAod+fVmNQxySCiMBp4CxD+QEIHl9tY6uhjpQa0QbYoWJmN1my7biY/CjPiEL
	NXRmg==
X-Received: by 2002:a05:620a:284c:b0:8f4:3895:25d3 with SMTP id af79cd13be357-90f88d999fcmr1147254385a.9.1778768051436;
        Thu, 14 May 2026 07:14:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm249913685a.38.2026.05.14.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:14:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNWpF-00000005JtS-3Wsh;
	Thu, 14 May 2026 11:14:09 -0300
Date: Thu, 14 May 2026 11:14:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Ahern <dsahern@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
	arjan@linux.intel.com, davem@davemloft.net, edumazet@google.com,
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org,
	kuniyu@google.com, leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Message-ID: <20260514141409.GA7702@ziepe.ca>
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
 <20260514115048.GX7702@ziepe.ca>
 <139794f1-80b8-49d9-829a-0629379def51@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139794f1-80b8-49d9-829a-0629379def51@kernel.org>
X-Rspamd-Queue-Id: 39233543120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287992-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,linux-foundation.org,linux.intel.com,davemloft.net,google.com,sina.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 07:58:18AM -0600, David Ahern wrote:
> On 5/14/26 5:50 AM, Jason Gunthorpe wrote:
> > On Thu, May 14, 2026 at 03:31:22PM +0800, Edward Adam Davis wrote:
> >> On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
> >>> On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> >>>>
> >>>> On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> >>>>> We must serialize calls to nldev_dellink() or risk a crash as syzbot
> >>>>> reported:
> >>>>>
> >>>>> Call Trace:
> >>>>>  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> >>>>>  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> >>>>>  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> >>>>>  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> >>>>>  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
> >>>>       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
> >>>
> >>> This seems like a rxe bug, I would have expected the lock to be inside
> >>> rxe to protect its racy implementation of rxe_net_del(), which looks
> >>> like it is possibly also triggered by NETDEV_UNREGISTER...
> >> No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".
> 
> Not that Jason's point. Code wise
> 
> rxe_dellink -> rxe_net_del
> 
> netdev NETDEV_UNREGISTER:
>  rxe_notify -> rxe_net_del
> 
> both can lead to the same problem
> 
> >>>
> >>> ie it should not change nldev_dellink().
> >> While this could be fixed within RXE, the same issue affects all other
> >> RXE-like submodules when they subsequently support the "dellink" interface,
> >> therefore, handling this within nldev_dellink() is relatively more appropriate.
> > 
> > Why would other modules have an issue? The problem is rxe's racey
> > refcounting scheme for its lazy socket creation. There is nothing
> > wrong with nldev, and now you've created some nasty BKL in the nldev
> > code to fix rxe while ignoring its other races.
> 
> +1

Edward, please come with a fixup on top of this since it was already
applied

Jason
 

