Return-Path: <netdev+bounces-197575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E70AD939E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C8D16E9DF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA4221D94;
	Fri, 13 Jun 2025 17:16:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E3202F8D;
	Fri, 13 Jun 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834960; cv=none; b=GaNEwcdwfSxykmMwJfZJ/CsWkZ8tuvikqwqGbc3CkuSezkp6t2M/JXH1dJL4OBv8TrNnhb65aa7fGRl+5YPWfGzxs99NZia98WoMr/LsldrDAHtXBdjn7G1xUaJMzhmYBjYrAO5+I1GSt31nmBaq0VtWw1xABiYN1B64p5QoGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834960; c=relaxed/simple;
	bh=1ZH2b6ZUlZPaBRuBt/hNdxgZCldvvpeb2gvA1spBNtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MPqK1hCBJxVwaIZNW7Zb3haHcwyjdKMoJlZOLMH7XAuj2wMuFMXNQ7Kxo9TpPdEpDnUlNokjtlZdr7LfQnYKsJ8u6AO2HoeOq50vqXIBptK2r4cRIuz5bnttyaFPlLwQWFj0mr+PbHxJ5CDoDIWsgZOKHn+mNgEVYpM4SHXiDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so311771566b.0;
        Fri, 13 Jun 2025 10:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834957; x=1750439757;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGxEYwfOd0Ujd5Hw1wX1Gnw78aFNFWkj5mQx5XWTxjY=;
        b=kLesICXRV7BDN20iWe/vEq4MERVO+s+HEedgXVvbkUCqhhDvoiFxdGw94MV+uoPl1u
         0z0jO3/NHp7wGxK+pFQno1gtQK9qobIS5UBABan0xEMbLXFhHV6n6MlYHlBrshPEg8Q4
         iRhTUWJgRGMZz8UpxbAn13aXdOYAc28kTjBSF2CKkf213VPC7HNK3djZhR3Ku/oUrj+K
         2y5BRWnnBO/WtqN5N8xSZ5ZXsdE+9HihNIBlRsnmwt87PJoP1GAY7EVdfyKlfEHgs4uR
         o5MP7ZrZmGErFYXs+ijaGwGmYYqrkmxj0Qg4rmgVdTY82k3L2HzcUcsNsv12BVlA3Bjw
         NRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV00uSrO83dq6uFC/EuKyhenGYI1rTtZZ7sM96JA9n6Oc1hD+6WEiuhEfmNGQsNEdJJjZslzt74UTeDcpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+6t0QO5bUZd8dhQHGScFhdSS9GATcSGgwcNqy5bM0uvzHMIQ
	ylxC11kwzJNEJmlR3JsfmxQhuAAtpxq/sJuMaM95HlKhbT2IvRL5/q0j
X-Gm-Gg: ASbGncuPfoiezWnqMMlZYzcE6dAoYYI7+YyrAh/W4X+CXywkQl/M6v+elKMLQGz2Gfb
	Im1wD/LG9lbc4kfZjdLtzBo1aRkEd8seJaBE5/7Q20BfhMRUe3rmaiThVkSLfSyTWXm8WNNkHJm
	goTD+D5PKTbFeR8vqWMlP7aF1gjW/kdqRhmDzkPW3Rw9OlaPjiE/tVi/ZoaConuv5mSyYAuurdj
	ZWwcGiZNBOoANPOh5fd3xV4AA8f0suc1z8DqNtjxzZ3bOAEDzEZT1rfOZ5ymGxxk6nOZZ1zVU2W
	tDSa4T5iZwgL3ov5QdXHdidDpr0mAY7kmdGB+AczarzjA2GW6TiJug==
X-Google-Smtp-Source: AGHT+IH+FY+sXP60bK/pav/b5kHtQnQtXciM39phg3rbYnFxvYvjqOmz/uO/j+iPDOYwnei2I4q8eQ==
X-Received: by 2002:a17:907:7b8b:b0:ad2:15c4:e23f with SMTP id a640c23a62f3a-adfad327357mr2598466b.13.1749834957036;
        Fri, 13 Jun 2025 10:15:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8153529sm156155666b.23.2025.06.13.10.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:15:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 10:15:46 -0700
Subject: [PATCH net-next] ptp: Use ratelimite for freerun error message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-ptp-v1-1-ee44260ce9e2@debian.org>
X-B4-Tracking: v=1; b=H4sIAMJcTGgC/x3MQQqAIBAF0KsMf51glhVeJVpITTUbE5UQorsHv
 QO8B5mTcIajB4lvyXIFOGobwnr6cLCSDY5gtLF6aDsVS1R2Wv1u7Oj10KMhxMS71H+ZEbiowLV
 ged8Pusl9OV8AAAA=
X-Change-ID: 20250613-ptp-58caf257a064
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=leitao@debian.org;
 h=from:subject:message-id; bh=1ZH2b6ZUlZPaBRuBt/hNdxgZCldvvpeb2gvA1spBNtA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTFzLWTOEeoS8B5ihZOT6Y31FFXEtnxOdn+KDa
 IPJfMiYbOmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaExcywAKCRA1o5Of/Hh3
 bcsTEACj7l/UGxvz6U1UkdstkVxhcZtyUS41h5ofTjNKIDkqY93hHqEJByPXrruvhPydigVU79J
 YezarOTuk6udAZCeTPpPJlP9NgsbMR/KWwlyP6RpuiP18dCAlzq8VuuhqBYnw67YZyP+f3CeC6G
 8QcvhCHIQZcYmTrCCq3D6Cwr/hYTu95qxUoUQOiNmxkN/3cRwQcV3leVp5EuiPS3y/TsoS+oVVK
 S+cGLiPL9U4B269RitLlYPRw8fSztZd7qJzeur5FkyG/t6iZsC0Md+Xk8UEiY11dHsVnBK+g1QA
 TbmAhNyjAbfBdkF4wQp8ye4oFd+76jTFlyywbkoVzjb7rkiuI6aUkKTN8FrJE62r7PLt5OnW1Ca
 4nvgEHa8Tm7F86G7JOpK64gD+WlZmsloBbfWSAmC289ZClbTCOD6b21ax1nBp4h1DTwMC253wY5
 8yCJz38caLsCcDstNrYbroBbD+oJbBxNyKwEWjXSQVvdYcvrlwQHbiay5Lbtocbr2831qI09NwV
 1TkRpF/HIzjkip47v6ok5UKW83ZzME3JL1iCx+05GKWenbXPb83BkxVWoizt4u3YFN372+O0exJ
 8Rq5spxtv2R7mwtSQfiQs8wuJvQC1ucaf1/03ma1CsD/dt19CoDz+OBtJDlYEcjUDoJ2IunlDTB
 T9vbpw+sYJppdpA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace pr_err() with pr_err_ratelimited() in ptp_clock_settime() to
prevent log flooding when the physical clock is free running, which
happens on some of my hosts. This ensures error messages are
rate-limited and improves kernel log readability.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/ptp/ptp_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 35a5994bf64f6..335e88d3ebdff 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -96,7 +96,7 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 
 	if (ptp_clock_freerun(ptp)) {
-		pr_err("ptp: physical clock is free running\n");
+		pr_err_ratelimited("ptp: physical clock is free running\n");
 		return -EBUSY;
 	}
 

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250613-ptp-58caf257a064

Best regards,
-- 
Breno Leitao <leitao@debian.org>


