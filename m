Return-Path: <netdev+bounces-18170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7B755A13
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF672811FB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A444C98;
	Mon, 17 Jul 2023 03:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BA15B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:27:15 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5DD18D
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 20:27:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R46vf6fcXzBHXhg
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:27:10 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689564430; x=1692156431; bh=Oyj+TYnFM2nBhAsEqO9sGZFdi1T
	41zSnIhBu9yxAGig=; b=ceI4ja6mW2skrEWD0o2pcg+KUCD/H0WA9GfGx+bcsEL
	uvNfgn10YaPtOjeWgzS0m9V4b/j6ZrZKaEZafMlOhmI8k1eCvUKDUNgLJMDeG/9U
	p/6uDHVH/qWT3l1DDYtCdEtpiWsIWzSqYPNMduQPMuiJgCwctTkqs9Omb54wYGeL
	44z5rBWCbFmZxGGhKOC1VlwnLQEe81kbCguVaXQWy1Y6ypNTDSbXvCBQri4iEK0f
	8IOwiV1G4cb0qKsdBxFxxVRSC3jEdsC7pHNGAt+NXLD/jGDvnFO73la4W/xtoPv3
	qYaBU2BCOCWn7PeLmK68HLaBiXQqxFHw97Uwca1cLPw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cHJD7h0nocig for <netdev@vger.kernel.org>;
	Mon, 17 Jul 2023 11:27:10 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R46vf1jWLzBHXR9;
	Mon, 17 Jul 2023 11:27:10 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 11:27:10 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 3c59x: Add space around '='
In-Reply-To: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
References: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <304ca645a55aa0affe830bd36edaf24d@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix checkpatch warnings:

./drivers/net/ethernet/3com/3c59x.c:716: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/3com/3c59x.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c 
b/drivers/net/ethernet/3com/3c59x.c
index 082388b..9aa3244 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -713,8 +713,8 @@ static void window_set(struct vortex_private *vp, 
int window)
     Note that we deviate from the 3Com order by checking 10base2 before 
AUI.
   */
  enum xcvr_types {
-    XCVR_10baseT=0, XCVR_AUI, XCVR_10baseTOnly, XCVR_10base2, 
XCVR_100baseTx,
-    XCVR_100baseFx, XCVR_MII=6, XCVR_NWAY=8, XCVR_ExtMII=9, 
XCVR_Default=10,
+    XCVR_10baseT = 0, XCVR_AUI, XCVR_10baseTOnly, XCVR_10base2, 
XCVR_100baseTx,
+    XCVR_100baseFx, XCVR_MII = 6, XCVR_NWAY = 8, XCVR_ExtMII = 9, 
XCVR_Default = 10,
  };

  static const struct media_table {

