Return-Path: <netdev+bounces-299647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eyS2KjiCMGrJTwUAu9opvQ
	(envelope-from <netdev+bounces-299647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD768A7D5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jJnI8+oY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299647-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299647-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6013A306380D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55C23BADAA;
	Mon, 15 Jun 2026 22:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D73B9D9A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563900; cv=none; b=qY0hRvAaBUY3KY4zzpIKAm9j8lU+iL5hr3hvI9yPnL0PaRDOfDJRFyUA4iyQiWoGLqNgu4SWqFHgpAGQhy3WltEAxcRDPoQkJByOJOA7TlB0qLpY5fg57ACUMq6YyTVfezpSAL50vWjllhzpUWeb9uDWIzTRYXjC5X0dDd/WVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563900; c=relaxed/simple;
	bh=ujAjSm7BhxUMJVslQmleewg+/DVfcJZ1Gp/kz42YP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAYY2tB2cQbt3AI7xE5oLDGRVPFA11icN1dO8P2fBb88h1HHdSDabRNVp50ouqUEZGQ7L2/euInCCyClxGHuWlUgYCojswvptaiuYrxArW9i5RJCF+lqQ2+IFl8ee0CoQLDBjGIEO4JXlmyDXXq/TbjSX+Mz6qsLIrY361gNVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJnI8+oY; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso34639385e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781563898; x=1782168698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=jJnI8+oYnPGKCz46aKZOuPWQYTSJIPRsolTSYqKCWQAgDyxI1SUBQmqFPHVks2+TpB
         4iXUTu4TTtWwNv9roSa/ClXgKgXKToEWTkT5BT1YsaXY0a0ggqk0Itry41UPBWBcZx0C
         j6EyCnwFF4AW2Picfnn1NUNOzYJyfPmMqXugAScEXFMIGSbi/W1/C78bkBUiTLVluXcf
         u3FhIRglS783WShkExW2P+uIZbMqLgPGCGcUvPcfBSc0F26elNnxjbXSnVXwPr7BoKts
         aM1OlsjHoXBbJqJG5ZNbuq1j4NVigLqHwX44DiwSdmYm6d8mC17tDemNvS19f5Gnx132
         n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563898; x=1782168698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=d8mNcJDJh7Z680lN3xBzf2Ycj7SmMtoONOonDtcaoffD23Oh+4/mvBdggI/nKBfEuw
         /2hf9oqo8Q+46In+7zbJzfdWoBNqhKBMN6rnfakuyz+NQxxHR64qgSHjdcjO3Dlhb8AH
         h4/AoDvqHSgvx6TzeXmwigO1tIcuH39dMAcVKxNKUie0PD8Ej+8p1wVtSJ1997sxWNkr
         YXWBhYYFWyUM9qvUN0GLFquUA7+ASN/7oF4xP4VTSHL4iD38Q4D9rmiDfPXwDAQTyKp/
         LFssw3vJy9ioe8kh1SdYW/vGZ1es/TOYLeczzTrATvICcUqgYS1WRTKzaB0JMC88klCC
         toPg==
X-Forwarded-Encrypted: i=1; AFNElJ9NW9D4TsJCrKm8P8Bc3FXndstpNSXf9RyCronMshXPl4vWG3nJZKOPMtqApD1bm5NrgduvBJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FF5bbm38UYTzLj8qIXgKioN91RGwI0mcSkxJyyp3SP1yoig/
	XMYM3iOpKDwnylKhnVcFynNn7C8MFKyM6xK4WzeG+x+gB1LDOjVIv9Iw2sSIPe8G
X-Gm-Gg: Acq92OF4SeF664GFWKS0JVOBby9RqDt9YX8gVwJMZAo3cXkHuW6sGKj+bJr7MqEDenp
	ytginkGe2WITE9j8SgemZib9Ih8TGdn1gCAaFkSDFx197jdLK6RTSRqR/+H49bl61Azwstq0NXe
	W7Pyr9qsUzYrDUykhknJMqMnnWkvbNUWTI/pgW2cXkro04yDctVHiRhg2VONFzj5qN0ZFK0DWq4
	J3KVj0eU82teAgqM74ls/+vDPi+Mm7zdrkmLUkcBycEy60x/Pp3HRBG7Ig/vyuXdK0p7rDa//rS
	StRILvMFVeyyUIKK5h7aukADAOVZvqcahs1q+Hd7awNR+fOsvA/BWBTiFJPuVve+u0j8H+dbr97
	YDB6fN83l2ROwxnb8NO2cT3l399kp57icYvaV5zhhxPE3jBpumD9LjVTB4E2yVXH4rM1CZbsbvV
	zTO6YAsaAaF1J2Gs9yf5kC5/HZ0i3Ih46bgwoPuKuiYEM36HBqFouk3HCBVZFHk5X3ABvuYAW9H
	+uq9e2gMCv+bSZn2lurbHf0c8IoZT8KjQGuszVnMKT0gkIZkavmzFHhmnbHtkUX6O+LIyhYSPp1
	GriEfLQUoDJ3rbHZzsNTeVw3jpDhdYgBsEkNibIlgqM=
X-Received: by 2002:a05:600c:3b02:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4922f3cd1a2mr28492865e9.30.1781563897718;
        Mon, 15 Jun 2026 15:51:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm38392917f8f.30.2026.06.15.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:51:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:51:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com,
	eddyz87@gmail.com, shung-hsi.yu@suse.com, stable@vger.kernel.org,
	mykolal@fb.com, tamird@kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Message-ID: <ajCB9jXBzPyaDNSQ@mail.gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299647-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:sashal@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ADD768A7D5

On Mon, Jun 15, 2026 at 12:58:37AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This v3 targets 6.6.y and changes the backport strategy based on review
> feedback on v2.

[...]

> Relevant QEMU selftest results on 6.6.y with this backport:
> 
>   verifier_scalar_ids passed all 18 subtests, including the newly
>   backported linked-scalar precision tests and the related
>   check_ids_in_regsafe tests.

The first patch in this backport series is actually breaking the
"precise: test 1" selftest from test_verifier. You can see the full
error at [1]. I haven't yet checked if it's the test or the backport
that needs to be adjusted.

1: https://github.com/shunghsiyu/libbpf/actions/runs/27575831217/job/81523786835

> 
> Thanks to Shung-Hsi Yu for reviewing v2 and suggesting the upstream
> linked-scalar precision series as the preferred backport direction.
> 
> Eduard Zingerman (4):
>   bpf: Track equal scalars history on per-instruction level
>   bpf: Remove mark_precise_scalar_ids()
>   selftests/bpf: Tests for per-insn sync_linked_regs() precision
>     tracking
>   selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
> 
>  include/linux/bpf_verifier.h                  |   4 +
>  kernel/bpf/verifier.c                         | 367 +++++++++++-------
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 253 ++++++++----
>  .../selftests/bpf/progs/verifier_spill_fill.c |   4 +-
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   2 +-
>  6 files changed, 417 insertions(+), 215 deletions(-)
> 
> 
> base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
> -- 
> 2.43.0

