Return-Path: <netdev+bounces-32923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B808F79AB28
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608DE281300
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71415AEF;
	Mon, 11 Sep 2023 20:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE59AD23
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:17:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BF60185
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694463437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qur3wfzB9pIADg/HwTZreGB3O/dplLLwBbi4OuIftVo=;
	b=By372EhkqKpxGfwVDyRnrtxpDcK1Tb+ffJVkpkgWj/L2da0n7bcHmtgzrSOL0GLWMsuSNI
	EpUQkEeDMWvq+z47sGL8SUBg30oFARgtTfhejaDR7A6V1Axc1SL1BWodn85ZLm+bbE/sOR
	2ah8BK8aoV6VBduvqj3mzkONpuawD8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-vC3S7mk1PmG4o9qwNpRc4g-1; Mon, 11 Sep 2023 16:17:15 -0400
X-MC-Unique: vC3S7mk1PmG4o9qwNpRc4g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-525691cfd75so918986a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694463434; x=1695068234;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qur3wfzB9pIADg/HwTZreGB3O/dplLLwBbi4OuIftVo=;
        b=GVqCgOa4ucJJflBZxrqeT4Q6I2gUvusl23vPMLMdKa7Jbont8LpHB5R+fxwXhchLGT
         7LraX9iaWTqioTQ4XyIBhECaV/pDVUTk46aF9bmnKE7ORF2zfBddXbM6IKO7zfooucRN
         2Wu8qYLkjfXvrDOEydUDonOmLJidUp0squgQLPiiqW8Xq/DVzlpR0nHrsHwx2mbwu8Kn
         tns02pGmdV0FN9emSeZ5qWn3R2SZmLBJkByO7PGr6W8nnNF7Ndt2EPOTubdd/9yv/GoQ
         FOI3TNRJNBezrZseBvc151oMrEUZcTkfY2Y7yLVu27ottOg3lm6FSQOtk3jmMBuyDHxn
         /awA==
X-Gm-Message-State: AOJu0YyDtR7b3BA82t02BUZ90MIz6qs2CxgRWNrbbraXzMslx32bEt+b
	6N5pHJv9JhxXNUZ5Z3uj/HSp9sCgzA6r14ts3m3p3EqklMBn3aSObcbkhyB5SAIRI1mskxlC38K
	nnTFoA1i3cMESMKFEVN9vimRcpIJCYUBKzc30NuH/MaHTSAAEhMNxtLHpoNIStL8s4o+PxwpUZA
	==
X-Received: by 2002:a17:906:5b:b0:9a1:d915:6372 with SMTP id 27-20020a170906005b00b009a1d9156372mr8871755ejg.4.1694463434507;
        Mon, 11 Sep 2023 13:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7pEObJbYthmW3q0zt1T8ON+/uRkJ6tTjKpXhZbAn59IET82rUM8plIj53Lc01b1RLINQHXQ==
X-Received: by 2002:a17:906:5b:b0:9a1:d915:6372 with SMTP id 27-20020a170906005b00b009a1d9156372mr8871746ejg.4.1694463434179;
        Mon, 11 Sep 2023 13:17:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-126-104.dyn.eolo.it. [146.241.126.104])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906114a00b00992076f4a01sm5794950eja.190.2023.09.11.13.17.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:17:13 -0700 (PDT)
Message-ID: <71ddaadcbcca1dcf3cb38b3e29ba5b0b1027c281.camel@redhat.com>
Subject: [ANN] net-next is OPEN
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Date: Mon, 11 Sep 2023 22:17:12 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

net-next is open again, and accepting changes for v6.7.

Please note that the location of the "status" page is:
https://patchwork.hopto.org/net-next.html


