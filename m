Return-Path: <netdev+bounces-47569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C07EA786
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FCA280FF9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C771C05;
	Tue, 14 Nov 2023 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eRrNIWgV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6817EF
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:31:46 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5DD67
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:31:44 -0800 (PST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A4EC240C55
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699921902;
	bh=cwc6NfaIKFI0vWpuvPcxk4kM/LAeLbAV4iG8Wtk28vc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=eRrNIWgV6oi8d8hDNbwOU4K+QpwiyEajPTwzMf67wEJ9CZO6+hkvURjRsFNlfngFz
	 fIL5wlCzB9pFtTINv23edFVY4PrLbK3wtYnrEw0nuRaTkY1dVr2f0e1C7Zn1/cV1e/
	 MPdtqhov6Cv3AWR60cojvD+Nt7QAoiUzSNNPzG/xXzxTuy/T6FtcFRXWChHtO2M6kN
	 LxYfDW4p/e9/ETcY31xhnR9KrFqshHSeK35DtdlGEDzevvCtP3XYEVNlyR6gXiirvI
	 pFh8FNTGS+5qA6U0RU31mrwnLvifrzWhW/fp3ppZ8JtXrOhDL80EF7nxArSLCaCF+E
	 OrwkZaCbXwncQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so4279720a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699921901; x=1700526701;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwc6NfaIKFI0vWpuvPcxk4kM/LAeLbAV4iG8Wtk28vc=;
        b=I32BX3oAmnSYa8jC0nnoUvvobPzEWxIozX7iYBLfvPwnXCDyGtsSRYVtlHonebGrvg
         WVfgkyloBTzk1EkVNRNpXroWqDN3WpnmddtQOSVX/OU75grBnq/QLwNKt1S7HyhJSHf7
         UQTlIga80ZHD/OBTJsNxjerKOYuFzMSbVDQS9iscb1fOTZyB3XfGKST++8nzyF3hNkOU
         aiUNGUZyOo9p7RV+Mo+QfNpz7cv5Wk1jrx7aeWfAeyJAF56G7/ZxRS5CwaTrCyU5Zf6A
         FQqy34vEzO8hijSOpJXvyFBC6iYS2GAL+Il3cFK9InuYCjgg38TY6MiCkV+icJzPm6GS
         BMrw==
X-Gm-Message-State: AOJu0Yw+DpvkgXDSZFspA5eG4/Fg2KT4VJOpT6WEtkNFjaafsbMKmCpy
	DRKh23jg7JUSj8oAFDsGzPO1npfyL/jQ/iOMGdglfmDLC5e+QkNFtPFFrQpM8byctbsr1TVjGiM
	y7l5yn74OQxh8fiov9S9zkP/QEf+/jsNcvA==
X-Received: by 2002:a17:903:11c9:b0:1cc:29ed:96ae with SMTP id q9-20020a17090311c900b001cc29ed96aemr945022plh.41.1699921901041;
        Mon, 13 Nov 2023 16:31:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+6yvcYzcAXYZ+MmOoDrL6rQF1qKFVvwFJkSIu5P+hcu2MOry98qgolVeqprGlQviRbx7ZHg==
X-Received: by 2002:a17:903:11c9:b0:1cc:29ed:96ae with SMTP id q9-20020a17090311c900b001cc29ed96aemr944993plh.41.1699921900698;
        Mon, 13 Nov 2023 16:31:40 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id az2-20020a170902a58200b001c62c9d7289sm4576227plb.104.2023.11.13.16.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 16:31:40 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id DBB945FFF6; Mon, 13 Nov 2023 16:31:39 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id D45DC9F88E;
	Mon, 13 Nov 2023 16:31:39 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, andy@greyhouse.net,
    weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] bonding: use WARN_ON instead of BUG in alb_upper_dev_walk
In-reply-to: <20231113092754.3285306-1-shaozhengchao@huawei.com>
References: <20231113092754.3285306-1-shaozhengchao@huawei.com>
Comments: In-reply-to Zhengchao Shao <shaozhengchao@huawei.com>
   message dated "Mon, 13 Nov 2023 17:27:54 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9927.1699921899.1@famine>
Date: Mon, 13 Nov 2023 16:31:39 -0800
Message-ID: <9928.1699921899@famine>

Zhengchao Shao <shaozhengchao@huawei.com> wrote:

>If failed to allocate "tags" or could not find the final upper device from
>start_dev's upper list in bond_verify_device_path(), only the loopback
>detection of the current upper device should be affected, and the system is
>no need to be panic.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>---
> drivers/net/bonding/bond_alb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>index dc2c7b979656..5519cc95b966 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
> 	 */
> 	if (netif_is_macvlan(upper) && !strict_match) {
> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>-		if (IS_ERR_OR_NULL(tags))
>-			BUG();
>+		if (IS_ERR_OR_NULL(tags)) {
>+			WARN_ON(1);
>+			return 0;

	This seems reasonable enough, although I'd suggest the using
WARN_ON_ONCE instead of WARN_ON.  Alternatively, this could stay as
WARN_ON if the above also returns non-zero in order to terminate the
netdev_walk_all_upper_dev_rcu walk.  The intent here is to avoid
spamming the log if there's a lot of macvlans above the bond.  If the
allocation in bond_verify_device_path failed, trying again immediately
seems likely to fail as well.

	We could also arrange for whatever called alb_upper_dev_walk to
reschedule at a slightly later time, but I don't think that's worth the
trouble.  The bond will by default resend learning packets once per
second, so issues related to a lost learning packet should resolve
relatively quickly.

	-J

>+		}
> 		alb_send_lp_vid(slave, upper->dev_addr,
> 				tags[0].vlan_proto, tags[0].vlan_id);
> 		kfree(tags);
>-- 
>2.34.1

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

