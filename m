Return-Path: <netdev+bounces-62198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FB8261DE
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1D282D72
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75533F9E4;
	Sat,  6 Jan 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LsHYH9h7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246E101C2
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bc09844f29so806082b6e.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704579281; x=1705184081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS4qazorYduSB7jUXsLe+JhpKXe1zULh9HpZv8m/hkA=;
        b=LsHYH9h7ruTTMEK3FVeGUCWwn/VKzdLs1JBltAjqSf412FG90FSjmd5YMSO5zy36U+
         9XPKBJhlePTyo/0X0SnbwNo/gpA8lm7Z006xaqi517BNKZc9dijNK6UxiE/ppDgQvWUW
         GuI+YExM9Fsg0fEaFBmPmF7EKXaO20L9dF9ie1ygCgJHuNaXn1YhQODnN01XJg+0e3BY
         5U3rZkx/+rJm0d/gxhGqsmSqoHgSZ2PEyoPRt6pxbvtsbT1A8G2WpTB1wiWUaAf+HYMl
         K/AhQAnEJKJUJoh/GM3bA3uhp/KgjRADJZkJN+0gFLraSplLVQyc/eBJKJ8utLw/M99l
         eung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579281; x=1705184081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS4qazorYduSB7jUXsLe+JhpKXe1zULh9HpZv8m/hkA=;
        b=q5zNw4+pzt5MwoTbPhMObRCzfnzJQdTADdCZhz31b1iyVSFpM3rgIGsdYXNf0XImrA
         9oW0eZlDbU+7UzTtuMO8dFlE3b5NTw/UeBxCuG54JAFHrkEhHqkifMYDxjtqRCHup681
         2z9EA2JHHPzBOBPj+LNMbKygYK5MzR2iiKI8ZNdtf3C4bbaKcQIIcntnkx4clKZhaelT
         JARqZOdkJtdNOm2w1Rp2gbAYljh5C5LRkMdo+rCM7gsr0UH34USWN3XzX1T3DMYu5qiB
         8h1qekLFRmBPMuStrpozH1Bfx1w9usXM1QiQGWReoPDE6w7KEWJq6fV9Ctog8m4ZzQkV
         V4xw==
X-Gm-Message-State: AOJu0YxXV1pRV9YfxtT/lR4+yHyayudJs8VL0tVuAELbdnaHqYOeVlyE
	A67LOfn8sD4X6XI6fZrXelHP7CT6Qrg9Fw==
X-Google-Smtp-Source: AGHT+IFCTiWLmFJPe4vHJBPFs5jyOLtx3JlKVkFyMudOkXZ1IZ+0IR5IYGhT3WePROuvyC7s3TC4rQ==
X-Received: by 2002:a05:6808:318e:b0:3bc:271b:cfe with SMTP id cd14-20020a056808318e00b003bc271b0cfemr2463396oib.103.1704579281609;
        Sat, 06 Jan 2024 14:14:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id gx25-20020a056a001e1900b006d9be753ac7sm3519201pfb.108.2024.01.06.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:14:41 -0800 (PST)
Date: Sat, 6 Jan 2024 14:14:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ifstat: Add NULL pointer check for result of
 ll_index_to_name()
Message-ID: <20240106141439.5bc4895a@hermes.local>
In-Reply-To: <20240106201010.29461-1-maks.mishinFZ@gmail.com>
References: <20240106201010.29461-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jan 2024 23:10:10 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Result of ll_index_to_name() function do not being checked for NULL
> pointer before using in strdup() function.
> Add intermediate variable `name` for result of ll_index_to_name()
> function. Function result -1 when `name` is NULL.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  misc/ifstat.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index f6f9ba50..e6c38812 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -129,7 +129,12 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>  		abort();
>  
>  	n->ifindex = ifsm->ifindex;
> -	n->name = strdup(ll_index_to_name(ifsm->ifindex));
> +	
> +	const char* name = ll_index_to_name(ifsm->ifindex);
> +	if (name == NULL) {
> +		return -1;
> +	}
> +	n->name = strdup(name);
>  
>  	if (sub_type == NO_SUB_TYPE) {
>  		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));

iproute follows kernel coding style.
checkpatch complains about this patch.

Also, there are several more strdup() calls in ifstat.

### [PATCH] ifstat: Add NULL pointer check for result of ll_index_to_name()

ERROR:TRAILING_WHITESPACE: trailing whitespace
#105: FILE: misc/ifstat.c:132:
+^I$

ERROR:POINTER_LOCATION: "foo* bar" should be "foo *bar"
#106: FILE: misc/ifstat.c:133:
+	const char* name = ll_index_to_name(ifsm->ifindex);

WARNING:BRACES: braces {} are not necessary for single statement blocks
#107: FILE: misc/ifstat.c:134:
+	if (name == NULL) {
+		return -1;
+	}

total: 2 errors, 1 warnings, 13 lines checked



