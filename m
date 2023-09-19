Return-Path: <netdev+bounces-34950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371587A61D7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AB81C20B0B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A7847F;
	Tue, 19 Sep 2023 11:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37E36B1E
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:57:45 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B83F2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:57:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32008b5e2d2so1802050f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124663; x=1695729463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuJQaFLa14v3v4gCh7qh27URwpDr3Mx7FznQmAg/xfk=;
        b=CLQbjEPqvgYSJozJo/+/nMddwB9XC/KoKzn5SjXJrOB/m4NW27Rih3T4ytruHi/eJ3
         RhnfSpnhiqQz7hjE8pUm7ZmqDW+NHGThElL4O7S3DWW6odI+BDurFJ46H+wfU5i4UcGc
         zKZZnKOC38mj2tPsIE4LLdx/eUl8GS7ExqGkxnge6Xl6C//Uu8l8fe9w6wpWGGFxHT61
         SBC2n26KAFrpdtQKPv9VyoK8BW5W1UpDr9x8wLI7WCwJodSmujpOPxsAGgUZscrifLJH
         NFXyuLU6KM7sFEc/Si6eCcMApB3RC5EHy6V0OZ1Z/LRIZ5Z8HIUDMHvNdTVhbGIDuYWZ
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124663; x=1695729463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuJQaFLa14v3v4gCh7qh27URwpDr3Mx7FznQmAg/xfk=;
        b=BA4+3wvb7HFlBqd/EmjKfyNRcO7Fisu+HfJpnP+iM4JnY6rU0nSVNS9t6nFpKQHKb7
         wGgngk0mS0d9o82zYDwXUJRQuPUqEDsBZO1RKUxrNziqiyjQofBk8Qr/QeeY4Rt4nmYE
         JktYyiu4hvb0z2Bce0h6ZYSaEC6pf6SePojTrW1y4AExtXf6SJXrfYjKEvCYtM2nlJ2/
         qal2fNV/wM2l+zNcsWiXGZQZqF8+BhZS1lxXDP9iXbvP0XZMc48sN+OiKDueW+9++yzp
         JOJoEVoRjo8N/gPcn/foi8r7rvpJGStiLZNzMAtSe/A0nWwUBZ09yjwL4M9SZt0ImN6w
         Nd1A==
X-Gm-Message-State: AOJu0Ywx+Bkt0ZvmG57/2U65ROeGy9/fkNOsmMPl9z4s2mwRLv6UOjHQ
	qELeLD3FrubnJPdiGmfueCysaA==
X-Google-Smtp-Source: AGHT+IHgCilZpxDG5k45tbIW1KgIt7vjgEQAWgBmaT6kDNjLIRz4eWHB7woHNlKOuEVFeEw/lM4muQ==
X-Received: by 2002:a05:6000:136c:b0:31f:a717:f1b6 with SMTP id q12-20020a056000136c00b0031fa717f1b6mr1935266wrz.11.1695124662994;
        Tue, 19 Sep 2023 04:57:42 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b0031ae8d86af4sm15346274wrx.103.2023.09.19.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:57:42 -0700 (PDT)
Date: Tue, 19 Sep 2023 13:57:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [patch iproute2-next 2/4] devlink: introduce support for netns
 id for nested handle
Message-ID: <ZQmMtO+InwpjRDmQ@nanopsycho>
References: <20230918105416.1107260-1-jiri@resnulli.us>
 <20230918105416.1107260-3-jiri@resnulli.us>
 <628fff39-307f-c848-f72e-4ed8c682b34e@gmail.com>
 <ZQlIVVsUCcY5yHpK@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQlIVVsUCcY5yHpK@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 09:05:57AM CEST, jiri@resnulli.us wrote:
>Tue, Sep 19, 2023 at 05:06:12AM CEST, dsahern@gmail.com wrote:
>>On 9/18/23 4:54 AM, Jiri Pirko wrote:
>>>  static const enum mnl_attr_data_type
>>> @@ -2723,6 +2725,85 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
>>>  	       !cmp_arr_last_handle(dl, bus_name, dev_name);
>>>  }
>>>  
>>> +static int32_t netns_id_by_name(const char *name)
>>> +{
>>> +	struct {
>>> +		struct nlmsghdr n;
>>> +		struct rtgenmsg g;
>>> +		char            buf[1024];
>>> +	} req = {
>>> +		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
>>> +		.n.nlmsg_flags = NLM_F_REQUEST,
>>> +		.n.nlmsg_type = RTM_GETNSID,
>>> +		.g.rtgen_family = AF_UNSPEC,
>>> +	};
>>> +	int ret = NETNSA_NSID_NOT_ASSIGNED;
>>> +	struct rtattr *tb[NETNSA_MAX + 1];
>>> +	struct nlmsghdr *n = NULL;
>>> +	struct rtnl_handle rth;
>>> +	struct rtgenmsg *rtg;
>>> +	int len;
>>> +	int fd;
>>> +
>>> +	fd = netns_get_fd(name);
>>> +	if (fd < 0)
>>> +		return ret;
>>> +
>>> +	if (rtnl_open(&rth, 0) < 0)
>>> +		return ret;
>>> +
>>> +	addattr32(&req.n, sizeof(req), NETNSA_FD, fd);
>>> +	if (rtnl_talk(&rth, &req.n, &n) < 0)
>>> +		goto out;
>>> +
>>> +	if (n->nlmsg_type == NLMSG_ERROR)
>>> +		goto out;
>>> +
>>> +	rtg = NLMSG_DATA(n);
>>> +	len = n->nlmsg_len;
>>> +
>>> +	len -= NLMSG_SPACE(sizeof(*rtg));
>>> +	if (len < 0)
>>> +		goto out;
>>> +
>>> +	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rtg), len);
>>> +	if (tb[NETNSA_NSID])
>>> +		ret = rta_getattr_s32(tb[NETNSA_NSID]);
>>> +
>>> +out:
>>> +	free(n);
>>> +	rtnl_close(&rth);
>>> +	close(fd);
>>> +	return ret;
>>> +}
>>
>>duplicates get_netnsid_from_name
>
>True, but that one is in "ip", that is why I decided to duplicate, for
>simplicity sake. How do you suggest to re-use it? Should I move it
>to lib? Any existing file?

Nevermind, took a stab at it in v2, just sent. Thanks!

>
>
>
>>

