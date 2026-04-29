Return-Path: <netdev+bounces-282429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA+eBnch8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB4496B4E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82053300B9E0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7937AA8E;
	Wed, 29 Apr 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7iJCGba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C28378813
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475916; cv=none; b=DETmDD1qBvAwzq4L36xBhfhFKvbxHLkGhOX7/46gt3q4l4ysdgLIEDZyfdcPvXfXq/Qmspxxwx5wvE885dtQscIYMEQZ23gzI3HUp6YKzpQtqZrAFv04UORb8lJg5kKF5TUgE4yJG6B1iUy2g79AtCVX5AOd7QYDxulo497zod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475916; c=relaxed/simple;
	bh=/BimwSCUsuashVXwD+dzxd+4t5G8fzzhA6oBT4Cnlr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo5iaWcoTesBvzHuiMNDQjPCJd/qgw5YHjxHi9easbt9hkMSdCTLjHaLLnx/iLVydPcdqggO+zPCqAWzuBhKoQDR8dXJmp/ia+mI35FJt7c5n66uHk9dCTgQm+2YRZsPE1kvuecWlnK8Iv23XC/EqUNl+xeNjgha/rzOTsQKq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7iJCGba; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbd23bc684so7133168a34.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475913; x=1778080713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=b7iJCGbaNlXtp4X0g6/WayFeLAL1bJl7AXsejxs7Gg1yd3+tXxfLCqVRJ6zgl+87Ty
         AzkjBbmGxQXA5dPHLvzunpTs8WxAQ7r7BYtmSYzNn8xmKooUmrYgvDByEfrGR9oMNHST
         6CYlQCxvgSVqcxF4KUQH1q7M9m7OjIWYp2+HxRh/LoRPURMvrEgXRK9WNLNlB7BsykRX
         Pmu2UsOH9F8ek8o5h+A7RETSgO/zEg5diwBo2XSltxub7IYnetVfLLiar8QOKiuubRSR
         mVR2pcvukrXZxLDMZLKOgq8uo+utneT0SkFkFgAMAA8W5wNs+4wTTLLdIaYkjcrXUpMc
         ExWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475913; x=1778080713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=dyIUoE8gjdaMLV79iO3u7Ssz70FkVsnOIBicDjTMlrU6mwZZTGXVpmAfcysGtkoRr9
         vaAgXU7ZaVXs6FlrUHXvJZEIsYS/I9j1YroDM99OSVZjUin/YoIObEuDLVcBqSbUwxyb
         CGCLWhg3WSIASlrs86f/GNBrZ2QHTA7wnDiyiO4GzyevgFM/qjw2JOKFQj0BMvYhAxmP
         iPkre5wAor5tJfP/9VniCEAKgXASnRQDDOKGKtOvF2t3EHjhANP+QrJFd3zq41B+IB/4
         u0/JObbY8aruuj7bTdTnaQ7LqbzV7TsWngGonIlMfNeVqKVY7TAR4+Ob0BtOakhy4p3j
         WR1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gxbtuFFJj41I1yJp6Zt24cvJ/NA5lV9BE00xkGxRWV4mT2AuO4LPylSwPjAkIXAgs9n1RL0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLSmxzQbuvNCvvdwAK3wexB2+yBKkWCAw/6/P62A0UVdU8hue
	Va7K29d069XaNO5r1VHtM9LPHk6yXcG1dJfiZWWPgsc2Bw1+5dvY9nxq
X-Gm-Gg: AeBDieuoIiLL1ACYzjaXNO4I63YXD9yOVky3rhAEJOD6zBS5gpaOb4tIfwaAo2krbUV
	Hl/zPVgJtj1y6gbz2nKe8A2eEl1odCq9wFEgDujL91oMlhGESUio+pQDpuo1gvhH2pTusQi7TFn
	Pt32i8dIUoprE4zzZcOiDTeFybMUCQybFhupW+RbziD++lFzhESvWCREvi2sgvy0qrrDHzDUBnb
	ZS6rnlSbNm4kM+99TojbK1gjnCT9SLPGZZM+vIeAHdLxBshZjjQufFy6/WqGKyXGH64v0RsApcL
	tSIQprwBxdKlLiFBxlAsEO+Flxi/Ph1n07LBTmTXOOei3s2ymkMLMh2Jwg7FT5dc3LUIgNWw5OI
	0TCuEKDP4D0jB2PD9AJ74JsjZtDMBURsRkQMr9mC7hU5M04Tbl5uU9Be+dL24NTkfO6a1FDKuIT
	d8ojHuKMKpOhdgfHrzDPpZISyR7S3iyn2GTEIHhl3nbljui91zZvHWF2/PtA==
X-Received: by 2002:a05:6830:25d1:b0:7dc:da80:42b4 with SMTP id 46e09a7af769-7de9a1002c7mr4284996a34.24.1777475913099;
        Wed, 29 Apr 2026 08:18:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f812:6a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab99036asm1469135a34.17.2026.04.29.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:18:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <afIhP5dtlzCtzn1T@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>
X-Rspamd-Queue-Id: DBFB4496B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282429-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]

On Wed, Apr 29, 2026 at 02:08:31PM +0200, Daniel Borkmann wrote:
> Hi Bobby,
> 
> On 4/29/26 12:41 AM, Bobby Eshleman wrote:
> > This series enables TCP devmem TX through netkit devices.
> > 
> > Netkit now supports queue leasing. A physical NIC's RX queue can be
> > leased to a netkit guest interface inside a container namespace. This
> > gives the container a devmem-capable data path on the RX side (bind-rx,
> > etc...). On the TX side, the container process binds to its netkit guest
> > interface and sends traffic that netkit redirects (via BPF or ip
> > forwarding) to the physical NIC for DMA.
> [...]
> Thanks for working on this, after the RX queue leasing got merged, I've
> been looking into the same actually. :)
> 
> I think the NETMEM_TX_* enum approach seems reasonable.
> 
> What I have a PoC on is to build out TX queue leasing as first-class
> symmetric infrastructure to complement the RX queue leasing - basically
> I implemented an equivalent to the latter in netdev_nl_queue_create_doit
> et al, so you can have independent RX and TX leases and per-queue
> accountability, such that ynl queue-get op shows the full picture, and
> lastly we could also enable AF_XDP TX-only support through this infra.
> 
> Would you be open to collab on integrating both and migrating the devmem
> code to work off an TX queue object? Next week is LSF/MM/BPF, are you
> there by any chance to catch up in person?
> 

Hey Daniel,

Definitely am open to that. I will unfortunately not be at LSF/MM/BPF,
but maybe we can schedule a meeting offline to sync up?

On the approach, explicit TX queue leasing sounds like a better way to
permit devmem's tx binding than implicitly via RX lease.

Best,
Bobby

