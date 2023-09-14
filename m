Return-Path: <netdev+bounces-33848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA427A0772
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3644FB20B57
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA25273F4;
	Thu, 14 Sep 2023 14:31:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7118273E8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:31:49 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BB71A2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:31:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27197b0b733so215802a91.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694701909; x=1695306709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWJ3g+x+ZjRO4Z8Z/nCNHe21x/QVa3bH1+n3wwpisIQ=;
        b=lBmmND0YzgJP2spiJo2qHq+QeId2Bl1EELLZX6wPstYysGu6yKJNph8AZ7Q8CA32F7
         olvRTzmmz4Q0KeJGqVO+kDmVRX1ZgLdG2Cd5yu4AXqhjK8sJvz0IUKEDuELgQwqC74Lk
         WvYJNul+i3chEr0TgTo1r95d9u01np1BZ6JNr0qeW9Fi7Ckx1ssaH2qHU/9e/v5IbdfC
         60LuklXZA1LBW6DddkuZ6GmolyXxPUTzhCL+eFFT+zxN0eECLSpUuk3x6mnLDO+TP9e7
         oNS5zO4+Y51/BZGlg3dAHsw/Aa9u4pTZgzBC4XyHnWIG+jmLkeQNFDqefeVmGDctgzUg
         4hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701909; x=1695306709;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWJ3g+x+ZjRO4Z8Z/nCNHe21x/QVa3bH1+n3wwpisIQ=;
        b=LtxuUFPXPBTmK3xDT7GrDThCYMuHuegqGY3AedSUVvVms4CWC7bcQs7g9aSEkWebSo
         4dwm50Lda94pYCPYUacNnTyZ1HzZuSEq1SaxWrPVZD0LN4Cic8tnbh9bP5oDLkExykL1
         ubzB+Si6e8BDG9Xr1KLryUUxhPFwl/QRoIZQtCwNoUoCPfrpvKDM9RBk1KO1ohiedJqm
         zbww3qBOSD+gp2bEGKcy5I/zZLTPv0UTo4NhkRQxbshG8xbDLfBqG4ygra9C4o0rMKu7
         ADX8YIDZnaRpocaY3Fx2fdA9c+z9bVjzm/lAcoVDiar9BjosDKeR65JiL7ZB+P5ror7Q
         P2ig==
X-Gm-Message-State: AOJu0YxMwgXMG1N2+HSYNxqIrfMYXy8Jmp0nGY0dWbdjxZ6SfRC+ZfIZ
	DvIxLRijtYGW+85QfCrESnMZZKPhOe31Utac8Wk=
X-Google-Smtp-Source: AGHT+IFuyZuVbCEOQKloD0U1ul3PAQM01Z4GgMrc17fdhLNfQTiuaNhVbIlz8F/G3yqLGdZA+3yosIYCAHrPP5atyiY=
X-Received: by 2002:a17:90a:4e84:b0:263:2312:60c2 with SMTP id
 o4-20020a17090a4e8400b00263231260c2mr5027497pjh.3.1694701908702; Thu, 14 Sep
 2023 07:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Sep 2023 11:31:37 -0300
Message-ID: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
Subject: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com
Cc: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On an imx8mn-based board with an 88E6320 switch, the following error
started showing up after the commit below on the 6.1 LTS branch:

mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done

commit df83af3b996d79d7eb51eaefdffb7f4352e55052
Author: Alfred Lee <l00g33k@gmail.com>
Date:   Mon Aug 14 17:13:23 2023 -0700

    net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

    [ Upstream commit 23d775f12dcd23d052a4927195f15e970e27ab26 ]

    If the switch is reset during active EEPROM transactions, as in
    just after an SoC reset after power up, the I2C bus transaction
    may be cut short leaving the EEPROM internal I2C state machine
    in the wrong state.  When the switch is reset again, the bad
    state machine state may result in data being read from the wrong
    memory location causing the switch to enter unexpected mode
    rendering it inoperational.

    Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done
after HW reset")
    Signed-off-by: Alfred Lee <l00g33k@gmail.com>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Link: https://lore.kernel.org/r/20230815001323.24739-1-l00g33k@gmail.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

What is the proper way to avoid this error?

Thanks

