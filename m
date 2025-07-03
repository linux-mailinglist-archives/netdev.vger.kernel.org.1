Return-Path: <netdev+bounces-203936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941EAF833E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F5B3BC5A4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81B2882C5;
	Thu,  3 Jul 2025 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s2ckkjAn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD832DE6EE
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581343; cv=none; b=RrndohvdRbQKM/O2JafLAl7dAJ0qKOuy8H3P4cpcB796+JZahQb+NV3qfkWm3/XquXDkd6kfnUVKpy4boRzSr+tiwB7KsFpemxF36Ls4oGQy83fUStZVvZsun+C/TWyhP+5oSCR+5k6Nxi5sdg+VvosoeTcQq0vYJz9EI2WCHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581343; c=relaxed/simple;
	bh=D/PppK0hDftWiCKNXNsgHrcA+jFHhAFOCWiRLOQNwOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzYkYSk96CiStq7IUAazqsuIhGh+2mlTpGNT+WNAjL7JywRwEcOZjOELbEaSir7X+vhgZ0fIUyTOivGGXZ2JE30QX4oFcXNzG3hRDwpiyiDfEK5ZpGbu7kln0emu5mjjZzDN/YqeMmmfolxAqiLSVZHmwviF+Q49+TdymnrD1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s2ckkjAn; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C71F3F66E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581338;
	bh=47Hy/CVM+m+STHABdIjCLud+sfTnWYA0RBiwXCk0B4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=s2ckkjAnQ8geo8jnMHv81qRCHBVTOqxrT6j+tI5nEiwQ0sJMGioJlce5b4aTMqNDt
	 sG6HEdv77pd6Qg8PKqNZBetCoAXZ3TODdnw27xYy9358hRcuO98sEDitBxpwBpyljL
	 yo0YxtA+ZXXdNASxl0R5GutoolWy2cOR+GTFZG7JevVE7p1rM7oIwG120HNbgAXpg6
	 KpK2Z5sBOVuIPO0oqdmw0BzzMVMwLpkHX/sdE3DRj5sXdg6ekUkvROfMGU9jC8Fq/J
	 cRD8WbZcb+yr3ky6YXRDqLmC+hnjceOZWS1NsgLauZJ4qiHi2+AJ3oYFzFqDwn3Gpb
	 X3fn9i/3Rns0w==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a1701so190010a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581338; x=1752186138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47Hy/CVM+m+STHABdIjCLud+sfTnWYA0RBiwXCk0B4w=;
        b=khrXINL4m2nMOArTe7sClDxZBpzIGMb8MqZXz8LifWTwQnKbeoI4n4I70mkZraIzQC
         O3YPf66ol2nkeP8mJ0KZtMWXmhknRbDRe4upi1PdiwIdGcUsceCYgUqFuJX5YGvsD9Vi
         IaCwN3mjpAXI7MqZAQI5uU+/QyTLprVwH/iPS3cHozOW9dW/75mYshjGEuy/xtWbAF2b
         A56DCzW4one33w8CQsM3WaWG4yrkRBqtGjo2f1b6qPgZuuDwQQ1KnFYKbnseNjShE5GO
         qyxbirlVxgI64pa0op+QENlBTXkALGKwUt+zs3NuCqaljbdf7MhKZZTBADlB4Q5DA4/g
         suEA==
X-Forwarded-Encrypted: i=1; AJvYcCX5ha/DxSWWgHRYszR4MIAMJQqZqH9QF5U2tJpi8z73WQOw77Tc8O7cYDRcaPcwgkUOpO5cIE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSkGzV20JF0TRv1x95aIEndapqdNYIPKGfcCqn5DwWWboNS5R
	fj5oh/hAYng6ytnZDLBr+inIriF2lZT5oTS54FfxQ8PrCh3WsKKw1yMrdysr97tv9vgsULEXlI8
	97Tyhqdf+aWsxb6iJZ8iKF3OFbZF5/ovKP/qsW7uDFc85+0jE1YwtD3VUNOrsQY5AWGPP8S4iCA
	==
