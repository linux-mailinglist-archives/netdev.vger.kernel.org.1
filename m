Return-Path: <netdev+bounces-35001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E447A66D5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE241C20ED9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482A18621;
	Tue, 19 Sep 2023 14:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019F3715D
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:36:35 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80846BE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:36:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404732a0700so58649115e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695134193; x=1695738993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqWfPazUioSHKQCq40SJfNRl+iwKgwPn3TlvV+AW248=;
        b=gQUsjG13tqJLje5ZDA7gBc6obKnUnXL8NL85mSNvjk9GI31VcRUO7uwkgqu6XrC0ci
         N/08jlNc5K+JKY6c5Wuwv2+4Ios/1gT4Q9MBs9vYjdyKQbMNl0ecSVVa1/Fm8ia/T6Cb
         LXflMnq5fMZjBDwy4QAqWfY616RCpxUpqt99VI2SVTKqMAHx1sihl5mavxXnFe2GPAAW
         XyW3bXpTk1aXvpxPj7uyp1k8NK892aJ8J9fkTLUoDdq02VNAyoUUB5E9gylw0kiJyAjK
         x9UfDIDNAwn26yUvT8I+a3VLF7KFsYhH2YCEZhiwK40eNSeawZDRIAmWAEwpIpKOHNhY
         xbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134193; x=1695738993;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqWfPazUioSHKQCq40SJfNRl+iwKgwPn3TlvV+AW248=;
        b=AjQFN6zP3qf/9vlYbCyk+FsNrGFJ2rhwcm7grdXPaTKIQ0dw8BaPSUXuJQKGzTXIHa
         XyDZejkxH5ujWp7v6JCOE5cUQA0fStfPcvP61NrX6VhCThd+qxsS7eJ1qj4i2wZgZwoC
         SPlMJeazyFPXurr5+FkA32sJZxG7H7qHyle+DqYApW2cNQfMJ4OchQBFjFMAqHreccYR
         i8sj8dNWH1Fw7WGAAi1TdIQNJeOnfh8t5oOBPzPgP7hMq5Gr0KbedgDngHpDEzsD0Bnq
         wPhj5i6OIrVdqumuRji60rOoJ9hfSUnTzpNfvFkqzAoGvhoJkwFDNE7C5UnlIGlZ3zHO
         cJNw==
X-Gm-Message-State: AOJu0YzlfubhlLaGV46tXFMC3HW2lxHFLXmNC6Dr+ZPYQiyi/Jhpj0Qc
	/ctRYKbyZGVuLxEKEJ90FgE=
X-Google-Smtp-Source: AGHT+IFHgrkBeSGmdFzxAUnwEi1p8GMg1I9dVnrrpicI0bqO3TTSFKYuA6BpebYruFevBmxWwg0vjw==
X-Received: by 2002:a7b:cd8c:0:b0:401:d2cb:e6f3 with SMTP id y12-20020a7bcd8c000000b00401d2cbe6f3mr6020wmj.1.1695134192730;
        Tue, 19 Sep 2023 07:36:32 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b003177074f830sm14284467wrc.59.2023.09.19.07.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:36:32 -0700 (PDT)
Subject: Re: [RFC PATCH v3 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
 mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <b0de802241f4484d44379f9a990e69d67782948e.1694443665.git.ecree.xilinx@gmail.com>
 <20230919111038.GA25721@xcbmartinh41x.xilinx.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f0ecc83c-13c7-9cb8-ee2c-8b8e1cba7db1@gmail.com>
Date: Tue, 19 Sep 2023 15:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230919111038.GA25721@xcbmartinh41x.xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/09/2023 12:10, Martin Habets wrote:
> On Tue, Sep 12, 2023 at 03:21:39PM +0100, edward.cree@amd.com wrote:
>> +	int	(*create_rxfh_context)(struct net_device *,
>> +				       struct ethtool_rxfh_context *ctx,
>> +				       const u32 *indir, const u8 *key,
>> +				       const u8 hfunc, u32 rss_context);
> 
> To return the rss_context this creates shouldn't it use a pointer to
> rss_context here?

No, the whole point of this new API is that the core, not the
 driver, chooses the value of rss_context.  Does the commit
 message not explain that sufficiently?
(If you look at Patch #7 you'll see that sfc doesn't even use the
 value, though other drivers might if their HW has a fixed set of
 slots for RSS configs.)

-ed

