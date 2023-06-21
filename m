Return-Path: <netdev+bounces-12492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B97737C76
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E80E1C20DF1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47982BE61;
	Wed, 21 Jun 2023 07:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382411C3E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:41:45 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A111A8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 00:41:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9c0abc876so1817155e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687333302; x=1689925302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNubZGxL9mnAxf2nB2QeV5y6P7eAxnFpZSDeTanD4pY=;
        b=RdvdaUn6eHY6wzTsUxt0yn3K26iQWe75KSAWwMSuJVXS3SutxpzhfRMXTp0bP9XhBE
         7C2Mxf0rEesT7qfvmv3yJnFZgq8YLsshcqhAoEKB7UjczN2UsQ1QhHgnqyu/Kxp0p3f0
         r3SRfzKMyFSLBKwMqMORg6jh9H6vC/jFh4ru2S1kHbY8jnBVUNwA1NV0bItI/TtioGJe
         DKc8PwTsEWCjxzPBgDQO9XytT51RttGfJbjRKmJwpYNN/u5NnKgqPyt8WvozZUUp0Xfh
         Ro5q6tGkaOvHA9NoWsfEmsl+5CLgZCHvIhKCCHR873tLBu8eU0Up2Pnrw6wN2o0ZlMha
         f68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333302; x=1689925302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNubZGxL9mnAxf2nB2QeV5y6P7eAxnFpZSDeTanD4pY=;
        b=PASZgbFk2EwAKOY5O138ge/VkTKA3LB5dd2T2F/2r2xyXrgWYEALkrm8R9dESYdCyK
         oaONapDbGgKohj/USfJlDEsXWoz9kD7DGQYN4D/J3cd/CDZMBlh3d/cMUIM5/i3zU5Rj
         XlRPx4gh15h6expAmrqtVF91ejPtOJ//BLmq7WrwozcgCeU1qv9MQeQ37GIFcPta/90a
         XhKyznoR1kHr6IbtP5Nf30rVlD6vN40rtoR1GzwTWT5dLBQ/6+GBm09fKFCuCaWFNAms
         DFQ6Yd9zBDTkZtXzpYoJUOzgXqggO0/9qHUturdQTL8qhv6s0Erm8BfkSX8GEdlwLE17
         +sLw==
X-Gm-Message-State: AC+VfDyazkP3LZi6z+Ey6KZZC/AijEUkCTfCl0PpZ00lAr645LFykwa3
	QxHoR8lF1rdC5uLWSaG+s5Q=
X-Google-Smtp-Source: ACHHUZ6mtgyBVi4Y/3qFv+B8wR/yIruBEJ+XACvo8zxYs+mE9hHGHV5gkdD/fE8uZr4t5pebMx7R7w==
X-Received: by 2002:a7b:c4d5:0:b0:3f9:c933:c7d3 with SMTP id g21-20020a7bc4d5000000b003f9c933c7d3mr387wmk.19.1687333302429;
        Wed, 21 Jun 2023 00:41:42 -0700 (PDT)
Received: from tycho (p200300c1c74c0400ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c74c:400:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003f93c450657sm4156668wmp.38.2023.06.21.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:41:42 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Wed, 21 Jun 2023 09:41:40 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org, 
	hmehrtens@maxlinear.com, aleksander.lobakin@intel.com, simon.horman@corigine.com, 
	Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next v2] f_flower: add cfm support
Message-ID: <7qu4upqp3nm5kmaf2tyvqui4som5sdxzl4w3v6at2ljiikvcfw@kdlyqyftvjpc>
References: <20230620201036.539994-1-zahari.doychev@linux.com>
 <ZJKSDdC+YNlvCXVv@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJKSDdC+YNlvCXVv@shredder>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 09:00:45AM +0300, Ido Schimmel wrote:
> On Tue, Jun 20, 2023 at 10:10:36PM +0200, Zahari Doychev wrote:
> > From: Zahari Doychev <zdoychev@maxlinear.com>
> > 
> > Add support for matching on CFM Maintenance Domain level and opcode.
> 
> [...]
> 
> > 
> > Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Few comments I missed earlier
> 
> > ---
> >  include/uapi/linux/pkt_cls.h |  9 ++++
> 
> iproute2 maintainers sync UAPI files using a script and I believe the
> preference is for submitters to not touch these files or update them in
> a separate patch that the maintainers can easily discard.
> 
> >  lib/ll_proto.c               |  1 +
> >  man/man8/tc-flower.8         | 29 ++++++++++-
> >  tc/f_flower.c                | 98 +++++++++++++++++++++++++++++++++++-
> >  4 files changed, 135 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > +static void flower_print_cfm(struct rtattr *attr)
> > +{
> > +	struct rtattr *tb[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
> > +	struct rtattr *v;
> > +	SPRINT_BUF(out);
> > +	size_t sz = 0;
> > +
> > +	if (!attr || !(attr->rta_type & NLA_F_NESTED))
> > +		return;
> > +
> > +	parse_rtattr(tb, TCA_FLOWER_KEY_CFM_OPT_MAX, RTA_DATA(attr),
> > +		     RTA_PAYLOAD(attr));
> > +
> > +	print_nl();
> > +	print_string(PRINT_FP, NULL, "  cfm", NULL);
> > +	open_json_object("cfm");
> > +
> > +	v = tb[TCA_FLOWER_KEY_CFM_MD_LEVEL];
> > +	if (v) {
> > +		sz += sprintf(out, " mdl %u", rta_getattr_u8(v));
> > +		print_hhu(PRINT_JSON, "mdl", NULL, rta_getattr_u8(v));
> > +
> 
> Unnecessary blank line

somehow I missed that :( I will fix it and resend.

thanks
zahari

> 
> > +	}
> > +
> > +	v = tb[TCA_FLOWER_KEY_CFM_OPCODE];
> > +	if (v) {
> > +		sprintf(out + sz, " op %u", rta_getattr_u8(v));
> > +		print_hhu(PRINT_JSON, "op", NULL, rta_getattr_u8(v));
> > +
> 
> Likewise
> 
> > +	}
> > +
> > +	close_json_object();
> > +	print_string(PRINT_FP, "cfm", "%s", out);
> > +}
> 

