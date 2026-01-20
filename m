Return-Path: <netdev+bounces-251657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HuKOVYRcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:35:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A04DE53
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27131A00EF7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F640FDAD;
	Tue, 20 Jan 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3zUt4kM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310438B7BD;
	Tue, 20 Jan 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951777; cv=none; b=XH0g2SJwU7SQmFs+jLZ5jAEwmtVZyMisHoaR24Ch+lOczGz/nGvxZzHMzsTWDKqy4ozigHxu0Noom0gDesnmJFgDhxX6Vt3rlIze5X0C/nVA0bi8pTeb+lDINDR+/bkF2J2HoGctaplJ2cDMpTGjDn/tOe9AAd7RFMGyXhDoaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951777; c=relaxed/simple;
	bh=MnMzxsQi9s5gcx4IbSfF2YZQ7yecHRA3Ds+sFR+OjPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdtmFYsgv9zvbWprEl0Z5UYSEfFLEKCWy7btfFHMSKb3qDghmpos5loIUSYXGNw7+ZUqE9lVxb+IvU/mfyv4tOQgh65fPif5Li1VQAc+MZ8ltiNSFjUuda6Xk0Aj5e6OPPX5r0jyvpZeC+CeJ6Ffx2jdXmkrQI/q7GnT+IyqTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3zUt4kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFC5C16AAE;
	Tue, 20 Jan 2026 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768951776;
	bh=MnMzxsQi9s5gcx4IbSfF2YZQ7yecHRA3Ds+sFR+OjPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3zUt4kM7xp8pW2zQ9Y7Tym1EbX0MG2lETtqOHLfd4Tg9CwwCWtxLGhMwFcJVr3ao
	 VK8fwsjXfNsixuflcIy1qGFCpNFMU4+fXsHkkoOAw7M9v3hXBPrV0xLcPAGdyopOPG
	 ee0ETxm/Q8PxbY5QIdyflybfzvigXdf/Oe4nKLzLuIo5u3fhpZXqzxI6GiKRJuZ1M5
	 YU/LNWZNpWFQqptSjjPSGd7Wh8R4UCpJyrtWtywPovvYUmUXF+35nOwNp3js7E2TXw
	 HutRwTJV+pR3dJIVxhWCpiWmoljkRhtKRhWbFEu1AQl8kHcYidf2noSl8XVFrrUvIY
	 kngWB9O1zmZ0Q==
Date: Tue, 20 Jan 2026 15:29:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>
Subject: Re: [PATCH net-next v4] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260120152934.2eb16a11@kernel.org>
In-Reply-To: <b676baa0-2044-4a74-900d-f471620f2896@linux.dev>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
	<20260119083759.5deeaa3c@kernel.org>
	<b676baa0-2044-4a74-900d-f471620f2896@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251657-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linaro.org,goodmis.org,efficios.com,davemloft.net,google.com,redhat.com,gmail.com,linux.dev,shopee.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 947A04DE53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 11:16:20 +0800 Leon Hwang wrote:
> I encountered the 'pr_warn()' messages during Mellanox NIC flapping on a
> system using the 'mlx5_core' driver (kernel 6.6). The root cause turned
> out to be an application-level issue: the IBM/sarama =E2=80=9CClient Seek=
Broker
> Connection Leak=E2=80=9D [1].

The scenario you are describing matches the situations we run into=20
at Meta. With the upstream kernel you can find that the pages are
leaking based on stats, and if you care use drgn to locate them
(in the recv queue).

The 6.6 kernel did not have page pool stats. I feel quite odd about
adding more uAPI because someone is running a 2+ years old kernel=20
and doesn't have access to the already existing facilities.

