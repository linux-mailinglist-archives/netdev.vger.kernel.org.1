Return-Path: <netdev+bounces-34080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182557A1FDC
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B241C211A5
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4110973;
	Fri, 15 Sep 2023 13:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEED101EB
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:30:27 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EED18D;
	Fri, 15 Sep 2023 06:30:25 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694784624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4a69QAJHoLA0O/kevTly+3PbGRi/ca9qXsnMKQmmz4=;
	b=VvhyY2DjZI2vuivX7kUro9SCFkXJxhGEOzbmZVk78FLfzmED6+pXPF71mKfsEnmzi5ke/Y
	JzUSn+Y4ieqsib0SLhHkNeXeE0eeZdOPsxH9BFFg8IGHpqUHhgLFKbM9jjmOlkBUh0oI7i
	D0CUFWf00DY0DU2tvyKNA9Fy0I7H9gfSlZXnZdrEVs19CYik3pGy+KHhMjC7HIQUOPnBHB
	6rtDDAbD2aLigxZObvxapKneQW+ZtNScPpN+tl85LIxzZiGvpCw/J+HUOEkOuxNEzFQ6WK
	8Z7B7kQsYsXXU4WOrzqKpQOnKVj2jUk9bQFluXtkTHfD/+f37KWohaOdnnT1ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694784624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4a69QAJHoLA0O/kevTly+3PbGRi/ca9qXsnMKQmmz4=;
	b=MB7u8FElR3aNFJLb/9MfgTw1mqXDhAupHamM3e/Ij4hNRTGnIiKMXsws8Nk249DLQk0XIb
	2cTXmHAYSYrwk0Dg==
To: Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Peter Hilber <peter.hilber@opensynergy.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Richard Cochran <richardcochran@gmail.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 4/4] treewide: Use clocksource id for struct
 system_counterval_t
In-Reply-To: <20230818011256.211078-5-peter.hilber@opensynergy.com>
References: <20230818011256.211078-1-peter.hilber@opensynergy.com>
 <20230818011256.211078-5-peter.hilber@opensynergy.com>
Date: Fri, 15 Sep 2023 15:30:23 +0200
Message-ID: <87cyyj1s40.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Peter!

On Fri, Aug 18 2023 at 03:12, Peter Hilber wrote:
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1313,7 +1313,7 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
>  	res += tmp + art_to_tsc_offset;
>  
>  	return (struct system_counterval_t) {
> -		.cs = have_art ? &clocksource_tsc : NULL,
> +		.cs_id = have_art ? CSID_TSC : CSID_GENERIC,
>  		.cycles = res

Can you please change all of this so that:

    patch 1:   Adds cs_id to struct system_counterval_t
    patch 2-4: Add the clocksource ID and set the cs_id field
    patch 5:   Switches the core to evaluate cs_id
    patch 6:   Remove the cs field from system_counterval_t


> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -270,12 +270,12 @@ struct system_device_crosststamp {
>   * struct system_counterval_t - system counter value with the pointer to the
>   *				corresponding clocksource
>   * @cycles:	System counter value
> - * @cs:		Clocksource corresponding to system counter value. Used by
> + * @cs_id:	Clocksource corresponding to system counter value. Used by
>   *		timekeeping code to verify comparibility of two cycle values

That comment is inaccurate. It's not longer the clocksource itself. It's
the ID which is used for validation.

Thanks,

        tglx

