Return-Path: <netdev+bounces-278457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIQUK0JC3mlvpwkAu9opvQ
	(envelope-from <netdev+bounces-278457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9E3FA8D5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5A0303FFAE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD03E6DD5;
	Tue, 14 Apr 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mPCTrtam"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC63E0C7E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173334; cv=none; b=fraF6DaYrjdf1u4ng9t+8Bo8emhXvPdZwb/pE+njW5m1k7ohjRzlzmTb5x6s+dgmt34ba9kB8cmSb2it0PMpGXU0hF65ebS4LP+o4ZUg/m5dQBvmJGVZFWtY1oDYY3FDdNLz1PER/Y2aL2idRtOwhHtj2Wi0kpu6pc17QJVTY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173334; c=relaxed/simple;
	bh=p7JWKcuedLO81gSsCyeFSH1I/OpNmDJ+e7USeQ4yvqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8PcGacu0SXctB+E10gtn/5LjCjcLg4tu+axXWdLG2SKRPuWC6icBeRNcluhFYqgA6s2aAbOWRkuJazSaUEJfRfIGpTORLbVz9miKUzMkyXH/j7pGDmqZeJ9Li3symSsJa05I3PIrYhxVQUJyw7de1vbhchL2Nt9FSr5ZeAj5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mPCTrtam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEA7C2BCB6
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:28:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mPCTrtam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776173330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oA89sTD5YxYL/+yk9WfECH2uN8yoVEYYQe2R4s4QMK0=;
	b=mPCTrtamuZ5SwkVUV9Br4MP7+TQAcFXXjg9fj2LDNrDDgqKnTQzY5xlOHj3N/xjYp7KNyC
	4+481eF+Ztm6zwyWhAzCNUMjV1bV5ZcQqeRMOHsXtgpUq62r3O/S6YOtNltoNmWnbsEDWl
	y2QdWbLjTOcR37whVF8ev1F/AXq/f4s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1ac49e31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Tue, 14 Apr 2026 13:28:49 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46f0fa0e398so3187733b6e.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9N9xUWzqKOQk9dfRwNH0HmdnOp8rbVUVOp3G7CkKy7nUSkepPMmK0O3/MSno3Sl6nS9J2a2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpTiEsajifPtX1WvAKJYl76iLVjxelTszf18d1Wc8zhqdfAEb
	vHSJ6212M4CrnUtHC77DxUs3RMlnzSzN77cphWQzK7EUFlgUtMa273cPz0XRogFC5bHTB8sOsjC
	Wukjc8/GiWIHXsv0ub/qg29t5WBsUTjI=
X-Received: by 2002:a05:6808:518e:b0:462:aa0f:4375 with SMTP id
 5614622812f47-4789f20b19fmr8732029b6e.39.1776173328337; Tue, 14 Apr 2026
 06:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 14 Apr 2026 15:28:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com>
X-Gm-Features: AQROBzD8reYvNXiQg2DJuP8iLuSIf1CWlszs50_8P6eG8mLGfkZRXcPija3v4gQ
Message-ID: <CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com>
Subject: Re: [PATCH v2] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: kuniyu@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, janak@mpiric.us, kalpan.jani@mpiricsoftware.com, 
	shardulsb08@gmail.com, syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278457-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,lists.zx2c4.com,vger.kernel.org,mpiric.us,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zx2c4.com:dkim,mail.gmail.com:mid,syzkaller.appspot.com:url,appspotmail.com:email,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 0FD9E3FA8D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shardul,

On Mon, Apr 13, 2026 at 5:13=E2=80=AFPM Shardul Bankar
<shardul.b@mpiricsoftware.com> wrote:
>
> wg_netns_pre_exit() manually acquires rtnl_lock() inside the
> pernet .pre_exit callback.  This causes a hung task when another
> thread holds rtnl_mutex - the cleanup_net workqueue (or the
> setup_net failure rollback path) blocks indefinitely in
> wg_netns_pre_exit() waiting to acquire the lock.
>
> Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
> Add ->exit_rtnl() hook to struct pernet_operations."), where the
> framework already holds RTNL and batches all callbacks under a
> single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
> window.
>
> The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
> from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
> because all RCU readers of creating_net either use maybe_get_net()
> - which returns NULL for a dying namespace with zero refcount - or
> access net->user_ns which remains valid throughout the entire
> ops_undo_list sequence.
>
> Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3Dcb64c22a492202ca929e18262f=
db8cb89e635c70
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

Thanks. Applied to the wireguard tree, and also added the missing
__net_exit and __read_mostly annotations in the process.

Jason

