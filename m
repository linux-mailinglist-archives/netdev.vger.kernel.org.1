Return-Path: <netdev+bounces-24061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2676EA32
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5496D281CAF
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCEB1F179;
	Thu,  3 Aug 2023 13:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5917FF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:26:01 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291F2D73
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:25:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1710457e87.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691069133; x=1691673933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX1yN9Ixci8IcrltYrGugFYIQgxWeNIjdcjZ6DOu8VQ=;
        b=h/MIjuBQXoq05U76MfpTugGQ2wCdqSY2kmw1KLU/UJEdzS10EiaxXnFcx2Pa7UrOSD
         AIdCBmmrf7qeZ6zxosxhoZDak+n9PRiRcPhbj3ppia9szhEYOj+bPU8Q3ynsT9auiKVK
         bilo4hSsuRixPhCcUfMKS7ScmLB2xhU0OewQ7YaFDgOGscEG9PF6S02hIUyj0YCl4d/0
         8E50basgRjz16AUTCMOcy0un1MvywpRWGbmieM4MoOdbzczAP7HttoF1rcd5SJFlwayl
         QKz9PBAvpCCXGNNFCwO7My9CTJWBD4sXyC/1hqzH0Zr7jUfd8CTxYNMMFoKSDakuW0Pv
         sC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069133; x=1691673933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX1yN9Ixci8IcrltYrGugFYIQgxWeNIjdcjZ6DOu8VQ=;
        b=Qwv/lQMWtJ0S0siR7+CBK14lFmgc8tuZr01bWQGuqLznzhTtCmcAIF9T8DsLg1w2jh
         dU1AVHdAtWsqW1wxoArS2w8aaH/ylwBsnjtSdpPz0DKeUVO+J3i1YWGUPYxLOlUEqiYD
         9jCE8F13BxqMXY+p2yYj0THJDsqPP07wF/0TCJ0gkn4g/iNhv/z/JztHh8hksoaVenR9
         cWlQu9ohNIz9RXSSDZNsuI/TMGFsj+skRoJl+qJZDmjZDS9Qd9vslAqBwpRYbHZ4wa6b
         HyeWjBCErsQaLM31Tt8sICZSlpgEl/ygsRnFHNZXLlaypwJizHNW0l3W8W3Lk1tTDOoi
         uuRQ==
X-Gm-Message-State: ABy/qLZaYxCf7VZeiUa8E2PSniWF6S8o4BpSlLWk0ChJ4rjYjvIHlMXo
	YXvbUIc8nrUUnqidAn5ieG3gfA==
X-Google-Smtp-Source: APBJJlHYeqEwy6KD1OxnrtjOYODMuMnIXYbY4rZvxsbyH+nY0Epj5By3KPyjIh40xnsMlFIvZF5QuA==
X-Received: by 2002:a19:4f1a:0:b0:4fd:c0dd:d54b with SMTP id d26-20020a194f1a000000b004fdc0ddd54bmr7273358lfb.65.1691069132854;
        Thu, 03 Aug 2023 06:25:32 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090616ca00b0098d486d2bdfsm10574938ejd.177.2023.08.03.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:25:32 -0700 (PDT)
Date: Thu, 3 Aug 2023 16:25:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH v1 net-next 2/4] tc: flower: support for SPI
Message-ID: <15ea5ace-db96-4839-8376-b885cf32c6d5@kadam.mountain>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
 <20230801014101.2955887-3-rkannoth@marvell.com>
 <ZMqpd2DyHz4O/v17@kernel.org>
 <664b202a-d126-4708-a2af-94f768fe3abd@kadam.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664b202a-d126-4708-a2af-94f768fe3abd@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Done.  :)  That false positive has been bothering me for a while so it's
nice to have it fixed.  I'll test this out for a bit before pushing.

regards,
dan carpenter

diff --git a/check_index_overflow.c b/check_index_overflow.c
index 19ea4354029b..644310ae837c 100644
--- a/check_index_overflow.c
+++ b/check_index_overflow.c
@@ -160,6 +160,43 @@ free:
 	return ret;
 }
 
+static unsigned long __TCA_FLOWER_MAX(void)
+{
+	struct symbol *sym;
+	struct ident *id;
+	sval_t sval;
+
+	id = built_in_ident("__TCA_FLOWER_MAX");
+	sym = lookup_symbol(id, NS_SYMBOL);
+	if (!sym)
+		return 0;
+	if (!get_value(sym->initializer, &sval))
+		return 0;
+	return sval.value;
+}
+
+static bool is_out_of_sync_nla_tb(struct expression *array_expr, struct expression *offset)
+{
+	sval_t sval;
+	char *type;
+
+	if (option_project != PROJ_KERNEL)
+		return false;
+
+	if (!get_value(offset, &sval))
+		return false;
+	type = type_to_str(get_type(array_expr));
+	if (!type)
+		return false;
+	if (strcmp(type, "struct nlattr**") != 0)
+		return false;
+
+	if (sval.uvalue >= __TCA_FLOWER_MAX())
+		return false;
+
+	return true;
+}
+
 static int is_subtract(struct expression *expr)
 {
 	struct expression *tmp;
@@ -286,6 +323,9 @@ static int should_warn(struct expression *expr)
 	if (common_false_positives(array_expr, max))
 		return 0;
 
+	if (is_out_of_sync_nla_tb(array_expr, offset))
+		return 0;
+
 	if (impossibly_high_comparison(offset))
 		return 0;
 

