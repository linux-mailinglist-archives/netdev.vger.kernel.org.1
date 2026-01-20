Return-Path: <netdev+bounces-251461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILPANFBEcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853C5047B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E32825483
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA7423145;
	Tue, 20 Jan 2026 11:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D8423A89
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909048; cv=none; b=b+yH28OOUScHggGM9zPbm4Ee6vYy7CcNVPFJKBVt4CjHIQK27nqHM1PaW5VAtHcIpGJ+jS6EEP9rL3NMqsBGJ70DPvd4W1lXYIcMceTslmfkLWYvyQulR1QG2zx5i1IvsRO9GdsTKx9/XDzR7Yg5EvhYL7gq6wjgp5w+tKM+Jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909048; c=relaxed/simple;
	bh=rEZf/1Sg4LXN0exmaMPQLqDFKOXXdr/Yxg1dey9pOTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW1I0mtmPcj7e/YeiCHfr/dA9qmRueIMsPcTIgxAJwaL+q6tjLJ0Dw+GPDLxmgAt0MDDAcK6alG4oEOYLb/KA3QPLcZ4Ybo93HdC6NpHWiY4WeYbOpupM/wiBfFHsw8hX4iSjyhonTB8iuF7k7v2Ba6nRZx4woRP9PqUxBYzNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd10887d5so2185984a34.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909046; x=1769513846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSmHYeXBvlEb7OLSe8G59RYQyhINnpjWVcu9COHnqJY=;
        b=oHDzmp2Pj9hrP6+aO7WYewvn1R+0c5rNJC3J9WsATnVpKglMvtmY6bPlvnkZ9YjZQ7
         swRf6iLASOx/vdkjIy2H+381oVD80dnofm1C2DM+l0jKjLUQxr4BQXW1MrChxgV/rQP4
         ZAXp7IotRpneKWgYe4NZfozMdNmnSxmuwpq/j5xHNKMU3TI2+Vlr+xB/VXUNytEWqIGL
         qA9gYPFZ2N7BMhGqoYKOn1gJUs7wzhe0eZ+kTQlITLTeOYgvnByg6B2hCkEJMoRnDpm6
         6IY8Ugdur77kRiPM2xFvg4U4rsGYTOrhty+Wp4je+RiWaF0EhGW8YWzPYLmGGUMGVjN3
         gcJA==
X-Forwarded-Encrypted: i=1; AJvYcCXOuVXDiGPc6Cbn0ElBTkJRcwBzznjptAz91rdNSpDHhzf0E6OJYy3cYc3v+ZFV/PmLr5qcMxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynAAI2eDHci5PeNOkSVm+vbmQqvCz3Wz6bI955DYGwSQeLDFxs
	MK1QPt4f+2pFCrq7pFeBAwc6wjzhrLnv/+QDRn7hJZbeaT8HC600xxgB
X-Gm-Gg: AY/fxX7GW7NZMKWJJ1hC7KhoYV7A8u14VprmhYetIQXWx5mdKadvPQVGDSqbzf2tBs6
	bCmhNLRv2JXVHOMelugQYoyIMH/G9kyNYZlquOmrGoZzTnmdHS1IPGt6kfG6YrYqLwK3rUq9qVR
	Q5ZB6aWoByHYayLppSx9bZq6GuhRzPkdio7dS4+6HqcAC4yaItPKlWYKtH3MhkL2UXdC3fm2L6w
	Zd3IdDiyPGgD2p4nXRM93d7w5ci7rr25dgGwTxEPbrHO9ql7HoFhmVkQJl5MrBtNlpgq7xFor80
	40+WyUojDRexAoxZHeDVcsnt9a5jdabQXd+b0QZiUqYubevOK2hYObLqiC/0htb+8JtXWi6dl6m
	KaZt752i/8D0l6VPsREYFZkX+abJ8VN0TAPEVh6Cz/6oL8nPiaETofha8QtCDILhvbk96HSJoo/
	RS
X-Received: by 2002:a05:6830:378a:b0:7cf:d9ba:c9a6 with SMTP id 46e09a7af769-7cfdfd7a1a1mr6528097a34.0.1768909045718;
        Tue, 20 Jan 2026 03:37:25 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0db2ddsm8381109a34.3.2026.01.20.03.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:37:25 -0800 (PST)
Date: Tue, 20 Jan 2026 03:37:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 6/7] netconsole: resume previously
 deactivated target
Message-ID: <aW9o34Qfoxca3lt8@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-6-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-6-4de36aebcf48@gmail.com>
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5853C5047B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 11:00:26AM +0000, Andre Carvalho wrote:
> Attempt to resume a previously deactivated target when the associated
> interface comes back (NETDEV_REGISTER) or when it changes name
> (NETDEV_CHANGENAME) by calling netpoll_setup on the device.
> 
> Depending on how the target was setup (by mac or interface name), the
> corresponding field is compared with the device being brought up. Targets
> that match the incoming device, are scheduled for resume on a workqueue.
> 
> Resuming happens on a workqueue as we can't execute netpoll_setup in the
> context of the netdev event. A standalone workqueue (as opposed to the
> global one) is used to allow for proper cleanup process during
> netconsole module cleanup as we need to be able to flush all pending
> work before traversing the target list given that targets are temporarily
> removed from the list during resume_target.
> 
> Target transitions to STATE_DISABLED in case of failures resuming it to
> avoid retrying the same target indefinitely.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

