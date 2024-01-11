Return-Path: <netdev+bounces-63126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96582B4DA
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ED91C25F34
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0437433D9;
	Thu, 11 Jan 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="B/A4IE0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB553E06
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dad22e13dcso3854326b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704998702; x=1705603502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5Qf2MfhYm7DJdrZK8IKsKOHdgH8VUY6AQbfGQfczZE=;
        b=B/A4IE0slO7CmwBIrTDE/EIIKYFLZBHVi79VzrcCEEQBZeKp9N1jCKmrdkpO0/1ght
         8d4jL9m5FF17GjIO22DkpJvlj8zeCitoCGIy5YAzOAVHymnMJWIO9FlNhRiEzz88NXLh
         yNZ+gvnQ83TpgFZCcQUAFGTL7q8ytLv7REfgU2qjGUVmQ13EwH/2q8lRfyjO1V0k3y9V
         c6Ytn3TRYj1NE64QVLgUx1UZSwuO7SKiPQujWIbLwHjFJGsvbp6K6GBza8ziZ9ljKxWn
         soVEOjg/jug7R5oH1EoVmM/bF92S5TODvr0mqaOmhfXBBMEbrPuVIam3FHK1TDJ+G8HW
         RsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998702; x=1705603502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5Qf2MfhYm7DJdrZK8IKsKOHdgH8VUY6AQbfGQfczZE=;
        b=CRcw2JAyjn7NIArxxmxltjFyRnOORster2qX5ksO+W3HKbSaCZEr3WbXlM1zyjxDGw
         +0TPJ9iWLogMkq5vxy3NkMZaq8xI6t3/L7J3+DMhq4A9eTZ3fl3rKcFaAIiRHlhlkmjM
         pTNpOCjz6zPxZnnhcYHHnmXw/4V/FGUmbh94OfN2pcxojy8UXnxu3uM1a6myGWXPRzBX
         rllA0clt57yf60wNil0Vd4/hsQjRnK8U0vXjZERCvlabn4M+TyvdDqAxfYV2s5WB1jS7
         0HxTgZ7TTg2d8KG3W4oWymmKEukXTqZkInjjUh34RJibc1MdaJfxdgEbMN5PfJpqHzzS
         qPjQ==
X-Gm-Message-State: AOJu0YwYICDONTxn5Y5qZuI7XDYQJEMJBpWbyipteCB0LXEVasiGW+55
	/VCm0r7z2h+Ky/XWvPRUH+Us+wOxWZyvJsoRIuSOaoFw3qJapw==
X-Google-Smtp-Source: AGHT+IFy0TRenOfUIJ/hs5BCYmlzvbuhyuAnpeLMvoN3ud19BHqeT6lvU1KEglVzipXYxHex9+80AA==
X-Received: by 2002:a05:6a00:a8f:b0:6d3:a9:51a8 with SMTP id b15-20020a056a000a8f00b006d300a951a8mr195178pfl.59.1704998702071;
        Thu, 11 Jan 2024 10:45:02 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm1513460pff.71.2024.01.11.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:45:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 0/4] documentations cleanup
Date: Thu, 11 Jan 2024 10:44:07 -0800
Message-ID: <20240111184451.48227-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move what is relevant in doc/actions to man pages and
drop the rest.

Stephen Hemminger (4):
  man: get rid of doc/actions/mirred-usage
  man/tc-gact: move generic action documentation to man page
  doc: remove ifb README
  doc: remove out dated actions-general

 doc/actions/actions-general | 256 ------------------------------------
 doc/actions/gact-usage      |  78 -----------
 doc/actions/ifb-README      | 125 ------------------
 doc/actions/mirred-usage    | 164 -----------------------
 man/man8/tc-gact.8          |  85 ++++++++++++
 man/man8/tc-mirred.8        |   8 ++
 man/man8/tc.8               |   1 +
 7 files changed, 94 insertions(+), 623 deletions(-)
 delete mode 100644 doc/actions/actions-general
 delete mode 100644 doc/actions/gact-usage
 delete mode 100644 doc/actions/ifb-README
 delete mode 100644 doc/actions/mirred-usage
 create mode 100644 man/man8/tc-gact.8

-- 
2.43.0


