Return-Path: <netdev+bounces-276648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGtMBIOF1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863B3BEFE9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 429BB3002505
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BD3BAD8F;
	Wed,  8 Apr 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufh9vfJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAA347FE1
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666556; cv=none; b=IcxlaYJjnFCXB2DlJ9opLn7ToKsfg2LjTfYB63dXNTIS1md0MyJGKFxRJ8+S9Jw6pQy9j9kkuBc2NG2YHllYXYjVZwJaai1xQP+AT/Ng5S7VgrLS2FG6FdoZnG9KZsDwEixG+dZ7G7TA47BKNGJ9dg+joJMG89subzcYsntXGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666556; c=relaxed/simple;
	bh=bLTx+c32C/qCHUhoY7N2Byd8IuNJWjj4peOddNFV/tg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2jV80X1e3rlnsxMX9AY8uJ/3jmfspCLpZjdyrYoXcUdgRQF2zXOiGgBmMMQfJbOYZsLoi0sCD4+QPJH5YxEPcUkL069XoOKO9hPJVNZ/MtVFPkXQN2dqu6pbf5QiZc0TUR4QhqMBp8mez5YUkFCQmT8MSTpPwz5dJgkLALWOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufh9vfJv; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbd2a0211bso22579a34.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775666554; x=1776271354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ2Mix/WsrjuvVUa/+AnBSq7oOCxR/J1k92RQPsE65E=;
        b=Ufh9vfJvLsHaNBzA05Q8+VpuyYa8nVYc1tiO9AfLms29/IZ6Zj6OKGFL4uOpYHd3P9
         beEk8q1R6XtFdwpSJGLoKqGXtlqvaThxgjQsqB/SKc8ZHT5iRq2nYUzLGQKH952zhpSJ
         YwmalQ7nXtgllfREtsmo41Blb9q7LCjUi0pqfiqQD9X4+5BglmMupL6qTYhAYMbvuF81
         ByqLZTQuuIxfHG6R2ZwJTCvvDFAf3csjs1UZNusadui3zynluRjWvCCSLk8D5VdpyN8q
         WzfSbQbVP0ocayCMpGs2v9lhEVJBEUiAqfbsx9NKm7s8pj3rjVCuzc7ZxkscU1xiaCUi
         cREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775666554; x=1776271354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZ2Mix/WsrjuvVUa/+AnBSq7oOCxR/J1k92RQPsE65E=;
        b=HgZlh1AObT7DHj5YepZxIXODADk7Vne3hpywmsNVC+UGcksRpeUTCFG5XqPQBqgdcd
         KLj0mqsyL/QNO7Q2RL7JNF3A9gPdyjPPRw7BIZL5LJusz1HFEL+3SneDi0WvE0P6ihgI
         6+bJbZh3A1hY3LJZ8DCfsl0yWxC5kb1mo7qUCPrVqQY0ykJrC1Rnr5/WZeH5R+QCBlAF
         11xf1Jnf1CsO11FRzSm0kB6tiA7+eNIx6M/CmHWvB2kro0KWrbig5cCm35sVk6sfMGyJ
         JQhEueKuXTpbAzMJ/OCbZDb6AvUlMfENgIb4kJicb6Nx+WUdqaRcaYU6NlKK0lX3Nr7p
         MFfg==
X-Forwarded-Encrypted: i=1; AJvYcCWKpcQGEIkvhtD4VSGGPKqQyesLGdo5GhdmQDExcHem3XSxGeVsYxT+CJpGuvxSBOjf5/VP1oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/2pvh54Q/1h7ZXfSKtKvZLSonWRpWt4AqS5X/FFOv6oKhUqj
	+2ZO+lyIJkrW1+ybxu+AYsBQKuA7uqoMod3XPjBhHJ/QxmFd4g3NhYcL
