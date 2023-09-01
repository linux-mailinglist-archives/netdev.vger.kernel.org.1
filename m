Return-Path: <netdev+bounces-31786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325127902D0
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 22:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04F5281801
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33ADF50;
	Fri,  1 Sep 2023 20:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB07C136
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 20:28:32 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483FAE7F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:28:31 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE92341D35
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1693600109;
	bh=trUGss+XmptPoPRENI5SIudMC9BUyQNCNA1erFL5kbU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=I3H7M9Toq3lcUG2NGoARVp13pIczDaaNfJ6wJGOlzj7mXEsOZWvZ5PxqN/3DWIvX/
	 6hKEM6E1K5kF3DoHTDh81/tquU21Ye/MoAiUZfF9lz9o0GJ7S3VUP3aB8mFEhpPslK
	 F86aacOvxGGd4it2IxUP8c129HiaepRiqRYlbXygIBrnWDB30RmZISR6E63DQWIh0w
	 J6PIzMzPmEW3TX5W21PXbXHIwGFXhbKKds7nwTIOiDoHEwGrDdc2A3RquGzNWv6xej
	 SpMSU1TdEX7LECTIgiE7QooQ5ym+VL5AeXVcuMO67MYXuxQhOObvWR3+1Dyl4Utehl
	 yzYdJCc9iOhcg==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56f8334c253so2549438a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 13:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693600108; x=1694204908;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trUGss+XmptPoPRENI5SIudMC9BUyQNCNA1erFL5kbU=;
        b=egwfugXHApdOobndWI1Hw/Hww0J21h0wHbjkXTYipJsKyD783MSMDHNBSWRRJd2NOy
         NomqlAV0FkHjYewoZ+iEW/Rn+4l4Lwm6bnVGEIHDaIi+tIZT+2cBaqvwPUjSzIZZ0Aw5
         Ip3pWCbVwLJp2tAVBeNSYtKB01MUgOXBXX5h4kEsDp7PtVXxnqoh+7WcDjDBa+gwntav
         Rl9LReOJrWAT0YeemhLIuLSHYJvJmB9/inOBF/ph6yDiEgxU/7sa+vt6Wt2R3FFmjRrf
         FFrblTM4iieSbHEEFCEuN6Qdl0IjDx3uWFCZhEaUP3mhIBzQAripc1jVwAgXFtXwKKqV
         tPEA==
X-Gm-Message-State: AOJu0YwLowk51c3q82OiaEwq5DeVjN1XvMCG5gdMNnr6sC2Vq8eRW+3k
	dyhDFCfJo9jPsYOmuDmW1K7aXqOX6Ot21iHTMkwYhm8+FOoh5dghauaBkVY1vTxiRLXdoHxh0Gk
	JGVjRrkMxjYyUoPYVNeO5Rn6/2Z+eZ0hUWg==
X-Received: by 2002:a05:6a21:32a6:b0:14c:d0c0:dd25 with SMTP id yt38-20020a056a2132a600b0014cd0c0dd25mr4361251pzb.57.1693600108328;
        Fri, 01 Sep 2023 13:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHozaMKnYY9iMOdnGx+yJXXWEiezm1GOJMoq+UF9cuFtZRIQH6P1VO6vdBDiyl8xjyC2xNfyw==
X-Received: by 2002:a05:6a21:32a6:b0:14c:d0c0:dd25 with SMTP id yt38-20020a056a2132a600b0014cd0c0dd25mr4361243pzb.57.1693600108093;
        Fri, 01 Sep 2023 13:28:28 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id s21-20020a62e715000000b0068a29521df2sm3460972pfh.177.2023.09.01.13.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Sep 2023 13:28:27 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 34ED060648; Fri,  1 Sep 2023 13:28:27 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2D6BE9F83B;
	Fri,  1 Sep 2023 13:28:27 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: patchwork-bot+netdevbpf@kernel.org
cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
    kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
    ecree.xilinx@gmail.com, netdev@vger.kernel.org,
    habetsm.xilinx@gmail.com
Subject: Re: [PATCH net] sfc: check for zero length in EF10 RX prefix
In-reply-to: <169355282650.26042.12939448647833622026.git-patchwork-notify@kernel.org>
References: <20230831165811.18061-1-edward.cree@amd.com> <169355282650.26042.12939448647833622026.git-patchwork-notify@kernel.org>
Comments: In-reply-to patchwork-bot+netdevbpf@kernel.org
   message dated "Fri, 01 Sep 2023 07:20:26 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11385.1693600107.1@famine>
Date: Fri, 01 Sep 2023 13:28:27 -0700
Message-ID: <11386.1693600107@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

patchwork-bot+netdevbpf@kernel.org wrote:

>Hello:
>
>This patch was applied to netdev/net.git (main)
>by David S. Miller <davem@davemloft.net>:
>
>On Thu, 31 Aug 2023 17:58:11 +0100 you wrote:
>> From: Edward Cree <ecree.xilinx@gmail.com>
>> 
>> When EF10 RXDP firmware is operating in cut-through mode, packet length
>>  is not known at the time the RX prefix is generated, so it is left as
>>  zero and RX event merging is inhibited to ensure that the length is
>>  available in the RX event.  However, it has been found that in certain
>>  circumstances the RX events for these packets still get merged,
>>  meaning the driver cannot read the length from the RX event, and tries
>>  to use the length from the prefix.
>> The resulting zero-length SKBs cause crashes in GRO since commit
>>  1d11fa696733 ("net-gro: remove GRO_DROP"), so add a check to the driver
>>  to detect these zero-length RX events and discard the packet.
>> 
>> [...]

	Should this have included

Fixes: 1d11fa696733 ("net-gro: remove GRO_DROP")

	to queue the patch for -stable?  We have users running into this
issue on 5.15 series kernels.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

