Return-Path: <netdev+bounces-268196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNs4N68muGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:50:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4334A29CC27
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C268D308A164
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7783A4519;
	Mon, 16 Mar 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vSCeAY/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00E3A1E73
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675868; cv=none; b=sd9M2W4HNR+ewJWwd2UmIvhaikVSQZBlCvQ++UKd5qk6CsWWUHfPa41rFg4+sLj2AhKLxZd9H8sjbsjvwGuhDYEs22d6anmanYJSmR3LH2UPn7wy5gK9V+AsOO9u369EZ3cSnrhFr5AXXn1+PQzFu6lrzbCh0ltmmLKjlHsJcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675868; c=relaxed/simple;
	bh=ipQs/pnOj3C+qN131d1fldvdWOQBtYc0/dhAsl74UM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn097hfaN4svqBhVx9Y1rtv86A+nQeZ8bzb+BqmwCmmG/ZLwWxBNODPGPnbUGLzRHz0O1nqd9VVaMmpgjeo/8w6ahUpP6LAZukLdqtStiKjyhrkr8BLCYHTyriueq0oL4K6M9nUssW1Fzi17wUXi6pnBaGLy30iyPTIWPk/eX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vSCeAY/5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so4666786f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773675865; x=1774280665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddfRTEAvGKSPvnCWeMTeF8TeOJoffU721DP6/2wjZd4=;
        b=vSCeAY/5rUQOkWOaa8vj0HQw22hr0GOUcNUQz+7JMYRn65PsXMj7l224HjkpRTfigI
         EOPVIGzTA+U1GjSM4eR5MlP/KKJKflm5yZ4qSLHIzXd7Hwdt5kawlZw08GaOoV0zqvlD
         aOmSRrOHBl/KlAA3dyv2cz7yCYoqZob8pyjmjYveUG907tWZuvcmGbfhHduQQumS0Yov
         LR2agkHwlE69INFeKpsaKGnuMt/Pc2IxzKlkNM7M+Kx2D4/8JKwwc20WJncUVVFHoK4D
         8hw1tUPmESu/+9leafiN0sKyl2WcSs+LKT5F5oVex5s3UgudN+0cNsUoM9dsuyBdnrUI
         ktXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675865; x=1774280665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddfRTEAvGKSPvnCWeMTeF8TeOJoffU721DP6/2wjZd4=;
        b=I4yNcNMA75/jMV4fbInQ9+AKcFejGiEG+Yuo15BaTD/kmKe3+U1Mct6Jo8EaRJQeEs
         kyXGxZHvXSMqGvRwPwOysK4OruQEoa85eC7z++aovw2ofq+WGs+pivlUn6kKAu8lQYMS
         SqLcRNoN7WIDqI/leQsaLEKIkfrSf0iWVl4yO/yrRZQl3Duzuqfm3dfZXqzZ3w2EHy/F
         Ua8UB5XO6WIUtAbbZrbj5CgjGFsDHl/Cq+92lCUhjynWTf9FzwtpKgz1Q0vRBfH1IYBs
         mnQJ1nvRSL+Zv6CLZRsx6JJbkJKrNUnEqXmsMOWMDlhoJbRSIWcKQJ9E60N8O1qQH4ho
         74Uw==
X-Gm-Message-State: AOJu0Yyyp9IQjx7O2zRsMAnpbdH8xU78+1oqTpIBO4BkwTQX3IjcEGPw
	eH0i2hYu0VTTuCer5IwrHW9lPxPa1KEJJz069/L8v4wOCxvY9Eh9fB5UA0TbE3biw1I75eMxXZ0
	qMBJY9A8=
X-Gm-Gg: ATEYQzwfm+Yiyfc/zH9fz/UQXPFQmU0MP6wXAZtfrzb0DQRiqj9cNdcWHStfUh7bqx1
	oWAcmyJxx6pK04RgTPNrvKErx6DU8BN3HEeqUOgfm8CzmYjeek/WLGRyQi9FAji1L5PngVZPOUs
	2ksXidQqsPaIKLN+DHD1HzWTwtmKQQiOwtkKbVtkEE5gZQVj4cPHj2JcBF66sC5hnneTMsLzGzk
	YeB1Zl34skRQz4VUlmR12gPnWhOM0IyJy9TWWw/6TohoBeFejRNYPM5B8gRzEDscLspLIgdHQjB
	BRaRR8/gcOExxY8U+iVLmte8xmY2ec1RdSoi2fP2IdAZtML2676m/ASqYaYAzpZiWn81n1qycLM
	dzmW4QkmsjUk6mQ6nkVcTRMx21JIVJHC/x80x5vpyq2985zckudX9TmmEWHKWIdMsyP70MWUgJI
	AL/12x4uBHp9AUFkeV5A==
X-Received: by 2002:a05:6000:2385:b0:439:b114:60c0 with SMTP id ffacd0b85a97d-43a04db6008mr25880981f8f.35.1773675863471;
        Mon, 16 Mar 2026 08:44:23 -0700 (PDT)
Received: from localhost ([213.195.231.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm44939332f8f.15.2026.03.16.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:44:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [PATCH iproute2-next 3/3] devlink: show devlink instance index in dev output
Date: Mon, 16 Mar 2026 16:44:18 +0100
Message-ID: <20260316154418.625026-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260316154418.625026-1-jiri@resnulli.us>
References: <20260316154418.625026-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268196-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4334A29CC27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Print devlink instance index in dev show output when
the kernel provides it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 39b0fac098c8..730515a78950 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -4095,8 +4095,12 @@ static void pr_out_dev(struct dl *dl, const struct nlmsghdr *nlh,
 {
 	if ((tb[DEVLINK_ATTR_RELOAD_FAILED] && mnl_attr_get_u8(tb[DEVLINK_ATTR_RELOAD_FAILED])) ||
 	    (tb[DEVLINK_ATTR_DEV_STATS] && dl->stats) ||
-	     tb[DEVLINK_ATTR_NESTED_DEVLINK]) {
+	     tb[DEVLINK_ATTR_NESTED_DEVLINK] ||
+	     tb[DEVLINK_ATTR_INDEX]) {
 		__pr_out_handle_start(dl, tb, true, false);
+		if (tb[DEVLINK_ATTR_INDEX])
+			print_uint(PRINT_ANY, "index", " index %u",
+				   mnl_attr_get_uint(tb[DEVLINK_ATTR_INDEX]));
 		pr_out_reload_data(dl, tb);
 		pr_out_dev_nested(dl, nlh);
 		pr_out_handle_end(dl);
-- 
2.51.1


