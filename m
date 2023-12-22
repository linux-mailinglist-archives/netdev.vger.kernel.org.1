Return-Path: <netdev+bounces-59832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C681C2A8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 02:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1701F25226
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77A65C;
	Fri, 22 Dec 2023 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="r3FR2Ils"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F875A41
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso14599a91.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703207970; x=1703812770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6EeMDzilZ/pUpH5h1rkc4Fh1Cz8xn5Zj8+wsdoEnpg=;
        b=r3FR2IlsF/z9SMtjFda2TQMOAV3ngRwTYKOfXHFOWgyVazM8rHIGD1kFSJEDLUIDvD
         u6g0Ob8jhOvmEo8M6wrrj+JeVqqY+cvdTv1zYdB0okJ6LG9xa/gke0p5zy9D2xWjUjpr
         PtBOEuE67YZf6k1Nhcldk8BMaDEPUlrJW4ofS8RF8ll10n3fxoU64DviDergKUueaIo0
         MHz9X0Y1ZcLzr6GLtIiGdnXUOFKmAOgndKP4yVDVIrES+8PVthkNKlz30UXnhXQSg4Ra
         zy48F6nuGMx1LHk5G5NNpLjjdXXfapGlQKvEePYrAauTHBxzg2ULhu0RfHEZpEt6ZvZH
         HYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207970; x=1703812770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6EeMDzilZ/pUpH5h1rkc4Fh1Cz8xn5Zj8+wsdoEnpg=;
        b=TA5Taq/t8vurHPTnx/+ofiabktMbo5UuqiyX2wBM8sDdZTV9gPEve+YEkfjCOOuqxP
         zl/bI5N01GTlZS49LxeT8a5TOjtaqwjLmulpPAcki0bpkU7IZ1xXXHTMsbmeztLRmCN7
         Ugo2VvPfoK2v50pn8HJxghBwXrEbmNaQbxxMDBSCLg2f8z8ANE7Hzy4G3OqsLSgJ88QX
         jVrm36IVjhqzzxxDITtHOnOj9EyNclsItOWjir7VGSn6jXByhGcD3MEmwhzfsdiLCxxu
         f4cAn0coJBMY7oOCOGd9v8UJ7sz3fSuqlx4TZIU6QRy4yBVzQ04+NFkwdBn1zfjM6nq4
         pm0g==
X-Gm-Message-State: AOJu0Yz9wOJoK3LGolER3oRLrwg35edgaovyaHiGTRpDON1r2402Wht5
	wbc5Nl0OTn2jRGMKCwVJVCuqkO1bM6zfew==
X-Google-Smtp-Source: AGHT+IEAgdeCYX9DNslzUtHX4OfVtJfXqbUwBExnZ+MOwXcJzxt1qqFpQ6yaM/9KXVl6e303tVEs+Q==
X-Received: by 2002:a17:90a:dc03:b0:28b:f32c:7996 with SMTP id i3-20020a17090adc0300b0028bf32c7996mr694945pjv.38.1703207970151;
        Thu, 21 Dec 2023 17:19:30 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001cfb4d36eb1sm2248689pls.215.2023.12.21.17.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:19:29 -0800 (PST)
Date: Thu, 21 Dec 2023 17:19:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 dsahern@gmail.com, fw@strlen.de, victor@mojatatu.com
Subject: Re: [PATCH net-next 1/2] net/sched: Retire ipt action
Message-ID: <20231221171926.31a88e27@hermes.local>
In-Reply-To: <6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com>
References: <20231221213105.476630-1-jhs@mojatatu.com>
	<20231221213105.476630-2-jhs@mojatatu.com>
	<6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 18:38:59 -0300
Pedro Tammela <pctammela@mojatatu.com> wrote:

> On 21/12/2023 18:31, Jamal Hadi Salim wrote:
> > The tc ipt action was intended to run all netfilter/iptables target.
> > Unfortunately it has not benefitted over the years from proper updates when
> > netfilter changes, and for that reason it has remained rudimentary.
> > Pinging a bunch of people that i was aware were using this indicates that
> > removing it wont affect them.
> > Retire it to reduce maintenance efforts. Buh-bye.
> > 
> > Reviewed-by: Victor Noguiera <victor@mojatatu.com>
> > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---

...

> > diff --git a/include/uapi/linux/tc_act/tc_ipt.h b/include/uapi/linux/tc_act/tc_ipt.h
> > deleted file mode 100644
> > index c48d7da6750d..000000000000
> > --- a/include/uapi/linux/tc_act/tc_ipt.h
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#ifndef __LINUX_TC_IPT_H
> > -#define __LINUX_TC_IPT_H
> > -
> > -#include <linux/pkt_cls.h>
> > -
> > -enum {
> > -	TCA_IPT_UNSPEC,
> > -	TCA_IPT_TABLE,
> > -	TCA_IPT_HOOK,
> > -	TCA_IPT_INDEX,
> > -	TCA_IPT_CNT,
> > -	TCA_IPT_TM,
> > -	TCA_IPT_TARG,
> > -	TCA_IPT_PAD,
> > -	__TCA_IPT_MAX
> > -};
> > -#define TCA_IPT_MAX (__TCA_IPT_MAX - 1)
> > -
> > -#endif  
> 
> Sorry I missed this, wouldn't this break compilation in userspace?

Yes, it breaks iproute2 build if tc_ipt.h is removed.

