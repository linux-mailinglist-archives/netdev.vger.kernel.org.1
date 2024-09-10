Return-Path: <netdev+bounces-126923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C33973107
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB59D1F22562
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC318C03D;
	Tue, 10 Sep 2024 10:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D414D431;
	Tue, 10 Sep 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962662; cv=none; b=ut8Ex2F2Vwv5BhHcIW35l1DS17G59l1serfzDDbRVcz8r577HfjEv4G2WWCwG69Ic8Mow43LkcTIX6LGsUncNe0L5D9IeuX1CkqTyNranEeWvlaWJ01Fe2RDcyGI5UPr3rsu3Z6wBFkqMW308fkzujgcZVakf45sB6QqLDmUiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962662; c=relaxed/simple;
	bh=95oZpFaGdT+n4AZv5eSHnzRAEcN6F31kOCCWx2NuuHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWMouFUaY7YNCtKzgIHCQI/05EhQFBnZa9FexlOJrK8JMuFvdZgabdFGB14yRLDgAECjK0VGzaOoPxavXl4OkMmOM/u0Dk+zDjVZ//E9phY4n/eTsyBNkBydjCNjc+kyJOzRrXqE9gjuvWrff/n9Nx92xIFyqttBwosXpQ13VQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso63895455e9.1;
        Tue, 10 Sep 2024 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962659; x=1726567459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsRLUkVFmf9olbGB1o/ibUldWoNaR0g8xtOS4a2+kao=;
        b=me2OFqOCGysFXE2dETqoGgnlo9qA6JE9FYkNV5/PlAN3EhE4NnPO46p7BRYOfn0M8J
         bP0wERGPsNNgTBT5JbhJK6KhUYdaOFA7P8GXsla2ByAoCkDQLBgfw5BQEGcb+Z1nh8A6
         RF2rjMdCmqYAidQ4EkkPLwA4RjDSy9hqH2fhb1PvSTpF0FFT7c7Henklb/7i2uXpLvJY
         MCc4CdgAqDud4vvheiCy9IkEc0XWl6d//S7v2/bfNl7smdxpaTAipUXW+xT394Xi4MIX
         uCQ6lg0Uq4cJQ/O2Vt+Z9f+OiXsFfP0HW4iNW3aiTMEXX0E9lw2oXRc7hJszH/UV2081
         3SQg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ai4z3vCsT0rExU6U8yD0EDat6Fh7d8KqsT69LVHE1qLcA7Nxsmif16lQraw5/fz1wWd2nf2s@vger.kernel.org, AJvYcCXZfS6OGEYgsJwxan85lfkG9klB8QF+X/BkuJnyqf0NDl5tWESqKMhTxD+F6PJiQxZCDBRr6joARCnO76Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSbo6mkfJyUmmM36za2NlGMjM+2a7ksSJup87/d1H8510/CX8
	cc+BtuNUxfwgX2Gkd7Go0lbhnS+dwEqE0BkynTSWKfFaSxxhnWqg
X-Google-Smtp-Source: AGHT+IGXrnjZI/oOa8NXFUtM6aGaQw31QV3ohiIbd4e3pm2LJ1RrTeO6Bb7ft3h/Pdl6j89mFg7Mdg==
X-Received: by 2002:adf:f2c9:0:b0:374:c3cd:73de with SMTP id ffacd0b85a97d-378922b9b93mr9793336f8f.35.1725962659169;
        Tue, 10 Sep 2024 03:04:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cea3eesm461465866b.145.2024.09.10.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v3 00/10] netconsole refactoring and warning fix
Date: Tue, 10 Sep 2024 03:03:55 -0700
Message-ID: <20240910100410.2690012-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The netconsole driver was showing a warning related to userdata
information, depending on the message size being transmitted:

	------------[ cut here ]------------
	WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
	 ? write_ext_msg+0x3b6/0x3d0
	 console_flush_all+0x1e9/0x330
	 ...

Identifying the cause of this warning proved to be non-trivial due to:

 * The write_ext_msg() function being over 100 lines long
 * Extensive use of pointer arithmetic
 * Inconsistent naming conventions and concept application

The send_ext_msg() function grew organically over time:

 * Initially, the UDP packet consisted of a header and body
 * Later additions included release prepend and userdata
 * Naming became inconsistent (e.g., "body" excludes userdata, "header"
   excludes prepended release)

This lack of consistency made investigating issues like the above warning
more challenging than what it should be.

To address these issues, the following steps were taken:

 * Breaking down write_ext_msg() into smaller functions with clear scopes
 * Improving readability and reasoning about the code
 * Simplifying and clarifying naming conventions

Warning Fix
-----------

The warning occurred when there was insufficient buffer space to append
userdata. While this scenario is acceptable (as userdata can be sent in a
separate packet later), the kernel was incorrectly raising a warning.  A
one-line fix has been implemented to resolve this issue.

A self-test was developed to write messages of every possible length
This test will be submitted in a separate patchset

Changelog:
v3:
 * Fix variable definition to an earlier patch (Simon)
   * Same final code.

v2:
 * Separated the userdata variable move to the tail function into a
   separated fix (Simon)
 * Reformated the patches to fit in 80-lines. Only one not respecting
   this is a copy from previous commit.
 * https://lore.kernel.org/all/20240909130756.2722126-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20240903140757.2802765-1-leitao@debian.org/

Breno Leitao (10):
  net: netconsole: remove msg_ready variable
  net: netconsole: split send_ext_msg_udp() function
  net: netconsole: separate fragmented message handling in send_ext_msg
  net: netconsole: rename body to msg_body
  net: netconsole: introduce variable to track body length
  net: netconsole: track explicitly if msgbody was written to buffer
  net: netconsole: extract release appending into separate function
  net: netconsole: do not pass userdata up to the tail
  net: netconsole: split send_msg_fragmented
  net: netconsole: fix wrong warning

 drivers/net/netconsole.c | 206 ++++++++++++++++++++++++++-------------
 1 file changed, 140 insertions(+), 66 deletions(-)

-- 
2.43.5


