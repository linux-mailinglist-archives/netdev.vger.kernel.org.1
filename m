Return-Path: <netdev+bounces-27713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FE77CF15
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844B5280D6B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3414ABC;
	Tue, 15 Aug 2023 15:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A712B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C090C433C8;
	Tue, 15 Aug 2023 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692113283;
	bh=4G1Occfzk39bG1Fz4J+IRgpViclUFYqLilAA5At/1JI=;
	h=From:Date:Subject:To:Cc:From;
	b=Y9SO/h5W2xJdVv9OrPjCedAocbzoK50Gwv9+IQrZdfCWdEzrBlghDJwmOqypnPil6
	 OWitq4WgRdodfG5Xp+l94DaeaRjmRC+hrcXkQWGBTL+8boy+HFPbtBYI3tMV6k7FuC
	 s2zY7qHPjlH9S65DqF1Hja365jVwBMlQJiG/2oVRiwRJWZ1ufVfE6pPP2RYNCPVemg
	 S9CGLz8IUJlx77l7BCQ3F99GJQqXQQP2RJSgC7h/o7zDu7r/ikyPN7FqAhc1xLoLin
	 qXfxrjmqH6PZlyXDu/+5m3XpcA7m0rZoJgbk16UiXGT0Rk3AiO0aB2oZfnmU5FDCTl
	 yAzEPAVcHZalQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 15 Aug 2023 17:27:49 +0200
Subject: [PATCH] mailmap: add entries for Simon Horman
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230815-horms-mailmap-v1-1-dee307b451e0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHSZ22QC/x3MTQqAIBBA4avIrBPUEKSrRAvRMQfyB4UIwrsnL
 b/Fey90bIQdNvZCw5s6lTwhFwYu2nwiJz8NSqhVGKl5LC11nixdyVaOKJQRzisdHMymNgz0/L/
 9GOMD689as18AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Retire some of my email addresses from Kernel activities.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5dd318121982..e50662536c48 100644
--- a/.mailmap
+++ b/.mailmap
@@ -538,6 +538,8 @@ Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
 Sibi Sankar <quic_sibis@quicinc.com> <sibis@codeaurora.org>
 Sid Manning <quic_sidneym@quicinc.com> <sidneym@codeaurora.org>
 Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
+Simon Horman <horms@kernel.org> <simon.horman@corigine.com>
+Simon Horman <horms@kernel.org> <simon.horman@netronome.com>
 Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>


