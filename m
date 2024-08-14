Return-Path: <netdev+bounces-118504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CE951D10
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE13284A0D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8A1B32B7;
	Wed, 14 Aug 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPZaQta0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1731B32A9
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645718; cv=none; b=ez6oXgcNhCIVfcpef3ZHZ78Cjfp9rjP1VjYLEkhPSFyewN2763SE4FF/3QQhuEHtgXb22WwOmoxcJ3FBtE+xBAD9eo9i6x/M9qhmfKeAm+NF94G9FQz1TiDszwlugXon+bVYbO6oY+20VEnWdk2CfSbcwVSV9XTiE6GKZD12+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645718; c=relaxed/simple;
	bh=QWxt0lloGANJxaduuHaqgPl0oFfbfuAXX/8icOmkxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iillDt4FqjeyjuX/nrgkZJvZ7+7iW6jQ5vWUgcjP2t1/OB6iZqbGm8GB9F+RhmOv/jcvOqPt0YYh3S6wT+3KGRHuxQXac6Iuvxc36IsrtAHAPmJtX1X2F+vzvDEZdxopMfStxWNKgLUI7znh761kG3bzmsDWYUqzmhRu8p+wp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPZaQta0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670F6C32786;
	Wed, 14 Aug 2024 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723645718;
	bh=QWxt0lloGANJxaduuHaqgPl0oFfbfuAXX/8icOmkxfo=;
	h=From:To:Cc:Subject:Date:From;
	b=oPZaQta0WkHLwSSEJcdJqXCHmJbo9f+I/Eev2ck4naeSBJ7QlbacqEsMD236kWvgY
	 7qUe7/cmoKUp1ZM+zIBTt0neiNXJz0/3C4pjDZEUPTWo/GMH5x61N0pijTpbvju333
	 Js0iSIva2/VpHTAZ4jk2zHNeMvi3bb4Q8TL+bNjqyarea4lxL0FUgrZ9ucQ/MgJ7Mt
	 fsFu9krnsIyaLM/IGqIIIbyXqmu2xXPrbxfczf9giv5ExJS8NAAl+MYPJFx41WS0zu
	 qK7YbopR1NvmMcPUsmTk0FQKw9gP5hyFY7VsJ7PqI3MUnF+L0F2mvqkK1rs2UUCtyi
	 aWOm9oC6sJtCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add selftests to network drivers
Date: Wed, 14 Aug 2024 07:28:32 -0700
Message-ID: <20240814142832.3473685-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/testing/selftests/drivers/net/ is not listed under
networking entries. Add it to NETWORKING DRIVERS.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b291c3a9aa4..a6d5fe3bc08b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15886,6 +15886,7 @@ F:	include/linux/netdevice.h
 F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdevice.h
+F:	tools/testing/selftests/drivers/net/
 X:	drivers/net/wireless/
 
 NETWORKING DRIVERS (WIRELESS)
-- 
2.46.0


