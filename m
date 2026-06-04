Return-Path: <netdev+bounces-294985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yaJ9H1jIIGqA7wAAu9opvQ
	(envelope-from <netdev+bounces-294985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9E63C117
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:35:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qq34Hxwy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294985-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294985-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF1A300F5CB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215101DE4F1;
	Thu,  4 Jun 2026 00:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CA1A9F8C;
	Thu,  4 Jun 2026 00:35:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533324; cv=none; b=SIdQ86ssR50Z229zkhLicVVdBel/3zyrRJeC34NUJ0ZfkJfrUN6N+qs1RHDYSUBi9dm9V/ZNPuJ8RHpM7dgMYMCRwIcBt3fuAneoJRUN3q5rUZPT46+/YUCcauPcWnOx/spv179xh6pLKceJkdo1tU0xtPD5z2B+zMDELS7+qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533324; c=relaxed/simple;
	bh=A2z6SNO2yjt0fs9+wv1+olxQ5q1Fodgv/wh0LodXQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzzsKY2/8wWEVV78VSP5BwKUjNTl4tcZ2jlibQrLQrUWL8MUv3ePskzmtOul/rQwuB2wfS54Weps+YDrWQkYVda62noP6R2DcPDsdRvNuDx8FBbWlcy0DVgUoElMH8SgxoLxabPedvQyc+7TrD0fELwHQp7q5DsFlQxnTc/n9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq34Hxwy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201901F00893;
	Thu,  4 Jun 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780533322;
	bh=ivkg/2iVEYSrJRcHW047elvXMjgLlnJ08R3bB5mu1/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qq34HxwyttNAhGfOKtjS9FM6eDddvrXpJ1l+7F2vKSnyw5lRu3DClqmfbISpz8YAO
	 pARmvQ7hzJgMoUTJWAF2smaWNVlUlJ8x2Wg/ysQyZhvAxoJmJfR0FJPvAy1FkXI+Fj
	 xw9+n4s5O4j0SWFwIIHfJuwy0L0EjuuiLsLtKQrzusBS2Yylg1ouzs8n1pVefM5aRH
	 +MSpL1o9aM7BttP26ACMozLzRe5x0KwAN6aefYJrRU8z91AVP6lO9CJ9VDKTKxeVJ7
	 uZtFwDUXsIefnHl0rP09Mu+3ysv70geVKUdVEZHFKCfv6KLSk6Zwg8J4gSMj0Camxd
	 s8jKlVDkwko8Q==
Date: Wed, 3 Jun 2026 17:35:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH v2 net] vlan: fix REORDER_HDR race between header and
 xmit paths
Message-ID: <20260603173521.53c87f62@kernel.org>
In-Reply-To: <20260603081018.23901-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260603081018.23901-1-zhaoyz24@mails.tsinghua.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mirror_vlan.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8A9E63C117

On Wed,  3 Jun 2026 16:10:17 +0800 Yizhou Zhao wrote:
> vlan_dev_change_flags() updates vlan->flags under RTNL, but the VLAN
> data path reads the same field without RTNL.  In particular,
> vlan_dev_hard_header() and vlan_dev_hard_start_xmit() may observe
> different values of VLAN_FLAG_REORDER_HDR for the same skb.
> 
> This can lead to inconsistent tagging.  If REORDER_HDR is cleared when
> vlan_dev_hard_header() runs, the function pushes an in-band VLAN header
> into the skb.  If REORDER_HDR is then observed as set by
> vlan_dev_hard_start_xmit(), the xmit path may also attach a hardware
> accelerated VLAN tag, causing the packet to be emitted with two VLAN
> tags.  Conversely, if the flag changes in the other direction, the skb
> may be emitted without the expected VLAN tag.
> 
> Avoid making the xmit decision depend on a second unsynchronized read of
> vlan->flags.  Instead, use skb->protocol which was set to vlan->vlan_proto
> by vlan_dev_hard_header() when it pushed a VLAN header (REORDER_HDR off),
> or left as the encapsulated protocol otherwise (REORDER_HDR on).
> Checking skb->protocol first also preserves the short-circuit evaluation
> order introduced by commit dacab578c7c6c ("vlan: fix a potential
> uninit-value in vlan_dev_hard_start_xmit()"): when no VLAN header was
> pushed, skb->protocol != vlan->vlan_proto is true and veth->h_vlan_proto
> is not read, avoiding the uninit-value issue.
> 
> Also use READ_ONCE() for the data-path read in vlan_dev_hard_header()
> and WRITE_ONCE() for the control-path update in vlan_dev_change_flags().

# selftests: net/forwarding: mirror_vlan.sh
# 11.35 [+11.35] TEST: ingress mirror to vlan                                       [ OK ]
# 17.47 [+6.12] TEST: egress mirror to vlan                                         [ OK ]
# 23.58 [+6.12] TEST: ingress mirror tagged to vlan                                 [FAIL]
# 23.59 [+0.00] Expected to capture >= 10 packets, got 0.
# 29.70 [+6.11] TEST: egress mirror tagged to vlan                                  [FAIL]
# 29.70 [+0.00] Expected to capture >= 10 packets, got 0.
not ok 1 selftests: net/forwarding: mirror_vlan.sh # exit=1

