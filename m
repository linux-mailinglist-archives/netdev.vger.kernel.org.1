Return-Path: <netdev+bounces-270662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKwzOhWJwWn+TgQAu9opvQ
	(envelope-from <netdev+bounces-270662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:40:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8E2FB6DC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2AFE3053CF7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC13CF67F;
	Mon, 23 Mar 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU4LxGOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DC3CF697
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290518; cv=none; b=FaoSTiRWLRUc+22Fl3slfT6eI3HMiqAvdTzAm92Pk9tftLM8nhRjDi/vCXOCt/Tku1XIy3+l9a+FvhiFTSvobkO35jA4e9aH6Gkpne0/Y7iG+5WXsiuVU9iA1XzufC07r2zmMaq46Aj53YEY2yRT9NrJQDuT9k++Tbga8eiGvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290518; c=relaxed/simple;
	bh=t8uGoOmn69GTvslBxUEc5eTMB7ZiO+nrKn47M9Cp8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2SKtkwBaFEUrr8PfrChAoxtDnVOuSEWD9Bc9hBwalPFC8Jt0Xv7SXTX8VreqwswfJ3rsktE8oIrATZBtTz+89gaagNl3OmreIj1iC7KR3ZB8b+3KLEl511lrk/9IpUZy1TyItYrhlAXiQpsBe6mRr1KbDCJELxjW2Lh2Ty6ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU4LxGOf; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so3065601eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290512; x=1774895312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=nU4LxGOfPs3QZ3q1BOHY3xW1BsasEVECfsn054gvduGccyJOdGSSriZyQel7ZZuODl
         ND8rPtQjMEovixdtNdNPwz4OydDcycp5pWW/3m1fgC5jMQKNUFPH7NGtKsQK1IfKfrh9
         Rqidd+o/bKJ8/7fAi7cuedl4la/kRsdBnWlhvXPhFzz0J2hgto+9uB1E+I8bK+rQylJi
         lSKxKrIbr7b/Jb/WJJy2Mj5pzoj2OD079F/dp9rrMqkSgsYnMnG4IjOOa44gvtMGJhqv
         B9oDuQ493ayNmc/UX1pJrrIqdmYW1NQWAO9Q0QIVybo3KKDYoESuZZMQdAQSGs8k+uO7
         teDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290512; x=1774895312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=dGYkwxhbSaP7Uz1XPAI/XhZ72aeQWHioa68Aav0hCZh5G3TrzSYs8ZQ2j6f+6vk81u
         jN1YQvebpV5JwIXL2Ok8rqejm9dvxRImFg0ohV+NkCYPa7FhzJoBBa5gXbHHbfMBAwYZ
         GsSxrh5GxNfDjAjmVOyx0pVNqkc7X73EzTZ7ESxbbkUKuc1Ff7ix0skvL8rji94mblgQ
         OvOKWswKB56OD9vWcVu0r4rL5+K4H4cER3eIsS6sXdzLKXaHJSWKD63HuWRa4+AaFIga
         P2pcHPT0QeXPVmxltNR5bFhcyTPvbEI46gdGMU6asiilDFvvnl4vDY35nJN80NmrVXpr
         7sGg==
X-Forwarded-Encrypted: i=1; AJvYcCWYAYeAZbfL9LhbZC0OcFBblFqqoy6yIuQ+zQHj/2VMjjtiPBLMzYSwv2FSqss0qSm3yvEqvGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRZnFnCJhjQC1g5oZFE0DY26gbg2HOsxkxy7HvoT+JHct6alD
	ynQyhw/XMGdqHT49w6Qw4vvKnjm7vWbt7/FDa9pHwisxhiQLRr1aaD5i
X-Gm-Gg: ATEYQzzJ4vkxbvRUBXD61UftPN2ynl/OJrbTWaXZhSU7+QX01o20M1T/H9sPj/Uashq
	9dfYEXJmXm9Y8MlQy6m2rfAKZPRzFICUTGi+5lKSDGn39mkf63tHWTZY/jNKHiQoB2LixIgFGzd
	FPVDvlWn/U06oPeAk+kWlfnQKxl8sPd/x4ozGnf+lRxy7tCLPAxxvbnJIyLgW0by6JqqyNl2XIY
	FbrW135k+yN1NHCyUDXxOTTJvfveOKXsRB2/c0QVqsRTLn3RrU7nlrMJ7ut6mDpLOLzlGoZe5my
	p/kz1r8aJ0zqmX5vb/dGDpDvhdOO2xXTQc34eePx4DBcML+thCDwzkqN26qgf6/iFArYZo+zhqC
	TY1MtwVMNcuklMMXgjfiEz+jKmy1KEgO3UqLxE8sMlL/mMYRHABOoLhLw3dZ1lhEp0CXGxkr2vK
	OqrP2+D7fJKmX4HPIYNIl9Trlh2r79fpNi12o+0u5zSe2uHrD20hqZr/RTXZipbkM7
X-Received: by 2002:a05:693c:2b06:b0:2c0:ad52:e657 with SMTP id 5a478bee46e88-2c109712cedmr6434030eec.21.1774290511733;
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm17872306eec.9.2026.03.23.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:28:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGFksyx3SA0kJ5b@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270662-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88D8E2FB6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:00:43PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:22PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&regulator_class, np);
> > +	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
> 
> The regulator API is very deliberately specifically using the OF APIs,
> not the ACPI APIs, since ACPI really doesn't want to model regulators.

For now? We also have software nodes and maybe we come up with something
else in the future...

I think we should use firmware-agnostic APIs as much as possible, and
only use OF- or ACPI-specific ones when there is no generic equivalent.
This makes the code most flexible.

Anyway, I am not proposing to change all of the regulator code, just
clean up driver core APIs.

Thanks.

-- 
Dmitry

