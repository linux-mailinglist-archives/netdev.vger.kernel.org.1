Return-Path: <netdev+bounces-53626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F315803F50
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451C2B20A68
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B92FC48;
	Mon,  4 Dec 2023 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnwYqH9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003BD2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:30:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so3317a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701721856; x=1702326656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Flj9PSEm5qn3n/BXHUntswUiOpnhFSXTydYmHyBlDSQ=;
        b=QnwYqH9egC9xlVvW78fe/6t+uf5eapyw8YIdyjfALx8HJKb3UKxG72ArRp2z4q5I67
         0h/DTD3MTbSz8XKhtXdzai2H4htcrCs+E5rbCDEdS3Nv7OVMhzpNBvoFthb+AiwPwwh/
         HUnUuBdn180gulsZ1eSp2IG0YSSM32KGeD91zJByNxXlTBG2a+M8mokDxO92ysZn/PQt
         mJTd3wZZq36e6jIpgaFvry2PRobh0SJYfo9dGCcKSgZzeU50MBjrXmRLZUEdGx+fha0S
         wQ5Ki+mtthaiNosGL8enblT+aI+lMuYIp8nkhaloxrwso3S1F8vV7lM6VSiRHSqJh47Z
         q+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721856; x=1702326656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Flj9PSEm5qn3n/BXHUntswUiOpnhFSXTydYmHyBlDSQ=;
        b=dT78IQM/HrqAVJ5Gah0MJBo5BlhEJMV4JhAhGBUwSEEgfiKsHrdoklGwhm7ptU04DX
         9nvyA9q15cYWNMCrpeq+cIoZR5eq9Lsdiy8mkvkVfrOaa/ZjVQ79f4X33xG31czJlAxH
         +Al/dyZ7gs72GlU4buu5gSRVCb02jAgwhnOl4GiGhIEURJczQPUx+l2JC9G0F/g2uP+J
         SDoCU2IvxhKxTiTsfntx7tx6BDqN2NRV/DZ0apED9oNUzL9vsOUm7P6ceqF4YzBB6/IT
         t1hQd1I3Qp1AA0EI1+YZBiD4anaN0GEmhyyJoa7mMBZGhZXQMV49QNHVG2bm4y6JQZOF
         0JKg==
X-Gm-Message-State: AOJu0YyMMOs07AusR2NKwZ6R+hvNnq0wEbHZb+qknCAIF4rdPdHTdBeq
	/YvCiaFY2axeFRtC+cYchsUki/MjCLR8EKhMowd9uQ==
X-Google-Smtp-Source: AGHT+IGOT0XseURcH0F9OLPkKsCgAWmqH+doJ0wH224+2yJl7wP9N5iEp3eBmMO2QFGBkEyU8pbCQoUi29LlxNW65bw=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr299098edi.3.1701721855932; Mon, 04 Dec
 2023 12:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201232.520025-1-lixiaoyan@google.com> <20231204201232.520025-2-lixiaoyan@google.com>
In-Reply-To: <20231204201232.520025-2-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 21:30:41 +0100
Message-ID: <CANn89iKmEVas7gKo573v2BtmpAK-QdnVm6p6sVC-AS0Z_=ssWQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] net-device: reorganize net_device fast
 path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:12=E2=80=AFPM Coco Li <lixiaoyan@google.com> wrote=
:
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
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

