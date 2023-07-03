Return-Path: <netdev+bounces-15225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A5746286
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52432280ED3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC288100A8;
	Mon,  3 Jul 2023 18:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C6259D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 18:34:44 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56310D8
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 11:34:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so1588319a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688409253; x=1691001253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk9SnCweir07n6iSnq2VMPuIcHh/ITn83xE6dP7Oq5k=;
        b=Lv9po05CtHjjWxQ1UXKHnlsyr2h/qvz0yTinJsNajxDn3co0f+jG1yDu2VdJnXoX5A
         3FKDApEDiqZk7TCo0Dz5RLGW47SIEHqD06qUIz5X63sQO9chtVLYl7N8RTaueXBsg0oo
         gUbgQOkxsRdlsoxTOqnDh25fHnWvluoboT3kDOJFBjnyvLZTwPELWvRkUb1W1pW1ZXyO
         dl7lDBgx9iNNZ1lUk8N3argudh8uaiIqu9qF1GpHe0cjmrc2x4Ff5VVQiOCks2O8AkMw
         rMCyLQ6TDdAG5a0rwWyCluGg/2DluNNIexqZJMKiqTIo1dYRceGIUAeVd0VPnK3wYfPq
         /O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409253; x=1691001253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk9SnCweir07n6iSnq2VMPuIcHh/ITn83xE6dP7Oq5k=;
        b=ZdCEBQeLrfzfQYmtCqgoc6pe96gGKSpHiYFJJFIQw4s3ycIeCCpzdqAxbSBlUTMv+b
         UoVb2yCwdDAFDvStjqQ0DpQVaHTaHWtjflqExvSIZ3yl+Sr8fixh2dYdmudxxcvQY8C4
         6EPM7FxHlmBCRH2kjLgEiRKCiXV8iVEd5b4yZF5NsS15OLXG8mvKgcuWzQC5ErZPFnHx
         I+Ws4/V5FJA4ggMa6MUSE+OUSLgK3TSHjCMjd8bvAvcm0zKAJXGtmttur2g52xQbAI4h
         hy7lKmkMwqzOwokVsCxwiVdzySWRzNcu/AH07/faSld7y0tycdIXDgDSj2zVWweqvAHu
         WxEA==
X-Gm-Message-State: AC+VfDyknE01G0SZ3rFgzj9mu69g76vdCR7JpySadncBgdmsYXCCPqFB
	7NEArh+DvwleXKU1chHtdAHRiw==
X-Google-Smtp-Source: ACHHUZ4vAkhoUesbgq8fhxwbf65kA+IsJDKYCvhlHsOsvrs7kocp/SfweP5O4gzmxJyR4PQnUjGqAA==
X-Received: by 2002:a05:6a20:5499:b0:12d:346f:d8ac with SMTP id i25-20020a056a20549900b0012d346fd8acmr15093841pzk.44.1688409252714;
        Mon, 03 Jul 2023 11:34:12 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id q28-20020a635c1c000000b00548d361c137sm14872353pgb.61.2023.07.03.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:34:12 -0700 (PDT)
Date: Mon, 3 Jul 2023 11:34:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: leitao@debian.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, sergey.senozhatsky@gmail.com, pmladek@suse.com,
 tj@kernel.or, Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org
 (open list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230703113410.6352411d@hermes.local>
In-Reply-To: <20230703154155.3460313-1-leitao@debian.org>
References: <20230703154155.3460313-1-leitao@debian.org>
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

On Mon,  3 Jul 2023 08:41:54 -0700
leitao@debian.org wrote:

> +config NETCONSOLE_UNAME
> +	bool "Add the kernel version to netconsole lines"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  This option causes extended netcons messages to be prepended with
> +	  kernel uname version. This can be useful for monitoring a large
> +	  deployment of servers, so, you can easily map outputs to kernel
> +	  versions.

This should be runtime configured like other netconsole options.
Not enabled at compile time.

