Return-Path: <netdev+bounces-251577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OQKDn3ib2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:15:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F04B1E6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F40D388AA90
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065C3ED10A;
	Tue, 20 Jan 2026 18:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844244A717
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932633; cv=none; b=F7/Vz4hiZXpjP6Oue0YobFtbuR6iZgDZA3oLp6mQDvMvRi3VbLRqU27Qpu/O/YaIUFnobU9XgGENYF397rWf50/rfvka+YhIh+7ebFKSfz36V56Y1Haz5k2OnAIDfVbSN+F9ysJNM6p20gMlKgI2/GyWohxOMC21VPkUf+qiWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932633; c=relaxed/simple;
	bh=SQuPEuyy9SCwEMK9OfKEs1E1tfBnZqkvPxTamck3rIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S7ZnoDobslZlU9iIoJMumvhjU0b4w55je6X4xpAx7ajTq6hL4VSpF0UatUoLM6+1p/Zefm5rB1+aZSGJOPBRFVBYgTJ75d5feIsmE/Y/M1fb3UB3oKujMJ5fT7UC+B7cEkqz6UHPBlTRONgWt2ljkPejnEcgiX0DaWYZo210SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4040996405eso3642036fac.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932630; x=1769537430;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0AMHUzuSQsGvVnfjvJFznULu3YAmXNESMHQiMyZeJo=;
        b=e5W58qDQQn3wS7r30YNwkiM8b8ZaZj5kjReCizeh9kWDdfByQy5OrnKC6ltvMeMSAv
         kpClaeHeJkWsrgs8WDi7RE/oxmHUBlLcijpcA4+nMci6M/ORhjteO7yXzUHwxmjppayV
         RlDAm1a0igRGw+rKBWm7lMWRVtaAdfyGjKCRoOnPP/ciOslB8av3ADozWXGp5JQlIIjP
         BmIPrD9HSC5gACNvDUKM/eHsKsE6IaBiUuc5cUWMzCxghfF5/Wg15c8gMxH0FMEGhlBW
         7xU7PqI3vXYsxNSUeJpyT+Ct9R8BzMjiL2QWEnWS4UyweawGAFFAQLkzyTnMIA8xh+fs
         hUWw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgcfG0EbMz0tgNOPcC5OEw/zFc/wqhon16QKNBgRI6/tVRndx8tJ9WX186H2xZJNZf9ZAUDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxId+AfPjBeT7x0hnzXwB93EeclTbczHjjRVfrRtrfnUUF2Bz
	ky8EeVaf8sAfOt+1SvCdeMcDr6Il7dSmF8qiaA4u4wSwVvdx6bKB8hNmvvnWuw==
X-Gm-Gg: AY/fxX41TggRA5ifVkhyZMfYyKVW2mY+JNtuAbrlsU6pyJPHLcOQcV9T0INg5ZTj769
	rRpQC2bVFa+g4sHDI5aTlZNToYfkL4RjNpTADlDpu95mOnrVvLau7UnXuNcz/3MXfFyyM5YWBNh
	B3UvyFNnoGJciM8pRp1gLpcSWTE+tvY3qCCodS10p/CRVlCdveR+ERAWiZx09nqpAbssbGaapP+
	YbJ4bYDVf1Wkn93d8qVE+/R18X2pGP/cKf4C/mkqsTdbb9pibw7e5UiAeD4iQq6LnOjzQqMngEG
	7o2u/cOuhJO4dGRbcxLkwb5UxEdL+iQBrIrq4l8mzEB6UCaEPFCmAnPknGlaIuqQGiNsYGFV9GO
	rLH+0HsIWj71EkS9A9BbjQ1qR+/2zeqirHzle3k/D/c8OMwt08OosivDyj7R4ygcEFuOahusOCs
	p/jg==
X-Received: by 2002:a05:6820:488e:b0:656:9202:58ca with SMTP id 006d021491bc7-662affa13efmr708830eaf.3.1768926244337;
        Tue, 20 Jan 2026 08:24:04 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661187a180csm6078410eaf.15.2026.01.20.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/5] net: netconsole: convert to NBCON console
 infrastructure
Date: Tue, 20 Jan 2026 08:23:46 -0800
Message-Id: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOsb2kC/y3NQQqDMBBA0auEWZuSjNpoVr1HcaFx1NlMSiJiE
 e9eCF1/eP+CTIkpg1cXJDo4cxTwCisFYRtlJc0zeAVosLXWOi1TiKIXbBrnwtgvNUGl4JNo4bM
 4bxDatdC5w1Ap2DjvMX3L4LClFwsR/9ZhtdHPdmrqYPrOme4108SjPGJaYbjv+weRVKvZpQAAA
 A==
