Return-Path: <netdev+bounces-15379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C347473BE
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EA81C20980
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4B613B;
	Tue,  4 Jul 2023 14:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D512575
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:11:45 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E555F10C1;
	Tue,  4 Jul 2023 07:11:39 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3280333b3a.3;
        Tue, 04 Jul 2023 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479899; x=1691071899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVWqdQakMSUsv5oj8nSg9QczQrmrUO38b67MhpmWVYY=;
        b=ZH/KPRP50O9QKZQfFKaA+IfAWPHaD+Gxo1Eu3fP8ZxyDdYI3LJSQtB5pJ1LNZCP35q
         IiV8TxAZlRORnVGaqCJdzy5BFSME/+DZq9B+IS9yAxJQ4FU3c0sHLNVg4LaQttqWg5hd
         bM5LMjlOQJCGjfyUqstEXhs3Dd8wimOob7Q0h3RUn4qjwSxiYa/nobSPuoeZEPS9MS42
         srKFZ70VAwX7m2pI0PgphsbWrm6lh/UXvykFGzcIugoINW1nJ0OhoX+WdVsTs9eNV23E
         aJtRS4HrQ1C6JxK+hMqI3oWzf0iKWvVdvHE7pO3iCmyrKE+K3UE6Y5185bgItTX1QEDi
         4JGA==
X-Gm-Message-State: AC+VfDyguM2YZAAPdq0N9FgoO29YGFEhGKrGIR6kCa7gx3X6HXmDtixw
	qsAUMcwhyjDMUOAki/oH7fs=
X-Google-Smtp-Source: ACHHUZ4mKI72SACTkxfTB3tQ6Ji13XYniCvY2MHAxg/n5JeT4DfHtHYI7qLyK+rPyEqNoEPYk2/cWg==
X-Received: by 2002:a05:6a20:1456:b0:12c:d9cc:340e with SMTP id a22-20020a056a20145600b0012cd9cc340emr10681222pzi.5.1688479899229;
        Tue, 04 Jul 2023 07:11:39 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b00682a9325ffcsm1178509pff.5.2023.07.04.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:11:38 -0700 (PDT)
Message-ID: <739807cf-4551-4760-83e0-a94026b5c1b8@acm.org>
Date: Tue, 4 Jul 2023 07:11:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kunit-dev@googlegroups.com, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
References: <202307032309.v4K1IBoR-lkp@intel.com>
 <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/4/23 00:15, Marc Zyngier wrote:
> On 2023-07-03 16:11, kernel test robot wrote:
>> tree/branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> master
>> branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next
>> specific files for 20230703
>>
> 
> [...]
> 
>> Unverified Error/Warning (likely false positive, please contact us if
>> interested):
>>
>> arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
> 
> This *is* a false positive. The function is entered with a lock
> held, it will exit with the lock held as well. Inside the body
> of the function, we release and reacquire the lock.

Which tool reported this message? If this message was reported by 
sparse, has it been considered to add a __must_hold() annotation?

Thanks,

Bart.


