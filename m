Return-Path: <netdev+bounces-18237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35C755F2F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791D21C20ABF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D9A927;
	Mon, 17 Jul 2023 09:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412879474
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:26:15 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F8C0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689585970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i89SSA5gdj0T0qPiw7Zh7cwvLGywF5cnF2x7BxqbJteVJSmDk/WoK9O7uURRWxOVhtRBSG25zMMGbAyHLRt3BtIOrOJD+Q3uTG1FCWVrE75FetGgzyGpxmwA1lRgsBViGHDNwAZhiMQOB8vKlflBwyI7kLsVd07JqhRxiXUuSS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1689585970; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=KSZBpq/23JNZIa5WsoaMTiDqk2ETWDQ/FSdKzYzR3Vs=; 
	b=AdW5SFTBlyrmwxgiqdoEc9t3TyHabBEcVcwYuzkt78fnBYh1tUaGGfxD3WOHdEbJIKK389DBHzaeQE/S3VVRvoMWGJrWbzcM1C0ROIkDzzRyY31e+Gbh759IfXzuQ568tN3xGWkiBjwh2AiTeHqatnrFPm4+meToRAvC9sj33nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=chandergovind.org;
	spf=pass  smtp.mailfrom=mail@chandergovind.org;
	dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689585970;
	s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KSZBpq/23JNZIa5WsoaMTiDqk2ETWDQ/FSdKzYzR3Vs=;
	b=rKXnw0XgfhJX7xcWnPMl+YYFijRVB3OtO/esctSd1LUZ0q3EsEKfucro4ijHPL4x
	hOTuhK6rsqzw4crkpRcJCBJbfd7h2tAazl7BAPAJqcr8ubFekQWCZTB+E0iCvUzswRu
	0o8+0bKl/IGN1w+3Pff31/693Cbx5UXWnw8dtYe8=
Received: from [192.168.1.43] (101.0.62.66 [101.0.62.66]) by mx.zohomail.com
	with SMTPS id 1689585968939805.7922169918038; Mon, 17 Jul 2023 02:26:08 -0700 (PDT)
Message-ID: <26a5d195-5b42-dc59-68a2-2e3235ffaba8@chandergovind.org>
Date: Mon, 17 Jul 2023 14:56:04 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH iproute2 v2] misc/ifstat: ignore json_output when run
 using "-d"
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <2d76c788-4957-b0eb-bd5f-40ea2d497962@chandergovind.org>
 <20230714090425.76cb96f2@hermes.local>
From: Chander Govindarajan <mail@chandergovind.org>
In-Reply-To: <20230714090425.76cb96f2@hermes.local>
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

If ifstat is run with a command like:
ifstat -d 5 -j

subsequenct commands (with or without the "-j" flag) fail with:
Aborted (core dumped)

Unsets json_ouput when using the "-d" flag. Also, since the "-d"
daemon behaviour is not immediately obvious, add a 1 line
description in the man page.

Signed-off-by: Chander Govindarajan <mail@chandergovind.org>
---
 man/man8/ifstat.8 | 3 +++
 misc/ifstat.c     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/man/man8/ifstat.8 b/man/man8/ifstat.8
index 8cd164dd..2deeb3b5 100644
--- a/man/man8/ifstat.8
+++ b/man/man8/ifstat.8
@@ -16,6 +16,9 @@ by default only shows difference between the last and the current call.
 Location of the history files defaults to /tmp/.ifstat.u$UID but may be
 overridden with the IFSTAT_HISTORY environment variable. Similarly, the default
 location for xstat (extended stats) is /tmp/.<xstat name>_ifstat.u$UID.
+
+The \-d flag starts a daemon. Subsequent \fBifstat\fP invocations connect to
+this daemon to fetch statistics.
 .SH OPTIONS
 .TP
 .B \-h, \-\-help
diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..08f0518b 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -888,6 +888,7 @@ int main(int argc, char *argv[])
 	sprintf(sun.sun_path+1, "ifstat%d", getuid());
 
 	if (scan_interval > 0) {
+		json_output = 0;
 		if (time_constant == 0)
 			time_constant = 60;
 		time_constant *= 1000;
-- 
2.36.1.299.gab336e8f1c

