Return-Path: <netdev+bounces-53827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED96804C0B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED107280E25
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3803BB41;
	Tue,  5 Dec 2023 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLO1H5KC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF4FA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:15:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so9640a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701764128; x=1702368928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynnvl8LsLrxfDj7bKNLo1dnw8JKtWg9wpT6p42z0kYs=;
        b=dLO1H5KCFsRnyqmUf1j2z+VNey1dplSwjNtwgWDjk/B2iUBcZkSPtYky3hWQqtuPQh
         kArrEMxy2Pk2H9ND0JKwJ96+m9fXdzR+56MRtE9VYYoQ9/3ynztv6hgBmYhocYUNST/0
         b/lQH5EH7ShCW6npWrwq6phq3kKEd8KWx9/fWWU9TUgbn86jbK+62ssxU1znsheSs8+C
         fs3pD8Jh5M3Zs7tXugb35luASIsaECvbOEQZinnXc45aSfSe+E7nV38MGMZADN5kHLSJ
         pfJ50XVbIakR1elddXxfas2FlEUhamBZVVhiFSIUos8vgY/RGJgW8YDs0/fd4BE5c+I2
         2PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764128; x=1702368928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnvl8LsLrxfDj7bKNLo1dnw8JKtWg9wpT6p42z0kYs=;
        b=SAizD7ZzuekX2IqoDryhOytzoKZzuEcgEbT+ZuJuRJVkSyx/X8KZ5r2bk8qGUz9yew
         q+GUBTY4RlNkdxSOUc1Qv7+f2nLeuRH+fNTKaSLv7CFtHB3V3OXCgO2u1ZQoE3t3KhVC
         nudefmzRgaDk7BTmlJ3o2y+kybcX5fvI4B8yzDigUdbr36Ptkdv0BZCGDFwonxPO3in1
         zdwgE2WRsxCz0G/s9/oCT2OHg2byk14kvRTTS3MRjJ62QcCM2U0JnW3g/n0fIv+FyV31
         dkOSJnOEnrQWFhntxe0nOMd5nih2jUie1RmodYvNqYIuKrjZTepq4ijkRNSuCdUMJRT+
         4a3w==
X-Gm-Message-State: AOJu0Yx/KzMrgii4MaUS3U6sLSzQo5j/TEtND2egudCVoHkEoROuSvDg
	5GXKQRqJNLyn9LxTUOAbaEbPIRvjzsQACVrwORpKXQ==
X-Google-Smtp-Source: AGHT+IFNWdVhhSQl5FTZcEdFUQFcb28k663ttPMC6jRcM8Ukfae+es4lkf8WRyKmWGpUYViAefmyfT2whU+s1YSg3k8=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr419141edc.6.1701764127887; Tue, 05 Dec
 2023 00:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com> <CANn89iLuxfSZs+HV6-3=2FJL_KHg3=7WLZ109VXqsXO2-k+KvQ@mail.gmail.com>
In-Reply-To: <CANn89iLuxfSZs+HV6-3=2FJL_KHg3=7WLZ109VXqsXO2-k+KvQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Dec 2023 09:15:16 +0100
Message-ID: <CANn89iLugAraF-n-PE72k2g+OUo9T0RcdC+HbKAKRZW-cTbHsg@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Doug Anderson <dianders@chromium.org>
Cc: Judy Hsiao <judyhsiao@chromium.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 9:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>

> Please Judy send a V2 of the patch.
>
> I gave feedback, my intention was not to author the patch.
>
> This is standard procedure, I now realize this was Judy first
> contribution, sorry for not making this clear.

I meant : "first contribution" in a networking tree, let me clarify that.

>
> I will simply add a "Reviewed-by: ..." tag when I agree with the result.

