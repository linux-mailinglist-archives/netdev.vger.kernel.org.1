Return-Path: <netdev+bounces-34574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63F7A4C2F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4615B28198C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41B51D698;
	Mon, 18 Sep 2023 15:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1691CAA0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:28:29 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F88E5F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:25:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fdcc37827so3969433b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695050592; x=1695655392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buRXwf6zDV0ZsfhibdGnN8mIgc+4dxqCoxX63IZqWAU=;
        b=et9SwXElzPs+797UUH20c+HPEtDjHaaWgWTaPWOhtE0UYJyLoXZSOWq0La68xUjtAV
         t4BnZKqZHDf28i01QZFss1GGaxM5WgS0U7BgI7UH9ZaLhhtme0u+qq4LkfaDUhYzJ+e5
         olCsXOC8FFe2GiAYBq18YwWqgxHIXOfl1W/X4GHfKaXveCbAirgldYz4nhrrzI+pylSk
         sUC3S5Biy2ZI4AygTLWxZsfO6AWTBXc2lWJDYOwWZOefhO9kegESiJtD7ynwsbpea49d
         gNW8kSCauXaG9qTfy4nxjYYImQD9wviNn77dcbiSjatzp9iHjNfHNIqvRFYSNjZqXdWP
         9FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050592; x=1695655392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buRXwf6zDV0ZsfhibdGnN8mIgc+4dxqCoxX63IZqWAU=;
        b=fyGdNB/+TuPSJxuG+jZBiW1OVSGQ2A57aZ0JBqwIdYLIf0CGKLLq5eLxrowu+SjJ+b
         RH213N43WACEF/K0OEUOwAUeqhARADB+319KIUsETbZ9eFmLMMI2PPf0hnI7xduN0FN5
         OMtbDucHlMlCnEF9tQ/oUX+ciYNMAEcGLmwMVphGiuxv6/qs8Ok2RN/vtiQA6swEqGRR
         ahlAaEBzFDeke1sqL4KXDrPJPE2TQU9TvVbVTYzXGLn4joJtR++YKUL0vni0PV3FAHJq
         o0hjpAPeKyPrGKaIxl//0Vjv1isnB5z6Q5UwSPqIy9g21krRjhslikjC/oo/YnAcqCSb
         Q4wQ==
X-Gm-Message-State: AOJu0YzAhXRwL9LXANeHzBYBDrqUyUocxYFEp7TZw6B32C2J8gdqJ2bd
	8kAUO1ReYuTqaV2tCqBx7xiTz67Dk/DwZ92+4K8Edg==
X-Google-Smtp-Source: AGHT+IGrpzE3+5t6NStLtkpWxKJYTxJ19eUzLmUXLWnduHIxq4c8mN3oTvLpVmIhC/xe+IB/yTnNHg==
X-Received: by 2002:a05:6a21:6d9f:b0:152:4615:cb9e with SMTP id wl31-20020a056a216d9f00b001524615cb9emr11917027pzb.13.1695050592138;
        Mon, 18 Sep 2023 08:23:12 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id k25-20020aa792d9000000b0068c0fcb40d3sm7187978pfa.211.2023.09.18.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:23:11 -0700 (PDT)
Date: Mon, 18 Sep 2023 08:23:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/3] net: libwx: support hardware statistics
Message-ID: <20230918082309.7e592c7c@hermes.local>
In-Reply-To: <20230918072108.809020-2-jiawenwu@trustnetic.com>
References: <20230918072108.809020-1-jiawenwu@trustnetic.com>
	<20230918072108.809020-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sep 2023 15:21:06 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> +
> +struct wx_stats {
> +	char stat_string[ETH_GSTRING_LEN];
> +	int type;
> +	int sizeof_stat;
> +	int stat_offset;
> +};

Type here is an enum. Therefore for type safety you should use that
enum for the type field rather than int.

Since offset and size can never be negative, why not use offset_t and size_t instead.

