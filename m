Return-Path: <netdev+bounces-37758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2F7B7026
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B710F2812B0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F253B2BA;
	Tue,  3 Oct 2023 17:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901DD2EB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 17:43:58 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D9AD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:43:55 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FACB4151E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696355034;
	bh=RekqBXxIuo8nUJ1wOD8QPazynzzYmeoIKII5+diCjtM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=b/jFWKo9XX2cCl+X70MC493XMTU4UVwVY3Ur0Cr/9x5i6hFBHjH2dfQNAS3nAP+IS
	 Igx5lTabdpGjWnWmq6b69y04XpVLlCFmuMbQY06CFGAXQX/ugoR2Y47duVJNRtNLc0
	 Y1t8ZzQJUcAPAqhmwweXSw9Wlo+uiHXaLFmJ1aYki/5XnPcv1MrEnaK92Xrrd1+wIZ
	 z/DEKL7JxW7rq26OdlNza0130VoRFCY2N0ESOtPQMEvyiFTxWY5J52lD9vgataUvqD
	 JxvnamshxzP1PxxgZfqAR6csHBmc1qyDIstaCmVncxrZ1l6eJbAqf54sCRLWR05yY9
	 MGkq+BWcnImbg==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5784ef4be4fso34416a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 10:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355032; x=1696959832;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RekqBXxIuo8nUJ1wOD8QPazynzzYmeoIKII5+diCjtM=;
        b=ZT1e/q9QHgKB2e7WfpGY4aIQQS4iHeqPq959EEOMLN1YlkAhToaakO6FVp4wEtdQzo
         cYwdZKmtqrcV+VDgNDYxB0pFcNBhyorcca1tYhmcwRGf0/EuAT0QPaZtLoYlCu1z6WEy
         1IJz/JQMtTlWn1/Uqy8bC3B5Lfco/hLOV9gVQJsNEVBAusYII2/didqz8RzkTl10oIMr
         CnYdszpe9HSgNRDHQNH0vshUNsLH/ogp5xg9xa+/28hXRDmMGjj1jK+RAEZz4vMas3ef
         bZ31otSfrWCk9noFK3XWgPFF9KZKE8+y6T6UXUOG4jLSIFQFXxIY0ptc+rAVe39gKtbY
         zHlg==
X-Gm-Message-State: AOJu0YxHD9J46t5e2Yw9pbXUu+iiB4GiNnsBYoH/aZZYvuoAEL0cArDC
	axDWF4JFnN0nnZxWO4UvkS/zT2EeRspVFmCHSKZ4jJs2/ipCJJNBzY/z2vMZDlHtGUaYbY1xG9p
	MGbvEHGNPQTTcg1XBBw3QU+PhcCifH0cfAA==
X-Received: by 2002:a17:90a:6b08:b0:277:422d:3a0f with SMTP id v8-20020a17090a6b0800b00277422d3a0fmr5126854pjj.17.1696355032647;
        Tue, 03 Oct 2023 10:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf+mJNCF8GOIgzfEETYZUhbEzNCAt0tEO+UwMr96ToEKnZHXBX0JVvdaGx2aQGr46KMJUqHA==
X-Received: by 2002:a17:90a:6b08:b0:277:422d:3a0f with SMTP id v8-20020a17090a6b0800b00277422d3a0fmr5126815pjj.17.1696355032293;
        Tue, 03 Oct 2023 10:43:52 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a001300b00279951c719fsm2043254pja.35.2023.10.03.10.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:43:51 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 661365FEAC; Tue,  3 Oct 2023 10:43:51 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5DCC59FAAE;
	Tue,  3 Oct 2023 10:43:51 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
cc: intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org,
    pmenzel@molgen.mpg.de, netdev@vger.kernel.org, jkc@redhat.com,
    "Vishal
 Agrawal" <vagrawal@redhat.com>,
    Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: reset first in crash dump kernels
In-reply-to: <d0dc80a2-6958-5cc1-b75e-2f1dd513f826@intel.com>
References: <20231002200232.3682771-1-jesse.brandeburg@intel.com> <17923.1696290586@famine> <d0dc80a2-6958-5cc1-b75e-2f1dd513f826@intel.com>
Comments: In-reply-to Jesse Brandeburg <jesse.brandeburg@intel.com>
   message dated "Mon, 02 Oct 2023 22:50:27 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <789.1696355031.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2023 10:43:51 -0700
Message-ID: <791.1696355031@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

>On 10/2/2023 4:49 PM, Jay Vosburgh wrote:
>> Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
>> =

>>> When the system boots into the crash dump kernel after a panic, the ic=
e
>>> networking device may still have pending transactions that can cause e=
rrors
>>> or machine checks when the device is re-enabled. This can prevent the =
crash
>>> dump kernel from loading the driver or collecting the crash data.
>>>
>>> To avoid this issue, perform a function level reset (FLR) on the ice d=
evice
>>> via PCIe config space before enabling it on the crash kernel. This wil=
l
>>> clear any outstanding transactions and stop all queues and interrupts.
>>> Restore the config space after the FLR, otherwise it was found in test=
ing
>>> that the driver wouldn't load successfully.
>> =

>> 	How does this differ from ading "reset_devices" to the crash
>> kernel command line, per Documentation/admin-guide/kdump/kdump.rst?
>> =

>> 	-J
>> =

>
>Hi Jay, thanks for the question.
>
>That parameter is new to me, and upon looking into the parameter, it
>doesn't seem well documented. It also seems to only be used by storage
>controllers, and would basically result in the same code I already have.
>I suspect since it's a driver opt-in to the parameter, the difference
>would be 1) requiring the user to give the reset_devices parameter on
>the kdump kernel line (which is a big "if") and 2) less readable code
>than the current which does:
>
>if (is_kdump_kernel())
>...
>
>and the reset_devices way would be:
>
>if (reset_devices)
>...
>
>There are several other examples in the networking tree using the method
>I ended up with in this change. I'd argue the preferred way in the
>networking tree is to use is_kdump_kernel(), which I like better because
>it doesn't require user input and shouldn't have any bad side effects
>from doing an extra reset in kdump.
>
>Also, this issue has already been tested to be fixed by this patch.
>
>I'd prefer to keep the patch as is, if that's ok with you.

	Thanks for the explanation; I was wondering if this methodology
would conflict or compete with reset_devices in some way, or if there's
a risk that the FLR would in some cases make things worse.

	Since many device drivers have this sort of logic in them, would
it make sense to put this in the PCI core somewhere to FLR at probe time
if is_kdump_kernel()?  The manifestation of the issue that I'm familiar
with is that DMA requests from the device arrive after the IOMMU DMA
remapping tables have been reset during kexec, leading to failures.

	Regardless, the patch looks fine to me given the current state
of kdump / kexec / reset_devices.

Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

