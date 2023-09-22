Return-Path: <netdev+bounces-35754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DF7AAF0E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 61F9E1F2281C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E41EA7B;
	Fri, 22 Sep 2023 10:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C21E521
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:03:05 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D891
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:03:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50437f39c9dso928283e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695376982; x=1695981782; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eVP3S9HqIBmNLbS2aitYe40797ATaQajL73YIypW3qk=;
        b=I5ag15EfSl8tI/AHTK9xuQEwV+5VgGOjJ9k5GQ9E6U1MVyuL3CM+9ooM5cizp5P3T8
         co9PoVAv5VvJ4IGao/ETyL0nah3el6Eo6zSV72A4mHmApOqfZnxY4OF9pdHcfROzCFbF
         nQWpN4qttLyTkNGp6RqVGuqGLYYh+TLAPx4pMtNp0OyzBxHZToF7S/9UdXiCBKpmQSF3
         wPYxHPEia0K2TneE9dQcW1xws2XtUrQNH1QCQ6IxBH6IF0sv55zYLv+Xpwllz9gYNsqf
         4kGhFKFAXYvGaauK8DO0bF9KMaSWA7Utf40M6DbuE0QgOlP5AhRn4BuO2/nBkRksil7b
         N+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695376982; x=1695981782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVP3S9HqIBmNLbS2aitYe40797ATaQajL73YIypW3qk=;
        b=UUKcT+mdyK8ftYzXotMgTQzHXGCLuyx45F14rI4WLVaq52FEzlEG6TMnOOMEqthems
         8pjEu5OkuLuc8lvPCEYKhXdDrk1N/UphAltxNifjy6+5VN2BDFXGMWICIgmCF6/zMhZy
         hpy0t5KZOkIxKNaalrC1dAQxdY+SNNgFaKQDkBaoZ1DaaCPTn5TbjkAvcTo194lL1c/J
         WQDX/ofGFWqSKi2jEcMxSTvSJ/vFSUzMIoBktC0SLMoiDXE3fRfMmGDFgoYl2XfZFN/b
         OBP2mOW+GKpaRMk5H3OwPbb3KCSReFHGTcMclPPVuO7fHjcf3YXT4hSq5NmadEYJLDOp
         mw8w==
X-Gm-Message-State: AOJu0YyM2NI/O27WpkyvLIM8o/Ladxdt+uN/PGel3EjlmsVy/reB9aJr
	UPj3bd2olwKypl52ABdlTJSNGNN2HO3mbnM67pUC8ikDOIs=
X-Google-Smtp-Source: AGHT+IGIj8rgoJDQ8Z9WcKOSNXu3usgT9JavdAnv9vIvGAEFpF5QcUQV8OPUrbPNEMPWWffTFde8MCbtZIFQvjoJADI=
X-Received: by 2002:a05:6512:2356:b0:504:35a1:31ce with SMTP id
 p22-20020a056512235600b0050435a131cemr2364274lfu.30.1695376981688; Fri, 22
 Sep 2023 03:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Bj=C3=B8rnar_Ness?= <bjornar.ness@gmail.com>
Date: Fri, 22 Sep 2023 12:02:49 +0200
Message-ID: <CAJO99Tn411oPCLG0pSc6CKBiaBb0n_LAz=7uc+xF-jOPGfwcFg@mail.gmail.com>
Subject: SO_ATTACH_REUSEPORT_EBPF and TCP_DEFER_ACCEPT
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

I was hoping and trying to peek into TLS client hello packet from
reuseport ebpf when setting
TCP_DEFER_ACCEPT, but unfortunately this is not the case.

Is there any technical reason for needing to "route" the SYN packet to
a listening socket
(except for fastopen), or could this decision potentially be deferred
by introducing a EAGAIN
return from ebpf?

-- 
Bj(/)rnar

