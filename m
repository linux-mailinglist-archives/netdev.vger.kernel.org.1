Return-Path: <netdev+bounces-276221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCN1Jneo1Wlf8gcAu9opvQ
	(envelope-from <netdev+bounces-276221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:59:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752D3B5CC5
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF4C300954C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3D322B74;
	Wed,  8 Apr 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtPNTtMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707A3242B2;
	Wed,  8 Apr 2026 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609948; cv=none; b=J96v2wqH66eNCiLDrRRkXKqif3vD85maqkkNIHAC8fdRT4fs9D9uQn8PWIK0ucageciiTcMjWh8zkkHBtLvn1epz/fxfsuGWWEkQ+oWjxfyCeoanOwYgYlYf+h9Kfdb8S8o4AehNu/ILdlDKF8jqXEFW80nvr/LsUJNhWRbfbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609948; c=relaxed/simple;
	bh=o8JL0K1oKB1JVDgFNu0cLWvhRHTmlprcR6C/VwYen7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9/GNnUccBKLe04o/uc/z1LOqaVSVljMXtUu2WF/9g0blU9ra03kL/P6xQCwpEYe+DGpKk4TVy2fet86UKQ84Sdl06cWMGf2jrdpAON0KvKJ1fgFFXtjrY04XcBtewUmLEeQU7MSA/L010BZ7Dx29/oIodB1pGdX4UiGjvQiBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtPNTtMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8819DC116C6;
	Wed,  8 Apr 2026 00:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775609947;
	bh=o8JL0K1oKB1JVDgFNu0cLWvhRHTmlprcR6C/VwYen7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtPNTtMq/OJ610VcZNXbYohmjoIE4xsd/q1VXxJhTdIVGmt9BYUj5F59M4cipIvON
	 dhagPWhadBFh4JrPQgxpOlvhGHjsCzXKHKmh0zJqoM/91PxpFnoahJ4+93vQsIoE2s
	 Q5kuGaKL16NKIj455JtNUs7Wu0vSdUk7TTP4sw0lJEr5q54rZHHVQdrqvnjwuBsSoi
	 kza2L8xD8miecKRSK9ouKPekEohE6rDyPlLVFrfI5i9XIiNM/afXRkGI239ao9EPHT
	 FIoMz0+FaQZG8Wvje59RQNqfRqhgGCMyQafBWd1zGVZiEwiVboxfAnjLihdrXpyGt/
	 D3R+cH0HRXtkQ==
Date: Tue, 7 Apr 2026 17:59:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <20260407175905.02439816@kernel.org>
In-Reply-To: <adUvRegULccN0hiL@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
	<20260407121515-mutt-send-email-mst@kernel.org>
	<adUvRegULccN0hiL@leonardi-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1752D3B5CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 18:22:57 +0200 Luigi Leonardi wrote:
> >> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> >> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>  
> >
> >Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >but I think we should drop the Fixes tag.  
> 
> ok, should I send a v2 without the tag?

Yes please
-- 
pw-bot: cr

