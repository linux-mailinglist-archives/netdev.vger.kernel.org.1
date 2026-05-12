Return-Path: <netdev+bounces-287022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPpeArfyAmo9zAEAu9opvQ
	(envelope-from <netdev+bounces-287022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105951DAD1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2747B30471C8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E33B961E;
	Tue, 12 May 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqK/W/Zv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E3393DC8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577974; cv=none; b=sy91uzg5uauj9yjLWcVFdEuW7TYujK17cdOTStR3WhCPSCyR6v5SZOBDjzt0+0Qx7WEruGP4bkUsfeLY+Q9yWHWf3UBzlaiAECOK9EReyxsDR81lBYDZWktdMZmMj14irK6+G0obEZrjHuXKCGJ0wuPASowJGpZ75f0mgFbhf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577974; c=relaxed/simple;
	bh=Aa9k4JIXMfWoBEywcAjfDBCQBqZfhCo9Ags0Jb9ayFA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT9RpnN/RF4HDUzfNPiDOrd4sLrXCKG/blpuNv3PH0thtFC2VhBdJmT7zqG2SREsUnzIK74r6OnHUc6P4dPshkbpjqRsC/4iJ+L9+DlFKVhNoglP5d+KXOYD8m1LdVqPfyOE4XVfn+CbSO++2/MC8/WJNKPt58GtvqmYadrtKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqK/W/Zv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-393800f638bso42076971fa.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577971; x=1779182771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOgcSNGt805XiQUX+Fq6Uz2xukIsUi5hMysVvClcsfY=;
        b=qqK/W/ZvvJW8sGV0Nk8/mnQFU555aA5J5DgCA5htvamV/lrl9d8iO1XYgmYV+9H9rJ
         lrqj/7up9df+PRu7xpIpT+eqHHoSGfO2PGpqLd6Y4L3vxgpWtcnOQoBR+hywD+9MwLhh
         sJPSHjJc156s1u7GJ2iZKlVRJnu55OS9uzxxextK22p1iWxlmfgT1bhZIuAe1FJmaabQ
         wXgH4bwXOnPDD9gCyCBOgl6ylMSLsqT9GgHfTLCqjH83hNBAkBRqu/0MMgMjxoQlzbWH
         Fgp6F+Dv7Dr1wueHYDCxqjRZ/AHnpRFaUTRypd4CZTFW3G2vufP0+iXC5aOx1G0Q4xBp
         U3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577971; x=1779182771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOgcSNGt805XiQUX+Fq6Uz2xukIsUi5hMysVvClcsfY=;
        b=XealjrhcxUN7WkiXIxHaS5FyryxbGCy/RbDViv14cZdQ3ZqgsLWIZUZYNNfd1T8OVw
         EIEzfnyFko0M6cLaBnaUgb2Zb5BQZl1hYSWNpOOYTc5BbT0+RtW+SKr3XSfuKyPLN4PV
         HxQaTmbOBEaMq0sJpTwWJtAzYGIwAND+bbGqJvd+Bf4kHYt6MREJrSxVFqh3QTsE2LS9
         cgtbCyQd40Yr3NtCpEGSns3Tj0oQ93mHjm7tLEmeaPb5fv9Bss+vMPYqYFRX0aUrfws4
         nitD3z47Cd6WOkT6gQG0/n7lvGJhCtpqMh5XQokVLd0aQOvFFWdqDdVkvIGLU9AhvbE/
         yYAw==
X-Forwarded-Encrypted: i=1; AFNElJ+AJd/Z1tXRleL3FdpnhL75J/oely1XhqokpezoKdCcE4m47KmyHE9mOfz/t5s4/FTrHzjgd4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt7VGChp/ltv/mPtH2/Iw1Tvv53rUObYBDFIOjrsTTlpodyoz
	hTkzJ4x/o4XLCl3xFTbXKAH6+7GQzt4JLEpCOl4ytg0UFYm2Ls0Ur0i6
X-Gm-Gg: Acq92OFOJzGmvDLQCLtkoWaTTFOHOuPFZggKhmnflfpu5dmlvNk/DXjPMkhgrhUXSgw
	9ELsnFUVaBsS8eIFnxeWRgA3SgqAZUjeQWnE2otnE1mihk9+Ra1cZEWKIVmC3uO6Dgukz2Pqe/5
	kRsbCT2rFe/PuYp5d2wS2xUB/Zm9CJWKh6jD+/CXxmmegulOc3mLItt41AuHZTbsVtke0cGqByT
	rLtIyywW6ww8cF+B4e9lyVrosRI6pKapUUHpI3UacOBfVfz6f2ld00BTwaNfOyJF/9j5w7rvX9S
	nbGzehCuhXS2dgTKV0zEUFz/e7Cw+s3DNXFnvXsGrtypWO1w4DErltAVJW15QCkqWdMC9XbEQqa
	XjCAeZxrdxUirW/NDiPzARMl81iHFpvsn+YPPZ5FdQRAnk4pcnY4MGe+M5Scmb9NSl0a3TFJkXm
	vmSKp/XYbykTBgD1JS1eQ2k3hngT+0IPmq3ggsA/f3BB1j9/RCrIM=
X-Received: by 2002:a05:651c:3241:b0:38e:49e6:a363 with SMTP id 38308e7fff4ca-3943cb812d3mr7142681fa.15.1778577970282;
        Tue, 12 May 2026 02:26:10 -0700 (PDT)
Received: from pc636 (host-95-203-23-125.mobileonline.telia.com. [95.203.23.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f9ffa0a0sm30618831fa.21.2026.05.12.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:26:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 12 May 2026 11:26:06 +0200
To: Ido Schimmel <idosch@nvidia.com>
Cc: syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>,
	urezki@gmail.com, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com, fw@strlen.de
Subject: Re: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
Message-ID: <agLyLko3Et-V2mRV@pc636>
References: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
 <20260512084754.GA181587@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512084754.GA181587@shredder>
X-Rspamd-Queue-Id: 8105951DAD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-287022-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,gmail.com,lists.linux.dev,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,blackwall.org,googlegroups.com,strlen.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,8b12fc6e0fb139765b58];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:47:54AM +0300, Ido Schimmel wrote:
> On Sat, May 09, 2026 at 12:35:24PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > kernel BUG at mm/vmalloc.c:3206!
> 
> It seems that this bug was fixed by commit 30c19366636f ("mm: fix BUG
> splat with kvmalloc + GFP_ATOMIC"), but then commit c6307674ed82 ("mm:
> kvmalloc: add non-blocking support for vmalloc") re-introduced it.
> 
> Uladzislau, can you please look into it?
> 
> Note that the bridge is calling rhashtable_lookup_insert_fast() with BH
> disabled.
> 
Yep, since vmalloc can be called with ATOMIC/NOWAIT flags now. I am
checking this. Probably we can just remove below check:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 676851d5cfe7..3d338e4bcbf7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3209,7 +3209,6 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
        struct vm_struct *area;
        unsigned long requested_size = size;

-       BUG_ON(in_interrupt());
        size = ALIGN(size, 1ul << shift);
        if (unlikely(!size))
                return NULL;
<snip>

We have already the check:

	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
	allow_block = gfpflags_allow_blocking(gfp_mask);
	might_sleep_if(allow_block);

in alloc_vmap_area().

--
Uladzislau Rezki

