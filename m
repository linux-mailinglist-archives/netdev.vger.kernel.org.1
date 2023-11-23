Return-Path: <netdev+bounces-50430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D17F5C56
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0311B21169
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFE225A9;
	Thu, 23 Nov 2023 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KlFciYGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA321BF
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:32:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a02cc476581so87337166b.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700735529; x=1701340329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GManKvXrmUiwkljJpaZnD/3S4HSp75RXwJ2plJ7pOa4=;
        b=KlFciYGSvJb9aCbIbHk0YyUTYfQIEMYi+NeEylSylMPYh7sc/mtu8/TjuF5f0MYdRK
         hHMWrUbu6sWDW4OOo3NGXxxGPc7vcVfik+xlKGwqrzfwCD4TUrkC8oAchD9MvUGjQMX5
         76h/9XI9bpnSiC3UpsXZRh4VdTlpKEo2Fufqt6TJBDJLbqZy56Tu6Ev1WZeO8o9eGFrx
         tHz6r3iC1gmf4V18QSSjPZqyb9nrcHFJxqSLjpP6l3dU7D5aVr1jxLTxSaY3la9FPvPf
         ifU0IRi+bqHuGfjASL8WcL6W9Xf44SiN4/k/pGJL8I+wJTAMCkuYXbyJQtLmS921Z9Ya
         qUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735529; x=1701340329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GManKvXrmUiwkljJpaZnD/3S4HSp75RXwJ2plJ7pOa4=;
        b=SUTya4jOIG2HrfHpI1KELVYPGP1Bv5IxvLBDiUsKOQyYavHwrcxEhvIFluCQl/1qdX
         Ysx1lBFzPP5FtllzhssQ1nD5dd6cTdW1t1gUC0oP3HtU68e8ghW9gvIV0YuHTm+DJ7w3
         WE3sN/uQBIfk0IEFTbB3/7moi4ZjwuTFXo2G/nhpCohmTXom+i3xMSqGzVEpSlmkR4f3
         G+IEVMwW8SP1Ae17kMka4up7b8CjYPMCFN0Bc5XDUFMgXmlScSwlDk/fi7TFQII9efZY
         p5OifFf+rXZFyeLPNnpqlvPwRrL9KT4tfXHTchgLt0V5NGgT3qVwvN86Zq/h+StHaN0D
         VZ8g==
X-Gm-Message-State: AOJu0YzjDaTij4+4NQdZZtIBaOCq8BfiK3k2PFnCDrMlJzhgm7ABwK1X
	4mb+eUUJ8k3Ih5aJvUSgH4+NFg==
X-Google-Smtp-Source: AGHT+IFaebfRXE6ikq9pCYGUfA2EkaawpbFdMPFVtSM9yVIq0Kdh5KxjfHkKEYuIuLCsIeYl+lOtvA==
X-Received: by 2002:a17:906:52d2:b0:a00:893f:58cf with SMTP id w18-20020a17090652d200b00a00893f58cfmr2427913ejn.54.1700735528853;
        Thu, 23 Nov 2023 02:32:08 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b24-20020a1709062b5800b009fcd13bbd72sm599985ejg.214.2023.11.23.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:32:08 -0800 (PST)
Date: Thu, 23 Nov 2023 11:32:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZV8qJ1QX9vz3mfpT@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
 <ZVys11ToRj+oo75s@nanopsycho>
 <20231121095512.089139f9@kernel.org>
 <ZV3KCF7Q2fwZyzg4@nanopsycho>
 <20231122090820.3b139890@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090820.3b139890@kernel.org>

Wed, Nov 22, 2023 at 06:08:20PM CET, kuba@kernel.org wrote:
>On Wed, 22 Nov 2023 10:29:44 +0100 Jiri Pirko wrote:
>> >If you're doing it centrally, please put the state as a new field in
>> >the netlink socket. sk_user_data is for the user.  
>> 
>> I planned to use sk_user_data. What do you mean it is for the user?
>> I see it is already used for similar usecase by connector for example:
>
>I'm pretty sure I complained when it was being added. Long story.
>AFAIU user as in if the socket is opened by a kernel module, the kernel
>module is the user. There's no need to use this field for the
>implementation since the implementation can simply extend its 
>own structure to add a properly typed field.

In this case, the socket is not opened by kernel, but it is opened by
the userspace app.

I basically need to have per-user-sk pointer somewhere I'm not clear why
to put it in struct netlink_sock when I can use sk_user_data which is
already there. From the usage of this pointer in kernel, I understand
this is exactly the reason to have it.

Are you afraid of a collision of sk_user_data use with somebody else
here? I don't see how that could happen for netlink socket.

