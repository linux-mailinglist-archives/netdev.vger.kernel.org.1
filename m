Return-Path: <netdev+bounces-117236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7A94D355
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B6D1C21DC6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E8198856;
	Fri,  9 Aug 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1b9FwcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCC19883C;
	Fri,  9 Aug 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216936; cv=none; b=hJ/H4/DUmxLTCsjpVOq3Vvsiyun855ORbmKQl0xwVww0fZeVgPzCiwpC39Cj01x5+j//ZpHjxxQDM3Ao88MgP1K1WZtQLImSWnymZ10+cwnuJONxQzZdHMTkXFu+uJIzUfjQGP708YBkN5tidZYMEJmxaSzswR+dv1mnqgTd4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216936; c=relaxed/simple;
	bh=HlyJThkDlBMireeAQexe6626bYIaEEUXGfjWtQZWj04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cNTUMBxzPDESfoNycy/J9LyefvqkGTQEaPNnOOWgjhVZ657kFGAqW/u7VPSH8yx0xlIILayjSHxZLAavg3ooD728nALphAfun3jxtBUqX9y7bX58xvwFy1F/gymqMUiE1F8N+OY7nXSiaY79bxrsQhr3vGQrRqOP433NZhWDSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1b9FwcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A886C32782;
	Fri,  9 Aug 2024 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216936;
	bh=HlyJThkDlBMireeAQexe6626bYIaEEUXGfjWtQZWj04=;
	h=Date:From:To:Cc:Subject:From;
	b=r1b9FwcMuQtYCwpbG+D7+8ZgJHmjTuRNFvYBNtR3Extjz1LkgdeqJ4hhCkpq8fzJA
	 2g4oMtVivHvTe8D/Ncur8s1vO740tTsLKrGsAMKLODj1LYQWPI6mU/QuBLcG+eHJZH
	 mfzKLHQ+mnPPezZF0RleQ+vpzG9ksVcBq0NgsGHo4D9rzGhlkK/ZaX1uEB1mvsZLyo
	 OH3uEPLLE7U60ISuDSUCJYPBF1bom89sWxgwUAdHJr5iHDbFWaQg3Ozb59J/zXBUwa
	 tFm2T4sUl+8368S3OaPsb1IApCAGS1VxUxURppxO+ABEl5jrUQuSgzL0hYKthFmu9Z
	 jYdQH2Ev8VGkA==
Date: Fri, 9 Aug 2024 09:22:12 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZrY0JMVsImbDbx6r@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Remove unnecessary flex-array member `pad[]` and refactor the related
code a bit.

Fix the following warning:
net/sched/act_ct.c:57:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove flex array. (Jakub).

 net/sched/act_ct.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 3ba8e7e739b5..2197eb625658 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -44,8 +44,6 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
 	struct net *net;
 	u16 zone;
-	/* Note : pad[] must be the last field. */
-	u8  pad[];
 };
 
 struct tcf_ct_flow_table {
@@ -62,7 +60,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
 	.key_offset = offsetof(struct tcf_ct_flow_table, key),
-	.key_len = offsetof(struct zones_ht_key, pad),
+	.key_len = offsetofend(struct zones_ht_key, zone),
 	.automatic_shrinking = true,
 };
 
-- 
2.34.1


