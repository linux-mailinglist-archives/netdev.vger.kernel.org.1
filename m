Return-Path: <netdev+bounces-78826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08572876B2E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B8282B09
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B22BD0F;
	Fri,  8 Mar 2024 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+B3ZZlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420925570
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925957; cv=none; b=VPc9hw59G3S5F1Qg1bXQtikQHqvxK5HmcDV3KrxsrD6i5jmnFtw/v3NY53DVsBwGYo0MYpK0SzO+OnaqdloxSb40aKbolS9tRe8Iar/NINg3XKGmPlOFNVeSjrfhZ5rdMtVCiRPKjWQCBNMxdbvzcNGB7sfw9WQ9qXst2OG3Vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925957; c=relaxed/simple;
	bh=O2iWMZzdJFYWXHQtocUxX5VXr3xLQ3ZyfnUFOFKFtTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlI4xIUCfzt7gOW11s3EilkGvB5L+OG5dI4JTvwHFKLd8kttKv9HZiQm3GJMyMPnkXKBR49DOFZyeyMKhUBiPNNEWv886XPC524HPC/K+qXLUk3TkCOkf7Q/nFwIGvTM//ZKW+45km/qXLTiQKREy45kUIZQ2jwC7L0pmHw0qtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+B3ZZlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B702CC433F1;
	Fri,  8 Mar 2024 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709925957;
	bh=O2iWMZzdJFYWXHQtocUxX5VXr3xLQ3ZyfnUFOFKFtTE=;
	h=From:To:Cc:Subject:Date:From;
	b=K+B3ZZlXmm5bZ/L6Op2rq5TTSUa5IRyx1kYRw+HJIcIBwJb2IMYsq2AOeQ4//J9ok
	 cf/nr9mMADrYI89ho5hDc+HoRpRVp/KD1n8Jq0VssjDF8IqEQziXpoKOa11Xz6z5/I
	 Jp8PzLfbY+fJLu9qee0HQE6Us5WmnL7/RQTXXyOOk5L/XVENRrQjp+nQyJsbGpQs8o
	 jRyG8ooQdNj4zqodexkUo2mA3TN1r8rFDVXjTUz5qQDskXTnZOFLvc84OndfDy1Xfm
	 X9NlT0wBcmgQ1B1StC5elbjJgZ4KfO4Sm6DobwY8KU2HRZHfl452N01jUYx/k+QQBF
	 DFEWO2HzQvuYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl: remove trailing semicolon
Date: Fri,  8 Mar 2024 11:25:55 -0800
Message-ID: <20240308192555.2550253-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e8a6c515ff5f ("tools: ynl: allow user to pass enum string
instead of scalar value") added a semicolon at the end of a line.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 239e22b7a85f..cb01eee3b2d5 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -484,7 +484,7 @@ genl_family_name_to_id = None
         except (ValueError, TypeError) as e:
             if 'enum' not in attr_spec:
                 raise e
-        return self._encode_enum(attr_spec, value);
+        return self._encode_enum(attr_spec, value)
 
     def _add_attr(self, space, name, value, search_attrs):
         try:
-- 
2.44.0


