Return-Path: <netdev+bounces-13839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9173D31C
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 21:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55184280EEC
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4C79DD;
	Sun, 25 Jun 2023 19:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D847464
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 19:03:45 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156931B3
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 12:03:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b7e1875cc1so2656855ad.1
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687719823; x=1690311823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrm+sL/vmovf1S8qK7FEwepjJ6TXVSWNhnCVMcCBtB8=;
        b=KY72FEf317jM3ub38/uJkb5dqvEr/njRlqs1SDfY5wBfN9IVbiE00sGCGZROhmfnPD
         ow+CTwBPo8hY5K22+HBN4HVR6H8i8qygld5reWytxoJoZ6uRWQV+344DnorPVHwHHDOJ
         qD2zfPVjZ0KkNO8/2NPlWAPbgBiqzgCGpZzTEtypwFtHSw2yk18t0S5/F+HXjrjoQ3FX
         ckJXL0s3sawiAIOf5f9cXKjj/jEHw2Nzl3Px0gSga4FOWH9PPn57tRKq3Vr442wwUh7B
         NOGujVVIxg4zDCSBCgoIdrHqqrJdE47voIblJW508hurVmvK7TDvLK1pPAPJzVcZXXL+
         NMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687719823; x=1690311823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nrm+sL/vmovf1S8qK7FEwepjJ6TXVSWNhnCVMcCBtB8=;
        b=D5Bga8NZZach2LQtcZXs8Q5l7ZaBBaWCZ8ld+7O2KVolxacWwnmQCNxXutGEfRGg8z
         tbb/e4ut/qsnrNuYzZm2qm8PZ4pAHzuHNPcBtiOVfW/3vaq3E2MkbTnIamG//xQt692g
         yZpZke5L3dMh9qoDJe8YaDvV5RzXlemxfMXSJTH60JAX50unNLkE+/Ba9AttwMCgKRWW
         MAeDNicAbD3SgsHIDSOiikLSSpM8KwgxIM3a+kYPBBRmcBS9+3wlybfMXRBZFRelSTDg
         gruT+sK0ee9MxOI1zYqmX/SY+njXFACPsNsekuJeBBIgN3rglIQT5LNpGIR91VCWu3kI
         fGNw==
X-Gm-Message-State: AC+VfDzgfXYmkecVQUK8+DKthS4LBZI9kz6dQ9gNcDTRAWk5iAHCudF3
	l/cCNha6zAdfrBzlh6YuiHAFbA==
X-Google-Smtp-Source: ACHHUZ7iqKG9j1UtgQKRLrkCJTl/uB0y3kH084FHO85jOBPjWcAVfXqPBoZ5Xp3qiIzRI5SmoSaN9Q==
X-Received: by 2002:a17:902:ef8f:b0:1b7:db37:fada with SMTP id iz15-20020a170902ef8f00b001b7db37fadamr1944061plb.58.1687719823492;
        Sun, 25 Jun 2023 12:03:43 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902aa9500b001a4fe00a8d4sm2742149plr.90.2023.06.25.12.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 12:03:43 -0700 (PDT)
Date: Sun, 25 Jun 2023 12:03:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, hmehrtens@maxlinear.com,
 aleksander.lobakin@intel.com, simon.horman@corigine.com, idosch@idosch.org,
 Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next v2] f_flower: add cfm support
Message-ID: <20230625120341.5e738745@hermes.local>
In-Reply-To: <20230620201036.539994-1-zahari.doychev@linux.com>
References: <20230620201036.539994-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 20 Jun 2023 22:10:36 +0200
Zahari Doychev <zahari.doychev@linux.com> wrote:

> +	print_nl();
> +	print_string(PRINT_FP, NULL, "  cfm", NULL);
> +	open_json_object("cfm");
> +
> +	v = tb[TCA_FLOWER_KEY_CFM_MD_LEVEL];
> +	if (v) {
> +		sz += sprintf(out, " mdl %u", rta_getattr_u8(v));
> +		print_hhu(PRINT_JSON, "mdl", NULL, rta_getattr_u8(v));
> +
> +	}
> +
> +	v = tb[TCA_FLOWER_KEY_CFM_OPCODE];
> +	if (v) {
> +		sprintf(out + sz, " op %u", rta_getattr_u8(v));
> +		print_hhu(PRINT_JSON, "op", NULL, rta_getattr_u8(v));
> +
> +	}
> +
> +	close_json_object();
> +	print_string(PRINT_FP, "cfm", "%s", out);

Don't think you need to format the temporary string if you do this the easy way.
Just use print_uint?
	if (tb[TCA_FLOWER_KEY_CFM_MD_LEVEL])
		print_uint(PRINT_ANY, "mdl", " mdl %u",
			rta_getattr_u8(tb[TCA_FLOWER_KEY_CFM_MD_LEVEL]);

Since argument to print_uint is unsigned, the u8 will naturally get expanded.

