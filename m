Return-Path: <netdev+bounces-251994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFBSLKwJcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:15:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596E5A626
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B554D5EDE95
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69382331200;
	Wed, 21 Jan 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bvTibq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6030F532
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012223; cv=pass; b=cqffuvA7wwZmeaNfY8HNYJSFxq0x0wM0XPQJQ3aJ0ncJ5y50mkWpBJ6ZTpapgL8QUQqLruy/nGoLr+gQQefQF2veT5zqFeFrgzCPuGN8v78jxqS1QxNBQZoBdfwQW/G5DqVs9bC+PgAr2RtkSpqPD1KkAA7RbkhuEwV+Xujn/TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012223; c=relaxed/simple;
	bh=wnliqYd6zk/2HNbD9zIx0C1pTfY2s30n6EInDoJGwKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1NGnr2IFpUxpwGJ+qhZcSv82W09AZ1vqb7MePmUqHgd1tO3ReI2/yr/mfQh60eObrtppfSJiYhWHyjYVFqTf9u3MiHT9oU6qSDFOTQq+hmecKF3BYWItL1xb5rlfHvkXpVUlUMGyIi7qSqUewKjoF9mNXv536+LgD1qCGMTxSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bvTibq4; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014acad6f2so90731cf.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012218; cv=none;
        d=google.com; s=arc-20240605;
        b=jLllmI+HBWot5cqXzXCjcUfK63/IHo9cHzwkBv7zfwxJxXM4TT/JOzIGuw7R7Z66hK
         yPym5N7UBqbCKpFNL5ZEGseVP7WLuC+KdOFn8hcXs4Yc2TkE2lc8GLrgKQ2cEl4zqcU+
         phow7Fgr1ShmWpbNO7kaP5T010ZUeuUUH9xGjc0PZrDTnsJAZfyHHlLGbRb/4+sqpYUV
         wJcOGk25HfYdYj5wnJhg4C2Q4DBV/Dx9VrJziH4Xe4o/5P1doHimgbMLlAOCk4cI+cTd
         ftWriWnyzewzkYvAolp3zgbnHcvIUEQHepHTkeyRIlEfJhvIukUKlalO5oGFuLL4xIMG
         1nAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84//lGTqBWWDFAN9sEGYZ8ZxR9L02GEsL1prDixx6yQ=;
        fh=EX8kjTzu/zWhQA0BRtC+huxxdN6Y5eJBWkfUCQ6fH9E=;
        b=IiGlxI9sWBaCGDPqtCs+LWJnDnxzZHXEDVyS8XnqiHvUIkmWygVX+imAIU+HIHXDzS
         ARSriWljS20nAZlHdTt8LmsZXc0OlDSSk5jQoz7T2/lsq38RgCzg3w1nJFnpv7F9EZfj
         ffcSQxxl5jYgwJffp1oN1IV+7TD1glDc7RjfstSMnQCL75bSCnkK2Xm+a8U+JOmM5ac2
         dLpcLrQ6ete2ym0Tt6qcwcHsV9mNtcgI5NqiZNe3ZaAslakdC0FvhQmAiZW2mZoPMIPp
         ME3n4ZeMVp8yXhs0HMfb7d948PyKCUSQi4o6FeQcJOdeS9CZOkvYF1/w9zq3H2ITNUhf
         tyjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012218; x=1769617018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84//lGTqBWWDFAN9sEGYZ8ZxR9L02GEsL1prDixx6yQ=;
        b=2bvTibq4R6Rc69OjXv63Xc8sl0YhOlFUo+xd7w/gFbSUXizY0HwTuSWb1ZgctXSQPT
         YjAaB7wcQhTkJoag5eGVsnCyuD1Fqi0t5Wts0+jQouwUA2qBJdsZI3pyjXl3q8/L2Bs5
         Qzmkgr2FXy3ACiSbUdnyPjuj9j+IN/VXiTuBXnOV3yrgiIwKt8cnHIKoCn+ZFinjFeL/
         tJQyHnHDIFJ063ZTcz5E/eomh262W9/fwyyFOV8hxYdTzdkO18tO4I4xnMKejr7MtGYS
         CHR2PlCriqklRpN4mHxzn2rINq2PQj4vaSJu+pl+aJliJqnrwDdt6KsP/ozufOKhLc1y
         taWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012218; x=1769617018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84//lGTqBWWDFAN9sEGYZ8ZxR9L02GEsL1prDixx6yQ=;
        b=veyFN+c2rty9L6mFDsQpAjiPUqLt3t/B3yuKHqTw0fEB8ODEU3hMDgvf/Yxn2c2NVo
         9PNmpA7Om+LCqV7ADsRFUM3SB//mpyxHFj5hnXJJ1ipVynduVu1sJPT1iGET/1bYt5iS
         R/xCNGLhxxILNuyMgREuTv0J5pC8lZBP4qm7naxMEAgOs90L8Qv46lD9DFbEBjS4d0lf
         7SooF7HBZvBvYJCufJgtILNmZt07NzsiNtBrRw0Q5xr6Imfy87X+GIBk8kOQ+2oxGwo1
         8/0vcosRkh5s8cCCZRmJRuE5B8JbjdceBJ06xTdTICMHzuy5F2xOH58MBQUU+UqWQVVA
         487Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjhyLMTTXmvRJb1rJ4vb6k6+g9zaPmr7vhqkCKi9KwxV/DnRQOX1+H5Fgf7nEh6WUPMnIep34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHEJi5sw644wSuqx7WRBjc1pwBIPORjA3+uT4l2mcm0uqgfn2
	j0bGu1Wdke4UXLGfn1ACR5QxEsquN8Mq3T4yG1SBlRboDqhgRNWBMe0BH7lkGvW4it4AzvhozL3
	Qos7TOOnqhhw1HJv88F8C4+kw25FfJT7XzO7yiUFw
