Return-Path: <netdev+bounces-293386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGKrATkMHGq5JAkAu9opvQ
	(envelope-from <netdev+bounces-293386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCD615919
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72CFF3020A7B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371E368263;
	Sun, 31 May 2026 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5z5fxJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75252341AC7
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223029; cv=pass; b=H54K0s6tsbKKSg4azvCWfirjs42mUb51IuvrtIwFShroIGUHf8x53CvLNX88tR8pzA86l7Yuzp3jTKCtGQguLJJ9ftnzRaUfnyZuNI8svGY+XEFvnpCjJs3mTI99LGrhCF4Wl/gGz6QEdD2huc6z8quvaGlbTUiII2ZgT6E5QWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223029; c=relaxed/simple;
	bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwchMwkUx8vH5L3xds0G5BUWlbOwy7Kv1P9zRlfpPtLEmYBUtLDjzM3pNqka++3ITTEkC39zyHWnxJ+SF5mGCfiKJk5rg3igKd0YkrWofdWis2MjNCk9ZLUDnTi4LYSoHWJxMKo6qeyl2CeiJPz69q6aL83HLn4VHLIRQczBpyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5z5fxJD; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a7682635so4847115e9.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 03:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780223027; cv=none;
        d=google.com; s=arc-20240605;
        b=UuDRqKSufRsE+7KGsLU+nkvm7RN+htOF1u8xLTiuXc+R7tshNAL1CFbNkLqs3oSgWn
         YweGef/3548x5acav2rWt/mRvIKyEtzWJFCcMhczbBOpCG52DFD6+a/nk3R2fvXH70CY
         XnUnyJXghDWbRHyD4Xa6IL2WoQy8w+8O49T7WN8Mor5m7wo3hM9uaqREYvY7T/+cSDLX
         IvRi16HNAaGaB2d0svJIbnYatKYemMFkqj44/+jO9y6heJmgelPye5JFPiySb7eOo5tD
         Fs/Yy+FNA4zgm8T04wTFCOlr0vTWPZxRQ8Nnad1gKff3ZvBt/GOU5KOPdzNkQ5ix+mcB
         rhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        fh=xHKsPAa7l0vzneEkQKAi8Z4zqC4cRZeuec0ESsta2no=;
        b=NZ1xpOX5V+pWOsl8YUO6rDvWKlR/+Go1hLTuH5bxab3u03+MYSBD3x7VZPwkHDJbDo
         tqmsiSzMxbMruPd4kzFzzYvFFCTauaZiGZCxQfLncHe2Uks8xPBd/UlwzC6WIqwSyVz5
         4btgr7rD7otfMxYEUT/ykEgjBCoaH3KSzzznx+gA168NTMqfx83JT6I3c2hO7cb0aAPP
         lHmvVkzEWpuaaU8S9h7yfE/k/qgzSS+CZmEtDO8YhcwQQrADGyGbi1NUA9cN8wtLaLag
         cV5IPnz4BHaywdghVrX/7bbDkeOHiIVsfpM3T/wSP7hfNlpGkWRQP/n1cP+5ZnjZJar6
         tOFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780223027; x=1780827827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        b=N5z5fxJDH4HqVdvtuMrFh5WFdzVe40AbFtLTd/6PKAcqHs6oDEzORYCMNZZkMh5PWf
         bRGaJFKv6rwMPwywdXY/434LbPk1XxHZIb58zVi3mTPhs2P4VRVZjBO8bdHb9Xab3mhG
         RvNs/1fClAW9wNsxPCBwuxmtbIWHpCb8UJl9kJykbkCMI0QYJzGVZpiCbRhBHjy4AXBc
         z0x0p0U9A5kkGoBh/68DIvvUst8ZqC5Aj/fmncYMzsQvXvCc48pAiHcVfu/wSI4td6EZ
         +XsntvK3OYr3+Fghlbjor2LFUjBTmNLho6M+yVLCyQAPFdPsbfcEZqiP/PQh/2V6nxR4
         zk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780223027; x=1780827827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLLR8+6bmCGL+3izc0M2O2Lxk4Hx/AsBvEPAyarzO7U=;
        b=BGRgtYIzs4ox9UFC8Zzfnqh31ZOdInjSpU04DGAlcCWWi52SQ2lRSbonDfSRSw692P
         XXHkmV2JmRy8E8rASku/HqUaPqa2Ha+plbT1qR+OYaI9G15vHhEC1QTM6IUm1do3OFkA
         G7qm6wPUoL+phhpsfUpYcgye+golscTohsD1udBp8wjjEgWTk4JWooYoRTNE+Uzmz0Ne
         ek0acF9OZcfYiumUKy4VNXLNprbqvBgMep605O0ax6wHfjZDJQ/jDj9lxIfEBGSX1Y7f
         Kj+XY/6wnNzx0i/HMnfXTRXeUwwZJy5fkdkXh1mqV9D7gGpw9wLZ/hwYShxvRmhOZsYu
         7jcg==
X-Forwarded-Encrypted: i=1; AFNElJ8L9o/552abpJOnaUKlulNmn+7ANXo0LRX8gfBsMWxHbPdswuy7DdsHY6irL/OojYp4xsb2myU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg7DGsNAfr3x+bh5CX2MDZO1lWDaJMaBfZw5FFR/0+QbtVT4C
	PZhDT6fkqcY+dfeuEIUr0TCPPbYKdm4pS1tmIBBX3aai8x2j0Us8rCOc3i3VZHRVdCJ/5OgIjlJ
	Cmuf363RPhAVO4GDWGKpMjvNqxUYP+8c=
X-Gm-Gg: Acq92OG8nQvh2Yu4F5j+ber4yBydjsrT8tIcqRC55XahgXSACJ+YZY9C8cdUhL1PlbJ
	0xYuVyDuLA/W/EAkExu0EYlDwfTB6yEU/C+BzrtOrD3F1sTUCN3uW0Xh7PrME4sgyOcEsgwP4ih
	SWDJzgv+HzFaGYnW/s56U1K4A4TneQoBox71ugH5iaTIQpi3AGT0CnioszvE4zoeVcm4oM/QQf3
	Yf+/cV7Yn32pSlVt7YltBdpC2UCcCZWYdJgrYAbOhgrksmRrxfWJjVBH2+7d9OuOtxvRNWIRdvd
	S7GPOJEI4L4svhNGhdZOCWwRc1tP
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-490a29639e6mr116698675e9.29.1780223026778; Sun, 31 May 2026
 03:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
 <20260527075924.2707856-1-maoyixie.tju@gmail.com> <21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
 <20260527161849.738b7f1f@kernel.org>
In-Reply-To: <20260527161849.738b7f1f@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sun, 31 May 2026 18:23:35 +0800
X-Gm-Features: AVHnY4Lg-drlo1nT7uZW5coIPZFwVZQUv9F4k8fWAy2gBbp-s6mdZBwVD22P17I
Message-ID: <CAHPEe=F+ii=GgNorkhYJYXZAa4akxjKxG+qFr_H-USQE1F8bRQ@mail.gmail.com>
Subject: Re: [PATCH net] hsr: broadcast netlink notifications in the device's
 net namespace
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jan Vaclav <jvaclav@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Taehee Yoo <ap420073@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BBCD615919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 07:18, Jakub Kicinski <kuba@kernel.org> wrote:
> Not sure TBH, we'd need to take a ref on the netns and allocate
> a tracker (on DEBUG kernels). One could go either way.

On the RCU side, you're right that moving the net out of the lock
means taking a ref, and this isn't a hot path where that really pays
off. So I'd lean towards keeping it as posted, with the multicast
still inside the rcu_read_lock. Fernando, thanks for the suggestion
either way.

> I'm replying because I wanted to question whether this is Fixes+stable@
> worthy. Sending the notifications to the namespace where the device is
> makes sense. But it's as much a behavior changes as it is a fix.
> The commit in question was merged to 5.6, real users clearly don't care.

On the Fixes and stable tags, my thinking was that the init_net side
is an information leak. A privileged listener there ends up seeing
ring error and node down events from devices in other netns. The
payload carries the peer MAC and the slave ifindex. That was my reason
for tagging it.

But I see your point that it is as much a behavior change as a fix,
and if nobody has hit it since 5.6, the risk is clearly low. I don't
feel strongly here. If you'd rather take it as a plain net-next
improvement without the two tags, that is completely fine by me and I
will respin it that way.

Thanks,
Maoyi

