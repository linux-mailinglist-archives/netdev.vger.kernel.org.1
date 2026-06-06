Return-Path: <netdev+bounces-296075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yN7KIyDQI2pBzQEAu9opvQ
	(envelope-from <netdev+bounces-296075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61464CDD8
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:45:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J89U8wFJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296075-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296075-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0213301FA52
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689E30AACB;
	Sat,  6 Jun 2026 07:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752A2FD696
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 07:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731934; cv=none; b=A2ghEz1e/agVjMYZYKcjCuzaiGNR8P9kIdM1YhnMktGyQGrorl1obNOgKtFfZ6lsKUKrgmlcFM7wdEVQe1RDh1nYBsCTbWbWnUlEzMY92LtOyZ0wfkOIPYRo/MtdluLSXhNUB8wExZRAgFHAkoUoMEvlPa9pkIL3ndDS1W0xtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731934; c=relaxed/simple;
	bh=v9RFj9MLdQbf0mLs20/N3qsqWDLSHOEx8cvUCHKQTcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWgadVykbVtTBQKkcEnDK4YdpSwq142W5E979gq+YW3XCDFm5tK/KvC8rUINSFouxK56V0tISEhBuFZplG319VcfUYPJKBZqvoByD9yIhJiAibFxVuDdIBrWEyK5fhRjNte1WvJ+XVJHfImfqJ07IjF7sf0VLg9jJ/eQZhDuo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J89U8wFJ; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso2134809b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780731932; x=1781336732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soOeU2aKGw0sdOWk6ao9iMdkrGHwTA85Ix/Vj7V69uU=;
        b=J89U8wFJwcO8RuLdKPnTH98kxRcTTEICOCldLhpAvX/wKWlfhYcHAhEbxxlLIcIYBH
         ETi5mqDiA0Udop/A12zd4rZ0Er3Sq6eNrdOjXPb5AJ6M65N4dg3+JVEvwYmqluf8Z/FO
         YkiBLWaBQThY4fm6vm9Q1ly/rGxpTNf1i84xHPvtVCUk46idUwzTiXyJ0kQY2yPN5fmC
         x2mhUWHVF/LRAPv7M0E3p6V4xBBpubdlZOtlE3rp8y8q1QLhaUThTKz4qSE3cDCTnL0C
         bGBayIImKC4ugrQGL6ByvloQU8aRuMWwW7iWcH2EQY6T0jH3zrHoOJeB7nhid2eeCrGh
         pqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780731932; x=1781336732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soOeU2aKGw0sdOWk6ao9iMdkrGHwTA85Ix/Vj7V69uU=;
        b=hPYtMPy7ZQ3CD/xoTCblrVtky64cAQjD1EWSx6jWcAAlC2A4mYe+MQtFNRXR4pDFeN
         07eMVyVJ/Ip1zfpBCXtX1xao4r+p7MF6OLG6WLhjxWG+j/1QtuQa5vN45Su8rek7bRD/
         znainDhscp1QtRLIAx3HJPLC7GFT/D4upvlPWYNs8bjtVsuzeDQGsm5p6FvYM7lv5EUN
         yntXNfDnBqEkpEuzKsycQYYUQo+2kpW9MVEsZ8eijXdBYWsBIRXKlHp1aoMrGO91VYpK
         UY6bY0U1vUqRyV7NYcqUqZxCJl9nE7aaUD6LCXL2wpl8mlHapi4LDbQwtn0MjD5vBxOB
         hp+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9WmrK4Q/InmsC3hzoPMF8b8gPeNrWu5OyA/GpOEaE1AuwKBtYXdGAJ8aAFJa12ky68zkak6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwKQ76KKcPABgmiaRctWst8iNwXCAGY+zo2veYD3Qc1k0Z4Up
	etW7NIVwRcwOX+MSvQXaK/xhaKHGF/gCiOq6tWLptFfqpqqReRrwkRgE
X-Gm-Gg: Acq92OH7rVxZvurmZK5Nvge8v+54Or/Mk70LCGeBVzbCmHQjXiVPW0qMU5ry4LbKQqi
	v77Ge4vpV8Wb57CpSQXZxjImZcP/L86o02mqibvdUJONxpgv8Pmz62zyb3+t/SFE/4idNI0ALOt
	Ihe8IHzNx6hA2OCtobVdPdIn40Zuy9ufqBzNPKHoXH7iBi7cEROAsIOgjr57nRQ4T8sMlqsg3GW
	e+i6Bdi2WmFscJLqgDmmcUzDCAZeAdCQdUozsqVWiM/lV8kbqHcI6i3vALS4gcrqAOlfo0y4EEy
	VzGQN6bfDM/erCE/kGjoRDzWjww1gy2qrKWMEXxWe3jwkxSHX6TWVjS1G/zxzX+TcRRj9N2crB2
	ga2xvoSi+n9Lja0vMr39G2Ahq3d5mPnAs9RhDqefNDXI8vttBXsOn6R2aydHzTO9FaBTHRze9rc
	lE3RG3xUZjOVctWac6bmoqFKVBJzkWZT+JrS4Nc6sgNVAzZahgIQ==
X-Received: by 2002:a05:6a00:94d8:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-842b0f4278cmr7095141b3a.45.1780731932077;
        Sat, 06 Jun 2026 00:45:32 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:13af:61e2:7096:38fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm11350990b3a.28.2026.06.06.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 00:45:31 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: stephen@networkplumber.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next 1/2] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Sat,  6 Jun 2026 13:14:32 +0530
