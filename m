Return-Path: <netdev+bounces-24618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7E770DDB
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3321C20B1C
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 05:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E98187E;
	Sat,  5 Aug 2023 05:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FD17C6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 05:10:01 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8714ED8;
	Fri,  4 Aug 2023 22:09:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so42057241fa.3;
        Fri, 04 Aug 2023 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691212197; x=1691816997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KldLBiFwSL+U5xUltvcJvXEpQEYt+vbYhZvqxWXYyU=;
        b=FbTm3Z4QhAkRbiqII6hLJoVkJQtpLednvFEFHd0HHxHn0twFOCwjnlYPLszFRmY5EY
         vhYhraxC2ouYoge35Q2jAFBaLP4L66sP8HxfL9zrUh0wj3aUKRbqdoaH1V4EqDQt2oIo
         xZQXRcCpB3BtZ7or6678C5CyuwNxvrbYuvjHgqsMQE5bj1/IF3uRlcHgnUnoSdrSq857
         /273uBUXQishTBhP0v3WtzTArKFDrT7GUuvrk8ISczfoEnARhWgLV/JWtXRayuLUzZ9p
         /kH/ssWeldETLXT6WpV9nS/r1H9Ija7Spgf6QZNJF2wkqO4hLxpuI7NMgAX27yXpJOHo
         6/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691212197; x=1691816997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KldLBiFwSL+U5xUltvcJvXEpQEYt+vbYhZvqxWXYyU=;
        b=ZcLbn2tCqnHKBC2YOUOnvhk2HukyO1uXihOlp/04DI2VUEAClLfgUKkkuNOUJ3sUpN
         KQH0xyRwUUMJyhBfUJ7ioGYKajvz5Hv2fI5YDrK1GS9U0S7C3AdH5YyT2R0gye4j0H8B
         m37YJUvE8gWpkXMrRaSFnJe2jNvSu0YpYSyZCFDJxmmDcCnldE92UAdWAAV0rzf02ZyD
         SUyqoBBCbHni1XtpwL58cBH7jb8yvYJdX822xM9XwqLzXvp+o2ir4vqoidybzeuAmK67
         ogKB+kJLeYMX37RT0hdjjBJHyNoSlwI9Zi5FXRYBWvgV9iHhXipmsOTPLfUxd9I+sEJr
         ByOQ==
X-Gm-Message-State: AOJu0YwscBy9Q1T3tdobR4z6WpkU2mp/RjOt4pAugV7b3iypiIN1wpkf
	fR3fGOXYAO8giHB0o3U0Rjid/dP9TNW71Oa1LMo/bCvPCkM=
X-Google-Smtp-Source: AGHT+IGCw4sul8vw4580XYl3TAj7SSZjvNqnALZCs7l9G3Kya94G/RaqS1BVS6Iz9IdpjHVlOBqSu5YUTs+U4tEja54=
X-Received: by 2002:a2e:740d:0:b0:2b6:bc30:7254 with SMTP id
 p13-20020a2e740d000000b002b6bc307254mr2510862ljc.13.1691212196867; Fri, 04
 Aug 2023 22:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
In-Reply-To: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Aug 2023 22:09:44 -0700
Message-ID: <CABBYNZJZbiyhnary2F7iZMKg5xSFKNV0iRVJ6ye7NayS-z-a0Q@mail.gmail.com>
Subject: Re: [BUG]Bluetooth: possible semantic bug when the status field of
 the HCI_Connection_Complete packet set to non-zero
To: Xinyu Liu <LXYbhu@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	baijiaju1990@gmail.com, sy2239101@buaa.edu.cn, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Aug 4, 2023 at 9:35=E2=80=AFPM Xinyu Liu <LXYbhu@buaa.edu.cn> wrote=
:
>
> Hello,
>
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in=
 Linux 6.2:
>
> During the connection process, the host server needs to receive the HCI_C=
onnection_Complete packet from the hardware controller. In normal cases, th=
e status field of this packet is zero, which means that the connection is s=
uccessfully completed:
>
> However, in our testing, when the status field was set to non-zero, 47 fo=
r instance, the Bluetooth connection failed. After that, when we attempt to=
 reestablish a Bluetooth connection, the connection always fails. Upon anal=
yzing the event packets sent from the controller to the host server, we obs=
erved that the Status field of the HCI_Command_Status packet becomes 0B, in=
dicating that the controller believes the connection already exists. This s=
ituation has been causing the connection failure persistently:

That seems like a link-layer issue, the controller is saying the
connection had failed, and 0x0b also doesn't help either except if you
are saying that the other parameters are actually valid (e.g. handle),
that said the spec seems pretty clear about status other than 0x00
means the connection had failed:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2170

0x01 to 0xFF Connection failed to Complete. See [Vol 1] Part F,
Controller Error Codes
for a list of error codes and descriptions.

>
> In our understanding, it would be more preferable if a single failed Blue=
tooth connection does not result in subsequent connections also failing. We=
 believe that having some mechanism to facilitate Bluetooth's recovery and =
restoration to normal functionality could be considered as a potentially be=
tter option.
>
> We are not sure whether this is a semantic bug or implementation feature =
in the Linux kernel. Any feedback would be appreciated, thanks!

Well we can't do much about the dangling connection if we don't know
its handle to be able to disconnect since there is no command to
disconnect by address if that is what you were expecting us to do, so
the bottom line seems to be that sending 0x0b to the controller is
useless since we can't do anything about at the host, well other than
reset but would likely affect other functionality as well.


--=20
Luiz Augusto von Dentz

