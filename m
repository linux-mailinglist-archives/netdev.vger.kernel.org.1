Return-Path: <netdev+bounces-24686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3E771178
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D4281F65
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20420C2F2;
	Sat,  5 Aug 2023 18:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DA1FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 18:35:47 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55486B7
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:35:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76c9334baedso202713985a.2
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691260543; x=1691865343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGhMUdldtY0+/e8gREoTkca+7FM9iuGsDLO3yurckxM=;
        b=Xwq3zgS2A0/LF3Ml8cKRxxqvsp0iC0SpiMj3tqKDWpSkMxWU/ADeet3f/kLne3SgqI
         yUYcyJVKx2oZEi0EDbT4SybctYIqzR9HjDXfNbZ6PCLuqWwinsJQobi4q2GquXdzDe09
         sXMPYsC0I8N0M/qn+xAzoMIyfB+fAdAgswqpBZ/DF4auqOTQEyQM4H82ZvlO+LEm80+d
         SSw9YK6UVRPOb4obiv9G2C1hBbPq2WMjx7zYKauiNhH1s51XTYdUgVBr7LIywk6ZKHJa
         /MwKIwSGXv/31aUfOggLiTTKFXF0IPxvz5krjQapB0k8pkzyNzXHizKK0j8QQzvvA6qM
         afSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691260543; x=1691865343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YGhMUdldtY0+/e8gREoTkca+7FM9iuGsDLO3yurckxM=;
        b=cKh/+yfml1B9wVINlgpVmJoShE745U/CFcsV+eYdmLuga7nSfwmKIJD1Eeo/lnWe7o
         uynrgqiD895yGOaQYZ2G/0au28MO0RS6h1xC5hIqK7KLaC/3tHvFBg3APnoI+XemJA4y
         NukECCN/iV2wcuMsZ7L4fLGOfRHayEWg9KV+d+LyEbvxf+nO8QiEgTEI67WafNKqqshs
         PsUfgf9i90KIM68ihSqz//y7u+D2ewBOLp9awSrZY99Nh0JKhbvmOpEjx+7ndmtTNROP
         ZdfTcDvdDDD4raxdgichLqTpz8yhHJhY+Vd6rIm4sWcmA0IaYLE06OWDM2A9evEmP51k
         AKag==
X-Gm-Message-State: AOJu0Yz1+hGcd4tH9ucKxRYQKRuHMIbWMce7zU6BFHKLcEMjYfpoQfGL
	7equR9BdTpwIvf7A/qXeHkM=
X-Google-Smtp-Source: AGHT+IGdOE80QoQgMN1rYEebqPdDi5Iwg+4yiq6zbGSsJXs3NW0+f0Ly+XQYFZ9sHqswtPkmSiroWQ==
X-Received: by 2002:a05:620a:4da:b0:76c:af3e:3c18 with SMTP id 26-20020a05620a04da00b0076caf3e3c18mr5044331qks.43.1691260543345;
        Sat, 05 Aug 2023 11:35:43 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d4-20020a37c404000000b0076cda7eab11sm1470648qki.133.2023.08.05.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:35:42 -0700 (PDT)
Date: Sat, 05 Aug 2023 14:35:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, 
 yuehaibing@huawei.com
Message-ID: <64ce967e6614f_3044329490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230805110009.44560-1-yuehaibing@huawei.com>
References: <20230805110009.44560-1-yuehaibing@huawei.com>
Subject: RE: [PATCH net-next] udp/udplite: Remove unused function declarations
 udp{,lite}_get_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Yue Haibing wrote:
> Commit 6ba5a3c52da0 ("[UDP]: Make full use of proto.h.udp_hash innovation.")
> removed these implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

