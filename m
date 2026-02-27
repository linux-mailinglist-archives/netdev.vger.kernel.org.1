Return-Path: <netdev+bounces-261951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOrmNkPtoWmJxQQAu9opvQ
	(envelope-from <netdev+bounces-261951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C31BC8E1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9E2831AD16C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32583ACA7C;
	Fri, 27 Feb 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="VUUmes+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E73939C6
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219424; cv=none; b=t+V7xIz391f5EcQUJj+1cpvHvr1FZq5PkrUJpotlm8Ijd9zdaDyLssBHBQNRBI7WWTz0gc24tvffZoo6hIJe4Pi1IiQpEpvht0jW+haU4+E3aGxK2DyrbMx9suDtfKq2V1UrMWULc5KEdCba7XCWbgl//6JEUEeRPilIKydTWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219424; c=relaxed/simple;
	bh=wRsz6sFYCEWGluPn6aUYpGD4Zes6VntrFKWbRAHPmTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJVoowFs2/4yVmQos15QvMQmh0GJONTInJGfPJjmltl5Pty+rrlNLQvauRNkyTH4boghe8D5F3vcW8rKCDa7lzqdVv1eD+54jGNGZhtOiLxfKG1BbcuWTfG/zz8AYT8SmCPxd0srpJqaLWDkWGtKqnvUTUImVilIGT+7IZ9geOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=VUUmes+J; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ade1806c28so14512365ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772219422; x=1772824222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X43j2DUGdIFSq3q1jZJ01eH8jaKKw5456FRtyKFHSA=;
        b=VUUmes+JdnB8m/B9DbzwHPxu+PKW9jT27j8IHUrKviSvkOnvPLUNFvswy7RiwtUPoj
         zx49BBGV3GYRDmgdYhadpT6DdPRJopqfCaVAmtPU2i4+mLTO1u6nnJIgkNXmLvSMxCe0
         TfYFYW6ZrYvOqckATrwaducMTKkrlPopnn6Hc3xAKmSP0XTBX84Leij2TegqtnBaBKFG
         RZGQQohwhspjEF/FNGRxZo3CtDM8hqjbbl3UVfkgKhP0fGo1/dWeoJP2ftgpFL/mSdGH
         BLF6FV11IX/LsSiNYD1v1VVwiPY5P5TI1gJ3b1h4j/pKc6S4TX+Cq3WWztkKpLUHBxrn
         OvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219422; x=1772824222;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5X43j2DUGdIFSq3q1jZJ01eH8jaKKw5456FRtyKFHSA=;
        b=Sly8oH1oQYMPERVWzGAUa0htlAYTdsdxwQGaNwogAq/m1TWPFOSFVxy6epjDy+ZMze
         Rh2dWY9OjShDm58IZRQWsjMl7GZPGFb5KVwxeLFHRkyjJ5wCS14RAddux8nrlrw52X0g
         82WPnx4lnn2o3AJ083x/jnecBW0p4UgCXk5deduUYuUH4sTQGJW1d5mEACohV+9smplM
         qczCel5R6iDNADKRDfRL2i4KYb5gPj+fvrYjDQw1qCOtDjR98Il6yh12lrqlQm+iqA2a
         3RX4bJZrQdScBLsFawzGuanC8tSOgSvuFFHUhr457xU70DeXSkgkc60XltJ/LhFzJE/k
         u8gg==
X-Forwarded-Encrypted: i=1; AJvYcCWKQBJyMPXkpTPKCVYkxwxZTgplxfzOdhJ55GstdD8UdUqX28GCx3kFxuSySRrrsXHbIkNkVw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2pXHpvVLi+JVaNobH+VWZ44RWK5eXO+zceh2GhgHb26N1zDC
	bxQCTK8QYxETormFgErCFllFl96weRZMs85ptvPcY22bLGm/b0AXX+rAwdbtC9neUz4=
X-Gm-Gg: ATEYQzzKUmdKm3Pw2b2RScJzQqkNKve1EA/Y5Q+WkKQ99a22XNArANLG97wPK0M+NQC
	n0SSJp9tHVSTGPWuZYYzKB/ZxTUapUoVssKXeCTDpOOgBK1OJ5dhS2rvfW2UI7htWGX7lREVART
	YB+TM7ga0/44l1H92FL1R9WXE8lf1yZuwfSENJuYRm570B276/2ZBGbyufkmOUB0L5FE1VR2BpH
	ojUeuscN4gB0wc6wBY9Rldf/4mW1jGT5qyxAgMZ+zhGPrLt0mU5AAK4x7kLxTCRk6wMRSaTIZDy
	SCmM0Jf6jcudD34pq4UXFU+wDzDcIlZBmrDVrhr59AwmixT2i9lrEjbGzThUBs19NvylvpK4mhK
	0+VJQyqY5wROAIRGGc4a5hEZV2NX4neOfv3Eg0NvLmFxVNU7VBMPFsQL55q/LIAsmkygM9LatoP
	GVpoH3YtKtGdqhjDc=
X-Received: by 2002:a17:902:cf0f:b0:2ad:bd4c:a6 with SMTP id d9443c01a7336-2ae2e4e2373mr39407325ad.49.1772219421803;
        Fri, 27 Feb 2026 11:10:21 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5e1174sm64053165ad.41.2026.02.27.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:10:21 -0800 (PST)
Date: Fri, 27 Feb 2026 11:10:20 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aaHsHJYss1lgxmcg@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1772211065.git.carges@cloudflare.com>
 <632dde7417fc23bbcaf48bdc2e947f2695463e53.1772211065.git.carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632dde7417fc23bbcaf48bdc2e947f2695463e53.1772211065.git.carges@cloudflare.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,cloudflare.com:email,dama-to.20230601.gappssmtp.com:dkim,xdp.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 4F9C31BC8E1
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:40:19AM -0600, Chris J Arges wrote:
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

Reviewed-by: Joe Damato <joe@dama.to>