X-Change-ID: 20251117-nbcon-f24477ca9f3e
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227; i=leitao@debian.org;
 h=from:subject:message-id; bh=SQuPEuyy9SCwEMK9OfKEs1E1tfBnZqkvPxTamck3rIA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6wiGIjGPirQtPzTE38//gV+YKNqP3l9aqhJy
 psRVRB24muJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIgAKCRA1o5Of/Hh3
 bWLMEACYKoRWE/hco3X4LrqZpdgnDURnMjioeUGXIBlEG4tAAEU3yd+bTztlrPPuA1UCEdjPXEI
 aHcQ/NdeusET9PFFm1E7t4smTY6cnshIQgJib1fcK7J9fGxztWtp4gj1lKyvhxlTKlDWyMlUXmu
 bCLjjYxutiva3Q4a1fbmwI2da/XZaQmfT2jG4aQy3wFtalp9jafnNhbYVUgdFtAWa1LtmfU8Ssz
 WPq9uS7q1iB9EqhXbogKlpYeQ9fgD/oLoD9FVvTt5KOXrfsoiLcsl12QWuq0+oGeHZ0jgFob5mE
 golu9Y2u0bPN+3zoa9MVOk5Pvb2Eb1hAx1fNidXjwM9OmGXMpG6eX6tc77i4Rcc3+O0DSkWfAhh
 16fhm+YiHtF1Xy4C3nsThgpmzY4emdIYObIvBzdrLjmTAe1U6RKyQPqHnCHWSbWa7DMqv2bQlOm
 SCRtPddpPyN5pO7RfpaP/+kJqRpbmu1rvuZMuXSytngiCnD7bw6YCQ3QXGZn1WTfnU5XkmdbAb+
 rgOryHMkBNF4lszbSOapJip4xBjWU+uPA2nBRCHkVJjKHp33Sry1RoXBhNMaZgXVBhVpv/t5SQA
 yv1RQFh6zpMhlD+zyNsuWZfrQmikByvg4xxV21bcpl3kEwN6zvMTSuml1iy7vjzkl4eLVlhkywL
 zyFVxqb/wmr9ulw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251577-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8F6F04B1E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the nbcon (new buffer console) infrastructure
to netconsole, enabling lock-free, priority-based console operations that
are safer in crash scenarios.

The implementation is introduced in three steps:

0) Extend printk to expose CPU and taskname (task->comm) where the
   printk originated from. (Thanks John and Petr for the support in
   getting this done)
1) Refactor the message fragmentation logic into a reusable helper function
2) Extend nbcon support to non-extended (basic) consoles using the same
   infrastructure.

The initial discussion about it appeared a while ago in [1], in order to
solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
cause is that some hosts were calling IRQ unsafe locks from inside console
lock.

At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
nbcon: Allow unsafe write_atomic() for panic"), and now we can
implement netconsole on top of nbcon.

Important to note that netconsole continues to call netpoll and the
network TX helpers with interrupt disable, given the TX are called with
target_list_lock.

Netdev maintainers, Petr suggested that this patchset goes through netdev[2]

Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
Link: https://lore.kernel.org/all/aW9D5M0o9_8hdVvt@pathway.suse.cz/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>

---
Changes in v2:
- Return if not able to nbcon_enter_unsafe() instead of retrying on
  a different target (Marcos)
- Add printk that supports context information, which will be used later
  by netconsole sysdata. (John, Petr)
- An extra patch to bring symmetry to send_msg_udp()
- Link to v1: https://patch.msgid.link/20251222-nbcon-v1-0-65b43c098708@debian.org

Changes in V1 from RFC:
  * Removed the extra CONFIG for NBCON, given we don't want to support
    both console. Move to nbcon as the only console framework supported
  * Incorporated the changes from Petr.
  * Some renames to make the code more consistent.
  * RFC Link: https://lore.kernel.org/all/20251121-nbcon-v1-0-503d17b2b4af@debian.org/

---
Breno Leitao (5):
      printk: Add execution context (task name/CPU) to printk_info
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: convert to NBCON console infrastructure
      netconsole: Use printk context for CPU and task information
      netconsole: pass wctxt to send_msg_udp() for consistency

 drivers/net/Kconfig               |   1 +
 drivers/net/netconsole.c          | 147 +++++++++++++++++++++++---------------
 include/linux/console.h           |   8 +++
 kernel/printk/internal.h          |   8 +++
 kernel/printk/nbcon.c             |  15 ++++
 kernel/printk/printk.c            |  52 +++++++++++++-
 kernel/printk/printk_ringbuffer.h |   4 ++
 lib/Kconfig.debug                 |  20 ++++++
 8 files changed, 197 insertions(+), 58 deletions(-)
---
base-commit: 956f569c90ab507559342d289f4c923adfbf06f5
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


