Return-Path: <netdev+bounces-124141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3E96846B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC08C2843A6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93813C820;
	Mon,  2 Sep 2024 10:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9F2C6AF;
	Mon,  2 Sep 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272269; cv=none; b=TmDmQgpWQyY1k9IQXXvb8f0HA8Qg3iXoYn4kPpd6yu7ARUHKxP36p+bRI5l+3EFCh8egNeG+2D24fJm60VMcOxN77EQEY6wmvlhqQiezWMT9IQc29d4mbFSTgj6ysLDFpGGgkMAlhxTy2F/wwGOAmykTkCXvM2DxnljkgDGvoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272269; c=relaxed/simple;
	bh=nbX9KfI/+DDTr5d4yM+MfCmQLM1WG+Gg/zOaSMRtfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oi4KydpJ48NIw9SJMBBy33R0KcEEC3J5BKrLBznnm9XOGt9LA27uSzLtPqiEWqZGv0b2sRYnhJgjWvZux8oQJVMlGGOlSO45j3J1nz3t2VJ4Tm1pM+83b6ZPxUIRsy1yLlnIAuXlbuHhkJ9ADxFIsA6vk18TjD7BqW2P3q7tPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so436478866b.2;
        Mon, 02 Sep 2024 03:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272266; x=1725877066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp68GOlzkW0Wm/qTOXUyBI6eoQvITkZK/0/+aDmZ0uk=;
        b=TlPzFJwKRyKCljFQoYb16y+BGUWgQf8LrMrvS/lKiK01zU46et5ynyK19OxJU9f0bk
         5NEBjkr0ZrZLB6NfZ4OPgFwHYQ7Eca/rDldSflsPa2ZN0MV2i0KF8tGegaxmIkhNQyiw
         J2weqBQE8NpZEw+mihECnb2w2H4Oc5Mbkl++V9M5ogYgNMp2QAzohB/2w0o+kE0i+ApY
         2PsilPHchczXppFdYV2wO0RdmIVqK1hQi2sUhAGycvfK7hiMMEqPvCSj+48lrnCjmqP/
         krVTUIEHUwLH6kK5FqQgPrn91niS9cLT3i6S6budka8Q/pq8CIkZmkdzz9i33NbeYFEj
         dNRw==
X-Forwarded-Encrypted: i=1; AJvYcCWNr8Z7ojb3ujkwqLEpKX44PYYJQKun1gfxZemfWLMCnaAtQQZKxvBcbbfiUCJA+xr1rXZyfBGk@vger.kernel.org, AJvYcCX6zTrecCzJMcGx6TcFYIc+mMhkvw0AHGbNuDyrpSrSJ8Nyshypt+WSLwcXxmq8KfsI5I/U7b/sscoEmh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUTbJAKzNa3J8f1FJyzm/32eExCoKxBVM4P9wU6u+6lGb7C1K
	d+1TzNpqFkz3i3DCV+hCJHPB6Vuog9KW+vyYEcMLab2qUKtk/fzO
X-Google-Smtp-Source: AGHT+IGCufznu0i4cMADPoZDO+Y9Jp5Q4Ua4zfgtG0RygJGYNzpjmM8yQ+sDEUh5b9OABvtagM5YPw==
X-Received: by 2002:a17:907:7e95:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a897f84d7b0mr1056427166b.20.1725272265068;
        Mon, 02 Sep 2024 03:17:45 -0700 (PDT)
Received: from localhost (fwdproxy-lla-012.fbsv.net. [2a03:2880:30ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm535742866b.32.2024.09.02.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:17:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dqs: Do not use extern for unused dql_group
Date: Mon,  2 Sep 2024 03:17:30 -0700
Message-ID: <20240902101734.3260455-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DQL is not enabled, dql_group should be treated as a dead
declaration. However, its current extern declaration assumes the linker
will ignore it, which is generally true across most compiler and
architecture combinations.

But in certain cases, the linker still attempts to resolve the extern
struct, even when the associated code is dead, resulting in a linking
error. For instance the following error in loongarch64:

>> loongarch64-linux-ld: net-sysfs.c:(.text+0x589c): undefined reference to `dql_group'

Modify the declaration of the dead object to be an empty declaration
instead of an extern. This change will prevent the linker from
attempting to resolve an undefined reference.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409012047.eCaOdfQJ-lkp@intel.com/
Fixes: 74293ea1c4db ("net: sysfs: Do not create sysfs for non BQL device")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 444f23e74f8e..291fdf4a328b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1524,7 +1524,7 @@ static const struct attribute_group dql_group = {
 };
 #else
 /* Fake declaration, all the code using it should be dead */
-extern const struct attribute_group dql_group;
+static const struct attribute_group dql_group = {};
 #endif /* CONFIG_BQL */
 
 #ifdef CONFIG_XPS
-- 
2.43.5


