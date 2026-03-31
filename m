Return-Path: <netdev+bounces-273454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPeqDDpGy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A972A363C96
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5773930641DB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56992D060B;
	Tue, 31 Mar 2026 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLyvP+X9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C41A3154
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929394; cv=none; b=gJrhU3EpJlHvbWFXYPkMjt3U/mES+1EtfcBYD18Rg6wo6yusc5TpvVzk8NlyXtpB27uf7NtmckIKI4bd03XpBasNN25wTVmm3g79e9Vj4VPY3kkkUdsmu34ZNa3dET0oyrDPkO++g8NutD9YnEuM/FNOpyYE4tjEkWgGIzIRN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929394; c=relaxed/simple;
	bh=/1d/SQB0lDkfk6gQGl066QQ60SbR0X67jpMKif4tqy8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JhLQVpqzw+J6QdbcZjOYyvljEBXewO+oSl1753hPCAcqrvovQ8RuwOgiUfiNg8JCDCX+YZLQL6hYm5el3KyGObbT/a6wMZRsNhrBlAXFwlidh3QQ/fgkTPJN5ijuFJT/IpXYQgji8rOs4zCs6fK1SLh1EnpX08hZNplQXvgGpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLyvP+X9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b24ddb2428so11257915ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774929392; x=1775534192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll3YM4do8VUXTzcFrksYghcaSP2fNs5r3be4UVdcfFo=;
        b=hLyvP+X96WTV/3rUwX8jafFUtLelHgKKQB1B1NpnztwRrmPae6hfXy9YnLbfSjSTIO
         OQG7VPd0d9pVzv2vXT+F4fB3bXk3zj6YXHi8k/dFzAn4ClL4Uu4R81ydF4xLd+ACZW3P
         povzWBjOmNfjnXYcGOdK5B8Z5HK/cekBPJbgonY9PuvhzNrXkFntAGTKiRzQHVLtrBIn
         Gwt3+OUChSccEvKW5CJgAWjmtjRqE9DrVlonUYV6B3mN8htWc4dDearsr+e2ITO1Ys1n
         7IQVwczLPBDth6Gp43+72xK4xau+4LuVTT/o0SKNqNU2BmrNmFfQmj6Q2crsQoBIH1Yf
         v/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929392; x=1775534192;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll3YM4do8VUXTzcFrksYghcaSP2fNs5r3be4UVdcfFo=;
        b=GUDIUmYaU1ae7eM25NRbyR91oPZ8Nhsjyzsq4ByUAGTgbx982f/dx7weL4IgvUhiOi
         ojWurByYzMY5FSpDVtN/rCtEvgUJ/MimDH/DhCDZ34uid+UGZwnz47H6ahFuYsuCvCbw
         woiPpFCjmq4edOQBxxqfopJGZbmG1NN2Ay6Cc02cTBGvIVYhIY1lSXO6Z3HpYxmshgDJ
         vzEHqNDwrXUGFZydDwUWChNBQxh1E3jUhXEufDzepCX/RkHmNh/RqCLyVws4qxFFAQ6f
         3RBfORhesYFHqGiGsztMaQ/2ZJpHuzepBAXjiwsSP/jAqc1y4Ko3PQgPMjMVMDf7/ZPP
         N0+g==
X-Gm-Message-State: AOJu0YyLMOoP1MdRQtDtgiG7nuAMJSC6kyAZID7ydp4LaSyfEnyO+Hig
	Y5XPwp/6rttN10w80WpaHnEHTVhvCAwKLL+G81J4KOERgKntIAk+cBmB
