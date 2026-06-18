Return-Path: <netdev+bounces-300481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HFShJHcUNGqrNwYAu9opvQ
	(envelope-from <netdev+bounces-300481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BF6A15C2
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:53:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=RZNxLZlN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300481-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E43F3023699
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489893431E3;
	Thu, 18 Jun 2026 15:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF462341057
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:53:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797984; cv=none; b=Otm6BXYSipKbKZX0l6k0nc3GOsUWeGKXRZY123sU3L6xLZIGXM+iLyI+Jkc/1w7t5KP4+dEx0YyTiGfd8kJAP43WOKhfVI/iPj2hztJwOD4gkfz/gMhatAEsWBThdeAU0pzKj9+pwqsKXekt+liuIU/11t8bXLOoIsByUTi/1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797984; c=relaxed/simple;
	bh=aMFYA7Kt9TXbBJGwu+gndNL/OVZNCiVxFov18W5JUAQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YLCgvwhC3AxoicF3iIDaZKEzd2e/DVvXvZrUqqpMbXFIpKyB5gHXfkKd6nQ8sdkVdj7hwwVJmbPuGfWUt56Sq6ytXLJ7AEnIygqRZhBmZfHS8ynszMaLO4+h13mtrdh0jGzkhG9YgFss5uVbAh4yACi8W6VQO2hdcz0yqp9bDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=RZNxLZlN; arc=none smtp.client-ip=74.125.82.182
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c001b21feso435660eec.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781797982; x=1782402782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTL6bV2rIofTVcADUYtXTuLoT3fzW6CzPkLk54i0chQ=;
        b=RZNxLZlNZXRwAyvmIxksDADdCXB6L2Lt8FodJScTUSp0jwIkSZkV4c/C+XcPKNOqDv
         JJyIeFzgTejEhi7BFuYhpauab6F/yOjuUqwp9+s5yCmHpp+Kc/WjjNr9Xmood+0PLcVL
         1lbR454pO4j2Z7LXTNMDlE7DRTp5T9RU+P0Ih46UDaFF6KYCCCd4gjM7H4rdRWuR5FTy
         sMs4EMfjWK8MYsVVcxznn4vLh0yr+juFEK8ssuL1sTIW78ulQohS/GMTuVFKud3rZiOK
         irptvTMRir2mttZ4nRYfBumVXrNeVWTX/AYKAk10mqN0lpcbSZfmXhxyhNZ39nLfjnlw
         LOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797982; x=1782402782;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTL6bV2rIofTVcADUYtXTuLoT3fzW6CzPkLk54i0chQ=;
        b=EOwx/HJerDZO87/Hxu03V9YXmmdA6r9pXSPzgegCjHR0RUohlESYp/+1JtdeCgyUEY
         lgCXJ09Q6GvOGQFvqV83BeQKzxiqbU+1UhWsk1g3CJzkWcQUvftBdMh+qOj1jKidCp23
         fv1bPHa1QNKbkWk4CJPMjtWb1m7hCGp9r3A9cg8pniicSxJiE0lBE4yv4rVW/ke56RyH
         qYQNDQ75Wba2wZMmzeLurEtC+NnJepft0kT77eYNyo9XVoM0ZxoczAaTkh9XoCpWGJYb
         SqoB4BMm+mUqrx5UmNQVsLF3LTpZxR6dUNr2x0hqmbot3khT1l1F0w5eHB2Zo/9NDPkd
         /CTg==
X-Gm-Message-State: AOJu0Yw9pIbfpINIhAIvfDP5ksc817PgK98WMlczxX3hjV6+zYndeEW2
	iOxfX0tIuQwuz1YC2ReRRdGEyftyRxbX1pwfE2h2vkgJwqb01+DANXBCaq85Z1sV4VTByjmK5Pg
	QYomk
X-Gm-Gg: AfdE7cmY0vA3sW2vUEHVURkPBJfxzFKji3+qKHMU2RF4xpAOmfhncyBl1yhHjo7X9cv
	jbni15qQHgLoPBeQm1Uh+G/HVu5EEuLbu4qMaTmE3W8uAJirNYdCw0/GHN41yPvKMwajGcboM0F
	WayBGy8OGzMiN5wekJ/zZzHTvTZF1V5Wt/g3pClCkC9j7YwP5CX7QDsQmDipLdyumKAmSa1l1dJ
	A+8UEzxq0Pe3mIcLdxXpKzHqVytmr6OIJtz3MVwtk1KojG/sFVyt1hxqwM0IoQEQnxWKNOlxoQz
	uU+yOhnfAwcx7NmsC7TMc0BUNWWhCcgbxWsa35KAUWkH7hvH0vnJYSh9Kt8pDyaHJgBENycTyXg
	ivLNKGzYN7QLG6Ut1847Hb+ZBSmNDVwH3esDywdyb6Bue7MgsWxSklX5G5RNOVatWlpP9ofJzsu
	JXyW9D0BIBft5zPlYEbFqBb9IRYzeH4u6xN6ZHhC/SE4vAkd1MiylyXg==
X-Received: by 2002:a05:693c:2d95:b0:2cb:4b8f:b2bd with SMTP id 5a478bee46e88-30bf071c8a6mr3559016eec.6.1781797981626;
        Thu, 18 Jun 2026 08:53:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea447b4sm23947472eec.23.2026.06.18.08.53.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:53:01 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:52:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 221665] New: tcp_ecn: doc says default is 2, but should be
 5
Message-ID: <20260618085258.2d7ccb8a@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300481-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 100BF6A15C2



Begin forwarded message:

Date: Thu, 18 Jun 2026 13:05:29 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 221665] New: tcp_ecn: doc says default is 2, but should be 5


https://bugzilla.kernel.org/show_bug.cgi?id=221665

            Bug ID: 221665
           Summary: tcp_ecn: doc says default is 2, but should be 5
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: pedretti.fabio@gmail.com
                CC: corbet@lwn.net, pabeni@redhat.com
        Regression: No

Here: https://docs.kernel.org/networking/ip-sysctl.html#:~:text=tcp_ecn

tcp_ecn - INTEGER
...
Default: 2


However it looks like the default was recently changed:

"In previous kernels, the value of tcp_ecn is, by default, two, [...] The new
default value is five, [...]"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8ae3e8e6ceedfb3cf74ca18169c942e073586a39

Please address this.
Thanks.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

