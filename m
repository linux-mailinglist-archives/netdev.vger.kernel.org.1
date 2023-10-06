Return-Path: <netdev+bounces-38579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F67BB7C8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92611C209FA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BB1CA83;
	Fri,  6 Oct 2023 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wLuloOra"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716941D695
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:35:36 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760DCA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:35:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b64b98656bso361864966b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696595730; x=1697200530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPJcT5r5NqW3rXXeioqjT7vInGqN3ma7GJ/PMepM5+s=;
        b=wLuloOraHoViJ6a/eyvcnAsk4zBaaxEbfPcP+2/gSTHZGvJf3rJoY3zTvdWyGYo6wx
         N00ejMg+5Bysc3h+okgEet9kzor81FnSpiP+OYnKv6aXzK7sUrwsdNfyEKpbOGbZzwNL
         bUgEwgp+YtQkf2yk5mfRS13XlA2QMvrqO4M2YxqMJnuXAEO+M6LX1g+xgieTwZIYi2+M
         dJXe9JKh+s1jNEZuyLds/BB9/IiyNXfrCMz6YCLFNR/4XcEWWYJBgijI7e4LExH96OIk
         +YZEpKBWzbFFQhhQigQnOr9k5Ig4P0XsvY4gyl4onz+oTMDLTTFc9zCAdP9RBPlOVPVX
         wl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595730; x=1697200530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPJcT5r5NqW3rXXeioqjT7vInGqN3ma7GJ/PMepM5+s=;
        b=KtZwLGwjByJEnvkQTVV5dOSwC6tEOla2S3Z3ZjDbfnZ1WgocKyERMRSlRnMvjGkJg5
         QqvPZKqr0+KpD7awCAv8yV+8KT3lfSeKmz4hN23zB2RU3LQ3Fcnz9hlC+b/lj/j/fDg+
         TZDhMJLxjG5tYkDhHh3yBq29iIkRt1UTNgtqqAhExaBzm2NOceUA7v1LDbRZrddCffTA
         uF/4VoTchU87k4uw/S0WFAcGRk1QQwePGDoZboaHTV2T3vZFOZSoLAPdA7GsdMMOwkU3
         uARJddk6fTImCHn9H/F+14SKZjU266KZFAcAVesSy8YT3+QPS9SCvHCA+7nIUT3zMzdr
         /+DQ==
X-Gm-Message-State: AOJu0YwsJNKc4A4LYTmcEGeRz1Uc/wDIaaa/Bd6UFP9upqj8QeCI2MjY
	DzyPHRbhCkohgtsM5/seZwlbgiU766erJqx/71tyDg==
X-Google-Smtp-Source: AGHT+IFXPSHOjrPnY2a/T+VhRBRqsxhIpMZ12KyvGwoTWS50mT/cmbXVGJWeZ/RIv5+kUbCFiUcCWw==
X-Received: by 2002:a17:906:1ba1:b0:9ae:5fdc:aee8 with SMTP id r1-20020a1709061ba100b009ae5fdcaee8mr7472326ejg.53.1696595729858;
        Fri, 06 Oct 2023 05:35:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id qb40-20020a1709077ea800b009b9af27d98csm1391700ejc.132.2023.10.06.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:35:28 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:35:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 5/5] dpll: netlink/core: change pin frequency
 set behavior
Message-ID: <ZR//DY6xMPi1AQ5i@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-6-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114101.1608796-6-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 01:41:01PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Align the aproach of pin frequency set behavior with the approach
>introduced with pin phase adjust set.
>Fail the request if any of devices did not registered the callback ops.
>If callback op on any pin's registered device fails, return error and
>rollback the value to previous one.
>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_netlink.c | 50 +++++++++++++++++++++++++++++--------
> 1 file changed, 40 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 97319a9e4667..8e5fea74aec1 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -615,30 +615,60 @@ static int
> dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> 		  struct netlink_ext_ack *extack)
> {
>-	u64 freq = nla_get_u64(a);
>-	struct dpll_pin_ref *ref;
>+	u64 freq = nla_get_u64(a), old_freq;
>+	struct dpll_pin_ref *ref, *failed;
>+	const struct dpll_pin_ops *ops;
>+	struct dpll_device *dpll;
> 	unsigned long i;
> 	int ret;
> 
> 	if (!dpll_pin_is_freq_supported(pin, freq)) {
>-		NL_SET_ERR_MSG_ATTR(extack, a, "frequency is not supported by the device");
>+		NL_SET_ERR_MSG_ATTR(extack, a,
>+				    "frequency is not supported by the device");

No need for this wrapping. Seems unrelated to the rest of the patch
anyway.


> 		return -EINVAL;
> 	}
>-

No need for this too.



> 	xa_for_each(&pin->dpll_refs, i, ref) {
>-		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>-		struct dpll_device *dpll = ref->dpll;
>-
>-		if (!ops->frequency_set)
>+		ops = dpll_pin_ops(ref);
>+		if (!ops->frequency_set || !ops->frequency_get)
> 			return -EOPNOTSUPP;

Add an extack msg while you are at it - could be a separate patch.


>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ops = dpll_pin_ops(ref);
>+	dpll = ref->dpll;
>+	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
>+				 dpll_priv(dpll), &old_freq, extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get old frequency value");
>+		return ret;
>+	}
>+	if (freq == old_freq)
>+		return 0;
>+
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
> 		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> 					 dpll, dpll_priv(dpll), freq, extack);
>-		if (ret)
>-			return ret;
>+		if (ret) {
>+			failed = ref;

Extack msg.


>+			goto rollback;
>+		}
> 	}
> 	__dpll_pin_change_ntf(pin);
> 
> 	return 0;
>+
>+rollback:
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		if (ref == failed)
>+			break;
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				       dpll, dpll_priv(dpll), old_freq, extack))
>+			NL_SET_ERR_MSG(extack, "set frequency rollback failed");
>+	}
>+	return ret;
> }
> 
> static int
>-- 
>2.38.1
>

