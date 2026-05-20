Return-Path: <netdev+bounces-289697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDoAAB8TDWpUtAUAu9opvQ
	(envelope-from <netdev+bounces-289697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23C586A14
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0723C30209E4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FF2DF719;
	Wed, 20 May 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32cewKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A81A316E;
	Wed, 20 May 2026 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241754; cv=none; b=rrhjMKN3eKlLTeBGGGYe/Sr6+XZlYCHeRtH0OypHGiy6TEFZO2fhxqySEi1BC1ZidJER6vDPSsgm3snfpfC3oD2DNNMjtsWVfHe5cF22hv4y5CULhaj/DCn9AxR8sNQYq63oRX3X8PEIFb6nKjC0obBS4e8mni1fTutLXn3Fc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241754; c=relaxed/simple;
	bh=AhymG6cy2liaN1yN5luH1H+RF/bYVemyN4rEVk0XYMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0RV3gWFV7LFghRTOZKpOlra8NnoOyuuPr4lEdnmbop34/1sMBbVMTldAVH3euQ4kGT+nKS2RrpkwICl3C1NT2TpFAz4Zz5hX5Z/mDgR/KrQq7XLNXU0fHwEAxlL3Am6ETq4EyfuUqpZ9Px1iwBfH6R/rDWdRCH4H+CFlyOv2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32cewKI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EEE1F00893;
	Wed, 20 May 2026 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241752;
	bh=bXwiPD50uebpn5rsLXrIZRETt2LvlvnYNhWAe6HOn44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D32cewKILv6MxuLgEM9DcnTCoOnSLQoR7buvW9Km5EmdFHpjn74x6HzCWBxEENBVc
	 xVWyPMNr1oZHxuKwnArHKeyfg+Ut39ZQOsm8yKxA74d1TJHrIA+GG8EGfaUDS3cLig
	 HigXyvvTaE+UdSN7p2R940OSh70P8LdMU/v673vD1VdpADq1PwHoOKOEepkbU0ZGHj
	 DyTTwf8u45fVbvefrFO4Zrwy27+ZQw3wJvtB6s1xq9S7rpxSujpvilgvDWDiqvCZQv
	 C3fryWOWdP19ghyHs+cvqJTsN0uakCqaSs0rSb7F2KJ637U8v987LzsEkSTVsn7bME
	 uLjCkhg0CLpdA==
Date: Tue, 19 May 2026 18:49:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/6] net: hns3: debugfs support for dumping fd
 rules
Message-ID: <20260519184911.3b9e6ff7@kernel.org>
In-Reply-To: <20260518093526.1109595-6-shaojijie@huawei.com>
References: <20260518093526.1109595-1-shaojijie@huawei.com>
	<20260518093526.1109595-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289697-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A23C586A14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 17:35:25 +0800 Jijie Shao wrote:
> Currently, the tc tool only supports adding and deleting rules from
> the driver but does not support querying rules from the driver.
> 
> This patch adds a rule dump file in debugfs to check whether the driver's
> configuration matches the configuration issued by tc flow.

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:2155:25: warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)' attribute to the declaration of 'hclge_fd_dump_ptr' [-Wmissing-format-attribute]
 2141 | static void hclge_fd_dump_ptr(struct seq_file *s,
      | __attribute__((format(printf, 5, 7))) 
 2142 |                               struct hclge_fd_rule *rule,
 2143 |                               u32 type, const char *name,
 2144 |                               const char *fmt,
 2145 |                               const void *key, const void *mask)
 2146 | {
 2147 |         if (rule->unused_tuple & BIT(type))
 2148 |                 return;
 2149 | 
 2150 |         seq_printf(s, "\t\t%s: ", name);
 2151 |         seq_printf(s, fmt, key);
 2152 |         seq_putc(s, '\n');
 2153 | 
 2154 |         seq_printf(s, "\t\t%s_mask: ", name);
 2155 |         seq_printf(s, fmt, mask);
      |                                ^

