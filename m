Return-Path: <netdev+bounces-58458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05E8167E4
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 09:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FA5282DB7
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25739F9E9;
	Mon, 18 Dec 2023 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Oql7Iv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D201118B
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702887414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUag13Qv3e+BRTg6Ynxq8V4FPLpzx1zmCnPquT3Mq0=;
	b=V4Oql7IvFqhCbrsxfhR/LiE+8C2raAVASnA2cIHt1aI6995FBMmzEhdwsCoxq+mR/2wR9x
	uK8JtbfGF1isbtKTpIU8ef3+f1xuIFmocawgJiCw6M5ohvayvMunmNSPJWNOqC8/sWXEi/
	VaFNtzUlLzXF2F2Nv23Iw4tkZv0v/ao=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-UQ4NT648OzarA3Ivw8kZ3g-1; Mon, 18 Dec 2023 03:16:52 -0500
X-MC-Unique: UQ4NT648OzarA3Ivw8kZ3g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso58072466b.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 00:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887411; x=1703492211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGUag13Qv3e+BRTg6Ynxq8V4FPLpzx1zmCnPquT3Mq0=;
        b=NL7EKP6U8tk270bzuRITfprpRnb//sdD730J52auAlxYDAlLqHmpIeOaxoN10IxLju
         RMQCOPakGE+HnuI+Qk56fXBVOkSxU5Hp1HuqKe+QS8oPhjmtgtVOQUhGoircB1DQ+hpy
         BybrJsY+9+NN6SOp8it8FithFyXMj7/PnitgimeDnmKNmBCHiLI6iLDTtLDeyPhNhF4y
         MfSpWEOLpavVieylkaj+xr6w7K4LylQz2xtRvBd0pDo3X418H4aMqCWxnMett6d4mzh8
         cM8CF0P/7DyEYNkzab1BqubV211haYqfHIW6+AtVOLe/vUsF2Ff5Z8qi3/8IqIBTeaqK
         hpJw==
X-Gm-Message-State: AOJu0YxaXf5za0dNDJSkOp3rmsLx6uUFnm8nCHwqpxLVL5qVek9UIa0k
	CPZ5x5qV9R0c+j0g1PHOILt9ur1OfahHBESAE/XYBCJnKds/fP0D3N5umcEpWMmphdD8tlCzuTk
	sLZCgQYxvQOcAmCQd
X-Received: by 2002:a17:906:f586:b0:a23:5c9d:4233 with SMTP id cm6-20020a170906f58600b00a235c9d4233mr1057278ejd.7.1702887411732;
        Mon, 18 Dec 2023 00:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpHjyXraaufwnJ/sd16XraNMKF3PqVp7EJZaPzyYZIgs84Jdx80T/2ekNop6io/r6Qk96Gdw==
X-Received: by 2002:a17:906:f586:b0:a23:5c9d:4233 with SMTP id cm6-20020a170906f58600b00a235c9d4233mr1057264ejd.7.1702887411423;
        Mon, 18 Dec 2023 00:16:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b00a1dc4307ed5sm13745382ejc.195.2023.12.18.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:16:50 -0800 (PST)
Message-ID: <e6509e106251c10a9f65bf5e520911cda26060a6.camel@redhat.com>
Subject: Re: [PATCH net-next 01/24] locking/local_lock: Introduce guard
 definition for local_lock.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Mon, 18 Dec 2023 09:16:49 +0100
In-Reply-To: <20231215171020.687342-2-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	 <20231215171020.687342-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 18:07 +0100, Sebastian Andrzej Siewior wrote:
> Introduce lock guard definition for local_lock_t. There are no users
> yet.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/local_lock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index e55010fa73296..706c4b65d9449 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -51,4 +51,15 @@
>  #define local_unlock_irqrestore(lock, flags)			\
>  	__local_unlock_irqrestore(lock, flags)
> =20
> +DEFINE_LOCK_GUARD_1(local_lock, local_lock_t,
> +		    local_lock(_T->lock),
> +		    local_unlock(_T->lock))
> +DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t,
> +		    local_lock_irq(_T->lock),
> +		    local_unlock_irq(_T->lock))

DEFINE_GUARD should fit for the 2 above, right?

Cheers,

Paolo


