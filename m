Return-Path: <netdev+bounces-280859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIFNEXVw6mlBzQIAu9opvQ
	(envelope-from <netdev+bounces-280859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6283456A48
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B4DD3004DF7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143C391E76;
	Thu, 23 Apr 2026 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7MIut+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A2391849
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971884; cv=none; b=VfrKPMu0WLYY9V98fFL3KNpH028WE9mCG9yvuygUdPz+P1ZEcllX9bJGWWd1j213FRfPopwp0KzRnzAEoI/xMs2lf3buwXHC6Q2bNqkHYJgTNkI3hIivRhMVSZpX0c0ftcIvdU7F7a4/LvmU93MHB6w55BV9kTsni7uYiNZ4SNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971884; c=relaxed/simple;
	bh=xxMdqnMhpPGGo80oMi3DMqP+rH6DCCoqMcufjpmKcf0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1f6ry7Ocm3njfbs6HmNYIqN+rwWDjaEFinlq1LARiou+ynlJGHUigMWZMMRFpbI2+ifEEzcQRFxEdtDJnAMPbv6+cvZsvtbhagxtKD7taQKFua5aGhYclu27CBvyGFzNlJTJQvJb+2OkbwDFrfM9xFf54UMRgH/Tt2FpJznFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7MIut+v; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so71128425e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776971881; x=1777576681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZgGic7vcX65jbk5YcKn+It2Xp07XFQHAroT+QVt21o=;
        b=r7MIut+v0xwzAp2A8ht11VuqmdNa7JQFAFrELkrrmB57QzOs89kZU7HfxbeC5XOnkS
         jKi3u7fDI71fGfCjmKF/CE+QPcXu3q+/pO9NUhQMrgAWCGpNIUs8tVmRkvzV7phYvaKW
         3MexVjn37fZNaPIJQ0I3uX8ElTQso9Oxm/UYk9R+MOISDMXSzpqU10nX9wrvALyiBua+
         9yTt9kVLJTh2AF28mdEmTjXgiHY2Hxd1bnzfAXSIjdWoKYWnuTVGb13MV2g/LFH4ViTD
         UcdewyN+spOyiWMQ25XzYa79UfETQv84z7VcLQ7t7kZQNj56GETKprtWP2U/Aw4rbfcT
         zvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776971881; x=1777576681;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZgGic7vcX65jbk5YcKn+It2Xp07XFQHAroT+QVt21o=;
        b=m5cvmtsk3PRWMgaVQ7HCcQWlvnS9rl6QGmpvj+kFQ+t289TC/BacYkQ3BP1AbhnTLl
         P5MPk1HN7oKxtcxhWcqPLu6vBfisH70YJMbKM6ekbg+/nuKOnJxRrVZaLLBjg8H3eR8E
         cUq8z0V2FHf3XLO/Fbibvnu9sIKEOT4bM+9ObG1q9oQXxT6uw0QN9u52v8kPDYAoVMMg
         kXUjU8dC6CQa2koTVu88uwnfXKkxj1Wq+U6HhaIYenQOf/UhIHxPrIt2Q9YEGFKurSBr
         TtgWWDTf4jtlxQDOav2vsYH3SSprLu0OEJs74/puc+lAjRdcWpVvoxcbLshuzpPh5VUB
         eo6Q==
X-Gm-Message-State: AOJu0YzAF+xNz/ofRcMgY+W4AFBlKscTRRRz1rwvYy49uJD02Qe5gHe6
	RjAa1NJo1drCgmis5SW9EOfJIHog6izDTJu8j+5ucfP34PxD+S/Td3x+gPOdPg==
X-Gm-Gg: AeBDiet1IC+VpID5AwS+5ILp206GYXhf4y41nFiWv55GdCEE5bPhroxMul/ulmXPwIh
	zUbsO5c6SyNGNR4P3MyYGsL/dA7f/Ie4E8JbCvwUgVqdjqOe3dCTa6imJUkjxHu5pYkPQ1yqPpC
	yutHzuEhVYdpJnI/sTihKNlG/Ekp0RWHi+6yBDrRyg4WKQjt9hrMp0Y8MuX4GfivyoGbV9pPp3K
	hjKjV9pEADNZDB7kt8DWoYpMTeaN/ErHTycoYhsMbA3TwxUdgHKfy+MmYbg3XtTDmjuvr94T4eE
	sxtjyLnQPaGR++NFySVm/ZPX3Fu5RX1NWy0TF3EHFTuoq4eJ814EMPpcNYwcvf+/8hIQjnZZRKZ
	xVl7R9Eku5kEUiUD5wM31910YlX0C2GK9DX6Xq0WTDdQnH4mEw0fiQTN9pfRTB32MCLgq83342l
	e+G2Onyst3tPlPqnSdyYMjOO5Zj8MvjU16x0GzZHgAhKWgrSydUCDlVBGmy2D8b4i1IafQIg==
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488fb74e130mr300823905e9.8.1776971881250;
        Thu, 23 Apr 2026 12:18:01 -0700 (PDT)
Received: from watcher (102-182-140-48.ip.afrihost.capetown. [102.182.140.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm166569075e9.18.2026.04.23.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 12:18:00 -0700 (PDT)
From: Bruce Merry <bmerry.robot@gmail.com>
X-Google-Original-From: Bruce Merry <bmerry@gmail.com>
Received: by watcher (Postfix, from userid 1000)
	id 86CED2C1036; Thu, 23 Apr 2026 21:17:57 +0200 (SAST)
Date: Thu, 23 Apr 2026 21:17:57 +0200
To: Yishai Hadas <yishaih@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: Help with PCIe THP on ConnectX-7
Message-ID: <aepwZVpSFsN-Xegd@brucemerry.org.za>
Reply-To: bmerry@gmail.com
References: <aejnzWR_szvAOxkK@brucemerry.org.za>
 <58a85178-c00f-4705-aa20-61e668bb9216@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a85178-c00f-4705-aa20-61e668bb9216@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280859-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[bmerry@gmail.com];
	REPLYTO_DOM_EQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmerryrobot@gmail.com,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brucemerry.org.za:mid,brucemerry.org.za:url]
X-Rspamd-Queue-Id: D6283456A48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 05:55:53PM +0300, Yishai Hadas wrote:
> On 22/04/2026 18:22, Bruce Merry wrote:
> > Hello
> > 
> > I'm hoping someone from NVIDIA Networking can help with this; I wasn't
> > sure of the best way to get in contact with the engineers working on
> > mlx5 kernel code so thought I'd try here. I'm trying to write some
> > (userspace) code using ibv_reg_mr_ex to register a memory region using
> > TLP Processing Hints (THP) to improve performance on an Epyc Turin

...

> It's supported only on CX8 for now.

Thanks. Does "for now" mean that you expect it to become available on
CX7 in future, and if so, are you able to say anything about timelines?

Thanks
Bruce
-- 
Dr Bruce Merry
bmerry <@> gmail <.> com
http://www.brucemerry.org.za/
http://blog.brucemerry.org.za/


