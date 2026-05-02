Return-Path: <netdev+bounces-283446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPkfEGcx9mnKSwIAu9opvQ
	(envelope-from <netdev+bounces-283446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCB4B303C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503D5300C027
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E535C182;
	Sat,  2 May 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRbYRLOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F43033EA
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742166; cv=none; b=cOcryGqX+Dyu5uw+klfhAna1m/9j2koQ5j/dXlMvtiMo+F1beIUfTbWlf3CZVqdjprVQvpFvdmIoODAuz7T5KQ8tneKH5q/9D1yoW+/KGUeNFf1G4ri1/h+vB8gcbBjoA/5XlqOq7hlUd3AvHDPeNbNTeO6e3520Ymcknqc14Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742166; c=relaxed/simple;
	bh=+0CFC5A4Evy+9GJG+IpKuen6s5CfemtvpTuS9J4rTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFNiSII7Z+ueE5ZNE3FUwU72XhREQhx9A87bUGkK7T7zWzsoSA2u4hG7/f9v8BanJ/jEPOc/3QF34pbJQwf1hMkW+3hhy2JJUFTqWdcP467RSHaexNtoyLteu+QJR4s/X6XP0x3RCE/96Y4ZJ56udMbY89zpnsDUdOn4I6vvIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRbYRLOV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef5776530bso326350385a.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777742164; x=1778346964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z11f/Vv9GkY9KDFoxqPMfht6srzp4mP7hxNzZazS6AM=;
        b=cRbYRLOVKst7BuzUoW9x9PfVHQfmL2YlfabBCjvzLaBds447t3EK6MCJzd3DqXwIfQ
         lvpNpWCNQDCnIQSKh2ptijz7xitnR0IImy+NSTgZ6mhVFgYK7PxShnzLXo8zH+08cLzH
         vYl22IIlfNCfFxikKKph8jaKGUSKEhJKM5FqrLOGo25qcDRroLB6HfIZDxKyzuik2Klz
         L2hub35AXL9d5C5lARHkR57Zis2n9oV+eQq63c1g9wKOxY4/n5be5pZCOWdSNQlu0d0n
         4GxtcUhqxs7tl00if0iUhBAxc/jo3wqR5w3p+DZY0RUtEhoDDAvi9KoQsUmS8IRkOp0Y
         IPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777742164; x=1778346964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z11f/Vv9GkY9KDFoxqPMfht6srzp4mP7hxNzZazS6AM=;
        b=d72nZadN02PG5gwTXV5mRdc/sInh9MESykL//CvllHIoAyDg1nH/yaTtjhagqlUyCd
         VRwLqvADF9fA3AL1rsm/SaNOLSNaMAyeISrFzGPIpBKiIbzEBhtPolLTGtPZIvZUikb1
         g6oIS1QXcyTINR8ksvC6nz8k3cMRuOfCRIxTsmHyeNaShuFeSDFMFpd3WWq+h6FSTkZz
         MsSStpSzSgtlQtcWBzyeQCbFOT+rXGEOFQrXVaLAxvcojJNTL8yQ2hRJUkA8Y/FTVeaS
         LvOxXgjyw3lWBF3TNW4W+7C3IVM9pqM6jad9iwX8u8ahIxw34QrSjGVF8TFUQBQpe+f5
         sIGg==
X-Forwarded-Encrypted: i=1; AFNElJ+CBJv54oco+lFrQDI5jqBoUSYZSTCROeiMkg/M/mChR8A23SFtzzCYPTLG1Xt3F37fF4s1RnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8CSLaYGexHd+HQjygz0zc9501cqoDvD0n/NpNxLliiA67J9H
	TkROZeUcLn9th2ShflgvWB7X6k3fpskKDUS6hrXF9OqFOTDjqX4W5Mv8
X-Gm-Gg: AeBDietAa09jAuvklx3smnsV0ehTKOPisxIh31muwrZ10lkCNspPIuyFTBvtqewziSx
	ddg9n7yX6XhCKExZSw1ITPNNKbJ/c8QvNbrwXKTnPeXObr2Q9WB5pgjJIVGPv52PveD0sd/PvQU
	cLBiqlnKfs1FoNZNror+riAORU0Jv6xXsqKrxTVWktYvSPMDdpQ5uykrza+sLKw/yWeZmWyRi+M
	EOZx1QoM1mqYryqyLGC78nmQbNCClp5qGl0nCp6VLZm1HtPSHMQRfvMd61R2M0yRYv0Jvr+EyRR
	GlFVNqwwmv8oQTLEOpp8QGhYYPUa2MUxbgCT0lHbzdEg67WJymZmhz90f2ucn8PGj1EwjwIN7Uk
	mA2QIb882wFCQZJNzRz8VOdIZxMXHgQQEmuAA7uTH9UU/STGwMWHMLFNaQFr2Nr38LvcZkTygCV
	86vKnn1wqG4phFp7/kWD8g99ZqQSvq3z59G8GcNJ54/LPZQLSEaD31FHNSBiw9bfkOBdM=
X-Received: by 2002:a05:620a:40c9:b0:8f4:e8ce:8e3 with SMTP id af79cd13be357-8fd17e45b75mr609597585a.41.1777742164457;
        Sat, 02 May 2026 10:16:04 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm572920185a.36.2026.05.02.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:16:03 -0700 (PDT)
Date: Sat, 2 May 2026 13:16:00 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <afYxULoCOaL3pQkm@PF5YBGDS.localdomain>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
 <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
 <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
X-Rspamd-Queue-Id: B0DCB4B303C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 04:02:04PM +0200, Andrew Lunn wrote:
> On Sat, May 02, 2026 at 05:45:08AM -0400, Mike Marciniszyn wrote:
> > On Fri, May 01, 2026 at 02:46:36PM +0100, Simon Horman wrote:
> > > On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> > > > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> > > >
> > > > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> > >
> > > Hi Mike,
> > >
> > > I think this warrants a bit more explanation: Why should addr 2 be
> > > accepted? What happens from a user-perspective when it is not?
> > >
> >
> > The DW IP part has two distinct PCS address ranges cooresponding
> > to the C45 PCS registers.
> >
> > The shim translates the PCS mmd/addr/regno into specific CSR writes
> > to one of two zero-relative addr values into one of those two
> > ranges.
> >
> > This patch fixes a one off in the test that could allow an invalid
> > CSR write if an addr == 2 was called.
>
> Stable runs say:
>
> It must either fix a real bug that bothers people, ...
>
> Can this bug be triggered with the current driver? Are there any
> noticeable effects? How would somebody inside Meta know they need this
> fix? This should be included in the commit message.
>
>     Andrew

Thanks Andrew!

I am working inside Meta with Alex and Kuba.   I noticed the one off when
doing the patch that reworks the shim.

As to a real impact, that depends on the part2 series, but before that
series no one would care, which is why I had in as part of
the patch 1 series.

Without the follow on work, I suspect that no one cares or would
see any issue as I have yet to present the xpcs changes in part2.

Perhaps the best thing to do is beef up the commit and remove the
stable Cc, leaving the Fixes linkage?

Mike

