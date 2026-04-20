Return-Path: <netdev+bounces-279741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIeMGWYl5mmOsgEAu9opvQ
	(envelope-from <netdev+bounces-279741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:08:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2142B42E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0902301AA98
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598839FCD6;
	Mon, 20 Apr 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGltjTc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51513A1692
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690520; cv=none; b=h7I66IwcZNA2HQdRxxiXEbM92beoVAvZDpmgVqz26jlph6PCWq6xv6N4XVHy6Oz6GlZUc9i9LYes8APSZeN8qQgF0jmV5vpzJQ08DgDUYjEWzzbCTLxXPUbY4Q6L/EDoH2cvpFJWRKXJsSkKtHmofI+VVQ80nXL+x64C8k62JO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690520; c=relaxed/simple;
	bh=WfdVss5pRtKxRJBglQrxBTFvd3jpqaaHpT5PTY30qcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYaX4Z/5O55IleJztmnOXIfoQSF03vmcx1g75UOv4wsBQ0L2c52ZyMPbGJSQo5BzHc7oVZt+AJA2zo4gOeRmZB/nvQ4dVl6ZoZcHQ7463bqIzTVWbtNhDCoGAzI+b1667f5S4FvgSwdJimDoyJJjiZw8VexbWjbLUm5o4PCerTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGltjTc6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so46859465e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776690517; x=1777295317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wEN4jEMCOiQ0Wb/rEfzmY335o62y1i/d8QKlDPNvdc=;
        b=OGltjTc6So0lhKLVhds0TswoCWFDJLk1RyqcSpCHjngiDSXfD5qOTHXrYL2PTTDpO4
         v83z+cMlwjEC0txBbh1a2dPjxP8+QpQBw1ra0IcEEaVFjav8uooyRRDJ4kIl8ifz5mZ+
         0iNp9vcdp2fR9/OHUfh9qEWcj6f7224FKwuHzEjC/xCOLwHlLOca3Asl1iH9YJYWVHg5
         3fKqSRVvq8ri7c7pvk/zUHTlAfggOHqjCUVBjTqUh0gO2Hinc4TAZ78PrSL0tG//FHFm
         dmnkWl/uHG9tVclZ2rrwN4bGj9SDXe/mNO0Rv6nDsxLy9yoNA1IJfHCpSTeACMyxlcC/
         haxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690517; x=1777295317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wEN4jEMCOiQ0Wb/rEfzmY335o62y1i/d8QKlDPNvdc=;
        b=MuejAdge7hq/rHLgDxDA48AbPl75krK+k/5g9/RUBYPsaB1p0dwg8Mep1CDK4izTqw
         6crR97ZQfKw35tibG3WnT4CFJA6IrtrG9bqr2egopX3eDNWZENfjry6JaZS5xUIiyFDY
         kxzfiJPVCcKWqN/kkVZNt9evyMhCHvxHVIH16SYZkpMOqi3T1zfpoL0jyQDgS0wWFJ7d
         hg36lXsHruL/MTc80KtlVod+kHxYS8GCjGLCXHlf0TVaYdp8GQ4VsEDMJTMXbfaU+nDQ
         lvZ9yjmeQH32aWvjeovdOigztjAU11M/glnf0RGctzaR74AAshU9zpxxbC8wcxrm02Pe
         x9/w==
X-Forwarded-Encrypted: i=1; AFNElJ8b3OljhzK+eWOrvXPIeDAnjV9YaTccgHaZ2wH2s4CCNUL6DoMiEnSx2zKqZjkszd/D5g5oRlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKS2mUtpNZ7ILHpEhAW3duhTc89IHbl9zVzIDsdP2KCtGo5pj
	rHl7huBFVVp6SCblBnWm5/NFP8DwdXmXAP7if7tyWBL0rtmUuzj6qEQC
X-Gm-Gg: AeBDietyF6g53jfO0vi5aMcdS1AzwLck2k2UrPZPeak11dWDF8HNGDGMDij4IqFAWuy
	NY5xryQybYlxCWP9ZPYw/asHGWdLV90pDjkDU4XxHsXu1zSE5BVZxkKVoAgH2+Zqp81dS8lcht3
	vkaZp+BbgXa41MwtZd8kp06UfXpAmE6TDytfTm54+s7xm5YtxDAxKKbPoOIrI/wsPopxkIm6XA0
	xbTUBdMOdtHg5OWqmce/f6+Y5BU/CeAt4/74mqOjw6ll2KeHaxcrxFCE/M6g5TcztlfU95yU3nA
	jl1RcIcKK4m5BjpoMELZjzbHF70QV8RoRsMxvQ2j6KUbbgrQJPyFc6gmpk4soShvjrnwRumGk2N
	3Jlu3yD7MzRUtJuhCiuHQJ28qDgb+RA0nnNgt5wi+59OGtRzSkhZWfcNBre95jJyJkhjp+E2Fo+
	dx+kzCmpBJRabjnRcf0phio5uPsITImU/8HFS2L7YOiraafaWCHhFvlc35kB9cw2Kci3Ph1dMBZ
	4Fq
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48a53638e07mr5220075e9.22.1776690517192;
        Mon, 20 Apr 2026 06:08:37 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm21505945e9.13.2026.04.20.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:08:36 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:08:35 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, lkp@intel.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 4/6] selftests/bpf: add icmp_send_unreach
 kfunc tests
Message-ID: <aeYlU9r1ZyQ7rcgs@gmail.com>
References: <20260420105816.72168-5-mahe.tardy@gmail.com>
 <4cfe307cc6b1197fc7bb3a11e79382764ac1d269a42eb4e4ffec9e991e6868e6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cfe307cc6b1197fc7bb3a11e79382764ac1d269a42eb4e4ffec9e991e6868e6@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-279741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 38A2142B42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:36:13AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> > new file mode 100644
> > index 000000000000..24d5e01cfe80
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include <linux/errqueue.h>
> > +#include "icmp_send_unreach.skel.h"
> > +
> > +#define TIMEOUT_MS 1000
> > +#define SRV_PORT 54321
> > +
> > +#define ICMP_DEST_UNREACH 3
> > +
> > +#define ICMP_FRAG_NEEDED 4
> > +#define NR_ICMP_UNREACH 15
> 
> Jordan Rife previously suggested in v3 that these ICMP constants should be
> imported from <linux/icmp.h> rather than redefined here. Would it be cleaner
> to include the header and avoid the redefinitions?

Yes it would be cleaner, but looks like I can't do it simply, maybe
there's a solution, see the answer from the cover-letter:

to Jordan: I couldn't include <linux/icmp.h> because of redefines from
<network_helpers.h>.

> 
> Reference: https://lore.kernel.org/bpf/usz5bhydsiejr37owgt3zypckzh7fa7ygmhsyaaiprsljx7iy5@ipopnr5n4ds7/
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24663313503


