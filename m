Return-Path: <netdev+bounces-295326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XFYrFvulIWpiKgEAu9opvQ
	(envelope-from <netdev+bounces-295326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8E641CA0
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:21:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=lh5QSWwx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295326-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39F3730E050A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1DD413247;
	Thu,  4 Jun 2026 16:10:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6E39734D;
	Thu,  4 Jun 2026 16:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589447; cv=none; b=WaVgGIBPE4v0krysG0vIF+xbQyYi4rjyZmwh3bF/8tLSyH99dY44mFDZoN3M/M9PIFIeDD717u0lnaj2IPOMGazoOHAJN4dc2q3XysZBGkqGKjnScj1Ea8PTeJimpUVwnGEfibcmhSJapDA7HhUvXOXfIbl+wXVG6kzMTTQeVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589447; c=relaxed/simple;
	bh=L/IBd4/iumf/eA1CF4qd6XImogUuYJFsfZU2/g7LIME=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kfPZLzx/J5XndsTkc4SvGgl+2ch1t/lm4pv1V4lvLJ879fmor/6aAfSSYpicYP26ysdAelUhIIHsP6fsjAnLML5xyiYaqFz8bSuwoWN8u4LkHHjy1zzn53VDiDEeDzMeFiZ+xNIswyQZqtdnXZ8a1gkdV6LKhomQVv+A4EcxXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lh5QSWwx; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2+vS8c64Ylrgjbk1xHW4g3n21zANpFFJKU0f3rSzCkE=; b=lh5QSWwxAPZWu3jMDDiz8bTk1R
	9aQ14ffnf+hGMA73i7Xq0p2GFjUi570+QKxhrM5KpQbpFO/VfgxBZT7xVGJMdgNOOHg78hn1WJkVG
	krgZI1XfIsWDjEYdbfVXPrO2BCsdcI0LQqbdTAVh/dQCHmeD1upm3BnEps9wQFpQOhYWxQ3/s9Rz9
	P7DoUmIZiC1CW9nJlHV4vFp1h8v9y1Pbhq85f4bquxdOVTikIeXYVfBho99K6y2qhzvPJGg4uYOLX
	xvCoTVCp4hXhWK0rLSS2D+bpdAcTsUZJvILzFDylnV1Rg4a6/c4/5MV4GHRdZN0P/SLPtWV5h1Fok
	KDnn18Nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAeQ-004dNm-1r;
	Thu, 04 Jun 2026 16:10:34 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/5] netconsole: Fix reported problems
Date: Thu, 04 Jun 2026 09:10:09 -0700
Message-Id: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKjIWoC/3WOQQ7CIBREr0L+WgxS25CuvIdpGqCf9psIBpDUN
 L27Ka5dz8x7s0HCSJigZxtELJQoeOhZc2JgF+1n5DRBz0AK2YlWKu4x2+DT6GgdDboQcXyGgtx
 OnXVor6hcCycGr4iO1kq+g8fMPa4Zhl+S3uaBNh/go7tQyiF+6oki66L6OiH/+orkgqPVjVNam
 YtubhMa0v4c4gzDvu9fiLLJ49sAAAA=
X-Change-ID: 20260528-netcons_fix_before_move-cd6cfec4e8f5
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=leitao@debian.org;
 h=from:subject:message-id; bh=L/IBd4/iumf/eA1CF4qd6XImogUuYJFsfZU2/g7LIME=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1p0XV/HD/2m2BEzb4Lw2uUQdWlxLMV4hlt
 VHWoO08mF2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bQq+D/4syjR5OK2y4I6e00+VSAp+rNSOa3R70oOJ3yD3PfbMJel1N3IcX6jC/cmrzB901+gag/C
 bsVLnxySJ7XUbeuyZBJC2Aprizjjm7zWcyQV+sXehtJ3bJVqzF8+/VjvfdMVVhLfJyu27qvaADH
 316w/cZz0BK40TtIKOFa9Bfhy5T5e2Ws1RN4JlV0F0CXFnQnAYTWDdnYsP72RQzZr5y9TVgqmAm
 COHwvqp1fiY3ZDd2mbh3SVh4EyGlqKzxv4FCod9lMIZClfON0Vi8RwNQTf9XQAbZXtzh9cLGxJg
 SQ5N08NuuVZUPsifX5VEboAwgbyw12W28ASNto+xGc8s8AmzCc67j9VrcyXoWXUWUigKLeD+SwN
 kU7hSxKFUQlcJNE/6kgeCujHxxIXQ2aiec4+Y20IfPm4U15lXaJalz9J1f2NCDM/IPeNmQjWGQL
 uQp/dI9e5YfSQBVpT4fDKVFQepr80lg9lAeUZngq1bQcRaRqiJcOR92HF+IEhIy8qPKggnasjxM
 +NLllREouMoiRkoZ2JeY3oSnvCV44bO9lzAik2r1a5u3niK0jZVRT40ygfiP65ZdDrhXLadY5Jm
 P0xGR2XAGAYwwZQ2I7O5rtbd9tZICD/oRQPWXZA3eibheQDZUiuRaeH4E3eKn6GhQ+iIvWz1oQF
 +ZGkwDDYhy0N5Ow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27D8E641CA0

These are some of the issues that LLM reported to netconsole, and they
are being addressed here before big refactors.

I was doing some big refactors, and got some "pre-existent-issues"
during LLM review of the refactor, that make them hard to guarantee that
refactor is not introducing any bug, so, let's clean these pre-existent
bugs first, and then submit the refactor.

The issues fixed in this patchset were reported during the review of
https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/

Not all of them got fixed, but, those that were easy to reason about.

Why net-next and not 'net' tree.

Most of the functions that are being fixed here moved from netpoll to
netconsole, thus, fixing this on net will cause merge conflicts from
'net' to 'net-next', thus I decided to fix it on 'net-next', given we
are on 7.1-rc6 already. Sorry if that is not the right approach.

---
Changes in v3:
- Fix a regression in the first patch, where warning was called in
  a potential NMI context.
- Fix additional issues reported by sashiko. They never end.
- Link to v2: https://lore.kernel.org/r/20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org

Changed in v2:
  * Change it from 'net' to 'net-next'.

---
Breno Leitao (5):
      netconsole: do not schedule skb pool refill from NMI
      netconsole: do not dequeue pooled skbs that cannot satisfy len
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()
      netconsole: clean up deactivated targets dropped before the cleanup worker
      netconsole: close netdevice unregister window during target resume

 drivers/net/netconsole.c | 76 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/netpoll.h  | 16 ++++++++++
 net/core/netpoll.c       |  7 -----
 3 files changed, 87 insertions(+), 12 deletions(-)
---
base-commit: cd5077cccf13effebf7ff4cb1c7fa080c1738d0f
change-id: 20260528-netcons_fix_before_move-cd6cfec4e8f5

Best regards,
-- 
Breno Leitao <leitao@debian.org>


