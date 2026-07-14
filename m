Return-Path: <netdev+bounces-307572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wTz1BDeMVmpk8wAAu9opvQ
	(envelope-from <netdev+bounces-307572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B73075831D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:21:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XCt8Lfj2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307572-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307572-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15F323030066
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BD2931E5;
	Tue, 14 Jul 2026 19:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48012931CD
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:21:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056884; cv=none; b=CUOt2pL4w3qtmHkV9fpfhjMO+4M//eo+Rw0hy486uZyaPtlJpr5zzo7hz/bUWrFOMXpzUMM1IvsJ1NPS3Km1/ZAX7X6/BE/F8aW9hdva9ZzkV3R7elBjITf4Wg3XyfS6PxFIlrSdXT700PgKlToKawH/nepvW8Bsi3jj/Hrl6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056884; c=relaxed/simple;
	bh=tWniBlvSYvLc9mXjbuv76SfuUK88aGrLRBkLHUZFF10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCA28be9nBzSTsX5I1N0U8W6e7i+XedXycWP7/gtx9Fzx+kIkQoxr9piSJppynxXpZHkwC/apvn8o6RHJUmLruvcp0g+JQsLCpGRIm9up68ClFQhUtkG3XZxcoYtCUUY7tz41hy0cyk7P76gueUoSnesvSE5Km1bOBkt3Ed+kcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCt8Lfj2; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so56233665ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056882; x=1784661682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mHy8t4zKOYGLPi7aUYeTB15EGxexEveRnk5KK7uTm0c=;
        b=XCt8Lfj2mZnBma3+2nbP50NeVeN67/4hD9v4Dy0VIb/Vifq1ftMBeRVCtEtJ4KJ86L
         SBDTKo3JpVRSRZOUD4x/z+7l3MGMhaxgyQjGfFIROhj5mez1rF13GFpFeFq75gZXWpF7
         qyuSt0aNparC+9MD8dpaY2EUUkX+jwRaNsLadGIzURw4F/KxGZ6+r0Ej235pjUQNsoJF
         FE2oN+C5NUD86VRKG6degaXXYFzcEs2PEoTd/2YE5I3ZUvcv32Bihsobx4+O9ovyCECF
         uhR2ezBUG/OY03Mvz37xvS0ACeLVlWU0dE95qCaZx3RBVHeqLkws/M4sxkxk6wG0vJLV
         9Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056882; x=1784661682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHy8t4zKOYGLPi7aUYeTB15EGxexEveRnk5KK7uTm0c=;
        b=OwuVFAU7mtuhhMR4VrNE3jm5gAv1bMd1rgtYKvWiCs1iT5xNOqvPAiPSaR79LHx4dO
         CG2DzG4aR8AoPmFwAS+AVFMvvmDvT8HoKg7XhV7GSDlhOeGfp/6vPg936l3VSFl0uWxy
         ey9QrcZPm/7NF9gVtCfNepSGWZimUt3afqmyH4YEUsFZPiY2ExfCaVffMEZh7zHXcanj
         xXZXQN2CU3c0+Hz1ppmE+/Krn0XJoG+aiFPJ+OJABpUgsnqVptSArLhSSZnnerY4MD/D
         N/vU/Aw4I95fTJbRl3dNOYhR/MtqYsOKuoHXsP1vyOfly9NPmgJXUe2KJ3usybCfphuE
         NBEQ==
X-Forwarded-Encrypted: i=1; AHgh+RobkUoidiR4qq5eQv2d7czyN3zaFpzC572hujM0xemXRg9sLmtOqpynsjA4KqeDVhrS4oBIhc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6K0BInNavRJUXPPAdhI6u5Cmbn2ALB6wkYEPGHrhf7qhM0wt
	KkqgIaMyq61m4XEOD19ex0qcGVhGPkEFOhg2ZDI0Wcu82N8d7xcY4qWa
X-Gm-Gg: AfdE7cn0Ud7hx0v/HshnVgoX+LZrWKmub7Vw/FizP8/3yaLUFt9dfUobL3XLYkwdzOx
	9/aoH3xvLJ4hgOY8UG4qmVl/B5GSiAPcWZVvKOsshJDhKd1RprFE7Hoz3RvngLGBn+m1skvKiHf
	gT5N15CDNY22obHx8JSOFuczhgUt7CxL3Br3vtvqzoVlVBQYuKouaJ1Px5rS6Ui9QaRhhb8KBOO
	8Gsx/4M9KNhvD/c+1/9a7zCGSjpOLMDop5z+lgN1VrtySPII3LB5IHhOw7GaGf68CXyWJMXX+ao
	ONY2DmkXZ+WaxGHSsFnylN2e0TeLdrPA9r0VPNxfbWxkGg5mFOeaSHSGINw/8BKp89j+zoOlEeJ
	/4LYePu83KUGSnriNAUguyhpwsLJa+kcyOq7YLCQ7W4sQikxCchPvCZnFvpz38uLzu01sKifONH
	mO1tzp+rIP1Q==
X-Received: by 2002:a17:903:1aef:b0:2cc:f7c6:8353 with SMTP id d9443c01a7336-2ce9f1605e1mr141816505ad.41.1784056882165;
        Tue, 14 Jul 2026 12:21:22 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm120804945ad.18.2026.07.14.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:21:21 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:21:19 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mattia.meleleo@coralogix.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Message-ID: <alaD1E0nOLZ59kT8@john-p8>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[etsalapatis.com:server fail,coralogix.com:server fail,vger.kernel.org:server fail,linux.dev:server fail,sto.lore.kernel.org:server fail,john-p8:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307572-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mattia.meleleo@coralogix.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:memxor@gmail.com,m:emil@etsalapatis.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,linux.dev,gmail.com,etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B73075831D

On Wed, Jul 08, 2026 at 06:55:00PM +0200, Mattia Meleleo via B4 Relay wrote:
>From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>counts bytes in ingress_msg. Without a stream/skb verdict program
>nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>returns 0 even though read() returns data.
>
>Add tcp_inq() to the reported value when the psock has no verdict
>program. The two queues are disjoint, so bytes redirected into
>ingress_msg from other sockets stay correctly accounted through
>msg_tot_len.
>
>Remove unused sk_psock_msg_inq().
>
>Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>---

This would be good to merge. The bots had some good callouts but mostly 
they should be follow ups IMO. There is some concern that the FIONREAD
may not be accurate on transitioning add/remove of progs, but mostly
this is done at connect and then removed only done on socket tear down.
At the moment this is causing real application problems.

The most relevant bot callout would be to make this work for UDP progs
correctly as well.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

