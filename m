Return-Path: <netdev+bounces-43212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034537D1BD1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82778B21413
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE615CD;
	Sat, 21 Oct 2023 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grnfSk2G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC01113
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 08:44:13 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B627A3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:44:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c773ac9b15so174832666b.2
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697877849; x=1698482649; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nonsXEsi5WuX1Fh9OG9wtMjhQBwDKMRR69tj3c0V9fA=;
        b=grnfSk2G09Bp4WePUdisFqIM1+fKDrkwqn+kxVVQSM2bAla4sZZeggO6ROeu3L/QyW
         v/HwHdWi1+T1nsoZTJi2e2AO9FkFJ1qW3j3fh1yWJ9tPssOHj+jFLPvBFaQ/jngqA800
         j3G/l8X6m0buGROP6ttu3Wq4ZpS87lSHP+Ssa9hI1CjD9Njzz6+uI4Eh6/xzwKHR8Zjf
         SsVNg8KN+K6oTaJ1EOtcx/R/Jb2CiwWQduD17L/8duFa4kkqjfUA6yLqn0n2wc4FmfYn
         nZKeq5hgNqNw9bsh85/U3ICulO7sLhbTFT+J/uTKm7VAEh5YaXPiNsmWXA3tP/rvKXRV
         2WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697877849; x=1698482649;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nonsXEsi5WuX1Fh9OG9wtMjhQBwDKMRR69tj3c0V9fA=;
        b=OiNMyFwng/ej/Is0dz53mlOLKpkDP/GnQGWxuNemrWt7mr1gyQ6FwspbRrbNtWDawM
         76B354XL8B3Z09rt82JiwOfXMdJpUUIOkTTL4TLAE+NqiDxztmzYt1J6KJJd2xUUwEuu
         z4nateRNFLWFHdzudklKoi4Ob613F0chhKfaCzos1BDBOe5ysTtNEOoZPIwr+jQwTl3T
         5jfgYAZcOjwpdsBb2WBLgGj9OMxBzhdGSdM9Qb6NM85UpKu3bCeJR5mVgOkcC7l+QLAV
         TI1OXuMxx2gOM09v7VEG0q1gMVTnQKsOlP69WYSdvunicvkNRMJLW7rGL+zlDdlQRDBn
         oCzQ==
X-Gm-Message-State: AOJu0YzeIu1DfI56nSQixlx4nPSBVeLzAR33hV7nszJXVDiyr1d+u6Z1
	zeOwPqD8CE1gDZQQAlRxPyF8iQXQYR4=
X-Google-Smtp-Source: AGHT+IGefXT+Vw1ARe+jnkOmJ0QzcU3s+jpbpPC/tHbs09+5Hn6sGW00QvRdfOVIfvzv8OiowdOGpw==
X-Received: by 2002:a17:907:3688:b0:9c6:1143:b52 with SMTP id bi8-20020a170907368800b009c611430b52mr2584214ejc.55.1697877849313;
        Sat, 21 Oct 2023 01:44:09 -0700 (PDT)
Received: from [10.139.141.58] ([146.70.193.96])
        by smtp.gmail.com with ESMTPSA id pw17-20020a17090720b100b009bd9ac83a9fsm3146106ejb.152.2023.10.21.01.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 01:44:08 -0700 (PDT)
Message-ID: <0451403b-0326-4723-a3bb-8acf465fcf45@gmail.com>
Date: Sat, 21 Oct 2023 10:44:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
From: Maxim Petrov <mmrmaximuzz@gmail.com>
Subject: [PATCH iproute2] ss: fix directory leak when -T option is used
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

To get information about threads used in a process, the /proc/$PID/task
directory content is analyzed by ss code. However, the opened 'dirent'
object is not closed after use, leading to memory leaks. Add missing
closedir call in 'user_ent_hash_build' to avoid it.

Detected by valgrind: "valgrind ./misc/ss -T"

Fixes: e2267e68b9b5 ("ss: Introduce -T, --threads option")
Signed-off-by: Maxim Petrov <mmrmaximuzz@gmail.com>
---
 misc/ss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/ss.c b/misc/ss.c
index 7e67dbe4..2628c2e0 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -678,6 +678,7 @@ static void user_ent_hash_build(void)
 				snprintf(name + nameoff, sizeof(name) - nameoff, "%d/", tid);
 				user_ent_hash_build_task(name, pid, tid);
 			}
+			closedir(task_dir);
 		}
 	}
 	closedir(dir);
-- 
2.30.2

