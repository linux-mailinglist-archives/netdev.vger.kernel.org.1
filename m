Return-Path: <netdev+bounces-35682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611A57AA937
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 49CEC1C209B2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0B442D;
	Fri, 22 Sep 2023 06:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538B2F3A
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 06:43:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74B19C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695365017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRMPqvCqmMC0AJ675niYKzHjnygI6mzXkE/qj4uep/M=;
	b=CY0Ol8FbTLljPyhbpNVmLFpyCypY3ISPRTdZf4jA+XfvdzFuT5UCsw3t7NHh8zns0cHdEl
	EnlYKs2LCWsgAQ8smbWxEsNgPObnxG7fMQXbqPSefeIU9G1nqcyl79voM8t5B2uUeT2Jij
	bE03+ZRRR1OPHc39TnFqOC4sFIulOfU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-g25j4gZeNMOUyd84PCSwMQ-1; Fri, 22 Sep 2023 02:43:36 -0400
X-MC-Unique: g25j4gZeNMOUyd84PCSwMQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c00cfa81b0so23618891fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695365014; x=1695969814;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRMPqvCqmMC0AJ675niYKzHjnygI6mzXkE/qj4uep/M=;
        b=VM9R9S66+1Rv3sJkeBZAxgk5Lt7M4SD4pGSnbnehw46uH1kfiSnLPeht3Czngtct1O
         39/uziMjujnZb3aQItCmxgLBai81ArGn9XUgfzFN+nl+Uo3geGH3bvWhFShgZ6KCJSXS
         9aTcaxHY5kJkfTsOLUb/lEo+LSvHuulS5vjKdEGytVQ/HP1dzlyp57tbD0axt/3WSryd
         Ibjx0AgPovnPs8mDTpx/cVhWbMt9uOKReaxfQQ+8Wci2/n63GsvaxV3DgDh6iQ7S5A3M
         h7Yw6+HTv5hSn7kfG/DCMBTmkRWUBtoXa4DyE5hXIAlEUb7EPXPDpyTXWNYu00BfuCu+
         ZOMg==
X-Gm-Message-State: AOJu0YyoW0qP+z+iD5x470wwhbYc68sSeeOtP8Fq6QgzbJsFjdGF4sOp
	NoPS4LO15w6fnscmURpZoMJN85iUhS6wcVPZthiu46TAGlvFDMeIbAqmUI7dOXn8iL0f6cBZvTC
	tGCdcxtDyui8iOB4wdRvicYJrbvxk2WZ9vmeAFMT2znLm58G2BxoZEWGIE6UpLLDhT1lYL5VJfK
	bk
X-Received: by 2002:a2e:8eca:0:b0:2bb:c212:5589 with SMTP id e10-20020a2e8eca000000b002bbc2125589mr6340005ljl.17.1695365014162;
        Thu, 21 Sep 2023 23:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgeGFU6HovUmC9t8NGr8L/qgVziF2T5GG1zIDCB0dVulG+o8O3PBU3gstaDp1VK5yV+J8e3A==
X-Received: by 2002:a2e:8eca:0:b0:2bb:c212:5589 with SMTP id e10-20020a2e8eca000000b002bbc2125589mr6339993ljl.17.1695365013769;
        Thu, 21 Sep 2023 23:43:33 -0700 (PDT)
Received: from [10.39.192.192] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906395b00b009ae587ce128sm2188822eje.216.2023.09.21.23.43.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 23:43:33 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] openvswitch: reduce stack usage in
 do_execute_actions
Date: Fri, 22 Sep 2023 08:43:32 +0200
X-Mailer: MailMate (1.14r5964)
Message-ID: <EFA8E5B7-948A-48C7-A52F-DDA00B0A2EE3@redhat.com>
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org>
References: <20230921194314.1976605-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21 Sep 2023, at 21:42, Ilya Maximets wrote:

> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>
> Move the stack allocation to push_nsh() function that is only used
> if NSH actions are actually present.  push_nsh() is also a simple
> function without a possibility for re-entry, so the stack is returned
> right away.
>
> With this change the preallocated space is reduced by 256 B per call:
>
>      b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

One more time to the list only, as for some reason I had HTML reply turned on :(

Thanks Ilya for optimizing this.

Reviewed-by: Eelco Chaudron echaudro@redhat.com


