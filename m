Return-Path: <netdev+bounces-33490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3540A79E2C7
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7101C20CDE
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E31DA5E;
	Wed, 13 Sep 2023 08:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A23D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:57:41 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30926E73
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:57:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c7912416bso6969610f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694595459; x=1695200259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3CaJ6AGFMnvXTdUa+Xhn5fiWkcwOHL94b0eWDaYA/A=;
        b=T6Hbck0uv6UzoGLCNpsE/fgIhV8SX4rIIJx4c/Na++A30OxBKVdSLD9W/mUEuZZsZu
         bgM5QCMrCNixAmC5MEcLzkc2qvIOPQ5KGP4PrPKdEamoRqnSXUmo0YWjljHDva0KxZCY
         DqM1bdWtHROGjRyhLmKS3iCvQL7zHymWaRLtDj4vR6PBHNGQ4sBUQm6bJwuvvf2FTMrA
         kAK+XeuR8erw7WDpiWtjXXShm8/eVHXoUeyJuyfH90Rog9udPsqxAo6UVscCMffi7B+J
         J1tLIInYxkCO6lQR5a0bFh17dgRgQkbS1tICTG1fCod7a6xdqgzmLQZ5JHBIVpJM9zZX
         Ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595459; x=1695200259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3CaJ6AGFMnvXTdUa+Xhn5fiWkcwOHL94b0eWDaYA/A=;
        b=AyqfpWJvM0g64IUYqWPeY21FCUz0QN6egOct1DastoDdmxuoNxdZRaHQWL1pjtdSNk
         Kh8DKJ1gcR5xMBO8CzgGlIEfK8m6j/mfkWA92yq2Yc4asH1T/allgJNTK76CtOHDS79X
         78KzguUY/Ti9QgZScTb/kix3Cuew3F/LkOKaTH3I4B+WM+MhuRGXyEmcE2nazepjlyhH
         x/fOXW/wOcM61zJZpz0scrDNWPk5HBDHceK+aAMvnNNmLpIV95anTaBNG9IBjE2wsXHw
         fO9wGr9C3qLnU1e5DWtHhPxhSP50P4qVRDYzjQ0iaPy5ZAaPgzw6dGtpwhhSEGB1ZPF9
         d5/A==
X-Gm-Message-State: AOJu0YzQoiwjl1BQqeGas1WQWSkoWwAhWvmme9qIa6Ww54k+jY9sgkOX
	WS9wy0GEx9BGWcT8bGwYSbI=
X-Google-Smtp-Source: AGHT+IHWP86inToGfPb/mMiFGzbdYz48z0lVwFT/mW3wpGz5iTykzq1wg0Uh5etENpsqvm6ilXflFQ==
X-Received: by 2002:adf:f981:0:b0:317:5182:7b55 with SMTP id f1-20020adff981000000b0031751827b55mr1489978wrr.42.1694595459285;
        Wed, 13 Sep 2023 01:57:39 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0031c3ee933b5sm14797527wrq.108.2023.09.13.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:57:39 -0700 (PDT)
Sender: "Xabier M." <reibax@gmail.com>
From: Xabier Marquiegui <xabier.marquiegui@gmail.com>
X-Google-Original-From: Xabier Marquiegui <xmarquiegui@ainguraiiot.com>
To: vinicius.gomes@intel.com
Cc: alex.maftei@amd.com,
	chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com,
	richardcochran@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v2 2/3] ptp: support multiple timestamp event readers
Date: Wed, 13 Sep 2023 10:57:37 +0200
Message-Id: <20230913085737.2214180-1-xmarquiegui@ainguraiiot.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <871qf3oru4.fsf@intel.com>
References: <871qf3oru4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Using the pid of the task will break when using some form of file
> descriptor passing. e.g. Task A opened the chardev, called the ioctl()
> with some mask and then passed the fd to Task B, that's actually going
> to use the fd.
> 
> Is this something that we want to support? Am I missing something?

Thank you very much for your valuable comments Vinicius,

Let me try to confirm if I understand what you are observing here.

Let's say we have a process with two threads. One of them opens the device
file to do IOCTL operations, and the other one opens the device file to
read timestamp events. Since both have the same PID, all the operations
(read,release...) would fail because I designed them under the assumption
that only one open operation would happen per PID.

This is indeed not as safe as it should be and I should try to improve it.

I am already looking at alternatives, but maybe someone can give me a hint.
Do you have any suggestions on what I could do to have file operations 
(read, release...) determine which open instance they belong to?

Cheers.

