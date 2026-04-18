Return-Path: <netdev+bounces-279508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJuRHjGX42muIwEAu9opvQ
	(envelope-from <netdev+bounces-279508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF460421532
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8946F3031AF4
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C1395DBC;
	Sat, 18 Apr 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym3L3pbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB82E413
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523053; cv=none; b=UFbJL5SH/PEu6qVTVoLWhK3koU5Rpbuz2c18epoWKOp9PzXTo0VTSI/2xMcSil4piv6r6CCi+pqExZJp/VdEM2CjIWE/EO6YKKdWTW5+n0a7Uh3yb0DIyWsk1nDw+vgDL7sCfKo9ntYlWzebPxqpnXLi4byYTvZvAe5fEGjxzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523053; c=relaxed/simple;
	bh=iTNeU9cM3xV2CYH2iSVxdzqeKxIAvyl4ZeNii1rFs2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/l2CX6rHaDRBu9fKqsUKVGAuzhXhwdDBcguCOyszm6Nh/HtlgYZOFnf+YyYa/Enm30zUSDTomSNbVmWobexGFGdQZARn+5eF/1BTkQuMSWMpTbrnfZ4HCFJq9XRLJm80lg9H8fLFWiG6n41VAZwxqWFpWSkuSW/oFQM+NZdKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym3L3pbo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso1133233a12.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523051; x=1777127851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbsMozQj477A2w2XnCGVvsxlPcZaVihW+fwe2arVXt4=;
        b=Ym3L3pboYo0n8GJ/dB62R9AMcroJpqWesZRC9DOJLQsvlxcBITVJ2xzwoxaoLQOXaT
         Y8ay54sfJ/NTYk2iAq6okZy0PT5+LiryP2NT3F1987D4SElMfixMrOCEWyAHLLNAHZC+
         HMXL9S5NC1Vaw/g5ZCr5E2j9pz01dJE/FdaW/2mirDiESAeQJMQlkwkS4oibbSZRTYSQ
         wE1h0ci+OARXMwRjjHg4vNKDFL7j2WoxNfFPMfOFum0+2RcL7OK1kiY2hUEDvCIlfM3Y
         KAjzfXp0y9cFu6Zw4tTsi4wRKrH/iST3kCcnBM40f8JrwG4A3k0QL5xnDRoNng3NheSW
         9CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523051; x=1777127851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbsMozQj477A2w2XnCGVvsxlPcZaVihW+fwe2arVXt4=;
        b=C3WDPWOkYiaqTxyyCX11zU2Q9osGGrC560JmRwxRqkD7PaVCPnFL/kqFio6etAFZpi
         aesO47WPFnDLXV7Gjh1rZBDcJG/yxxB4dSiFiFFiXmeTa/yM9+4zDHAVEQ9z4XcHVjQL
         LJiqk2WBHc3+6X0WygPlHPGQlUHTvTSHwhd8HvXBDX69OhxvyZ7JWYuWVmMKSJvVbAyE
         cI1haulyHWODV1Btt3KvfLak07cIaWjq+gwhvr0yYjYSjqggm8V8zhLucb7tbEb+Es4m
         XYdPDvqVT0PqcVx5rqr9XqwNupRCLhUzn0jKJSQ4rN6wrgrXlc57EUwe4wIOU6AKAMLw
         PNVw==
X-Forwarded-Encrypted: i=1; AFNElJ/yIV7SkKoiAaE4LHSX9DB/5sqU6m14HQoscYzRD1KBPESuIovYUtVwuofn1Q4jdRTleY6yw0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8Ym+MXnYsL4DzuAZ+I2ONO9FeZnm5QyGqndr58rhnlkJxwA7
	cYYPai86ALo1bPd7zvNly2gx4U/QH3adx4YMHLfmaddNc8aoeSDyvoziafPsjLmUua8=
X-Gm-Gg: AeBDiet6J3sYBFmS54IsoCWgcDMOUN7lZAkSdMRE7Nf4NVtKJV8HseYevz4TtC/71w1
	eps6pA1YyT8yWi4svoJcwjCGjg5kK9WZhsZ6+KRDTeInzhNTdMdYgqghSOHTNY0VmlNpVkbD/iH
	2Okq73oZrdnh9KX9mv++E7/JkWQBq4Aj94cktspmznU/e+mwSn97gqliW/UeRpk0wfl4bdndouc
	gfgr7cG4Srv3nLxsNV4ZsbPdMX8Ck90ygif1pHU9R28NQB0vPef4HY1E0y5LYpiQMzuFa1ooJX8
	l3azoVt4hHz8BARDsSC3dtnQ03tvswBfveq3Qqt30a2zIi7kLWDIrH9aAtuPYOzEJLgMxDqvNoE
	0wEzjTBrP1qdt6aGCK5wxrQP9pgXM757Ya3Mp1EJVYgZlFrWVtVmmzSCMtjzIQLY655jEWnl1rm
	O9C5AlEGFqOct6H+HwBcZLpZZAcECQwKnkJbajW+dsmb+c+tOV9ibuBMAbw3reSFEazu+7Ub/Pn
	8YF+eDLTw==
X-Received: by 2002:a05:6a20:6a08:b0:39f:2b9e:e48f with SMTP id adf61e73a8af0-3a08d8a88c2mr8335023637.33.1776523051279;
        Sat, 18 Apr 2026 07:37:31 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770587c1sm4004320a12.32.2026.04.18.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:37:30 -0700 (PDT)
Date: Sat, 18 Apr 2026 22:37:26 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] slip: reject VJ receive packets on instances with
 no rstate array
