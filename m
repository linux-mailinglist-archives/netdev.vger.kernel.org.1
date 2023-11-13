Return-Path: <netdev+bounces-47443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C038C7EA4FE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02011B2098C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684823745;
	Mon, 13 Nov 2023 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l37p5G0j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF57208BB
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 20:42:04 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946C189
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:42:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a55302e0so6842427e87.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699908121; x=1700512921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2W9VJhbbn2i0gwYWJ8MpqhxCwzksXfa0Ckx8jDNGdQ=;
        b=l37p5G0j3sRuxtg+c4dHqbwGk4OCwQNin8rr9fDZees2Tkd+0Rr/Uhusqbv9PCfvUm
         bU3fVuOhXK8QoVdvAddQTJdXSuOR0Nr0U3gUfy9b3UB8n7EUc5VqWkKNKBcwXOGEJ+qM
         JmvxiAeKjBe5VDy6xTCOEJNpfmmvcWHF4tYTbjhKPfJVUFPu2wqATb+tp5ypMICavhat
         RIAjV6iJgKIyQvdVTs7VOLTs4ZUtpI5QMVCr3kBe4f1AKW+AuZLCDNY5No+hwHeAidGq
         jQVHdrszyB1cfVEYLA2+Q+WPfppQ5LUBUwhEnIOR89X78IKyykahDFuBbk1ps47xucVo
         KgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908121; x=1700512921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2W9VJhbbn2i0gwYWJ8MpqhxCwzksXfa0Ckx8jDNGdQ=;
        b=Ugw6qankoqXWl/cZzL0wahH9p4eeE+45OkT8UnRUg5/gWCL1f1bKWVjYApfaEy06MZ
         DoBJub2DH9/gQJNvAVEtG40zuzpVIn6aI2a33F7DQib87pcpdG6QHQmJyNFp0OyovWTd
         bARwv0/1EoSUXmdfhjhahH6lLl7PpP2B9nXfnn9uiNTZCkCz3XL3jyWc8T+zbC89MZ4C
         TEB9Um9rDtNtOSO6H1z3Xbo7yBjTJTj9++SKMbzOwU3no9WdMAdwSh6r9XHULVS/K5JQ
         PcaCIFXd2yb/oMN70MlN2TCJ46byAuybPfahVDSMFm0D37/Rop4vOnV6laRdun+I4OEB
         ZqXQ==
X-Gm-Message-State: AOJu0YzDUgUNLGc1FexMAbKZrcA8kJWvAPZcIBbdUavR3ynqjrqNL9NM
	V+ukFaUuzM9iK1dMYaIFNT5nlkFFnZNIT50GECU=
X-Google-Smtp-Source: AGHT+IHkhyDMTLyaeLCHJ9nD5TjXaQ4C1a2r8ufnrIo3FF64xw0MK+bGy5CJT17n7ZwBq+Nc7zOUfSJXInOsdYkSaJI=
X-Received: by 2002:ac2:538a:0:b0:500:b7dc:6c90 with SMTP id
 g10-20020ac2538a000000b00500b7dc6c90mr4532027lfh.36.1699908120655; Mon, 13
 Nov 2023 12:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-4-luizluca@gmail.com>
 <CACRpkdZShX2d8EJheuNEVpC=Tf3oP53Khs071XFccTskfY1b1A@mail.gmail.com>
In-Reply-To: <CACRpkdZShX2d8EJheuNEVpC=Tf3oP53Khs071XFccTskfY1b1A@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 13 Nov 2023 17:41:49 -0300
Message-ID: <CAJq09z6NOLkury=kEa9SjiGPX=X7Pc3kAi4L88LOb=_DoD4ZzQ@mail.gmail.com>
Subject: Re: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> > Some code can be shared between both interface modules (MDIO and SMI)
> > and amongst variants. For now, these interface functions are shared:
> >
> > - realtek_common_lock
> > - realtek_common_unlock
> > - realtek_common_probe
> > - realtek_common_remove
> >
> > The reset during probe was moved to the last moment before a variant
> > detects the switch. This way, we avoid a reset if anything else fails.
> >
> > The symbols from variants used in of_match_table are now in a single
> > match table in realtek-common, used by both interfaces.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>
> As Krzysztof explained the dev_err_probe() call already prints
> ret. With that fixed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Krzysztof and Linus. I'll be fixed.

Is it ok to keep the series as a whole or should I split it?

Regards,

Luiz

