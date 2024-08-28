Return-Path: <netdev+bounces-122874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C3962F1D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEB11F2315C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23531A76A0;
	Wed, 28 Aug 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwXOV1FI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F61A706D
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867907; cv=none; b=l0Eu1FQQtbINiJIwdO7OyxiBcAAopP9qHQTCxmQWZevmmV8GjCL3LUDodsidvP8xb+G+JgS+gfXwa9lof11aHgM7vhxMxI9kEvHdLmL2+ebGT8US583sBoWVOEHQhsTG48uhPV5HRtC84ikcGCRSDCvdI+ajKAxK0TzdjE/fjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867907; c=relaxed/simple;
	bh=3OTEA3ZJBCWmsgx2NOrIPS9pq7fDhqSXWO18tFvp4Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FK72Jrt9thC4FNOokYh2lFUigNFxXHikEqw86hLAuqhe3QflJ9zBSmBY/qJo01UG0zQdCJg2PDPhmXVC7XfWWaIeS9S7QvjFFQaV2+QfJIGhrchFLk8H+Tv+KQLD+TFZC3Pt5kViKRq+tMoE9SXX8PwcLWE3HdMhlIMZu0t0MQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwXOV1FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C5C4CEC0;
	Wed, 28 Aug 2024 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724867907;
	bh=3OTEA3ZJBCWmsgx2NOrIPS9pq7fDhqSXWO18tFvp4Fw=;
	h=From:To:Cc:Subject:Date:From;
	b=qwXOV1FIgr3IBMirJoLn3oEtdFrK7PvMAVV9VSpEYaUAa2FXVBhZs2e73+2ptmr0E
	 lNUtxEULM7p/1Mkg0w2Bna6y8ymqZ234Z1y5MsWM+7it+AJGHlN41ISaI1So9ry0Rx
	 X3B8xRgNphGA9gpk7RJhCq1e0uUfYhnXZqHnOGk2qWOpICyF9UC3jbj+M1bvPMc51b
	 Dq2m2OgcEBr3lFlWyHRiN1nyWRTeWy1qVqCCuuXmHqTKus0sepsN60mE2eL6wWkqG3
	 QW8DB3kaPLrOIotcaY8tNLIAatjVd6zMInyzD4zldyErCPEbfqjWT/n2K/5B8+fGxy
	 WyfXgwMgdNMeQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: exclude bluetooth and wireless DT bindings from netdev ML
Date: Wed, 28 Aug 2024 10:58:21 -0700
Message-ID: <20240828175821.2960423-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We exclude wireless drivers from the netdev@ traffic, to delegate
it to linux-wireless@, and avoid overwhelming netdev@.
Bluetooth drivers are implicitly excluded because they live under
drivers/bluetooth, not drivers/net.

In both cases DT bindings sit under Documentation/devicetree/bindings/net/
and aren't excluded. So if a patch series touches DT bindings
netdev@ ends up getting CCed, and these are usually fairly boring
series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b75356afbac..d56b1b42f1e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15894,6 +15894,8 @@ F:	include/uapi/linux/ethtool_netlink.h
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdev*
 F:	tools/testing/selftests/drivers/net/
+X:	Documentation/devicetree/bindings/net/bluetooth/
+X:	Documentation/devicetree/bindings/net/wireless/
 X:	drivers/net/wireless/
 
 NETWORKING DRIVERS (WIRELESS)
-- 
2.46.0


