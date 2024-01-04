Return-Path: <netdev+bounces-61566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0E8244A0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EACC1C2214C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39023762;
	Thu,  4 Jan 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cC30SU6o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44E2376A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so470235f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704380831; x=1704985631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxIRrYKVm9lbLgGE/fKsTC4rA3OmYbCXO7T1xdSqM/k=;
        b=cC30SU6o9XVfmYRZuR/ki2V2ipTwSIlVGz79CoyzPexmzuqVwfjek6BYpRr2Cx5P9T
         F7DsiA9diwxeeDk27OA2UfexW9ELBfnT/2v1/OnZ8OnFsFbAZh5qQIAHD0alQunfbC0Z
         qyfEo4iPrCVsxnlu3F7jv1Eh0TFa6yZuWqHAFNtB+Y0371lcE95+Gw3cllU1PBXJIzx5
         /jEBGN+QFXMo1A0zQ6La7Ozakz1amPMRA6VLM+F0HGsK8QxfhWDn2C8AVnhSbpd7sVqe
         vCa8VgNoPtrWyn7wRdakN5m7yVsmUIqXRTF54Z7Mz23f+hvDqn6SG88GsjzPcHiDCD+c
         WCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380831; x=1704985631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxIRrYKVm9lbLgGE/fKsTC4rA3OmYbCXO7T1xdSqM/k=;
        b=ajE3fE01n5JKe56wfpgjtWWX2lOzcqZttV8j9MyoBOt0lh5dNb15OcrV98+tlm3wox
         dzsA2kMCtPI/5UX+QV2J4jOulMOM9rIGxG9dbJzU1JaIIXdNVpOl4IX5MjOcQOgtnnHD
         dAlVbO6fC9iadMs2OGHSVjig0MhD/set7kaJo514RwW8XXdoHT79JiNUAEJIth6OY/U+
         VXKfSawPo2NGuIu9DXrrbr/UtRsung3ZIJ2Ux2oQ7tXJA4Pxzur0jdZ8xzk/PCKe6uOB
         z46u8nP0EhxvkLjfhk9oSLuV0jiBJDl5zW7SZKvyvSfz/xQdQs6FvA1ZC4eqprP4aw9S
         47NQ==
X-Gm-Message-State: AOJu0YyELoBmVhAO/Ft52QcakWU+ztwel5JjmwKmw8BKcmpTZy6Xm8kW
	7crmmkXmkyHGeur1b2NUtrWZ4MzgQjIRAg==
X-Google-Smtp-Source: AGHT+IFflkF/Ph5guRFy12KKvredZAQX17X+ZMjcliHbuc1qd2lhnbh9KYLj2rBaCo5t2xFLzgYQ2Q==
X-Received: by 2002:a05:600c:219:b0:40d:9148:92a7 with SMTP id 25-20020a05600c021900b0040d914892a7mr421343wmi.89.1704380831313;
        Thu, 04 Jan 2024 07:07:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0040d6e07a147sm6009463wms.23.2024.01.04.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:07:10 -0800 (PST)
Date: Thu, 4 Jan 2024 16:07:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Message-ID: <ZZbJndeZ09-DeztP@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:

[...]


>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info)


What about dpll_nl_pin_get_doit(), dpll_nl_pin_id_get_doit()?

I think it would be better to move the check to:
dpll_pin_pre_doit()


> {
> 	struct dpll_pin *pin = info->user_ptr[0];
> 
>+	if (!xa_empty(&pin->parent_refs) &&
>+	    !dpll_pin_parents_registered(pin))
>+		return -ENODEV;
>+
> 	return dpll_pin_set_from_nlattr(pin, info);
> }
> 
>-- 
>2.38.1
>

