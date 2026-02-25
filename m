Return-Path: <netdev+bounces-260755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMkTBnd1nmnCVQQAu9opvQ
	(envelope-from <netdev+bounces-260755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:07:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA51917A3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A4213044B56
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5729B8E1;
	Wed, 25 Feb 2026 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbbIv/Vq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D2288517
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992391; cv=pass; b=S1WAYE5zsnO6bctfbaDu/1A4b6gfnJZlOKOquXXCyUj+I05dGZZokCCnI15zeAA0haVV5sP33sLpGcZvOt+O8JIF+g0yjBwXN7zRekChmYaTb/dkNq2j1Kr5lpHa+l1Z8J36pNEMJLeUTLbbQppPPIG2skw8xH+8HscA5eo5KU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992391; c=relaxed/simple;
	bh=Fi+kdpe7WvRf2GCT4ogJgFzTTNqdSBrO/vpBiE1iMQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnueXKRnno//4EIHCguqM+hYfED2RlBqmCFcIRmebt+zmQ+lxT843j5lizMmerWZC4Lkks2Ls1t5PjazpiPlEzl1MV25+lcUVsZUULtLzM3aTbmtoRREB+11IWSCERwwCb5xThedcqDdNOiUQRN446WlFpdk8YO7J6rfGczRIoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbbIv/Vq; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43767807da6so4544525f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 20:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771992389; cv=none;
        d=google.com; s=arc-20240605;
        b=kTQO1r+l/PYGCjzVYDAk6rJDn2BGGg7AQuhzK5SmI5QwDqcHuHayaj16OTR0Mmkact
         HdbXoDbNw7NhbnB7aecqwnxTdIDBXyZFN1Hypba8kxHWrX7QbM2XqQwdIxrPHdgt4CFG
         Fkn8eVfSwPN/3gtgLtXpJ0G6wYfsx19rtzTNGIXXsthzQUKbLy+BSeTW6Tftz9bBzVIX
         7IJaLWu57a8b24oSknsWtBNSRJ4s6QDCOuo3s3lfHOIcR/uRW/ZXwzytJxTj3WSvyvj6
         kifcpbiPieqYrafGKAI0IbFS1ljUlEd11vJjU1ZmXcpOPQZBIR75gT1mlVuu74hRwJl+
         nHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        fh=X13FNSMFOq9QrL8rMjc694yXMgIGj6j7L54Sdq/OoAs=;
        b=MpCGyRrJyoMsfaHsabS2E7xgspWpzt+pyHudXiZTipDSlyFjjkuU4ssknMe5UJkiC+
         RnU4kdjVlD9s4f2LJFVCRrDJqWEPESzD0hMOHoqRmWGMNnmb7he69GehnVRLqK/DKQEs
         l56wIPMgAXpQpY5kuCud3gVMzPxbw3TnU/2zZfM41+7LfPm4NpslEasKLKOmiRxtw5/+
         8R3Blq/jQhhO0StGgTB2JX5oLf8PCnPJIND465KOJ8ExXSlvzmYzLSBaTlEI3RsExDU7
         lIsxkODD54TFiFhf2V2+TkMWni91bkctdIhTwORQtKSPUIDQozEQBb6FYqQgan3uLkSC
         IBKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771992389; x=1772597189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        b=QbbIv/VqjpJROftbsaQAdwe9E2lBaJp4HIy886gNAZXx80agbJZcMpH4snDoXHV/gq
         0IFo8YyTkn6qFa7e9JwT+Fc/PcNW/g/eG5VBW72afElLBduKBR1+29Gh1xRYWZ+fwCNI
         pr3STx4mvI+cvJMiNPdbKACm/u1J/a+x7g+uEdVSHzfCKQB1FyH1YtwFsTfBQhDTnVQA
         Jj7o87PphSrS2+OH+62/woUItlPZ+Dduz0kbRg0VND1JXDhX6F2FFHqlgqHATvFZg85n
         qDiJClVCVdQy0IRf+F8W9vPLx1z/E8b3Nv/BYlzlVK7h0Uv7QH2enyff+f1PqFg1KUrs
         L/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771992389; x=1772597189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        b=TrzEj26j0VdFLJSuy1mAfGUwvfWkIIp/EWT0oT606DdGDRHS0GlLbYK2bx6aM1E462
         Ot01RDJBjKahAszb37h1UFMNsLhHcbkDuIfM6OyyHj2QeJM+Cxb692hsVJszOtiU0rgR
         kFvy0CP093RniqA1dnli19tufze1MGMGy/swyKVwKjzgKgy+rGMr9B2i+2p7dWS9cE71
         ptIokYAaKA8h82RsScrVr3H6Qr0PjHY1aQm5zcCOfP8Dq34wwy9tbPR7x4qeKj1wbmrs
         VFX2lrZDpekj7hjP1XYVa92FohLAv4Kva4ONuwygm0lAAHkDUmHVqy6zvbe/B15Olpeo
         Qg2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTGtB0Z3iR2QMTkEEbmaPHB1vMvmrQiW8V+4TzecCCObEE5/ZUI9T60sJxqblyeG6tp++L5Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVvM8sGMC2QdVAvoGKGmhFWP03LfgKaq1FY6DyEE/rB9UBm7i
	yFoZtszP7XyZ5jnyZf1Y2Y/4G5w+YWLHphQCa9GlxpvgHqdoKCyGMeP4xovWQ/6doOG9zrvezjC
	QrKervF8B6beWVQ54/W/Ue9/R6QBo6d8=
X-Gm-Gg: ATEYQzyDdevVkskO/9FdRxGHln8pkeadR4HOxolozC/cSNRyop8LpHmraFikHgNuW5x
	P/PtNeC1MVsh9/nvlYESg0nRhfKoKNKvrCZntY0CT/iYvhRfpcCRNwTxu5PIBmJpBsi7/JBRtgI
	L54Y/ZKsvWcL0OFdLBErmeQwm9Bh3mS0xfjx3E8ab6u11wb1KYGLGD8HDNN7hX+9lBRW6Bpp4ja
	N7xmxa/wb0aGj3FuYwLfjz36z/pqXLBNGxXdyQDMqfIAHaboWB/KzzjMp5MscydWuLd/bUKw0lZ
	8YpjwdEvdpNx2T+nfBhAYTZi1hTluuiHZSu1vjTFbgiXOuFZPdhfFVGFfbsMx52J93B8psMwOtu
	nmYmKC8XQKUZ9m4H+knbxRY7cVA==
X-Received: by 2002:a5d:45c9:0:b0:439:8487:73bf with SMTP id
 ffacd0b85a97d-439848774c9mr6713839f8f.41.1771992388923; Tue, 24 Feb 2026
 20:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 20:06:18 -0800
X-Gm-Features: AaiRm50fiorsm6xJbG-jE7y7y4BDj47ek38nJoU30RvjtWbz87B8DzjZJxXZKKU
Message-ID: <CAADnVQ+Z4n8e9kkZ1Tg1F3cnBXv-2QZmt2hiifnBhDGeuiRxiw@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog runner
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260755-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FBA51917A3
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 8:29=E2=80=AFPM Anand Kumar Shaw
<anandkrshawheritage@gmail.com> wrote:
>
> cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
> XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
> falls into the default case which logs a misleading "invalid XDP
> action" warning instead of tracing the abort via trace_xdp_exception().
>
> Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
> the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
> devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).
>
> Also pass xdpf->dev_rx instead of NULL to bpf_warn_invalid_xdp_action()
> in the default case, so the warning includes the actual device name.
> This aligns with the generic XDP path in net/core/dev.c which already
> passes the real device.
>
> Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
> ---
> Changes in v3:
> - Dropped unrelated queue_index changes that were accidentally
>   included in v2

Toke, Jesper,
please review.

