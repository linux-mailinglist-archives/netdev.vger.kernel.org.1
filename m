Return-Path: <netdev+bounces-48195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DAA7ED20C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24EE1F283FE
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900D28378;
	Wed, 15 Nov 2023 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n0S+SX+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E723BC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:34:15 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7AD903FDF2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1700080452;
	bh=hHBMFekNwsw5XqDya2KwUGgEm4y8j0uncBjQBgZvFf0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=n0S+SX+cw8TZqwxG0hw+L0PdhI5+0IGy+0sa+DlkqtYu3rcp6c41UkjrSwJebZQSo
	 epv67/QsV9xdfBeo69XFiIw+KlAc3p4S5wt0DsyCwCPTZl5eKZwZoPoPEYqKoGy9gk
	 04Gnyos41a0SomwIuaNTxE0+JilGYbDWX4yooDdwRpaLDpgUIzbSlgxNFnndqBkDTo
	 lYp3C6zyV/8zdA1EI2bWB9Ve7+YLELxP1kTYDTtu0r0sl2hxP8e1eVqN4j3feHEUNO
	 ZIkLdxJaD2vieH5TA9+1Lqh4nIMfphtZ04nJLO7vjd4VVrrlErc/1QkmG24GLMNsA/
	 TvkjzZ3KafxOw==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c19a3369c2so81294a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700080451; x=1700685251;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHBMFekNwsw5XqDya2KwUGgEm4y8j0uncBjQBgZvFf0=;
        b=wxURsgmFx+DJm1GudDYaokCgvecAvc1TUjAzVzUJZb3aX414XEiPFRHjBQIpIFup4N
         Oc1SJ+YJ0OTT1m61rDbKLxFx4e0Q18nIFu4KSwOaIxcoA7TtV6J9W7iErZ/Ry5Z89QJV
         fAa09eGMCN4iA34q9i9tKYX4OH8NCglEiCxsosxBKnfZIKBmrJK2aW6cZXirvVRCmF9a
         6yZwW+Yd6HSZ6AgytYPC9agRLcurMO5yOmAb32dbnAOoubB0olpzNsrQR8sA6CQuVV6+
         +9lsSFDbEN/AgwpTD2RlSuO4KIu6dzWkXlclAUtQIXaZjHS4wC4Gv3kYqK+5rbugREUn
         NE0w==
X-Gm-Message-State: AOJu0Yzr4a77FD9AkGto1PN2ihiZENEGbnPwqN40vIEnsSs2qbomew7U
	qP3fnqwB7Dlz/owThEMyQXUJPERVXm1KGGn+W4ZFNzWcLMm2P+3jYNX9TXdHQMnm7JLZ4VA7gfH
	WS+FAC5mSGCxtsIyv7f2X/LuXMQnfkAmHTVTj/m+7l+JN
X-Received: by 2002:a05:6a21:191:b0:187:83c1:ee38 with SMTP id le17-20020a056a21019100b0018783c1ee38mr2424065pzb.28.1700080450895;
        Wed, 15 Nov 2023 12:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET8br023BnWV6F5mDVVeZ4iADpYQnGVH+5SRFRxXmEoZ3ejtHtfAIOujCaFmXqPOdwn5hdkQ==
X-Received: by 2002:a05:6a21:191:b0:187:83c1:ee38 with SMTP id le17-20020a056a21019100b0018783c1ee38mr2424031pzb.28.1700080450450;
        Wed, 15 Nov 2023 12:34:10 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id j8-20020a633c08000000b005b18c53d73csm1529273pga.16.2023.11.15.12.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2023 12:34:10 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A0F6C5FFF6; Wed, 15 Nov 2023 12:34:09 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 98EFD9F88E;
	Wed, 15 Nov 2023 12:34:09 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Simon Horman <horms@kernel.org>
cc: Jiri Pirko <jiri@resnulli.us>,
    Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, andy@greyhouse.net, weiyongjun1@huawei.com,
    yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3] bonding: use WARN_ON instead of BUG in alb_upper_dev_walk
In-reply-to: <20231115174955.GV74656@kernel.org>
References: <20231115115537.420374-1-shaozhengchao@huawei.com> <ZVTUL4QByIyGyfDP@nanopsycho> <20231115174955.GV74656@kernel.org>
Comments: In-reply-to Simon Horman <horms@kernel.org>
   message dated "Wed, 15 Nov 2023 17:49:55 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18322.1700080449.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Nov 2023 12:34:09 -0800
Message-ID: <18323.1700080449@famine>

Simon Horman <horms@kernel.org> wrote:

>On Wed, Nov 15, 2023 at 03:22:39PM +0100, Jiri Pirko wrote:
>> Wed, Nov 15, 2023 at 12:55:37PM CET, shaozhengchao@huawei.com wrote:
>> >If failed to allocate "tags" or could not find the final upper device =
from
>> >start_dev's upper list in bond_verify_device_path(), only the loopback
>> >detection of the current upper device should be affected, and the syst=
em is
>> >no need to be panic.
>> >
>> >Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> >---
>> >v3: return -ENOMEM instead of zero to stop walk
>> >v2: use WARN_ON_ONCE instead of WARN_ON
>> =

>> Yet the WARN_ON is back :O
>
>Hi Jiri,
>
>I think the suggestion was to either:
>
>1. WARN_ON_ONCE(); return 0;      <=3D this was v2
>2. WARN_ON(); return -ESOMETHING; <=3D this is v3
>(But not, WARN_ON(); return 0;    <=3D this was v1)
>
>And after v2 it was determined that the approach taken here in v3 is
>preferred.
>
>So I think this patch is consistent with the feedback given by Jay
>in his reviews so far.

	Sigh, the more I look the more complicated this gets.
	=

	Anyway, I was previously thinking we're ok with WARN_ON if the
return is non-zero to terminate the device walk.  The bond itself will
automatically call alb_upper_dev_walk at most once per second.

	However, user space could do something like continuously change
the MAC address of the bond or initiate a failover in order to trigger a
call to alb_upper_dev_walk.  This won't be rate limited, and if the
allocations there repeatedly fail, it would always trigger the WARN_ON.

	So, I'm thinking now that instead of WARN_anything, we should
instead use something like

net_err_ratelimited("%s: %s: allocation failure\n", start_dev->name, __fun=
c__);

	in bond_verify_device_path, and alb_upper_dev_walk doesn't do
any WARN at all, and returns failure (non-zero).
	=

	This is consistent with other similar allocation failures.

	-J

>> >---
>> > drivers/net/bonding/bond_alb.c | 6 ++++--
>> > 1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond=
_alb.c
>> >index dc2c7b979656..21f1cb8e453b 100644
>> >--- a/drivers/net/bonding/bond_alb.c
>> >+++ b/drivers/net/bonding/bond_alb.c
>> >@@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *=
upper,
>> > 	 */
>> > 	if (netif_is_macvlan(upper) && !strict_match) {
>> > 		tags =3D bond_verify_device_path(bond->dev, upper, 0);
>> >-		if (IS_ERR_OR_NULL(tags))
>> >-			BUG();
>> >+		if (IS_ERR_OR_NULL(tags)) {
>> >+			WARN_ON(1);
>> >+			return -ENOMEM;
>> >+		}
>> > 		alb_send_lp_vid(slave, upper->dev_addr,
>> > 				tags[0].vlan_proto, tags[0].vlan_id);
>> > 		kfree(tags);
>> >-- =

>> >2.34.1
>> >
>> >
>> =

>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

