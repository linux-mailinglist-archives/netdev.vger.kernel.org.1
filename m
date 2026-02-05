Return-Path: <netdev+bounces-256966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLYSGr0phGna0AMAu9opvQ
	(envelope-from <netdev+bounces-256966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:25:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D8EEB35
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A913011C47
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964531AAA8;
	Thu,  5 Feb 2026 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otZ6UgEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BF1F471F;
	Thu,  5 Feb 2026 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269113; cv=none; b=d7Kqt/7NyPLIJmATiYHNrY43A1eyH3hLJ0jEoqWGGc5VtH1lKYrfjJJ6vv7TeZG8j8uCNX2+MdHgjqy0uAOeXDcdd9iaI22hCJJCB0wquO6j0zamNoe8wLN6hMKiCwsIe4QlcUmHJb05hf3vwdrhO24e1BfqNSyx4JLbqQXhOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269113; c=relaxed/simple;
	bh=yGdsgCTf1QDzagy1MDmADcs/xYLOANpJBIngoj1gkM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUJCFDCXYHNUliqHCTsozZaZLQvGJFoaQYF0sTUS7J3rDhQiK6GpSpelgJ7LE5aOl/kg75mdFEbApO7sGtBAZCTDjG4R5rx8DWLW0uaOlu0njZjQZMXKol57Ejn0i0RNd9JFR1b5Jp86vZV3ZCLMMvmedByTnRa/woF35p3k5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otZ6UgEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD3C4CEF7;
	Thu,  5 Feb 2026 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269113;
	bh=yGdsgCTf1QDzagy1MDmADcs/xYLOANpJBIngoj1gkM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otZ6UgEcQaXANvWbc/+4y7DpYVVXlME57f/FfVI4OXTkjmbdbw6ixPbJKwOuFFUCB
	 ulkZiRgmc/HXBm9HhxVJr4zE1PVmuAj7MuaorztuF0yfjCXRE3WLX7pomnXkch8OWk
	 He9zqfThzs8i+Ph6kqTEHn8jkMji3B2wshA3O/5sNuOzgZEGCthdrm5u75Ru68PSd4
	 ciFV14yeyhrcsaJr+7pxnVxIkzQ1W6jQmS+ApmcpRkSFR379U+vGpExvG2bsCakiZK
	 Ctt8iadUOjO+Zp7HpzMWnQcplEpz6NcPRO0553sfaRpeL+CXYBekYcLR099hwEEZ3u
	 AWf9yCnbd7Cbw==
Date: Wed, 4 Feb 2026 21:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Wei
 <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260204212511.017153cd@kernel.org>
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
References: <20260204193617.1200752-1-vishs@meta.com>
	<20260204193617.1200752-3-vishs@meta.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C03D8EEB35
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 11:36:17 -0800 Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.

TBH I wouldn't bother with this.

We run full battery of driver tests in netdev CI, there's not much
value in a dedicated virtio test that just runs iperf...
-- 
pw-bot: cr