X-Gm-Gg: ASbGncttC881Hnz2EKJg3YC5gVP/7GvVIMXNJHxMbkaUfCERYW0PgTHox1rp6cjmxkA
	9wvFDN1i5/RgDOq+qtuQYGLrjaLw8mzpwdT7SB/MhssVcOWaLK712o4hGdm9RdVIZmRcK4EHN2A
	BP0wGAc32jhSA80eowEto53MW/nNqeSCtEPls3F3JgnRNRWAlr1rasZ6fuJM/vHEnn/7pDCKoHp
	yBFfHzsnUEwLnjBOn7eEhkqKSwLe3a8sKa3E0pgkGhJrDiCkVirfYbUwIdGICn8ny8LXSb2qoTc
	GshNRX4ZPcB7CUPiGD1I18PZJs50qPOsOQe9HywdnKR5IeEbFQ==
X-Received: by 2002:a05:6402:51ce:b0:608:66ce:14d1 with SMTP id 4fb4d7f45d1cf-60fd2f85538mr235505a12.6.1751581337646;
        Thu, 03 Jul 2025 15:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhQ34cQJM1kgpxELeCyd/hjVgdKzujKM6mLeKa4YjV8RfISmMTTZ4biTzP94cqtbiU+M/JVg==
X-Received: by 2002:a05:6402:51ce:b0:608:66ce:14d1 with SMTP id 4fb4d7f45d1cf-60fd2f85538mr235469a12.6.1751581337198;
        Thu, 03 Jul 2025 15:22:17 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb2f3122sm352189a12.57.2025.07.03.15.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:22:16 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/7] allow reaped pidfds receive in SCM_PIDFD
Date: Fri,  4 Jul 2025 00:22:00 +0200
Message-ID: <20250703222209.309633-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a logical continuation of a story from [1], where Christian
extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.

Git tree (based on vfs/vfs-6.17.pidfs):
v3: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v3
current: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale

Changelog for version 3:
 - rename __scm_replace_pid() to scm_replace_pid() [ as Kuniyuki suggested ]
 - ("af_unix/scm: fix whitespace errors") commit introduced [ as Kuniyuki suggested ]
 - don't stash pidfs dentry for netlink case [ as Kuniyuki suggested ]
 - splited whitespace changes [ as Kuniyuki suggested ]
 - removed unix_set_pid_to_skb() to simplify changes [ as Kuniyuki suggested ]

Changelog for version 2:
 - renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuki suggested ]
 - get rid of extra helper (__scm_set_cred()) I've introduced before [ as Kuniyuki suggested ]
 - s/__inline__/inline/ for functions I touched [ as Kuniyuki suggested ]
 - get rid of chunk in unix_destruct_scm() with NULLifying UNIXCB(skb).pid [ as Kuniyuki suggested ]
 - added proper error handling in scm_send() for scm_set_cred() return value [ found by me during rework ]
 - don't do get_pid() in __scm_replace_pid() [ as Kuniyuki suggested ]
 - move __scm_replace_pid() from scm.h to scm.c [ as Kuniyuki suggested ]
 - fixed kdoc for unix_maybe_add_creds() [ thanks to Kuniyuki's review ]
 - added RWB tags from Christian and Kuniyuki

Links to previous versions:
v2: https://lore.kernel.org/netdev/20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v2
v1: https://lore.kernel.org/netdev/20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v1

/!\ Notice
Series based on https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.pidfs
It does not use pidfs_get_pid()/pidfs_put_pid() API as these were removed in a scope of [2].
I've checked that net-next branch currently (still) has these obsolete functions, but it
will eventually include changes from [2], so it's not a big problem.

Link: https://lore.kernel.org/all/20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org/ [1]
Link: https://lore.kernel.org/all/20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org/ [2]

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>

Alexander Mikhalitsyn (7):
  af_unix: rework unix_maybe_add_creds() to allow sleep
  af_unix: introduce unix_skb_to_scm helper
  af_unix: introduce and use scm_replace_pid() helper
  af_unix/scm: fix whitespace errors
  af_unix: stash pidfs dentry when needed
  af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
  selftests: net: extend SCM_PIDFD test to cover stale pidfds

 include/net/scm.h                             |   4 +-
 net/core/scm.c                                |  32 ++-
 net/unix/af_unix.c                            |  57 +++--
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 4 files changed, 247 insertions(+), 63 deletions(-)

-- 
2.43.0


