Return-Path: <netdev+bounces-293951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCeABkw6HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4EF6270C0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D894A3007ADB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A923451C8;
	Tue,  2 Jun 2026 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCqKa0PT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D634252C;
	Tue,  2 Jun 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365892; cv=none; b=MoFXV6Aqde+eRwJHVyzV0ijTZl4eTdK+cSYiHGe5DcDGdtcoHwIBupPhLF84oewWTAM02+s8T4ddwKMlfRbJKwq06l0oX4uv0axujatHAE3TCelXrAaiveQHlhM0sjEnRr9iHb1H6P8XYMPBgIhSHwGU8wcv7yoHP2bMWmmMc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365892; c=relaxed/simple;
	bh=qHKbtUgtwVTGybZ7nKUktJYOqjAnTtS8J+VaGNpeFx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvkO7v2V1HuzIqTh43GF9sPtmy9yclGDs7fQp2ml+E2uUS8VQrwN0q0FPO1xpvkeiAuIl6Yv+j6Mjn+9V9Tkgoa92Kb4SFWW6+/cNqGtEw7AdEGAm3LD7643Sd/9n4h9aWs4nSRbIt1GOIOCOIlyapfzw71Nw6ZsG05eaLh7AQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCqKa0PT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F551F00893;
	Tue,  2 Jun 2026 02:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365891;
	bh=7sBWfnpnuBX0muOPRmrztFzsv6IWCIJdnkmiAQzY9ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCqKa0PTwMNa7bcRRNVJ6RY0Vp7anwwfNLv5gA2zH6//vKdntaM1grjRet7WAJ91w
	 iJCcM/h8pLmuuKFVl9OSn+eUXTty/6dICkT4lIn471ZDB0HpFpNBlM4qN3U0jrBHgC
	 waSdYkH6crUfosc+GwTCCeRY5tCVx3loLTSMZbi9wokexVz0emcGudl8UQZqYa0dKl
	 i8JteF7Q6I23w1RuKR4ewDSm9AD4lj/y58nIhFCYHrGwOkC0vz+TtCGwdRZgNJ4TMO
	 xjddrHlwil6IMlKrdJaDEcLhhnHwi+5Cf21wCGmeMoCnv4rpQCYAD6d0m6aFRQrpb6
	 mGWUJzsmdf7Aw==
Date: Mon, 1 Jun 2026 19:04:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] vlan: fix REORDER_HDR race between header and xmit
 paths
Message-ID: <20260601190449.679a2f60@kernel.org>
In-Reply-To: <20260529073136.77179-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260529073136.77179-1-zhaoyz24@mails.tsinghua.edu.cn>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-293951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC4EF6270C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 15:31:34 +0800 Yizhou Zhao wrote:
> vlan_dev_change_flags() updates vlan->flags under RTNL, but the VLAN
> data path reads the same field without RTNL.  In particular,
> vlan_dev_hard_header() and vlan_dev_hard_start_xmit() may observe
> different values of VLAN_FLAG_REORDER_HDR for the same skb.

Does not apply, please rebase on net and repost.
Please add a Fixes tag when you repost.
-- 
pw-bot: cr

