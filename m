Return-Path: <netdev+bounces-264629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJo8MKlAqmlQOAEAu9opvQ
	(envelope-from <netdev+bounces-264629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:49:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02721ABC8
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D3DB3005310
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BE3612F5;
	Fri,  6 Mar 2026 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBQa1fx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9E35F5E7
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765274; cv=pass; b=Z9ZVlyGHGHVfVLJvYPQ53m1NVdxSXPa0v3+cde4tnw33X47P4KawKxAYgWcQRiO5g3AlmMfMdbvCUclI+YVqAJAPFGpFG9dYCW+2jDXxdn0Le1F7nsOOMMaz+AcUcF/h4EHBeUPF+fgdDTLjgxWGLfFyLEqzVCZcH0MllLINSck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765274; c=relaxed/simple;
	bh=roDUwwN5trIGJXrQ+SzJRvohhN8jkqd5essBX8nFDGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU+JNRlpaBbsge2+fxTNk/8RE+2C+EgXp7jIufcHFUblid8xCgyhG8t25DQKXOdHZKL7FGjQwJb53dmBLSTtmtqcKu8kl2TERWBWzBSjKxYfCayoeWNZcd2MoH6yG8NPjeSat6nQWBKKH5ELr7xcCucBjFg6CkPzCdVkSXdQuwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBQa1fx4; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7982c3b7dfcso89121827b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772765272; cv=none;
        d=google.com; s=arc-20240605;
        b=SZxJHKT0pjGBAYp8PeaFekSrPG9P0cOGqGSq9uVrppg9XMmtCJOrshFbWZQjnRiU9u
         bgDaQMGnzbK1UmHNDW8FwootKMvjkOjgqh5OGlUoALTWC5CWQt3wlhfc4h38Dp0HZwp5
         mtdvvvu5o0JGWVeG90kyD3reBiW5tR8ksIUQgt8X1YyJeYAsHg3hwabB1uSpHRRzl3YE
         6B7wGF8HTCV6NwJF0IiFT2AP8vXSSvcrAgCVR11DJas9TVxRAEgMLo1f10mZ1gZufUgv
         g3Gj5vsaXuAHtAIVJW+sKNGMqilPvwgA5bZ+Pbe5VNbutUd8lW4PjGGloxhVPDVodtLA
         ofHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=roDUwwN5trIGJXrQ+SzJRvohhN8jkqd5essBX8nFDGU=;
        fh=owG5XnX1qZ3JRnSa1uyXp5LtJ8UmR+aoZbFRwicncfY=;
        b=OC2qwObBtuTpFIuZEUuZXmqPL1XT5/wWQbi5tJE6fRMog4bUuBZ4xqLFTN89woPV93
         /HwbocPzChqjq4ku8nDP9YfC5qFhPPSk9hpU1VZITaKdV3jXV0+vgFrCzTTMDVNNYyBp
         RwzLNB8fEVHbesKz3aWt+sDXh+GBX7hGjPh0STXW3Iq8t2l2ov65ULTG5YiTEWpgmx4c
         kS8XSIGrGGj8xUJlWTzQWn1a0+Po9GHYxsYB5EHQzRS9kHJlbr1TCKIpNYxac9+hhMcN
         yWqk/+e189W/jTb4YflPY7K4ftltC1OPaOwJudX6jOv9HnTotw/0WbzYje3ZfiKREE9K
         vIfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765272; x=1773370072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=roDUwwN5trIGJXrQ+SzJRvohhN8jkqd5essBX8nFDGU=;
        b=ZBQa1fx4W8eO++a12Vhz4JvokE1661wG6tR7mvYmsJ8E+iBuHnC78lzHBXDhwuP+nO
         zMVGmR04Zmm4dEoMpoCB6Ym6Dg/MZafrBgqQYV9whO+5+ovwiQp5HIQmFEfLIkqzgRkb
         3ggs/LgWTrboxnuTpOEkwV0fnAd9Awsfur9rRzsVDf7W92ips1rhp2vnStOm3AzlbeCB
         e/FpOiycXD8sKh9vnkcNVWuC3NDkSsyhXobuvQM6WmjtUcCYUh1xn5nNd0lB/gxpcm62
         tHcRIAmCElR/EqnCMaWbd6qKFytluqtPFJ5QzDoRL2+sTi6Te3I45vTz2rXF0w28wH1Y
         BC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765272; x=1773370072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roDUwwN5trIGJXrQ+SzJRvohhN8jkqd5essBX8nFDGU=;
        b=qoeoF4mrBsnZmVqFRsvQTWmDS3PiZKRLdesrxtc48U0lwMBSmOojutVEDZK/j1/w49
         6ELmZN7VlEkNbmfKc3hWamKwNNPoB7aNbn1GRTWRW+SwHwISsOAVMDWr9Ah0hGCITMFY
         9cTkF+ILduLh5n/UnZmjJc8fRbQBMYhAAmBi1gupOZrkIHf25AVJNBNnmy35yypxwV8Q
         8UfY2rf2rLFJjs3Fg33XVz1gGExnXW2ASlA6P1kAVfywQjdcvxcJ734iA23v7bR4Hg/C
         pdqGW/ut6lxu3gz75UtyWFGCdv9+ra5EHyBmUDOsEwPKh5V9adKc7tq3vvHp5XiKZMLD
         kswQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbypQuqPJQmNsqN1+WdQg9bC+q2oYcXEogVaLUGJhnUgiD/rvZrMgrWbqOTcoeKTbTTEgt4rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8duKMdxBVqhYWPUoFjl0CkbNOpAIxmptw6DdIwh57ydqIwr0g
	XllaZtAh6UeHisNny1rKfCRI7j0rYCvmLM1R22VIdqhx2/REetpRFU6GKD4e7sbJx+sWG0N1oD+
	U+w373P1WEa8W0m+NWsrKzWGIFHBISN0=
X-Gm-Gg: ATEYQzztR9CxbfWul49N+401p41oWVjtu4EMH6YuhcP00vvInm22oO83EC2IfBq5KM/
	rZCvlqclijLQCDZdN+qiSoGLciA6I/bsg7dzNIzfhuzwgqKn68KCmBG5ygSwJyihbIlEGtHbos8
	0eWXpgjESVy83fwnPSyQs73IJdHCpSxOAuUZUizz7/7cH7gk9DzAjkcZjcamz3mE3161HSxf7Nm
	nN8QTYfm0fsBD//AimcoJtJSfQW4+qvIvPGK+KdHXhBv2uA7Z2AQ64CWbBFptZJszJiKqhEPLa3
	3d+f4nE2
X-Received: by 2002:a05:690c:112:b0:798:207:9d4e with SMTP id
 00721157ae682-798dd69b1d1mr5036667b3.20.1772765271939; Thu, 05 Mar 2026
 18:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225111451.347923-1-sun.jian.kdev@gmail.com> <177272642704.3184289.3763404212538394213.git-patchwork-notify@kernel.org>
In-Reply-To: <177272642704.3184289.3763404212538394213.git-patchwork-notify@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 6 Mar 2026 10:47:41 +0800
X-Gm-Features: AaiRm51qq--B7Q2ndRqddJildAbFU0yoZwRVNq_kHTuc17z21jkjgAZSCDjm2XY
Message-ID: <CABFUUZGwaowzgLtMRbZMwKkv_TQkC4NXrVZctAspSB1QGL23XA@mail.gmail.com>
Subject: Re: [PATCH v3 v3 1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
To: patchwork-bot+netdevbpf@kernel.org
Cc: shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CB02721ABC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264629-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Paolo, Thomas,
Thanks for the reviews.

Paolo: Agreed on the Fixes tag. I won't resend since the series has already
been applied to netdev/net.git.

Thomas: Will send a follow-up covering this XFAIL_ADD/TEST_F() ctor
ordering case.

Regards,
sun jian

