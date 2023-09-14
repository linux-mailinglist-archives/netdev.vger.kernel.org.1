Return-Path: <netdev+bounces-33774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452C7A011C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F11C20A7C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC02AB5F;
	Thu, 14 Sep 2023 10:02:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A90224CC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 10:02:23 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A9A1BE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 03:02:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so707748f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694685741; x=1695290541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M2Bf4JW/D8Gz2a+fop+RsYSxmEvEBq5PZUM0imPflA=;
        b=iLalMOoZxOwsMuhXw7duiqBYLZH41WDdeDWhJCKT6DQY8eLLSAbo2QjcvnHT3/eBaO
         MAAzGY8wM/KP3f7l1CTDC6q1w2E2K3afEKk2vXGXFTJ97rGngSbPUBPiz4Ofy4DlpZAi
         9MC7n8tC9jjpelstkck7SstclSANsTTWagugI9qpyJTbYTiI/p7IMmuhSUsQML+UIgXq
         JgMBgLx3qHz7cXqjAAZ6bjDW3mCE8WsdKaoHf43y8ssYUoQ+dbmFb2OEDCTR87idqohm
         gelMnfcOk6IDKhXWgO7/jLV70F/dSC2/4Jqu2TLsniu+4dTsPY2rSI5xtTXVm5QIiNwQ
         2CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685741; x=1695290541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3M2Bf4JW/D8Gz2a+fop+RsYSxmEvEBq5PZUM0imPflA=;
        b=EsO0CECCXnpVDagCwavRFcfsBid+5W9mYhwL9+CAlGVVjJvR1BdPVNUnppxPhFeATV
         jQI1WoygkvDXQPvbTLkNF5JXqhom82Y7Mw2OJCuBUF3ha97UOp6TgXBGJ0raBIGTpg8M
         nNTCUoDLJh4WhZPI+DYXjLaN/IM2GWCRZ86XbXFb/PySni39Z4wKSqALaCy4a0dKOZvt
         kOyXHXVG2OhM+pqpt8SwolCL1VWyzu/n1qEkwFM/RfqY5mW8qQg8dA6gHpj2kk8s82WB
         kBk+BBeOa8GTMNfckkr4VbHtiQxWZg2HcyTEUGco059uxdtWWbt1uj1I2ig2ptpAelf5
         yC2g==
X-Gm-Message-State: AOJu0YyZxO53UtXlAXyDpQP5yG1K/BvuXdqiNHTlb/ldP+aRO+J9nhOL
	oIOZsFdk+/b74ay8a00eK8s=
X-Google-Smtp-Source: AGHT+IFUkTwek9nWT6z8gGuOiuT7Wxok9DTS2bXa/YtNr9qGSn84MqnkfQswUl5bgshZRtFaI44l1w==
X-Received: by 2002:adf:ec42:0:b0:317:3d6c:5b27 with SMTP id w2-20020adfec42000000b003173d6c5b27mr4336682wrn.46.1694685740396;
        Thu, 14 Sep 2023 03:02:20 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id i11-20020a0560001acb00b0031fa870d4b3sm493253wry.60.2023.09.14.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 03:02:20 -0700 (PDT)
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
	shuah@kernel.org,
	xabier.marquiegui@gmail.com
Subject: [PATCH net-next v2 2/3] ptp: support multiple timestamp event readers
Date: Thu, 14 Sep 2023 12:02:18 +0200
Message-Id: <20230914100218.648085-1-xmarquiegui@ainguraiiot.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87wmwtojdv.fsf@intel.com>
References: <87wmwtojdv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Taking a quick look, it seems that you would have to change 'struct
> posix_clock_file_operations' to also pass around the 'struct file' of
> the file being used.
> 
> That way we can track each user/"open()". And if one program decides
> that it needs to have have multiple fds with different masks, and so
> different queues, it should just work.
> 
> What do you think?

Thank you for the suggestion Vinicius. That was my initial approach, but I
couldn't make it work. Maybe I'm missing something. I searched struct file
for some variable that would help identifying the open/read/release instance
a call belongs to, but couldn't find any.

After that, I tried printing the struct file *fp pointer on every open call.
Unless I did something wrong I would say that it points to the same address
every time for a specific device file. My understanding is that if it was
different for each time open gets called, it would help us identify the user
of the rest of file operation calls, but not if it's the same. It is true that
I did this verification on kernel 6.1.38 and not the latest, but I don't think
that specific aspect has changed.

I will keep looking for options, but any help would be appreciated.

Thanks.
--
Xabier.

