Return-Path: <netdev+bounces-42647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477787CFB70
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0134928202C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9E2746A;
	Thu, 19 Oct 2023 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Rc++FVhp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C21DDA6
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:42:14 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA2124
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:42:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso13965941a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697722930; x=1698327730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fT6yjQzbrIxK4VbxbP010pd2CoBqENWGiNng7XdOAY0=;
        b=Rc++FVhpM5xZ48/mZCvWnfcUN/ILrBi9Reb0Uu/uRneielMSPGMsozS2oRLzsQ+n3d
         +avsY3oPIXwP01ZSYkuzv9dT19+3lAD3jRUdFMDvZ4A8v87SAbBB0Bo9mzxW9eU1d18U
         05kG2muh4jJ+t5XoY5qqbNOP+LrCacode+St/ec9YFpeV481CLdADRL49/QpXe7q/V83
         Njhr6mM14hdG/Fnc3fs365PY8iWsaiavCwZsze/ZP6nXMVuSry3vwnzaPXT2uwbqIwI6
         pkmN1vtXpCglwjnpl0l8XbjpBiSGg1/+xu5IO+a5UF/tRPiVM0Cjk3d/hufzHSwm7byd
         O62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722930; x=1698327730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT6yjQzbrIxK4VbxbP010pd2CoBqENWGiNng7XdOAY0=;
        b=QxX8UiTS2gZqhQcqt1roa84R6WruJmj4j3cS5SwB5Y0ydUWfsqbPgCxU7XAHMz0qcQ
         67oBcLqC8Y57/k9RYdCbTn4vui1RWkijN1pSt3fWs/Kjb3mcUR2Igmh/di8RAiKmTKus
         XY4zDyj3hT5Sd9zGHnj8uUkkpXLi+eTkAuAvqxfScDTOrqorNw6eLhSVVtx9MN/jpZSN
         ONyOuUs4w4hJoA+MWFUxK4QMhbJS34hTu+o+Kvqb8l60GUyvnsSN00Oc0jIfmMX394rp
         RIyiz7/EuiEDuZvvs/v8nDNl+8yMOzKzUd0gaPYD1oa5m7Uk91q4zLqS8EPRsFiJaMt8
         3auA==
X-Gm-Message-State: AOJu0YynUwMdU1zZdxK68WLQGZPbn3K4cR1F/59RNiBc0WFjGeo4hhKp
	xomtYPIOQwBiK46Yr/ox0gl/VqUHE7ee1RmHQLs=
X-Google-Smtp-Source: AGHT+IGE9rzVVn/ZQD2MhjwKSqCyHZIMrOiqduxfGeyNNQzs03Ei7gaVDj3EYHkvEFyKzWv/qSgk/Q==
X-Received: by 2002:a05:6402:4311:b0:53e:1825:be92 with SMTP id m17-20020a056402431100b0053e1825be92mr1672251edc.31.1697722930155;
        Thu, 19 Oct 2023 06:42:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dk5-20020a0564021d8500b0052febc781bfsm4495398edb.36.2023.10.19.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:42:09 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:42:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net, opurdila@ixiacom.com
Subject: Re: [PATCH net v2 1/5] net: fix ifname in netlink ntf during netns
 move
Message-ID: <ZTEyLbSgJaZcHnja@nanopsycho>
References: <20231018013817.2391509-1-kuba@kernel.org>
 <20231018013817.2391509-2-kuba@kernel.org>
 <ZS+FehME4fC4b7w4@nanopsycho>
 <20231018081341.66bf393b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081341.66bf393b@kernel.org>

Wed, Oct 18, 2023 at 05:13:41PM CEST, kuba@kernel.org wrote:
>On Wed, 18 Oct 2023 09:12:58 +0200 Jiri Pirko wrote:
>> >+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
>> >+			       const char *want_name, char *out_name)
>> >+{
>> >+	int ret;
>> >+
>> >+	if (!dev_valid_name(want_name))
>> >+		return -EINVAL;
>> >+
>> >+	if (strchr(want_name, '%')) {
>> >+		ret = __dev_alloc_name(net, want_name, out_name);
>> >+		return ret < 0 ? ret : 0;
>> >+	} else if (netdev_name_in_use(net, want_name)) {
>> >+		return -EEXIST;
>> >+	} else if (out_name != want_name) {  
>> 
>> How this can happen?
>> You call dev_prep_valid_name() twice:
>> 	ret = dev_prep_valid_name(net, dev, name, buf);
>> 	err = dev_prep_valid_name(net, dev, pat, new_name);
>> 
>> Both buf and new_name are on stack tmp variables.
>
>I'm moving this code 1-to-1. I have patches queued up to clean all 
>this up in net-next. Please let me know if you see any bugs.

Okay, fair enough. It just looks odd, but I get it for "net".

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

