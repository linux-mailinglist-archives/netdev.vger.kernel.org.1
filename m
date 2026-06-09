Return-Path: <netdev+bounces-296853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8fNwAah1J2qIxQIAu9opvQ
	(envelope-from <netdev+bounces-296853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0965BCE2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:08:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LgajasKG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296853-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296853-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43E483069C3F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71E35EDA4;
	Tue,  9 Jun 2026 02:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7849313E34;
	Tue,  9 Jun 2026 02:08:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970902; cv=none; b=RGPw/r2dpXJODm4HacUs/QW1UqtZ63hgP4kbdKrKAvgNGD6JoAeCG0qdz3qysSqNYgDpjwAvRHKsxQDcpKdIoFHZ+P11XGOkzqv2USs39vH5ORQo7Wd3fTNskrQsMKE+9x0VSBL85NnZHc00hnXeiQo09b+VmeosoGNQXr5ANIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970902; c=relaxed/simple;
	bh=c7JD3w02JBo5tsTPDMmw4GptFNlt/PbYFnc2NsI8qaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiCHrWJx7BHAb2up3iMX2RAqBLtO2uYOIXycIWe+wL0vf2roW1MD9QpjQWbTwzfW7F6Up6o3ux/6efkEklMAOAJCyh/Csmc5V0awGm3n2WOzlhmfkeXNlcA+80j4d0ncGzWUDSDZRbV937EzRNeW+xxE9kRE7Y7rf8gPYj12AMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgajasKG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22211F00898;
	Tue,  9 Jun 2026 02:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970901;
	bh=fsHEdsO8gQZ7KC1cppmjOB+DDC9HC3XZJCn72ObCXLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LgajasKGMygU6JenratQCZdYHxi5XgKKuGJr6rYg4jBIfWny22QRAo8U9cEeJv56D
	 ccYDvKLs5WbYIvKvXIwb4YJuOICx5fQe9dQwrwMmEE0J8ruc11lfqQs4KGBoTuzZA/
	 fys19H8Pi228p2NN4VzMLVqaQIQh/vhvBSzl9lfEq2UhJbdQ/56uTkNAMYDrdFo+J0
	 6s61qeiGOtruVcKNRjAHV1Hu/23KGjojoZYDWfYjRBi8uCLYQgRFak6iSXQpXlhpGY
	 tH3QZpsI13qnkOvBizLMgbOuN9tWSU8nyKlfp9t2ZVDCN5h6rkrjHVPlmj9lZxPtFD
	 fFh1J2T8ogGwQ==
Date: Mon, 8 Jun 2026 19:08:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
 <bobby.eshleman@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman
 <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260608190820.71785304@kernel.org>
In-Reply-To: <20260605115314.552321-1-avkrasnov@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,bytedance.com,linux.alibaba.com,kernel.org,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EF0965BCE2

On Fri,  5 Jun 2026 14:53:14 +0300 Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further
> support easier, rewrite it in the TCP way.

Does not apply:

$ git pw series apply 1106582
Failed to apply patch:
Applying: vsock/virtio: rework MSG_ZEROCOPY flag handling
error: sha1 information is lacking or useless (net/vmw_vsock/virtio_transport_common.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 vsock/virtio: rework MSG_ZEROCOPY flag handling
-- 
pw-bot: cr