X-Gm-Gg: ATEYQzz8T8LOV0oWpJnf6Z8prqZlewnhGQ4zEqGOEleUlqCAsLs1rr3JonAmbbzcB1A
	8hrc33KpNnQ+vuikg8AnF1U6BxmPY3qwjsyVYBf7JDzvrdGmiUgmnLJgJnWhFF0Yx7tllMTtYS0
	IsV37aeNzwIoXJIdChW5Q58XjTcGe9JSuAZpD04M6MkuT+OVKnHwL4oahY5j2T2eiMlDXb1iagL
	km/YOMXp4beHNCyCLk2oXxgNhKgq1cdwwr/HZv+GA2rqcRUpXi3jBKLbSMevZMnzXQbs9Vh4blr
	1aXJkDG8EGw5OnUqkyHfBF0L/nM6UG5P+T5iiOaR+mDdve8JUDg8xEG5TvbD4UR/W9tP33SbRCe
	JjWFApgjAfxg7BVOQeE6ZTRsr3SeiiDC6yMR8OzvEMY0DshFFEbNqdwBntzq0kMWHnKRYmZqrdF
	/lXm1CPCpSbgxqiH46bJy5zl5gDhbvqtoc1aHzdT0TIGgVSc15sIjbFJlvA0YGGDNK982PdqTez
	Ope30gRDCCx+0pSmnZCdO9P5PZvqkMk32jO+KESBbwaORwZpD0=
X-Received: by 2002:a17:902:f54d:b0:2b0:673a:7c90 with SMTP id d9443c01a7336-2b0cdcb7203mr145646665ad.28.1774929391550;
        Mon, 30 Mar 2026 20:56:31 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm94680625ad.24.2026.03.30.20.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:56:31 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/4] ynl/ethtool/netlink: warn nla_len overflow
 for large string sets
Date: Tue, 31 Mar 2026 11:56:10 +0800
Message-Id: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gacTEcHryIyaE01IKm0RRTx7
 pZZvsX/F0QOwhHa4oLAu0TxmvEqC7DLoDOjTNlAFdXVmwyOBk9df5yW5P2K7tvYyZD7NGQhR1t
 gJ8d/2IFyQuUjQX/fD4hMEptqAAAA
X-Change-ID: 20260324-b4-ynl_ethtool-f87cd42f572c
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273454-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A972A363C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses a silent data corruption issue triggered when ynl
retrieves string sets from NICs with a large number of statistics entries
(e.g. mlx5_core with thousands of ETH_SS_STATS strings).

The root cause is that struct nlattr.nla_len is a __u16 (max 65535
bytes). When a NIC exports enough statistics strings, the
ETHTOOL_A_STRINGSET_STRINGS nest built by strset_fill_set() exceeds
this limit. nla_nest_end() silently truncates the length on assignment,
producing a corrupted netlink message. In the doit path the corrupted
message is delivered to userspace without any error; in the dumpit path
an -EMSGSIZE may be returned if the data does not fit in the dump skb.

Patch 1 improves the userspace tool: rename the doit/dumpit helpers
to do_set/do_get and convert do_get to use ynl.do() with an
explicit device header instead of a full dump with client-side filtering.

Patch 2 adds a --dbg-small-recv option to the YNL ethtool tool,
matching the same option already present in cli.py, to aid debugging
of netlink message size issues.

Patch 3 is the kernel fix: check whether the strings_attr nest would
exceed U16_MAX before calling nla_nest_end() in strset_fill_set(),
and return -EMSGSIZE early if so.

Patch 4 adds a generic WARN_ON_ONCE() in nla_nest_end() itself, so
that any future caller hitting the same overflow is immediately visible
in the kernel log rather than silently corrupting data.

---
Hangbin Liu (4):
      tools: ynl: ethtool: use doit instead of dumpit for per-device GET
      tools: ynl: ethtool: add --dbg-small-recv option
      ethtool: strset: check nla_len overflow before nla_nest_end
      netlink: warn on nla_len overflow in nla_nest_end()

 include/net/netlink.h          |  1 +
 net/ethtool/strset.c           |  4 +++
 tools/net/ynl/pyynl/ethtool.py | 77 ++++++++++++++++++++++--------------------
 3 files changed, 46 insertions(+), 36 deletions(-)
---
base-commit: dc9e9d61e301c087bcd990dbf2fa18ad3e2e1429
change-id: 20260324-b4-ynl_ethtool-f87cd42f572c

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


