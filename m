Return-Path: <netdev+bounces-296123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bgVGBsRcJGq15gEAu9opvQ
	(envelope-from <netdev+bounces-296123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 19:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2C64DFBE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 19:45:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rssy+w1j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296123-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE8A9300CEB7
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E62DBF75;
	Sat,  6 Jun 2026 17:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F12CDA5
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 17:45:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767937; cv=none; b=cUaTEZl1echBLxVJy1lSt/8CWsFzDDjTsOsmgH9WtsjwevwU/ddbKUeLAbX37KRc3QQKmqCPOlD8SqJPCmSQ3hlWHSl/F2VdArTNlt6TwS5bp7xkjcyxBOmN9JhbEDJZkYFG3xsvPe8qhcM0WgFv+Wpz8ENHmX/LihGvIJMT1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767937; c=relaxed/simple;
	bh=GGSurrkRrVaBAAv0mDCXfnzvvVpJJkyj1u5L2qicQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpwaZ5/iEZn+K8YPupOZ/fLh5fzcQGx8Pgiw/oDTR5RRmkroCy0L88HdzfXXEeCZ3mo8psoCgahGqbVVSK4VTw1tf+UZJT4SlJ18yF0J0IBLE0yPXTUlO6EgiJr2cAD3jLjVCYrdvXfg2PjNdY0+f37ezGR5QL4PeH9kEX04nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rssy+w1j; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1283588a91.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780767936; x=1781372736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vdYOcG1zbXs38rrfilNIDc0Eb6wx6T9J2haYHxstsE=;
        b=rssy+w1jsJllqB7zYTZYqtl2zldiyzN5d5GOui8YJ0BRK8MSxSFn+n3v5AV/sOXd+H
         nbjIYbCya0Vy5OlG67lZnkvypfVe3LuB9hG5r5NiKuUcqrVmha1ebqOAcit7vhBcmwzx
         3Nd9/zSSz1HiTMpmK7t2pijGBWjbzvvXrffDm4uovCbmMD8Y29Fz49xdM1kisSEgdQRK
         kSWwRwqcXEF9uyOkMbGSaJkRreBdcBaGUAbf0eTvlRs5cwXkayLwiZxosg4mTmTPt+OE
         xxVDwdToyFRY6/cIk5uwNossOBihFWcAHVLtgYAXUZFNvdcdarw04A+ry4c6LjxlygPs
         kG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780767936; x=1781372736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vdYOcG1zbXs38rrfilNIDc0Eb6wx6T9J2haYHxstsE=;
        b=qYcDm47Ab99yza3jg+jVi/FlbtkGN2EiMNRnpEetu/xpswCTc0Jp422yRhU4D64Q2r
         VehT4nR+f0+5JaVOxLkL5jkC67hIENbc1/FZDXoBG2GrHAM6H9Mstw+piP2xw1riQh+g
         QjUXJmbYLombUwtlACQ8Ht9ElKBxwQqSX4Nz0TgyDdgnOCcXSZK1D0f7OzCXAMl9un0s
         rPWxFaBeUbMvesyLfPW4CMLslpTByZANBdWHPKSBs48E3WVLyiRhQrb9HpzgqNzBl0M8
         oqhyPJnXBGLkbpPlMIi+FZ8VQJIuVdPmekIMM2Qai6n+p1IvVFjleB63Q1v53rbL25+5
         cV/w==
X-Forwarded-Encrypted: i=1; AFNElJ9CRhfWCZNF9R/czSVRv2c2cF0HnCZgRlCiZlsVZQgug+0WWpo2oFZs9EFMPsvXRYhQI4YI0HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerCV2zB18lBpcpuIp77D8Zadd/vpMcfhHL1tt+0s6S0AymwhZ
	U/RQEs1Zrfg3oaSdCwGm6hT8QQx5m53KaF2Obyc2NN4uqpFcQs1V1qVB
X-Gm-Gg: Acq92OFDlaBDfn7VFS530rFChwJU0k6b//l9Q5JpZVrDbK+0ZRPTXPBEZNey7kID40C
	3DZns+1/uU13iHpgRLHUJKDCoY8TGF414qEMUypyMOfhl/ZMx0CUoK15lbW4+SK5VxdP+i+XwZP
	VQMl44oOInfGjlKLEnP9wgArR9PK3xKoPlclyUHQyEpZA+OaxaVjix63sVzmvbEJRdseyxqvPdr
	hOy2KHtXWmOPwivIvRLTXAv/3dmoyTcDtC0Fo3cT6AhYldxj3jyqNorBeuGnno86KIs6tJcKozo
	x24NU4fHY3XUlTrlLhfPKWGsAD54M0L4UDpeAKm4JkrUPao0//QJduUbj1ao8erPyl+hw75eZO9
	FCPWgCcsgqgwrlvNDTw1ZO14ATZ68VN+152zWPGvOsdJ00TsI8N+XqlYk8jBsfkYjRUpIZgVk9I
	TaL1aM9xd8eF+K+nJbSan+yPDhb0ODDoM0RU5OYwL/Txbm2hPI9ckMwbCPlAE/ne57fK+o8JfkO
	H8jSQlwA5t7ZvupImk3oNw=
X-Received: by 2002:a17:90b:3fd0:b0:36d:cf58:b79 with SMTP id 98e67ed59e1d1-370f0e4b14amr9357296a91.19.1780767935628;
        Sat, 06 Jun 2026 10:45:35 -0700 (PDT)
Received: from urbaner-laptop ([61.70.109.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf90a32sm12852338a91.1.2026.06.06.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:45:34 -0700 (PDT)
Date: Sun, 7 Jun 2026 01:45:30 +0800
From: Ko Han Chen <urbaner3@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document: Fix missing reference pages
Message-ID: <aiRcum6gw3oa4wJU@urbaner-laptop>
References: <20260605084130.13363-1-urbaner3@gmail.com>
 <20260605171401.0586831d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T8XblR0duSLm763K"
Content-Disposition: inline
In-Reply-To: <20260605171401.0586831d@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:corbet@lwn.net,m:horms@kernel.org,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[urbaner3@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urbaner3@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hackmd.io:url,usb.org:url,urbaner-laptop:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6B2C64DFBE


--T8XblR0duSLm763K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2026 at 05:14:01PM -0700, Jakub Kicinski wrote:
> On Fri,  5 Jun 2026 16:41:30 +0800 [Ko Han Chen] wrote:
> > Subject: [PATCH] Document: Fix missing reference pages
> > Date: Fri,  5 Jun 2026 16:41:30 +0800
> > X-Mailer: git-send-email 2.48.1
> > 
> > Today, my friend and I are discussing a wwan driver produced by
> > Mediatek. I am reading the related document and reference link,
> > then I found the page is missing. So after a short search I am
> > giving the better link and test the two pages with my bash
> > program for more dead links. It turns out only this one. I check
> > the page and the following documents. Details are covered in
> > this markdown [page](https://hackmd.io/@Urbaner/lk_patch_doc).
> 
> Nothing really wrong with your commit message, but the narrative
> format is quite unusual. Please rewrite it as if you were telling
> the code base what to do.
> 
> 	Correct the links to ... in ...
> 
> > Signed-off-by: [Ko Han Chen] <urbaner3@gmail.com>
> 
> And please remove the brackets around your name in the Author line and
> the Signed line.
Hi Jakub:

  Thanks for the advice. Updated the patch.

--T8XblR0duSLm763K
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Document-Fix-missing-reference-pages.patch"

From 1c11e2d24116cb86ebba6ac1c8463d6efc59c70b Mon Sep 17 00:00:00 2001
From: Ko Han Chen <urbaner3@gmail.com>
Date: Sun, 7 Jun 2026 01:37:42 +0800
Subject: [PATCH] Document: Fix missing reference pages

Fix the first reference link in t7xx and iost pages because the site
reports the content is missing. Replaced it with a page offering the
right content. Tested and confirmed it was the only broken link.

Link: https://hackmd.io/@Urbaner/lk_patch_doc

Signed-off-by: Ko Han Chen <urbaner3@gmail.com>
---
 Documentation/networking/device_drivers/wwan/iosm.rst | 2 +-
 Documentation/networking/device_drivers/wwan/t7xx.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/iosm.rst b/Documentation/networking/device_drivers/wwan/iosm.rst
index 6f9e955af984..d28a922391ce 100644
--- a/Documentation/networking/device_drivers/wwan/iosm.rst
+++ b/Documentation/networking/device_drivers/wwan/iosm.rst
@@ -84,7 +84,7 @@ session 1.
 References
 ==========
 [1] "MBIM (Mobile Broadband Interface Model) Errata-1"
-      - https://www.usb.org/document-library/
+      - http://usb.org/document-library/mobile-broadband-interface-model-v10-errata-1-and-adopters-agreement
 
 [2] libmbim - "a glib-based library for talking to WWAN modems and
       devices which speak the Mobile Interface Broadband Model (MBIM)
diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index e07de7700dfc..fd532a7e225a 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -187,7 +187,7 @@ References
 ==========
 [1] *MBIM (Mobile Broadband Interface Model) Errata-1*
 
-- https://www.usb.org/document-library/
+- http://usb.org/document-library/mobile-broadband-interface-model-v10-errata-1-and-adopters-agreement
 
 [2] *libmbim "a glib-based library for talking to WWAN modems and devices which
 speak the Mobile Interface Broadband Model (MBIM) protocol"*
-- 
2.48.1


--T8XblR0duSLm763K--

