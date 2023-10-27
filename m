Return-Path: <netdev+bounces-44834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A005C7DA125
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA70E1C2032A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C263D38B;
	Fri, 27 Oct 2023 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1JnwIaM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDC18C2E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 19:09:47 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B672BE1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:09:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59b5484fbe6so18375787b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433785; x=1699038585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnrT4pnhtsjQaBlW7HCmbHqYuxjYkHapoY0fCqmh3GQ=;
        b=U1JnwIaM25pXL1MVVrgeya5kp4+cJC0Q/1nhxXgFzmQ0mmRE3XvRAhU/d186/yWXx7
         tsbiJw7RpqYpzl5pOoi4uiObp2Elyr1fJd0XqlR8f3AB93gQiJM8lIMZVxF0l1xMaAjl
         ottmY9spBYS0dzI5e31IZqLQx+tR6dh/FhEWoxPcAHLtlhyTcmCFblW7Hg7rqwHwYeOx
         nfWcmbmbiYFhLemWLWd4N1W88sDtI9ZTh+9IQ5sdgUl3zo50yyVUHa42E984+WXmEbHt
         DhcObNv5nuDfU9ruK0/EPjaX0kTlEMwfkakk2K/u6GQdvn6nYJxrCZo1MjeYnMfuE8xu
         HLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433785; x=1699038585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnrT4pnhtsjQaBlW7HCmbHqYuxjYkHapoY0fCqmh3GQ=;
        b=ps5FhE7s4onN14L7MNM6H7VmaTJXyYlkdWsMA8oV9lDikxxyCXGjAS4FH0/jjEHpNE
         2m8jdiqmjb2hGljkMv1tXQheZxCFTRx6MgfD33JsfXMsGSP9TiNVgqpheQjYyuePA3r6
         ukJX6fcr3OmY5QZfDp1j7DqMbzLwFA+XoIE2EjsKcKB8ArkJmcQl4Cm2/WRW/uOXBNYK
         1xTgwPZwj2YMhY7oRu8hfnrHbUFvchKx7q0Y9LNxqWgoIKztHYYZ+iyzZ/kqo8ciS53Q
         5Htg7c/WOVBQSRSstJtECrZs4WjPu/LNLQs+9mT0SPj1GuBAE0izUSHZpMMmMmv1pD2i
         o1KQ==
X-Gm-Message-State: AOJu0YztAAP/20oVLJjWIwYFtvQE2jML/xO9GMBAlj4Hl+t0Yz4BwPRf
	NBVCUNdFW1xc4Toqp+wj6SCd+mgK0KGetg==
X-Google-Smtp-Source: AGHT+IG5cB15BUUvNfP+1I3QG5n5V/w630fQ0IHl7viEUed+EkhNbZlBmIpo8T2ctzSr/cKDL6PoRA==
X-Received: by 2002:a81:ae5f:0:b0:5a8:2037:36d9 with SMTP id g31-20020a81ae5f000000b005a8203736d9mr3282742ywk.25.1698433785486;
        Fri, 27 Oct 2023 12:09:45 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id g190-20020a8152c7000000b0059c8387f673sm958696ywb.51.2023.10.27.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:09:44 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: [PATCH net-next v2 0/3] net: dsa: realtek: support reset controller
Date: Fri, 27 Oct 2023 16:00:54 -0300
Message-ID: <20231027190910.27044-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
- Introduce a dedicated commit for removing the reset-gpios requirement.
- Place bindings patches before code changes.
- Remove the 'reset-names' property.
- Move the example from the commit message to realtek.yaml.
- Split the reset function into _assert/_deassert variants.
- Modify reset functions to return a warning instead of a value.
- Utilize devm_reset_control_get_optional to prevent failure when
  reset_control is missing.
- Use 'true' and 'false' for boolean values.
- Remove the CONFIG_RESET_CONTROLLER check as stub methods are sufficient
  when undefined.



