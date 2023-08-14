Return-Path: <netdev+bounces-27290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D434877B5F5
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1253F1C20934
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA2AD43;
	Mon, 14 Aug 2023 10:07:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D3AD26
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:07:01 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA29FD8
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 03:06:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so37391915e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692007618; x=1692612418;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN8g4lwFIyJXb7Ox+6A1U6+7e/RjfOAucao0Qh5pRHI=;
        b=O2EOMhan9fWkaYPrcpYeFPDFzrR/7KcHvTWPLstWjaz1tgPItAoOJdHFu8yB/eI61L
         IG6lQqbwLU4U50ToYGB6jBp6cqi0whLG7dRMeyv/aEZBRFHtCmTnSDM3LzIRTBIKazS1
         wmpMg0YvWi+5IkCuLO/xQWHhsPguThJrFp0kQfCuc049RPBanxDtCA+Uem//sMwpP1Bt
         vw4xQHUBKZ3O3S8l9srtPDBhb961R82yBtmoQyRd0FLdGSLoZj9ROqcFX+MQCjs6g6o9
         JgOutK8kt29amC6OVMo6/9D3nW9l3rP/uciIvliSAdpUUORV2LuBuJkurgSrz0H5ZFUC
         vy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007618; x=1692612418;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LN8g4lwFIyJXb7Ox+6A1U6+7e/RjfOAucao0Qh5pRHI=;
        b=g/26+ox+xnNO8hkI3x71eIArF2+4kMk4HYyi3ig5xXUgDEIx62DvZcLEU4mrYeu7Xh
         ChFDGAjaV964xMR5YPRvZbQUdFym33YyvCt7JxOFGL0foZTMVr2l9BVbz30+sO3OnZUh
         Y3BsRW1ei5WJ+WCWZl8sZlaej25f716TnDN9sdkGJQjOWiptMVmClVdoDpYb2QRJMt0B
         fJIywbRpboE291KjVQsErxdc/JTNG4E5udHosn29izBNFjYvavUEDISfwrVFuENQ0FUs
         J0xrghD+vn/JyDkHE8A4hQhtamfvlbnED8IaF3mSdySjGTvq5NZxhMEU/jta8BTdnnrN
         9oJw==
X-Gm-Message-State: AOJu0YzLemF0ByKStPGtpP9yEQJt19+8tcE6C0xhVI+gNmXKXhlSklIS
	4vCKhv+W1/LphE9T5Ae0SKo=
X-Google-Smtp-Source: AGHT+IGdiIGDdOHdtgm+i5oKnRLf2dx0mZPo0LrjiMRR0daBDDDbDKbyIc650sFeqOTf2baV+x+WJQ==
X-Received: by 2002:a05:600c:259:b0:3fe:2102:8083 with SMTP id 25-20020a05600c025900b003fe21028083mr6536251wmj.26.1692007618109;
        Mon, 14 Aug 2023 03:06:58 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm13806320wrp.93.2023.08.14.03.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 03:06:57 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 1/3] sfc: use padding to fix alignment in
 loopback test
To: Arnd Bergmann <arnd@arndb.de>, "edward.cree" <edward.cree@amd.com>,
 linux-net-drivers@amd.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Martin Habets
 <habetsm.xilinx@gmail.com>, Kees Cook <keescook@chromium.org>
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
 <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
 <ceec28d4-48e2-4de1-9f26-bfd3c61fde45@app.fastmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <90e83021-49f3-2b0e-bb9c-01539229c50b@gmail.com>
Date: Mon, 14 Aug 2023 11:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ceec28d4-48e2-4de1-9f26-bfd3c61fde45@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/08/2023 09:23, Arnd Bergmann wrote:
> On Fri, Jun 23, 2023, at 20:38, edward.cree@amd.com wrote:
> Unfortunately, the same warning now came back after commit
> 55c1528f9b97f ("sfc: fix field-spanning memcpy in selftest")
...
> I'm out of ideas for how to fix both warnings at the same time,
> with the struct group we get the iphdr at an invalid offset from
> the start of the inner structure,

But the actual address of the iphdr is properly aligned now, right?
AFAICT the concept of the offset per se being 'valid' or not is not
 even meaningful; it's the access address that must be aligned, not
 the difference from random addresses used to construct it.
In which case arguably the warning is just bogus and it's a compiler
 fix we need at this point.

-e

