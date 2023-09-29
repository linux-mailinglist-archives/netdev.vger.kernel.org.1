Return-Path: <netdev+bounces-36984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EB7B2CE3
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 04E551C2099F
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CBC13D;
	Fri, 29 Sep 2023 07:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB3C134
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:12:04 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9141B3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:12:03 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4526b9078b2so5732282137.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971522; x=1696576322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmZRKIigA0ykCxEY+0N4Kzqi58uY5WB+JX2QZumaAss=;
        b=N2j3Gh7Ty2BGeKtfvJ7txtjEUeQyQFGT9stn4jg9FeHuXXVMTUbLB7awbwMXhK6ywh
         zxOaZrrk/gmOMPD7HpLJiPRE5pZHu9lwsdAV8iZkZDsj6JDwcXBCQV38DPrbZiszzS2+
         ihtXTPWKCy42p+H3ZWEjr7GvGweiXARKPhbvOq7A1bwOwcxjuPSTF2PmauwMsnvK7lrK
         D7YYgVYdieYIA1j+HUcMJGb1noI4GPhal0/GT5ZlkX5PluFF77akR3R/4M2GfJhWoRKA
         0S4B6USRZw0q0dVpz36Dy6bQsvtAscDtSU5w+uM15YThg8EABOVvrZiRUNfUPHuO5wtP
         h4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971522; x=1696576322;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmZRKIigA0ykCxEY+0N4Kzqi58uY5WB+JX2QZumaAss=;
        b=RtyPTe4mUiLyJg6r+ieDV1SDdcESTAUuQ9jmKI3YfaaMFMraBjPq3LvSR/Bnx0KRHO
         +xXVL6p+PUVF3nAt/aaStRktrj7kg5S1s712krn3F+g/JDKJNj6Z+a5T2RjjCQolqaC5
         b/KH4iu92PevMEhrfuXM3kQn1xgomgr+8rNvERRIomask6sLgA2k5e9NnuUm9JLFqFRd
         dqHcRofV9k81bTJNwjYVb/silln0Nl0Nqv+isHt03pa9KCH96c8UaqNp3uATONGASNFN
         5f4gluVj+b41f7MJ1JXkz4xgLbgicZdXzVpqUi3hfxva2LT50W42ykJkm4uy+s65ncrw
         Li4g==
X-Gm-Message-State: AOJu0YyW7S094AbYL9qtkn25fkPU9bfGFFgIA99aL4hDk5hc+4gOlags
	FWdOoBCZr+r3HnpSfPzzJiTn4sSrFxYgVOytB0iLgw==
X-Google-Smtp-Source: AGHT+IG10QdAXHqWImprqOK2ab4qL9hNrpt7NoJ9tjYopqvquES3U0KG9GK4LYgWv/fxOAXFbhWSv2DwMh5uRl9UW2U=
X-Received: by 2002:a05:6102:d4:b0:452:94b8:2fe9 with SMTP id
 u20-20020a05610200d400b0045294b82fe9mr2543051vsp.21.1695971522079; Fri, 29
 Sep 2023 00:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 29 Sep 2023 12:41:51 +0530
Message-ID: <CA+G9fYu2DKDxOEFTeJhH-r_JD8gR1gS8e4YsSrW3rfGegHR4Sg@mail.gmail.com>
Subject: arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined
 reference to `crypto_has_aead'
To: Linux-Next Mailing List <linux-next@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	linux-snps-arc@lists.infradead.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The arc defconfig builds failed on Linux next from Sept 22.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----------
arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined reference
to `crypto_has_aead'
arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined reference
to `crypto_has_aead'
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[3]: Target '__default' not remade because of errors.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230928/testrun/20145384/suite/build/test/gcc-9-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230928/testrun/20145384/suite/build/test/gcc-9-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230928/testrun/20145384/suite/build/test/gcc-9-defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

