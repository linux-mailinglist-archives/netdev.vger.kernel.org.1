Return-Path: <netdev+bounces-259756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDMlBd2tmGl4KwMAu9opvQ
	(envelope-from <netdev+bounces-259756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34F16A323
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A98E3018C03
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2636683C;
	Fri, 20 Feb 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTvfJTk1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40D2E7BB4;
	Fri, 20 Feb 2026 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613656; cv=none; b=G6ISSaDb7u/zwqdbvKB5Mgu04YWR70BwaNFpw7edGziYCBFJ5cXK89TXxkDzXU5IVYtZedcmDulhUtI0jZbWsvk2UOUMCZhBIvKJYnAm4P4q8UN/PFPMGnA5/7d0cVZumsO2MVXxfCkXPlrITKvURo3tyuGxS4tHeFjdDSpTHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613656; c=relaxed/simple;
	bh=hFetM3+clZO7c6XVenc/oELmwqh4574Kor3LRRxJ5P8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2MwzhbBEKxZt4Edm54Bq69/bhFk7zIBRaUaJTn3sanKvlwTpmVkTEbt9Br0wEYrTVkIK8LnDQ3jARpgI+xhirp4u0zZJL/uiNq0nJx/gBgS5jpZchNL6P4853+m3e50EMV68g7s3bP2CY3/S6Nni1iAGynIKs9zTtK/XDfZ4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTvfJTk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF015C116C6;
	Fri, 20 Feb 2026 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613655;
	bh=hFetM3+clZO7c6XVenc/oELmwqh4574Kor3LRRxJ5P8=;
	h=From:Subject:Date:To:Cc:From;
	b=RTvfJTk1rQYRuEpVer6/q4yxaHfNYY0VPgJOFzjP4R3WvhN4JPipUtLnD0im5TZeW
	 77oOcZpzbgqa4Eh9RRjUqAJ0V5EbdTlYKm8876xLhxbk61NNiKvtZ2irWSF3nRr87Y
	 RjKuOeUUQCJCuSDTzOoxC82GU7LssWDoIi4wAqkIdaWrCMUjJ4kXs7igijfXKYXK4Y
	 0O8by0WXxRCQF/9IPXRCo2MmFbwX29GC6Btqoaj18YE4cV3NTp9sS43PW6oJWk0QZn
	 h3Jq+J6+mcDp9uaOt6q2LTa6s52f7BvKQfEa2Oy1WqIyZM5ZU5Ju725FP5oE5vBcru
	 x1sVR7pojOLYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute2-next 0/3] ip mptcp monitor: add JSON support
Date: Fri, 20 Feb 2026 19:54:00 +0100
Message-Id: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMitmGkC/x2MywqDQAwAf0VyNrAbX9BfKR7ExjZCE8muIoj/3
 qXHgZm5ILELJ3hUFzgfksS0QKwrmD+TvhnlVRgoUB+IAsrm+DWVbI5rMsXYDU0zxI7aOULJNud
 Fzv/yCcW2PTOh8plhvO8fAACp73EAAAA=
X-Change-ID: 20260220-ipr-monitor-json-1573371524c1
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hFetM3+clZO7c6XVenc/oELmwqh4574Kor3LRRxJ5P8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnrL080Zqju0ll008RTsajE5YnRla4rDKfuj37V/y6d
 zeW/dl1oKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiu34x/PdcxLDBcMq5X/WH
 jE+t2FozyyZrtkWOz61X/mXtbGXn7GMZ/hmvsDhneEOC3YbfTjbY9GT+hJuJu+SzJ3qkrJvZnvT
 wFC8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259756-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C34F16A323
X-Rspamd-Action: no action

With this series, the command 'ip [-t[s]] mptcp monitor' produces an
output with the JSON format.

- Patch 1: a small refactoring to uniform the code.

- Patch 2: add JSON support in print_timestamp() helper.

- Patch 3: add JSON support to 'ip mptcp monitor' as requested by
  Stephen.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: uniform stream closure
      utils: timestamp: add JSON support
      mptcp: monitor: add JSON support

 ip/ipmptcp.c | 96 +++++++++++++++++++++++++++++++++++++++++-------------------
 lib/utils.c  | 19 ++++++++----
 2 files changed, 80 insertions(+), 35 deletions(-)
---
base-commit: f120cdb35da76ca99932d0428a0917bd01a843da
change-id: 20260220-ipr-monitor-json-1573371524c1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


