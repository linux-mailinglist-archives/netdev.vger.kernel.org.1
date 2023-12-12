Return-Path: <netdev+bounces-56366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E653A80E99C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856A7B20B6E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F355CD17;
	Tue, 12 Dec 2023 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnWIFyMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71AA0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:06:10 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-425b4c1b67cso48229101cf.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702379170; x=1702983970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lGmIcMhNgJ5nuLLLOeuCsGL+mY0x9+gbG4NYJUWpsjk=;
        b=VnWIFyMQzEgGsRntblNmb6xeDz/B9aeWZDZ1AgClruuGXqpgLBzS4KsddR8TrxyVdJ
         ngImInj8myJpOFO7u/xH3MQyTaSd6nO+/pZpgjQkB9w90ITSTOLqlxBPlnzfxi1+QA/m
         K4nOfBfPVp36rmjtrJf9C6R+Q+aG8mjIXKIbHb8kofa1xvZTTk0PjvSjqgRiR849lEob
         l5fnM6qqAQIywj6jQzF8vnpOxDEuLpF1wLPClR+z1tF+SpScecr8uYzd47BFn3BR58v7
         EcrvsOHMh4PjA3HYPOZQw4TbSWDP/6U9lbsx6nZZMbayoqrUi68noO4+XAHy9HTLHRf1
         QOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379170; x=1702983970;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGmIcMhNgJ5nuLLLOeuCsGL+mY0x9+gbG4NYJUWpsjk=;
        b=pKkkGjZys94Lh1JyPGg3hVT45my43Fv1MuIqv4ywQZpQei0NW3Hu5ZD2v5JkxZzZGN
         o/nBjMNhYCJtriApU4pk72/oengjB2wS3Z62X7ruONlwzQsen5FlwjVsYZXrMvH7awwy
         2TWzgIKqQv+EE2RcL7HipUw0Suek2Rxfjw0gFvqgQZLU62VlhaQvI8W5/P0loaKyyMUy
         aL//bmloFhUqI1SLfSxyEHtlsD8ga63j874a0hP7G1lbnHHmnNOTCg11SVGJakRFti0d
         vr4FtnZcFZy11LDFHMxIyh2fT5tHQBhIoKRw07m2ijscCB7ZWCmrPSok5zrpAElMZRqr
         CCcw==
X-Gm-Message-State: AOJu0YxGunX5+ULNcaEiAGsfIm2KNbkhE1mkNIJWRAixqI79IQW3ag0H
	0E6fJ9bjHs3x6j+Irj+x1kkRqxdSlZTkXg==
X-Google-Smtp-Source: AGHT+IFo2b+pVYnPyfXEugF9JjsPIvDDFxQHP0SJiNQ4KAbW/54QjxjQ/oZl5a79KBi7gsAEzOCuuvPc9+kOqw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:47:b0:425:c3b7:40bb with SMTP id
 y7-20020a05622a004700b00425c3b740bbmr30055qtw.10.1702379170192; Tue, 12 Dec
 2023 03:06:10 -0800 (PST)
Date: Tue, 12 Dec 2023 11:06:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212110608.3673677-1-edumazet@google.com>
Subject: [PATCH net-next] docs: networking: timestamping: mention MSG_EOR flag
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP got MSG_EOR support in linux-4.7.

This is a canonical way of making sure no coalescing
will be performed on the skb, even if it could not be
immediately sent.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com
Cc: Willem de Bruijn <willemb@google.com>
---
 Documentation/networking/timestamping.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index f17c01834a1230d31957112bb7f9c207e9178ecc..5e93cd71f99f1b17169b31f2ff93e8bd5220e5cd 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -357,7 +357,8 @@ enabling SOF_TIMESTAMPING_OPT_ID and comparing the byte offset at
 send time with the value returned for each timestamp. It can prevent
 the situation by always flushing the TCP stack in between requests,
 for instance by enabling TCP_NODELAY and disabling TCP_CORK and
-autocork.
+autocork. After linux-4.7, a better way to prevent coalescing is
+to use MSG_EOR flag at sendmsg() time.
 
 These precautions ensure that the timestamp is generated only when all
 bytes have passed a timestamp point, assuming that the network stack
-- 
2.43.0.472.g3155946c3a-goog


