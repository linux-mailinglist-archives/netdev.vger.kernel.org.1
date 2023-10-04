Return-Path: <netdev+bounces-38085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F247B8E81
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 29E97281705
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212C2374E;
	Wed,  4 Oct 2023 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B0k8qH3U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95775D50B
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:10:25 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C290
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:10:23 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc57401cb9so46209a34.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696453822; x=1697058622; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=B0k8qH3U4B/V5migOyuL4PtqxjNzr9Nd+hDul0JOIHT4MDKsS+vsqAYkITXLMybaO5
         rRCclpA5ndJt3uJCBp0smyY6NTAZ9qH1Inp+5fMPSU4fexPDVsKyRL+PIGwj2zJ3Rqfq
         7rW1vLgoK6klYpHHsONLuRytMMn3V0HyUFpvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453822; x=1697058622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=MfS7tiQXF9idua0wybbK0w3rqvkBo7EqlLTJ+raI1MlDpimRcma0/+MBJ41bYWi8Tm
         mNZ+LRG0GMBHrVBWDRW3LO0Zs6juZC+BlA5zbhG1hYhlD0OUuuMw1Qf6/o+i6Ojcp7AX
         gEUzlnZYhhBI9czECn2DuxNpJwNdqeGOJ4KqCyAZIoC5nYYdyFgmdDY1v6OmChDU+PBz
         XzP/oTvRwlkfIVbRtYhWWdeu6jE0CbzbGQVJDASuN7CfHR1Yc+HriK6p7UywzBPj4VCF
         rlljV/W3ZRmdL+fVpXaRhlRFW0oWnIDUiOMVJxpTbNh1WtJlPd49NHz7cOD+ZILPC0uH
         UkDQ==
X-Gm-Message-State: AOJu0YwKbc92cxMjvm2ETd+8LNvTMtrbNxGECo2CL4d/EyvV6gLS+zAE
	bxImScZcGIBgBZBzOjWE8IC9+hN+UShezJG09jeTcQexhgPvDQ8gYDzdhw==
X-Google-Smtp-Source: AGHT+IFA20l1hKX1jfOwGw1iBEvU3l75GZKNj088g6h73iMvQZkbH1zuguhfIV7Eism5cUoXSXokyTeFH5rzJUnT4MA=
X-Received: by 2002:a05:6359:b9a:b0:147:eb87:3665 with SMTP id
 gf26-20020a0563590b9a00b00147eb873665mr3095178rwb.3.1696453822340; Wed, 04
 Oct 2023 14:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Markus Mayer <mmayer@broadcom.com>
Date: Wed, 4 Oct 2023 14:10:11 -0700
Message-ID: <CAGt4E5szcr7PNmgrmv_8SR6j_u38SAqhBt=M+2BJGHHecoz4rQ@mail.gmail.com>
Subject: subscribe
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

subscribe

