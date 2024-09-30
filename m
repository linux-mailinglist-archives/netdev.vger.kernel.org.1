Return-Path: <netdev+bounces-130373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7C98A467
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F3C281C7C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD818FC91;
	Mon, 30 Sep 2024 13:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4501DA4E;
	Mon, 30 Sep 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701941; cv=none; b=P/f+kU+BZHcdaW5pb+l6QIEoxXzm1xUsqs/8powXnuhXwOPbDTltwhOs60uyf1kqirKE4ZbeEJ1I9QszDdNeFFwDoGb6hHhmNdE//Z8rAEq7WNoIJfHQMYRP1yq1hrlT6214G7KQ6gxTxQgMxkNfqxEmfLNAFsxPJmAtJlR0ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701941; c=relaxed/simple;
	bh=C4XawccF0VSzYH9awHDSmMhdKHu5R94r9UOvfEYSALU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HIJ3ttEGgMdGKM1Xg16dTgARoaSC5md6QSx8cvf/itsFRVjE10yXNDfElhW2WcbjMt1xawxUQ8zmlkB+C3BGQREwmUngHlxiL9iSxOQP4CqmmE7CMet06kCwDhHdMdiJZGppLZ0c3U7DMOW3CQbk11648v5IfVejaT2HpIcq6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8ce5db8668so772575466b.1;
        Mon, 30 Sep 2024 06:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701938; x=1728306738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1nLBdi7487Zfg4WCU8FTbDUdtX7xIfd1ygDpmzRDh8=;
        b=mIomz6z2tZxzcbOgg9RYceLqX5Wsadf/zmdcZUOIb39uiX+Ee4/g+KwcrRMYhChLML
         IVulm4byNZXmXztPmiwS0KttS7S+NPV9l6+tkcOPGn+RJ+tS74qC+ALj0K76JGquJSQT
         eEFw2xhjWWurvZNf89XbM47ls7pzOOAHNg5+ELUB6DhPP2aEDomqv70ASuCK8IN4Fxia
         K5ziY+9occrttEV1N2MqCxfPpFsSyuXS0M/NlA6tznNAdTjKs2Y47MaJLVlotZE+ljHz
         WDI/pxLk1ARrcSn2ynmyY0LkbKiI6bxP9WzbnKw4MJXFclf/uD1jQe/9C3wY4sOUudN3
         jvOg==
X-Forwarded-Encrypted: i=1; AJvYcCUdW0omadRbKuUmRyf4cEElP7fjLw7IpeMj8td7MI+5kRyhZgmpAU1I3mJvLfojTUJuvv0ZOra7HJU3YYc=@vger.kernel.org, AJvYcCUl+fI0MPFc7oAv0AEiRKukTCbBvR7mj9JYFMw34GhFYpPB35OJ2s4ChZHD1fIaaTnFc7KQkMDA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqh6ZwrTs1eFHOVTHIDAkIs1upFvgDsrkEVIJU8BTaJZ4QuN0P
	DxlxCvrEi6dbsrmbiGwKN157zIMYfY9MR9nXoXZADMDhSxbwI79w
X-Google-Smtp-Source: AGHT+IGN32sxgW7AOZYwRiRXoIh7VQzMLZhcvXpuOqP6MjyUFEFltoG7yhwghcyWbU2XWe25ppWFjQ==
X-Received: by 2002:a17:907:3f17:b0:a86:96f5:fa81 with SMTP id a640c23a62f3a-a93c492ab08mr1255743366b.32.1727701938031;
        Mon, 30 Sep 2024 06:12:18 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2996631sm524410166b.200.2024.09.30.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:17 -0700 (PDT)
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
	max@kutsevol.com
Subject: [PATCH net-next v4 00/10] net: netconsole refactoring and warning fix
Date: Mon, 30 Sep 2024 06:11:59 -0700
Message-ID: <20240930131214.3771313-1-leitao@debian.org>
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
v4:
 * Pass NULL to userdata in patch 08 ("net: netconsole: do not pass
   userdata up to the tail") (Simon)
 * Do not try to read nt->userdata_length outside
   CONFIG_NETCONSOLE_DYNAMIC in patch 3 ("net: netconsole: separate
   fragmented message handling in send_ext_msg") (Jakub)
 * Improve msgbody_written assignment in patch 6 ("net: netconsole:
   track explicitly if msgbody was written to buffer") (Jakub)

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

 drivers/net/netconsole.c | 205 ++++++++++++++++++++++++++-------------
 1 file changed, 139 insertions(+), 66 deletions(-)

-- 
2.43.5


