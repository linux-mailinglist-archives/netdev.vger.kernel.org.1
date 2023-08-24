Return-Path: <netdev+bounces-30218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6C786797
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B94F1C20D90
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCD24522;
	Thu, 24 Aug 2023 06:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02165185D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:39:59 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5D10F7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:39:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ca7b4782cso441967785a.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692859198; x=1693463998;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3tKHdxQGAr7SJNWGKYj1W07BfyX4ME496ixp9h0xfwM=;
        b=YegdOe2z3TVSLyNlwwL7NViH0P9vf7+cafY8ViiKNj+Xa7FRDKc3+Gj7hTK9B4goPH
         ZCUJW5z6XuSdQJDg1kW0Jq0O2Qe55I2zJrOFsYm8LGfcEibXE9XPPGmjX80MQjXYWnWM
         6ArDV+3LsDZydwiniM020iEtSItatqptil07xKuRPgoMvc/DrxkNma3WdvUxxZsWBUeD
         ljJ/XLtTr8vcpAgrcS5jpM/bIB46X7HcZFp1tYf9dwg1dENhygQZJ23peXqxDTQn0e5a
         zGgwxsulfCvFRFcwY6lWEFro4CF68Ik3Icf4S7nG9s8hWHsyJSfF+ANa2S0J2zXH/612
         nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859198; x=1693463998;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tKHdxQGAr7SJNWGKYj1W07BfyX4ME496ixp9h0xfwM=;
        b=AyMLkikCQE57VmcJ2H+7lbPT3o3h0vRBoNZ0tzWwK+ZYIv2lLl16g5D8cAArAtVFiT
         +MJjHCAcGuCjZySNqVBN0kkd75nXt5bPqhjFW7YWilIsTHHD+I7oPNkAzhEp31bv0+7E
         T2r/ucaHVHLpsyF5skISQZg1tQbL8Xc6Yctojw/0fge8AcX9tBidsOUTGAc3Qf5ptKq/
         XLc//EIW7iepjNgscwFFYY31ft4LCWM5Gj2bm4G77azZpif0s0wejjNAdykuVyloCLed
         T75m+ogBsy/NZI9TkuevzzBG7WitP8WKrJbbUivGOUSSjirE/mO7M0MhoHBNNeVT7U/B
         OjjQ==
X-Gm-Message-State: AOJu0YxkRXaUEtpj4J3J9ZaCn4AOWdK7a2DklS7VGVK7UJGTHX2+oUtH
	W4H7xWj/So8XqPXVNnb7IKUOiiFioOH2SH82TjozFZ6BXw==
X-Google-Smtp-Source: AGHT+IEdYqS+0v+/wCGC2xPfeVr3T2iTAhkpk3ixNsp+3kAjOF5cz7J7YKq/UCNNSt98kh3YlR1FDgEg5I0/hbmpi+c=
X-Received: by 2002:a05:6214:4599:b0:649:7b67:14d3 with SMTP id
 op25-20020a056214459900b006497b6714d3mr16367842qvb.32.1692859197799; Wed, 23
 Aug 2023 23:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 24 Aug 2023 14:39:45 +0800
Message-ID: <CAMaK5_g-aZjHSzTd73LsqLRWOXhTpjUGsPsxax5YjCEYHAeO7A@mail.gmail.com>
Subject: [Question]about the commit tcp: randomize timestamps on syncookies
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
when i read the code about the commit
84b114b98452c431299d99c135f751659e517acb tcp: randomize timestamps on
syncookie, i cannot understand the code
in cookie_v4_check=EF=BC=9A

tsoff =3D secure_tcp_ts_off(...)
tcp_opt.rcv_tsecr -=3D tsoff


in my view, this tsoff is different with that which we used when we send SY=
NACK,

why rcv_tsecr can directly be subtracted by tsoff? any thought behind it?

any feedback is welcome, thanks.

Regards

Xin.

