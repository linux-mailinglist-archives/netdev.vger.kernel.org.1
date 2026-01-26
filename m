Return-Path: <netdev+bounces-253298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDbMOMS2dmksVAEAu9opvQ
	(envelope-from <netdev+bounces-253298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 01:35:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9A83358
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 01:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D17C83005E9B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC617260D;
	Mon, 26 Jan 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StN5kJ9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBA625;
	Mon, 26 Jan 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769387712; cv=none; b=puEiRW2aiGHImQhnansa1YQWeYUOKLEL/YVSaUPtndf9UrDK6N8Oa6v17FQyRggcELz7pwinRJDappm0vatIMwXzVN4PYxqwkLEz2TmGV5LQPjDItD0mrwpKu/jxbsM2W0eR73ssIP5laZtgegz7exLmPlEKFIBxhjBx9ZXEoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769387712; c=relaxed/simple;
	bh=UPQoK1ge3az5sWfMSPCewv5xcDr179Pzfg1pOZpPjrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ji55uSwBHEmtN60mY7VxBu+V6d/JJsRKHA4DBJ6rg3ogUSx+V6CXEIa7nMZO9DLqFZIx1nyUhODO9tAJgq3tH5APIUrMkmT8p54hE05+oVaVGhbQD4QcskjFthDGTsXXy2+DQshTWJhSr3Pw0jF7D7kExtzzqFkOgdkHn/fF/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StN5kJ9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8106CC4CEF1;
	Mon, 26 Jan 2026 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769387712;
	bh=UPQoK1ge3az5sWfMSPCewv5xcDr179Pzfg1pOZpPjrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StN5kJ9Zffbb7bohQyX5TgM0rQPH5yf0P0HPrka2oW8956lqitlziLCBsLVljcF/1
	 HIH2xlx94WbJRnekZaJiLbC+MbkCS7JSFKg2NXKiyIjZDRqJHNEmnXCIFX91gTqSgj
	 //j7N5aMGBYqgr9aXx9U9b2rKA/85bN6swIZNv4VXIBgDxL9LLI8d3f3OHK+cip7QK
	 YW0z6/9Y+yPRAoOCQ2R0d7OP3LQUP79ZtZPAWAivg5Nc71q5IGJYn91BEoaUmopJGv
	 MCppXfRv4RBZTJBp4wBtsxTsWhYZ+eHfj41f+QsTzbmhvG5wnxxC7YK18GjXT4suvy
	 t+yQFG6W2Lh/g==
Date: Sun, 25 Jan 2026 16:35:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: airoha: Use u64_stats_t with
 u64_stats_sync properly
Message-ID: <20260125163510.4c5ea4df@kernel.org>
In-Reply-To: <20260125220753.3984326-3-mmyangfl@gmail.com>
References: <20260125220753.3984326-1-mmyangfl@gmail.com>
	<20260125220753.3984326-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73D9A83358
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 06:07:50 +0800 David Yang wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.

The driver takes a spin lock over the very expensive series
of register reads and then drops out to copy the just read
values? Just move the readers under the spinlock?

