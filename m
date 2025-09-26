Return-Path: <netdev+bounces-226638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC6BA3531
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2186D2A3610
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ABB2F260E;
	Fri, 26 Sep 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BxjfsKl5"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21403233704;
	Fri, 26 Sep 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881808; cv=none; b=pllitqMuq1b7SCQHa2/0bgfrSFXM6P4ueqjwQIEuiHzDTSNWEwVW6+p9xxy6KR0wd6LhDKnAAeB6rUm9ZkRMjR5DZumu+VvcEa4dyl+7nojQyhv2Gm9yWxezEgLc8Z1p48S6mqPFSXBbl0tbYJCbh2cJkC4e1G1rmLrqKmAe1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881808; c=relaxed/simple;
	bh=FPM50SUFxE4R91GbidRBo+cPANFD0VljE4jNjCG8P8o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CvAq2QnYsRr8sHgPSSLYfvuZru6MyBCVoCcsv3+n0ZisqI6kac07CPrz19ocFdY3jAKa+5E88Wx4n1PiRjxDCjj5KiIRPWsET9IQdNh2quDm/srBEon2jC8AVlmNXGJDaFJhlDUO2WUqheI1bJW/M3MBMCH9ONtQubVZjllaBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BxjfsKl5; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758881493; bh=p/FWhBW97flJy6Joa5iUDeBbgx31a8n/Yv7gttstfUc=;
	h=From:To:Cc:Subject:Date;
	b=BxjfsKl5WlO3X4eQZLqVsKpg4F75JjuE90xXkVG0GaLejDbQ3XKRT4ECIHsjmJ3gJ
	 aqqaZAG7nrRoW0a8h93fBDi3RPFYMXeg0WyKnjG6sRDJsP94hZnRQxxJBcyTPPcwn9
	 xB5nXgjz3dTHuRpPRihYlfB3YKAGWoCWhnfrUwCQ=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id E96088A8; Fri, 26 Sep 2025 17:58:22 +0800
X-QQ-mid: xmsmtpt1758880702tj7hgavkk
Message-ID: <tencent_16B08FED03C970A0B8F75F16AE3D7A2F3305@qq.com>
X-QQ-XMAILINFO: OJYupdf7O4WtOarT0umYcT9n2WOK4VNELW60YPTHZEKji+pviCYYHZR6mVbHYl
	 Pfgs+o+CpTCnb6IkWZ7CPweVeSm1olyv6MW+OIYSEzfAdNuOMqZmIoaHJaduO5xhn95u01kuRJKe
	 zAxQNh5RigmOXbBmwUB3TXhIhVvSktJkQjXuNEH+mmsSXpP6+0oEKUEicoRx/0tjO8kccRovlVmV
	 kNYc7y7FxEDuH47dWg2Pntaie4sscqJNkOfXmiLc2SalGfdxV/Mg2T6K0dlFfGPyCYKU7m9foMv4
	 c4db7W+TcXil8ltSJzaG/loywS4yG1NAr/fFYNLmdhupL55QomwtkT9cH1KkZ2cWLONYKoyYjFsP
	 ZUhYz1iTvwfV6UJHx7opEzEfAPrPaLuM5j2g6r3wVuHMt7bf/lt1whDjgHAjEi461AjUHsntPd+o
	 zDEpVWy51qSXwo7QqHreIlk1SzF8Ta4kv7N9QPk0RzCcf19AsXAqL/RLTJUWiOzN3qvX+Iu8l2aa
	 0eqUoTbG643R3CM5XL+d7Y9eI6zY266su8MZQoIQXQPgPUiDOrufUr+wHYdXycnazBzWb7EQ4cME
	 hZyTijukkO6FeeMWHakpJ4s6wqjPa3W1bTmDfY4pI4mNLIPrF6AUbNFp66sdxZuSyBOkGL0UEdl4
	 4ZzItesOC8eQR5vQUorcMtyW6pOGn1fvK4y8iUb4vgI7/HdqbqqS2lJmg2BcZNTbC1oVhdtEOQia
	 orBrc5Xap99pjam9OCxgzRTv/Qpdmn/C72tKGaHTMSqbVaf/aL3HdJ3YXc6caYsOSZ6P6/qdSCai
	 QTcTSrp8M+ZUp124o9xdlyi7PXI8FdorRDRY9ti1KZJzAzWyjlHq6HVaceMnp1ptxA7gezu+cX7e
	 Y8MkABxiYfTwAbR92iwmiOKQvaLAVTpNqD2pb9RfqbcNO9EETgnpvYT37INW6AEqr6cyYiKrYbcf
	 DyCOO8ODyjtpiYYkdht/FLAdu1Izk/z7nSbBU7HVtGUjSxIjpxMxJ/1vy9BNgjarEvEk3werzcxo
	 9JE51IutOeezRv657ACic8Wm53XvLbdr1yowBFwhGcg3FkXmuGN4NxUA4+nIQv8TcloTjNXQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Haofeng Li <920484857@qq.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] net: ynl: return actual error code in ynl_exec_dump()
Date: Fri, 26 Sep 2025 17:58:20 +0800
X-OQ-MSGID: <20250926095820.2570975-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

Return the real error code 'err' instead of hardcoded -1 in the error
path of ynl_exec_dump(). This provides better error information to
callers for debugging and error handling.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2a169c3c0797..1a79adcc3ac0 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -1064,5 +1064,5 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 
 err_close_list:
 	yds->first = ynl_dump_end(yds);
-	return -1;
+	return err;
 }
-- 
2.25.1



