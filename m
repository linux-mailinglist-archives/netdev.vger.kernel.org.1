Return-Path: <netdev+bounces-270750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBhhNoizwWnlUgQAu9opvQ
	(envelope-from <netdev+bounces-270750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:41:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CDE2FDDF6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CF253015BBD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E63803F8;
	Mon, 23 Mar 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvOMxUP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B63803D9
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302070; cv=none; b=N2305EOXylNpoLiLb/TnPwRiLetnh6G/uACXjRnbhiUjYJ7IrUhpIwLC+Z6aOAChgQSU2YZUvSN+CItph6nTico3FFsE/tL2scvqMCCsInV33m4BakPnkKElFW75mbQfZGDTNmzIw5XdGI6fAn9pf3nA03pJTV4x6eH16p0OA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302070; c=relaxed/simple;
	bh=Ia2wOeaNxrGGSqm94OjQXh1deCH4whLtBppic3PUk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQWXUacUvKQkp3GHUIXHcM7ya4dQ4aAJ/l+jNYr2KQa2Va0wjtdgDnrYlyd6lL/yYPixyS7JAHMliIrCwAZQu4gv/ud4tteykn968rxclO+0NAMHfHc9STvgC5w4Ll7dZ3lNBi712vgNa70k41AfLwdhxWXcw/1Qpd3u8J4mDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvOMxUP3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso4850657c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302068; x=1774906868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7HCZ5YthEu6Sto4GADNi5rznGP/hi6UoU7AjdQU+RY=;
        b=bvOMxUP3ynayoZoyQiQubkhgSB8gwVBqoVcFi/egyb7w2owvUhwCU9zc4g2v3ctqCD
         B9O8oZmoaNmgoTpSUMugSavwhcQw/Mk62VoF8VU3NhecFu88XPN8zcD+HbSLj0oXUxyC
         Uak67PuSuJwMSOBapnvPrhpdLqV1WnYkFhMp0VHFSaRHSdPftLaCsO+8090CSi/ZEuUY
         H4EOf4cAnGEcPNfQutrSMyl++XsVQ7+a2ez+143H+ogac1wgD6++YgqtDxYVnCbtV/JL
         8MD7fp/sk3fLbgxnYX3lRnrh+ZSq7NEE7mMTUXvIWVLVci3z7Cao4NWPVIreNe+fwAv6
         4UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302068; x=1774906868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7HCZ5YthEu6Sto4GADNi5rznGP/hi6UoU7AjdQU+RY=;
        b=I7r62uCYrZaghjubD9Pjydy7N95wiQqOt/Dpmi9CF6JttW24DTqBJ5AiipZt9k3CJt
         2CWQ++4QC1VLvNA762yf1b1HUBwvXwJvUnK3KWDchRcNaU62GF1oMw57Y0Foghvj9oRo
         w4h4kvPpmb5zvQhoBUVUM34POwZbTfAJJ09Z5Prxqgt8EA5f/FSKpyNBf5lpEyuJ7X57
         aAM1aehDDlRDEEPRHq368VK9/DXNkir616o4+3xF3Cb1Hp8I64PBjC3NQ2p/Kl0sd4bQ
         CWOYp+f6JPh5GYYz319x2851BGaf7BvPYeoM6gWq63zFnQ5RYPrFNq8nzazlIlshWFg/
         lWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8pjW5znbXCmFt5Xuxv8RCohFAjrjF7QQIXTZ0yFjhZcCw0lkoBv0YRfBjcDJu9LW8oGmRmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBktWhGZNZtiycjJ0+LmVJkXgBe0eLM1x1cp7V851K3m8nGE4s
	3/ASA6Bix1XYZxHgJMIHN0Rv++8Ax2vfWq6ABU3o6bD7ZA269OEu63D1
X-Gm-Gg: ATEYQzzU/PzuvYs2debuZrAezPhcDBRv7cYaR0Q23W1yJNAuqphuaLdJVrf/uc0nhNT
	F+hJZiYfw2mZermBeIEW2PFIFXRtxLf70ZHlcJU+Mg1ALrMGGGNyC7s7YbhLD1Y4NGYJbpChAwe
	IiKB67pXoO+RdEQ8dXM+NxBM/p1pQY2KfMGCsMRDum5Lw/TB0DVfqL2PMxiPfjC8M7qIbfvCxus
	u301xnVtA/UkNq1DNQeEuR5iH9VwZfeX7mpm89yz1kvZc1JBwQ2bxbz1rtN86AfEjuBPPeXEe+d
	E4FNCn996XlCQ+gHS58XdzKM65BGmslSQSn+jcjSa4CzVWW1IqJdqNG/saf/5PH/C2uRT7GNTAA
	nQO09omFPS5FS2wyr1o4sAthEk6vH0HRbgVrE2q5Gbp6zxjIy4dxWT9/naZGKLwtDim5JtfP2Xe
	kVg328y4++ZrJ7THoqSilRMIRFUu8SvncdglwxOONVXnx8OsTpMWOLm62azVqL0A5B
X-Received: by 2002:a05:7022:31a:b0:128:d24a:a5ba with SMTP id a92af1059eb24-12a726cafe2mr5295048c88.20.1774302067990;
        Mon, 23 Mar 2026 14:41:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9682893c88.4.2026.03.23.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:41:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:41:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGzJV3vKhuty3nd@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35CDE2FDDF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:36:07PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 09:01:47PM +0100, Andrew Lunn wrote:
> 
> > How do you handle deprecated OF properties? This is a problem i've run
> > into before. A developer needs an ACPI binding, so they blindly
> > convert from of_ to device_ without engaging brain. As a result, they
> > bring all the deprecated OF properties we want to die into the brand
> > new ACPI bindings.
> 
> Honestly that one hasn't really come up much for me - not too many
> deprecated properties.

Given that we position properties as an ABI even if they are deprecated
we supposed to handle them forever. Newer properties usually offer
benefits over old ones and that is how users get moved over.

Thanks.

-- 
Dmitry