X-Gm-Gg: AZuq6aL9im0FxDYLEwUvOWGBPsJj3tUBOdNguuBsbkfcy9pxJIFY5OqY32r2+v2fGhI
	67AmM48pdlqPUjI71ql0XIFbRuOqvJL6OPBIBwnvCM6IhNK9MedOMoQKaVMzKDjALxfu2HKZD5K
	7YE6gAM8oz1d1FwC8nGHVwRt0jVV/2DOvY2PUuylDyeJH5yCC6HNGZgLlusV/VSxS9OcK5AYKGU
	gsOu9cttrsSZnAlRbTEVg5a/TC3Z68NWkMLubZPtDslDQyO4ZbVhFaR+nI93NbfOzv51AXB4SMz
	JuStucew8uWncVjebfeaNH/7ZJ6gdctQXGIG7d9MvnRI+HfSgmOUHvQctnwo
X-Received: by 2002:a05:622a:2c7:b0:501:19ce:5bdd with SMTP id
 d75a77b69052e-502e0bfde98mr14486121cf.6.1769012218093; Wed, 21 Jan 2026
 08:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121095923.3134639-1-edumazet@google.com> <20260121095923.3134639-2-edumazet@google.com>
In-Reply-To: <20260121095923.3134639-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 21 Jan 2026 11:16:41 -0500
X-Gm-Features: AZwV_QgVnOeSHDSri6rMg-XBbVOpc9hL3r6ONSk0-hOPcOmNg86IUvtTXMnXG74
Message-ID: <CADVnQyn1U3Na8_xyToPyfjXzyRNNB9-Wxnd5XGY4s7idK=M7bw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: move tcp_rate_gen to tcp_input.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,vmlinux.new:url]
X-Rspamd-Queue-Id: 5596E5A626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 4:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This function is called from one caller only, in TCP fast path.
>
> Move it to tcp_input.c so that compiler can inline it.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 226/-300 (-74)
> Function                                     old     new   delta
> tcp_ack                                     5405    5631    +226
> __pfx_tcp_rate_gen                            16       -     -16
> tcp_rate_gen                                 284       -    -284
> Total: Before=3D22566536, After=3D22566462, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

