Return-Path: <netdev+bounces-13190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72E73A8FF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43471C21031
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2821071;
	Thu, 22 Jun 2023 19:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24820690
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:31:48 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840DA1713
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:31:46 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1AD142458
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687462301;
	bh=myW0bOwzrP+zdsiC16uuM6w7aJuKjyogFwiBpraHSys=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=WvABjilZdHBYqzLzxPDlxVTy2CdiLLdP23+qqhiDitE2DoFbmKyWNZISEIV82y3Yo
	 ehFFv9v/6iKdmqkSfo7d/rqKYAe7Ds/mVMQ5QrV7M4BLUyGBkJuTk88ermIVmDwaXl
	 9ayQxIjJ3EXXb0BAD0KbrHmDJfd4IhdhYQAKp3fUly/GXa4MPb6r3CsmImnEGfh5/h
	 KtI3TzRsJsYcFWBI0teehLQpncdwUcULGzh+42FlJOrNchu9r8JEd3vGVtiLemNamy
	 E3SopTN3iuBtyp4Vie+FD8yYB9UkH+at6R2odADI/DTLfrAIh6BaWmT9VOMZLcG808
	 MwFDKBiW75OaQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b511b1b660so37361155ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687462300; x=1690054300;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myW0bOwzrP+zdsiC16uuM6w7aJuKjyogFwiBpraHSys=;
        b=QyiLA3PLj9OT9v+js7sBINKpDrKO4OeLEjGj/2utXAYKVZ+SwzauHGBi3o2ATnIqYd
         1YVCEuOvpYStNeOafW8zjI1lJNSVCJUCKNq1IjvaUbo63cu0bL4/2ArrBJy2tJmgw4rV
         bPXHw/UR+/E1HTj/pdyBFWQctv5tgmoiJoSZHyebHf1tXuRyyzscOlEFZcc0BjpGVFQw
         i+fbNvHHaOuaWuGrPjgU779MMkx+YkYyQLgRGDQoKhkPHQIof+5/nFWIonOuc2oxNvky
         ffIX2j7tTqmCBoT/1nhlpNRGNKah0qU28/pCdvlZYQF7xjtRHiZ5373k29dhWjmPS/Um
         Q6DA==
X-Gm-Message-State: AC+VfDxVy1cIfKe+hjKNFCMYHiPv92/uDOU07SnzWVTkr40HL0TEM6po
	mHaDnih4MlRO9qAMWoYem46wsjn1bId5EwL98GH5iaE49ukrI5RPCh1+aCxvu28TcN+WAyaPwPn
	5jn00CU9i7D6RP/bIgEvsHNsrPHOOWltDqw==
X-Received: by 2002:a17:903:1109:b0:1b0:3637:384e with SMTP id n9-20020a170903110900b001b03637384emr15875814plh.25.1687462300169;
        Thu, 22 Jun 2023 12:31:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QAr+uEK2OdOmrgeENE4OTP/yD6xv3SRTujObawz3NhKI7tqXyUECy5ph/8UAR5KxGKZTD+w==
X-Received: by 2002:a17:903:1109:b0:1b0:3637:384e with SMTP id n9-20020a170903110900b001b03637384emr15875796plh.25.1687462299917;
        Thu, 22 Jun 2023 12:31:39 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001b3ab80381csm5755054plb.301.2023.06.22.12.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2023 12:31:39 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2BED75FEAC; Thu, 22 Jun 2023 12:31:39 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 24B519FAF8;
	Thu, 22 Jun 2023 12:31:39 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org, eric.dumazet@gmail.com,
    syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>,
    Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
In-reply-to: <CANn89iL3kLondF3ETBui8ik3sJW+1NR8SZFYWqw7FY4H5gcUjw@mail.gmail.com>
References: <20230622152304.2137482-1-edumazet@google.com> <22643.1687456107@famine> <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com> <26275.1687460144@famine> <CANn89i+Vcwp9o59Fzy+epqS+YSxjrStNjBRX-5GSie_TdiMbVg@mail.gmail.com> <CANn89iL3kLondF3ETBui8ik3sJW+1NR8SZFYWqw7FY4H5gcUjw@mail.gmail.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Thu, 22 Jun 2023 21:01:52 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 12:31:39 -0700
Message-ID: <27955.1687462299@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> wrote:

>On Thu, Jun 22, 2023 at 9:00=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>>
>
>> Ah right, I will send another patch to remove it then.
>>
>> I think it makes sense to keep the first patch small for backports.
>>
>> History of relevant patches :
>>
>> from 5.17
>>
>> 429e3d123d9a50cc9882402e40e0ac912d88cfcf bonding: Fix extraction of
>> ports from the packet headers
>>
>> from 5.15
>>
>> a815bde56b15ce626caaacc952ab12501671e45d net, bonding: Refactor
>> bond_xmit_hash for use with xdp_buff
>
>If this is ok for you, I will cook this cleanup patch for net-next.

	Yes, this sounds fine to me.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

