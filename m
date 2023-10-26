Return-Path: <netdev+bounces-44529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D57D8721
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733331C20A9A
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD43381C6;
	Thu, 26 Oct 2023 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc1SrhPC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A12EB02
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 17:03:33 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA8187
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:03:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so3006365ab.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698339811; x=1698944611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzchgOa7Zq9H++ZxvTv1zOflgk0E68bly4mWQ1uQYQw=;
        b=Hc1SrhPCk0ya7nv42X6G1MGJdUN7SiQ11ww9gWOgMe0CoIWSHW1ILqLySjTNMkbBNe
         lpeR+3Bb8aXFdSxdZ/VVVD/FfPo57h/ITlJEzP+TmpRNSaCZiYp5xtPQtabNitmecGTf
         y6ZG7wfPmVIiK2MWBCuV4wWBcpmwZAEXAUFpR09Hw2bL44Ly8wcZiwL31SPFutLLj8ZW
         +qSrsvY1q0O5SV9W8PKliu8noDOA2AhBBocu91yjTkmfU/5mjgP/8/vShjLNxiRB6lW1
         Sbrp/IBw6bmUSSb/isFVAf1qnTSzRkRH3SAntiqiUCf9RaCibn9tX7cwOB/0QHYujPGo
         SqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339811; x=1698944611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzchgOa7Zq9H++ZxvTv1zOflgk0E68bly4mWQ1uQYQw=;
        b=MLL5FR5R276X0cX/OlIUaSeTixEZXJFft6fMkj/4LWFK10sTVqLJOkXVhOmFpTzIJM
         yTlrJJSrGB1hnJBSSYQhDPTImstt4B1GEmjSjj+RPDdsX6vhIyAYwFCNOkdvlT7wFbh5
         M0jp1nan8SXpPUTIsUZT6VZEBJNiBNLEhnPqCOFrVhM5An8saxq0Lczm8UazROApa3xR
         +5EpyWkLnVK7Ufv6nA8JXBR42b3vD6xzRpUlx3etxZPJfXdhKqSXQJDtovGqpKJSYjUL
         Wg7cVOfa3z/khau+mPnH8o5+VMunnscouDEibW8/Fghms3zg0zrKEH3Huh68bMSWEImD
         UyNQ==
X-Gm-Message-State: AOJu0YzeqMmiFx6XtZObN0Pock1FFe5BgG028r94tYmvUSApfeOuPW2Q
	emJNToma6WX+kldK+LrDerA=
X-Google-Smtp-Source: AGHT+IGDxFlAR+RCfn2RrSLKnyjtzOB531985JzKGKD/npDxyPf5ZaOxTAxhGAxdBPUI8gHoQCD41Q==
X-Received: by 2002:a05:6e02:2192:b0:357:f345:7e8c with SMTP id j18-20020a056e02219200b00357f3457e8cmr322215ila.30.1698339811717;
        Thu, 26 Oct 2023 10:03:31 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:542:b658:250a:2f23? ([2601:282:1e82:2350:542:b658:250a:2f23])
        by smtp.googlemail.com with ESMTPSA id z9-20020a023449000000b0040908cbbc5asm651931jaz.68.2023.10.26.10.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 10:03:31 -0700 (PDT)
Message-ID: <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>
Date: Thu, 26 Oct 2023 11:03:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch iproute2-next v3 3/6] devlink: extend
 pr_out_nested_handle() to print object
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-4-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231024100403.762862-4-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 4:04 AM, Jiri Pirko wrote:
> @@ -2861,6 +2842,38 @@ static void pr_out_selftests_handle_end(struct dl *dl)
>  		__pr_out_newline();
>  }
>  
> +static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
> +				   bool is_object)
> +{
> +	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
> +	int err;
> +
> +	err = mnl_attr_parse_nested(nla_nested_dl, attr_cb, tb);
> +	if (err != MNL_CB_OK)
> +		return;
> +
> +	if (!tb[DEVLINK_ATTR_BUS_NAME] ||
> +	    !tb[DEVLINK_ATTR_DEV_NAME])
> +		return;
> +
> +	if (!is_object) {
> +		char buf[64];
> +
> +		sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
> +			mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));

buf[64] - 1 for null terminator - 16 for IFNAMSIZ leaves 47. I do not
see limits on bus name length, so how can you guarantee it is always <
47 characters?

Make this snprintf, check the return and make sure buf is null terminated.

> +		print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
> +		return;
> +	}
> +
> +	__pr_out_handle_start(dl, tb, false, false);
> +	pr_out_handle_end(dl);
> +}
> +
> +static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
> +{
> +	__pr_out_nested_handle(NULL, nla_nested_dl, false);
> +}
> +
>  static bool cmp_arr_last_port_handle(struct dl *dl, const char *bus_name,
>  				     const char *dev_name, uint32_t port_index)
>  {


