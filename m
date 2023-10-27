Return-Path: <netdev+bounces-44729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD77D976E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151981C20A8C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD48199B7;
	Fri, 27 Oct 2023 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8daz6rc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989571FD5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:13:01 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA198121
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:12:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d81864e3fso1287085f8f.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698408778; x=1699013578; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ph8ZV619qssLjPgO/yEQk7zJEM+NsPqPerc7acZSWpY=;
        b=o8daz6rc631MqPzy5xXDSWpQC+qqEDyriqahCFFP9KRW2v++lJAhP/3E+UkavWESWk
         NjGQCqPCP6iaxR/8iQ1k1cAdnBq/w6mI6oOGXfdinxLKzSAYjVbFF7t6w3U1WM2jE/HS
         sefaSYFJesUVGHnLJgUCvDTW54reKPRxa4ZjaefZVGU6SdnB2PhFIM7X8FwQg79nbtMw
         jmpk4LdHu3lkPoWMHmUz8+51aFjt/sx1/RQ9Pcc8xBoMD1DdKodC7FhZpHSj/sl+4WF5
         +neR2a5bqH0+fFnPNPIZARb7BD9OyVxg4UuBXpyhRAXX79mIQ+WK7baW3dWEnFNRT9Ew
         fxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408778; x=1699013578;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph8ZV619qssLjPgO/yEQk7zJEM+NsPqPerc7acZSWpY=;
        b=IKumWI9U2P2hnKTWFZkRbt/Rsh1PepBClpxiEED+FJtaGQhv4hctOhj2qtFXdjzLGU
         vAipmlY3myDSu+9V6QMxcGzZRpoW4cPJu9NjUbMD3a49d5sCSSjDLOHODa+uK9Fi8yAr
         w32t5jKZk+KfrKy39RN1HAHT/GfPZuQf7YVQQmYOFyKxCMUAF40GBl1fd53xwx/boRc4
         LwbHIqnNTL3eKa8ZbNCo6m+aYY4LN6JJ8ZErWdTvlo1XF2Gn0MMFSljR+ZgxyshzrG8Q
         Y1bkdH8lQcwureJnB+IPaxI9x5uqAo7WjpCPZhqlMXgUz/lsFvpFHI588eGVqjvT2I4k
         i3Rw==
X-Gm-Message-State: AOJu0YyGo5mG+khDI4Atgj+u01cRp5Tm0lqvdSAQHYC+oAkrpYYMurW8
	GEBY8ActmhX0GSqKepX3cIe8FQ==
X-Google-Smtp-Source: AGHT+IHQCvYgKC4GIYkhBWYFRXqIbXkxbYn7XjCLJnX8gknw9LeiqQ8kmzYwo5Nm46vJg6lPKDEazw==
X-Received: by 2002:a5d:53c9:0:b0:32d:701b:a585 with SMTP id a9-20020a5d53c9000000b0032d701ba585mr2104274wrw.69.1698408778388;
        Fri, 27 Oct 2023 05:12:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p9-20020adff209000000b00324853fc8adsm1642437wro.104.2023.10.27.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:12:58 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:12:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bo Liu <liubo03@inspur.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-XXX] vhost-vdpa: fix use after free in vhost_vdpa_probe()
Message-ID: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The put_device() calls vhost_vdpa_release_dev() which calls
ida_simple_remove() and frees "v".  So this call to
ida_simple_remove() is a use after free and a double free.

Fixes: ebe6a354fa7e ("vhost-vdpa: Call ida_simple_remove() when failed")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/vhost/vdpa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9a2343c45df0..1aa67729e188 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1511,7 +1511,6 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 
 err:
 	put_device(&v->dev);
-	ida_simple_remove(&vhost_vdpa_ida, v->minor);
 	return r;
 }
 
-- 
2.42.0


