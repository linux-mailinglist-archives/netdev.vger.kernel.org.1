Return-Path: <netdev+bounces-126508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A0971A5A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6D41C225BF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CB1B81DD;
	Mon,  9 Sep 2024 13:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DD1B81C7;
	Mon,  9 Sep 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887288; cv=none; b=iIJtMHTbgEZFuFfZDZ9+78GXFo/Dywfrws8jYxJLiZIZQIA4+ZCoS6KGnutvqurWIyfrbWm297T0OSQU6pNPLika3Xx2FUDq9o6j0gNvv/mXemDiHBAcLxxNhj9S/FJCR5wlwWPULGjzoXyHNo6axcy930pjE7fZIz/iSP4/uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887288; c=relaxed/simple;
	bh=JEa6y4jDffFE69+MhQFQQXlXGP3AoixNb30uGRg1vyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/E1rumfpb1y2FskLauTU6MiJGiCiKuxAVNFo6nX2JJrb/aGJRoaGe9Fq67LDsHJVX92liL9jk6EtXGZvAglbQ47QzcMeXdG4+MbjLTm0YprKilPKJ/AMWzbasw/3WtEkKF9VAW30vxOptZ3h67GQwxAIcYErxB4VtdxwGb3e9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so24850966b.1;
        Mon, 09 Sep 2024 06:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887285; x=1726492085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g58qUFJ099hZIXdKNoMUinp/CyYpo3DMSfp75/oxgLc=;
        b=PyXHQpgSUMonSCmp8ut+dqiHgRlLQ0trk8enozJ1cLIks7LGJ1Cjho8lu1PzeGU3za
         GJM2NJ6ISY81tcbRxf1KnimhnoIk4qZD3726YVguDTG1nRfoZT3VPwSIRfIafiwQPgcZ
         TCBEMv8OPIO7QkK1sOQpvjc6VkK1XgmArEadn/ka18SGeIraIzRzGRFBbnjYx8+xryZa
         CLxFBvq9w9R2YJhxLZNVKX9osY5fr5lROiUEMMBvNedtssaYznZltIHsZvN9FyIyi7/B
         GSx6yUQBMAmix5JyCYJVYwVvdzswvIEaboVy2ncLEvVGOJVioesfaOUKGGm1nRdw1vCq
         VTiA==
X-Forwarded-Encrypted: i=1; AJvYcCV4XbH6/8QTtrF5K4WJUDbT2ssSR9WOvaIQv0ItVRL/CNHiZX3Neg30RWzq3ydSVPs3zmdVT7hC@vger.kernel.org, AJvYcCWapSv85gd6PO1lo6A7BPN1Ml5bLIxulCsaAcE2UcT8mDvdQV9IZWOOGwqBl/KxNE58SR0yqvcoVtQmhmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HGrtYOBC+uQZW2Q72JzIBf4bN40y1tlLCDL5TQBYXMQMc1rS
	yJEnpnQ8iWhwXomPoD3BPPv1JyAeCowYeW6nAdaP6nckBK9fvGrocRPbjA==
X-Google-Smtp-Source: AGHT+IHk09uiCOP7/hKkgsay7cyHC7RMmQhMg4nn4aCJTUEBpvaCyM/6D+BZBOB7oOOghPdlIYZizg==
X-Received: by 2002:a17:907:1c1b:b0:a7a:af5d:f312 with SMTP id a640c23a62f3a-a8a887e60c8mr741649466b.46.1725887284412;
        Mon, 09 Sep 2024 06:08:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cecc21sm339289866b.166.2024.09.09.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 00/10] netconsole refactoring and warning fix
Date: Mon,  9 Sep 2024 06:07:41 -0700
Message-ID: <20240909130756.2722126-1-leitao@debian.org>
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

v2:
 * Separated the userdata variable move to the tail function into a
   separated fix (Simon)
 * Reformated the patches to fit in 80-lines. Only one not respecting
   this is a copy from previous commit.

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


