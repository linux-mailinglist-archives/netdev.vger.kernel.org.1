Return-Path: <netdev+bounces-16293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4374C66E
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B215280A03
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB879DE;
	Sun,  9 Jul 2023 16:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B91FBE2
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 16:32:08 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D80101
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 09:32:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9926623e367so473323166b.0
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=gAn+QFrFr5ulawjYCYTO7VmTQzHU5lgWSC5NEnzugmdYhNVwnmToW+MQ4reDvuq6l7
         PzP2nnDKMv8tyPbAMBaFVMjpeYKtX/i/KRcWvIp4fd9RpwmjkD31sHkkt+5HXaKSjBzT
         4EDltBMvryK/qN2k9UurMRUANtYKeMK9ETJQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688920325; x=1691512325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6q+aOy2r+flgQCJZwvu7LKyLs8yIYN/+XSC8dA1GdM=;
        b=bwbEkBOKebUboNLBGNfcwGEoaoEs/dOGilnpz3lwu9/C8LSp8Z1cVsowf9de8dC+cW
         YBpRZWbV7koj2AUNRxpHY5gPNpbCJLR32uy+d+oCJqtxVDZsK+3aAFANPpCikP4/cvwM
         7Zj4v8P8tzBvvbclDXsV5QQ5gNZk2Bw7BzVWNOuvyQV3evi8zEVVLQ0AqqsHJoGieGC+
         5Rsk7mSGh+c/mmjdI9HdNcmUSJlsPpwhM/Y5SDBUoxRS4O0liHJ3cIRjxfak/0F//Axl
         hR2MzNHvpw3rSwQEkVwrbMhAICUbLh59swSmoNbDGRYGayy/lXF3HWzOTQ2x0/pP5q69
         +PTw==
X-Gm-Message-State: ABy/qLYNLzbdqQE/LiSnNvfB8gx4tOjX0OGkri7SZKmrseCpmDEuhxfg
	ghZ0ZhYzyM6dTZkUuktWLLmkXJJvMYVe12r1BQlM8GqG
X-Google-Smtp-Source: APBJJlGz6L26DWtfVApHkFIB8r2ITRiGjEpOdC5ORmFw3QyrU/CBQ80/ALjkgk+GWRQvqP+Qu97c1g==
X-Received: by 2002:a17:906:2205:b0:973:ff8d:2a46 with SMTP id s5-20020a170906220500b00973ff8d2a46mr9912571ejs.3.1688920325194;
        Sun, 09 Jul 2023 09:32:05 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id e25-20020a1709067e1900b0098de7d28c34sm4941027ejr.193.2023.07.09.09.32.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso38571285e9.2
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 09:32:04 -0700 (PDT)
X-Received: by 2002:a5d:54c2:0:b0:313:f22c:7549 with SMTP id
 x2-20020a5d54c2000000b00313f22c7549mr8377726wrv.66.1688920324114; Sun, 09 Jul
 2023 09:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com> <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
In-Reply-To: <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Jul 2023 09:31:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Message-ID: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Greenman, Gregory" <gregory.greenman@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Baruch, Yaara" <yaara.baruch@intel.com>, 
	"Ben Ami, Golan" <golan.ben.ami@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 7 Jul 2023 at 03:55, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the regression list, netdev, the net maintainers, and Linus;
> Johannes and Kalle as well, but just for the record, they afaik are
> unavailable]

So I will release rc1 with this issue, but remind me - if it hasn't
had any traction next week and the radio silence continues, I'll just
revert it all.

From a quick look, "revert it all" ends up being

  fd006d60e833: "wifi: iwlwifi: remove support of A0 version of FM RF"
  a701177bd4bc: "wifi: iwlwifi: cfg: clean up Bz module firmware lines"
  f4daceae4087: "wifi: iwlwifi: pcie: add device id 51F1 for killer 1675"
  399762de769c: "wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices"
  31aeae2446d5: "wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants"
  ecf11f4e4950: "wifi: iwlwifi: also unify Ma device configurations"
  bfed356b4fc4: "wifi: iwlwifi: also unify Sc device configurations"
  3fd31289d5de: "wifi: iwlwifi: unify Bz/Gl device configurations"
  e3597e28a2fa: "wifi: iwlwifi: pcie: also drop jacket from info macro"
  0f21d7d56083: "wifi: iwlwifi: remove support for *nJ devices"
  c648e926d021: "wifi: iwlwifi: don't load old firmware for 22000"
  a7de384c9399: "wifi: iwlwifi: don't load old firmware for ax210"
  a13707f7c845: "wifi: iwlwifi: don't load old firmware for Bz"
  508b4a1baeb3: "wifi: iwlwifi: don't load old firmware for Sc"
  5afe98b2e299: "wifi: iwlwifi: give Sc devices their own family"
  19898ce9cf8a: "wifi: iwlwifi: split 22000.c into multiple files"

since clearly nothing seems to be happening on this front, and summer
vacations are only going to get worse.

But we'll give it another week. In August huge chunks of Europe will
go on vacation.

                    Linus

