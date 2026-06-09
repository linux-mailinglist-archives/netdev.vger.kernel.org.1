Return-Path: <netdev+bounces-297111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5pR2KTMxKGp4/wIAu9opvQ
	(envelope-from <netdev+bounces-297111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E07661BD7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aNvmHBx2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297111-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297111-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885E630A7125
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90C49690A;
	Tue,  9 Jun 2026 15:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E9494A07
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:13:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018018; cv=none; b=MTUrQ7JrJ4ywfVsG/I1u2ndFhHkyOk5Y0peCDlqpVZ389WMy2C/LF1EGHtVkOyWcNPxqemX9bRJbo5x95+lkSiHksRkjz8kYzKq9gXF7qWEZqnnEPgn5YdoYxHv8hfR+Pc8/I3U98mHKHKvrn10HKj5nufnVB14qwYYYzK8XGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018018; c=relaxed/simple;
	bh=s24y9GPV7y+NJAKmvwvAX1cER3c+JYcl/Cz6+DphJa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IObbUK0jju1uCFsJwi7eXOcaN0+c3Rv16SNX3r1mlQI0GIZAcE+rosHhCLYi8oWWPRALOGkFIcxxwe8Lubq3WfLByLrv9An2EMEpPJv0f6isJYrU185KApxt9SCCQy1BASBfWUW2Tf51C/V/D/hdmZYuIh8iwZksDNpkyL9nU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNvmHBx2; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so10362341a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018007; x=1781622807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3neVONgdAVcEZX3f1l1KWGoYXB46SXm/tOXseRIlMNM=;
        b=aNvmHBx2tHLb1lluUrYs1uQzVJcvwHSyvnhBJFTOWpn/IZLK9O06PRCpz+IJ90keLP
         g24YjrWQNGyzoVkhvKukEngRyFm0AoW8aLvnezAZNa0LxFi/IaRwuDuFfEMKMuGp8BsK
         LehignkKO11waRS0BofFk3GywQZKqx/pheAP0ZyqF4xO5NLE9oVDLLPrpJGz54zjIPQM
         JaS3KBYZP2r4JRzZII8eGBBZAeG4jJiYjdgwEKAct5HBVAxesGsRdOrx6EBpR6Aro0kK
         WZHl+V3eW1nvqpHTdk+jYWNqzTEsfbg1xIW3Q7sZ5k/2NJd7UtkfArzBj5dbYRj4jzOp
         DJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018007; x=1781622807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3neVONgdAVcEZX3f1l1KWGoYXB46SXm/tOXseRIlMNM=;
        b=rKVQxF4qsIJQBRw2zDXoCZQBZEMOJt3tr/DiEkCB2aDNHL9sx2RtgYMSFK5Tm9yuhg
         R1ShKX5qHHW5iY6spc2f4Q2XyQJxl9sqK1jCDEpPDEfmIx7b4B3enNkWmKNjiAbxSjfY
         J6lHsNo+BAl0XLmWYWBMheM9h1ChoUb8wal1f+0k5bU4vtz6I/YMdrby2+rNF6DBS9q4
         MVBMmATbPRXTwDxAvBaUy1xz6lbGkYnW03LgCeg799StQ0VF329CrqOAzHUCYPlqT52R
         e3s0ZBd1Vlpn4ulJASE0Bf1uId1vAQkpcjdL2p3dyBge68djiFMoq9IwKmXS6zQk+gkl
         Mtfg==
X-Forwarded-Encrypted: i=1; AFNElJ9vrjpjZpkXPcm8g2pJV1betHVMnBZhoZPo4wEtNdLXOkaLw19/P7yqDBDRqiKjJA9GK5SAgoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0muTC74d9a50que7Aj7v+hU6VaSYhjKR/wmBo6qmgCAWjmG0/
	GeeBwpKJ1T6mj1ON5ENiGbSMbVftrzUHhbaaMnv1JS3hxwC0UZTvbgLu
X-Gm-Gg: Acq92OEYRKnV1ogKLMKGhBzNG1dRR2LQGpN3+CYeDdm5lNBjlUc8lBjrCllK/FU6QIt
	UdxQc4S3j58jlIIOXDYkRoxasUC1N7Z7yh3KzQVsM6uIy4esXIqpNyMe0wEwJUI3HP3ANkvE7UU
	5kqN1f9hTwfZ9yrUf1s/gFX3aFvu0IXZvR2hF9VMvoJnCi1CfpcwcvHkPUrBkJ8Ndx5x4xeLpkG
	N6W9J+sV9EpIS+yvfcNzvnL380QNMYvnysFL8NZtsYE6uK+wG1P1ZZyQ/8rzVz0cDLPCBP/Jf1A
	pCKlakERxSa8lX8zdStZ2GquFLiUjeFbJoZVSjmgxSfzJceE6AC748kyzHCIgxFIS3IURaGH7fE
	x7FLiSC1g52yVPESzekIzQAEz3ihbWCStVIOWtfABh7v/j5C+49E3w25M2nrs4+cfNwsTlJ4daw
	ZV5vkO9mMplJgwtNaxP1/VNKS3Qtwgidto
X-Received: by 2002:a17:906:d552:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bf93a00a5c3mr170280066b.49.1781018006681;
        Tue, 09 Jun 2026 08:13:26 -0700 (PDT)
Received: from Ansuel-XPS24 ([2.195.136.12])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bf0517721e5sm1073637866b.9.2026.06.09.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v6 08/12] of: property: fw_devlink: Add support for "pcs-handle"
Date: Tue,  9 Jun 2026 17:12:04 +0200
Message-ID: <20260609151212.29469-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609151212.29469-1-ansuelsmth@gmail.com>
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297111-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04E07661BD7

Add support for parsing PCS binding so that fw_devlink can
enforce the dependency with Ethernet port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 136946f8b746..e6584a2f705d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1392,6 +1392,7 @@ DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
+DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", "#pcs-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1548,6 +1549,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_access_controllers, },
+	{ .parse_prop = parse_pcs_handle, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.53.0


