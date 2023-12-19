Return-Path: <netdev+bounces-59083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B9781949C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28629B21DF1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50926281;
	Tue, 19 Dec 2023 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joby.aero header.i=@joby.aero header.b="Qa3fnCk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91B3EA7E
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=joby.aero
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jobyaviation.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2370535060so35637066b.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joby.aero; s=aero; t=1703028608; x=1703633408; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I3qMmKfq61ryt80/4ZFSfgmWpcFz14X+vNAF65ciOIs=;
        b=Qa3fnCk0TCMkDJNjSIhtXEDugWtWdgV464zBlNNEIFYhM5YSpi2rJE3Jw4tb/1SNof
         LxAUoJolM5xpd5XZCoCTB9gZm/2/zUBW79KJ7HNzPK65dMmqJcq5nbbCVS9Lopd9HquT
         w+gwODj/0fp6tBy/f//ULOmeZmoTj1NU9TFk0aWhdwhhrldq2IpMdJpLP1im6l4Q0BLk
         jPStoUvGet7prEGQx8Fd7hgKBhoInr2cNi8RsjswEFK8zsFlbtkrBF62IQOG2LLQq3Qa
         yxqKgxDTKscxbX2/sDRk7N8C4WqZ48InHtchJpFnAa2QQ26c2LpGTYRTAQG8/ur59Zsm
         PwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703028608; x=1703633408;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3qMmKfq61ryt80/4ZFSfgmWpcFz14X+vNAF65ciOIs=;
        b=Cks4lgpfADPOiEyX9w1r08NH03PYlmVHj4z6GarCDLudf91dbgM/fMM3CQsOKaRAnX
         uRkD2GPM2akweWdVRGPalwFj8J8joEQ7iccUXvjJq7L5jeIE0uLzAL9T74BEzNxszbbj
         5SYTVxNKwRRQtrFnRCUiJ48NOdKMhnhj67NIjRAlW0oG92cxAqzy8SCeKfJKoelj7GgR
         hX88PJazY+knqopuju95wzYmLiznmeiEUaIJo1P9dj9f9cRIQ987XKroaRkmtm28mYuh
         Uk8ZmeC/Nwte7ihx5j5wXn9rD4bf/zZ3TGowEuIpaODaFx8fOelDsSpQlPSyfIv5B5ZX
         6IWw==
X-Gm-Message-State: AOJu0YxFqqoXp0Ts62qnXD8QbNmE4q1BW4t8JoFGYK5wXtOr97Igv9gU
	0pLUWDs9XnI4qNUc9fsrKwUQj3uDyuTtdJuzs0orHa73Rk0PaIjRQlBqvxsVSzpVBmSR2Tj8Wjv
	QDMbL7zqG1FXNNsFRK6yCYLfHfdaQeAqkdI5jQA==
X-Google-Smtp-Source: AGHT+IEWQP5Ph9v8Oho3y8/vgQ5kKO6/sDZz00l25UQhi6qStXstYKLPr49yFcmT/8AY1nCaoP92IFKO8uVxLnjV2hA=
X-Received: by 2002:a17:906:4b:b0:a23:617d:1bbc with SMTP id
 11-20020a170906004b00b00a23617d1bbcmr2151300ejg.15.1703028608181; Tue, 19 Dec
 2023 15:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Bellizzi <matthew.bellizzi@joby.aero>
Date: Tue, 19 Dec 2023 15:29:56 -0800
Message-ID: <CAJkJqoSBJAdFTOGuXyW+bwdbW5o2spw5UYd3TzC3Oqy5kYjCSg@mail.gmail.com>
Subject: 
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

unsubscribe netdev

--=20
This email and any relevant attachments may include confidential and/or=20
proprietary information.=C2=A0 Any distribution or use by anyone other than=
 the=20
intended recipient(s) or other than for the intended purpose(s) is=20
prohibited and may be unlawful.=C2=A0 If you are not the intended recipient=
 of=20
this message, please notify the sender by replying to this message and then=
=20
delete it from your system.

