Return-Path: <netdev+bounces-61568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46E8244A7
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D65B258D3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529921362;
	Thu,  4 Jan 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EDNkvqGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F0249FA
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d8902da73so4274235e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704380914; x=1704985714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfSh6vyDqYUXi7xZ7fhpJF+1QaGTBf6Af2OHXAsHDYY=;
        b=EDNkvqGqY/ziYyaCBY7+sGlqBd4K/mhynzcsUVqeGJCQCHKD93S9o/FwtBVrwI32ge
         5abSeBKQnqpex6IJt7eWIan6wBTznIJw16BYEW/FftLuOcGUYvQ2i0D9c5SRpAXbvzOY
         vSA4lqzlk0IwHndKcIrmEaOtO+Xo6fPGf5FBFFcCzV+FNBbh3D2QXTAMQ2kWdz4EM01M
         VtTZg7DIOZ1GdMo3yymE5y3dpjcGj8nxaEJnDRiECcRwapj+xMltjO9nDgUCoM1KozBb
         zcsgmoloD6SSQQZfiQTQFKcb/RjFUgZ+JZG2+0PMZvYs1BFyd3tG+NdsIX9VbzoHu0fY
         0LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380914; x=1704985714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfSh6vyDqYUXi7xZ7fhpJF+1QaGTBf6Af2OHXAsHDYY=;
        b=GOfhRftXeVbV44TO5m3ANZNwOqtLJIxNtw5VcRnSlGtwXh8USPuvZ67dnSzWVLqW19
         6UA2HzM3CYQuT3HgDtCmY9U+4SA2R2x3822BxzQEUSioRN2zLHzaf04Gzq+VvGNQTUkS
         Bs+XzNgDeH0JMgKX0rgt2jOFJl6rdSQgG6Dk1TXvr1Pz/GNwJ2QXvjNAVWRd18S9bApR
         gci4WCUqRDhoJdpZ8RoixHPHo5IeueERUyijry+APVGPXFzXKBSJbptiawaYWTZjTtjp
         bLqKBYnwQa+AGME8UZ+qLsfkdaRzgVAqp/+3aRtPfoVGl+MKX6GnzLizwpD7ltaFDhWc
         zOHw==
X-Gm-Message-State: AOJu0YzufvnQryCNK6ZJJvrZIJ2xj8IfP3wpH9BBp4x1sXnyQiDr3aRU
	G4YTOBfbHFKHNci/Pr59QZWOuQvb3mQPMQ==
X-Google-Smtp-Source: AGHT+IGI6/7sf6is9LQJWAy0NKkeVobL4AJ4D4gAG2QXz1Tb4oEGfoNHhwQgS9+WSWHnKtvXKHfXDQ==
X-Received: by 2002:a05:600c:b58:b0:40d:87b7:2462 with SMTP id k24-20020a05600c0b5800b0040d87b72462mr435087wmr.40.1704380913877;
        Thu, 04 Jan 2024 07:08:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jb18-20020a05600c54f200b0040d3dc78003sm5876548wmb.17.2024.01.04.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:08:33 -0800 (PST)
Date: Thu, 4 Jan 2024 16:08:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v2 1/4] dpll: fix pin dump crash after module unbind
Message-ID: <ZZbJ8I99ia4kbBL3@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-2-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:29PM CET, arkadiusz.kubalewski@intel.com wrote:
>Disallow dump of unregistered parent pins, it is possible when parent
>pin and dpll device registerer kernel module instance unbinds, and
>other kernel module instances of the same dpll device have pins
>registered with the parent pin. The user can invoke a pin-dump but as
>the parent was unregistered, those shall not be accessed by the
>userspace, prevent that by checking if parent pin is still registered.
>
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_netlink.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index ce7cf736f020..b53478374a38 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -328,6 +328,8 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
> 		void *parent_priv;
> 
> 		ppin = ref->pin;
>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>+			continue;

If you make sure to hide the pin properly with the last patch, you don't
need this one. Drop it.


> 		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
> 		ret = ops->state_on_pin_get(pin,
> 					    dpll_pin_on_pin_priv(ppin, pin),
>-- 
>2.38.1
>

