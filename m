Return-Path: <netdev+bounces-31893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3F7913AD
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90095280E71
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F3818;
	Mon,  4 Sep 2023 08:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DF7E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:41:42 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5869A126
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 01:41:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401b5516104so11514675e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693816900; x=1694421700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE7BHnZloW37jfpvuGNZSni6U8BesQvPfCymv0eqooQ=;
        b=myyig6pO2NZGB0kPSvtqytbAFnCWVhPIBb2ylrlE7OaXS2kuMJzr8HENyCTReg2CQ5
         Ac7ypQqPCas3pNOmVorxgbJDTRmxniH5nlCRZoMiC/9jp6DcaSdRxmWfTFon0QHAqbcG
         AwoV1h/S9DXXYaBdswp9b8ZF/R18z6nwLQx+dUfOpWflOKB3+OKBqJ+DMR1joHIth/Vo
         oLzW4ZrMKIOFdfpZ9TvQSNk/ow3n6r7wJLBpJZLzvQlWWVS9Y9PSClFMw8ktuyW88FR1
         nD8sfm65blCYawzUO1JPUPFih8+0DYemzYT0zjFYDpVxzX98EvsnHm8XrFP685OpdH2W
         BJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816900; x=1694421700;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7BHnZloW37jfpvuGNZSni6U8BesQvPfCymv0eqooQ=;
        b=WtyHGfNV0uP2NkiW6trfhXdfdj5AaObNT6ZypjF/he18+XQcOoXGN6Ap0BdudheuFa
         424+SqV/pheua8zuV8nMT+FGL0TH1ZdAEuKf6oHdVCjCwdcRtekcBgJyNoeLFfgtCr7Q
         K+r0b2YOvdFqkGUBukvwpBXwQz55coaFZAoWzgZ0WfNXIjGwrp4C/XBoRYQdRonsbbp+
         GWw5rk/8DhEzHI/184HqWszrbsQ4F2bDHo1U799X9bX0+0xqRtbkQ+bKoI1PITiSWLue
         dtpOqPbN1fx/OqrrMNdgk40c2LiTwqQVv7p2VEG4MCm2U3dSKqC84s7e0HSpawg3XLZ4
         Jp0g==
X-Gm-Message-State: AOJu0YyVzzDHRZ75sUGrlVWToTnZRFh86k8DGOWsAuWPcpaE+n4w9Q4O
	ctqMmFWxd31rXPYyP5rRb+E=
X-Google-Smtp-Source: AGHT+IHq02uI5fF14YQN4QPBB4bANduSM03H5PtjZ+3RG3nzPlSa1QMEpTw6q5DBHpZJxw3pUyymAg==
X-Received: by 2002:adf:e8d0:0:b0:311:3fdc:109d with SMTP id k16-20020adfe8d0000000b003113fdc109dmr6762978wrn.1.1693816899597;
        Mon, 04 Sep 2023 01:41:39 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b003176aa612b1sm13816735wrq.38.2023.09.04.01.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:41:39 -0700 (PDT)
Subject: Re: [PATCH net] sfc: check for zero length in EF10 RX prefix
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com
References: <20230831165811.18061-1-edward.cree@amd.com>
 <169355282650.26042.12939448647833622026.git-patchwork-notify@kernel.org>
 <11386.1693600107@famine>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <29b21a45-a391-9e33-5c6a-78cba2231512@gmail.com>
Date: Mon, 4 Sep 2023 09:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <11386.1693600107@famine>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/09/2023 21:28, Jay Vosburgh wrote:
>>> The resulting zero-length SKBs cause crashes in GRO since commit
>>>  1d11fa696733 ("net-gro: remove GRO_DROP"), so add a check to the driver
>>>  to detect these zero-length RX events and discard the packet.
>>>
>>> [...]
> 
> 	Should this have included
> 
> Fixes: 1d11fa696733 ("net-gro: remove GRO_DROP")
> 
> 	to queue the patch for -stable?  We have users running into this
> issue on 5.15 series kernels.

I didn't think Fixes: was appropriate (for various abstruse reasons I
 won't go into), but this does want to go to -stable.  I expect Sasha's
 robot will select it, but feel free to submit it explicitly.

-ed

