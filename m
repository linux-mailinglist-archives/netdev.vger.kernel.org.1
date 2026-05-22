Return-Path: <netdev+bounces-290877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPbtCYd+EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821105B751E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1197B3052896
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BF3290A6;
	Fri, 22 May 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIw6b3Ue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35C324716;
	Fri, 22 May 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465633; cv=none; b=GKePNVj/piWFaIq8iSTePUwgNFU+UtQQ9ziGqwAhrgJeIGbtocAP69jOlF8GLb5dEc6XqPvpsEuaCF6oISVFWkXgpwPh/5zKl3r9zXad2jkoqjFCn2k0uo/OiPxpCu6TOLRWIUZDHX2Hdq2/jLfOMldc5p4z33C4KG+4vHRTtY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465633; c=relaxed/simple;
	bh=UiXZ8JxAnrPkG9Y6NqMCwwaXg5q5v1IigEOPGsruZi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lStDLacO564tGzuqW/2KaxDJbZOa1e1UIFfW/cO2CQaUeh3c5FfyoohLW1d6WttfSzCvETBlH5s1ujqhlYJhRGywDuv6NJII999iqNDaKLJEOMDBTyvKTi4BcEr7jh0YuirI6M3EWOSEGGEog6i2vMNvn+zUWONjgpuRut16Ahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIw6b3Ue; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B61F000E9;
	Fri, 22 May 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779465632;
	bh=xSP9TnreoMiB9fX38i3rOEo3HeJ6iDoibDLyG4Gjw2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FIw6b3UeGGRgOcrpYajP1NzANMYn6nZr+e53xodXSNx/qQ0+Gv8h67LwyxXiUl1Hg
	 xcM3zI/aN3BbSZgxQk9fP/M7pyh1VCv1x4bHkhulM9qAwN4mIiZ76KAwDyYtNUH/Ro
	 ailD0ocCgQSXqCJtcWVjI534XiSOEuJBwlT0EC69CwfxyLQBDrdiRu+aN7caeO+M8H
	 b0VNRYAc3sEJVt8fBTXZVKQ7a2Uxl/VFtjCCxgOL8wTXqSkCWtRZccVbut5dk6kSmE
	 mzzd3W5/1gTzAoe1o8mI8Ba7m0YXWJZteN/+XMN0WWf2EXqYfaR90VhKKfTIsEVMOC
	 DREjkYWH/Kd2Q==
Date: Fri, 22 May 2026 09:00:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] Add OVS packet family YNL spec and
 unicast notification support
Message-ID: <20260522090031.40e809cb@kernel.org>
In-Reply-To: <20260522032447.238715-1-houminxi@gmail.com>
References: <20260521022002.879334-1-houminxi@gmail.com>
	<20260522032447.238715-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-290877-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 821105B751E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 11:24:47 +0800 Minxi Hou wrote:
> Sashiko flagged a few things on this series, noting my analysis here
> for the record.
> 
> The dp-ifindex field is typed as u32 in the spec while the kernel
> struct uses "int".  All three existing OVS specs (ovs_datapath,
> ovs_flow, ovs_vport) also use u32 for this field, so I kept it
> consistent.
> 
> key/actions/egress-tun-key are typed as binary rather than nest.
> This is documented in the commit message and inline comments --
> the nested attribute-sets belong to ovs_flow's spec, and YNL does
> not support cross-spec references.
> 
> The execute operation does not carry uns-admin-perm in the spec.
> The kernel sets GENL_UNS_ADMIN_PERM on it, but none of the existing
> OVS specs declare admin-perm flags on any of their operations either
> (ovs_datapath new/del/set, ovs_flow new/del/set, ovs_vport new/del/set
> all have GENL_UNS_ADMIN_PERM in the kernel but omit it in the YAML).
> 
> ntf_bind() will raise OSError if the socket was already bound.
> ntf_subscribe() has the same constraint -- both expect to be called
> before any operation that triggers autobind.

Your explanations sound reasonable.
But please rebase and repost, I think some patches merged yesterday
will conflict with the new ynl helper.
-- 
pw-bot: cr

