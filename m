Return-Path: <netdev+bounces-271289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFl4FhP2wmkEngQAu9opvQ
	(envelope-from <netdev+bounces-271289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0C31C648
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C8203035A40
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF43542CA;
	Tue, 24 Mar 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeS/98XC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB53537F7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384650; cv=none; b=IEq6HEaWKcjQFKCzyZfey6VKiD7CNp7E0BueXrRTFMDLYZFErUFcxXiHrlOy0x9p15PdBB/9N8+iLmG9d/XJqvrxUg8qN4FOj7nhEDWgB7LBdYNcn1GJuRBRvre3Zefdk0+Q3A2R5u7AuMjW8R3pSIAAx/GVzvY3zO8uNr1wF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384650; c=relaxed/simple;
	bh=2fb9QmqUnFFelrj6A30F7vaMKOKb/UcvjcX+rchrfqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW4b+tEbYxXRaTQ8ZVzlRAyWbGCcR+1VdQ9HqxIy0l0SoAruCv4uXuHy0h2wmD0vY9+DeyvYTdMklihAAUyRjTtw1QQ3ABNvNGbCSFI98hnUBYL+uhNN2x93/3FbMya7LsWK1mHFqVTAdv5gW06OxlpR02fTLjPyacs3Zo4thzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeS/98XC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc49c5c0so7130275e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384646; x=1774989446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kl2wSUguQHFJVaa5PJoa/q8MZubAAVwaDsB6skZ4oE4=;
        b=EeS/98XClSeBauhFPhrpU0JFT1XSiS0rIM8IgdBVMWxWoMHU9BXljdhagy4Pi0Du7A
         zb4/gKn//2zStgbwXSlNq5LokUpVq10vUD3lJUT9uas2trTFB/Ps+0A8ffnar029BldN
         7zAQPJGNUMD0qNqWILX+MDEHIVcS9iXNVuBPYvq5ZnOQ2TdqqnfcfwDqwCLRs2RiFNiA
         Drf+n5ncyJVlKTvPkF5C0vnw9Nskla51Zkf/8mOubCOkztKfh6MraV8b2dNxM7lZR9N8
         ZpRK4G/x4CEPDcIsG/5pQ2sLSXUdf7ac4hcZvTaiZJZCZPQVQaGpZhNRIv5W1u03vyMo
         btgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384646; x=1774989446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl2wSUguQHFJVaa5PJoa/q8MZubAAVwaDsB6skZ4oE4=;
        b=C9fzktZZ0QQSDEn3rjS0DOeYHd85UE9xEQb7BFybqoVRjRc0sjglitR/TEvfFyt88O
         atnMRcpDjzI8lOq3mFJv1SfXJjgmIwvam/wZqG6UHPtV3e+gJ/AZ9O4Y+HmO0wYvKumm
         +RLNXgt4F7e/eG+pnOws54j6Jxwfptam6hho9TYmMSZcr1O6+Lx0kdJNbmy8e6BFSDiB
         xnxCijZI3udwXpubREAQqKHE6gEKHptIVhcGneE4wpdb4xv89/F9npKcvaFvnFP2ZkJA
         mzQCDHg8y5Gs0JKPlqWPmT/3IprLaiB8AgzGOiLOWutdwdgCFtXNyuoMNd8AwjgwiJV/
         cLpw==
X-Forwarded-Encrypted: i=1; AJvYcCV4XM+Uo7Q3yIaRfRxADKZ99TGap6yTOUPTAkZSHlfAnWoPkH4kBsPdcwWEIDB4zDb1CV5SGbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYO4ycnSxP+oDkOmur8mpoK8Ja8qN0FXFEfhHRD9gShu7P0mM
	tCAwo9/wHnGU0VqF2SY41a46rGKTlWlV+p1ZDFqqZPFeCaUKfZ5nXA/7
X-Gm-Gg: ATEYQzxzJbxm3GDAPfkQYJJBKV6zhALeeBcRM6grPAC5D00y0/FRhREyn0xTHoY5pEe
	GDgxB3XEKqUE/PRvMLqPnm+mVGuqDXJxadkxRjw+7/wCx1xNqogJl1Zem+8NWueH4ORXLQ0yt8x
	eTVzsJQBSU8lj0pYwzKyf/oXD7ebmZaNiJwE7zXp07OxJ/UT1G1ocFOpBqacdvcnTRUh9FhlHSN
	dH+HRYsjClP87RRjVxwTngkMMJu0NIeWlIrslKOtRMJrcRZq5igOu0hwXMeIFvYfjUzn69d9HXS
	aFAb/bXjijLKLmKFi5QSS8FT6j6Lmoga2R5JcPcrRTcQKQCLImPmPzE+GcSwjdkJd2FIqtja7Pk
	dFVKWXXCCrWLKliuJ08P7WpjsOlHDSZelQTTWjxh4xA1JZ0k/z591chG7Zp7ZZa4xSVmCYTfZhi
	BU5lDN8n4bn+MeHA==
X-Received: by 2002:a05:600c:4f95:b0:486:fcf9:5ba with SMTP id 5b1f17b1804b1-4871609da81mr9456935e9.7.1774384646022;
        Tue, 24 Mar 2026 13:37:26 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:1955:43a4:bdf:48ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm92104015e9.2.2026.03.24.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:37:25 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:37:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Drop unnecessary check
 in ksz9477 PCS setup
Message-ID: <20260324203722.4ahhkivou33kdn6o@skbuf>
References: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
 <20260324180826.524327-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324180826.524327-2-maxime.chevallier@bootlin.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271289-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6F0C31C648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:08:24PM +0100, Maxime Chevallier wrote:
> The ksz_dev_ops .pcs_create() is called under the assumption that the
> switch has a PCS port :
> 
>   if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
>           ret = dev->dev_ops->pcs_create(dev);
> 	  [...]
>   }
> 
> The KSZ9477 implementation of .pcs_create() does the same check on
> ksz_has_sgmii_port(), and protects the entire function with it.
> 
> Drop it, saving a level of indentation and increasing readability.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

