Return-Path: <netdev+bounces-20050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C464175D7E2
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B09282495
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A120F9E;
	Fri, 21 Jul 2023 23:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD31ED44
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:29:14 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F81FDF
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:29:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7589b187so3923769e87.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689982150; x=1690586950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anVy9Kv4Y2YSI/LAKGEHJfCukEooM5SYvQ4i1jsNbGk=;
        b=EaJE5lSHp1QuFUcFWJrd7/oAlSR5LPj0j6p6FdbDiXFSfAD4X849YfXo0zFYHQRWyW
         30uya2lAffzjxVeXpa7jW5RafrU2KyzNktFCzp29o6odftwlCQSM1aFCrBSjKnqyGxm7
         UvXkbRoYunkDXL/fsKFXL3s0PRI/MMHUy7c7uH163S9ruItwScrBpFgOF2l95ZQHhzmJ
         8N9a8D9/S/IW3quo9ARBtPoauSqipRgKkEYDYCvBrTIOx+BPsSTGeZBkKMuwa5iqpmFl
         gCEDokmySU21GExgtu6fdxptEkqWgQsTIUI6ORLFMNTFA/hb6Xk7J7lKIS4FpgyAGf0e
         HzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689982150; x=1690586950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anVy9Kv4Y2YSI/LAKGEHJfCukEooM5SYvQ4i1jsNbGk=;
        b=YIlMzikJ0DAs1IkbiCizYTptOeQDjCl7MIYroNyq+nc+BhJrWdvHcrqVU2hzzzdfa+
         kZM1riu3Sm1vku6DlwI4AvHYMV4dI/J+fLfwCXu+eHbfQ0Wl2CS7V8XGkX0sLLKsktkc
         5GlGqdyLSM/GDazt3rltfjiT2sK7nddEEglqa2lO9DwctQtakBm6pJKlr3RkOsfgpmWK
         NhVfFc/pAOl3h9zrwK3985dvmi93MLoNqAUpJrzvIZQIJrkFr4swDoPLYGugwbb90d9T
         8qCGwbm28UO6KfO+5JZbnsn//mSEchTrxaGi/NDvhYy2K+6+ajOW50ioclmqUOWjz5nN
         oj2Q==
X-Gm-Message-State: ABy/qLal5XvOGXn3VYxBu8RPts4Qh9lrMndCLUkr++rFckd+hjslsgVk
	WKQ9vbWaMEf7klIefIHl2byvNR97zgZRzQ==
X-Google-Smtp-Source: APBJJlH8r5vcRs0+fNDd3J5zQL48ATpuo/fqYKbs2+AZ8q5SFrpP+pEHy3qzXXX88BBR1br62gLyXQ==
X-Received: by 2002:a05:6512:1150:b0:4fb:9168:1fce with SMTP id m16-20020a056512115000b004fb91681fcemr2446758lfg.59.1689982150218;
        Fri, 21 Jul 2023 16:29:10 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0031412b685d2sm5423028wrx.32.2023.07.21.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:29:09 -0700 (PDT)
Date: Sat, 22 Jul 2023 02:29:07 +0300
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
Message-ID: <20230721232907.mzi34kirl236wxfp@skbuf>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721150212.h4vg6ueugifnfss6@skbuf>
 <CH2PR12MB3895C55CC77385622898BCADD73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
 <20230721223236.kgdjzl7unfbuenzm@skbuf>
 <CH2PR12MB38953C0288EB343ABC8B250ED73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB38953C0288EB343ABC8B250ED73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 11:27:10PM +0000, Asmaa Mnebhi wrote:
> > > [  285.126250] mlxbf_gige MLNXBF17:00: shutdown [  285.130669] Unable
> > > to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000070 [  285.139447] Mem abort info:
> > > [  285.142228]   ESR = 0x0000000096000004
> > > [  285.145964]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [  285.151261]   SET = 0, FnV = 0
> > > [  285.154303]   EA = 0, S1PTW = 0
> > > [  285.157430]   FSC = 0x04: level 0 translation fault
> > > [  285.162293] Data abort info:
> > > [  285.165159]   ISV = 0, ISS = 0x00000004
> > > [  285.168980]   CM = 0, WnR = 0
> > > [  285.171932] user pgtable: 4k pages, 48-bit VAs,
> > > pgdp=000000011d373000 [  285.178358] [0000000000000070]
> > > pgd=0000000000000000, p4d=0000000000000000 [  285.185134] Internal
> > > error: Oops: 96000004 [#1] SMP
> > 
> > That is not a stack trace. The stack trace is what appears between the lines "Call
> > trace:" and "---[ end trace 0000000000000000 ]---", and it is missing from what
> > you've posted.
> > 
> > It would be nice if you could also post-process the stack trace you get through
> > the command below (run in a kernel tree):
> > 
> > cat stack_trace | scripts/decode_stacktrace.sh path/to/vmlinux .
> > 
> > so that we could see the actual C code line numbers, and not just the offsets
> > within your particular binary image.
> 
> Hi Vladimir,
> 
> Do you want me to just send it as a reply or send a v5 and add it to the commit message?

As a reply, for now, please. I haven't requested any changes to the patch.

