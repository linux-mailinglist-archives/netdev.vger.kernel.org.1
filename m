Return-Path: <netdev+bounces-180429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E12A814A9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B12460110
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6823F273;
	Tue,  8 Apr 2025 18:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAC13B284;
	Tue,  8 Apr 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137140; cv=none; b=NYyy2LIKFGQsbE5Tu8KtO4JKoFg3vEmAzv4UMPOCnPGFi0jsZAYHDEVNFWmfKvEpLNS7uLsGfRosaqgpMzD3LynHYsCY0JAq/jlzTChPpKumTaZgQusTsMbD0fS6a8DL7eo36VzzipOv1wVb6fmIvwqvGbNQVohzwtbxXBisbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137140; c=relaxed/simple;
	bh=OryvZOZreQRN9d4/WwVOrgEu+nwQYER0oeNyHkxvwDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Esdi3Su+JPUbPRk5lGT5fDJAgvw8G6IOAstUYiUitezUVgFjH7YHU+ZdOtrTbAimcUzEylHVze+051hZmI+2YggMv/QSFJW/omYeSnwn/N8wRgTn+NwNoQmqAgvfWuCpKM0df0v1V2g2l045pSa0JOVHEtZ8p6oujcmas2I7bNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac339f53df9so1039769966b.1;
        Tue, 08 Apr 2025 11:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137136; x=1744741936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5Jx7PvljALIDWr8PvqHjb+UDGqay3yAkNF12bNlpmA=;
        b=bbihGiYPfkXZ5vIqNlEyPC0V9OWVFMWYAp86KhNUPSuEvRVZgTvSiI434m+RuYdWMF
         iE4dKzLrON3SnGFRBqmt5if/o4wUN6FfyPi2KPKS7+pgty7zgi34xYOVv8pFtHDYZn0l
         RwqfihznLc/+wj/ZS+hrXopGtAJ3+oBDWKLyAHgKUVfRrxjHgE1xjLfX8R9qn8fRVmqV
         R/VX6CTyrRfrCzpnxOEw3Bh9pTM5vCAWVcBaqAjDLLG3XUiMg0BCBL0z4/7vfPHNg6a3
         PgmBfDLKODecN1ibBXm2nlBpCKjm2o2rY9WXu5D+R9HuEuS443PEihJqZFJW/pwTyazF
         pNvg==
X-Forwarded-Encrypted: i=1; AJvYcCUuD7wLXoW93zWYuDXrHw2tLQmv/PVsCbVJrCzbZTyxzYxomUYYPvIaULfephgh6K9znoL34N60@vger.kernel.org, AJvYcCXbc3fzMBI4cyCEKOugQcIWGDh3Sra+bnsP1D6NGZD6BTYNnFcAmmbPd6dzxIx32/3eEaabiDTfPJiH/vg=@vger.kernel.org, AJvYcCXqfWDkpJowao2d5I5m6lQOQa4nM49KIecVuAJr3FflZPHiSljvy48xELOe09ATL0BQjywWyT3oXFwQUC9s5ksJLwbI@vger.kernel.org
X-Gm-Message-State: AOJu0YyIR6/KJbxQtxOXvES/SmwDm3d6z8zhWa85uJ1WMIdS5kpqxZb/
	kNbSml4aACmn9vlWeMfC5j/B7FhOjJlXL3v/WPRiZAg8EWpzUv/feYkptQ==
X-Gm-Gg: ASbGncvO36rVvQLxI3I505kuKhY0E6UASEs80QqWSDDJdL3DP9n4BzdOwoNzKx8IvFM
	1zCOvvSVwFra/WS361sbhHAM+D4XkzoGnPlD3vBy0hxhWh11MHCsS/tHDjOiy8ShQr2ItTOouvN
	sgWMG66cSQ7NTaXSohzmC4KDuW5FijGGjSpFBSBctaBPgFM7n/oeOamJs+bB0Yzu/veuoP6BMXF
	j9eYed26aMx+nc98wcGhQD5hPSecfQa6hPFcEu2W6Fj3F6McaoK+JFslvkcvl3wOw6Nt8QCQres
	XkKekonOyOOdf7A1/8uS+ULr5rokiHKNVVF4F9gNL0w=
X-Google-Smtp-Source: AGHT+IEMQRTZxVzUSeU2TT2ras46DcgDWdtHHmlpLTCdXnJGJ+RdrGIkpzvVjbGzNwmZXTANC0UiZg==
X-Received: by 2002:a17:907:948b:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-aca9b6988bfmr19320766b.34.1744137136387;
        Tue, 08 Apr 2025 11:32:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0184d30sm958281166b.133.2025.04.08.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:32:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 08 Apr 2025 11:32:01 -0700
Subject: [PATCH net-next v3 1/2] net: pass const to msg_data_left()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-tcpsendmsg-v3-1-208b87064c28@debian.org>
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
In-Reply-To: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=leitao@debian.org;
 h=from:subject:message-id; bh=OryvZOZreQRN9d4/WwVOrgEu+nwQYER0oeNyHkxvwDM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9Wutou7ciJXtVa/EeZ7qCwW8ZgzuDckGWA22V
 rTyYkVFF9KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/VrrQAKCRA1o5Of/Hh3
 bYCVD/0Q/gZaLkfLzmoF3U5VC5WEHqR8IKwja3rGU1EVDLvpQltAl2K6Zguru4zHM0YUHD6KtEL
 /H7QGpznCK1+YaCvfOfR6iJRoep9aP+pfyobDIDIgM21sLctwS+KGvWeU0gnGD2p5PexALNzzLf
 tWXuFjUMjmm41EZE3atN90VppuucK2BvRwlmuTVcwWbIVoPZI2TIZD6SPG3fFeNJeBGJ3Hjj2uv
 tJ09IdGiP64DSw73s81wQm7jABfWikdykdTokyit0r2bxmnDWDkBUg3UbM3It6XC5THiUVmn+rE
 eF4m1pPyvZ9abpBNSOfh/DqZey9WyLR+lrLH9LC8fvUQgDJmNKfLvVwWwWHe4QlsU0OqHoG0PhY
 gtoFT5uz/qN1jci9LHGY3NjeDvqbwjcRtIzNGn/UQGD8rD2UsbSwSWCYeazbpjZ66CBc2Sy/Z3o
 EFlCHP7qejBcitjtQSqy8XCoyJ1ufsBdGW5ld5REAn4PPUQqV8VsVsqFeZxZ/V0ihBgMu+d5uzp
 KWcSU2zvyU9c3FwphYI9lrakJGTA/juOJNWqhNbuWigUNRA0TR/OiY5EoNrzWR/CN244vWg0yu6
 ERsyRtYc9T+jxgstWwDFLBKm4ikaHlMKQLnuFbZbqM0TPBm4tHH+RWau5f5uahKuJJlA/XWerrC
 LFxGEukAl/cw72Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The msg_data_left() function doesn't modify the struct msghdr parameter,
so mark it as const. This allows the function to be used with const
references, improving type safety and making the API more flexible.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index c3322eb3d6865..3b262487ec060 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -168,7 +168,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
 }
 
-static inline size_t msg_data_left(struct msghdr *msg)
+static inline size_t msg_data_left(const struct msghdr *msg)
 {
 	return iov_iter_count(&msg->msg_iter);
 }

-- 
2.47.1


