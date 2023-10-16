Return-Path: <netdev+bounces-41346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3227CAAA5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AF1281452
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9E286A3;
	Mon, 16 Oct 2023 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="M25S8ekK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03427721
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:59:25 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B5182
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:59:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7b3d33663so61541517b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697464760; x=1698069560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wMYooUkM1nunigDk2LPCLu9Cd71nmXj5oLnseLVsCeE=;
        b=M25S8ekKZN1zkCWl21jOhJMZ3yVzn+vGx9SuKLmCmENETbSVi9Lh291KIL70j4vgdl
         O7J61ekscOPKWikwu9MVHBCheYXpFK2zH9TKDtN4pjAkNLWJEjHsm0Fq5mlrbpztjPG1
         GcVGGhlfsAFmlEzXE8/cAZ/QBiIZtPBKF30w6w5AUVtou8vGJGPSLU7H/odhmp/8LAQ4
         WpMZ6fs22m3+kb8tSGgAruwnyPq0KRHCrd3physBJstTep1MlOqv3wJrjmFtBBl6hQCG
         smh5jeAlVaKRCujx23u6zVTBinuYrAv/cqx3jzKpW/Nyb8uYe9yG8kGHpVqEvVX5Wtz5
         xpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464760; x=1698069560;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMYooUkM1nunigDk2LPCLu9Cd71nmXj5oLnseLVsCeE=;
        b=A9pJqaOD2AhGqdX+KJjrHY3w1y5MOcZZ0EelmvoBrie/yKcbp88GHoXuu+np81RNGR
         kd+0e43bbkO+ZFGsiGO9SMPknNhxJQs6gU+KY1+6qGDkRimVgf5ePjwgOmNRKoY3iRiY
         FyIlvB4LCbKoj3iGat6lYUYjDA9shCc7HzdXP9svXHdWGemBfvf6SM9RH7Iegs85ug/2
         QxEVNg3LBadYMhnRLGuSohn1c5wQtWO0W6k+4U//Jmhtzn5GByrtf+e/59qqzl7J2UjB
         Ln2NiHN6OAcb5EveWpNjL1Hxfxochc3lKbXoA0LI42w1zm9sWHuNSDON35EiP1v++AWe
         z8+w==
X-Gm-Message-State: AOJu0YxM2JmlsUOi0WeexQ4+iAVR+qJ2HKb9vM0HG7iXmBzSGC3MG5Ss
	QIiXvY87JflOkC28c8lFAL/rVt9RumZeCx0tQPYm2Q==
X-Google-Smtp-Source: AGHT+IETRiV2/PhjUZyx0BRtzi0Hsmm6fxw54pLJiUINO18R8nKmJ9dy1P8nuaiL6mgLYz744QPxYMSIpJHE9XQPCro=
X-Received: by 2002:a0d:c8c3:0:b0:59b:f8da:ffdb with SMTP id
 k186-20020a0dc8c3000000b0059bf8daffdbmr37459485ywd.29.1697464760466; Mon, 16
 Oct 2023 06:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 09:59:09 -0400
Message-ID: <CAM0EoMmBbnNfTMAa4jap71Sja51CMvRxJVUUvRTykPs4wKwQSw@mail.gmail.com>
Subject: 0x17: Schedule is now up
To: people <people@netdevconf.info>
Cc: Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	program-committee@netdevconf.info, 
	Ricardo Coelho <ricardocoelho@expertisesolutions.com.br>, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, lwn@lwn.net, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	lartc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Apologies for the delay in posting the schedule. Here it is:
https://netdevconf.info/0x17/pages/schedule.html

Amazing sessions as always.

cheers,
jamal

