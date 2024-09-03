Return-Path: <netdev+bounces-124559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC094969FD9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B2F1F25544
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63454364A0;
	Tue,  3 Sep 2024 14:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDB6FBF;
	Tue,  3 Sep 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372486; cv=none; b=Ee0zdhFMQ9hR4QPr/NPDQnSwiGeTsuj10MTNv0EXmcx6Yt4ELjpx5onx1w9SyjfM9ARebsw/K3FcNd7YgYmFG19Ht0r1S91KRkrVvzRUaLE0nbZmYwZa/VlSWvO8YJPwvnKjDPM6SFqhGCK45SWCY0QId+3ydJ9qouiCDBXe8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372486; c=relaxed/simple;
	bh=2QksUoOzs8b3y01VrtswmMfrqgCljZZYMbvmvw1oO54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlFs833fscuxZ8oTk0BujbFqrKDFe62LiOoaEYYQb8v0lds0N4PI+kSBL5aE9D4ia/w19z/j+Ht0UvBIIB6Kp8qSa8k9owK3wpbRzQmz4mNwPICd/6BhL/rpk9Bkwcy5AiIJ8xRiQLU34EiSROZcYToOL13yhhDI0nfOTR904nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so4992842a12.3;
        Tue, 03 Sep 2024 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372483; x=1725977283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SJUMYC/B/LDdyMOquinpjkUGGxPZTuewBSuACu47Fw=;
        b=Dlg2Y4FZofcSlY8XM2XWXP7i5gFG3WEMhbjfcQLxKOGNGeo4dTce8HYB4a2YIRntFq
         2VAN0g2XEw2F1Fga+w56KednJYuHeKezWvrRYdFXm2CnO/nRkvpHfHChrGgQkZd4vxi7
         vHPmPZagjMNk4j7QkcRLKGKXHfo71FOjG/1E3bZJ3xn/Lz/av3gdZY+Oi5AQe9zZinb0
         wFzC//A5mceb2aTJ0x3AkNR5DNxMVNTTru0CcQftnUSdWM4Kk2tZ70s/o0e+18lfYJQy
         kuiTAFoa3NXEGjZl/dDG6uUB1Tgf8LS0HDFaArsGoKdfBTOFRIJLUbuecnkImobO7l9Z
         mMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUK/pTOrf9AiCSv98pPDBLKWzfl60JrcsoLycSiPBKCs+0C+mjDHq/CAaeEZkQ/jMnOWJchOXr6@vger.kernel.org, AJvYcCWdzxm/+2Cx2rxWtdqVCtCBqPRr/hEZ4oKK8/3e+pN3BczW0XfUuJJfBz/81WB2raETfkYLv9KZmf5nXlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPyFCOfbEfVP+j+df5KDKfR9zo5WXk1UwYH/1MjptaHwwNdSc
	6Q9yGY81+WdAJomeR9ODrATu3mXTKJXL2I/pjLCqX85lsAL4ia8w
X-Google-Smtp-Source: AGHT+IFLqVlI44S1N0roOyi+iH03dFvs/VW2/EpxgDGh6xIeTUhfmVdiQbGMwFTjpp8Z5+ACbehPJw==
X-Received: by 2002:a50:8d8c:0:b0:5c2:43bd:8ce8 with SMTP id 4fb4d7f45d1cf-5c243bd9034mr5965912a12.21.1725372482267;
        Tue, 03 Sep 2024 07:08:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd18a3sm6438847a12.66.2024.09.03.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:01 -0700 (PDT)
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
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 0/9] netconsole refactoring and warning fix
Date: Tue,  3 Sep 2024 07:07:43 -0700
Message-ID: <20240903140757.2802765-1-leitao@debian.org>
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

Breno Leitao (9):
  net: netconsole: remove msg_ready variable
  net: netconsole: split send_ext_msg_udp() function
  net: netconsole: separate fragmented message handling in send_ext_msg
  net: netconsole: rename body to msg_body
  net: netconsole: introduce variable to track body length
  net: netconsole: track explicitly if msgbody was written to buffer
  net: netconsole: extract release appending into separate function
  net: netconsole: split send_msg_fragmented
  net: netconsole: fix a wrong warning

 drivers/net/netconsole.c | 207 +++++++++++++++++++++++++--------------
 1 file changed, 134 insertions(+), 73 deletions(-)

-- 
2.43.5


