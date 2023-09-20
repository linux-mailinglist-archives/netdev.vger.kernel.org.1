Return-Path: <netdev+bounces-35311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB87A8BBC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE433281A09
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF333CD06;
	Wed, 20 Sep 2023 18:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB53CD04
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:27:25 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA212B;
	Wed, 20 Sep 2023 11:27:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c008042211so1428471fa.2;
        Wed, 20 Sep 2023 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695234435; x=1695839235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B51hhManBxQCDJi8s/bZ6EVrxt2B6zMHpl9BIven/A=;
        b=XxkB1F4mWNZ5hmEZIAL9RYt3aY48jFNLjmnb4ZC4///+Ca/tlZV0DiKfruR22tiThX
         LEJhcgDoh2NvAB/lgYePIdx5fEiH60rhFHTt2CsFSfFJdjs42f7+sqAwb8yw/3YvdOKh
         yuVa99B+pLt2atDesBJP7HIHUf4cqlGB4xc+yhbu0jwgzOS+42doXSQZcTrgMbVeMnV3
         a2dmS3cd2LN5JB/aj6EujAKJ5mOm0uFCoaAWqcJaMHtcyUE1pOdth/C+cU1fkCOGU8Ly
         EgVcg71sxIJqyx+uRvIU3BVn4aCPnGuASMsMiOLPjdLFeEe40P3N46qZOooIBG1oWsi7
         tJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695234435; x=1695839235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/B51hhManBxQCDJi8s/bZ6EVrxt2B6zMHpl9BIven/A=;
        b=hWdyjNoGpGHHOxm8jWYqq0QVW795D34QxEaPUgwTw7ja7bqGbT8feVcCeQj6zGJoep
         5FGn5YKpfgIaJYE/e/n3PD8LnrklBwxtR7WVuG7UrUJWpNyek0WCnw758z6/q1IFsRky
         x+QbFwCmah9KhG4PLj4YboFJrkOiZzA/MGeEkL8KV+5x97fHPwdt+RH36fTDp0LgQlv6
         23r2zHt1PqgBPpm+7hIPsUgWw119AVkpRZUDiLeGtfo8FEvQ3s1a1yxi96RL8j/TtmAa
         PqT90Sxhdf8YPUUfYHCYg+8LNkS9wOsfXLkSDlzkgRXDNwhqyvDkZcS7Hm6S9inkLaHd
         YxlQ==
X-Gm-Message-State: AOJu0Yw1Tdz8WSp9RYjRRklErzHNl2SeeZ4nG95m+nV2vHGWZa4Nugej
	dpcKO7FDrtXou3Wi9a0bLBl0YkJ/qP+8osJKy8Q=
X-Google-Smtp-Source: AGHT+IF0iUJNRicLpJin3ByiycK68Xagu/oZrfx1jraD/qFlUAPWvrmPcx4u8CUjgnhAlieVUWLkWumO10WZWKvzyDY=
X-Received: by 2002:a05:651c:108:b0:2bd:133c:2d71 with SMTP id
 a8-20020a05651c010800b002bd133c2d71mr2718462ljb.52.1695234435115; Wed, 20 Sep
 2023 11:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829205936.766544-1-luiz.dentz@gmail.com> <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info> <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
 <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info> <CABBYNZJ=5VH2+my7Gw1fMCaGgdOQfbWNtBGOc27_XQqCP7jD-A@mail.gmail.com>
 <ff2abfbe-a46b-414b-a757-8185495838b7@leemhuis.info> <cd12622b-bfc6-093d-5c10-493e10935440@leemhuis.info>
In-Reply-To: <cd12622b-bfc6-093d-5c10-493e10935440@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Sep 2023 11:27:02 -0700
Message-ID: <CABBYNZKg8dbD0CY2yR=JUYLjXcRm_Pq7GU3W5gPErx6-_7GAJQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, patchwork-bot+bluetooth@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>, 
	Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Thorsten,

On Wed, Sep 20, 2023 at 7:02=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> @Luiz Augusto von Dentz: did you make any progress to get this into net
> to make sure this rather sooner then later heads to mainline? Doesn't
> looks like it from here, but maybe I'm missing something.

Just sent the pull-request:

https://patchwork.kernel.org/project/bluetooth/patch/20230920181344.571274-=
1-luiz.dentz@gmail.com/

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
>
> On 14.09.23 20:08, Thorsten Leemhuis wrote:
> > On 14.09.23 19:51, Luiz Augusto von Dentz wrote:
> >> On Wed, Sep 13, 2023 at 10:13=E2=80=AFPM Thorsten Leemhuis
> >> <regressions@leemhuis.info> wrote:
> >>> On 12.09.23 21:09, Luiz Augusto von Dentz wrote:
> >>>> On Mon, Sep 11, 2023 at 6:40=E2=80=AFAM Linux regression tracking (T=
horsten
> >>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
> >>>>>> This patch was applied to bluetooth/bluetooth-next.git (master)
> >>>>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >>>>>> On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
> >>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>>>>>>
> >>>>>>> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning require=
s
> >>>>>>> periodic restarts of the scanning procedure as the controller wou=
ld
> >>>>>>> consider device previously found as duplicated despite of RSSI ch=
anges,
> >>>>>>> but in order to set the scan timeout properly set le_scan_restart=
 needs
> >>>>>>> to be synchronous so it shall not use hci_cmd_sync_queue which de=
fers
> >>>>>>> the command processing to cmd_sync_work.
> >>>>>>> [...]
> >>>>>>
> >>>>>> Here is the summary with links:
> >>>>>>   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICAT=
E_FILTER
> >>>>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
> >>>>>
> >>>>> That is (maybe among others?) a fix for a regression from 6.1, so w=
hy
> >>>>> was this merged into a "for-next" branch instead of a branch that
> >>>>> targets the current cycle?
> >> [...]
> >>> That answer doesn't answer the question afaics, as both 6.1 and 6.4 w=
ere
> >>> released in the past year -- the fix thus should not wait till the ne=
xt
> >>> merge window, unless it's high risk or something. See this statement
> >>> from Linus:
> >>> https://lore.kernel.org/all/CAHk-=3Dwis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5=
wmB6SRUwQUBQ@mail.gmail.com/
> >> Thanks for the feedback, I will try to push fixes to net more often.
> >
> > Great, many thx!
> >
> >>>> but I could probably have it marked for stable just
> >>>> to make sure it would get backported to affected versions.
> >>> That would be great, too!
> >> Well now that it has already been merged via -next tree shall we still
> >> attempt to mark it as stable? Perhaps we need to check if it was not
> >> backported already based on the Fixes tag.
> >
> > Changes only get backported once they hit mainline, which hasn't
> > happened yet. And to get them into the net branch (and from there to
> > mainline) a new commit is needed anyway, so you might as well add the
> > stable tag to it. Side note: And don't worry that identical commit is
> > already in -next, git handles that well afaik (but if you rebase
> > bluetooth-next for other reasons anyway you might as well remove it).
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.



--=20
Luiz Augusto von Dentz

