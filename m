Return-Path: <netdev+bounces-34876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DAE7A5A78
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099291C20A23
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BE358A6;
	Tue, 19 Sep 2023 07:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5735890
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:06:03 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE32102
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:06:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso18199385e9.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695107159; x=1695711959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VplTJYtmRrVwXcqQPH1K3K1mtKpeZAcANhFdMcS868w=;
        b=FfnXITCx3z665eit2TzfuS7O5PToy+5R7TvTGA3YYAZlVKCr+7etVgOEQ3K/L1BmbV
         U++a5Dlx3njP/s7J/WIScJy9xdF3/dgCez7qFYmC6RfK3DjBtvu9czagKwuTsvK30tnZ
         PDkinUC0QvPlsPsvHTPC7oOr3OnmHELO5d09wFiiWWrbtManGJObkma0i0LX1o/l8hmQ
         cCpTHlnyiAkSMFlWNPEwG595kvoX1SnbPqjzqroPRftBLS2ZjCKBfqQ8LjAXog1pYVLk
         wqRYS7x4reBhYOnn8EllgtPDTkp2eVfw99835crNAoTiMyR42jN1ElQrVOjhvM9Vdk/l
         bPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107159; x=1695711959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VplTJYtmRrVwXcqQPH1K3K1mtKpeZAcANhFdMcS868w=;
        b=vMM+t8zICD6GcWOT37kpn4LrKRw5m1SWrTAiPEUqZ6Z0ZnNapbdfXGszcRbyGb588h
         E/G2YlGog+ylzN9JjxoskWq3Te+gaBomNvXur0XWqTA6WVlfNU7eb7WdXHzXlAd9JIZ5
         +Y95YR/Y9r2vG7ECFC+DRdWMirKw0gN4WwlR6MyyM8U2laTPWjMqIJSnjb0IN/pE39VQ
         0mQASptImM+KSFOwz1S/6o3OwqlNbFCuTyzJDQBsXoaOYrwl+Jy9X5L7TPl9jWsxNT5Q
         69uaGsh63UjgNL+n052Saj02/+ESSrzoUkFkBgoZvKkeXWoPi74wx3J1Yx2DX2DKltUl
         VZkA==
X-Gm-Message-State: AOJu0Ywotxj3WdB3MoVORj4+rL25E6SNftQ/+yrfFnVTflzhhG2mGRso
	hp86Qpu+ANGu4uOUXwqmVCsofpfvEQjq0SfEMgFdcA==
X-Google-Smtp-Source: AGHT+IGNkDxKKElJGqCKzHaYix2EpSxyhxBLPZrBbrqdQgkjbBrLxSP9JWldd2tC0pIBdz6mlJ34EA==
X-Received: by 2002:a05:600c:2057:b0:3fe:d1b9:7ea9 with SMTP id p23-20020a05600c205700b003fed1b97ea9mr10065247wmg.36.1695107159252;
        Tue, 19 Sep 2023 00:05:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000024c00b0031989784d96sm12538282wrz.76.2023.09.19.00.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:05:58 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:05:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [patch iproute2-next 2/4] devlink: introduce support for netns
 id for nested handle
Message-ID: <ZQlIVVsUCcY5yHpK@nanopsycho>
References: <20230918105416.1107260-1-jiri@resnulli.us>
 <20230918105416.1107260-3-jiri@resnulli.us>
 <628fff39-307f-c848-f72e-4ed8c682b34e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628fff39-307f-c848-f72e-4ed8c682b34e@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 05:06:12AM CEST, dsahern@gmail.com wrote:
>On 9/18/23 4:54 AM, Jiri Pirko wrote:
>>  static const enum mnl_attr_data_type
>> @@ -2723,6 +2725,85 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
>>  	       !cmp_arr_last_handle(dl, bus_name, dev_name);
>>  }
>>  
>> +static int32_t netns_id_by_name(const char *name)
>> +{
>> +	struct {
>> +		struct nlmsghdr n;
>> +		struct rtgenmsg g;
>> +		char            buf[1024];
>> +	} req = {
>> +		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
>> +		.n.nlmsg_flags = NLM_F_REQUEST,
>> +		.n.nlmsg_type = RTM_GETNSID,
>> +		.g.rtgen_family = AF_UNSPEC,
>> +	};
>> +	int ret = NETNSA_NSID_NOT_ASSIGNED;
>> +	struct rtattr *tb[NETNSA_MAX + 1];
>> +	struct nlmsghdr *n = NULL;
>> +	struct rtnl_handle rth;
>> +	struct rtgenmsg *rtg;
>> +	int len;
>> +	int fd;
>> +
>> +	fd = netns_get_fd(name);
>> +	if (fd < 0)
>> +		return ret;
>> +
>> +	if (rtnl_open(&rth, 0) < 0)
>> +		return ret;
>> +
>> +	addattr32(&req.n, sizeof(req), NETNSA_FD, fd);
>> +	if (rtnl_talk(&rth, &req.n, &n) < 0)
>> +		goto out;
>> +
>> +	if (n->nlmsg_type == NLMSG_ERROR)
>> +		goto out;
>> +
>> +	rtg = NLMSG_DATA(n);
>> +	len = n->nlmsg_len;
>> +
>> +	len -= NLMSG_SPACE(sizeof(*rtg));
>> +	if (len < 0)
>> +		goto out;
>> +
>> +	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rtg), len);
>> +	if (tb[NETNSA_NSID])
>> +		ret = rta_getattr_s32(tb[NETNSA_NSID]);
>> +
>> +out:
>> +	free(n);
>> +	rtnl_close(&rth);
>> +	close(fd);
>> +	return ret;
>> +}
>
>duplicates get_netnsid_from_name

True, but that one is in "ip", that is why I decided to duplicate, for
simplicity sake. How do you suggest to re-use it? Should I move it
to lib? Any existing file?



>

