Return-Path: <netdev+bounces-60732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2473821517
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8521F21280
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E3D51C;
	Mon,  1 Jan 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNe9Nihc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB705DDA2
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28ca8a37adeso2449280a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704135519; x=1704740319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZArNRS5eHJ/5gCpze36JCzg98WRx0PWDpZHPAhdWCE=;
        b=DNe9Nihczz4l8pCCoeQ8XZltNVDguj24XmqvyFQ+JPdmUtmCluX5q0R8Dpb4+9URcB
         SqCu9MzlUZ24FsBIxRP5r54NFgoG4zVNir37/adcr2Gj3PW15RoMWaIs58MRzLamVXFC
         vVZpBkm3IGz9rtyoDomg5V5CYdSFw9uYelLOesjBQrg9YwwwS93ny+3nhsAw1rMYttRp
         BYkrwpPScR6Ux4kvTnw4Ku/ujxSyAxpEgqPg7nQZhCmjOdGeEEmrZtZBOcIfljLAAXgU
         J2jMDRY78qR/nNwm49V+MSr5XxnAKeqwTtVuBdDgFfkzDQ8awLzp9/msQgS2HYmFD4GR
         4/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704135519; x=1704740319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZArNRS5eHJ/5gCpze36JCzg98WRx0PWDpZHPAhdWCE=;
        b=XOpzl8enNqFXE3349jKoo/G2qZYDyjLxfbRXzAPICENtjvaX2V1QhV+DUBvvWXKKRe
         DZOi+ks3FoaNNyerI/3hqX3vbhepG6r3BT4vUdL2HpfKPNzH6shJluUik39UnpdYAG/Q
         OYgGdHruVxYm8jUz5BQCcq77JkD38iXogtOCVAH9S68SqKXJsuh6DL71GXq+sdLpW6FG
         eo7ZvCEDNHEr/QQdwXcWKuWyFy6dOCUPnVykflOz7QQY6Rr4hijFZYsmZdzegPwi9mxQ
         vRsk2CBxJcMj0tgteSdCgZeNhD0rtmegwFwJT8OWb0/e26eIMhHNrTM3k2cyLlW9Abi6
         5UiA==
X-Gm-Message-State: AOJu0Yx3CSnT649kwhveM+Dvt5WoaOML3ArVm+SVQClB4EqF1AFX8PL+
	oy4Ho6Qu6WpDiVigc1j73uc=
X-Google-Smtp-Source: AGHT+IH+Bqzz48kxk6rkwgkWrnJJba5rP3CduQ8kF5VTi1r24ArYaQHdo7F39KIWzzkXfZ5vSGsRBQ==
X-Received: by 2002:a17:90a:d58f:b0:28c:17de:c8ce with SMTP id v15-20020a17090ad58f00b0028c17dec8cemr7174679pju.2.1704135519119;
        Mon, 01 Jan 2024 10:58:39 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:8134:8b90:8d31:15e7])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001d3ffb7c4c7sm20562013plf.40.2024.01.01.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:58:38 -0800 (PST)
Date: Mon, 1 Jan 2024 10:58:37 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
	stephen@networkplumber.org, dsahern@gmail.com,
	pctammela@mojatatu.com, victor@mojatatu.com
Subject: Re: [PATCH net-next 0/5] net/sched: Remove UAPI support for retired
 TC qdiscs and classifiers
Message-ID: <ZZMLXb6saOOf4xcM@pop-os.localdomain>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223140154.1319084-1-jhs@mojatatu.com>

On Sat, Dec 23, 2023 at 09:01:49AM -0500, Jamal Hadi Salim wrote:
> Classifiers RSVP and tcindex as well as qdiscs dsmark, CBQ and ATM have already
> been deleted. This patchset removes their UAPI support.
> 
> User space - with a focus on iproute2 - typically copies these UAPI headers for
> different kernels.
> These deletion patches are coordinated with the iproute2 maintainers to make
> sure that they delete any user space code referencing removed objects at their
> leisure.
> 
> Jamal Hadi Salim (5):
>   net/sched: Remove uapi support for rsvp classifier
>   net/sched: Remove uapi support for tcindex classifier
>   net/sched: Remove uapi support for dsmark qdisc
>   net/sched: Remove uapi support for ATM qdisc
>   net/sched: Remove uapi support for CBQ qdisc
> 

All look good to me.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.

