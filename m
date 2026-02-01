Return-Path: <netdev+bounces-255584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD7iBHEPf2myjAIAu9opvQ
	(envelope-from <netdev+bounces-255584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:31:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1367C5402
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1A43014133
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99FD2DB7AD;
	Sun,  1 Feb 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+zRbNcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2C1FE451
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934699; cv=none; b=AT3/ClpPRri6g9QTnhCiv5I3V7OXNosjN4ZRI+hRg6NzRQ80agidLP5LLewAL6fKJ4IxKEuc90ymdXIfoJ1D3OY24Oev4uLMpssFuFIQ5PbjIu15U4kTs+DcR/WqDe6V/bLQvVsPGMtylohXVQPIJ8KHY5sMfndirJOiKoMI/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934699; c=relaxed/simple;
	bh=LQmmiHx5w8tZVOwNLsHgS8a+2UGZKLcitwgGC61lnfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slBAP0ANNWCt1e61OjoiLR/R15otQASd7fOG+FHerSU9JcuIZEeO6RhwShMNU/Sd6NnrxSW6KVz48dWNJZucfiFWnMuvp0Ug8Xe4sTQ69P8+1SJqMQIGJ3/h3HOaFL3B9UoBVkYvBZEf3M/lc8myXxYACgpR3+Aq2j4N1ZnxUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+zRbNcg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4357b308f28so135036f8f.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 00:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769934696; x=1770539496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq8p+3GS5rJ+sMx/Auwolk1i3RSb2e6INH/BBCQXxTE=;
        b=I+zRbNcgkZb7WJJ7nJ0ZKuPVc+71AA6KitbtA9awYoMxS7pw9uGOLZlqKeNuRmL5Ey
         Kw3dpY1QQ+t8uSvOjH4qxxGdOPP7keCjyCa29Sa0QiigHpz+IaOUl0teBevnFbl4Cn5/
         2hiHR2GlMljfBsCZcWsQddTZ543xFcXZNB01HOSIt0B07/GHjwyaSPIVbaHpdIQSQb3K
         GN1R93maRaJCz/PlDFAswsyKudc7RjSStxgCriUC90lCvYrDy9nGGuKABzbEbuDb96Xn
         jHxI21NBp1bHtu8/2Zm25sz2Mtkc5c5a9w+P5Ombp7OsJE92psMcEX2jLY1GJZLwK10d
         nUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769934696; x=1770539496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq8p+3GS5rJ+sMx/Auwolk1i3RSb2e6INH/BBCQXxTE=;
        b=PH60ZwHfwca1cu8yuPXwTBY/hIzPkMhdXyU/Fa1LilXrXP+zTCE5m/EN19UOm63rjl
         LxXbqOHrzpGbxsu6uowxP73DnVR7QMRNNEx2t0QjT56eXpWMvKflDniV2y2RezNlixDR
         Lpegc1D6u+NSsAMMf6uH5Krdpxo56f7Ls6ZElDKRf5P5462vUERHu/q3G3dY9PaKUBjd
         65zx9imbv6GDnIZo4RdsUpa3EkLuxom5xhvhYT+BI2lybrNR+aweibtK6NlgZyb6ChD4
         PbAcQz1nqsLKwRX+pL6W916aS5Q5jphc2DMIsefNOdDRuqe6Wyd19JqCSTNESSjienmU
         EJow==
X-Forwarded-Encrypted: i=1; AJvYcCVIDRCCV1dJUstlOThmt7iYVo/CjEmbjAopaq0lJxHva0HIewLBer0X8spBpKImevsJlE94uVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6sxBhQME6roAunpLsrcEPl0qwnZYIAonwUGtQYSBhKuN4JMU
	haAjscxgbcGQn91br+ld/nnOxDr3d9M0Tamq/uKRV/S/vxECY+4jujuu
X-Gm-Gg: AZuq6aI5Q4UkexK48TJMhJ2a1Cn06cCVZfIN89EX0p8M4VfYv9wFbt0OVaeHQAk9CHF
	vtuebjM6dm9qvaztFWcci+vxNhP5klJzv9i5nZMyPC8HxpvC0c0dh8hVHehAJ1rd5uIEVeeIhzM
	ecny6LdVhsjggwKW2xfz7+z5BY1Bwe4bEHO+rEqp4ujacWe5TrIU8+sjuxXpWxjmrkx2upHOCJx
	vn4NNzWwJS9WYJ4LAOP+7cQNEIu/jnzqF9/e/ou0sSmdV+9I/lcW8UhgujDm1UXE+iDsp790znw
	fl9gkxnC4tv5wbvToI7vM1VaVkkHzHtabSopIFB7JYKBz2ybhCskxvsvp07sTglsgFcfVwVqHed
	s+e54nGGSw9W403QwEXydH1qDqOmI33To1JQOWnlWc7/8zDNLhrAwH5G/JYYYwnhET5dnwXjc3T
	ygjcY=
X-Received: by 2002:a05:600c:8217:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-482db4ca9bfmr60365615e9.5.1769934696368;
        Sun, 01 Feb 2026 00:31:36 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:1194:3ac0:7d64:6ba4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322eefsm36013033f8f.30.2026.02.01.00.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 00:31:35 -0800 (PST)
Date: Sun, 1 Feb 2026 10:31:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mxl-gsw1xx: setup polarities
 and validate chip
Message-ID: <20260201083132.sfxg7y63duukoxte@skbuf>
References: <cover.1769916962.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769916962.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255584-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1367C5402
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 03:41:34AM +0000, Daniel Golle wrote:
> Now that common PHY properties make it easy to configure the SerDes RX
> and TX polarities, use that for the SGMII/1000Base-X/2500Base-X port of
> the MaxLinear GSW1xx switches.
> 
> Also, validate hardware in probe() function to make sure the switch is
> actually present and MDIO communication works properly.
> ---
> Changes since v2:
>  * be more clear about describing polarity at port, ie. external pin level
> 
> Changes since initial submission:
>  * use allOf to include phy-common-props in dt-schema
>  * use phy_get_manual_rx_polarity and phy_get_manual_tx_polarity helpers
>    instead of open-coding them

For the set:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

