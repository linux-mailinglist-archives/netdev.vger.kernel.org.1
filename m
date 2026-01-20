Return-Path: <netdev+bounces-251654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBzKMOsVcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:55:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE84E2E7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0EA74F14F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B28740F8E6;
	Tue, 20 Jan 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcuZNz+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBB287272;
	Tue, 20 Jan 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951131; cv=none; b=XiqP9ujPJYtgZDwibFaSveH1CtU16TzTbMB5mawwYXDlvqycIsUY4u0II/qtneM/gNV4ojPyZ2femea2OEF29W5+CioylEIZpf4tlO5mpyjteYO0GvcGq3rOsYoRNwPfGXZMp2FhUg9C26tYtLN3xsDJ7BjyKDA8zs/EwSF+ilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951131; c=relaxed/simple;
	bh=rhIdiglnXjC0fp1zFEv/hrjRU01KuohsJ3nh01dHPZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehPcmV7OYPiG7mpB6ZYEM/Gm2ZQ09du3TYVQ0E34MYIxu8bV7YwD3nnPXOa5rzdrfvXTHXuR2xGzQavh+DEDrs7UZr0mt4uaBI42t4dAhPwiJ4FOSTLgKVgZLl35esjjrdGPK5g73N0zdigCA9AmcsyyA9L3t2Uilu5zqRMui5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcuZNz+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E3C16AAE;
	Tue, 20 Jan 2026 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768951130;
	bh=rhIdiglnXjC0fp1zFEv/hrjRU01KuohsJ3nh01dHPZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UcuZNz+Dz5vDY7oXixLokeQoeFSVugCZYHuoQ9XjL/TIMruJqEQAN2pdsC4doEc5t
	 Gh9iS3JA/lfT/CpEf8uK8TmwTD4otAY4BWtkiWz8c9jpq84/y+LSo7CQFdpYJtjNkI
	 YVns2IwOfjfwvkigFuTqCazbh5vijzjaIVQ69T3T/L8DeLdNV55/7enL/PHaaOrkOi
	 fGlqpNmdyka56Qiyx2dqAvakjpcBbuTnPlEESdUiUN5uyINwHWtnSQ4bAo3HVS474z
	 w7+JIMPqFwF4fFzjBnkpTQdAuE+L7JBddUaLegSZCL7ddyBkz1V3TXqqcWn0szFHuI
	 sYkPrXUpBXt4w==
Date: Tue, 20 Jan 2026 15:18:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "Michael S.
 Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, kvm@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang
 <jasowang@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Asias He <asias@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <20260120151848.3b145279@kernel.org>
In-Reply-To: <aW9L0xiwotBnRMw2@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
	<20260119101734.01cbe934@kernel.org>
	<aW9L0xiwotBnRMw2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 37FE84E2E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 10:37:12 +0100 Stefano Garzarella wrote:
> If you prefer I can send a v6.

We'll need a v6, patchwork can't do its thing if the series doesn't
apply and last time I applied something without patchwork checks it
broke selftest build: 
https://lore.kernel.org/all/20260120180319.1673271-1-kuba@kernel.org/
:(

