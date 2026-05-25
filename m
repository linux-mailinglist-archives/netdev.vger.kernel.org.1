Return-Path: <netdev+bounces-291481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKGGLtfCFGoTQAcAu9opvQ
	(envelope-from <netdev+bounces-291481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:44:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90995CEE95
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7D813003811
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8D3815CB;
	Mon, 25 May 2026 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuJCl26A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC9349CF3
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779745490; cv=pass; b=kE3/+lZpyWZ0o+6jVetWbZ32djS8OrTKQ/c9udHS+SH+RgVAJVMr8s1lcwRu3pmzOXQBywMOgvmKEhfzdebDlBifuOZGyaYrojoasu2ma9GNG+FVdbmRdkEWpfBoox+3xivpCPXCxKuJwNyhIQ5Icc8cweIy79m/xbU0KY4Ylag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779745490; c=relaxed/simple;
	bh=ohFb5JUUsqtnkWu+wQSsJVMsuG7CcJFkAaC28tSHXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8r/Hi987a+0QicTqIgZ1Ma9Ra0cPF/FQE2eTCWNo8dsKFSn6pt9naQJwdmrS79VrYHqUNBT303mT1w6mOJcsv166JPSZ0rN7TvYzuIrAo4dnGmJqvpZUlrgvCcfKlygZpP8K3+5M/JkL0kIp148xdlPChIUZ4IYJ8zfMooYAv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuJCl26A; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-485462d9290so2459827b6e.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779745488; cv=none;
        d=google.com; s=arc-20240605;
        b=cqECUe7gFxOTM8B+0VB9nMEUE0NzcUTLqKNZX1rKQK4tPeY2bF49Tu01SghKCtph7P
         qs2ngT9mq9OnApiSGXLdxz5QRSt9nw0gLaXLo0DFPmdTfsHkp4v3hgIL10Gi5yoz8PJO
         eSUWNZ4QlKDnQaK7CmZTipuWnB7Lnsa8To+MHl1grKWYKpCXZ7kD9gL2pKiaa+A0F/vm
         p6h92Axo72xcMUqxk7D/ZefN8e9fvZGKYPUc4FaS8eBigqfdtAb+YfU4LthDsPtNlWYD
         w71DIaBMyR279mIT6Bcy+HI/ppSLY0H07u+2WtKJBveUJSV+uo3CIn+1/YWfoMC0s2dX
         kUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        fh=Tsfq4QOKjpokSCa4d5aSOn4UHNjtZzWqYSPAd2o9YIo=;
        b=CP7fJcH1PrEEFUJiH5sBSPEr60Vnk1tlwYrM9F56BjlP8CfWLBh9pJShlWmR7O0K7S
         /TXgjFpfQ+9uHgXQ5iw+603IURaHdNFc3VHPGqqtE/n/adk1yq6QBeNkLGTW1NRzaQfe
         T7Jsh2kk6Wv7iobOP1S6m2aq4kAPwZkwNo/3ARRTJnJMhCknWNoe1wCc61LVbEwunv2A
         bUfpjRMXP2np2IeUiLz/NzMI31QwA0etEHC0JtLvMaDj+HcTE1gm9NOiHDJru2wPEqQm
         zB77nniyewd2Fqe0huxDZWVQVmoxw0xSokoI9HL27bA3PnrNj/yUJqJAAFpaU5LRPvN5
         PzSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779745488; x=1780350288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        b=CuJCl26AetG7KSd/fTG+LAv4HpMsNupmHxk7fhNrWE2s7FlmzFLBp9287f9UeQLpoe
         JTeGpinGRZp35P4TpWwsrc5IktKf69zIZvSpqiawOL1Qin9oOHSGr8lbHpaY5V3zx+5r
         zx81Ny3+H2uyVgCCY6Ju6Ywy7gCt6TZYN41HQslN8PKbb/cUj9jSZSQGgy55gTZUQ3aR
         7e4ixTZZk+E+eQD0kdpvDYbPI6PL4APliHUB3TG2CdIKxy+nT2cE1TG8iK/+KfrL8oAQ
         0Z5JOfcW5qbM53aNVi8jQDnUXgH8VGBI8nSgHHUnUHyVNyVZjSsPexmVUz02NL/5M1NW
         qDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779745488; x=1780350288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        b=G45dJRhMpVMxfiTk/KTipRxc9iWjFTONHzxiPinr0XpKALARgJPaiI16vMmvoL69yw
         RLr+SZupD7QjpBOpuT5skPhSQAwqW15qlx2JuavSS9/uWAbXwz376It11uKHeFKAc64A
         ayT4ZAA5JOuI3GFS83S9TBlML8Tc2D1LEF57E6Cxpo/j2df1hzyJ+8HE50hNq8F6cFJF
         htwq5uYdKcw4GZNz0s/+2mw41bd2aZ4gk+8gk5tXTp6UUabGAFJYPR94JgtsY3bNGH+j
         dVYZ8P6Yw0zdd9bouv9uHnrWXW5Rq7HDpEB/3sgQNwug8i0C1aeARfYKQgdRbIySCuo3
         ZIng==
X-Forwarded-Encrypted: i=1; AFNElJ9KQPNOEfMIrKfl6ThiKcwtAQ/qk0YdDXwDi9QtnZLZjGoywYwpAIQMcLcMIiP/vzNf8AYwfl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kObrPnTFVaJ+bSgHyTWrS6Z2BSI21rV0DWmHkJLhFDiEqgLq
	llwqoSTP2I667xEnOvEXg9JpdEHA5kYKRgLul/dcSuRnr/iNBsSd0zBnOLDQci3YIkzZyhBhQM6
	kUkq0MfRql+kx2a+ugEwYBPFqGBbG7Ls=
X-Gm-Gg: Acq92OGIHFZmPYD5yIwc5LvdPrqQlKiA0TY9gcE2U5h30UGZqQXmDS/8jPSjUAXesTD
	YS2LWB0pG0rQrJlkXJjdw2M58gc3ISFiWAYF/N3DROHaE9ZpWF4Vi/vzwQA0dTEilc55wtJYUgo
	xWWZicAmYjEzuQyvam2Ykqf5gLQXzgYzLQSB3YXj12tGVFVUKC685TXs1hQcwGC/Iw2ilDdvMop
	iVWJ1oyQJL28wejUsjexa+quwbZAk6H3J0AFBAt6W6g6gu2JvSI5DPcxmOcjmkEx3i61EJj0x71
	BUpUcefZOLoPhaT7
X-Received: by 2002:a05:6808:6786:b0:463:a42c:503a with SMTP id
 5614622812f47-4854ae802demr7862655b6e.14.1779745488308; Mon, 25 May 2026
 14:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com> <ahS--cPlhv6NHAcO@strlen.de>
In-Reply-To: <ahS--cPlhv6NHAcO@strlen.de>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Mon, 25 May 2026 22:44:36 +0100
X-Gm-Features: AVHnY4L0Lr1XHbcvt5E12PJzwDX33S_ExYucZKBalfL_rpD9sdnEVwCRq6K5ujY
Message-ID: <CAG-Fur6f65LeVVRrK2PF9_JNyjEwd3jWR1vcChn-FqZFQrjK+A@mail.gmail.com>
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291481-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C90995CEE95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Is this an actual, real world bug?  This code is 20+ years old, all that
> this hints at is that they are always aligned in reality?

No, as far as I know it's theoretical - I just stumbled on it while
debugging something else.

