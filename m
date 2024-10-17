Return-Path: <netdev+bounces-136496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C449A1EF9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717D61F22391
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F61D9A59;
	Thu, 17 Oct 2024 09:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD8165F08;
	Thu, 17 Oct 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158653; cv=none; b=jKSKe9gsV9vU+u2uLWBWbuHB8Ep6KG1m+7VGgAgja9LHF92Yy28dp6pWcxRvHvRnWBpZz4/GzuNCFYKx91C1cen9TCwf1k6s97yUthjSnGMb0oJYWVxfFvWYyHI1VpdkDOea9/I+Ou49wSTy2AjNAc5ifeO/KdkSPE+JGmwKh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158653; c=relaxed/simple;
	bh=L2iZyYNzU5n0vMmFAaG9I2sAgUj6MrJPfvyqjwuin7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MTVL3hr/RSIC5/XhXdmlHRq42LNpqABoz/8ikHkXWyEcjqKo/kiASMNDEOijaZj3R1ZPc8nrbCbJbJeiKrFPB7lbUrAuISM6wJxaQ0SUitktiviiAm7CxAHiefQ2UZFloZde+eLzcfJkKU8R/I5sMcxkYby4pplZwV4gvYd1paI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so9616881fa.1;
        Thu, 17 Oct 2024 02:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158650; x=1729763450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YH0bb/VsAy0uWyC1771z0ENOP+IISgwLjVL9e394kY=;
        b=f/kVzsJWTq+koF+G2uoHXXNzPj6F9fi47CFJnMIXjGplNFN2QLRt0ZAlD1Yxqdmwwo
         6MGAIiIyOFxqmbnI1o4JJwIkXJoqcqN+l2PXK7pcglb7J405JdTeGCY/PaoTqxn3cZQM
         AVNvXP2xDXPVgq+B9rt1B1N9HJg15FuBiwSQ6lpQZlotLRlSaJs2Ja5nFqOPyCq60aAe
         kVokQ/QTiZb/OLpmlYwzClG6Ei3YJayM6/HWzWTzhywiW4iPlouYyzeCFcr663AEzskm
         yAhAmjziKrRHTZWOOoYG6NZ6I3AEkuzU6Y1JjTgVOHUfuH4m1N1110eWcR2l8IL51v0p
         /SQA==
X-Forwarded-Encrypted: i=1; AJvYcCVivILWr3yAypfQCcD/yYqbUA+yrvYe+BnXcF9w6ep+ktRxGlgG6ZuS+4T03M9IYL40vBIfzd1lAneIKac=@vger.kernel.org, AJvYcCXcVcoV0rxvJlQlAdQZh4xQobItuZrVv+9U3ns6j5D5QoHOnUH+fgdZMkd5nYtNrQNB6gx/P8eV@vger.kernel.org
X-Gm-Message-State: AOJu0YylHbl5cP0KtFFNKgDW1gOnzKncQKAUMILM3TDz4dhlf9wMFr92
	zpYmGyPv6Km/ZQ0EJUkUB3+xyzaK46gWqp5QHw1M/1vPb0GSf540
X-Google-Smtp-Source: AGHT+IH8PD+FFVnvIIekbt1so5+Oy8KFjqg+MMuqSzWgVmFRB18TwVY3j69Rj2toznWO1qA3NwCmRw==
X-Received: by 2002:a2e:a9a1:0:b0:2fb:5bb8:7c23 with SMTP id 38308e7fff4ca-2fb61b8a505mr40422181fa.26.1729158649349;
        Thu, 17 Oct 2024 02:50:49 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6269sm2605245a12.2.2024.10.17.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:48 -0700 (PDT)
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
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 0/9] net: netconsole refactoring and warning fix
Date: Thu, 17 Oct 2024 02:50:15 -0700
Message-ID: <20241017095028.3131508-1-leitao@debian.org>
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

The fix was already sent to net, and is already available in net-next
also.

Changelog:

v5:
 * Exact same version as v4, except that the last patch from v4 
  ("net: netconsole: fix wrong warning") was already landed into
  netnext, so, dropping it from v5.

v4:
 * Pass NULL to userdata in patch 08 ("net: netconsole: do not pass
   userdata up to the tail") (Simon)
 * Do not try to read nt->userdata_length outside
   CONFIG_NETCONSOLE_DYNAMIC in patch 3 ("net: netconsole: separate
   fragmented message handling in send_ext_msg") (Jakub)
 * Improve msgbody_written assignment in patch 6 ("net: netconsole:
   track explicitly if msgbody was written to buffer") (Jakub)
 * https://lore.kernel.org/all/20240930131214.3771313-1-leitao@debian.org/

v3:
 * Fix variable definition to an earlier patch (Simon)
   * Same final code.
 * https://lore.kernel.org/all/20240910100410.2690012-1-leitao@debian.org/

v2:
 * Separated the userdata variable move to the tail function into a
   separated fix (Simon)
 * Reformated the patches to fit in 80-lines. Only one not respecting
   this is a copy from previous commit.
 * https://lore.kernel.org/all/20240909130756.2722126-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20240903140757.2802765-1-leitao@debian.org/

Breno Leitao (9):
  net: netconsole: remove msg_ready variable
  net: netconsole: split send_ext_msg_udp() function
  net: netconsole: separate fragmented message handling in send_ext_msg
  net: netconsole: rename body to msg_body
  net: netconsole: introduce variable to track body length
  net: netconsole: track explicitly if msgbody was written to buffer
  net: netconsole: extract release appending into separate function
  net: netconsole: do not pass userdata up to the tail
  net: netconsole: split send_msg_fragmented

 drivers/net/netconsole.c | 197 ++++++++++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 65 deletions(-)

-- 
2.43.5


