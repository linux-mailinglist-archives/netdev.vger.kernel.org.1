Return-Path: <netdev+bounces-268363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULwILBemuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:53:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130062A25CB
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B3A302D5D4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8D23909C;
	Tue, 17 Mar 2026 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEiFpola"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41302367D5;
	Tue, 17 Mar 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708730; cv=none; b=hBtbLSTLY8cdaI3xTBRKSH3wcPNWZTJq0PuG15oAQLXiZtBcHUMD5gjNqw8MXVjeCrqI2j5MoMwQCF4oxnsHEvcWXp5V3SvE9+So1p7TiYR0X7HhyEHeLjs1pnq2ZCdqcyHF9Xd8pD10TDHXqsj5t/DQmd2L2v3mP9tICGWVrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708730; c=relaxed/simple;
	bh=+0iqwdVhPk5ZGLF8d9XGnhWjF8iSMfOaud0rGq4gkfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHwcV9U5czG/1U/asT1eHHMkGWmM0pxvIfJ8UnlwaPjcAwo9XxSOTcZS2GA2vXgjGLwgC2R1Kx+aar940ZKyrtmF29cfrYptkINPceiUOfiQc8DZKtVuHuxPgLgt+s2z6djFLQm3LRPy0wlUPdectRLKvFiVSMx9EBQzEbfUwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEiFpola; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE9C2BC9E;
	Tue, 17 Mar 2026 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773708729;
	bh=+0iqwdVhPk5ZGLF8d9XGnhWjF8iSMfOaud0rGq4gkfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vEiFpolah1Ig1QUMssfx2JDExWznmhUfUt5YyOW66y8/qHcAizWA2EY5oy+EYD8RH
	 hv3U03rfx9xs0B4MYGxtm2Es5zNdBI9a03Wov5TrndAXylu/CHXCgTZPdD+LnYP0Zx
	 YVeH/iPbLgmsAZebm37/3EgYiKXntiIHzwJCRvXA601IzHbZqXOa1EN+cici0/WEs1
	 6NkTuqno0PXYylS60bxQ7dcvfOjZlQxabAdoLRQqjM3CD3UVbdC3F/ccDTPbgLQHCb
	 X7Mh+84CfaHF570aT5BPU+HpmwBlg97KaTTD9lFfdC4TJAoQOC0FMCVRL3hWqtbIw+
	 2tp0dEtlr2voA==
Date: Mon, 16 Mar 2026 17:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access
 and ADV indirect access
Message-ID: <20260316175208.3e14385e@kernel.org>
In-Reply-To: <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
	<20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268363-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 130062A25CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 10:31:38 +0100 Birger Koblitz wrote:
> Add support for the SRAM access interface of the RTL8157 and
> the ADV indirect access interface.

../drivers/net/usb/r8152.c:1757:12: warning: unused function 'rtl_bmu_clr_bits' [-Wunused-function]
 1757 | static int rtl_bmu_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
      |            ^~~~~~~~~~~~~~~~
../drivers/net/usb/r8152.c:1788:12: warning: unused function 'rtl_ip_clr_bits' [-Wunused-function]
 1788 | static int rtl_ip_clr_bits(struct r8152 *tp, u16 addr, u32 clear)
      |            ^~~~~~~~~~~~~~~
../drivers/net/usb/r8152.c:1793:12: warning: unused function 'rtl_ip_set_bits' [-Wunused-function]
 1793 | static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
      |            ^~~~~~~~~~~~~~~
../drivers/net/usb/r8152.c:1810:13: warning: unused function 'sram_write_w0w1' [-Wunused-function]
 1810 | static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
      |             ^~~~~~~~~~~~~~~
../drivers/net/usb/r8152.c:1824:13: warning: unused function 'sram2_write_w0w1' [-Wunused-function]
 1824 | static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
      |             ^~~~~~~~~~~~~~~~
../drivers/net/usb/r8152.c:9807:12: warning: unused function 'r8157_desc_init' [-Wunused-function]
 9807 | static int r8157_desc_init(struct r8152 *tp)
      |            ^~~~~~~~~~~~~~~
-- 
pw-bot: cr