Message-Id: <20260606074432.22005-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531154149.592bb35f@phoenix.local>
References: <20260531154149.592bb35f@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:hemendranaik@gmail.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:tahiliani@nitk.edu.in,m:vishy0777@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,redhat.com,nitk.edu.in];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296075-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA61464CDD8

On Sun, 31 May 2026 15:41:49 -0700, Stephen Hemminger wrote:

> Sorry, you can't change the kernel/userspace ABI like this.
> How will old iproute2 handle new kernel and vice/versa.
>
> The better safer way to do this is to either extend the
> existing structure and have iproute2 know how how to handle
> short (missing) class data; or use another netlink
> type for class data.

Hello Stephen,

Apologies for breaking the ABI.

We've been working on two fixes along the lines of what you suggested.

Approach #1

Append type and the union after the original 9 fields rather than
inserting them at the front:

struct tc_fq_pie_xstats {
__u32 packets_in;       /* offset  0, untouched */
...
__u32 memory_usage;     /* offset 32, untouched */
__u32 type;             /* offset 36, new */

```
      union {
              struct tc_fq_pie_cl_stats  class_stats;
              struct tc_fq_pie_xqd_stats xqdisc_stats;
      };
```

};

tc_fq_pie_xqd_stats is currently empty. It acts as a placeholder for
future qdisc stats if needed.

With this layout, older iproute2 versions receiving the new 64-byte
blob still see RTA_PAYLOAD(64) >= sizeof(36) and read the original
fields correctly since offsets 0-35 remain unchanged.

Conversely, newer iproute2 versions receiving the old 36-byte blob
take the memcpy path into a zeroed local struct, type defaults to 0
(QDISC), and execution falls back to the qdisc stats path.

Approach #2

Leave struct tc_fq_pie_xstats unchanged and export class stats
separately as an NLA blob via gnet_stats_copy_app():

enum {
TCA_FQ_PIE_XSTATS_UNSPEC,
TCA_FQ_PIE_XSTATS_TYPE,
TCA_FQ_PIE_XSTATS_CL_PROB,
TCA_FQ_PIE_XSTATS_CL_DELAY,
TCA_FQ_PIE_XSTATS_CL_AVG_DQ_RATE,
...
};

Adding any new stat, class or qdisc, is just a new enum entry and one
nla_put() call. Old iproute2 sees an unknown TYPE and skips it
gracefully via the default case. No struct versioning, no size math.

Let us know which approach you'd prefer, or if there's another
approach you think would work better, and we'll send a revised patch
accordingly.

Thanks,
Hemendra


