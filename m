Return-Path: <netdev+bounces-265827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG41MORrr2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37E2432E4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 123793028E93
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E027CCF0;
	Tue, 10 Mar 2026 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="CBZ2lG81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBB26F288
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104082; cv=none; b=avktnKv5dP7xR5WZps3mPWm1vI/ilmqheQh4wkjZyHL6CzwbxOkrNHB7CeZpu6Azl7yUqN9RqWi4zzfllZV4tTOqyGtBq3EVDY+1/zdjcg3whIJmHnQ3Z3KiVKywIdEKBG5uL7TgMhiiEF5ysr4ls4/I+jRQ/lwAAvy3mGqxGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104082; c=relaxed/simple;
	bh=q/3n1xERGFt9pBxbxus768OlQpVMYV691SqiPTwnCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auBtzmJSoR1XdyS6Lpn0A4cTxlDMUjVZgsAjwF7YtbZnXl7L+UsJ6B1HmURBxkArHjuCI4jdlzarAfWl9uKn6Mx1iuEG8deQo2CSury09PBHvA1LYJDqzaNZe9zHfF/Es8z/mL0AIrHCII/qS4Kd9uwX4J64CgFXTRLn0FkUQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=CBZ2lG81; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7393c6832bso1688025a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104080; x=1773708880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgT23yH044LlGG/ozIQ2ZblhH3i8dVPmq39iaq5VJ3s=;
        b=CBZ2lG81bVnNT7LA/ta8D0fvNT2TDXGpNjSvtvazaOwRtHN5nWBk8Oo+JbJ9zhIeaA
         aCz4q9UQz28WV/E9zJXXXcr3xK6wMEfoZ9DFDNIW/QDsDXgTNwVRUPIzK4elvUT3LydJ
         HIaqTRoIYfnj/xPYUtvkgwTHci7hu08LYUHZiyDl+gXz8lSEDzyldtJKM3mkwgoFygv4
         xy3/8I9+0+njhiqGv4btzbTbKWxSk3bhsGCy7VnoODoUDbKhiLhl2qJuMgXglE1QgoiA
         MjADmZrbYXFp/g4KkT1Rf9Ero1slR2P00AcuixHPNEfVXIKq5nve+rGR1Cfqvf4+R66A
         NSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104080; x=1773708880;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgT23yH044LlGG/ozIQ2ZblhH3i8dVPmq39iaq5VJ3s=;
        b=DRN1wT5baQ33d72lqJeACskoiPRK0m6+S1aiN0PiTiomO1uKhYjTHaImvZWrgxhYFU
         mLEoZIniYuatyYMJDOfUdZdBn+Shcxz/6KdwiAr53cn6xrfRFVXKbHm2jvn+bohmy9GC
         +ckS0VR8vsACPKgAcGGIys+JcbvMUSYyPgxGjwT1qNeb/5fez2TeF1TcL2iIsaHkcYF0
         vTy9VYG/zva3fh8MQDrEo6DMM5Sigcv4lObNV+/KIbDIYLfafWcJLl+wA4VxoYLQMIaX
         vHGqopJlmiv8Yr7+h/Yzx56/8btJh1D2Wg526OfDD5URPu/2DQiz7I5BDcUXnBYe8kS5
         jMaA==
X-Forwarded-Encrypted: i=1; AJvYcCVgyEi/XMLO1rypglc3B7sy2ozJ0NV/JCEWrZp+Ma/TTPs/j8n00SER+BNHxGbBFzC0tx3Uxt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzembOR2Fh3A2Rq58W8AuQtCyVUsJfnEcYxNAj9MDqGfx10rit1
	2CTf/EKvTX+Ec/qm8lf//7uJ46a564v7LdP/GduGl3aNXWzAKg8Xav2EIB/YKO10y9c=
X-Gm-Gg: ATEYQzw+xk4IylzsJDFRg/NPdZsKJSDFxltbT1FD5z9SIjbRVZnajyJ5C8pOECDTy7Y
	dxCbwBzdNQFLVSOIkfqncDg7+/FoWaYfgusjbCSnXqyWSCov5G+XTUgXS0y60aXnUGcE7gMxHb6
	Ek7Oh7h2cuSQZIY37qAItKwBaQK5OepQJ5qyxrFf7xiBjEnpCPPAaDjPafIdvPXwi0no4OOIrMw
	ILrZnCSFFgvu0gHIczVSU87Yt7NpORv+7g3KSsOBdYFt5k+DKVqkIulGYUtMIp58hPnKDKKi9PC
	yrBJr0dxfn3KdNWc1N7Va48/FCIErFgCMxyRfd9St5x8wDupqEPkDT+ZgzpUb1slUvfLrk68uDA
	/iF1t60pRfA2cfQWciVc+rmjeVpXdjSF9by+4bo4l07ssVuyykeNugpSwPDp4OkwkuGuIqlxiOi
	fvyrM=
X-Received: by 2002:a17:903:2c0d:b0:2ae:5bee:f0fd with SMTP id d9443c01a7336-2ae82530643mr146551245ad.51.1773104080629;
        Mon, 09 Mar 2026 17:54:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840c9967sm167614145ad.90.2026.03.09.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:54:40 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:54:39 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aa9rz54M/NXPvDbw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-5-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-5-carges@cloudflare.com>
X-Rspamd-Queue-Id: 5D37E2432E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xdp.py:url]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:00:19PM -0600, Chris J Arges wrote:
> This moves a few functions which can be useful to other python programs
> that manipulate XDP programs. This also refactors xdp.py to use the
> refactored functions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
>  4 files changed, 95 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

Looks unchanged from the v2?

Reviewed-by: Joe Damato <joe@dama.to>

