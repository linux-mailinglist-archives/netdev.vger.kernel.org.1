Return-Path: <netdev+bounces-282343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OurLszf8Wn3kwEAu9opvQ
	(envelope-from <netdev+bounces-282343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:39:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CD4930A8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E983032CF2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9133CA4B2;
	Wed, 29 Apr 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhOGMnBR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773023CFF6A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458976; cv=none; b=gYpy69H40H+I0GJhD/e1AF4/YkZ1Ja11YXpp5nzxH6t2k4ZX3AVxqm89fb9mKlA3QVrO/VXo/51GOQ8CPQSwBeVOtjv9O17hxV3GTjXeC9VVLEBQsDWRCjpsJa2Yh9nBEwxrKhItksvs2ePAWyWvvyDRYbHskj5VwGwc4pEMQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458976; c=relaxed/simple;
	bh=Lztaoe8D6tALyIoNz2jIME1CJAhrcwGitSWeewC9wTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeWqZNHNBKSQVcBw9E1QNg5D/JBCsXikVj3VVp6rP47Q4udTtBDCn1eIed2wSE88Bm9z2fpmebq3nA1ePbR+yNTpuq6QsxAEtn3qrBBvsUipOwaoJ6KxhlUTjBfNwcUzcNnFCUB82oWCytH6B/2MPo3ic0S4iVqs0ac/LtC+fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhOGMnBR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb1ad3734so6523711cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777458969; x=1778063769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyypOgEbiK3dH2xH1H/KkEjHCpdt2R7NPE0TLtBJdyI=;
        b=fhOGMnBRbeVVkLq8fQ2e+2oJR11TO+kQQhlRcrcCCVtuAMDbxFEWZ4h9dEc9sZIUf+
         vWY2TIOxJIJglqNkkzE1rfRbDpmMNI7NmEn1NOegi6KTXk02SMFbf9lQ6J4sWdfMP9Pt
         WgEqHXTeDP1FsZ1GSmAmPEJ1BfrgQmPfKNiRwljMl7yZCMKFKtetWG5Is9DIt/DHqmI8
         3JTcwWsdL3DvpqReJkLDmHDY9KfJeH/BCUO8IEwdSg2ulaNBYLf+qzzItyNUzKiYt0eP
         Yq1uAWEAh/kPux8s+5tKyYDOjpCzNyFRIVFrYTHE0vsC2gLH5ZU8cGB33jiSgmN169c0
         aHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458969; x=1778063769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyypOgEbiK3dH2xH1H/KkEjHCpdt2R7NPE0TLtBJdyI=;
        b=Jxz3UGmFwBN2ZWXa1kRcMRPx+dI/qW3llWbFTET/WtpTJ5uBU+zx8mUwWIfBk7X6yQ
         xQo28ny43/M+qE9hrUDrckCL8k+LPA1fLH4NOSblx65F8RkuzpD3JwnhLOYZOIO3nxug
         GNx4sOLjSj/eHRzizjjsiZYOctigdb6USedgmbnebJS71Pj7gy3rYsLlVs36MiAVh67e
         HAb9UhxvD++cjQemsYqJsKtdMkphjAIOBAn0YtvESE9Pz2sd9RZxZG2Hv4KqTrIAS90G
         zr/6PvdTxHEIdJ/cjWqbAOM4BXJUdKceVugFYviZUJX+vimiYrRHLX7OQ1/maub5aLc3
         ZV+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Bc4lM+OO3Y3k62HqVOM6aQc1TWRsbhpR2/nXL3f3akNc2b75LOQO8JsZxdsgLFZytVI6JAhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rOBDfW1/m9oxXdEAGZKwmJqUvU0G9142SbAWTNDwztTCdafX
	/tFxnt5vXvWUGH5HinGKt9jVL7l7m97tCP5YuK6jexGruziEKWBsl9N9
X-Gm-Gg: AeBDieuTaBHJOoeSU5qfr5mWf9NaaEEC4gcsjDeAbp4v5nLXC/LFfieEKRz2d/ReXQS
	65F3xuQ6/umq/JXv8hBElWZOvki8sbxhCUSwh0JMVDtizh4/z7/VxJ/jbHSKqyOluQ4aPvrTKmZ
	hKLeXnXTWTsIoertfXzjkI3yctW10TClpf46DxEJJ/MjMRRYj3oaC/s+IiGWcKwNqvj2aNte3mz
	gTEMkrFo/AFYLCC3qbl0timHfD3SD2C3DlYH6GLtdRVvIOV5iUGIsZgXj71i1pgt2WNJsyqEB2O
	RgVy5mVVFSYbgTChh72FSxLyoO6SmTE23vHcyip+u18Aqa3PIniktjYGEg4ihhwNhx2adVQEuZM
	qbOC1MmqdcBwuyEkbEpai5pEaOM54AhXikxi38UtCvB6i9b7Ly7+FHQerYdNaKI2ZWUXzEzBUBx
	/A8R6ujOXKqPtqLmRQyw5T2acfQS31raSI6TgraxJw8fhKiB1vYMj982XYRI8T3w81LaU=
X-Received: by 2002:ac8:5813:0:b0:50d:7632:ddb2 with SMTP id d75a77b69052e-51019a37774mr33183071cf.12.1777458969343;
        Wed, 29 Apr 2026 03:36:09 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ab30033sm14354911cf.0.2026.04.29.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:36:08 -0700 (PDT)
Date: Wed, 29 Apr 2026 06:36:06 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <afHfFj0CkBUIQxRT@PF5YBGDS.localdomain>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
 <20260428172810.175077-2-mike.marciniszyn@gmail.com>
 <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
X-Rspamd-Queue-Id: 120CD4930A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

On Tue, Apr 28, 2026 at 08:11:30PM +0200, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 01:28:07PM -0400, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >
> > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
> > Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
>
> Please don't mix fixed and going development work in one
> patchset. They should be applied to different trees, etc.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
>     Andrew
>

So I'm guessing I need to send the bug fix to net instead of net-next
and reissue the patch series?

BTW, the review notes that the patch wasn't sent to you
(https://netdev-ctrl.bots.linux.dev/logs/build/1087030/14544928/cc_maintainers/)
but that is because there are two addresses for you:

grep Lunn MAINTAINERS
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew+netdev@lunn.ch> <----
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>

That seems to foil my scripting.  Is MAINTAINERS wrong?

Mike

