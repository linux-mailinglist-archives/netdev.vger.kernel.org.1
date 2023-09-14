Return-Path: <netdev+bounces-33925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388517A0AB0
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86F11C21034
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA182136D;
	Thu, 14 Sep 2023 16:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E42375D
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 16:22:39 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605361FE8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:22:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso225431a91.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694708559; x=1695313359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGWtc97i7WmqCMaOkrF32X6WRXsUDKRldvP4WaLwc+A=;
        b=oIXZsmh8Km0lHIoUb8P9JicMnPJOe37MKpwte89U8wszfpyzBGkehyoAgLeb8nbm3z
         IYHkjzoCxcBgfD+vXWLtwq9tiXwhcZmYHLuMu6CLrTJbAOvPgTcjkI7p/mfdt4iapJ8A
         G0Fl4cu3Sljy9LFaD0dmzl7Er09XhklNmu0i/i/aFAj/mMAM0LS9pmfz9eESxd9l1qPK
         PsegZawPr1duyzUNzoaZsKrfStk4VRWcQulFXCkD+DSPHkt9uXuq1UWmnadhVtX62ae5
         nFgYNFtGnuppZMK+gMjz17eMqLuyqw3f3uSJo7Q8zw3J+xoSTXHU0HwlG4a5Q6etH/WY
         FRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708559; x=1695313359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGWtc97i7WmqCMaOkrF32X6WRXsUDKRldvP4WaLwc+A=;
        b=coA0sOzGGFiIA5lmsG3Un3f21qMGVhj9bRDUllh1TfRTDzbnM8geq/4CMcFkRhiGfc
         4F9VBnPaP0yMSEibG+Ft5CQQiUjKad2EDuxyIbBm3yTHhGlx0V0JEhANJ/ELtsesmuHO
         0oap6WTuqjWl7+1nm4MivpYPHBANqk1WYfDgJqVy6Nj722rMx1zqc54vyHDdT399/LN6
         2i5Xo7QgYl5tzt2pGWMWTsHT1u1NKKirkCyPPjuFDp/5y5vrjpQquIMynabbmishaNG5
         xBAxI0WON9iesphe5KZU0UdGWt849Edu/E2ooZaMaBuz8pFcOWJ2VcRJzsnHutr7mi+7
         yl8Q==
X-Gm-Message-State: AOJu0Yy3pKQbGf8Xizher9/pcjLLzx4Fv7DodixN1h+bplB5pdoGd5No
	uQwtgcfDUvToawjeydo3eYabxTCqNp2SXf/A5aM=
X-Google-Smtp-Source: AGHT+IGJ+uv11jeJEOdcN7Xo1ZyJrhmLpmKSpTysTKSP0ivqNs5eNZXrvrFkK+yLwwobK4cVoom4vvhA/X8njADWhPc=
X-Received: by 2002:a17:90a:296:b0:26d:412d:9ce8 with SMTP id
 w22-20020a17090a029600b0026d412d9ce8mr5299832pja.0.1694708558673; Thu, 14 Sep
 2023 09:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
In-Reply-To: <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Sep 2023 13:22:27 -0300
Message-ID: <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Sep 14, 2023 at 12:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:

> Does this board actually have an EEPROM attached to the switch?

No, there is no EEPROM attached to the switch on this board.

> In mv88e6xxx_g1_wait_eeprom_done() what value is being returned for
> the read of MV88E6XXX_G1_STS?

[    1.594043] *************** G1_STS is 0xc800
[    1.600348] *************** G1_STS is 0xc800
[    1.606648] *************** G1_STS is 0xc800
[    1.612950] *************** G1_STS is 0xc800
[    1.619250] *************** G1_STS is 0xc800
[    1.625547] mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM=
 done
[    1.673477] *************** G1_STS is 0xc801

