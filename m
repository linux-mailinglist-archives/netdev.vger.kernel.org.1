Return-Path: <netdev+bounces-39199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8397BE4C6
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC7728186E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556673716B;
	Mon,  9 Oct 2023 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mCi+C5kF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726BD310
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:32:04 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11FDA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:32:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c871a095ceso33176125ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696865522; x=1697470322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8b93dv90D56oZ0oYIg7blNmShNpf/GwP56Ss+ZJmk=;
        b=mCi+C5kFlf+r+yX/403w9DJzNAmqkOWmRTZ16TVaq8iU7bRtHPUlRPSYPhaJz+DKHR
         ekCVVrpFP4VONMWp3y9OJC4xwpcZrdLLGbSKmUfgjiACiPwcZqE5aL7+B+pMkbvi+mVt
         SLD8qHXgB/pFzEEfA5tOVIcSFFyFmr+fK2zMClrgkCyQMOiOSFgSwNVhl6C257nk9+eH
         TWql9ukUcodK92/Ru2vhqRMLucFm8J1FuqACLrr7LNhZQG0VNWigBJpWRZnKBa7kot+J
         EqFlkGs/3WMy2jdd0PwjlAlhUYiLEO8HFdSJT+EBbl2ix4hKZe66wFPT9JB1kCjRA4n/
         FB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865522; x=1697470322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8b93dv90D56oZ0oYIg7blNmShNpf/GwP56Ss+ZJmk=;
        b=sV82RRU0vUEEvRHJuc4gIqIj+a3+uP64huEJH32d8nc9GABfBK2aKxJnKEJ9yuDAJr
         5G3SFzZip9vWEHl/l2pHu2/7af+4whkt6YnvOydSJFWvc6tsd5+bxMBzntkkY8N2JVrr
         8ABXlvubRWydfeLJKRrWfWvaE6Qv7L7ChRSN6+G125nbVBkHOsusIdr8Y4Z/sJ41oSdu
         3oDaCFYAivr/ANzX09P+L1ddk8Gj23VrOKH2ngZbh6cyY0kpPKI3rIWvbmHr8gnB+LI7
         4ee8ien7S+LkKfuyZghzkloq4Npf2BPvremo1VWwFLqaig3/Ht2WsWLkDR+w8BBDenJD
         6c+w==
X-Gm-Message-State: AOJu0YzxX921s4Zq+JHAJWtTrTjitQkh8w31dgvGQgHvUT01ZSELcD/g
	KhRfbJq+VTF6ae7yJC1Sl7RhYw==
X-Google-Smtp-Source: AGHT+IHC377mUubwTCvPh8gkyBN84l2AmdH1Zyqa4Dk1ALNvx86TDEH09ZXiPwpLRMcyroxTcA6V4A==
X-Received: by 2002:a17:902:f690:b0:1bd:f314:7896 with SMTP id l16-20020a170902f69000b001bdf3147896mr16795613plg.25.1696865521720;
        Mon, 09 Oct 2023 08:32:01 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3e90:dc7b:9e2c:258f? ([2804:14d:5c5e:44fb:3e90:dc7b:9e2c:258f])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001c76fcccee8sm9723461plg.156.2023.10.09.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 08:32:01 -0700 (PDT)
Message-ID: <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
Date: Mon, 9 Oct 2023 12:31:57 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, markovicbudimir@gmail.com
Cc: Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
 <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231009080646.60ce9920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/10/2023 12:06, Jakub Kicinski wrote:
> On Sat, 7 Oct 2023 06:10:42 +0200 Christian Theune wrote:
>> The idea of not bricking your system by upgrading the Linux kernel
>> seems to apply here. IMHO the change could maybe done in a way that
>> keeps the system running but informs the user that something isn’t
>> working as intended?
> 
> Herm, how did we get this far without CCing the author of the patch.
> Adding Budimir.
> 
> Pedro, Budimir, any idea what the original bug was? There isn't much
> info in the commit message.

We had a UAF with a very straight forward way to trigger it.
Setting 'rt' as a parent is incorrect and the man page is explicit about 
it as it doesn't make sense 'qdisc wise'. Being able to set it has 
always been wrong unfortunately...

