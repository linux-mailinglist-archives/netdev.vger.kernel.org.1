Return-Path: <netdev+bounces-16979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54474FBBA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198C91C20E11
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED62D1ED32;
	Tue, 11 Jul 2023 23:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C21DDFD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:10:55 +0000 (UTC)
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 16:10:54 PDT
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3ACF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:10:53 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0BAE126157F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:52:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 69031261704
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:52:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689115938; a=rsa-sha256;
	cv=none;
	b=2N9SQj05MnTpg3GAP1uqc4UkprhRPCKfOW84bLrmDYc/iRS2o/bisAKgWoOP7V5gH/pLXB
	IrONb8O6It9/wA2uGcoY8w6WbUFHLgmfy19Zt0He6ATXNiybdDDovcPr+y4TaNHQzztAmZ
	/sbDlTG7ZzSTSVex0DfyetoU/nlQKfdp3BFe4L651uTmemJ7R1mOg/h4RQAeHwZB4S0VIO
	ZNifS83GfoSC1Invai95iEiWQ0htbJYRuTwS6Quqw6DZP+7Zn1xZOt0bivSeeXWtUWfokA
	gynrMMB8SDLWEyFgf3/K0cMrIsrHRDaGs8KndLU3ha6WbpSxIOOhOjvCFcUryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1689115938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XV8yVFLS5zMgqY/+/PS/KFJu/og6DkPIRq5kY6V6N08=;
	b=vtZB/S5aqF/4vW97FNYFh3u/yt0S4nT8jiIwdVBPFHQsAjWZKKxwYfonXfOzMWfGIC4LxR
	iotlwMQAUS4GxfJXmjL0LX/Dz6fKRLEB61TaI2xebtu8PXMgOKMlvRLw8vCE5NlePf4hLD
	QCWR8MqT9u8O+jDBUFK18yClM/dB18TSgSNb034ZGfIsPKKPHfXp9Trv4HpXLogRHvRnsY
	czvC3xSLNpL3yUyoviBOdWBjzVpp377mWoiiA+FlyraEnW+NCh+HZQNpu0nSemCVNoxrjQ
	cqSPMveTy15fswrcpL/Wu4UhRaBhjUqB+nF7QC2qwQhGnS9kNw0+3+aFJB5nGw==
ARC-Authentication-Results: i=1;
	rspamd-7d9c4d5c9b-kprkf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Keen: 11fe075458cbed9d_1689115939694_2894248095
X-MC-Loop-Signature: 1689115939694:1113142804
X-MC-Ingress-Time: 1689115939693
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.24.120 (trex/6.9.1);
	Tue, 11 Jul 2023 22:52:19 +0000
Received: from kmjvbox (unknown [71.198.86.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0x2m1CpPz12t
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1689115936;
	bh=XV8yVFLS5zMgqY/+/PS/KFJu/og6DkPIRq5kY6V6N08=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CttG4FAtMe7nJzvGrVpLzPnS4lSDLwydVef8srYLzGTtqb6JyBP1Q1RMr9e9ZDE94
	 0GPkqExwHk5JDXfHiI63zyEtUa9WgUj7ijxSrxFwP2lrFXPOBM8rtnbEGH0IttDzy+
	 eJ1q77E6AjGNVfzcAZpRCggXERTuT3HPgIJFyAnc=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00cb
	by kmjvbox (DragonFly Mail Agent v0.12);
	Tue, 11 Jul 2023 15:52:10 -0700
Date: Tue, 11 Jul 2023 15:52:10 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Shay Agroskin <shayagr@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Message-ID: <20230711225210.GA2088@templeofstupid.com>
References: <20230711013621.GE1926@templeofstupid.com>
 <pj41zllefmpbw7.fsf@u95c7fd9b18a35b.ant.amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pj41zllefmpbw7.fsf@u95c7fd9b18a35b.ant.amazon.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 08:47:32PM +0300, Shay Agroskin wrote:
> 
> Krister Johansen <kjlx@templeofstupid.com> writes:
> 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c
> > b/drivers/net/ethernet/amazon/ena/ena_com.c
> > index 451c3a1b6255..633b321d7fdd 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> > @@ -35,6 +35,8 @@
> >  #define ENA_REGS_ADMIN_INTR_MASK 1
> > +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> > +
> >  #define ENA_MIN_ADMIN_POLL_US 100
> >  #define ENA_MAX_ADMIN_POLL_US 5000
> > @@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct
> > ena_com_admin_queue *admin_queue,
> >    static void ena_delay_exponential_backoff_us(u32 exp, u32  delay_us)
> >  {
> > +	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
> >  	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
> >  	delay_us = min_t(u32, delay_us * (1U << exp),  ENA_MAX_ADMIN_POLL_US);
> >  	usleep_range(delay_us, 2 * delay_us);
> 
> Hi, thanks for submitting this patch (:

Absolutely; thanks for the review!

> Going over the logic here, the driver sleeps for `delay_us` micro-seconds in
> each iteration that this function gets called.
> 
> For an exp = 14 it'd sleep (I added units notation)
> delay_us * (2 ^ exp) us = 100 * (2 ^ 14) us = (10 * (2 ^ 14)) / (1000000) s
> = 1.6 s
> 
> For an exp = 15 it'd sleep
> (10 * (2 ^ 15)) / (1000000) = 3.2s
> 
> To even get close to an overflow value, say exp=29 the driver would sleep in
> a single iteration
> 53687 s = 14.9 hours.
> 
> The driver should stop trying to get a response from the device after a
> timeout period received from the device which is 3 seconds by default.
> 
> The point being, it seems very unlikely to hit this overflow. Did you
> experience it or was the issue discovered by a static analyzer ?

No, no use of fuzzing or static analysis.  This was hit on a production
instance that was having ENA trouble.

I'm apparently reading the code differently.  I thought this line:

> >  	delay_us = min_t(u32, delay_us * (1U << exp),  ENA_MAX_ADMIN_POLL_US);

Was going to cap that delay_us at (delay_us * (1U << exp)) or
5000us, whichever is smaller.  By that measure, if delay_us is 100 and
ENA_MAX_ADMIN_POLL_US is 5000, this should start getting capped after
exp = 6, correct?  By my estimate, that puts it at between 160ms and
320ms of sleeping before one could hit this problem.

I went and pulled the logs out of the archive and have the following
timeline.  This is seconds from boot as reported by dmesg:

   11244.226583 - ena warns TX not completed on time, 10112000 usecs since
    last napi execution, missing tx timeout val of 5000 msec
   
   11245.190453 - netdev watchdog fires
   
   11245.190781 - ena records Transmit timeout
   11245.250739 - ena records Trigger reset on
   
   11246.812620 - UBSAN message to console
   
   11248.590441 - ena reports Reset inidication didn't turn off
   11250.633545 - ena reports failure to reset device
   12013.529338 - last logline before new boot

While the difference between the panic and the trigger reset is more
than 320ms, it is definitely on the order of seconds instead of hours.

> Regarding the patch itself, I don't mind adding it since exp=16 limit should
> be more than enough to wait for the device's response.
> Reviewed-by: Shay Agroskin <shayagr@amazon.com>

Thanks,

-K

