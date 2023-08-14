Return-Path: <netdev+bounces-27463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916877C129
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184171C20B5A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D61D512;
	Mon, 14 Aug 2023 20:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D8CA4B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:01:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7210C8;
	Mon, 14 Aug 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kdJnqWVzzrscwN4ereKbPQx9d2p7ritar4asPO6GM3Y=; b=Iq6vxRjUZj/TrUv1wAFWiCfQM+
	DbMTbBiOT92+Duh5wcIUZDDlstKiI8w3Gs/WRo0dxSo32Bam2B8MQDDy0AffD/NYihRq9mvC3bA9X
	xbH6Hc7nGRvZddZODkQBYk07YuEpowGas8jyytfdHjbApQN9tRLMWVm1GaOuDaWeLhS7qQTOLuZdK
	9Dpk0/NioDsAJMBYbW3nP4RSrA5mQA87fAQB2DWP7ixapK5eyO8tthvL1yt1PjJBBrZ6zudXRhgb+
	W72GsS7Qf0xOA3JV2A0Yu3kuC+uqtCyDnOtflGc+2LHqubE82B4F+1WM/VBc+AaKjCI9iBB3mkcMM
	XYUaOt2Q==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qVdkI-000G69-1M;
	Mon, 14 Aug 2023 20:00:58 +0000
Message-ID: <155add9d-241c-0e15-cc3b-a2ea22e8cdd0@infradead.org>
Date: Mon, 14 Aug 2023 13:00:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on ThinkPad
 T490s"
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Richard Cochran <richardcochran@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230814164054.64280-1-jarkko@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230814164054.64280-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jarkko,

On 8/14/23 09:40, Jarkko Sakkinen wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..6354aa779178 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6340,6 +6340,13 @@
>  			This will guarantee that all the other pcrs
>  			are saved.
>  
> +	tpm_tis.interrupts= [HW,TPM]
> +			Enable interrupts for the MMIO based physical layer
> +			for the FIFO interface. By default it is set to false
> +			(0). For more information about TPM hardware interfaces
> +			defined by Trusted Computing Group (TCG) look up to

s/look up to/see/ would be much better IMO.

> +			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
> +

-- 
~Randy

