Return-Path: <netdev+bounces-285884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN2WBE78/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:07:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1709F4F84FA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7FDE303D786
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A23FB051;
	Fri,  8 May 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwhlcuSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4C3FA5D0
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252601; cv=none; b=qLE73/ybdl7KOWoGpt6FgXrqn3zpKOiUM94MHB+r3shs9HmkrXjvhWp9R//c4bpODXl5BcEHZJ+DuprnohjzRaD79uM/0kBE7h9x/hPZ4Rpiy1OhGkFujxQ+ONa5SBOADTz//6nnL78Xj4Jlvqd9aP+x9Iy4T1facHxGl2Yf9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252601; c=relaxed/simple;
	bh=Yc8G/OYaz0np5e+ifQwa6O1CU5HmHo+b4K8v6Tjxvs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6jvp+8xKmIUKqlclUmpoF+YJ7+kd/TonIq5BL0Lo7BNRdoMDiira1p+H6cQdcmeyr7jqCekZU+1q2YnZb3bKwr7YkKxw7fVy40FfrT2XC7yFkUZw1AixlQaRHCPNC/HKxB3Mr7SNp+e3tu+hHOMGqTitWQlPA+ZZzXGaTwrG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwhlcuSE; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c802803ac17so951489a12.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252593; x=1778857393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCvkvD50FsVxDN97c8Hp0jXUGucP6UrrTJOe2Js6aRE=;
        b=iwhlcuSE1RFQW2tMj7c6OHS86RYq0Cr8bopzDoWjdgEhNUOx91pEsF8qHLVtRoYcpX
         toDk8UOGhdVxf9rWykP63/iEbJY0DCENeha6M0qNKzWdhB8uHse6vuj7omiMm1xbPzhf
         diAn5UqdUa5AiqVush6Ex/+pFWzc3Hp6J2mvNO/KZa6jj930gJ0w4gSYuJVWFs5RAIMR
         dGvAt4A1Cm06wdzEsAlmWhtrKhn0lK7euxhaaBB4EgQfcdMAMqN63yyYmfKs4L7s5rA/
         lUkUdTkx52qH0L1z6gQ19mJJ/hFM/sdw/C8NEQFHJgXBy6qKO4bjXgylqqitjrKLaQVe
         xrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252593; x=1778857393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCvkvD50FsVxDN97c8Hp0jXUGucP6UrrTJOe2Js6aRE=;
        b=i8q/PAqS46yXDfiLGONn4yVzeTLlG3Xdj+QZgr3VDu/kct1XCbKiTV4V18V9LqTx/Z
         G8lxPOnDForo9BOYmeNVL5u86rQXGxjKevWw3p3HthdH7wwJ3hc4w9X9lmxtIMJdXbxd
         XZJhuXJTv4AhMvdNpkVoEZtzoSwac09nHIzpymNDdb6hRAafVZ/oAxvC5zWVaLRcASbL
         lqDnY9G6E6HZHRSGiIbK8dAC2FWuVk3hQgygZN8gizVo2Kfkn5D0O6TqW/R04YLfLxkf
         32OrqwHb7YMG8DZ3Kmnzg9dRd23PYE6fwwNNlmluBBYS37ONlLHX0cQ9DoAuLMqasSGU
         EZyA==
X-Forwarded-Encrypted: i=1; AFNElJ/igeYH2QvoKmf2CZFANNS5V0xwQne8GL8Er1/noZmhDCFvBkw8EG0EViRjrwrmMr+2hS0v5d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDp5K0FNW7eXH3mOLYi2ocYxe/AQClzrP0w1z62SRoGQRB/fC0
	4ZRkYMOEX46skwaPKITPEcuLd3RPj/dy3fZvgtUFRxa60YyPZtPd+nbD
X-Gm-Gg: AeBDieuaW4Jy5kYmOvirNdalTv4a1hN4QflHJ1jT7/wlQwWJvtOvwsPH9E4f6KdQ4xd
	L1nUcYdqo4c/ekxF0g3//++mySb5JJMvoyPdd2uQbCsLXL7VFajt/N8wY9RK7kU+/YphKTNXNie
	d9696jsk8eRQUnZuiFJkEHU7UeR/sJ3zesC3Eth59e4xpAQq0KqoK4UxHxOlq6FhdSfZELsQysQ
	gXCuJ1NfDXZ1krGlltYouDm5JH67AuPLgJQ+4bldNrG7xCCAWVPWTbLCNKkPz7PropKoirMo3pW
	r1kzHcSHWm3lJgcJ1sBje8gBE6J2z50+aqGNcIJG3OjgvA2QjK2V0/FutqaVXCpOAi0c9eMKWal
	QLaQzAQZEtDnsnmFjz2FXbdKxBBhhviRGZocqMtRuPUAi1lxm4NIz208tdLnX6ik0nRkZQSeopS
	NzrPNgQWpAUi61THWi
X-Received: by 2002:a05:6a20:244d:b0:3a3:a69c:216e with SMTP id adf61e73a8af0-3aa5ac23e75mr14422053637.38.1778252592814;
        Fri, 08 May 2026 08:03:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396594645csm13180339b3a.14.2026.05.08.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:11 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <af37Eoq2TLjhI7kx@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
X-Rspamd-Queue-Id: 1709F4F84FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid,meta.com:email]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Adding netkit-based devmem tests is a straight-forward copy of devmem
> test commands plus some args for the nk cases, so this patch breaks out
> these command builders into helpers used by both.
> 
> Though we tried to avoid libraries to avoid increasing the barrier of
> entry/complexity (see selftests/drivers/net/README.md, section "Avoid
> libraries and frameworks"), factoring out these functions seemed like
> the lesser of two evils in this case of using the same commands, just
> with slightly different args per environment.
> 
> I experimented with just having all of the tests in the same file to
> avoid having helpers in a library file, but because ksft_run() is
> limited to a single call per file, and the new tests will require
> different environments (NetDrvContEnv/NetDrvEpEnv), it would have been
> necessary to have each test set up its own environment instead of
> sharing one for the entire ksft_run() run. This came at the cost of
> ballooning the test time (from under 5s to 30s on my test system), so to
> strike a balance these tests were placed in separate files so they could
> keep a shared environment across a single ksft_run() run shared across
> all tests using the same env type (introduced in subsequent patches).
> 
> The helpers work transparently with both plain and netkit environments
> by inspecting cfg for netkit-specific attributes (netns, nk_queue,
> etc...).
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---

[..]

> Changes in v4:

This is a v3, but you already have changes for v4 :-p

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

