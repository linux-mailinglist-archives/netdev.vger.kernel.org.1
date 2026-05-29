Return-Path: <netdev+bounces-292907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCiJNCvgGGrZoQgAu9opvQ
	(envelope-from <netdev+bounces-292907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:39:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F85FBBBC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB2BD3019A3E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F2349AFF;
	Fri, 29 May 2026 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huhxiir7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F42E4257;
	Fri, 29 May 2026 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015142; cv=none; b=L8aUPvpucWBHmg7KhAHNZiJObLD0s8fB0UiLHdKFe3gBGkaP8yv6ChLsI4d3EdEKy29wSkMydYfm+URRYtzXDuFFis/5lyhw95X4QzTRwiHDrVL8ns1gZqIbPBtZ+xH4Sqk6wW1NqJOv8BTMlGWmxWvmfe/w2WktXtD1wT+9LYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015142; c=relaxed/simple;
	bh=wmkqND0RB4BEWyT55XJde4kQAJdn+3ZUYCYnmGfe2KA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sczRBowi//vYs2PAU8anqeXx4Wh6eM7CR2u175BXSLhMwiK/eZtxw+o88ds0j/WTDelH06qqikIX4Sq/qXyANXO/dQfAl0/K4/6249I5qvhD1XJ1HJC6mkwmU6GH/CzhaA2+seOULVhhjn09Y8o4Iv82Heh4vcV5XX3F/f9T/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huhxiir7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD0D1F000E9;
	Fri, 29 May 2026 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015140;
	bh=S0LhC+L7ew0JwAUKzb7htSG+8KHzDbUfZ+uer8crve4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Huhxiir74PyJdqHzFCx/VC7sOg9xcgOt2UIExXN4OjrzpRRIxL5udOeZOX5IWMPUY
	 Gxah3mU8eTdd6Ol+C+nOSSNLD9ABwLtEVZ4A9hEa9lbYQl41i3V2qSu63cZN8/Kb58
	 HAWSPpVh3Mls+N6dj+q5ESN6LjQ41QfpzqQO3klv4BnE9D6nGOhfyVNHkE2JQfBSV0
	 dgHApsPOfNZEf8KPP7MAErX+0XEINmBRUirb6nENwokaulWf+L63nzvCI2acrhF9Kt
	 ofaMYNQl1qgMBVBu7fcuTGVi6PZIAv+geeoUBL6+XWuB9Oh6Weac80vr9IryXGXj5T
	 a0PFjOxcuTcag==
Date: Thu, 28 May 2026 17:38:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: microchip: sparx5: clean up PSFP resources on
 flower setup failure
Message-ID: <20260528173859.04fd6c27@kernel.org>
In-Reply-To: <20260527073855.2334001-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260527073855.2334001-1-lihaoxiang@isrc.iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 379F85FBBBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 15:38:55 +0800 Haoxiang Li wrote:
> Add error handling paths to unwind the PSFP resources that have already
> been allocated before returning the error.

Does not apply, please rebase on
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
and repost
-- 
pw-bot: cr

