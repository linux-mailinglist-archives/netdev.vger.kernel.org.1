Return-Path: <netdev+bounces-297406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GMIjBuzFKGq2JQMAu9opvQ
	(envelope-from <netdev+bounces-297406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB2665616
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f+o+2oX3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297406-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AE53038F67
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF002147F9;
	Wed, 10 Jun 2026 01:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CB16132A;
	Wed, 10 Jun 2026 01:59:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056757; cv=none; b=kfIS3ifhww86Pb6WbKZtY+TevgDs/vwi4iP78qbQsgVMUQ7t7vH9aQmB3YmJs9jlMd8GTEkq8zk9YaQLRMA//JO+d/XP1vd4vKfxhI/r2lIklWEJ00t94Eyjvhg2IbJGgGdq8r/8o7KuwASHh2s5Q8HKe+8pOmtuoz+/IqsSeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056757; c=relaxed/simple;
	bh=21kY2+Fqg0W8A8HmNPWueFtJrpgvxP5JBgkaXuBI+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8BJ6dXBlzkh2BCGmgKkgBgKO807xmWbsr4CviaAtQDtNnEAfSy2v/jP1OHJO9R0sIAg3hhbkolAxcPB31VxlatAgMA9iCjShxEwwstgbeube2cMnFYQ5BW3I6r2ij4logHj4uFxa4TXTXcm1MNZIAnaypIqXR4vrSV4qNoS+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+o+2oX3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CA1F00893;
	Wed, 10 Jun 2026 01:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056756;
	bh=LMo1YyeYGJbjVv1s9cUp1DtWyjbOOHVtkp74mFCuma8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f+o+2oX3F6xjQkWgOdSyDCvfM62GSugEJzF8gOnm6aJ2VwDMeijjoaAOiTqG4juxo
	 mzR3Cq75lQ5W6N2aXbk2ZQySp31dVk6/Y1uGywl6elSWasftdhogSHOfX3INHqSbH8
	 Zd7dEu2y55bOzO6k9JeLLm94Aj8WKBPjKUasGgdkFvloaBy4QMBluKIB4h2NOVCDlM
	 RU36YAEKBv5e22iFW6a+o0JBojQ1yobEzW1WacARf+AqWrtl4XwcYRQcUcrLSEVY51
	 bufT0ZwISiLju7NiCawZH0TfrE6n4xl/FV/rGBXqbrZ1cKuMW8Q2iiMb+YJ1wWP44N
	 eh8gPYgF8PKSA==
Date: Tue, 9 Jun 2026 18:59:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: sja1105: Add rev-rmii support sja1110 devices
Message-ID: <20260609185915.7aa34d8e@kernel.org>
In-Reply-To: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
References: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297406-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martijn.de.gouw@prodrive-technologies.com,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CCB2665616

On Mon, 8 Jun 2026 16:16:51 +0200 Martijn de Gouw wrote:
> When a rmii port is used in phy-mode (rev-rmii), the ref_clk is an input on
> the rx clk pin. Configure both the rx and tx clock source to use the
> rx_clk as external clock source input.

drivers/net/dsa/sja1105/sja1105_clocking.c:969:5: warning: no previous prototype for function 'sja1110_clocking_setup_port' [-Wmissing-prototypes]
  969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
      |     ^
drivers/net/dsa/sja1105/sja1105_clocking.c:969:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
      | ^
      | static 
-- 
pw-bot: cr

