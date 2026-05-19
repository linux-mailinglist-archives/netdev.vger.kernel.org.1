Return-Path: <netdev+bounces-289641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMdtGgvoDGpnpwUAu9opvQ
	(envelope-from <netdev+bounces-289641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:45:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512F585CE0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2661300E634
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB437C105;
	Tue, 19 May 2026 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUP8lvw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9A373C1E;
	Tue, 19 May 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230665; cv=none; b=L5XlvmxOrhiSnxNiGIqdYUWZ1Ut6BGnOlZ3mqLzzjqY4r7NO4YYlgjdpNKIFVLSqHsYPKgoEBxVfpvLhMjNnDSya//TLaDWcdioinVHAgEdt38aDt4T1dla+0+9kGjC1D2NoCi+rBhKeGJ1vIPKGcwkiFLYDuyVuupjH4I9PIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230665; c=relaxed/simple;
	bh=GnmL58nUJ+aQYfo5c+N8DIjsRzLma8nqcxDsscZWYO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyGYhkvbn0YG1ec94VQgqX22jK1gliaMJScFSuQjFCLIsupBdfqSYkE87uGWZOhr/ntU8fv+Rw5NJPdQMrPYPQwV2iXvrqudUnz+fwdu4LBtykQbc2rQGhv5SBsPlYxWBAAo+hSqz/MYXwI3DHOV1vXix/e1dC8Ho6yuUNCnx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUP8lvw+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF621F000E9;
	Tue, 19 May 2026 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779230664;
	bh=Ug7LuOJAwKawavxSmCtMPtqb0Cen/S35O6/Igj6pVwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mUP8lvw+pUzIkaoB8nwIy6Cs8ohIykTozdroxvySZsNhR1gQyVRt6ZJ79zggrZbG8
	 LKVTrKgTb9n5znQgknZU+jKjLwm2a5m3/GblJr1T86zSnJnMa6snAGRp0SN/1afxBa
	 2OXAT5ylzz4i8X5X9gKw7cq1t3KqnlR2gKRxfyiwXvSlSfQC4PE0oIoIr5DBh/Y48W
	 yvqj8mmaZRV9274zDaSdaErWebw0TIcByMNI31lVVt6o1xuVerLLTfVJWytcx2kEY2
	 DpFMS6m2oBDTFg9YcGSDA2NvbhgSCDc6GJjVskj1SsdObd31F57PDjFtvcTkdl8t8g
	 sGEPw7PilcpEg==
Date: Tue, 19 May 2026 15:44:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] tools: ynl: add unicast notification
 receive support
Message-ID: <20260519154422.525b32e6@kernel.org>
In-Reply-To: <20260519103153.968549-3-houminxi@gmail.com>
References: <20260519103153.968549-1-houminxi@gmail.com>
	<20260519103153.968549-3-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-289641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0512F585CE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 18:31:53 +0800 Minxi Hou wrote:
>        ynl.ntf_subscribe(mcast_name)      -- join a multicast group
> +      ynl.ntf_listen()                   -- bind socket for unicast notifications
>        ynl.check_ntf()                    -- drain pending notifications
>        ynl.poll_ntf(duration=None)        -- yield notifications
>  
> @@ -748,6 +749,10 @@ class YnlFamily(SpecFamily):
>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>                               mcast_id)
>  
> +    def ntf_listen(self):
> +        """Bind socket for receiving unicast notifications."""
> +        self.sock.bind((0, 0))

_listen() seems like a pretty bad name, given that listen()
is also a system call name, and we're doing a bind().

If we want a method to do this (as opposed to the user calling
ynl.sock.bind() themselves) we should probably call the method
bind() and pass the address tuple as an arg (default to (0, 0)).
-- 
pw-bot: cr