X-Gm-Gg: AeBDietFSt9NuCeM45I00D++fz32rwoX6qzk8ZIG4STTn2tEhJLGXeXQZ0kSWurRz6Z
	TxLvnke82ttkF60wlPfNP131v8mrkOxvXWV7Dw+S2a/ddBLCCIC4X7gG+w21isV8mcKpID/cmuD
	PlBStdl/76nJWx2SkrEntDarubRIDSTdzDtH8ODy6XhgoKprajsnuZoW/iUCchCm4VTC6Q+e3qH
	cQhQa90hXCgNCCc8BzIxJ62nGzwq35zKLW+CqTNyPdk51/JQg1ZzC3XgpweYvUOhZd3Zn7Pn0eL
	cpM/3oK1sPoHlLYbKMdsKfeqhefj3Ltg0hPuN1BdiO46q3AtvPtxJUMwHTH8thtOwyZ9ZaczTgx
	0x5/UKDexBWA7Bi6EPAV8Ftx9OaaYfZa+69cY4UOeLvB97u8+yC+d0YKZiQw9xBFQTqXuyufyPa
	RajX6zYCDZ5cE/vGnUXA==
X-Received: by 2002:a05:6820:1510:b0:67e:2fcc:fa99 with SMTP id 006d021491bc7-68220e45ed8mr11105185eaf.55.1775666554413;
        Wed, 08 Apr 2026 09:42:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68897af6975sm2288130eaf.6.2026.04.08.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:42:34 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Wed, 8 Apr 2026 09:42:33 -0700
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] tools: ynl: move ethtool.py to selftest
Message-ID: <adaFLI2b5eb2mZHx@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-1-7623a5e8f70b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-b4-ynl_ethtool-v2-1-7623a5e8f70b@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276648-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ynl_nsim_lib.sh:url]
X-Rspamd-Queue-Id: 1863B3BEFE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08, Hangbin Liu wrote:
> We have converted all the samples to selftests. This script is
> the last piece of random "PoC" code we still have lying around.
> Let's move it to tests.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/net/ynl/tests/Makefile              | 5 ++++-
>  tools/net/ynl/{pyynl => tests}/ethtool.py | 2 +-
>  tools/net/ynl/tests/test_ynl_ethtool.sh   | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
> index 2a02958c7039..94bf0346b54d 100644
> --- a/tools/net/ynl/tests/Makefile
> +++ b/tools/net/ynl/tests/Makefile
> @@ -36,7 +36,10 @@ TEST_GEN_FILES := \
>  	rt-route \
>  # end of TEST_GEN_FILES
>  
> -TEST_FILES := ynl_nsim_lib.sh
> +TEST_FILES := \
> +	ethtool.py \
> +	ynl_nsim_lib.sh \
> +# end of TEST_FILES
>  
>  CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
>  CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
> diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/tests/ethtool.py
> similarity index 99%
> rename from tools/net/ynl/pyynl/ethtool.py
> rename to tools/net/ynl/tests/ethtool.py
> index f1a2a2a89985..6eeeb867edcf 100755
> --- a/tools/net/ynl/pyynl/ethtool.py
> +++ b/tools/net/ynl/tests/ethtool.py
> @@ -14,7 +14,7 @@ import re
>  import os
>  
>  # pylint: disable=no-name-in-module,wrong-import-position
> -sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
> +sys.path.append(pathlib.Path(__file__).resolve().parent.parent.joinpath('pyynl').as_posix())
>  # pylint: disable=import-error
>  from cli import schema_dir, spec_dir
>  from lib import YnlFamily
> diff --git a/tools/net/ynl/tests/test_ynl_ethtool.sh b/tools/net/ynl/tests/test_ynl_ethtool.sh
> index b826269017f4..b4480e9be7b7 100755
> --- a/tools/net/ynl/tests/test_ynl_ethtool.sh
> +++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
> @@ -8,7 +8,7 @@ KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests
>  source "$KSELFTEST_KTAP_HELPERS"
>  
>  # Default ynl-ethtool path for direct execution, can be overridden by make install
> -ynl_ethtool="../pyynl/ethtool.py"
> +ynl_ethtool="./ethtool.py"
>  
>  readonly NSIM_ID="1337"
>  readonly NSIM_DEV_NAME="nsim${NSIM_ID}"

Do we need to add some expects/asserts to the script to really make it into
a test? Right now it just prints things, so it's not really a test.

