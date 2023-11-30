Return-Path: <netdev+bounces-52467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FC7FED4A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D0B281A5F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD238F9D;
	Thu, 30 Nov 2023 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/z1/yBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C010E2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:49:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so8324a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701341365; x=1701946165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzUVqIlIfPO75xR9q6rHuG22MK24VAKmADXe27uB5Hk=;
        b=K/z1/yBxRPS6QELGH1hCkHAP32TXzIR1yF9uinEfX3Ff/IDSTMLaA8S3a06KX8IP8o
         m3PDHDr7FnXr5UyHCQvgADKBRbrVSjRrka3/M1xmyA7dQYzZkDIrpRJ2KZFe8aSsJn3e
         nsP4JklO6rII0IFxBBOeblJaCgiciWMtDRrTFQZSkgKtTfTMvj8z2SIUQkq0YuRPHAVK
         Sbki0EBb253s4zHdqVzP6WdZ8JNJ5keaDb+1fzh6xzdt6frseZG/MrH6LhhX+JN6zyDH
         cFkQtk3/GuxeXflcaIE04/T6mz3NF2alpKyxi6+oWBg/0t3IUfphb+z1tgxFEp5Qfvhj
         1DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341365; x=1701946165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzUVqIlIfPO75xR9q6rHuG22MK24VAKmADXe27uB5Hk=;
        b=DkxIwycKCEXagcbvfju+WLY/wZlolxGhg6vByQACysbvPYa4tYFAQA0rA5nIAYaprF
         z3zFCGvwB0DhCVZgXpOEYk55lwfvzgGH29DsIrZdLqh0PPpuAbOm5lWw6yHVqpOCm9AL
         fU5/pRLaI/eYk2Cjy4w4D8K22iQrwVSrCABnwu1H61NYWYYWfBclGm+JeZvoI8Rv0nx6
         mw02sJr5FAfTPSxUtluW2dHMRAkoAM+x5J3geKRBbG1OfbgAUFFcebFsxaE/Kv9tdA0D
         C0c3dB9XVnn/KWdMFFkcH7vKUHKXciQ0Tfd/XnNKZla3xNpVihQhbN7vk9YPV6oNUw5Q
         J+Hg==
X-Gm-Message-State: AOJu0Yz8h0T3qUxNb28bjw528UUHwRddftXgDkw+x0eR3lw/lYH51uPz
	OIItVsXfDKg9YOJA9rA15ft1ukndZVAhogVK45HM/g==
X-Google-Smtp-Source: AGHT+IHsbTvXut8r909kfB2aG5SPWh5LCyVt2XDIGv6KLl/C5XDxu1kcfLK2lRJ/rinqW5jzGEFxM12M1YAd58rPyX4=
X-Received: by 2002:a50:8a8d:0:b0:544:466b:3b20 with SMTP id
 j13-20020a508a8d000000b00544466b3b20mr99547edj.5.1701341365347; Thu, 30 Nov
 2023 02:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-5-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-5-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 11:49:14 +0100
Message-ID: <CANn89i+4o+V44oaXGCEfkVWBTCRzFFCEhvanG6DckVS10NSNjQ@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 4/5] net-device: reorganize net_device fast
 path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:28=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
>
> Below data generated with pahole on x86 architecture.
>
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> ---


Reviewed-by: Eric Dumazet <edumazet@google.com>

