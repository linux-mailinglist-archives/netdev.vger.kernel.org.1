Return-Path: <netdev+bounces-62338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E9826AEE
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36463281A02
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E84125C1;
	Mon,  8 Jan 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EhMAM4BZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487C12E6F
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-2cc7d2c1ff0so16917601fa.3
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704706864; x=1705311664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/6mv7M/9Vs4VYVJ08PjYz2RSrtqgkfuN5+kQVSNgFs=;
        b=EhMAM4BZvVdwKVFBZrVgJAjw8TuvBFD6XI5DysjMzsEE6qaJNN8qTR5kvKgp8W7cGo
         3lLPHWfiUU+xghQoq6kizlxP/xLAJZV04rHc4HuJuJqTPbE7EvudfJamLObfD3k9sL7h
         0VNVt8vGuvfyS0GCr7mbit7qkfvVJVlVeexLQwTTVRn7HkU40zBgTSRGcyZAxwUnb1cb
         6XmvbSwITz+wRn5HfZhmtlYZLl5l50hzzI+kiRrDZz330IkFlJubi+U2CSgzlzYdrIo2
         XUvvTla1mpaXZqWc9Q1T/eAaGgP2KKFeM0RqaWMtuq9iFWYT5ELeO1n6CceLWOkcqxKf
         iFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706864; x=1705311664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/6mv7M/9Vs4VYVJ08PjYz2RSrtqgkfuN5+kQVSNgFs=;
        b=I+Rv+lTWnAL6srQwt3HNEa3UMW59hos1C6LCjc6b1xpkWEUmokcE1XPe72oebNDv9q
         CXqgEvzgSNUBXkwDZGwjd66yyxXRbbBwpR/ZHzb3lmbQ0FhZ8rLSKclujconrFfB0/aO
         tpqPmDkv0WyVuFtfaCvgaidbBTix9suCyJbshPqLliJQ+8CSE3yyRiDD5TNbd0OSsxD1
         JpqZoxoEitQWI/16vJw4x7ZgJOToRSRhS5Gz0oX+1TSw1RjHPyTRMuHoG4Z5rbXjGpYI
         vqelRdPOWlsSSFC+e3x3OTuIN1Gi28hrAFhGlsixd1rgnKQpIl0EWojVPPQD/XgDiuZZ
         Mekw==
X-Gm-Message-State: AOJu0YwCGgnlSSqNQWhTC3WFdElPBriaYlcFD26Nr7fVbiTwdY2TtZ1K
	so+bRNz+Por8S6R+k6mWtVXRuRALx82cdQrjmvIay5kU1KUWZx0Nn6J7EQ==
X-Google-Smtp-Source: AGHT+IGtoO2KtaIGk3jVFY/cdYYqwxN3KU1H2nV4ln4ezM8TzaGAM2lFb8sH5gSvWetpmVqhYR/S3C4o8hVG
X-Received: by 2002:a2e:94c7:0:b0:2cc:d574:6057 with SMTP id r7-20020a2e94c7000000b002ccd5746057mr1535959ljh.73.1704706864618;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id j13-20020a2e3c0d000000b002cceede42d2sm250760lja.66.2024.01.08.01.41.04;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 3A04160100;
	Mon,  8 Jan 2024 10:41:04 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rMm7z-008OeE-UD; Mon, 08 Jan 2024 10:41:03 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net v4 0/2] rtnetlink: allow to enslave with one msg an up interface
Date: Mon,  8 Jan 2024 10:41:01 +0100
Message-Id: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a regression, introduced in linux v6.1, by reverting
a patch. The second patch adds a test to verify this API.

v3 -> v4:
 - replace patch #1 by a revert of the original patch
 - patch #2: keep only one test

v2 -> v3:
 - reword a failure message in patch #2

v1 -> v2:
 - add the #2 patch

 net/core/rtnetlink.c                     | 14 +++++++-------
 tools/testing/selftests/net/rtnetlink.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)

Regards,
Nicolas


