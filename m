Return-Path: <netdev+bounces-20046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95075D786
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D3F28254F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3B1BE6D;
	Fri, 21 Jul 2023 22:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C361EAF6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 22:32:42 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE823583
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:32:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso1917159f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689978759; x=1690583559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1C61anelbuHVBz160KtCowrhvBVRAfuba/IwKLv9mI=;
        b=Qxt5hcPGHtPiQw8dP9Xf2H7N481R/l9r3Ii3gnxK6zhEKPMrLLLz62D6SFkR2oCJQ/
         QtvowVF2+i075NmMDnsLSK7iZxkbEJhRbREYwc2vHzLEYykmcnXKi3rhnLdxG7958SOh
         UWuyRILrzKkM8n3umtaoWox+PMF7j1f3LbocEkh821XXqFg5WZwdQIle/76n6Uq2xCRV
         I2/hprA7CuOrRf+sOxoXqzysPwEop3DoLCrj/FCYh2nw7LqgWp/eWflvAh3e8lbZSmr4
         vbXX9ejhLx3vMy/b6lRCLL29oKKoZn1HpOSD6sZQt63IKr+PsJwnYOUq5piKJnI6FYBc
         hpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978759; x=1690583559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1C61anelbuHVBz160KtCowrhvBVRAfuba/IwKLv9mI=;
        b=BIyU38hur6gLb+6dMAM6a+F5sJ+EJ6Cno0nqR5a+dZPecO6VisNKt6j7W1GLzPPTgX
         wvuNXfPFvNHCMvou52x5nEcdk4kdoEYcVggPIDFpJc101VjiJzYWm2a2285ZoCB1bemf
         Feym+uus7V8yCbmDu3ikaV+AyFs7iO+E7sYmhdlGsJKtEHhC1f611JIbQhm0SoOfKT3L
         RLzvWLQLwcnUNkbi/Ju71GSWoofNoDQCKmJRdJMvsASMsVRhjQkmoDPyYCfN1LW8j0cu
         8Ot2mNLPN2GdmhrA9x/4CdczFrlwO4S3vT9kTpXJR4eHSZmccGtD1hHu1ulrMJxXqc6o
         3CHg==
X-Gm-Message-State: ABy/qLZqB34eoKB/yd9VjZ3XHzGeMhAYMXTP2ZHLxUQTlepYwgUxWR99
	X07lINJZ7V4PrQmKPp63N/g=
X-Google-Smtp-Source: APBJJlGKyTzO1yNl+tHvQ3sQv7IixBhKOYYzKmiJP5IQSLPFXFGQUnABB9tJreUlPNt6qGLbO0txFw==
X-Received: by 2002:a5d:4244:0:b0:30e:590f:78d1 with SMTP id s4-20020a5d4244000000b0030e590f78d1mr2176632wrr.63.1689978758864;
        Fri, 21 Jul 2023 15:32:38 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4529000000b0030fd03e3d25sm5283311wra.75.2023.07.21.15.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:32:38 -0700 (PDT)
Date: Sat, 22 Jul 2023 01:32:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Message-ID: <20230721223236.kgdjzl7unfbuenzm@skbuf>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721150212.h4vg6ueugifnfss6@skbuf>
 <CH2PR12MB3895C55CC77385622898BCADD73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB3895C55CC77385622898BCADD73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Asmaa,

On Fri, Jul 21, 2023 at 07:06:03PM +0000, Asmaa Mnebhi wrote:
> > What is the race condition; what does the stack trace of the NPD look like?
> 
> Hi Vladimir,
> 
> [  OK  ] Reached target Shutdown.
> [  OK  ] Reached target Final Step.
> [  OK  ] Started Reboot.
> [  OK  ] Reached target Reboot.
> ...
> [  285.126250] mlxbf_gige MLNXBF17:00: shutdown
> [  285.130669] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> [  285.139447] Mem abort info:
> [  285.142228]   ESR = 0x0000000096000004
> [  285.145964]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  285.151261]   SET = 0, FnV = 0
> [  285.154303]   EA = 0, S1PTW = 0
> [  285.157430]   FSC = 0x04: level 0 translation fault
> [  285.162293] Data abort info:
> [  285.165159]   ISV = 0, ISS = 0x00000004
> [  285.168980]   CM = 0, WnR = 0
> [  285.171932] user pgtable: 4k pages, 48-bit VAs, pgdp=000000011d373000
> [  285.178358] [0000000000000070] pgd=0000000000000000, p4d=0000000000000000
> [  285.185134] Internal error: Oops: 96000004 [#1] SMP

That is not a stack trace. The stack trace is what appears between the
lines "Call trace:" and "---[ end trace 0000000000000000 ]---", and it
is missing from what you've posted.

It would be nice if you could also post-process the stack trace you get
through the command below (run in a kernel tree):

cat stack_trace | scripts/decode_stacktrace.sh path/to/vmlinux .

so that we could see the actual C code line numbers, and not just the
offsets within your particular binary image.

