Return-Path: <netdev+bounces-18238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB5755F4A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5541C20AB8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A6A92C;
	Mon, 17 Jul 2023 09:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDD947E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:32:57 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04610FF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689586371; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b6HSklPQPs1XDa2TLe/ltGenY8q4pumpd4wWgEsTrAI0CgLpnYDfPloEr9MJAmPWlu7m2CBFoPIUmjfMse5e48QH0RD5gOz9e0Zf4puuxtet0Bg4m1HXv8srID3uRUDz6WXRItwF5tTiGwrgsoYIWOcMDtLWq5wlfrfkyRJREW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1689586371; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=9hc++BVjqtMQewgmPkHKgA5xW5K8WEGIIJOcx/Wc4x4=; 
	b=BXWkAC+Wpv3/uM4xlVlBzbnIK9nWW9A5sAhjv4kJgLpIM+s+Zzg2KvbsZsmw5lAl/iUffOXBDPO5Wa9kUAoaQ5glwlWjbY6dgScn4WAlDkdw4bqOjJf2CEd69QKR8cWjPx/z8g3OMfcCJqjtLRrW+NCZkP+B1rpIpRCdNE4fpjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=chandergovind.org;
	spf=pass  smtp.mailfrom=mail@chandergovind.org;
	dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689586371;
	s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=9hc++BVjqtMQewgmPkHKgA5xW5K8WEGIIJOcx/Wc4x4=;
	b=pbYCXPWUT0UMM5ZkVYs23rCvGzq+Zo7jmnenj8BNhtWrhuLL0KaaFNxpfgyT4vWU
	OCx+qyf2fsOgx9L/p5ftbqYDRORZmci2SiF+S5L2/MItKLwrKLHHfXuNqmXoAmfrY9s
	q446YcXmmgnRhqg/lsSZgLjWBoNKdknSMRon81OE=
Received: from [192.168.1.43] (101.0.62.66 [101.0.62.66]) by mx.zohomail.com
	with SMTPS id 1689586369710539.7091966608089; Mon, 17 Jul 2023 02:32:49 -0700 (PDT)
Message-ID: <04c8e339-1811-b069-c833-99c7ab7060e3@chandergovind.org>
Date: Mon, 17 Jul 2023 15:02:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH iproute2 v2] misc/ifstat: fix incorrect output data in
 json mode
Content-Language: en-US
From: Chander Govindarajan <mail@chandergovind.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <ce6074bd-2e72-25ef-5827-6336c081b66c@chandergovind.org>
In-Reply-To: <ce6074bd-2e72-25ef-5827-6336c081b66c@chandergovind.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Due to this bug, in json mode (with the -j flag), the output was
always in absolute mode (as if passing in the -a flag) and not in
relative mode.

Signed-off-by: Chander Govindarajan <mail@chandergovind.org>
---
 misc/ifstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..6c76fa15 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -569,7 +569,7 @@ static void dump_incr_db(FILE *fp)
 			continue;
 
 		if (jw)
-			print_one_json(jw, n, n->val);
+			print_one_json(jw, n, vals);
 		else
 			print_one_if(fp, n, vals);
 	}
-- 
2.36.1.299.gab336e8f1c