Message-ID: <aeOXJoeq6VkCnqAH@SLSGDTSWING002>
References: <20260415204130.258866-2-bestswngs@gmail.com>
 <20260418123929.GE280379@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418123929.GE280379@horms.kernel.org>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.967];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF460421532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-18 13:39, Simon Horman wrote:
> On Thu, Apr 16, 2026 at 04:41:31AM +0800, Weiming Shi wrote:
> > slhc_init() accepts rslots == 0 as a valid configuration, with the
> > documented meaning of 'no receive compression'. In that case the
> > allocation loop in slhc_init() is skipped, so comp->rstate stays
> > NULL and comp->rslot_limit stays 0 (from the kzalloc of struct
> > slcompress).
> > 
> > The receive helpers do not defend against that configuration.
> > slhc_uncompress() dereferences comp->rstate[x] when the VJ header
> > carries an explicit connection ID, and slhc_remember() later assigns
> > cs = &comp->rstate[...] after only comparing the packet's slot number
> > to comp->rslot_limit. Because rslot_limit is 0, slot 0 passes the
> > range check, and the code dereferences a NULL rstate.
> > 
> > The configuration is reachable in-tree through PPP. PPPIOCSMAXCID
> > stores its argument in a signed int, and (val >> 16) uses arithmetic
> > shift. Passing 0xffff0000 therefore sign-extends to -1, so val2 + 1
> > is 0 and ppp_generic.c ends up calling slhc_init(0, 1). Because
> > /dev/ppp open is gated by ns_capable(CAP_NET_ADMIN), the whole path
> > is reachable from an unprivileged user namespace. Once the malformed
> > VJ state is installed, any inbound VJ-compressed or VJ-uncompressed
> > frame that selects slot 0 crashes the kernel in softirq context:
> > 
> >  Oops: general protection fault, probably for non-canonical
> >        address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> >  RIP: 0010:slhc_uncompress (drivers/net/slip/slhc.c:519)
> >  Call Trace:
> >   <TASK>
> >   ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2466)
> >   ppp_input (drivers/net/ppp/ppp_generic.c:2359)
> >   ppp_async_process (drivers/net/ppp/ppp_async.c:492)
> >   tasklet_action_common (kernel/softirq.c:926)
> >   handle_softirqs (kernel/softirq.c:623)
> >   run_ksoftirqd (kernel/softirq.c:1055)
> >   smpboot_thread_fn (kernel/smpboot.c:160)
> >   kthread (kernel/kthread.c:436)
> >   ret_from_fork (arch/x86/kernel/process.c:164)
> >   </TASK>
> > 
> > Reject the receive side on such instances instead of touching rstate.
> > slhc_uncompress() falls through to its existing 'bad' label, which
> > bumps sls_i_error and enters the toss state. slhc_remember() mirrors
> > that with an explicit sls_i_error increment followed by slhc_toss();
> > the sls_i_runt counter is not used here because a missing rstate is
> > an internal configuration state, not a runt packet.
> > 
> > The transmit path is unaffected: the only in-tree caller that picks
> > rslots from userspace (ppp_generic.c) still supplies tslots >= 1, and
> > slip.c always calls slhc_init(16, 16), so comp->tstate remains valid
> > and slhc_compress() continues to work.
> > 
> > Fixes: b5451d783ade ("slip: Move the SLIP drivers")
> 
> AI review points out that the cited commit moves code but doesn't
> add this bug.
> 
> It seems to me that this bug has existed since the beginning of git
> history. If so, the Fixes tag should be:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v2:
> > - slhc_remember(): use sls_i_error instead of sls_i_runt for the
> >   missing-rstate case; it is a configuration error, not a runt packet
> >   (Simon).
> > - slhc_uncompress(): goto bad instead of returning 0, so the instance
> >   also enters SLF_TOSS on the first rejected frame.
> 
> Otherwise this looks good to me:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 
> I do note that Sashiko flags some other problems in this code.
> I do not think that needs to delay progress of this patch.
> But you may wish to look into them as follow-up work.

Thanks for your review. 

I've already sent two follow-up patches for the decode()/pull16() 
bounds-checking issues:

    [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
    https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/

    [PATCH net] slip: bound decode() reads against the compressed packet length
    https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/

Best regards,
Weiming Shi


